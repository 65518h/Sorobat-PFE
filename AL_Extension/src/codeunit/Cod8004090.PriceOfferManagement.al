Codeunit 8004090 "Price Offer Management"
{
    // //+OFF+OFFRE GESWAY 17/10/02 Gestion des offres de prix fournisseurs
    //                     31/01/03 Sélection des fournisseurs depuis tables "Purchase price" et "Purchase Line Discount"
    //                     27/05/03 Ajout comptes généraux dans les filtres -> CompleteLines
    //                     04/06/03 Ajout Validate("Purchaser Code") -> CreateNewHeader
    //                     18/08/03 Utilise champ "Unit Cost (LCY)" à la place de "Direct Unit Cost (LCY)"
    //                     27/08/03 Ajout VALIDATE sur "Selected Doc. No." et "Selected Doc. Line No." ->SuggestVendor
    //                     02/05/06 Ecriture d'une fonction générique utilisée lors de la sélection d'une offre
    //              MB     10/05/06 Ajout des ligne de type " " dont les "Attached to line No." = 0 dans les offres fournisseur
    //                              Copie des commentaires lors de la création des offres
    // //CDE_INTERNE GESWAY 28/03/02 Remarque sur Validate("No.") -> CreateNewLine
    // //CONSULT GESWAY 12/11/04 Init "Sales Order No.", "Sales Order Line no." -> CreateNewLine


    trigger OnRun()
    begin
    end;

    var
        PriceOfferSetup: Record "Price Offer Setup";
        CurrPurchHeader: Record "Purchase Header";
        PurchLine2: Record "Purchase Line";
        CurrPurchLine: Record "Purchase Line";
        InitPurchLine: Record "Purchase Line";
        Vendor: Record Vendor;
        Vendor2: Record Vendor temporary;
        PurchPrice: Record "Purchase Price";
        PurchLineDisc: Record "Purchase Line Discount";
        Item: Record Item;
        ItemVend: Record "Item Vendor";
        ItemCategory: Record "Item Category";
        //GL2024   ProductGroup: Record "Product Group";
        VendItemCategory: Record "Vendor Item Category Group";
        VendItemCategory2: Record "Vendor Item Category Group";
        DocPrint: Codeunit "Document-Print";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        Window: Dialog;
        NbreHeader: Integer;
        NbreLine: Integer;
        InitialDocNo: Text[20];
        FoundIt: Boolean;
        Text001: label 'There is nothing to post.';
        Text002: label 'Offer No.               #1#############\';
        Text003: label 'Item N°                 #2#############';
        Text004: label 'Related offers will be replaced.\';
        Text005: label 'Do you wish to continue?';
        Text006: label 'No offer was generated.';
        Text007: label '%1 line(s) has been added.';
        Text008: label 'You can not change %1 because there are existing lines.';
        HideValidationDialog: Boolean;
        Text009: label 'Do you wish to create vendor price offers from quote no %1?';
        Text010: label 'Do you wish to complete lines for offer price no. %1?';
        Text011: label 'Do you wish that the program allot vendor automatically on the lines?';
        Text012: label 'There is related offers to quote n° %1.\The existing lines will not be updated.\\Do you confirm to suggest offers ?';
        Text013: label '%1 line has been added.';
        wVendortmp: Record Vendor temporary;
        PurchHeader: Record "Purchase Header";
        UseDate: Date;
        CurrExchRate: Record "Currency Exchange Rate";


    procedure SuggestOffer(pPurchHeader: Record "Purchase Header"; IsFormLoad: Boolean)
    var
    //GL2024 NAVIBAT     RelatedOfferList: Page 8004092;
    begin
        PriceOfferSetup.Get;
        NbreHeader := 0;
        NbreLine := 0;

        with InitPurchLine do begin
            SetRange("Document Type", pPurchHeader."Document Type");
            SetRange("Document No.", pPurchHeader."No.");
            SetFilter(Type, '=%1|=%2', Type::Item, Type::" ");
            if not Find('-') then
                Error(Text001);
        end;

        if not Confirm(StrSubstNo(Text009, pPurchHeader."No."), false) then
            exit;
        if SuggestVendorOffer then begin
            if not HideValidationDialog then
                Window.Open(Text002 + Text003);
            if OffersExists(pPurchHeader) and not HideValidationDialog then
                if not Confirm(StrSubstNo(Text012, pPurchHeader."No."), false) then
                    exit;
            SuggestOfferLine(pPurchHeader);
            SuggestCompletedLine(pPurchHeader);
            if not HideValidationDialog then begin
                Window.Close;
                if NbreHeader = 0 then
                    Message(Text006, NbreHeader)
                else begin
                    if not IsFormLoad then begin
                        //GL2024 NAVIBAT    Clear(RelatedOfferList);
                        CurrPurchHeader.Reset;
                        CurrPurchHeader.SetCurrentkey("Attached to Doc. Type", "Attached to Doc. No.");
                        CurrPurchHeader.SetRange("Attached to Doc. Type", pPurchHeader."Document Type");
                        CurrPurchHeader.SetRange("Attached to Doc. No.", pPurchHeader."No.");
                        //GL2024 NAVIBAT   RelatedOfferList.SetTableview(CurrPurchHeader);
                        //GL2024 NAVIBAT    RelatedOfferList.Run;
                    end;
                end;
            end;
        end;
    end;


    procedure SuggestOfferLine(pPurchHeader: Record "Purchase Header")
    begin
        repeat
            if not HideValidationDialog then
                Window.Update(2, InitPurchLine."No.");

            case InitPurchLine.Type of
                InitPurchLine.Type::Item:
                    begin
                        Item.Get(InitPurchLine."No.");
                        //Catégorie et groupe produit
                        if Item."Item Category Code" <> '' then begin
                            VendItemCategory.Reset;
                            VendItemCategory.SetRange("Item Category Code", Item."Item Category Code");
                            //GL2024    VendItemCategory.SetFilter("Product Group Code", '%1|%2', '', Item."Product Group Code");
                            if VendItemCategory.Find('-') then
                                repeat
                                    VendItemCategory2.Reset;
                                    VendItemCategory2.SetRange("Vendor No.", VendItemCategory."Vendor No.");
                                    VendItemCategory2.SetRange("Item Category Code", VendItemCategory."Item Category Code");
                                    VendItemCategory2.SetRange("Product Group Code", VendItemCategory."Product Group Code");
                                    VendItemCategory2.SetRange("Exclude From Price Offer", true);
                                    if VendItemCategory2.IsEmpty and
                                       wVendortmp.Get(VendItemCategory."Vendor No.") then begin
                                        GetHeader(pPurchHeader, VendItemCategory."Vendor No.");
                                        if not CurrPurchLine.Get(
                                             CurrPurchHeader."Document Type",
                                             CurrPurchHeader."No.", InitPurchLine."Line No.") and
                                           Vendor2.Get(VendItemCategory."Vendor No.")
                                        then
                                            CreateNewLine(InitPurchLine, CurrPurchHeader);
                                    end;
                                until VendItemCategory.Next = 0;
                        end;

                        //Prix achat
                        if PriceOfferSetup."Additional Vendor Selection" in
                           [PriceOfferSetup."additional vendor selection"::Both,
                            PriceOfferSetup."additional vendor selection"::"Purchase Price"]
                        then begin
                            PurchPrice.Reset;
                            PurchPrice.SetRange("Item No.", InitPurchLine."No.");
                            if PurchPrice.Find('-') then begin
                                repeat
                                    if wVendortmp.Get(PurchPrice."Vendor No.") then begin
                                        GetHeader(pPurchHeader, PurchPrice."Vendor No.");
                                        if not CurrPurchLine.Get(
                                           CurrPurchHeader."Document Type",
                                           CurrPurchHeader."No.", InitPurchLine."Line No.") and
                                           Vendor2.Get(PurchPrice."Vendor No.")
                                        then
                                            CreateNewLine(InitPurchLine, CurrPurchHeader);
                                    end;
                                until PurchPrice.Next = 0;
                            end;
                        end;

                        //Remise ligne achat
                        if PriceOfferSetup."Additional Vendor Selection" in
                            [PriceOfferSetup."additional vendor selection"::Both,
                            PriceOfferSetup."additional vendor selection"::"Purchase Line Discount"]
                        then begin
                            PurchLineDisc.Reset;
                            //GL2024   PurchLineDisc.SetRange(Code, InitPurchLine."No.");
                            PurchLineDisc.SetRange("Item No.", InitPurchLine."No.");
                            PurchLineDisc.SetRange(Type, PurchLineDisc.Type::Item);
                            PurchLineDisc.SetRange("Purchase Type", PurchLineDisc."purchase type"::Vendor);
                            if PurchLineDisc.Find('-') then begin
                                repeat
                                    //GL2024  if wVendortmp.Get(PurchLineDisc."Purchase Code") then begin
                                    if wVendortmp.Get(PurchLineDisc."Vendor No.") then begin
                                        //GL2024   GetHeader(pPurchHeader, PurchLineDisc."Purchase Code");
                                        GetHeader(pPurchHeader, PurchLineDisc."Vendor No.");
                                        if not CurrPurchLine.Get(
                                           CurrPurchHeader."Document Type",
                                           CurrPurchHeader."No.", InitPurchLine."Line No.") and
                                            //GL2024  Vendor2.Get(PurchLineDisc."Purchase Code")
                                            Vendor2.Get(PurchLineDisc."Vendor No.")
                                        then
                                            CreateNewLine(InitPurchLine, CurrPurchHeader);
                                    end;
                                until PurchLineDisc.Next = 0;
                            end;
                        end;
                    end;

            end;
        until InitPurchLine.Next = 0;

        //Ajout des lignes de type " "
        InitPurchLine.Find('-');
        repeat
            if not HideValidationDialog then
                Window.Update(2, InitPurchLine."No.");
            if (InitPurchLine.Type = InitPurchLine.Type::" ") then begin
                CurrPurchHeader.Reset;
                CurrPurchHeader.SetCurrentkey("Attached to Doc. Type", "Attached to Doc. No.");
                CurrPurchHeader.SetRange("Attached to Doc. Type", pPurchHeader."Document Type");
                CurrPurchHeader.SetRange("Attached to Doc. No.", pPurchHeader."No.");
                if CurrPurchHeader.Find('-') then
                    repeat
                        if (InitPurchLine."Attached to Line No." <> 0) then begin
                            if CurrPurchLine.Get(
                               CurrPurchHeader."Document Type",
                               CurrPurchHeader."No.", InitPurchLine."Attached to Line No.") then
                                if not CurrPurchLine.Get(
                                   CurrPurchHeader."Document Type",
                                   CurrPurchHeader."No.", InitPurchLine."Line No.")
                                then
                                    CreateNewLine(InitPurchLine, CurrPurchHeader);
                        end else
                            if not CurrPurchLine.Get(
                      CurrPurchHeader."Document Type",
                      CurrPurchHeader."No.", InitPurchLine."Line No.")
                   then
                                CreateNewLine(InitPurchLine, CurrPurchHeader);
                    until CurrPurchHeader.Next = 0;
            end;
        until InitPurchLine.Next = 0;
    end;


    procedure SuggestVendorOffer(): Boolean
    var
        lActionResult: Boolean;
        lListVendor: Page "Vendor List";
        lVendor: Record Vendor;
    begin
        wVendortmp.Init;
        wVendortmp.DeleteAll;

        repeat
            case InitPurchLine.Type of
                InitPurchLine.Type::Item:
                    begin
                        Item.Get(InitPurchLine."No.");
                        //Catégorie et groupe produit
                        if Item."Item Category Code" <> '' then begin
                            VendItemCategory.Reset;
                            VendItemCategory.SetRange("Item Category Code", Item."Item Category Code");
                            //GL2024    VendItemCategory.SetFilter("Product Group Code", '%1|%2', '', Item."Product Group Code");
                            if VendItemCategory.Find('-') then
                                repeat
                                    VendItemCategory2.Reset;
                                    VendItemCategory2.SetRange("Vendor No.", VendItemCategory."Vendor No.");
                                    VendItemCategory2.SetRange("Item Category Code", VendItemCategory."Item Category Code");
                                    VendItemCategory2.SetRange("Product Group Code", VendItemCategory."Product Group Code");
                                    VendItemCategory2.SetRange("Exclude From Price Offer", true);
                                    if VendItemCategory2.IsEmpty then
                                        if lVendor.Get(VendItemCategory."Vendor No.") then
                                            lVendor.Mark(true);
                                until VendItemCategory.Next = 0;
                        end;

                        //Prix achat
                        if PriceOfferSetup."Additional Vendor Selection" in
                           [PriceOfferSetup."additional vendor selection"::Both,
                            PriceOfferSetup."additional vendor selection"::"Purchase Price"] then begin
                            PurchPrice.Reset;
                            PurchPrice.SetRange("Item No.", InitPurchLine."No.");
                            if PurchPrice.Find('-') then
                                repeat
                                    if lVendor.Get(PurchPrice."Vendor No.") then
                                        lVendor.Mark(true);
                                until PurchPrice.Next = 0;
                        end;

                        //Remise ligne achat
                        if PriceOfferSetup."Additional Vendor Selection" in
                            [PriceOfferSetup."additional vendor selection"::Both,
                            PriceOfferSetup."additional vendor selection"::"Purchase Line Discount"] then begin
                            PurchLineDisc.Reset;
                            //GL2024   PurchLineDisc.SetRange(Code, InitPurchLine."No.");
                            //GL2024
                            PurchLineDisc.SetRange("Item No.", InitPurchLine."No.");
                            //GL2024
                            PurchLineDisc.SetRange(Type, PurchLineDisc.Type::Item);
                            PurchLineDisc.SetRange("Purchase Type", PurchLineDisc."purchase type"::Vendor);
                            if PurchLineDisc.Find('-') then
                                repeat
                                    //GL2024    if lVendor.Get(PurchLineDisc."Purchase Code") then
                                    if lVendor.Get(PurchLineDisc."Vendor No.") then
                                        lVendor.Mark(true);
                                until PurchLineDisc.Next = 0;
                        end;
                    end;
            end;
        until InitPurchLine.Next = 0;
        InitPurchLine.Find('-');

        lVendor.MarkedOnly(true);


        lListVendor.LookupMode := true;
        //#4737
        lListVendor.SetTableview(lVendor);
        lActionResult := (lListVendor.RunModal = Action::LookupOK);
        lListVendor.wGetRecInstance(lVendor);

        if lActionResult then begin
            //  lVendor.MARKEDONLY(TRUE);
            if not lVendor.IsEmpty then begin
                wVendortmp.DeleteAll;
                lVendor.Find('-');
                repeat
                    wVendortmp := lVendor;
                    wVendortmp.Insert;
                until lVendor.Next = 0;
            end;
        end;
        //#4737//
        exit(lActionResult);
    end;


    procedure SuggestCompletedLine(pPurchHeader: Record "Purchase Header")
    var
        NewDocNo: Code[20];
        lPurchHeader: Record "Purchase Header";
    begin
        SetHideValidationDialog(true);
        lPurchHeader.SetRange("Document Type", pPurchHeader."Document Type");
        lPurchHeader.SetFilter("No.", '%1', pPurchHeader."No." + '-*');
        if wVendortmp.Find('-') then
            repeat
                lPurchHeader.SetRange("Buy-from Vendor No.", wVendortmp."No.");
                if lPurchHeader.IsEmpty then begin
                    NewDocNo := CreateNewHeader(pPurchHeader, wVendortmp."No.");
                    lPurchHeader.Get(pPurchHeader."Document Type", NewDocNo);
                    CompleteLines(lPurchHeader, true);
                end;
            until wVendortmp.Next = 0;
        SetHideValidationDialog(false);
    end;


    procedure SuggestVendor(FromDocNo: Code[20]; FromDocType: Option)
    var
        UnitPrice: Decimal;
        SelectDocNo: Code[20];
        TempPurchLine: Record "Purchase Line";
        lDirectUnitCost: Decimal;
    begin
        if not HideValidationDialog then begin
            if not Confirm(Text011, false) then
                exit;
            Window.Open(Text002 + Text003);
        end;
        PurchLine2.Reset;
        PurchLine2.SetRange("Document Type", FromDocType);
        PurchLine2.SetRange("Document No.", FromDocNo);
        PurchLine2.SetFilter(Type, '=%1|=%2', PurchLine2.Type::Item, PurchLine2.Type::"G/L Account");

        if PurchLine2.Find('-') then
            repeat
                if not HideValidationDialog then begin
                    Window.Update(1, PurchLine2."Document No.");
                    Window.Update(2, PurchLine2."No.");
                end;

                if not PurchLine2."Ordered Line" then begin
                    CurrPurchLine.SetCurrentkey("Attached to Doc. Type", "Attached to Doc. No.");
                    CurrPurchLine.SetRange("Attached to Doc. Type", PurchLine2."Document Type");
                    CurrPurchLine.SetRange("Attached to Doc. No.", PurchLine2."Document No.");
                    CurrPurchLine.SetRange("No.", PurchLine2."No.");
                    CurrPurchLine.SetRange("Line No.", PurchLine2."Line No.");
                    if CurrPurchLine.Find('-') then begin
                        UnitPrice := 0;
                        SelectDocNo := '';
                        TempPurchLine.Init;
                        repeat
                            lDirectUnitCost := wConvertDirectUnitCost(CurrPurchLine);
                            if (lDirectUnitCost > 0) and not CurrPurchLine."Ordered Line" then
                                if (lDirectUnitCost < UnitPrice) or (UnitPrice = 0) then begin
                                    UnitPrice := lDirectUnitCost;
                                    SelectDocNo := CurrPurchLine."Document No.";
                                    TempPurchLine := CurrPurchLine;
                                end;
                        until CurrPurchLine.Next = 0;
                        //mise à jour des lignes du devis
                        if SelectDocNo <> '' then begin
                            PurchLine2.Validate("Selected Doc. No.", TempPurchLine."Document No.");
                            PurchLine2."Direct Unit Cost" := wConvertDirectUnitCost(TempPurchLine);
                            PurchLine2.Validate("Selected Doc. Line No.", TempPurchLine."Line No.");
                            PurchLine2."Unit Cost (LCY)" := TempPurchLine."Unit Cost (LCY)";
                            PurchLine2.Validate("Discount 1 %", TempPurchLine."Discount 1 %");
                            PurchLine2.Validate("Discount 2 %", TempPurchLine."Discount 2 %");
                            PurchLine2.Validate("Discount 3 %", TempPurchLine."Discount 3 %");
                        end else begin
                            PurchLine2.Validate("Selected Doc. No.", '');
                            PurchLine2.Validate("Selected Doc. Line No.", 0);
                            PurchLine2."Direct Unit Cost" := 0;
                            PurchLine2."Unit Cost (LCY)" := 0;
                            PurchLine2.Validate("Discount 1 %", 0);
                            PurchLine2.Validate("Discount 2 %", 0);
                            PurchLine2.Validate("Discount 3 %", 0);
                        end;
                        PurchLine2.Modify;

                    end;
                end;
            until PurchLine2.Next = 0;

        if not HideValidationDialog then
            Window.Close;
    end;


    procedure GetNewDocNo(FromDocNo: Code[20]; FromDocType: Option): Code[20]
    var
        pPurchHeader: Record "Purchase Header";
        AddToKey: Text[20];
        NewDocNo: Text[20];
        i: Integer;
    begin
        pPurchHeader.Reset;
        pPurchHeader.SetRange("Document Type", FromDocType);
        pPurchHeader.SetFilter("No.", '%1..%2', StrSubstNo('%1-01', FromDocNo), StrSubstNo('%1-99', FromDocNo));

        if pPurchHeader.Find('+') then begin
            AddToKey := CopyStr(pPurchHeader."No.", StrLen(pPurchHeader."No.") - 1, 2);
            Evaluate(i, AddToKey);
            AddToKey := CopyStr(Format(101 + i), 2, 2);
        end else
            AddToKey := '01';

        NewDocNo := CopyStr(FromDocNo + '-' + AddToKey, 1, 20);
        exit(NewDocNo);
    end;


    procedure GetHeader(pPurchHeader: Record "Purchase Header"; pVendorNo: Code[20])
    var
        lPurchHeader: Record "Purchase Header";
    begin
        repeat
            lPurchHeader.SetCurrentkey("Attached to Doc. Type", "Attached to Doc. No.");
            lPurchHeader.SetRange("Attached to Doc. Type", pPurchHeader."Document Type");
            lPurchHeader.SetRange("Attached to Doc. No.", pPurchHeader."No.");
            lPurchHeader.SetRange("Buy-from Vendor No.", pVendorNo);

            if not lPurchHeader.Find('-') then begin
                CreateNewHeader(pPurchHeader, pVendorNo);
                Vendor2.Init;
                Vendor2."No." := pVendorNo;
                if Vendor2.Insert then;
            end;
        until lPurchHeader.Find('-');
        CurrPurchHeader := lPurchHeader;
    end;


    procedure CreateNewHeader(pPurchHeader: Record "Purchase Header"; VendorNo: Code[20]): Code[20]
    begin
        pPurchHeader.TestField("No.");
        NbreHeader += 1;
        NbreLine := 0;

        CurrPurchHeader.SetHideValidationDialog(true);
        with CurrPurchHeader do begin
            Init;
            TransferFields(pPurchHeader);
            "No." := GetNewDocNo(pPurchHeader."No.", pPurchHeader."Document Type");
            "Attached to Doc. No." := pPurchHeader."No.";
            "Attached to Doc. Type" := pPurchHeader."Document Type";
            Validate("Buy-from Vendor No.", VendorNo);
            if pPurchHeader."Purchaser Code" <> '' then
                Validate("Purchaser Code", pPurchHeader."Purchaser Code");
            Insert;
            //GL2024   CopyFromPurchDocDimToHeader(CurrPurchHeader, pPurchHeader);
            CopyComment(CurrPurchHeader, pPurchHeader);
            if not HideValidationDialog then
                Window.Update(1, CurrPurchHeader."No.");
            exit("No.");
        end;
    end;


    procedure CreateNewLine(PurchLine: Record "Purchase Line"; pPurchHeader: Record "Purchase Header")
    begin
        pPurchHeader.TestField("No.");
        PurchLine.TestField("Document Type", PurchLine."document type"::Quote);
        PurchLine.TestField("Document No.");
        NbreLine += 1;

        with CurrPurchLine do begin
            Init;
            TransferFields(PurchLine);
            "Document No." := pPurchHeader."No.";
            "Buy-from Vendor No." := pPurchHeader."Buy-from Vendor No.";
            "Pay-to Vendor No." := pPurchHeader."Pay-to Vendor No.";
            "Currency Code" := pPurchHeader."Currency Code";
            "Attached to Doc. No." := PurchLine."Document No.";
            "Attached to Doc. Type" := pPurchHeader."Document Type";


            if Type in [Type::"G/L Account", Type::Item] then begin
                //CDE_INTERNE
                //    VALIDATE("No.");
                //CDE_INTERNE//
                //#5551
                Validate("Gen. Bus. Posting Group", pPurchHeader."Gen. Bus. Posting Group");
                Validate("VAT Bus. Posting Group", pPurchHeader."VAT Bus. Posting Group");
                //#5551//
                Validate("Direct Unit Cost", 0);
                Validate("Discount 1 %", 0);
                Validate("Discount 2 %", 0);
                Validate("Discount 3 %", 0);
                if Type = Type::Item then begin
                    Item.Get("No.");
                    ItemVend."Item No." := "No.";
                    ItemVend."Vendor No." := "Buy-from Vendor No.";
                    ItemVend."Variant Code" := "Variant Code";
                    Item.FindItemVend(ItemVend, "Location Code");
                    "Vendor Item No." := ItemVend."Vendor Item No.";
                end;
            end;

            Description := PurchLine.Description;
            "Attached to Doc. No." := PurchLine."Document No.";
            "Attached to Doc. Type" := pPurchHeader."Document Type";
            "Location Code" := pPurchHeader."Location Code";
            //CONSULT
            "Sales Order No." := '';
            "Sales Order Line No." := 0;
            //CONSULT//
            Insert(true);
            //GL2024 CopyFromPurchDocDimToLine(CurrPurchLine, PurchLine);
        end;
    end;


    procedure CompleteLines(pPurchHeader: Record "Purchase Header"; AllLines: Boolean)
    begin
        PriceOfferSetup.Get;
        Vendor.Get(pPurchHeader."Buy-from Vendor No.");

        with InitPurchLine do begin
            SetRange("Document Type", pPurchHeader."Attached to Doc. Type");
            SetRange("Document No.", pPurchHeader."Attached to Doc. No.");
            SetFilter(Type, '=%1|=%2|=%3', Type::"G/L Account", Type::Item, Type::" ");
            if not Find('-') then
                Error(Text001);
        end;

        if not HideValidationDialog then begin
            Window.Open(Text002 + Text003);
            Window.Update(1, pPurchHeader."No.");
        end;

        repeat
            if AllLines then begin
                if not HideValidationDialog then
                    Window.Update(2, InitPurchLine."No.");

                if not PurchLine2.Get(
                   pPurchHeader."Document Type",
                   pPurchHeader."No.", InitPurchLine."Line No.")
                then
                    CreateNewLine(InitPurchLine, pPurchHeader);
            end else begin
                case InitPurchLine.Type of
                    InitPurchLine.Type::Item:
                        begin
                            Item.Get(InitPurchLine."No.");
                            //Catégorie et groupe produit
                            if Item."Item Category Code" <> '' then begin
                                VendItemCategory.Reset;
                                VendItemCategory.SetRange("Item Category Code", Item."Item Category Code");
                                //GL2024   VendItemCategory.SetFilter("Product Group Code", '%1|%2', '', Item."Product Group Code");
                                VendItemCategory.SetRange("Vendor No.", pPurchHeader."Buy-from Vendor No.");
                                if VendItemCategory.Find('-') then
                                    repeat
                                        //GetHeader(pPurchHeader,VendItemCategory."Vendor No.");
                                        VendItemCategory2.Reset;
                                        VendItemCategory2.SetRange("Vendor No.", VendItemCategory."Vendor No.");
                                        VendItemCategory2.SetRange("Item Category Code", VendItemCategory."Item Category Code");
                                        VendItemCategory2.SetRange("Product Group Code", VendItemCategory."Product Group Code");
                                        VendItemCategory2.SetRange("Exclude From Price Offer", true);
                                        if VendItemCategory2.IsEmpty then begin
                                            if not PurchLine2.Get(
                                               pPurchHeader."Document Type",
                                               pPurchHeader."No.", InitPurchLine."Line No.")
                                            then
                                                CreateNewLine(InitPurchLine, pPurchHeader);
                                        end;
                                    until VendItemCategory.Next = 0;
                            end;

                            //Prix achat
                            if PriceOfferSetup."Additional Vendor Selection" in
                               [PriceOfferSetup."additional vendor selection"::Both,
                                PriceOfferSetup."additional vendor selection"::"Purchase Price"]
                            then begin
                                PurchPrice.Reset;
                                PurchPrice.SetRange("Item No.", InitPurchLine."No.");
                                PurchPrice.SetRange("Vendor No.", pPurchHeader."Buy-from Vendor No.");
                                if PurchPrice.Find('-') then begin
                                    repeat
                                        if not CurrPurchLine.Get(pPurchHeader."Document Type",
                                                                 pPurchHeader."No.", InitPurchLine."Line No.") then
                                            CreateNewLine(InitPurchLine, pPurchHeader);
                                    until PurchPrice.Next = 0;
                                end;
                            end;

                            //Remise ligne achat
                            if PriceOfferSetup."Additional Vendor Selection" in
                               [PriceOfferSetup."additional vendor selection"::Both,
                                PriceOfferSetup."additional vendor selection"::"Purchase Line Discount"]
                            then begin
                                PurchLineDisc.Reset;
                                //GL2024   PurchLineDisc.SetRange(Code, InitPurchLine."No.");
                                PurchLineDisc.SetRange("Item No.", InitPurchLine."No.");
                                PurchLineDisc.SetRange(Type, PurchLineDisc.Type::Item);
                                PurchLineDisc.SetRange("Purchase Type", PurchLineDisc."purchase type"::Vendor);
                                //GL2024   PurchLineDisc.SetRange("Purchase Code", pPurchHeader."Buy-from Vendor No.");
                                PurchLineDisc.SetRange("Vendor No.", pPurchHeader."Buy-from Vendor No.");
                                if PurchLineDisc.Find('-') then begin
                                    repeat
                                        if not CurrPurchLine.Get(pPurchHeader."Document Type",
                                                                 pPurchHeader."No.", InitPurchLine."Line No.") then
                                            CreateNewLine(InitPurchLine, pPurchHeader);
                                    until PurchLineDisc.Next = 0;
                                end;
                            end;
                        end;
                    InitPurchLine.Type::" ":
                        if InitPurchLine."Attached to Line No." <> 0 then begin
                            if CurrPurchLine.Get(pPurchHeader."Document Type",
                               pPurchHeader."No.", InitPurchLine."Attached to Line No.")
                            then
                                if not CurrPurchLine.Get(pPurchHeader."Document Type",
                                                         pPurchHeader."No.", InitPurchLine."Line No.") then
                                    CreateNewLine(InitPurchLine, pPurchHeader);
                        end else
                            if not CurrPurchLine.Get(pPurchHeader."Document Type",
                                                     pPurchHeader."No.", InitPurchLine."Line No.") then
                                CreateNewLine(InitPurchLine, pPurchHeader);

                    InitPurchLine.Type::"G/L Account":
                        if not CurrPurchLine.Get(pPurchHeader."Document Type",
                                                 pPurchHeader."No.", InitPurchLine."Line No.") then
                            CreateNewLine(InitPurchLine, pPurchHeader);
                end;
            end;
        until InitPurchLine.Next = 0;

        if not HideValidationDialog then
            Window.Close;
    end;


    procedure ShowNumberLines()
    begin
        if NbreLine = 1 then
            Message(Text013, NbreLine)
        else
            Message(Text007, NbreLine);
    end;


    procedure ShowGenerateFilesList()
    var
        lTools: Codeunit Tools;
    begin
        PriceOfferSetup.Get;
        lTools.fRunCommandLine(lTools.fGetEnvironPath('WINDIR') + '\Explorer.exe ' + PriceOfferSetup."Export Folder", false);
        //SHELL(ENVIRON('WINDIR') + '\Explorer.exe',PriceOfferSetup."Export Folder");
    end;


    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;
    /* GL2024
        local procedure CopyFromPurchDocDimToHeader(var ToPurchHeader: Record 38; var FromPurchHeader: Record 38)
        var
            DocDim: Record 357;
            FromDocDim: Record 357;
        begin
            DocDim.SetRange("Table ID", Database::"Purchase Header");
            DocDim.SetRange("Document Type", ToPurchHeader."Document Type");
            DocDim.SetRange("Document No.", ToPurchHeader."No.");
            DocDim.SetRange("Line No.", 0);
            DocDim.DeleteAll;

            ToPurchHeader."Shortcut Dimension 1 Code" := FromPurchHeader."Shortcut Dimension 1 Code";
            ToPurchHeader."Shortcut Dimension 2 Code" := FromPurchHeader."Shortcut Dimension 2 Code";

            FromDocDim.SetRange("Table ID", Database::"Purchase Header");
            FromDocDim.SetRange("Document Type", FromPurchHeader."Document Type");
            FromDocDim.SetRange("Document No.", FromPurchHeader."No.");
            if FromDocDim.Find('-') then begin
                repeat
                    DocDim.Init;
                    DocDim."Table ID" := Database::"Purchase Header";
                    DocDim."Document Type" := ToPurchHeader."Document Type";
                    DocDim."Document No." := ToPurchHeader."No.";
                    DocDim."Line No." := 0;
                    DocDim."Dimension Code" := FromDocDim."Dimension Code";
                    DocDim."Dimension Value Code" := FromDocDim."Dimension Value Code";
                    DocDim.Insert;
                until FromDocDim.Next = 0;
            end;
        end;

        local procedure CopyFromPurchDocDimToLine(var ToPurchLine: Record 39; var FromPurchLine: Record 39)
        var
            DocDim: Record 357;
            FromDocDim: Record 357;
        begin
            DocDim.SetRange("Table ID", Database::"Purchase Line");
            DocDim.SetRange("Document Type", ToPurchLine."Document Type");
            DocDim.SetRange("Document No.", ToPurchLine."Document No.");
            DocDim.SetRange("Line No.", ToPurchLine."Line No.");
            DocDim.DeleteAll;

            ToPurchLine."Shortcut Dimension 1 Code" := FromPurchLine."Shortcut Dimension 1 Code";
            ToPurchLine."Shortcut Dimension 2 Code" := FromPurchLine."Shortcut Dimension 2 Code";

            FromDocDim.SetRange("Table ID", Database::"Purchase Line");
            FromDocDim.SetRange("Document Type", FromPurchLine."Document Type");
            FromDocDim.SetRange("Document No.", FromPurchLine."Document No.");
            FromDocDim.SetRange("Line No.", FromPurchLine."Line No.");
            if FromDocDim.Find('-') then begin
                repeat
                    DocDim.Init;
                    DocDim."Table ID" := Database::"Purchase Line";
                    DocDim."Document Type" := ToPurchLine."Document Type";
                    DocDim."Document No." := ToPurchLine."Document No.";
                    DocDim."Line No." := ToPurchLine."Line No.";
                    DocDim."Dimension Code" := FromDocDim."Dimension Code";
                    DocDim."Dimension Value Code" := FromDocDim."Dimension Value Code";
                    DocDim.Insert;
                until FromDocDim.Next = 0;
            end;
        end;

    */
    procedure OffersExists(pPurchHeader: Record "Purchase Header"): Boolean
    var
        lPurchHeader: Record "Purchase Header";
    begin
        lPurchHeader.SetCurrentkey("Attached to Doc. Type", "Attached to Doc. No.");
        lPurchHeader.SetRange("Attached to Doc. Type", pPurchHeader."Document Type");
        lPurchHeader.SetRange("Attached to Doc. No.", pPurchHeader."No.");
        exit(lPurchHeader.Find('-'));
    end;


    procedure wConvertDirectUnitCost(pTempPurchLine: Record "Purchase Line") Return: Decimal
    var
        lDirectUnitCost: Decimal;
        GLSetup: Record "General Ledger Setup";
    begin
        if pTempPurchLine."Currency Code" <> '' then begin
            PurchHeader.Get(pTempPurchLine."Document Type", pTempPurchLine."Document No.");
            if PurchHeader."Posting Date" = 0D then
                UseDate := WorkDate
            else
                UseDate := PurchHeader."Posting Date";
            lDirectUnitCost := CurrExchRate.ExchangeAmtFCYToLCY(
              UseDate, PurchHeader."Currency Code", pTempPurchLine."Direct Unit Cost", PurchHeader."Currency Factor");
            lDirectUnitCost := lDirectUnitCost * (1 - (pTempPurchLine."Line Discount %" / 100));
        end else
            lDirectUnitCost := pTempPurchLine."Direct Unit Cost" * (1 - (pTempPurchLine."Line Discount %" / 100));

        GLSetup.Get;
        Return := ROUND(lDirectUnitCost, GLSetup."Unit-Amount Rounding Precision");
    end;


    procedure CopyComment(var ToPurchHeader: Record "Purchase Header"; var FromPurchHeader: Record "Purchase Header")
    var
        lFromPurchCommentLine: Record "Purch. Comment Line";
        lToPurchCommentLine: Record "Purch. Comment Line";
    begin
        lToPurchCommentLine.SetRange("Document Type", ToPurchHeader."Document Type");
        lToPurchCommentLine.SetRange("No.", ToPurchHeader."No.");
        lToPurchCommentLine.DeleteAll;

        lFromPurchCommentLine.SetRange("Document Type", FromPurchHeader."Document Type");
        lFromPurchCommentLine.SetRange("No.", FromPurchHeader."No.");
        if not lFromPurchCommentLine.IsEmpty then begin
            lFromPurchCommentLine.Find('-');
            repeat
                lToPurchCommentLine."Document Type" := ToPurchHeader."Document Type";
                lToPurchCommentLine."No." := ToPurchHeader."No.";
                lToPurchCommentLine."Line No." := lFromPurchCommentLine."Line No.";
                lToPurchCommentLine.Date := lFromPurchCommentLine.Date;
                lToPurchCommentLine.Code := lFromPurchCommentLine.Code;
                lToPurchCommentLine.Comment := lFromPurchCommentLine.Comment;
                lToPurchCommentLine.Insert(true);
            until lFromPurchCommentLine.Next = 0;
        end;
    end;
}

