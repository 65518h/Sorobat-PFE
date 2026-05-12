page 50032 "Chèque Trésor"
{
    // //>>>MBK:05/02/2010: Référence chèque
    // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs
    //DYS problème declaration page 511

    Caption = 'Chèque Trésor';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = SORTING("N° Bordereau") ORDER(Ascending) WHERE("Payment Class" = FILTER('CHEQUE TRESOR'));
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    AssistEdit = false;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        /*//GL2024 License     IF rec.AssistEdit(xRec) THEN
                                 CurrPage.UPDATE; //GL2024 License*/
                    end;
                }
                field("Payment Class"; rec."Payment Class")
                {
                    ApplicationArea = all;
                    //   Editable = false;
                    Lookup = false;
                }
                field("Payment Class Name"; rec."Payment Class Name")
                {
                    ApplicationArea = all;
                    DrillDown = false;
                    Editable = false;
                }
                field("Status Name"; rec."Status Name")
                {
                    ApplicationArea = all;
                    DrillDown = false;
                    Editable = false;
                }
                field("Currency Code1"; rec."Currency Code")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        //DYS problème declaration page 511
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
                    ApplicationArea = all;
                    //  OptionCaption = 'G/L Account,Customer,Vendor,Bank Account';
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = all;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = all;
                }
                field(Agence; rec.Agence)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Utilisateur; rec.Utilisateur)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Validé Par"; rec."Validé Par")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }

                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        DocumentDateOnAfterValidate;
                    end;
                }
                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Total Montant DS';
                    DecimalPlaces = 3 : 3;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Caption = 'Total Montant';
                    DecimalPlaces = 3 : 3;
                }
                field(Objet; rec.Objet)
                {
                    ApplicationArea = all;
                }
                field(Bénéficiaire; rec.Bénéficiaire)
                {
                    ApplicationArea = all;
                }
                field("Type paiement"; rec."Type paiement")
                {
                    ApplicationArea = all;
                }
                field(Qualité; rec.Qualité)
                {
                    ApplicationArea = all;
                }
                field(Justificatifs; rec.Justificatifs)
                {
                    ApplicationArea = all;
                }
                field("Code Recouvreur"; rec."Code Recouvreur")
                {
                    ApplicationArea = all;
                }
                field(TxtEtapesSuivante; TxtEtapesSuivante)
                {
                    ApplicationArea = all;
                    Editable = false;
                    MultiLine = true;
                }
            }
            part(Lines; "Payment Slip Subform")
            {
                ApplicationArea = all;
                Caption = 'Payment Slip Subform';
                SubPageLink = "No." = FIELD("No.");
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Presentation; rec.Presentation)
                {
                    ApplicationArea = all;
                }
            }
            group("Lettre De Crédit")
            {
                Caption = 'Letter of Credit';
                field("N° CI"; rec."N° CI")
                {
                    ApplicationArea = all;
                }
                field("DATE D'EMBARQUEMENT"; rec."DATE D'EMBARQUEMENT")
                {
                    ApplicationArea = all;
                }
                field("DATE D'EXPIRATION"; rec."DATE D'EXPIRATION")
                {
                    ApplicationArea = all;
                }
                field("CONDITION DE VENTE"; rec."CONDITION DE VENTE")
                {
                    ApplicationArea = all;
                }
                field("PORT EMBARQUEMENT"; rec."PORT EMBARQUEMENT")
                {
                    ApplicationArea = all;
                }
                field("PORT DEBARQUEMENT"; rec."PORT DEBARQUEMENT")
                {
                    ApplicationArea = all;
                }
                field("Mode Echéance"; rec."Mode Echéance")
                {
                    ApplicationArea = all;
                }
                field("Objet Lettre"; rec."Objet Lettre")
                {
                    ApplicationArea = all;
                }
                field("N° Brouillard"; rec."N° Brouillard")
                {
                    ApplicationArea = all;
                }
                field(Destinataire; rec.Destinataire)
                {
                    ApplicationArea = all;
                }
                field("Tomber FED"; rec."Tomber FED")
                {
                    ApplicationArea = all;
                }
            }
            group(Placement)
            {
                Caption = 'Placement';
                field(TAUX; rec.TAUX)
                {
                    ApplicationArea = all;
                }
                field(Durée; rec.Durée)
                {
                    ApplicationArea = all;
                }
                field("Comm Bancaire"; rec."Comm Bancaire")
                {
                    ApplicationArea = all;
                }
                field(Bénéficiaire2; rec.Bénéficiaire)
                {
                    ApplicationArea = all;
                }
                field(Période; rec.Période)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {

            group("Imprimer1")
            {
                Caption = 'Print';
                actionref("Retenue à la source1"; "Retenue à la source")
                {
                }

                actionref("Reçu de caisse1"; "Reçu de caisse")
                {
                }

                actionref("Bordereau Espéce Banque1"; "Bordereau Espéce Banque")

                {
                }


                actionref("Bordereau Chèques Banque1"; "Bordereau Chèques Banque")

                {
                }

                actionref("Bordereau Effets à l'encaissement1"; "Bordereau Effets à l'encaissement")

                {
                }

                actionref("Bordereau Effets à l'escompte1"; "Bordereau Effets à l'escompte")

                {
                }

                actionref("Ordre de paiement1"; "Ordre de paiement")
                {
                }

            }



            group("Line2")
            {
                Caption = 'Line';
                group("Account")
                {
                    Caption = 'Account';
                    actionref("Calculer Retenue à la Source1"; "Calculer Retenue à la Source")
                    { }
                    actionref("&Actualiser1"; "&Actualiser")
                    { }

                    actionref("Fractionner Line1"; "Fractionner Line")
                    { }

                    actionref("Chèques mouvementés1"; "Chèques mouvementés")
                    { }
                }
            }
            group("Navigate")
            {
                Caption = 'Navigate';
                actionref(Header1; Header)
                { }

                actionref(Line1; Line)

                { }
            }
            group("Functions1")
            {
                Caption = 'Functions';
                actionref("Suggest &Vendor Payments1"; "Suggest &Vendor Payments")
                { }

                actionref("Suggest &Customer Payments1"; "Suggest &Customer Payments")
                { }

                actionref(Archive1; Archive)
                { }

            }

            group("P&osting1")
            {
                Caption = 'Posting';
                actionref(Printing1; Printing)
                { }

                actionref("Generate file1"; "Generate file")
                { }

                actionref(Validate1; Validate)
                { }
            }
            actionref("...."; "...")
            { }



        }
        area(navigation)
        {
            //DYS fonction deplacer dans ligne
            /*   group(LETTRAGE)
               {
                   Caption = 'Lettering';
                   Visible = false;
                   action("&Application")
                   {
                       ApplicationArea = all;
                       Caption = '&Application';
                       ShortCutKey = 'Maj+F11';

                       trigger OnAction()
                       begin
                           CurrPage.Lines.page.Application;
                       end;
                   }
               }
               */
            group("&Imprimer...")
            {
                Caption = '&Print...';
                Visible = false;
                action("Retenue à la source")
                {
                    ApplicationArea = all;
                    Caption = 'Withholding tax';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::Comparatif, TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                separator(separator100)
                {
                }
                action("Reçu de caisse")
                {
                    ApplicationArea = all;
                    Caption = 'Cash Receipt';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"BON COMMANDE SOUROUBAT", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                separator(separator200)
                {
                }
                action("Bordereau Espéce Banque")
                {
                    ApplicationArea = all;
                    Caption = 'Payment Cash Bank';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Suivi PV Reception", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                action("Bordereau Chèques Banque")
                {
                    ApplicationArea = all;
                    Caption = 'Payment Bank Checks';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Documents Bureau D'ordre", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                action("Bordereau Effets à l'encaissement")
                {
                    ApplicationArea = all;
                    Caption = 'Payment Effects on collection';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Demande d'Appro", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                action("Bordereau Effets à l'escompte")
                {
                    ApplicationArea = all;
                    Caption = 'Payment Discount effects';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"PV Reception", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                separator(separator900)
                {
                }
                action("Ordre de paiement")
                {
                    Caption = 'Payment order';
                    ApplicationArea = all;
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
                //DYS fonction deplacer dans ligne
                /*  action("&Application2")
                  {
                      Caption = '&Application';
                      ShortCutKey = 'Maj+F11';
                      ApplicationArea = all;
                      trigger OnAction()
                      begin

                          CurrPage.Lines.Page.Application;

                      end;
                  }
                  action(Dimensions)
                  {
                      Caption = 'Dimensions';
                      Image = Dimensions;
                      ShortCutKey = 'Maj+Ctrl+D';
                      ApplicationArea = all;
                      trigger OnAction()
                      begin
                          CurrPage.Lines.Page.ShowDimensions;

                      end;
                  }
                  action(Modify)
                  {
                      Caption = 'Modify';
                      Image = EditFilter;
                      ApplicationArea = all;
                      trigger OnAction()
                      begin
                          CurrPage.Lines.Page.Modify;
                      end;
                  }
                  action(Insert)
                  {
                      Caption = 'Insert';
                      ApplicationArea = all;
                      trigger OnAction()
                      var
                          PaymentManagement: Codeunit 10860;
                      begin
                          PaymentManagement.LinesInsert(rec."No.");
                      end;
                  }
                  action(Remove)
                  {
                      Caption = 'Remove';
                      ApplicationArea = all;
                      trigger OnAction()
                      begin
                          CurrPage.Lines.Page.Delete;
                      end;
                  }*/
                separator(separator300)
                {
                }
                group("A&ccount")
                {
                    Caption = 'A&ccount';
                    //DYS fonction deplacer dans ligne
                    /* action(Card)
                     {
                         ApplicationArea = all;
                         Caption = 'Card';
                         Image = EditLines;
                         ShortCutKey = 'Maj+F7';

                         trigger OnAction()
                         begin
                             CurrPage.Lines.Page.ShowAccount;

                         end;
                     }
                     action("Ledger E&ntries")
                     {
                         ApplicationArea = all;
                         Caption = 'Ledger E&ntries';
                         ShortCutKey = 'Ctrl+F7';

                         trigger OnAction()
                         begin
                             CurrPage.Lines.Page.ShowEntries;

                         end;
                     }*/
                }
                action("Calculer Retenue à la Source")
                {
                    ApplicationArea = all;
                    Caption = 'Calculate Withholding Tax';

                    trigger OnAction()
                    begin
                        CurrPage.Lines.Page.CalculerRetenu;
                    end;
                }
                action("&Actualiser")
                {
                    Caption = '&Refresh';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        CurrPage.Lines.Page.Actualiser;
                    end;
                }
                separator(separator400)
                {
                }
                action("Fractionner Line")
                {
                    ApplicationArea = all;
                    Caption = 'Split Line';

                    trigger OnAction()
                    begin
                        CurrPage.Lines.Page.fractLine;
                    end;
                }
                separator(separator500)
                {
                }
                action("Chèques mouvementés")
                {
                    ApplicationArea = all;
                    Caption = 'Chèques mouvementés';

                    trigger OnAction()
                    var
                        "Chèquemouvementé_lr": Record "Chèque mouvementé";
                        "Listchèquesmouvementés_lf": Page "List chèques mouvementés";
                    begin
                        //>>>MBK:05/02/2010: Référence chèque
                        CLEAR(Listchèquesmouvementés_lf);
                        Chèquemouvementé_lr.SETRANGE("Code banque", rec."Account No.");
                        Chèquemouvementé_lr.SETRANGE("Référence chèque", CurrPage.Lines.Page.REFCHEQUE);
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
                    ApplicationArea = all;
                    Caption = 'Header';

                    trigger OnAction()
                    begin
                        Navigate.SetDoc(rec."Posting Date", rec."No.");
                        Navigate.RUN;
                    end;
                }
                action(Line)
                {
                    ApplicationArea = all;
                    Caption = 'Line';

                    trigger OnAction()
                    var
                        PaymentLine: Record "Payment Line";
                    begin
                        CurrPage.Lines.Page.GETRECORD(PaymentLine);
                        Navigate.SetDoc(rec."Posting Date", PaymentLine."Document No.");
                        Navigate.RUN;
                    end;
                }
            }
        }
        area(processing)
        {
            //DYS fonction deplacer dans ligne
            /*    action(Lettrer)
                {
                    ApplicationArea = all;
                    Caption = 'Lettrer';
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CurrPage.Lines.Page.Application;

                    end;
                }*/
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Suggest &Vendor Payments")
                {
                    ApplicationArea = all;
                    Caption = 'Suggest &Vendor Payments';
                    Image = SuggestVendorPayments;

                    trigger OnAction()
                    var
                        PaymentClass: Record "Payment Class";
                        CreateVendorPmtSuggestion: Report "Suggest Vendor Payments FR";
                    begin
                        IF rec."Status No." <> 0 THEN
                            MESSAGE(Text003)
                        ELSE
                            IF PaymentClass.GET(rec."Payment Class") THEN
                                IF PaymentClass.Suggestions = PaymentClass.Suggestions::Vendor THEN BEGIN
                                    //GL2024 License     CreateVendorPmtSuggestion.SetGenPayLine(Rec);
                                    CreateVendorPmtSuggestion.RUNMODAL;
                                    CLEAR(CreateVendorPmtSuggestion);
                                END ELSE
                                    MESSAGE(Text001);
                    end;
                }
                action("Suggest &Customer Payments")
                {
                    ApplicationArea = all;
                    Caption = 'Suggest &Customer Payments';

                    trigger OnAction()
                    var
                        PaymentClass: Record "Payment Class";
                        CreateCustomerPmtSuggestion: Report "Suggest Customer Payments";
                    begin
                        IF rec."Status No." <> 0 THEN
                            MESSAGE(Text003)
                        ELSE
                            IF PaymentClass.GET(rec."Payment Class") THEN
                                IF PaymentClass.Suggestions = PaymentClass.Suggestions::Customer THEN BEGIN
                                    //GL2024 License  CreateCustomerPmtSuggestion.SetGenPayLine(Rec);
                                    CreateCustomerPmtSuggestion.RUNMODAL;
                                    CLEAR(CreateCustomerPmtSuggestion);
                                END ELSE
                                    MESSAGE(Text002);
                    end;
                }
                //DYS fonction deplacer dans ligne
                /* action("Set Document ID")
                 {
                     ApplicationArea = all;
                     Caption = 'Set Document ID';

                     trigger OnAction()
                     begin
                         IF rec."Status No." <> 0 THEN
                             MESSAGE(Text004)
                         ELSE
                             CurrPage.Lines.Page.SetDocumentID;

                     end;
                 }*/
                separator(separator600)
                {
                }
                action(Archive)
                {
                    ApplicationArea = all;
                    Caption = 'Archive';

                    trigger OnAction()
                    var
                        Archive: Boolean;
                        PaymtManagt: Codeunit "Payment Management";
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
                        //GL2024 License   PaymtManagt.ArchiveDocument(Rec);
                        //GL2024 License
                        ArchiveDocument2(Rec);
                        //GL2024 License

                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action(Printing)
                {
                    ApplicationArea = all;
                    Caption = 'Printing';

                    trigger OnAction()
                    var
                        Text1: Label 'There is no line to treat.';
                    begin
                        //GL2024 License  rec.TestNbOfLines;
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text1);
                        Steps.SETRANGE("Payment Class", rec."Payment Class");
                        Steps.SETRANGE("Previous Status", rec."Status No.");
                        Steps.SETRANGE("Action Type", Steps."Action Type"::Report);
                        //>> HJ DSFT 09 12 2010
                        IF RecUser.GET(UPPERCASE(USERID)) THEN;
                        IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
                        //>> HJ DSFT 09 12 2010

                        //GL2024 License   CurrPage.Lines.Page.MarkLines(TRUE);
                        ValidatePayment;
                        //GL2024 License   CurrPage.Lines.Page.MarkLines(FALSE);
                    end;
                }
                action("Generate file")
                {
                    ApplicationArea = all;
                    Caption = 'Generate file';
                    Visible = false;

                    trigger OnAction()
                    var
                        Text1: Label 'There is no line to treat.';
                    begin
                        //GL2024 License      rec.TestNbOfLines;
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text1);
                        Steps.SETRANGE("Payment Class", rec."Payment Class");
                        Steps.SETRANGE("Previous Status", rec."Status No.");
                        Steps.SETRANGE("Action Type", Steps."Action Type"::File);
                        ValidatePayment;
                    end;
                }
                action(Validate)
                {
                    ApplicationArea = all;
                    Caption = 'Validate';
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        Text1: Label 'There is no line to treat.';
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



                        //GL2024 License  rec.TestNbOfLines;
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text1);
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
                        IF PaymentStatus_gr.GET(rec."Payment Class", rec."Status No.") THEN
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
                ApplicationArea = all;
                Caption = '...';


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
        CurrPage.Lines.Page.EDITABLE(TRUE);
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
    var
        NoSeries: Codeunit "No. Series";
        PaymentClass: Record "Payment Class";
        NoSeriesManagement: Codeunit NoSeriesManagement;


        IsHandled: Boolean;
    begin
        // >> HJ DSFT 21-01-2009
        IF RecUser.GET(UPPERCASE(USERID)) THEN rec.Agence := RecUser.Agence;
        rec.Utilisateur := UPPERCASE(USERID);
        // << HJ DSFT 21-01-2009
        //GL2024
        if PaymentClass.Get(rec."Payment Class") then;
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(PaymentClass."Header No. Series", xRec."No. Series", 0D, rec."No.", rec."No. Series", IsHandled);
        if not IsHandled then begin

            rec."No. Series" := PaymentClass."Header No. Series";
            if NoSeries.AreRelated(rec."No. Series", xRec."No. Series") then
                rec."No. Series" := xRec."No. Series";
            rec."No." := NoSeries.GetNextNo(rec."No. Series");

            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(rec."No. Series", PaymentClass."Header No. Series", 0D, rec."No.");
        end;
        //GL2024
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
        //DYS
        ChangeExchangeRate: Page "Change Exchange Rate";
        Navigate: Page Navigate;
        Steps: Record "Payment Step";
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
        PaymentStatus_gr: Record "Payment Status";
        PaymentLine_gr: Record "Payment Line";
        "Chèquemouvementé_gr": Record "Chèque mouvementé";
        Text010: Label 'Please enter the Check Number in line %1.';
        Text011: Label 'Check Number %1 used more than once.';
        RecBankAccount: Record "Bank Account";

        RecAutorisationEtapes: Record "Autorisation Etapes2";
        RecUser: Record "User Setup";
        RecEntetePayement: Record "Payment Header";
        RecPaymentLine: Record "Payment Line";
        RecBank: Record "Bank Account";
        REcPaymentSteps: Record "Payment Step";
        RecPaymentStatus: Record "Payment Status";
        TxtEtapesSuivante: Text[1000];
        RecEntete: Record "Payment Header";

        Text0010: Label 'You are not authorized for this step %1, %2, %3; please consult your administrator.';
        Text0011: Label 'You are not authorized for the Cash Receipt - Disbursement module.';
        Text0012: Label 'Your agency %1 is different from the one in the step (%2).';
        Text013: Label 'Agency change not allowed at this status.';
        Text014: Label 'You are not authorized to change the agency.';
        RecAgence: Record Agence;
        RecPaymentMethod: Record "Payment Method";
        RecPaymentMethod2: Record "Payment Method";
        RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
        RecCustomer: Record Customer;
        RecPaymentClass: Record "Payment Class";
        IntClient: Integer;
        IntTypeReglement: Integer;
        Text0015: Label 'Customer Payment Method No. %1 (%2) Cannot Be %3';


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
            //GL2024     Ok := CONFIRM(Steps.Name, TRUE);
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

        //GL2024    IF Ok THEN
        Steps.SetFilter(
                                  "Action Type",
                                  '%1|%2|%3',
                                  Steps."Action Type"::None, Steps."Action Type"::Ledger, Steps."Action Type"::"Cancel File");
        //GL2024   PostingStatement.Valbord(Rec, Steps);
        PostingStatement.ProcessPaymentSteps(Rec, Steps);
    end;

    local procedure DocumentDateOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
    //GL2024 License
    procedure ArchiveDocument2(Document: Record "Payment Header")
    var
        ArchiveHeader: Record "Payment Header Archive";
        ArchiveLine: Record "Payment Line Archive";
        PaymentLine: Record "Payment Line";
        Text022: Label 'The status of document %1 does not authorize archiving.';
    begin
        Document.CalcFields("Archiving Authorized");
        if not Document."Archiving Authorized" then
            Error(Text022, Document."No.");
        ArchiveHeader.TransferFields(Document);
        ArchiveHeader.Insert();
        Document.Delete();
        PaymentLine.SetRange("No.", Document."No.");
        if PaymentLine.Find('-') then
            repeat
                ArchiveLine.TransferFields(PaymentLine);
                ArchiveLine.Insert();
                PaymentLine.Delete();
            until PaymentLine.Next() = 0;
    end;
    //GL2024 License


    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Payment Class" := 'CHEQUE TRESOR';
    end;
}

