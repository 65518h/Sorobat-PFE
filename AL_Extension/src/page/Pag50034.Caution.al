page 50034 Caution
{
    // //>>>MBK:05/02/2010: Référence chèque
    // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs

    Caption = 'Caution';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = 10865;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Général';
                field("No.1"; rec."No.")
                {
                    AssistEdit = false;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        //GL2025 IF REC.AssistEdit(xRec) THEN
                        //     CurrPage.UPDATE;


                    end;
                }
                field("Payment Class"; rec."Payment Class")
                {
                    Editable = false;
                    Lookup = false;
                }
                field("Payment Class Name"; rec."Payment Class Name")
                {
                    DrillDown = false;
                    Editable = false;
                }
                field("Status Name"; rec."Status Name")
                {
                    DrillDown = false;
                    Editable = false;
                }
                field("Currency Code1"; rec."Currency Code")
                {

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Account Type"; rec."Account Type")
                {
                    OptionCaption = 'G/L Account,Customer,Vendor,Bank Account';
                }
                field("Account No."; rec."Account No.")
                {
                }
                field("Source Code"; rec."Source Code")
                {
                }
                field(Agence; rec.Agence)
                {
                    Editable = false;
                }
                field(Utilisateur; rec.Utilisateur)
                {
                    Editable = false;
                }
                field("Validé Par"; rec."Validé Par")
                {
                    Editable = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                }
                field(TxtEtapesSuivante; TxtEtapesSuivante)
                {
                    Editable = false;
                    MultiLine = true;
                }
                field("Document Date"; rec."Document Date")
                {

                    trigger OnValidate()
                    begin
                        DocumentDateOnAfterValidate;
                    end;
                }
                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    Caption = 'Total Montant DS';
                    DecimalPlaces = 3 : 3;
                }
                field(Amount; rec.Amount)
                {
                    Caption = 'Total Montant';
                    DecimalPlaces = 3 : 3;
                }
                field(Objet; rec.Objet)
                {
                }
                field(Bénéficiaire; rec.Bénéficiaire)
                {
                }
                field("Type paiement"; rec."Type paiement")
                {
                }
                field(Qualité; rec.Qualité)
                {
                }
                field(Justificatifs; rec.Justificatifs)
                {
                }
                field("Code Recouvreur"; rec."Code Recouvreur")
                {
                }
            }
            part(Lines; 10869)
            {
                SubpageLink = "No." = FIELD("No.");
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                }
                field("Currency Code"; rec."Currency Code")
                {
                }
                field(Presentation; rec.Presentation)
                {
                }
            }
            group("Lettre De Crédit")
            {
                Caption = 'Lettre De Crédit';
                field("N° CI"; rec."N° CI")
                {
                }
                field("DATE D'EMBARQUEMENT"; rec."DATE D'EMBARQUEMENT")
                {
                }
                field("DATE D'EXPIRATION"; rec."DATE D'EXPIRATION")
                {
                }
                field("CONDITION DE VENTE"; rec."CONDITION DE VENTE")
                {
                }
                field("PORT EMBARQUEMENT"; rec."PORT EMBARQUEMENT")
                {
                }
                field("PORT DEBARQUEMENT"; rec."PORT DEBARQUEMENT")
                {
                }
                field("Mode Echéance"; rec."Mode Echéance")
                {
                }
                field("Objet Lettre"; rec."Objet Lettre")
                {
                }
                field("N° Brouillard"; rec."N° Brouillard")
                {
                }
                field(Destinataire; rec.Destinataire)
                {
                }
                field("Tomber FED"; rec."Tomber FED")
                {
                }
            }
            group(Placement)
            {
                Caption = 'Placement';
                field(TAUX; rec.TAUX)
                {
                }
                field(Durée; rec.Durée)
                {
                }
                field("Comm Bancaire"; rec."Comm Bancaire")
                {
                }
                field(Bénéficiaire1; rec.Bénéficiaire)
                {
                }
                field(Période; rec.Période)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(LETTRAGE)
            {
                Caption = 'LETTRAGE';
                Visible = false;
                action("&Application1")
                {
                    Caption = '&Application';
                    ShortCutKey = 'Maj+F9';

                    trigger OnAction()
                    var
                        PayLine: Record "Payment Line";
                    begin
                        PayLine.Reset();
                        PayLine.SetRange("No.", Rec."No.");
                        if PayLine.FindSet() then
                            CODEUNIT.Run(CODEUNIT::"Payment-Apply", PayLine);
                    end;
                }
            }
            group("&Imprimer...")
            {
                Caption = '&Imprimer...';
                Visible = false;
                action("Retenue à la source")
                {
                    Caption = 'Retenue à la source';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::Comparatif, TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }

                action("Reçu de caisse")
                {
                    Caption = 'Reçu de caisse';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"BON COMMANDE SOUROUBAT", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }

                action("Bordereau Espéce Banque")
                {
                    Caption = 'Bordereau Espéce Banque';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Suivi PV Reception", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                action("Bordereau Chèques Banque")
                {
                    Caption = 'Bordereau Chèques Banque';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Bureau Ordre", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                action("Bordereau Effets à l'encaissement")
                {
                    Caption = 'Bordereau Effets à l''encaissement';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Demande d'Appro", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                action("Bordereau Effets à l'escompte")
                {
                    Caption = 'Bordereau Effets à l''escompte';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"PV Reception", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }

                action("Ordre de paiement")
                {
                    Caption = 'Ordre de paiement';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Demande de Crédit", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                action("&Application")
                {
                    Caption = '&Application';
                    ShortCutKey = 'Maj+F9';


                    trigger OnAction()
                    var
                        PayLine: Record "Payment Line";
                    begin
                        PayLine.Reset();
                        PayLine.SetRange("No.", Rec."No.");
                        if PayLine.FindSet() then
                            CODEUNIT.Run(CODEUNIT::"Payment-Apply", PayLine);
                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Maj+Ctrl+D';

                    trigger OnAction()
                    begin
                        //GL2025   CurrPage.Lines.page.ShowDimensions;
                    end;
                }
                action(Modify)
                {
                    Caption = 'Modify';
                    Image = EditFilter;

                    trigger OnAction()
                    begin
                        //GL2025     CurrPage.Lines.page.Modify;
                    end;
                }
                action(Insert)
                {
                    Caption = 'Insert';

                    trigger OnAction()
                    var
                        PaymentManagement: Codeunit 10860;
                    begin
                        //GL2025  PaymentManagement.LinesInsert(rec."No.");
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';

                    trigger OnAction()
                    begin
                        //GL2025  CurrPage.Lines.page.Delete;
                    end;
                }

                group("A&ccount")
                {
                    Caption = 'A&ccount';
                    action(Card)
                    {
                        Caption = 'Card';
                        Image = EditLines;
                        ShortCutKey = 'Maj+F5';

                        trigger OnAction()
                        begin
                            //GL2025  CurrPage.Lines.page.ShowAccount;
                        end;
                    }
                    action("Ledger E&ntries")
                    {
                        Caption = 'Ledger E&ntries';
                        ShortCutKey = 'Ctrl+F7';

                        trigger OnAction()
                        begin
                            //GL2025  CurrPage.Lines.page.ShowEntries;
                        end;
                    }
                }
                action("Calculer Retenue à la Source")
                {
                    Caption = 'Calculer Retenue à la Source';

                    trigger OnAction()
                    begin
                        CurrPage.Lines.page.CalculerRetenu;
                    end;
                }
                action("&Actualiser")
                {
                    Caption = '&Actualiser';

                    trigger OnAction()
                    begin
                        CurrPage.Lines.page.Actualiser;
                    end;
                }

                action("Fractionner Line")
                {
                    Caption = 'Fractionner Line';

                    trigger OnAction()
                    begin
                        CurrPage.Lines.page.fractLine;
                    end;
                }

                action("Chèques mouvementés")
                {
                    Caption = 'Chèques mouvementés';

                    trigger OnAction()
                    var
                        "Chèquemouvementé_lr": Record 50038;
                        "Listchèquesmouvementés_lf": page 50042;
                    begin
                        //>>>MBK:05/02/2010: Référence chèque
                        CLEAR(Listchèquesmouvementés_lf);
                        Chèquemouvementé_lr.SETRANGE("Code banque", rec."Account No.");
                        Chèquemouvementé_lr.SETRANGE("Référence chèque", CurrPage.Lines.page.REFCHEQUE);
                        Listchèquesmouvementés_lf.SETTABLEVIEW(Chèquemouvementé_lr);
                        Listchèquesmouvementés_lf.SETRECORD(Chèquemouvementé_lr);
                        Listchèquesmouvementés_lf.RUNMODAL;
                        //<<<MBK:05/02/2010: Référence chèque
                    end;
                }
            }
            group("&Navigate")
            {
                Caption = '&Navigate';
                action(Header)
                {
                    Caption = 'Header';

                    trigger OnAction()
                    begin
                        Navigate.SetDoc(rec."Posting Date", rec."No.");
                        Navigate.RUN;
                    end;
                }
                action(Line)
                {
                    Caption = 'Line';

                    trigger OnAction()
                    var
                        PaymentLine: Record 10866;
                    begin
                        CurrPage.Lines.page.GETRECORD(PaymentLine);
                        Navigate.SetDoc(rec."Posting Date", PaymentLine."Document No.");
                        Navigate.RUN;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Lettrer)
            {
                Caption = 'Lettrer';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //GL2025   CurrPage.Lines.page.Application;
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Suggest &Vendor Payments")
                {
                    Caption = 'Suggest &Vendor Payments';
                    Image = SuggestVendorPayments;

                    trigger OnAction()
                    var
                        PaymentClass: Record 10860;
                        CreateVendorPmtSuggestion: Report 10862;
                    begin
                        IF rec."Status No." <> 0 THEN
                            MESSAGE(Text003)
                        ELSE
                            IF PaymentClass.GET(rec."Payment Class") THEN
                                IF PaymentClass.Suggestions = PaymentClass.Suggestions::Vendor THEN BEGIN
                                    //GL2025    CreateVendorPmtSuggestion.SetGenPayLine(Rec);
                                    CreateVendorPmtSuggestion.RUNMODAL;
                                    CLEAR(CreateVendorPmtSuggestion);
                                END ELSE
                                    MESSAGE(Text001);
                    end;
                }
                action("Suggest &Customer Payments")
                {
                    Caption = 'Suggest &Customer Payments';

                    trigger OnAction()
                    var
                        PaymentClass: Record 10860;
                        CreateCustomerPmtSuggestion: Report 10864;
                    begin
                        IF rec."Status No." <> 0 THEN
                            MESSAGE(Text003)
                        ELSE
                            IF PaymentClass.GET(rec."Payment Class") THEN
                                IF PaymentClass.Suggestions = PaymentClass.Suggestions::Customer THEN BEGIN
                                    //GL2025  CreateCustomerPmtSuggestion.SetGenPayLine(Rec);
                                    CreateCustomerPmtSuggestion.RUNMODAL;
                                    CLEAR(CreateCustomerPmtSuggestion);
                                END ELSE
                                    MESSAGE(Text002);
                    end;
                }
                action("Set Document ID")
                {
                    Caption = 'Set Document ID';

                    trigger OnAction()
                    begin
                        IF rec."Status No." <> 0 THEN
                            MESSAGE(Text004)
                        //GL2025  ELSE
                        //GL2025 CurrPage.Lines.page.SetDocumentID;
                    end;
                }

                action(Archive)
                {
                    Caption = 'Archive';

                    trigger OnAction()
                    var
                        Archive: Boolean;
                        PaymtManagt: Codeunit 10860;
                    begin
                        IF rec."No." = '' THEN
                            EXIT;
                        IF NOT CONFIRM(Text009) THEN
                            EXIT;
                        /*
                        CALCFIELDS("Nb of lines");
                        IF "Nb of lines" = 0 THEN
                          ERROR(Text005);
                        CALCFIELDS("Lines not Posted");
                        IF "Lines not Posted" = 0 THEN
                          Archive := CONFIRM(Text008);
                        IF "Lines not Posted" = 1 THEN
                          Archive := CONFIRM(Text006);
                        IF "Lines not Posted" > 1 THEN
                          Archive := CONFIRM(Text007);
                        IF Archive THEN
                        */
                        //GL2025   PaymtManagt.ArchiveDocument(Rec);

                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action(Printing)
                {
                    Caption = 'Printing';

                    trigger OnAction()
                    begin
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text0001);
                        Steps.SETRANGE("Payment Class", rec."Payment Class");
                        Steps.SETRANGE("Previous Status", rec."Status No.");
                        Steps.SETRANGE("Action Type", Steps."Action Type"::Report);
                        //>> HJ DSFT 09 12 2010
                        IF RecUser.GET(UPPERCASE(USERID)) THEN;
                        IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
                        //>> HJ DSFT 09 12 2010

                        //GL2025   CurrPage.Lines.page.MarkLines(TRUE);
                        ValidatePayment;
                        //GL2025  CurrPage.Lines.page.MarkLines(FALSE);
                    end;
                }
                action("Generate file")
                {
                    Caption = 'Generate file';
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text0001);
                        Steps.SETRANGE("Payment Class", rec."Payment Class");
                        Steps.SETRANGE("Previous Status", rec."Status No.");
                        Steps.SETRANGE("Action Type", Steps."Action Type"::File);
                        ValidatePayment;
                    end;
                }
                action(Validate)
                {
                    Caption = 'Validate';
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        //>>>MBK:05/02/2010: Référence chèque
                        /*
                       IF PaymentStatus_gr.GET("Payment Class","Status No.")THEN

                         IF PaymentStatus_gr."Référence Chèque" THEN
                           BEGIN
                           PaymentLine_gr.RESET;
                           Chèquemouvementé_gr.RESET;
                           PaymentLine_gr.SETRANGE("No.","No.");
                           IF PaymentLine_gr.FINDFIRST THEN
                            REPEAT
                             IF PaymentLine_gr."N° chèque" =0 THEN
                               ERROR( STRSUBSTNO (Text010 , PaymentLine_gr."Line No."));
                             Chèquemouvementé_gr.GET("Account No.", PaymentLine_gr."Référence chèque",PaymentLine_gr."N° chèque");
                             //IF Chèquemouvementé_gr.Statut=Chèquemouvementé_gr.Statut::Confirmer THEN
                               //ERROR( STRSUBSTNO (Text011 , PaymentLine_gr."N° chèque"));
                             Chèquemouvementé_gr.Statut:=Chèquemouvementé_gr.Statut::Confirmer;
                             Chèquemouvementé_gr."N° Bordereu":=PaymentLine_gr."No.";
                             Chèquemouvementé_gr."N° Ligne Bordereu":=PaymentLine_gr."Line No.";

                             Chèquemouvementé_gr.MODIFY;
                            UNTIL PaymentLine_gr.NEXT=0;
                           END;
                           */
                        //Nettoyage
                        IF PaymentStatus_gr.GET(rec."Payment Class", rec."Status No.") THEN
                            IF PaymentStatus_gr."Référence Chèque" THEN BEGIN

                                Chèquemouvementé_gr.RESET;
                                Chèquemouvementé_gr.SETRANGE("N° Bordereu", rec."No.");
                                IF Chèquemouvementé_gr.FINDFIRST THEN
                                    REPEAT
                                        IF Chèquemouvementé_gr.Statut = Chèquemouvementé_gr.Statut::Encours THEN BEGIN
                                            Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::" ";
                                            Chèquemouvementé_gr."N° Bordereu" := '';
                                            Chèquemouvementé_gr."N° Ligne Bordereu" := 0;
                                            Chèquemouvementé_gr.MODIFY;
                                        END;
                                    UNTIL Chèquemouvementé_gr.NEXT = 0;
                            END;
                        //<<<MBK:05/02/2010: Référence chèque



                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text0001);
                        Steps.SETRANGE("Payment Class", rec."Payment Class");
                        Steps.SETRANGE("Previous Status", rec."Status No.");
                        Steps.SETFILTER("Action Type", '<>%1&<>%2&<>%3', Steps."Action Type"::Report, Steps."Action Type"::File, Steps."Action Type"::
                          "Create New Document");
                        //>> HJ DSFT 09 12 2010
                        IF RecUser.GET(UPPERCASE(USERID)) THEN;
                        IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
                        //>> HJ DSFT 09 12 2010
                        ValidatePayment;
                        //IBK DSFT
                        IF PaymentStatus_gr.GET(REC."Payment Class", rec."Status No.") THEN
                            IF PaymentStatus_gr."Référence Chèque" THEN BEGIN
                                PaymentLine_gr.RESET;
                                Chèquemouvementé_gr.RESET;
                                PaymentLine_gr.SETRANGE("No.", rec."No.");
                                IF PaymentLine_gr.FINDFIRST THEN
                                    REPEAT
                                        IF PaymentLine_gr."N° chèque" = 0 THEN
                                            ERROR(STRSUBSTNO(Text010, PaymentLine_gr."Line No."));
                                        Chèquemouvementé_gr.GET(rec."Account No.", PaymentLine_gr."Référence chèque", PaymentLine_gr."N° chèque");
                                        //IF Chèquemouvementé_gr.Statut=Chèquemouvementé_gr.Statut::Confirmer THEN
                                        //ERROR( STRSUBSTNO (Text011 , PaymentLine_gr."N° chèque"));
                                        IF PaymentLine_gr."Status No." IN [1000, 3000] THEN BEGIN
                                            Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Confirmer;
                                            Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
                                            Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

                                            Chèquemouvementé_gr.MODIFY;
                                        END
                                        ELSE
                                            IF PaymentLine_gr."Status No." = 4000 THEN BEGIN
                                                Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Comptabilisé;
                                                Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
                                                Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

                                                Chèquemouvementé_gr.MODIFY;
                                            END
                                            ELSE
                                                IF PaymentLine_gr."Status No." IN [5000, 6000] THEN BEGIN
                                                    Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Annulé;
                                                    Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
                                                    Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

                                                    Chèquemouvementé_gr.MODIFY;
                                                END;

                                    UNTIL PaymentLine_gr.NEXT = 0;
                            END;
                        //IBK DSFT
                        // >> HJ DSFT 26-01-2009
                        IF RecEntetePayement.GET(rec."No.") THEN BEGIN
                            RecEntetePayement."Validé Par" := USERID;
                            RecEntetePayement.MODIFY;
                        END;
                        // << HJ DSFT 26-01-2009

                        // << HJ DSFT 17-03-2011
                        IF RecSalesReceivablesSetup.GET THEN;
                        IF RecSalesReceivablesSetup."Activer Suivi Mode Réglement" THEN BEGIN
                            RecPaymentLine.SETRANGE("No.", rec."No.");
                            IF RecPaymentLine.FINDFIRST THEN
                                REPEAT
                                    IF RecPaymentLine."Account Type" = RecPaymentLine."Account Type"::Customer THEN BEGIN
                                        IF RecCustomer.GET(RecPaymentLine."Account No.") THEN;
                                        IF RecPaymentClass.GET(rec."Payment Class") THEN;
                                        IF RecPaymentMethod2.GET(RecPaymentClass."Mode Paiement") THEN IntTypeReglement := RecPaymentMethod2.Priorité;
                                        IF RecPaymentMethod.GET(RecCustomer."Payment Method Code") THEN IntClient := RecPaymentMethod.Priorité;
                                        IF IntClient < IntTypeReglement THEN
                                            ERROR(Text0015, RecPaymentLine."Account No.",
                                                 RecCustomer."Payment Method Code", rec."Payment Class");
                                    END;
                                UNTIL RecPaymentLine.NEXT = 0;
                        END;
                        // << HJ DSFT 17-03-2011

                    end;
                }
            }
            action("...")
            {
                Caption = '...';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //>> HJ DSFT 10 12 2010
                    IF RecPaymentStatus.GET(rec."Payment Class", rec."Status No.") THEN BEGIN
                        IF NOT RecPaymentStatus."Changement Agence Permis" THEN
                            EXIT
                        ELSE BEGIN
                            IF RecPaymentStatus."Changement Agence Par" <> UPPERCASE(USERID) THEN
                                ERROR(Text014)
                            ELSE BEGIN
                                IF page.RUNMODAL(page::Sites, RecAgence) = ACTION::LookupOK THEN BEGIN
                                    RecPaymentLine.SETRANGE("No.", rec."No.");
                                    RecPaymentLine.MODIFYALL(Agence, RecAgence.Code);
                                    rec.Agence := RecAgence.Code;
                                    rec.MODIFY;
                                END;

                            END;
                        END;
                    END;
                    //>> HJ DSFT 10 12 2010
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.Lines.page.EDITABLE(TRUE);
        // << HJ DSFT 08-11-2009
        IF RecUser.Niveau = 0 THEN ERROR(Text011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        // >> HJ DSFT 08 11 2010
        TxtEtapesSuivante := 'Action : ';
        REcPaymentSteps.SETRANGE("Payment Class", rec."Payment Class");
        REcPaymentSteps.SETRANGE("Previous Status", rec."Status No.");
        IF REcPaymentSteps.FIND('-') THEN
            REPEAT
                REcPaymentSteps.CALCFIELDS("Next Status Name");
                IF (REcPaymentSteps."Action Type" = 0) OR (REcPaymentSteps."Action Type" = 1) THEN
                    TxtEtapesSuivante := TxtEtapesSuivante + ' < Valider >:' + REcPaymentSteps.Name;
                IF (REcPaymentSteps."Action Type" = 2) THEN
                    TxtEtapesSuivante := TxtEtapesSuivante + ' < Imprimer > :' + REcPaymentSteps."Next Status Name";
                IF (REcPaymentSteps."Action Type" = 3) THEN
                    TxtEtapesSuivante := TxtEtapesSuivante + ' < Fichier > :' + REcPaymentSteps."Next Status Name";
                IF (REcPaymentSteps."Action Type" = 4) THEN
                    TxtEtapesSuivante := TxtEtapesSuivante + ' < Créer Bordereau > :' + REcPaymentSteps."Next Status Name";

            UNTIL REcPaymentSteps.NEXT = 0;

        // >> HJ DSFT 08 11 2010
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // >> HJ DSFT 21-01-2009
        IF RecUser.GET(UPPERCASE(USERID)) THEN rec.Agence := RecUser.Agence;
        rec.Utilisateur := UPPERCASE(USERID);
        // << HJ DSFT 21-01-2009
    end;

    trigger OnOpenPage()
    begin
        // << HJ DSFT 21-01-2009
        RecUser.GET(UPPERCASE(USERID));
        IF RecUser.Niveau = 0 THEN ERROR(Text0011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        // << HJ DSFT 21-01-2009
    end;

    var
        ChangeExchangeRate: page 511;
        Navigate: page 344;
        Steps: Record 10862;
        Text0001: Label 'There is no line to treat.';
        Text001: Label 'This payment class does not authorize vendor suggestions.';
        Text002: Label 'This payment class does not authorize customer suggestions.';
        Text003: Label 'You cannot suggest payments on a posted header.';
        Text004: Label 'You cannot assign a number to a posted header.';
        Text005: Label 'This document has no line. You cannot archive it. You must delete it.';
        Text006: Label 'One line is not posted. Are you sure you want to archive this document ?';
        Text007: Label 'Some lines are not posted. Are you sure you want to archive this document ?';
        Text008: Label 'Are you sure you want to archive this document ?';
        Text009: Label 'Do you wish to archive this document ?';
        "-MBK-": Integer;
        PaymentStatus_gr: Record 10861;
        PaymentLine_gr: Record 10866;
        "Chèquemouvementé_gr": Record 50038;

        Text010: Label 'Veuillez saisir le N° Chèque dans la ligne %1';
        Text011: Label 'N° chèque %1 utlisé plus d''une fois';
        RecBankAccount: Record 270;
        "-HJ-": Integer;
        RecAutorisationEtapes: Record "Autorisation Etapes2";
        RecUser: Record 91;
        RecEntetePayement: Record 10865;
        RecPaymentLine: Record 10866;
        RecBank: Record 270;
        REcPaymentSteps: Record 10862;
        RecPaymentStatus: Record 10861;
        TxtEtapesSuivante: Text[1000];
        RecEntete: Record 10865;

        Text0010: Label 'Vous N''ete Pas Autorise A Cette Etape %1,  %2,  %3 ; Consulter Votre Administrateur';
        Text0011: Label 'Vous N''ete Pas Autorisé Au Module Encaissement - Decaissement';
        Text0012: Label 'Votre Agence %1 Est Différente De Celle De L''Etape ( %2 )';
        Text013: Label 'Changement Agence Non Permis A Ce Statut';
        Text014: Label 'Vous n''etes pas autoriser à Changer L''agence';
        RecAgence: Record 50039;
        RecPaymentMethod: Record 289;
        RecPaymentMethod2: Record 289;
        RecSalesReceivablesSetup: Record 311;
        RecCustomer: Record 18;
        RecPaymentClass: Record 10860;
        IntClient: Integer;
        IntTypeReglement: Integer;
        Text0015: Label 'Mode Paiement Client N° %1 ( %2 ) Ne Peut Pas Etre %3';


    procedure ValidatePayment()
    var
        Ok: Boolean;
        PostingStatement: Codeunit "Payment Management Copy";
        Options: Text[400];
        Choice: Integer;
        I: Integer;
    begin
        I := Steps.COUNT;
        Ok := FALSE;
        IF I = 1 THEN BEGIN
            Steps.FIND('-');
            Ok := CONFIRM(Steps.Name, TRUE);
        END ELSE
            IF I > 1 THEN BEGIN
                IF Steps.FIND('-') THEN BEGIN
                    REPEAT
                        IF Options = '' THEN
                            Options := Steps.Name
                        ELSE
                            Options := Options + ',' + Steps.Name;
                    UNTIL Steps.NEXT = 0;

                    Choice := STRMENU(Options, 1);

                    I := 1;
                    IF Choice > 0 THEN BEGIN
                        Ok := TRUE;
                        Steps.FIND('-');
                        WHILE Choice > I DO BEGIN
                            I += 1;
                            Steps.NEXT;
                        END;
                    END;
                END;
            END;
        // >> HJ DSFT 21-01-2009
        RecAutorisationEtapes.SETRANGE("Type Reglement", Steps."Payment Class");
        RecAutorisationEtapes.SETRANGE(Etape, Steps.Line);
        RecAutorisationEtapes.SETRANGE(User, USERID);

        IF NOT RecAutorisationEtapes.FINDFIRST THEN ERROR(Text0010, USERID, Steps."Payment Class", Steps.Line);
        // << HJ DSFT 21-01-2009
        // >> HJ DSFT 14-04-2009
        IF RecUser.GET(UPPERCASE(USERID)) THEN;
        IF RecUser.Agence <> '' THEN
            IF Steps.Agence <> '' THEN IF rec.Agence <> Steps.Agence THEN ERROR(Text0012, rec.Agence, Steps.Agence);
        // << HJ DSFT 14-04-2009

        IF Ok THEN
            //  PostingStatement.Valbord(Rec, Steps);
            PostingStatement.ProcessPaymentSteps(Rec, Steps);
    end;

    local procedure DocumentDateOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

