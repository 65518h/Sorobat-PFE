Page 50321 "Purchase Request Header"
{
    //HS 

    Caption = 'En-tête de demande d''achat';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Purchase Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Basic;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = all;
                }
                field("Requester ID"; Rec."Requester ID")
                {
                    ApplicationArea = Basic;
                    // Caption = 'Demandeur';
                }
                field(Service; Rec.Service)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Type de demande';
                }
                field(Engin; Rec.Engin)
                {
                    ApplicationArea = Basic;
                }
                field("Description Engin"; Rec."Description Engin")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sous Famille Engin"; Rec."Sous Famille Engin")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statut';
                    Editable = false;
                    //  OptionCaption = 'Pending,accepted,refused';
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Management controller decision"; Rec."Management controller decision")
                {
                    ApplicationArea = all;
                    Editable = ContreollerVisibility;
                    Style = Strong;

                }
                field("received"; Rec.received)
                {
                    ApplicationArea = Basic;
                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                    Style = Unfavorable;

                }
                field("Date saisie"; Rec."Date saisie")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                    Style = Unfavorable;

                }
                field("ID d'approbateur"; Rec."ID d'approbateur")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                    Style = Unfavorable;

                }
                field("Date d'approbation"; Rec."Date d'approbation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                    Style = Unfavorable;

                }
                field(Observation; Rec.Observation)
                {
                    ApplicationArea = Basic;
                }

                field("Associated Purchase Order"; Rec."Associated Purchase Order")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Reason Refusal"; Rec."Reason Refusal") { ApplicationArea = all; Editable = false; Visible = RefusualReasonVisibility; }
            }
            part("PurchaserequestLine"; "Purchase request Line")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No."), "document type" = field("Document Type");
            }
            group("Follow up")
            {
                Visible = false;
                Caption = 'Suivi';
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                /*field(Urgence; Rec.Urgence)
                {
                    ApplicationArea = Basic;
                }*/
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = Basic;
                }
            }
            // group("Materials-Fresh Market")
            // {
            //     Visible = false;
            //     Caption = 'Materials-Fresh Market';
            //     part(Control1000000033; 50102)
            //     {
            //         ApplicationArea = all;
            //         Editable = false;
            //         SubpageLink = "Construction site" = field("Job No.");
            //         SubpageView = WHERE(Type = CONST(Materials));
            //     }
            // }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Purchase Request"),
                              "No." = field("No.");
                // "Document Type" = field("Document Type");
            }
            part("Article Par Magasin"; "Article Par Magasin")
            {
                Caption = 'Article Par Magasin';
                ApplicationArea = All;
                Provider = "PurchaserequestLine";
                SubPageLink = Article = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Reporting)
        {

            action(BPRINT)
            {
                ApplicationArea = Basic;
                Caption = 'Imprimer au format A4';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    RecUserSetup: Record "User Setup";
                begin
                    if RecUserSetup.Get(UserId) then;
                    // >> HJ DSFT 11-10-2012
                    //if Rec.Statut <> Rec.Statut::approved then Error(Text004);
                    //      if not (Rec.Statut in [Rec.Statut::approved, Rec.Statut::"partially supported", Rec.Statut::"Fully Supported"]) and (not RecUserSetup."Permission Print PR") then Error(Text004);
                    RecSalesOrder.SetRange("Document Type", Rec."Document Type");
                    RecSalesOrder.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Demande d'Appro Format A4", true, true, RecSalesOrder);
                    // >> HJ DSFT 11-10-2012

                    // STD HJ DSFT 11-10-2012 DocPrint.PrintSalesHeader(Rec);
                end;
            }
            action("BPRINT ")
            {
                ApplicationArea = Basic;
                Caption = 'Imprimer';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                Visible = false;

                trigger OnAction()
                var
                    RecUserSetup: Record "User Setup";
                begin
                    if RecUserSetup.Get(UserId) then;
                    // >> HJ DSFT 11-10-2012
                    //  if Rec.Statut <> Rec.Statut::approved then Error(Text004);
                    //       if not (Rec.Statut in [Rec.Statut::approved, Rec.Statut::"partially supported", Rec.Statut::"Fully Supported"]) and (not RecUserSetup."Permission Print PR") then Error(Text004);
                    RecSalesOrder.SetRange("Document Type", Rec."Document Type");
                    RecSalesOrder.SetRange("No.", Rec."No.");
                    //   Report.RunModal(Report::"Factues Achat Ouvertes", true, true, RecSalesOrder);
                    // >> HJ DSFT 11-10-2012

                    // STD HJ DSFT 11-10-2012 DocPrint.PrintSalesHeader(Rec);
                end;
            }

        }
        area(Creation)
        {
            group(Approbation)
            {

            }
        }
        area(processing)
        {


            group(BFUNCTION)
            {
                Caption = 'F&onctions';
                action("Generate Purchase Doc.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Générer le document d''achat';
                    Image = Purchase;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = ButtonApproVisibiltyCreateOrder;
                    trigger OnAction()
                    var
                        RecPurchaseSetup: Record "Purchases & Payables Setup";
                        TXT0001: Label 'Créer la commande d''achat ?';
                        Txt0002: Label 'La décision du contrôleur de gestion n''est toujours pas autorisée pour la création de la commande';
                        Txt0003: Label 'Le statut de la DA doit être approuvé';
                    begin

                        RecPurchaseSetup.Get();
                        if Rec.Statut <> Rec.Statut::approved then Error(Txt0003);
                        if RecPurchaseSetup."management controlleractivated" then begin
                            if Rec."Management controller decision" <> Rec."Management controller decision"::"Creation order authorized" then
                                Error(Txt0002);
                        end;
                        NbrLigne := 0;
                        // RB SORO 21/04/2015
                        RecPurchasesSetup.Get;
                        if RecPurchasesSetup."Autoriser Approbation DA" then begin
                            if RecLocation.Get(rec."Location Code") then;
                            if not RecLocation."Magasin Centrale" then begin
                                if not rec."PR Approved" then
                                    Error(Text012);
                            end;
                        end;
                        // RB SORO 21/04/2015

                        if not Confirm(TXT0001) then
                            exit;
                        CurrPage.PurchaserequestLine.page.wGeneratePurchaseOrder;
                        PurchaseHeader.SetRange("Purchase Request No.", Rec."No.");
                        if PurchaseHeader.FindFirst then
                            repeat
                                PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
                                PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                                if PurchaseLine.FindFirst then NbrLigne += PurchaseLine.Count;
                            until PurchaseHeader.Next = 0;
                        PrLine.SetRange("Document Type", rec."Document Type");
                        PrLine.SetRange("Document No.", rec."No.");
                        if PrLine.FindFirst then NbrLigneOrigine := PrLine.Count;
                        if NbrLigne < NbrLigneOrigine then begin
                            Rec.Statut := Rec.Statut::"partially supported";
                            rec.Modify;
                        end;
                        if NbrLigne = NbrLigneOrigine then begin
                            rec.Statut := Rec.Statut::"Fully Supported";
                            rec.Modify;
                        end;
                    end;
                }
                action("Transformer en ordre de transfert")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transformer en ordre de transfert';
                    Image = Shipment;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = ButtonApproVisibilty;
                    trigger OnAction()
                    var
                        RecTransferHeader: Record "Transfer Header";
                        RecTransferLine: Record "Transfer Line";
                        TXxt0001: Label 'Créer l''ordre de transfert pour cette DA ?';
                        RecInventorySetup: Record "Inventory Setup";
                        RecLocation: Record Location;
                        RecPurchaserequestLine: Record "Purchase request Line";
                        LineNo: Integer;
                    begin
                        if not Confirm(TXxt0001) then
                            exit;
                        // RecPurchaserequestLine.Reset();
                        // RecPurchaserequestLine.SetRange("Document No.", Rec."No.");
                        // RecPurchaserequestLine.SetRange("Transférer", false);
                        // if not RecPurchaserequestLine.FindFirst() then
                        //     Error('');
                        if Rec.Statut = Rec.Statut::Transferer then
                            Error('La demande d''achat a déjà été transférée en ordre de transfert.');
                        RecInventorySetup.Get();
                        RecInventorySetup.TestField("Magasin de transfert");
                        RecLocation.Reset();
                        RecLocation.SetRange("Use As In-Transit", true);
                        if RecLocation.FindFirst() then;
                        RecPurchaserequestLine.Reset();
                        RecPurchaserequestLine.SetRange("Document No.", Rec."No.");
                        RecPurchaserequestLine.SetRange("Transférer", true);
                        RecPurchaserequestLine.SetFilter(Statut, '<>%1', RecPurchaserequestLine.Statut::refused);
                        RecPurchaserequestLine.SetFilter("N° Ordres de transfert", '%1', '');
                        if not RecPurchaserequestLine.FindFirst() then
                            Message('Aucune ligne n''est sélectionnée pour le transfert ou les lignes sélectionnées ont été déjà transferer.')
                        else begin
                            RecTransferHeader.Init();
                            RecTransferHeader."Transfer-from Code" := RecInventorySetup."Magasin de transfert";
                            RecTransferHeader."Transfer-to Code" := Rec."Location Code";
                            RecTransferHeader."Posting Date" := Today;
                            RecTransferHeader."In-Transit Code" := RecLocation.Code;
                            RecTransferHeader."External Document No." := Rec."External Document No.";
                            RecTransferHeader.Observation := Rec.Observation;
                            RecTransferHeader."Chantier Destination" := Rec."Job No.";
                            RecTransferHeader."Date Saisie" := Today;
                            RecTransferHeader."N° Demande Achat" := Rec."No.";
                            RecTransferHeader.Insert(true);
                            LineNo := 10000;
                            RecPurchaserequestLine.Reset();
                            RecPurchaserequestLine.SetRange("Document No.", Rec."No.");
                            RecPurchaserequestLine.SetRange("Transférer", true);
                            RecPurchaserequestLine.SetFilter(Statut, '<>%1', RecPurchaserequestLine.Statut::refused);
                            RecPurchaserequestLine.SetFilter("N° Ordres de transfert", '%1', '');
                            if RecPurchaserequestLine.FindSet() then
                                repeat
                                    RecTransferLine.Init();
                                    RecTransferLine."Document No." := RecTransferHeader."No.";
                                    RecTransferLine."Line No." := LineNo;
                                    RecTransferLine.Validate("Item No.", RecPurchaserequestLine."No.");
                                    RecTransferLine.Description := RecPurchaserequestLine.Description;
                                    RecTransferLine.Validate(Quantity, RecPurchaserequestLine.Quantity);
                                    RecTransferLine."Unit of Measure Code" := RecPurchaserequestLine."Unit of Measure";
                                    RecTransferLine.Insert();
                                    LineNo += 10000;
                                    RecPurchaserequestLine.Statut := RecPurchaserequestLine.Statut::refused;
                                    RecPurchaserequestLine."N° Ordres de transfert" := RecTransferHeader."No.";
                                    RecPurchaserequestLine.Modify();
                                until RecPurchaserequestLine.Next() = 0;
                            //     Rec.Statut := Rec.Statut::Transferer;
                            //  Rec.Modify();
                            Message('Ordre de transfert %1 créé avec succès', RecTransferHeader."No.");
                        end;
                    end;
                }

                group("Special Order")
                {
                    Caption = 'Commande Spéciale';
                    Visible = false;
                    action(Action152)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Commande d''achat';
                        Image = Document;
                        Visible = false;

                        trigger OnAction()
                        begin
                            CurrPage.PurchaserequestLine.Page.OpenSpecialPurchOrderForm;
                        end;
                    }
                }
                action("Associated Quote")
                {
                    ApplicationArea = Basic;
                    Image = Quote;
                    Caption = 'Devis Associé';
                    RunpageLink = "Purchase Request No." = FIELD("No.");
                    RunObject = Page "Purchase Quotes";
                    Visible = false;
                }
                action(Action1000000000)
                {
                    ApplicationArea = Basic;
                    Caption = 'Commande d''achat';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        CurrPage.PurchaserequestLine.Page.OpenPurchOrderForm;
                    end;
                }

                action("Re&lease")
                {
                    ApplicationArea = Basic;
                    Caption = 'Lancer';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    //RunObject = Codeunit "Release Purchase Document";
                    ShortCutKey = 'Ctrl+F9';
                    trigger OnAction()
                    var
                        Txt001: Label 'Vous devez sélectionner un numéro de tâche dans la ligne %1';
                        RecGUserSetup: Record "User Setup";
                        Txt0001: Label 'Vous n''êtes pas autorisé à initier la demande.';
                        Txt0002: Label 'Le statut doit être ouvert!';
                        Txt0003: Label 'Voulez-vous initier la demande d''achat?';
                        l_Note: BigText;
                        Txt0004: Label 'Envoyer la demande d''achat %1 par %2';
                        Cdu50009: Codeunit PRcodeunit;
                    begin
                        //nEW
                        RecPurchasesPayablesSetup.Get();

                        IF NOT RecGUserSetup.GET(USERID) THEN
                            ERROR(Txt0001);
                        IF Rec.Statut <> Rec.Statut::Open THEN
                            ERROR(Txt0002);
                        IF NOT CONFIRM(Txt0003) THEN
                            EXIT;

                        PrLine.Reset();
                        PrLine.SetRange("Document No.", Rec."No.");
                        if not PrLine.FindFirst() then
                            Error('Insérer des lignes à la demande d''achat avant de la lancer.');

                        PrLine.Reset();
                        PrLine.SetRange("Document No.", Rec."No.");
                        PrLine.SetRange(Quantity, 0);
                        if PrLine.FindFirst() then
                            Error('Il faut saisir une quantité différente de zéro dans la ligne %1 avant de lancer la demande d''achat.', PrLine."Line No.");
                        PrLine.Reset;
                        PrLine.SetRange("Document Type", PrLine."document type"::Order);
                        PrLine.SetRange("Document No.", Rec."No.");
                        PrLine.SetRange("Job No.", '');
                        PrLine.SetFilter(Type, '<>%1', PrLine.Type::" ");
                        if PrLine.FindFirst then
                            Error(Txt001, PrLine."Line No.");
                        PrLine.Reset;
                        PrLine.SetRange("Document No.", Rec."No.");
                        if PrLine.FindSet() then begin
                            repeat
                                PrLine.Statut := PrLine.Statut::"To Approve";
                                PrLine.Modify();

                            until PrLine.Next() = 0;
                        end;
                        //Error(Txt001, PrLine."Line No.");


                        if Rec.Statut <> Rec.Statut::"To Approve" then
                            Rec.Statut := Rec.Statut::"To Approve";
                        Rec.Modify();
                        l_Note.ADDTEXT(STRSUBSTNO(Txt0004, Rec."No.", USERID));
                        if RecPurchasesPayablesSetup."Envoyer Mail DA" then
                            Cdu50009.CreateNotification(l_Note, TRUE, UserId, Rec.RECORDID, Rec, FALSE);

                        //nEW   
                        /*   PrLine.Reset;
                           PrLine.SetRange("Document Type", PrLine."document type"::Order);
                           PrLine.SetRange("Document No.", Rec."No.");
                           PrLine.SetRange("Job No.", '');
                           PrLine.SetFilter(Type, '<>%1', PrLine.Type::" ");
                           if PrLine.FindFirst then
                               Error(Txt001, PrLine."Line No.");
                           if Rec.Statut <> Rec.Statut::Released then
                               Rec.Statut := Rec.Statut::Released;
                           Rec.Modify();*/
                    end;
                }


                action("Re&open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reouvrir';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = ButtonApproVisibilty;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                        RecUserSetup: Record "User Setup";
                        Txt0001: Label 'Vous n''êtes pas autorisé à effectuer cette action';
                        Text010: Label 'Action refusée, le statut actuel est déja approuvé !';
                    begin
                        // if Rec.Statut = Rec.Statut::approved then
                        //     Error(Text010);
                        if RecUserSetup.Get(UserId) then begin
                            // if not ((RecUserSetup."PR Reopen permission Level 2") and (Rec.Statut <> Rec.Statut::"To Approve")) then
                            //     Error(Txt0001)
                            // else
                            if not RecUserSetup."PR Reopen permission" then
                                Error(Txt0001);
                        end;
                        PurchaseHeader.SetRange("Document Type", PurchaseHeader."document type"::Order);
                        PurchaseHeader.SetRange("Purchase Request No.", Rec."No.");
                        if PurchaseHeader.FindFirst then Error(Text009);
                        // if (Rec.Statut > Rec.Statut::Released) then Error(Text008);
                        Rec.Statut := Rec.Statut::Open;

                        // ReleaseSalesDoc.Reopen(Rec);
                        rec.Modify;
                        PrLine.Reset;
                        //   PrLine.SetRange("Document Type", PrLine."document type"::Order);
                        PrLine.SetRange("Document No.", Rec."No.");
                        if PrLine.FindSet() then
                            repeat
                                PrLine.Statut := PrLine.Statut::Open;
                                PrLine.Modify;
                            until PrLine.Next = 0;
                        // CurrPage.Close();
                    end;
                }


                /*  action(notify)
                  {
                      ApplicationArea = Basic;
                      Caption = 'notify';
                      ShortCutKey = 'F9';
                      Image = Alerts;
                      Visible = false;
                      trigger OnAction()
                      begin
                          // HS  PurchaseReqLine.SetRange("Document Type", PurchaseReqLine."document type"::Order);
                          PurchaseReqLine.SetRange("Document Type", PurchaseReqLine."document type"::Quote);
                          PurchaseReqLine.SetRange("Document No.", Rec."No.");
                          PurchaseReqLine.SetFilter(Quantity, '<>%1', 0);
                          if not PurchaseReqLine.FindFirst then Error(Text007);
                          if not Confirm(Text001) then exit;
                          if Rec.Statut >= 1 then exit;
                          TMessagerieChat.SetRange("Document No.", Rec."No.");
                          if not TMessagerieChat.FindFirst then begin
                              LeMessage := StrSubstNo(Text002, Rec."No.", UpperCase(UserId));
                              if UserSetup.Get(UpperCase(UserId)) then;
                              if UserSetup."Purchasing Department 01" <> '' then
                                  FMessagerieChat.InsertMessageDA(false, UpperCase(UserId), UserSetup."Purchasing Department 01", LeMessage, Rec."No.");
                              if UserSetup."Purchasing Department 02" <> '' then
                                  FMessagerieChat.InsertMessageDA(false, UpperCase(UserId), UserSetup."Purchasing Department 02", LeMessage, Rec."No.");
                              if UserSetup."Purchasing Department 03" <> '' then
                                  FMessagerieChat.InsertMessageDA(false, UpperCase(UserId), UserSetup."Purchasing Department 03", LeMessage, Rec."No.");
                          end;
                          PurchaseReqLine.Reset;
                          // HS  PurchaseReqLine.SetRange("Document Type", PurchaseReqLine."document type"::Order);
                          PurchaseReqLine.SetRange("Document Type", PurchaseReqLine."document type"::Quote);
                          PurchaseReqLine.SetRange("Document No.", Rec."No.");
                          if PurchaseReqLine.FindFirst then
                              repeat
                                  PurchaseReqLine.Statut := PurchaseReqLine.Statut::Launched;
                                  PurchaseReqLine.Modify;
                              until PurchaseReqLine.Next = 0;
                          Rec.Statut := Rec.Statut::Released;
                          Rec.Modify;
                      end;
                  }*/
                action(archive)
                {
                    ApplicationArea = Basic;
                    Caption = 'Archive';
                    Image = Archive;
                    Visible = false;
                    trigger OnAction()
                    begin
                        if (Rec.Statut = Rec.Statut::Open) or (Rec.Statut = Rec.Statut::Released) then Error(Text006);
                        if not Confirm(Text005) then exit;
                        Rec.Statut := Rec.Statut::Archive;
                        Rec.Modify;
                    end;
                }
                //HS
                action("Réinitialiser statut à Approuver")
                {
                    ApplicationArea = Basic;
                    Caption = 'Réinitialiser statut à Approuver';
                    Image = Refresh;
                    Visible = ButtonResetStatutVisibilty;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        RecGUserSetup: Record "User Setup";
                        Txt0001: Label 'Vous n''êtes pas autorisé à changer le statut de la demande en "à Approuver".';
                        Txt0002: Label 'Le statut de la demande d''achat (DA) doit être "Approuvée.';
                        Txt0003: Label 'Veuillez réinitialiser le statut à "À approuver" ?';
                    begin
                        IF not Confirm(Txt0003) then
                            exit;
                        IF RecGUserSetup.Get(UserId) then
                            IF NOT RecGUserSetup."Réinitialiser statut à Approuver" THEN
                                Error(Txt0001);
                        if not (Rec.Statut = Rec.Statut::approved) then
                            Error(Txt0002);
                        Rec.Statut := Rec.Statut::"To Approve";
                        Rec.Modify();

                        //   CurrPage.Close();
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approuver';
                    Image = Approve;
                    Visible = ButtonApproVisibilty;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        RecPrLine: Record "Purchase request Line";
                        Txt001: Label 'Vous n''êtes pas autorisé à changer le statut de la demande en "Approuvé".';
                        RecGUserSetup: Record "User Setup";
                        Txt0001: Label 'Vous n''êtes pas autorisé à changer le statut de la demande en "Approuvé".';
                        Txt0002: Label 'Le statut doit être ouvert!';
                        Txt0003: Label 'Voulez-vous approuver la demande d''achat ?';
                        l_Note: BigText;
                        Txt0004: Label 'Envoyer la demande d''achat %1 par %2';
                        Cdu50009: Codeunit PRcodeunit;
                        error001: Label 'vous ne pouvez pas approuver cette demande';
                        Txt0005: Label 'Le numéro de tâche du projet est obligatoire.';
                        Txt0006: Label 'La raison de la ligne refusée est obligatoire.';
                    begin
                        RecPurchasesPayablesSetup.Get();
                        IF NOT RecGUserSetup.GET(USERID) THEN
                            ERROR(Txt0001);
                        IF RecGUserSetup.Get(UserId) then
                            IF NOT RecGUserSetup.approver THEN
                                Error(error001);

                        if (Rec.Statut = Rec.Statut::"Fully Supported") or (Rec.Statut = Rec.Statut::"partially supported") then
                            ERROR('vous ne pouvez pas approuver cette demande car elle est déjà prise en charge.');
                        if not Confirm(Txt0003) then
                            exit;
                        // RecPrLine.Reset();
                        // RecPrLine.SetRange("Document No.", Rec."No.");
                        // RecPrLine.Setfilter(statut, '%1|%2', RecPrLine.statut::"To Approve", RecPrLine.statut::Open);
                        // RecPrLine.SetRange("Job Task No.", '');
                        // if RecPrLine.FindFirst() then
                        //     Error(Txt0005);
                        Rec.Statut := Rec.Statut::approved;
                        Rec."ID d'approbateur" := UserId;
                        Rec."Date d'approbation" := Today;
                        Rec.Modify();
                        RecPrLine.Reset();
                        RecPrLine.SetRange("Document No.", Rec."No.");
                        RecPrLine.Setfilter(statut, '%1|%2', RecPrLine.statut::"To Approve", RecPrLine.statut::Open);
                        if RecPrLine.FindSet() then begin
                            repeat
                                RecPrLine."Statut" := RecPrLine."statut"::Approved;
                                RecPrLine.Modify();
                            until RecPrLine.Next() = 0;
                        end;
                        RecPrLine.Reset();
                        RecPrLine.SetRange("Document No.", Rec."No.");
                        RecPrLine.Setfilter(statut, '%1', RecPrLine.statut::refused);
                        RecPrLine.SetRange("Reason Refusal", '');
                        if RecPrLine.FindFirst() then
                            Error(Txt0006);
                        if RecPurchasesPayablesSetup."Envoyer Mail DA" then
                            Cdu50009.ApprouvNotification(Rec."No.");

                        CurrPage.Close();
                        /* Old CODE
                        UserSetup.Get(UpperCase(UserId));
                        if not UserSetup."DA Approver" then
                            Error(Text013, Rec."No.")
                        else begin
                            PrLine.Reset;
                            PrLine.SetRange("Document Type", PrLine."document type"::Order);
                            PrLine.SetRange("Document No.", Rec."No.");
                            PrLine.SetFilter(Type, '<>%1', PrLine.Type::" ");
                            if PrLine.FindFirst then
                                repeat
                                    PrLine.TestField("Job No.");
                                    PrLine.TestField("Job Task No.");
                                    PrLine.TestField("Job Planning Line No.");
                                until PrLine.Next = 0;
                            Rec.Approve := true;
                            Rec."PR approver" := UserId;
                            Rec.Modify;
                            RecPrLine.SetRange("Document No.", Rec."No.");
                            Message(Text014);
                        end; Old CODE*/
                    end;
                }
                action(denied)
                {
                    ApplicationArea = Basic;
                    Caption = 'Refusé';
                    Image = Cancel;
                    Visible = ButtonApproVisibilty;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        RecPrLine: Record "Purchase request Line";
                        Txt0001: Label 'Changement du statut de la demande en « Refusé » non autorisé.';
                        RecGUserSetup: Record "User Setup";
                        Txt0002: Label 'Vous n''êtes pas autorisé à utiliser cette fonction!';
                        Txt0003: Label 'Le statut doit être "À approuver"!';
                        Txt0004: Label 'Voulez-vous refuser la demande d''achat ?';
                        Txt0005: Label 'Spécifiez la raison du refus';
                        PageReasonRef: Page "Refused Reason";
                        Cdu50009: Codeunit PRcodeunit;
                    begin
                        RecPurchasesPayablesSetup.Get();
                        IF NOT RecGUserSetup.GET(USERID) THEN
                            ERROR(Txt0001);


                        if Rec.Statut <> Rec.Statut::"To Approve" then
                            ERROR(Txt0003);

                        IF NOT CONFIRM(Txt0004) THEN
                            EXIT;
                        Clear(PageReasonRef);
                        IF PageReasonRef.RUNMODAL = ACTION::OK THEN BEGIN
                            IF PageReasonRef.GetReason() = '' THEN
                                ERROR(Txt0005);
                            Rec."Reason Refusal" := PageReasonRef.GetReason();
                            Rec.Statut := Rec.Statut::refused;
                            Rec.Modify();
                            RecPrLine.Reset();
                            RecPrLine.SetRange("Document No.", Rec."No.");
                            if RecPrLine.FindFirst() then
                                repeat
                                begin
                                    RecPrLine."Reason Refusal" := Rec."Reason Refusal";
                                    RecPrLine.Statut := RecPrLine.Statut::refused;
                                    RecPrLine.Modify();
                                end;
                                until RecPrLine.Next() = 0;

                            if RecPurchasesPayablesSetup."Envoyer Mail DA" then
                                Cdu50009.RefusNotification(Rec."User ID", Rec."No.", USERID, Rec."Reason Refusal");

                        end;
                    end;
                }



            }
        }





    }
    trigger OnOpenPage()
    var
        RecUserSetup: Record "User Setup";
        RecPurchaseSetup: Record "Purchases & Payables Setup";

    begin
        ContreollerVisibility := false;
        if RecUserSetup.Get(UserId) then begin
            if RecUserSetup.approver then
                ButtonApproVisibilty := true;
            if RecUserSetup."Réinitialiser statut à Approuver" then
                ButtonResetStatutVisibilty := true;
            if RecUserSetup."Créer Commande a partir DA" then
                ButtonApproVisibiltyCreateOrder := true;
        end;
        if Rec.Statut = Rec.Statut::refused then
            RefusualReasonVisibility := true;
        if RecPurchaseSetup.Get() then begin
            if RecPurchaseSetup."management controlleractivated" then begin
                if (RecPurchaseSetup."management controller 1" = UserId) then
                    ContreollerVisibility := true;
                if RecPurchaseSetup."management controller 2" = UserId then
                    ContreollerVisibility := true;
            end;
        end;
    end;

    var
        [InDataSet]
        ButtonResetStatutVisibilty: Boolean;
        ContreollerVisibility: Boolean;
        RecPurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Text000: label 'Fonction non exécutable en mode lecture seule.';
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesSetup: Record "Sales & Receivables Setup";
        //  ChangeExchangeRate: Form UnknownForm511;
        UserMgt: Codeunit "User Setup Management";
        "// HJ DSFT": Integer;
        RecSalesOrder: Record "Purchase Request";
        //  FMessagerieChat: Page 50103;
        //  TMessagerieChat: Record 50103;
        UserSetup: Record "User Setup";
        Text001: label 'Envoyer La Notification ?';
        LeMessage: Text[200];
        Text002: label 'Nouvelle Demande d''Achat N° %1  Envoyée par %2';
        Text003: label 'Notification Déjà Envoyée';
        Text004: label 'Statut de la DA non autorisé à imprimer';
        Text005: label 'Archiver Cette Demande d''Achat ?';
        Text006: label 'Le Statut Doit Être Supporté Pour Archiver ?';
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        NbrLigne: Integer;
        NbrLigneOrigine: Integer;
        PurchaseReqLine: Record "Purchase request Line";
        Text007: label 'Aucune ligne dans la DA.';
        Text008: label 'DA déjà engagée';
        Text009: label 'DA liée à un bon de commande';
        Text010: label 'Aucune modification autorisée, statut non ouvert';
        Text011: label 'Interdiction totale dans le module DA';
        "// RB SORO": Integer;
        PrLine: Record "Purchase request Line";
        RecPurchasesSetup: Record "Purchases & Payables Setup";
        RecLocation: Record Location;
        Text012: label 'Le champ Approuver doit être Oui dans la demande d’achat n° %1';
        Text013: label 'Vous n’êtes pas autorisé à approuver la demande d’achat n° %1';
        Text014: label 'Approbation effectuée';

        [InDataSet]
        ButtonApproVisibilty, ButtonApproVisibiltyCreateOrder : Boolean;
        [InDataSet]
        RefusualReasonVisibility: Boolean;



}

