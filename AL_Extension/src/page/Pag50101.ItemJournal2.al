page 50101 "Item Journal 2"
{
    // //+REF+IMPORT CW 10/05/05 MenuButton Fonctions + Importer

    AutoSplitKey = true;
    Caption = 'Item Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Card;
    SaveValues = true;
    SourceTable = 83;

    layout
    {
        area(content)
        {
            field(CdeNomFeuille; CdeNomFeuille)
            {
                Editable = false;
                Enabled = true;
                Style = Strong;
                StyleExpr = TRUE;
            }
            repeater("Control1")
            {
                ShowCaption = false;
                field("Entry Type"; rec."Entry Type")
                {
                    Editable = false;
                    OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.';
                    Visible = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                }
                field("Document No."; rec."Document No.")
                {
                    Visible = false;
                }
                field("Item No."; rec."Item No.")
                {

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.GetItem(rec."Item No.", ItemDescription);
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field(Description; rec.Description)
                {
                    Editable = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    Visible = true;

                    trigger OnValidate()
                    var
                        WMSManagement: Codeunit 7302;
                    begin
                        //VerifStock();
                        WMSManagement.CheckItemJnlLineLocation(Rec, xRec);
                    end;
                }
                field("Phys. Inv. Quantity"; rec."Phys. Inv. Quantity")
                {
                    Caption = 'Qte Dispo.';
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Quantity; rec.Quantity)
                {
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    Visible = false;
                }
                field(Heure; rec.Heure)
                {
                    Visible = HeureVisible;
                }
                field("External Document No.1"; rec."External Document No.")
                {
                    Caption = 'Num Piece';
                    Style = Strong;
                    StyleExpr = TRUE;

                    trigger OnValidate()
                    begin
                        ItemLedgerEntry.SETRANGE("External Document No.", rec."External Document No.");
                        IF ItemLedgerEntry.FINDFIRST THEN ERROR(Text004);
                    end;
                }
                field("Type Index"; rec."Type Index")
                {
                    Visible = "Type IndexVisible";
                }
                field("Index Horaire"; rec."Index Horaire")
                {
                    Visible = "Index HoraireVisible";
                }
                field("Index Kilometrique"; rec."Index Kilometrique")
                {
                    Visible = "Index KilometriqueVisible";
                }
                field("Document Date"; rec."Document Date")
                {
                    Visible = false;
                }
                field("Filtre Materiel"; rec."Filtre Materiel")
                {
                    Visible = false;
                }
                field("N° Materiel"; rec."N° Materiel")
                {
                    Visible = "N° MaterielVisible";
                }
                field(Chauffeur; rec.Chauffeur)
                {
                    Visible = ChauffeurVisible;
                }
                field("Nom Utilisateur"; rec."Nom Utilisateur")
                {
                    Visible = "Nom UtilisateurVisible";
                }
                field("External Document No."; rec."External Document No.")
                {
                    Visible = false;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    Visible = false;
                }
                field("Salespers./Purch. Code"; rec."Salespers./Purch. Code")
                {
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Unit of Measure Code1"; rec."Unit of Measure Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                    Visible = false;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    Visible = false;
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                    Visible = false;
                }
                field("Job No."; rec."Job No.")
                {
                    Caption = 'Job No.';
                    Visible = "Job No.Visible";
                }
                field("Affectation Marche"; rec."Affectation Marche")
                {
                }
                field("Sous Affectation Marche"; rec."Sous Affectation Marche")
                {
                }
                field(Receptioneur; rec.Receptioneur)
                {
                }
                field(Benificiaire; rec.Benificiaire)
                {
                }
                field(Provenance; rec.Provenance)
                {
                }
                field(Observation; rec.Observation)
                {
                }
                field("Reason Code"; rec."Reason Code")
                {
                    Visible = false;
                }
            }
            group(" ")
            {
                /* label()
                 {
                     CaptionClass = Text19009191;
                 }*/
                field(ItemDescription; ItemDescription)
                {
                    Editable = false;
                }
            }
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    ItemJnlMgt.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    // rec.CurrentJnlBatchNameOnAfterValidate;
                end;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                /* action(Dimensions)
                 {
                     Caption = 'Dimensions';
                     Image = Dimensions;
                     RunpageLink = "Table ID"=CONST(83),"Journal Template Name"=FIELD("Journal Template Name"),"Journal Batch Name"=FIELD("Journal Batch Name"),"Journal Line No."=FIELD("Line No.");
                     RunObject = Page "Journal Line Dimensions";
                                   //  ShortCutKey = 'Maj+Ctrl+D';
                 }*/
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Maj+Ctrl+I';

                    trigger OnAction()
                    begin
                        rec.OpenItemTrackingLines(FALSE);
                    end;
                }
                /*  action("Bin Contents")
                  {
                      Caption = 'Bin Contents';
                      Image = BinContent;
                      RunFormLink = Location Code=FIELD(Location Code),Item No.=FIELD(Item No.),Variant Code=FIELD(Variant Code);
                      RunpageView = SORTING(Location Code,Item No.,Variant Code);
                      RunObject = Page 7305;
                  }*/
                separator("-")
                {
                    Caption = '-';
                }
                action("&Recalculate Unit Amount")
                {
                    Caption = '&Recalculate Unit Amount';

                    trigger OnAction()
                    begin
                        rec.RecalculateUnitAmount;
                        CurrPage.SAVERECORD;
                    end;
                }
            }
            group("&Item")
            {
                Caption = '&Item';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunpageLink = "No." = FIELD("Item No.");
                    RunObject = Page 31;
                    ShortCutKey = 'Maj+F5';
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunpageLink = "Item No." = FIELD("Item No.");
                    RunpageView = SORTING("Item No.");
                    RunObject = Page 38;
                    ShortCutKey = 'Ctrl+F7';
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    action(Period)
                    {
                        Caption = 'Period';

                        trigger OnAction()
                        begin
                            //rec.ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';

                        trigger OnAction()
                        begin
                            //   ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';

                        trigger OnAction()
                        begin
                            // ItemAvailability(2);
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    RunObject = Codeunit 246;
                }
                action("&Calculate Whse. Adjustment")
                {
                    Caption = '&Calculate Whse. Adjustment';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        CalcWhseAdjmt.SetItemJnlLine(Rec);
                        CalcWhseAdjmt.RUNMODAL;
                        CLEAR(CalcWhseAdjmt);
                    end;
                }

                action(Import)
                {
                    Caption = 'Import';

                    trigger OnAction()
                    var
                        lImport: Record 8001418;
                    begin
                        //+REF+IMPORT
                        lImport.ImportJournal(DATABASE::"Item Journal Line", 1, rec."Journal Template Name", 41, rec."Journal Batch Name");
                        //+REF+IMPORT//
                    end;
                }
                action("&Get Standard Journals")
                {
                    Caption = '&Get Standard Journals';
                    Ellipsis = true;
                    Image = GetStandardJournal;

                    trigger OnAction()
                    var
                        StdItemJnl: Record 752;
                    begin
                        StdItemJnl.FILTERGROUP := 2;
                        StdItemJnl.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        StdItemJnl.FILTERGROUP := 0;
                        IF page.RUNMODAL(page::"Standard Item Journals", StdItemJnl) = ACTION::LookupOK THEN BEGIN
                            StdItemJnl.CreateItemJnlFromStdJnl(StdItemJnl, CurrentJnlBatchName);
                            MESSAGE(Text001, StdItemJnl.Code);
                        END
                    end;
                }
                action("&Save as Standard Journal")
                {
                    Caption = '&Save as Standard Journal';
                    Ellipsis = true;
                    Image = SaveasStandardJournal;

                    trigger OnAction()
                    var
                        ItemJnlBatch: Record 233;
                        ItemJnlLines: Record 83;
                        StdItemJnl: Record 752;
                        SaveAsStdItemJnl: Report 751;
                    begin
                        ItemJnlLines.SETFILTER("Journal Template Name", rec."Journal Template Name");
                        ItemJnlLines.SETFILTER("Journal Batch Name", CurrentJnlBatchName);
                        CurrPage.SETSELECTIONFILTER(ItemJnlLines);
                        ItemJnlLines.COPYFILTERS(Rec);

                        ItemJnlBatch.GET(rec."Journal Template Name", CurrentJnlBatchName);
                        SaveAsStdItemJnl.Initialise(ItemJnlLines, ItemJnlBatch);
                        SaveAsStdItemJnl.RUNMODAL;
                        IF NOT SaveAsStdItemJnl.GetStdItemJournal(StdItemJnl) THEN
                            EXIT;

                        MESSAGE(Text002, StdItemJnl.Code);
                    end;
                }
                action(Validate)
                {
                    Caption = 'Validate';
                    Visible = false;

                    trigger OnAction()
                    begin
                        RecItemJrnl.COPY(Rec);
                        IF RecItemJrnl.FINDFIRST THEN
                            REPEAT

                                DECMNT := RecItemJrnl."Unit Cost";
                                RecItemJrnl.VALIDATE("Item No.", RecItemJrnl."Item No.");
                                RecItemJrnl.VALIDATE(Quantity, RecItemJrnl.Quantity);
                                RecItemJrnl.VALIDATE("Location Code", RecItemJrnl."Location Code");
                                RecItemJrnl."Unit Amount" := DECMNT;
                                RecItemJrnl."Unit Cost" := DECMNT;
                                RecItemJrnl.Amount := RecItemJrnl.Quantity * DECMNT;
                                RecItemJrnl.MODIFY;
                            UNTIL RecItemJrnl.NEXT = 0;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintItemJnlLine(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        IF RecItemJournalTemplate.GET(rec."Journal Template Name") THEN;
                        RecItemJrnl.COPY(Rec);
                        IF RecItemJrnl.FINDFIRST THEN
                            REPEAT
                                IF RecItemJournalTemplate."Materiel Obligatoire" THEN RecItemJrnl.TESTFIELD("N° Materiel");
                                IF RecItemJournalTemplate."Affaire Obligatoire" THEN RecItemJrnl.TESTFIELD("Job No.");
                                IF RecItemJournalTemplate."Affectation Marche Obligatoire" THEN RecItemJrnl.TESTFIELD("Affectation Marche");
                                IF RecItemJournalTemplate."Sous Affect Marche Obligatoire" THEN RecItemJrnl.TESTFIELD("Sous Affectation Marche");

                            // IF RecItemJrnl."Entry Type"=RecItemJrnl."Entry Type"::"Positive Adjmt." THEN
                            // IF "Unit Cost"=0 THEN ERROR(Text003,RecItemJrnl."Item No.");
                            UNTIL RecItemJrnl.NEXT = 0;
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                        CurrentJnlBatchName := rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Maj+F11';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ItemJnlLine: Record 83;
                begin
                    // HJ SORO 01/01/2015
                    VeriflIgne;
                    // HJ SORO 01/01/2015
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec.ShowShortcutDimCode(ShortcutDimCode);
        // >> HJ DSFT 23 03 2012
        IF RecItemJournalTemplate.GET(rec."Journal Template Name") THEN CdeNomFeuille := RecItemJournalTemplate.Description;
        IF CdeNomFeuille = '' THEN CdeNomFeuille := rec."Journal Batch Name";

        IF RecItemJournalTemplate."Afficher Index" THEN BEGIN
            "Index HoraireVisible" := TRUE;
            "Index KilometriqueVisible" := TRUE;
            "Type IndexVisible" := TRUE;
        END
        ELSE BEGIN
            "Index HoraireVisible" := FALSE;
            "Index KilometriqueVisible" := FALSE;
            "Type IndexVisible" := FALSE;
        END;
        IF RecItemJournalTemplate."Afficher Heure" THEN
            HeureVisible := TRUE ELSE
            HeureVisible := FALSE;
        IF RecItemJournalTemplate."Afficher Heure" THEN
            HeureVisible := TRUE ELSE
            HeureVisible := FALSE;

        IF RecItemJournalTemplate."Afficher Nom Utilisateur" THEN
            "Nom UtilisateurVisible" := TRUE ELSE
            "Nom UtilisateurVisible" := FALSE;
        IF RecItemJournalTemplate."Afficher Affaire" THEN
            "Job No.Visible" := TRUE ELSE
            "Job No.Visible" := FALSE;
        IF RecItemJournalTemplate."Afficher Materiel" THEN
            "N° MaterielVisible" := TRUE ELSE
            "N° MaterielVisible" := FALSE;
        IF RecItemJournalTemplate."Afficher Chauffeur" THEN
            ChauffeurVisible := TRUE ELSE
            ChauffeurVisible := FALSE;

        // >> HJ DSFT 23 03 2012
        OnAfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveItemJnlLine: Codeunit 99000835;
    begin
        COMMIT;
        IF NOT ReserveItemJnlLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
        ReserveItemJnlLine.DeleteLine(Rec);
    end;

    trigger OnInit()
    begin
        ChauffeurVisible := TRUE;
        "N° MaterielVisible" := TRUE;
        "Job No.Visible" := TRUE;
        "Nom UtilisateurVisible" := TRUE;
        "Type IndexVisible" := TRUE;
        "Index KilometriqueVisible" := TRUE;
        "Index HoraireVisible" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF rec."Entry Type" > rec."Entry Type"::"Negative Adjmt." THEN
            ERROR(Text000, rec."Entry Type");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    var
        Text000: Label 'You cannot use entry type %1 in this journal.';
        ItemJnlMgt: Codeunit 240;
        ReportPrint: Codeunit 228;
        CalcWhseAdjmt: Report 7315;
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[100];
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'Item Journal lines have been successfully inserted from Standard Item Journal %1.';
        Text002: Label 'Standard Item Journal %1 has been successfully created.';
        OpenedFromBatch: Boolean;
        "// HJ DSFT": Integer;
        CdeNomFeuille: Text[255];
        RecItemJournalTemplate: Record 82;
        RecItemJrnl: Record 83;
        DECMNT: Decimal;
        RecItem: Record 27;
        Text003: Label 'Le Coût de l''article %1 Est Zero, Afficher Le champs Coût Unitaire Et Affecter Un Coût Correct';
        ItemLedgerEntry: Record 32;
        Text004: Label 'Numéro Piece Existante ';
        [InDataSet]
        "Index HoraireVisible": Boolean;
        [InDataSet]
        "Index KilometriqueVisible": Boolean;
        [InDataSet]
        "Type IndexVisible": Boolean;
        [InDataSet]
        HeureVisible: Boolean;
        [InDataSet]
        "Nom UtilisateurVisible": Boolean;
        [InDataSet]
        "Job No.Visible": Boolean;
        [InDataSet]
        "N° MaterielVisible": Boolean;
        [InDataSet]
        ChauffeurVisible: Boolean;
        Text19009191: Label 'Item Description';


    procedure VerifStock()
    var
        Text001: Label 'Article Non Disponible En stock';
        Text002: Label 'Quantité Dans Stock Ne Satisfait Pas Votre Demande';
    begin
        IF rec."Entry Type" = rec."Entry Type"::"Positive Adjmt." THEN EXIT;
        IF (rec."Item No." = '') OR (rec."Location Code" = '') THEN EXIT;
        RecItem.SETFILTER("No.", rec."Item No.");
        RecItem.SETFILTER("Location Filter", rec."Location Code");
        IF RecItem.FINDFIRST THEN BEGIN
            RecItem.CALCFIELDS(Inventory);
            rec."Phys. Inv. Quantity" := RecItem.Inventory;
            IF RecItem.Inventory = 0 THEN ERROR(Text001);
            IF RecItem.Inventory < rec.Quantity THEN ERROR(Text002);
        END;
    end;


    procedure VeriflIgne()
    begin
        IF RecItemJournalTemplate.GET(rec."Journal Template Name") THEN;
        RecItemJrnl.COPY(Rec);
        IF RecItemJrnl.FINDFIRST THEN
            REPEAT
                IF RecItemJournalTemplate."Materiel Obligatoire" THEN RecItemJrnl.TESTFIELD("N° Materiel");
                IF RecItemJournalTemplate."Affaire Obligatoire" THEN RecItemJrnl.TESTFIELD("Job No.");
                IF RecItemJournalTemplate."Affectation Marche Obligatoire" THEN RecItemJrnl.TESTFIELD("Affectation Marche");
                IF RecItemJournalTemplate."Sous Affect Marche Obligatoire" THEN RecItemJrnl.TESTFIELD("Sous Affectation Marche");

                IF RecItemJrnl."Entry Type" = RecItemJrnl."Entry Type"::"Positive Adjmt." THEN
                    IF rec."Unit Cost" = 0 THEN ERROR(Text003, RecItemJrnl."Item No.");
            UNTIL RecItemJrnl.NEXT = 0;
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ItemJnlMgt.GetItem(rec."Item No.", ItemDescription);
    end;
}

