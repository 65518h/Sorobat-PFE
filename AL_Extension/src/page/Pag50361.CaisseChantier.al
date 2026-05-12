page 50361 "Caisse Extra Chantier2"
{
    //GL2024 NEW PAGE
    Caption = 'Caisse Extra Chantier';
    DeleteAllowed = true;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Class" = CONST('CAISSEEXT'), Valider = CONST(false), "Caisse Chantier" = CONST(false), "N° Affaire" = FILTER(<> 'ADMINISTRATION'));

    layout
    {
        area(content)
        {

            field("No."; rec."No.")
            {
                ApplicationArea = all;
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
                trigger OnValidate()
                var

                    PaymentLine: Record "Payment Line";
                begin
                    PaymentLine.Reset();
                    PaymentLine.SetRange("No.", rec."No.");
                    if PaymentLine.FindFirst() then
                        Error('Impossible de changer le chantier car il est lié à des lignes');


                    rec."N° Affaire" := '';
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
                    AffaireMEDJERDABOUSALEMR := false;
                    AffaireRFRLOT1 := False;
                    AffaireRVE719BOUSSADIA := False;

                end;
            }
            field("Document Date"; rec."Document Date")
            {
                ApplicationArea = all;
                Caption = 'Journée';
            }
            field("Account No."; rec."Account No.")
            {
                ApplicationArea = all;
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
            }

            field("Payment Class"; rec."Payment Class")
            {
                ApplicationArea = all;
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
            }

            field(Valider2; rec.Valider)
            {
                ApplicationArea = all;
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("Validé Par"; rec."Validé Par")
            {
                ApplicationArea = all;
                Editable = false;
            }

            field("N° Affaire"; rec."N° Affaire")
            {
                ApplicationArea = all;
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
                trigger OnValidate()
                begin
                    //GL2024
                    PaimentCaisseEditable := false;
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
                    AffaireMEDJERDABOUSALEMR := false;
                    AffaireRFRLOT1 := False;
                    AffaireRVE719BOUSSADIA := False;

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

                                                    else
                                                        if Rec."N° Affaire" = 'MEDJERDA BOUSALEM' then begin
                                                            AffaireMEDJERDABOUSALEMR := true;
                                                            PaimentCaisseEditable := true;
                                                        end

                                                        else
                                                            if Rec."N° Affaire" = 'RFR LOT1' then begin
                                                                AffaireRFRLOT1 := true;
                                                                PaimentCaisseEditable := true;
                                                            end

                                                            else
                                                                if Rec."N° Affaire" = 'RVE719BOUSSADIA' then begin
                                                                    AffaireRVE719BOUSSADIA := true;
                                                                    PaimentCaisseEditable := true;
                                                                end














                    //GL2024
                end;
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

            // Group("Solde Caisse BOUSALEM1")
            // {
            //     Visible = AffaireMEDJERDABOUSALEMR;
            //     ShowCaption = false;

            //     field("Solde Caisse BOUSALEM"; Rec."Solde Caisse BOUSSELEM")
            //     {

            //         ApplicationArea = all;
            //         Caption = 'Solde Caisse BOUSSELEM';
            //         Editable = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;

            //     }
            // }
            // Group("Solde Caisse RFRLOT1")
            // {
            //     Visible = AffaireRFRLOT1;
            //     ShowCaption = false;

            //     field("Solde Caisse RFR LOT1"; Rec."Solde Caisse RFR LOT1")
            //     {

            //         ApplicationArea = all;
            //         Caption = 'Solde Caisse RFR LOT1';
            //         Editable = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;

            //     }
            // }
            // Group("Solde CaisseBOUSSADIA")
            // {
            //     Visible = AffaireRVE719BOUSSADIA;
            //     ShowCaption = false;

            //     field("Solde Caisse BOUSSADIA"; Rec."Solde Caisse BOUSSADIA")
            //     {

            //         ApplicationArea = all;
            //         Caption = 'Solde Caisse BOUSSADIA';
            //         Editable = false;
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;

            //     }
            // }






            // part(Lines; "Ligne Paiement Caisse")
            // {
            //     ApplicationArea = all;
            //     SubPageLink = "No." = FIELD("No.");
            //     Editable = PaimentCaisseEditable;
            //     UpdatePropagation = Both;
            // }
            field("Amount (LCY)"; rec."Amount (LCY)")
            {
                ApplicationArea = all;
                Caption = 'Montant Brouillards';
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

            actionref("Integration Paie1"; "Integration Paie") { }
            actionref("Imprimer Bon1"; "Imprimer Bon") { }
            actionref("Imprimer Journée De Caisse1"; "Imprimer Journée De Caisse") { }
            actionref(Actualiser1; Actualiser) { }
            group("P&osting1")
            {
                Caption = 'Fonction';
                actionref("Integration Paie a La Caisse1"; "Integration Paie a La Caisse") { }
                //GL2024   actionref("Retour Paie a La Caisse1"; "Retour Paie a La Caisse") { }
                actionref("Imprimer Bordereau Paie a la Caisse1"; "Imprimer Bordereau Paie a la Caisse") { }
                actionref(Insertion1; Insertion) { }
                actionref(Printing1; Printing) { }
                actionref("Imprimer Mandat Minute1"; "Imprimer Mandat Minute") { }
                actionref("Imprimer Fiche de Versement1"; "Imprimer Fiche de Versement") { }
                actionref("Generate file1"; "Generate file") { }
                actionref(Valider11; Valider) { }
                actionref("Réouvrir1"; "Réouvrir") { }
                actionref(Validate1; Validate) { }

                actionref("STC - BON1"; "STC - BON") { }
                actionref("Detail Brouillard1"; "Detail Brouillard") { }

            }
        }
        area(processing)
        {

            action("Integration Paie")
            {
                ApplicationArea = all;
                Caption = 'Integration Paie';

                Visible = false;

                trigger OnAction()
                begin

                    // RegroupementPaieEntete.DELETEALL;
                    // RegroupementPaie.DELETEALL;
                    // RegroupementPaieEntete."N° Caisse" := rec."No.";
                    // RegroupementPaieEntete.Date := rec."Document Date";
                    // RegroupementPaieEntete.INSERT;
                    // COMMIT;
                    //  PAGE.RUNMODAL(PAGE::"Regroupement paie");
                end;
            }
            action("Imprimer Bon")
            {
                Caption = 'Imprimer Bon';

                ApplicationArea = all;
                trigger OnAction()
                begin
                    //  CurrPage.Lines.page.GETRECORD(Line);
                    PaymentLine2.SETRANGE(PaymentLine2."No.", Line."No.");
                    PaymentLine2.SETRANGE(PaymentLine2."Numero Seq", Line."Numero Seq");
                    IF Line.Provisoire = TRUE THEN
                        REPORT.RUN(50214, TRUE, TRUE, PaymentLine2);
                    // ELSE
                    //     IF Line.Avance = TRUE THEN BEGIN
                    //         REPORT.RUN(50217, TRUE, TRUE, PaymentLine2);
                    //     END;
                end;
            }
            action("Imprimer Journée De Caisse")
            {
                ApplicationArea = all;
                Caption = 'Imprimer Journée De Caisse';


                trigger OnAction()
                begin
                    PaymentLine.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"Brouillard de Caisse", TRUE, TRUE, PaymentLine);
                end;
            }
            action(Actualiser)
            {
                ApplicationArea = all;
                Caption = 'Actualiser';


                trigger OnAction()
                var
                    "PaymentLine": record "Payment Line";
                begin
                    //  CurrPage.Lines.page.EDITABLE(TRUE);
                    PaimentCaisseEditable := true;
                    if rec.Chantier = rec.Chantier::OACA then
                        rec."N° Affaire" := 'AEROP-JERBA-MATMATA'
                    else if rec.Chantier = rec.Chantier::"PENETRANTE LOT2" then
                        rec."N° Affaire" := 'PENETRANTE_LOT2'
                    else if rec.Chantier = rec.Chantier::"PENETRANTE LOT3" then
                        rec."N° Affaire" := 'PENETRANTE_LOT3'
                    else if rec.Chantier = rec.Chantier::"BIZERTE BASE AERIEN" then
                        rec."N° Affaire" := 'BIZERTE_BASE_AERIEN'
                    else if rec.Chantier = rec.Chantier::"BIZERTE PONT LOT1" then
                        rec."N° Affaire" := 'PONT_BIZERTE_LOT1'
                    else if rec.Chantier = rec.Chantier::RAOUED then
                        rec."N° Affaire" := 'PORT FINA RAOUED RP2'
                    else if rec.Chantier = rec.Chantier::"AUTOR SBIKHA LO5" then
                        rec."N° Affaire" := 'AUTOROUTE SBIKHA LO5'
                    else if rec.Chantier = rec.Chantier::"AUT KEF RR173" then
                        rec."N° Affaire" := 'CHANTIER_KEF_RR173'
                    else if rec.Chantier = rec.Chantier::"OUED JOUMINE MATEUR" then
                        rec."N° Affaire" := 'OUED_JOUMINE_MATEUR'
                    else if rec.Chantier = rec.Chantier::"MEDJERDA BOUSALEM" then
                        rec."N° Affaire" := 'MEDJERDA BOUSALEM'
                    else if rec.Chantier = rec.Chantier::"RFR LOT1" then
                        rec."N° Affaire" := 'RFR LOT1'
                    else if rec.Chantier = rec.Chantier::"RVE719BOUSSADIA" then
                        rec."N° Affaire" := 'RVE719BOUSSADIA';
                    rec.MODIFY;//



                end;
            }
            group("P&osting")
            {
                Caption = 'Fonction';
                action("Integration Paie a La Caisse")
                {
                    ApplicationArea = all;
                    Caption = 'Integration Paie a La Caisse';

                    trigger OnAction()
                    begin

                        // RegroupementPaieEntete.DELETEALL;
                        // RegroupementPaie.DELETEALL;
                        // RegroupementPaieEntete."N° Caisse" := rec."No.";
                        // RegroupementPaieEntete.Date := rec."Document Date";
                        // RegroupementPaieEntete.INSERT;
                        // COMMIT;
                        // PAGE.RUNMODAL(PAGE::"Regroupement paie");
                    end;
                }
                /*GL2024  action("Retour Paie a La Caisse")
                  {
                      Caption = 'Retour Paie a La Caisse';
                      ApplicationArea = all;
                      trigger OnAction()
                      begin
                          RegroupementPaieEntete.DELETEALL;
                          //GL3900   RegroupementPaieRetour.DELETEALL;
                          RegroupementPaieEntete."N° Caisse" := rec."No.";
                          RegroupementPaieEntete.Date := rec."Document Date";
                          RegroupementPaieEntete.INSERT;
                          COMMIT;
                          //GL3900   PAGE.RUNMODAL(PAGE::"Regroupement paie Retour");
                      end;
                  }*/
                action("Imprimer Bordereau Paie a la Caisse")
                {
                    Caption = 'Imprimer Bordereau Paie a la Caisse';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        PaymentLine.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(REPORT::"Bordereau Paie a la caisse", TRUE, TRUE, PaymentLine);
                    end;
                }
                action(Insertion)
                {
                    Caption = 'Insertion';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        IF GeneralLedgerSetup.GET THEN;
                        IF NOT CONFIRM(Text016) THEN EXIT;
                        RecEntetePayement.INIT;
                        //  IF RecPaymentClass.GET(GeneralLedgerSetup."Type Caisse Ex") THEN;
                        RecEntetePayement."No." := NoSeriesMgt.GetNextNo(RecPaymentClass."Header No. Series", 0D, TRUE);
                        RecEntetePayement.VALIDATE("Posting Date", TODAY);
                        RecEntetePayement.VALIDATE("Document Date", TODAY);
                        //   RecEntetePayement.VALIDATE("Payment Class", GeneralLedgerSetup."Type Caisse Ex");
                        RecEntetePayement.VALIDATE("Account Type", RecEntetePayement."Account Type"::"Bank Account");
                        // RecEntetePayement.VALIDATE("Account No.", GeneralLedgerSetup.Caisse);
                        RecEntetePayement."Date Création" := CURRENTDATETIME;
                        RecEntetePayement."Créer par" := COPYSTR(USERID, 1, 20);
                        RecEntetePayement.Utilisateur := COPYSTR(USERID, 1, 20);
                        RecEntetePayement.INSERT;
                        IF rec.FINDLAST THEN;
                    end;
                }
                action(Printing)
                {
                    Caption = 'Imprimer';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        Text1: Label 'There is no line to treat.';
                    begin
                        //GL2024 License
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text1);
                        //GL2024 License
                        Steps.SETRANGE("Payment Class", rec."Payment Class");
                        Steps.SETRANGE("Previous Status", rec."Status No.");
                        Steps.SETRANGE("Action Type", Steps."Action Type"::Report);
                        //>> HJ DSFT 09 12 2010
                        IF RecUser.GET(UPPERCASE(USERID)) THEN;
                        IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
                        //>> HJ DSFT 09 12 2010

                        // CurrPage.Lines.Page.MarkLines(TRUE);
                        ValidatePayment;
                        //    CurrPage.Lines.Page.MarkLines(FALSE);
                    end;
                }
                action("Imprimer Mandat Minute")
                {
                    ApplicationArea = all;
                    Caption = 'Imprimer Mandat Minute';

                    trigger OnAction()
                    begin
                        //   CurrPage.Lines.Page.GETRECORD(Line);

                        RecPaymentLine2.SETRANGE("No.", Line."No.");
                        RecPaymentLine2.SETRANGE("Line No.", Line."Line No.");
                        REPORT.RUNMODAL(REPORT::"Monadat Minute", TRUE, TRUE, RecPaymentLine2);
                    end;
                }
                action("Imprimer Fiche de Versement")
                {
                    Caption = 'Imprimer Fiche de Versement';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //      CurrPage.Lines.Page.GETRECORD(Line);

                        PaymentLine2.SETRANGE(PaymentLine2."No.", Line."No.");
                        PaymentLine2.SETRANGE(PaymentLine2."Numero Seq", Line."Numero Seq");
                        REPORT.RUN(50100, TRUE, TRUE, PaymentLine2)
                    end;
                }
                action("Generate file")
                {
                    ApplicationArea = all;
                    Caption = 'Générer fichier';
                    Visible = false;

                    trigger OnAction()
                    var
                        Text1: Label 'There is no line to treat.';
                    begin
                        //GL2024 License
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text1);
                        //GL2024 License
                        Steps.SETRANGE("Payment Class", rec."Payment Class");
                        Steps.SETRANGE("Previous Status", rec."Status No.");
                        Steps.SETRANGE("Action Type", Steps."Action Type"::File);
                        ValidatePayment;
                    end;
                }
                action(Valider)
                {
                    Caption = 'Valider';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        IF rec.Valider = TRUE THEN ERROR(Text019);

                        // MH SORO 04-09-2020

                        RecPaymentLine2.RESET;
                        RecPaymentLine2.SETRANGE("No.", rec."No.");
                        //   RecPaymentLine2.SETRANGE("Code Opération", 'P2');
                        IF RecPaymentLine2.FINDFIRST THEN
                            REPEAT
                                RecAvance.RESET;
                                //   RecAvance.SETRANGE("N° Bon Caisse", RecPaymentLine2."Numero Seq");
                                IF NOT RecAvance.FINDFIRST THEN ERROR('Il Existe des Avances non Validé !!!');

                            UNTIL RecPaymentLine2.NEXT = 0;

                        // MH SORO 04-09-2020
                        IF NOT CONFIRM(Text017, FALSE) THEN EXIT;

                        rec."Status No." := 10000;
                        rec."Status Name" := 'VALIDER';
                        rec.Valider := TRUE;
                        rec."Validé Par" := UPPERCASE(USERID);

                        rec.MODIFY;
                        MESSAGE(Text018);

                        PaymentLine2.RESET;
                        PaymentLine2.SETRANGE(PaymentLine2."No.", rec."No.");
                        IF PaymentLine2.FINDFIRST THEN
                            REPEAT
                                PaymentLine2."Validé Caisse" := TRUE;
                                PaymentLine2.MODIFY;
                            UNTIL PaymentLine2.NEXT = 0;
                    end;
                }
                action("Réouvrir")
                {
                    ApplicationArea = all;
                    Caption = 'Réouvrir';
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF rec.Valider = FALSE THEN ERROR(Text022);
                        IF NOT CONFIRM(Text020, FALSE) THEN EXIT;
                        rec."Status No." := 10000;
                        rec.Valider := FALSE;
                        rec."Validé Par" := '';
                        rec.MODIFY;
                        MESSAGE(Text021);

                        PaymentLine2.RESET;
                        PaymentLine2.SETRANGE(PaymentLine2."No.", rec."No.");
                        IF PaymentLine2.FINDFIRST THEN
                            REPEAT
                                PaymentLine2."Validé Caisse" := FALSE;
                                PaymentLine2.MODIFY;
                            UNTIL PaymentLine2.NEXT = 0;
                    end;
                }
                action(Validate)
                {
                    ApplicationArea = all;
                    Caption = 'Valider Comptabiliser';
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



                        //GL2024 License
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text1);
                        //GL2024 License
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
                action("STC - BON")
                {
                    ApplicationArea = all;
                    Caption = 'STC - BON';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //   CurrPage.Lines.Page.Get11X12X;
                    end;
                }
                action("Detail Brouillard")
                {
                    ApplicationArea = all;
                    Caption = 'Detail Brouillard';
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        //   NumSequence := CurrPage.Lines.Page.GetNumSeq;
                        // DetailBrouillard.RESET;
                        //  DetailBrouillard.SETRANGE("Order N°", NumSequence);
                        //  PAGE.RUNMODAL(PAGE::"Detail Brouillard de Caisse", DetailBrouillard);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Currpage.Lines.Page.EDITABLE(TRUE);
        //IF Valider=TRUE   THEN
        //  BEGIN
        //    Currpage.EDITABLE(FALSE);
        //    Currpage.Lines.Page.EDITABLE(FALSE);
        //  END
        // ELSE Currpage.EDITABLE(TRUE);

        //Currpage.Lines.Page.DisableFields;


        //GL2024 // << HJ DSFT 08-11-2009
        // IF RecUser.Niveau = 0 THEN ERROR(Text011);
        // IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
        // IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
        //     rec.SETRANGE(Agence, RecUser.Agence)
        // ELSE
        //     rec.SETRANGE(Agence);
        // // >> HJ DSFT 08 11 2010
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
        AffaireOUEDJOUMINEMATEUR := false;
        AffaireMEDJERDABOUSALEMR := false;
        AffaireRFRLOT1 := False;
        AffaireRVE719BOUSSADIA := False;

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
                                        else
                                            if Rec."N° Affaire" = 'MEDJERDA BOUSALEM' then begin
                                                AffaireMEDJERDABOUSALEMR := true;
                                                PaimentCaisseEditable := true;
                                            end
                                            else
                                                if Rec."N° Affaire" = 'RFR LOT1' then begin
                                                    AffaireRFRLOT1 := true;
                                                    PaimentCaisseEditable := true;
                                                end

                                                else
                                                    if Rec."N° Affaire" = 'RVE719BOUSSADIA' then begin
                                                        AffaireRVE719BOUSSADIA := true;
                                                        PaimentCaisseEditable := true;
                                                    end







        //GL2024
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // >> HJ DSFT 21-01-2009

        IF GeneralLedgerSetup.GET THEN;
        rec.VALIDATE("Account Type", rec."Account Type"::"Bank Account");
        //  rec.VALIDATE("Account No.", GeneralLedgerSetup.Caisse);
        // << HJ DSFT 21-01-2009

        rec."Payment Class" := 'CAISSEEXT';
    end;

    trigger OnOpenPage()
    begin
        //     // << HJ DSFT 21-01-2009
        //     RecUser.GET(UPPERCASE(USERID));
        //     IF RecUser.Niveau = 0 THEN ERROR(Text0011);
        //     IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
        //     IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
        //         rec.SETRANGE(Agence, RecUser.Agence)
        //     ELSE
        //         rec.SETRANGE(Agence);
        //     rec.SETRANGE("Account Type", rec."Account Type"::"Bank Account");


        //     //IF Valider=TRUE   THEN
        //     //  BEGIN
        //     //  Currpage.EDITABLE(FALSE);
        //     //  // Currpage.Lines.Page.EDITABLE(FALSE);
        //     // END
        //     //ELSE Currpage.EDITABLE(TRUE);

        //     //<< HJ DSFT 21-01-2009IF (Valider)   THEN


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
        AffaireMEDJERDABOUSALEMR := false;
        AffaireRFRLOT1 := False;
        AffaireRVE719BOUSSADIA := False;

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
                                        else
                                            if Rec."N° Affaire" = 'MEDJERDA BOUSALEM' then begin
                                                AffaireMEDJERDABOUSALEMR := true;
                                                PaimentCaisseEditable := true;
                                            end
                                            else
                                                if Rec."N° Affaire" = 'RFR LOT1' then begin
                                                    AffaireRFRLOT1 := true;
                                                    PaimentCaisseEditable := true;
                                                end

                                                else
                                                    if Rec."N° Affaire" = 'RVE719BOUSSADIA' then begin
                                                        AffaireRVE719BOUSSADIA := true;
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
        //  DetailBrouillard: Record "Detail Avancement Production";
        NumSequence: Code[20];
        PaymentLine2: Record "Payment Line";
        Line: Record "Payment Line";
        Text017: Label 'Valider Le Brouillards ?';
        Text018: Label 'Validation Achevée Avec Succée';
        Text019: Label 'Deja Valider';
        Text020: Label 'reouvrir Ce Document ?';
        Text021: Label 'Document est Ouvert';
        Text022: Label 'Deja Ouvert';
        SalaryLines: Record "Salary Lines";
        //    RegroupementPaie: Record "Regroupement Paie";
        PaymentHeader: Record "Payment Header";
        // RegroupementPaieEntete: Record "Regroupement Paie Entete";
        //GL3900    RegroupementPaieRetour: Record "Regroupement Paie Retour";
        RecPaymentLine2: Record "Payment Line";
        FiltreChantier: Option "",OACA,"PENETRANTE LOT2","PENETRANTE LOT3","BIZERTE BASE AERIEN","BIZERTE PONT LOT1","RAOUED","AUTOR SBIKHA LO5","AUT KEF RR173","OUED JOUMINE MATEUR";
        RecAvance: Record "Loan & Advance Header";
        NumAvance: Code[20];
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
        [InDataSet]
        AffaireMEDJERDABOUSALEMR: Boolean;
        [InDataSet]
        AffaireRFRLOT1: Boolean;
        [InDataSet]
        AffaireRVE719BOUSSADIA: Boolean;


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
            //GL2024   Ok := CONFIRM(Steps.Name, TRUE);
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
        //GL2024  IF Ok THEN
        Steps.SetFilter(
                          "Action Type",
                          '%1|%2|%3',
                          Steps."Action Type"::None, Steps."Action Type"::Ledger, Steps."Action Type"::"Cancel File");
        PostingStatement.ProcessPaymentSteps(Rec, Steps);
    end;
}

