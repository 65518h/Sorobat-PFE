page 50363 "Caisse Chantier Validé"
{
    //GL2024 NEW PAGE

    Caption = 'Caisse Chantier Validé';
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Class" = CONST('CAISSEEXT'), Valider = CONST(true), "Caisse Chantier" = CONST(false), "N° Affaire" = FILTER(<> 'ADMINISTRATION'));
    ApplicationArea = All;

    layout
    {
        area(content)
        {

            field("No."; REC."No.")
            {
                ApplicationArea = All;
                Caption = 'N° Document';
                Editable = false;
                Style = Unfavorable;
                StyleExpr = TRUE;
            }
            field(Chantier; Rec.Chantier)
            {
                ApplicationArea = all;
                Style = Strong;
                StyleExpr = TRUE;

            }
            field("Document Date"; REC."Document Date")
            {
                ApplicationArea = All;
                Caption = 'Journée';
            }
            field("Account No."; REC."Account No.")
            {
                ApplicationArea = All;
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
            }

            field("Payment Class"; REC."Payment Class")
            {
                ApplicationArea = All;
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field(Valider; REC.Valider)
            {
                ApplicationArea = All;
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("Validé Par"; REC."Validé Par")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("N° Affaire"; rec."N° Affaire")
            {
                ApplicationArea = all;
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;


            }

            // Group("Solde Caisse OACA1")
            // {
            //     Visible = AffaireAEROPJERBAMATMATA;
            //     ShowCaption = false;
            //     field("Solde Caisse OACA"; rec."Solde Caisse OACA")
            //     {
            //         ApplicationArea = all;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;
            //         Caption = 'Solde Caisse OACA';

            //         Editable = false;
            //     }
            // }
            // Group("Solde Caisse RFR1")
            // {
            //     Visible = AffairePENETRANTELOT2;
            //     ShowCaption = false;
            //     field("Solde Caisse RFR"; Rec."Solde Caisse RFR")
            //     {
            //         ApplicationArea = all;
            //         Caption = 'Solde Caisse RFR';
            //         Editable = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;

            //     }

            // }
            // Group("Solde Caisse PENETRANTE1")
            // {
            //     Visible = AffairePENETRANTELOT3;
            //     ShowCaption = false;
            //     field("Solde Caisse PENETRANTE"; Rec."Solde Caisse PENETRANTE")
            //     {
            //         ApplicationArea = all;
            //         Caption = 'Solde Caisse PENETRANTE';
            //         Editable = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;

            //     }
            // }
            // Group("Solde Caisse Bizerte Aerop1")
            // {
            //     Visible = AffaireBIZERTE_BASE_AERIEN;
            //     ShowCaption = false;
            //     field("Solde Caisse Bizerte Aerop"; Rec."Solde Caisse Bizerte Aerop")
            //     {
            //         ApplicationArea = all;
            //         Caption = 'Solde Caisse Bizerte Aerop';
            //         Editable = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;

            //     }
            // }
            // Group("Solde Caisse Bizerte Lot11")
            // {
            //     Visible = AffairePONT_BIZERTELOT1;
            //     ShowCaption = false;
            //     field("Solde Caisse Bizerte Lot1"; Rec."Solde Caisse Bizerte Lot1")
            //     {
            //         ApplicationArea = all;
            //         Caption = 'Solde Caisse Bizerte Lot1';
            //         Editable = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;

            //     }
            // }
            // Group("Solde Caisse RAOUED RP21")
            // {
            //     Visible = AffairePORTFINARAOUEDRP2;
            //     ShowCaption = false;
            //     field("Solde Caisse RAOUED RP2"; Rec."Solde Caisse RAOUED RP2")
            //     {
            //         ApplicationArea = all;
            //         Caption = 'Solde Caisse RAOUED RP2';
            //         Editable = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;

            //     }
            // }
            // Group("Solde Caisse SBIKHA LOT51")
            // {
            //     Visible = AffaireAUTOROUTESBIKHALO5;
            //     ShowCaption = false;
            //     field("Solde Caisse SBIKHA LOT5"; Rec."Solde Caisse SBIKHA LOT5")
            //     {
            //         ApplicationArea = all;
            //         Caption = 'Solde Caisse SBIKHA LOT5';
            //         Editable = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;

            //     }
            // }
            // Group("Solde Caisse KEF RR1731")
            // {
            //     Visible = AffaireCHANTIERKEFRR173;
            //     ShowCaption = false;

            //     field("Solde Caisse KEF RR173"; Rec."Solde Caisse KEF RR173")
            //     {
            //         ApplicationArea = all;
            //         Caption = 'Solde Caisse KEF RR173';
            //         Editable = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;

            //     }
            // }
            // Group("Solde Caisse JOUMINE1")
            // {
            //     Visible = AffaireOUEDJOUMINEMATEUR;
            //     ShowCaption = false;

            //     field("Solde Caisse JOUMINE"; Rec."Solde Caisse JOUMINE")
            //     {

            //         ApplicationArea = all;
            //         Caption = 'Solde Caisse JOUMINE';
            //         Editable = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;

            //     }
            // }




            // part(Lines; "Ligne Paiement Caisse")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            //     SubPageLink = "No." = FIELD("No.");
            //     SubPageView = WHERE("Validé Caisse" = CONST(true));
            // }
            field("Amount (LCY)"; REC."Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Montant Journée';
                Enabled = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref("Imprimer Bon1"; "Imprimer Bon") { }
            actionref("Imprimer Journée De Caisse1"; "Imprimer Journée De Caisse") { }

            group("F&onction")
            {
                Caption = 'F&onction';
                actionref(Insertion1; Insertion) { }
                actionref(Printing1; Printing) { }
                actionref("Generate file1"; "Generate file") { }
                actionref(Valider21; Valider2) { }
                actionref("Réouvrir1"; "Réouvrir") { }
                actionref(Validate1; Validate) { }
                actionref("Avance Et Prêt1"; "Avance Et Prêt") { }
                actionref("Detail Brouillard1"; "Detail Brouillard") { }
            }
        }
        area(processing)
        {
            action("Imprimer Bon")
            {
                ApplicationArea = All;
                Caption = 'Imprimer Bon';


                trigger OnAction()
                begin
                    //  CurrPage.Lines.PAGE.GETRECORD(Line);


                    PaymentLine2.SETRANGE(PaymentLine2."No.", Line."No.");
                    PaymentLine2.SETRANGE(PaymentLine2."Numero Seq", Line."Numero Seq");
                    IF Line.Provisoire = TRUE THEN
                        REPORT.RUN(50214, TRUE, TRUE, PaymentLine2)
                    // ELSE
                    // IF Line.Avance = TRUE THEN BEGIN
                    //     REPORT.RUN(50217, TRUE, TRUE, PaymentLine2);
                    // END;
                end;
            }
            action("Imprimer Journée De Caisse")
            {
                ApplicationArea = All;
                Caption = 'Imprimer Journée De Caisse';


                trigger OnAction()
                begin
                    PaymentLine.SETRANGE("No.", REC."No.");
                    REPORT.RUNMODAL(REPORT::"Brouillard de Caisse", TRUE, TRUE, PaymentLine);
                end;
            }
            group("P&osting")
            {
                Caption = 'F&onction';
                action(Insertion)
                {
                    ApplicationArea = All;
                    Caption = 'Insertion';

                    trigger OnAction()
                    begin
                        IF GeneralLedgerSetup.GET THEN;
                        IF NOT CONFIRM(Text016) THEN EXIT;
                        RecEntetePayement.INIT;
                        //   IF RecPaymentClass.GET(GeneralLedgerSetup."Type Caisse Ex") THEN;
                        RecEntetePayement."No." := NoSeriesMgt.GetNextNo(RecPaymentClass."Header No. Series", 0D, TRUE);
                        RecEntetePayement.VALIDATE("Posting Date", TODAY);
                        RecEntetePayement.VALIDATE("Document Date", TODAY);
                        //   RecEntetePayement.VALIDATE("Payment Class", GeneralLedgerSetup."Type Caisse Ex");
                        RecEntetePayement.VALIDATE("Account Type", RecEntetePayement."Account Type"::"Bank Account");
                        //  RecEntetePayement.VALIDATE("Account No.", GeneralLedgerSetup.Caisse);
                        RecEntetePayement."Date Création" := CURRENTDATETIME;
                        RecEntetePayement."Créer par" := COPYSTR(USERID, 1, 20);
                        RecEntetePayement.Utilisateur := COPYSTR(USERID, 1, 20);
                        RecEntetePayement.INSERT;
                        IF REC.FINDLAST THEN;
                    end;
                }
                action(Printing)
                {
                    Caption = 'Imprimer';

                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        Text1: Label 'There is no line to treat.';
                    begin
                        //REC.TestNbOfLines;
                        //GL2024 License
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text1);
                        //GL2024 License
                        Steps.SETRANGE("Payment Class", REC."Payment Class");
                        Steps.SETRANGE("Previous Status", REC."Status No.");
                        Steps.SETRANGE("Action Type", Steps."Action Type"::Report);
                        //>> HJ DSFT 09 12 2010
                        IF RecUser.GET(UPPERCASE(USERID)) THEN;
                        IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
                        //>> HJ DSFT 09 12 2010

                        //  CurrPage.Lines.PAGE.MarkLines(TRUE);
                        ValidatePayment;
                        //  CurrPage.Lines.PAGE.MarkLines(FALSE);
                    end;
                }
                action("Generate file")
                {
                    ApplicationArea = All;
                    Caption = 'Générer fichier';
                    Visible = false;

                    trigger OnAction()
                    var
                        Text1: Label 'There is no line to treat.';
                    begin
                        //REC.TestNbOfLines;
                        //GL2024 License
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text1);
                        //GL2024 License
                        Steps.SETRANGE("Payment Class", REC."Payment Class");
                        Steps.SETRANGE("Previous Status", REC."Status No.");
                        Steps.SETRANGE("Action Type", Steps."Action Type"::File);
                        ValidatePayment;
                    end;
                }
                action(Valider2)
                {
                    ApplicationArea = All;
                    Caption = 'Valider';
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF REC.Valider = TRUE THEN ERROR(Text019);
                        IF NOT CONFIRM(Text017, FALSE) THEN EXIT;
                        REC."Status No." := 10000;
                        REC."Status Name" := 'VALIDER';
                        REC.Valider := TRUE;
                        REC."Validé Par" := UPPERCASE(USERID);
                        REC.MODIFY;
                        MESSAGE(Text018);
                        PaymentLine2.RESET;

                        PaymentLine2.SETRANGE(PaymentLine2."No.", REC."No.");
                        IF PaymentLine2.FINDFIRST THEN
                            REPEAT
                                PaymentLine2."Validé Caisse" := TRUE;
                                PaymentLine2.MODIFY;
                            UNTIL PaymentLine2.NEXT = 0;
                    end;
                }
                action("Réouvrir")
                {
                    ApplicationArea = All;
                    Caption = 'Réouvrir';

                    trigger OnAction()
                    begin
                        IF REC.Valider = FALSE THEN ERROR(Text022);
                        IF NOT CONFIRM(Text020, FALSE) THEN EXIT;
                        REC."Status No." := 10000;
                        REC.Valider := FALSE;
                        REC."Validé Par" := '';
                        REC.MODIFY;
                        MESSAGE(Text021);

                        PaymentLine2.RESET;
                        PaymentLine2.SETRANGE(PaymentLine2."No.", REC."No.");
                        IF PaymentLine2.FINDFIRST THEN
                            REPEAT
                                PaymentLine2."Validé Caisse" := FALSE;
                                PaymentLine2.MODIFY;
                            UNTIL PaymentLine2.NEXT = 0;
                    end;
                }
                action(Validate)
                {
                    ApplicationArea = All;
                    Caption = 'Valider';
                    ShortCutKey = 'F9';
                    Visible = false;

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
                        IF PaymentStatus_gr.GET(REC."Payment Class", REC."Status No.") THEN
                            IF PaymentStatus_gr."Référence Chèque" THEN BEGIN

                                Chèquemouvementé_gr.RESET;
                                Chèquemouvementé_gr.SETRANGE("N° Bordereu", REC."No.");
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



                        //REC.TestNbOfLines;
                        //GL2024 License
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text1);
                        //GL2024 License
                        Steps.SETRANGE("Payment Class", REC."Payment Class");
                        Steps.SETRANGE("Previous Status", REC."Status No.");
                        Steps.SETFILTER("Action Type", '<>%1&<>%2&<>%3', Steps."Action Type"::Report, Steps."Action Type"::File, Steps."Action Type"::
                          "Create New Document");
                        //>> HJ DSFT 09 12 2010
                        IF RecUser.GET(UPPERCASE(USERID)) THEN;
                        IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
                        //>> HJ DSFT 09 12 2010
                        ValidatePayment;
                        //IBK DSFT
                        IF PaymentStatus_gr.GET(REC."Payment Class", REC."Status No.") THEN
                            IF PaymentStatus_gr."Référence Chèque" THEN BEGIN
                                PaymentLine_gr.RESET;
                                Chèquemouvementé_gr.RESET;
                                PaymentLine_gr.SETRANGE("No.", REC."No.");
                                IF PaymentLine_gr.FINDFIRST THEN
                                    REPEAT
                                        IF PaymentLine_gr."N° chèque" = 0 THEN
                                            ERROR(STRSUBSTNO(Text010, PaymentLine_gr."Line No."));
                                        Chèquemouvementé_gr.GET(REC."Account No.", PaymentLine_gr."Référence chèque", PaymentLine_gr."N° chèque");
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
                        IF RecEntetePayement.GET(REC."No.") THEN BEGIN
                            RecEntetePayement."Validé Par" := USERID;
                            RecEntetePayement.MODIFY;
                        END;
                        // << HJ DSFT 26-01-2009

                        // << HJ DSFT 17-03-2011
                        IF RecSalesReceivablesSetup.GET THEN;
                        IF RecSalesReceivablesSetup."Activer Suivi Mode Réglement" THEN BEGIN
                            RecPaymentLine.SETRANGE("No.", REC."No.");
                            IF RecPaymentLine.FINDFIRST THEN
                                REPEAT
                                    IF RecPaymentLine."Account Type" = RecPaymentLine."Account Type"::Customer THEN BEGIN
                                        IF RecCustomer.GET(RecPaymentLine."Account No.") THEN;
                                        IF RecPaymentClass.GET(REC."Payment Class") THEN;
                                        IF RecPaymentMethod2.GET(RecPaymentClass."Mode Paiement") THEN IntTypeReglement := RecPaymentMethod2.Priorité;
                                        IF RecPaymentMethod.GET(RecCustomer."Payment Method Code") THEN IntClient := RecPaymentMethod.Priorité;
                                        IF IntClient < IntTypeReglement THEN
                                            ERROR(Text0015, RecPaymentLine."Account No.",
                                                 RecCustomer."Payment Method Code", REC."Payment Class");
                                    END;
                                UNTIL RecPaymentLine.NEXT = 0;
                        END;
                        // << HJ DSFT 17-03-2011

                    end;
                }
                action("Avance Et Prêt")
                {
                    ApplicationArea = All;
                    Caption = 'Avance Et Prêt';

                    trigger OnAction()
                    begin
                        //  CurrPage.Lines.PAGE.AfficherAvancePret;
                    end;
                }
                action("Detail Brouillard")
                {
                    ApplicationArea = All;
                    Caption = 'Detail Brouillard';
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        //  NumSequence := CurrPage.Lines.PAGE.GetNumSeq;
                        //  DetailBrouillard.RESET;
                        //   DetailBrouillard.SETRANGE("Order N°", NumSequence);
                        //PAGE.RUNMODAL(PAGE::"Detail Brouillard de Caisse", DetailBrouillard);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // CurrPage.Lines.PAGE.EDITABLE(TRUE);
        IF REC.Valider = TRUE THEN BEGIN
            CurrPage.EDITABLE(FALSE);
            //  CurrPage.Lines.PAGE.EDITABLE(FALSE);
        END
        ELSE
            CurrPage.EDITABLE(TRUE);

        //   CurrPage.Lines.PAGE.DisableFields;


        // << HJ DSFT 08-11-2009
        IF RecUser.Niveau = 0 THEN ERROR(Text011);
        IF RecUser.Niveau = 1 THEN REC.SETRANGE(Utilisateur, USERID);
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            REC.SETRANGE(Agence, RecUser.Agence)
        ELSE
            REC.SETRANGE(Agence);
        // >> HJ DSFT 08 11 2010
        TxtEtapesSuivante := 'Action : ';
        REcPaymentSteps.SETRANGE("Payment Class", REC."Payment Class");
        REcPaymentSteps.SETRANGE("Previous Status", REC."Status No.");
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
        IF RecUser.GET(UPPERCASE(USERID)) THEN REC.Agence := RecUser.Agence;
        REC.Utilisateur := UPPERCASE(USERID);
        // << HJ DSFT 21-01-2009
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // >> HJ DSFT 21-01-2009

        IF GeneralLedgerSetup.GET THEN;
        REC.VALIDATE("Account Type", REC."Account Type"::"Bank Account");
        //    REC.VALIDATE("Account No.", GeneralLedgerSetup.Caisse);
        // << HJ DSFT 21-01-2009
    end;

    trigger OnOpenPage()
    begin
        // << HJ DSFT 21-01-2009
        RecUser.GET(UPPERCASE(USERID));
        IF RecUser.Niveau = 0 THEN ERROR(Text0011);
        IF RecUser.Niveau = 1 THEN REC.SETRANGE(Utilisateur, UPPERCASE(USERID));
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            REC.SETRANGE(Agence, RecUser.Agence)
        ELSE
            REC.SETRANGE(Agence);
        REC.SETRANGE("Account Type", REC."Account Type"::"Bank Account");


        IF REC.Valider = TRUE THEN BEGIN
            CurrPage.EDITABLE(FALSE);
            // CurrPage.Lines.PAGE.EDITABLE(FALSE);
        END
        ELSE
            CurrPage.EDITABLE(TRUE);

        // << HJ DSFT 21-01-2009IF (Valider)   THEN
        OnActivateForm;

        //GL2024



        PaimentCaisseEditable := false;
        AffaireAEROPJERBAMATMATA := false;
        AffairePENETRANTELOT2 := false;
        AffairePENETRANTELOT3 := false;
        AffaireBIZERTE_BASE_AERIEN := false;
        AffairePONT_BIZERTELOT1 := false;
        AffairePORTFINARAOUEDRP2 := false;
        AffaireAUTOROUTESBIKHALO5 := false;
        AffaireCHANTIERKEFRR173 := false;
        AffaireOUEDJOUMINEMATEUR := false;

        if Rec."N° Affaire" = 'AEROP-JERBA-MATMATA' then begin
            AffaireAEROPJERBAMATMATA := true;
            PaimentCaisseEditable := true;
        end

        else
            if Rec."N° Affaire" = 'PENETRANTE_LOT2' then begin
                AffairePENETRANTELOT2 := true;
                PaimentCaisseEditable := true;
            end
            else
                if Rec."N° Affaire" = 'PENETRANTE_LOT3' then begin
                    AffairePENETRANTELOT3 := true;
                    PaimentCaisseEditable := true;
                end
                else
                    if Rec."N° Affaire" = 'BIZERTE_BASE_AERIEN' then begin
                        AffaireBIZERTE_BASE_AERIEN := true;
                        PaimentCaisseEditable := true;
                    end
                    else
                        if Rec."N° Affaire" = 'PONT_BIZERTE_LOT1' then begin
                            AffairePONT_BIZERTELOT1 := true;
                            PaimentCaisseEditable := true;
                        end
                        else
                            if Rec."N° Affaire" = 'PORT FINA RAOUED RP2' then begin
                                AffairePORTFINARAOUEDRP2 := true;
                                PaimentCaisseEditable := true;
                            end

                            else
                                if Rec."N° Affaire" = 'AUTOROUTE SBIKHA LO5' then begin
                                    AffaireAUTOROUTESBIKHALO5 := true;
                                    PaimentCaisseEditable := true;
                                end


                                else
                                    if Rec."N° Affaire" = 'CHANTIER_KEF_RR173' then begin
                                        AffaireCHANTIERKEFRR173 := true;
                                        PaimentCaisseEditable := true;
                                    end
                                    else
                                        if Rec."N° Affaire" = 'OUED_JOUMINE_MATEUR' then begin
                                            AffaireOUEDJOUMINEMATEUR := true;
                                            PaimentCaisseEditable := true;
                                        end






        //GL2024
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        Navigate: Page Navigate;
        Steps: Record "Payment Step";
        Text001: Label 'Ce type de règlement n''autorise pas les propositions fournisseur.';
        Text002: Label 'Ce type de règlement n''autorise pas les propositions client.';
        Text003: Label 'Vous n''êtes pas autorisé à faire des propositions de paiement sur un bordereau validé.';
        Text004: Label 'Vous ne pouvez pas affecter un numéro à un bordereau validé.';
        Text005: Label 'Ce document n''a pas de ligne. Vous ne pouvez l''archiver. Vous devez le supprimer.';
        Text006: Label 'Une ligne n''est pas validée. Êtes-vous sur de vouloir archiver ce document ?';
        Text007: Label 'Certaines lignes ne sont pas validées. Êtes-vous sur de vouloir archiver ce document ?';
        Text008: Label 'Etes-vous sur de vouloir archiver ce document ?';
        Text009: Label 'Souhaitez-vous archiver ce document ?';
        "-MBK-": Integer;
        PaymentStatus_gr: Record "Payment Status";
        PaymentLine_gr: Record "Payment Line";
        "Chèquemouvementé_gr": Record "Chèque mouvementé";
        // "--MBK--": ;
        Text010: Label 'Veuillez saisir le N° Chèque dans la ligne %1';
        Text011: Label 'N° chèque %1 utlisé plus d''une fois';
        RecBankAccount: Record "Bank Account";
        "-HJ-": Integer;
        RecAutorisationEtapes: Record "Autorisation Etapes2";
        RecUser: Record "User Setup";
        RecEntetePayement: Record "Payment Header";
        RecPaymentLine: Record "Payment Line";
        RecBank: Record "Bank Account";
        REcPaymentSteps: Record "Payment Step";
        RecPaymentStatus: Record "Payment Status";
        TxtEtapesSuivante: Text[1000];
        RecEntete: Record "Payment Header";
        // "--HJ--": ;
        Text0010: Label 'Vous N''ete Pas Autorise A Cette Etape %1,  %2,  %3 ; Consulter Votre Administrateur';
        Text0011: Label 'Vous N''ete Pas Autorisé Au Module Encaissement - Decaissement';
        Text0012: Label 'Votre Agence %1 Est Différente De Celle De L''Etape ( %2 )';
        Text013: Label 'Changement Agence Non Permis A Ce Statut';
        Text014: Label 'Vous n''etes pas autoriser à Changer L''agence';
        RecAgence: Record Agence;
        RecPaymentMethod: Record "Payment Method";
        RecPaymentMethod2: Record "Payment Method";
        RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
        RecCustomer: Record Customer;
        RecPaymentClass: Record "Payment Class";
        IntClient: Integer;
        IntTypeReglement: Integer;
        Text0015: Label 'Mode Paiement Client N° %1 ( %2 ) Ne Peut Pas Etre %3';
        PaymentLine: Record "Payment Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PaymentClassList: Page "Payment Class List";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text016: Label 'Nouveau Brouillard ?';
        LoanAdvance: Record "Loan & Advance";
        // DetailBrouillard: Record "Detail Avancement Production";
        NumSequence: Code[20];
        PaymentLine2: Record "Payment Line";
        Line: Record "Payment Line";
        Text017: Label 'Valider Le Brouillards ?';
        Text018: Label 'Validation Achevée Avec Succée';
        Text019: Label 'Deja Valider';
        Text020: Label 'reouvrir Ce Document ?';
        Text021: Label 'Document est Ouvert';
        Text022: Label 'Deja Ouvert';
        [InDataSet]
        PaimentCaisseEditable: Boolean;
        [InDataSet]
        AffaireAEROPJERBAMATMATA: Boolean;
        [InDataSet]
        AffairePENETRANTELOT2: Boolean;
        [InDataSet]
        AffairePENETRANTELOT3: Boolean;
        [InDataSet]
        AffaireBIZERTE_BASE_AERIEN: Boolean;
        [InDataSet]
        AffairePORTFINARAOUEDRP2: Boolean;
        [InDataSet]
        AffairePONT_BIZERTELOT1: Boolean;
        [InDataSet]
        AffaireAUTOROUTESBIKHALO5: Boolean;
        [InDataSet]
        AffaireCHANTIERKEFRR173: Boolean;
        [InDataSet]
        AffaireOUEDJOUMINEMATEUR: Boolean;


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
            //GL2024       Ok := CONFIRM(Steps.Name, TRUE);
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
            IF Steps.Agence <> '' THEN IF REC.Agence <> Steps.Agence THEN ERROR(Text0012, REC.Agence, Steps.Agence);
        // << HJ DSFT 14-04-2009

        //GL2024   IF Ok THEN
        Steps.SetFilter(
                          "Action Type",
                          '%1|%2|%3',
                          Steps."Action Type"::None, Steps."Action Type"::Ledger, Steps."Action Type"::"Cancel File");
        PostingStatement.ProcessPaymentSteps(Rec, Steps);
    end;

    local procedure OnActivateForm()
    begin
        IF REC.Valider = TRUE THEN BEGIN
            CurrPage.EDITABLE(FALSE);
            //CurrPage.Lines.PAGE.EDITABLE(FALSE);
        END
        ELSE
            CurrPage.EDITABLE(TRUE);
    end;
}

