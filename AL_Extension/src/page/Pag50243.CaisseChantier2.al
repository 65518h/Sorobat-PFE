page 50243 "Caisse Chantier Siège"
{
    // //>>>MBK:05/02/2010: Référence chèque
    // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs

    Caption = 'Caisse Chantier';
    DeleteAllowed = true;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = 10865;
    SourceTableView = WHERE("Payment Class" = CONST('ESPECES EXTERIEURE EMIS'), "Caisse Chantier" = CONST(true));
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            /*   part(Lines; "Ligne Paiement Chantier E") 
               {
                   SubpageLink = "No." = FIELD("No.");
               }*/
            field("No.1"; rec."No.")
            {
                Caption = 'N° Brouillars';
                Editable = false;
                Style = Unfavorable;
                StyleExpr = TRUE;
            }
            field("N° Affaire"; rec."N° Affaire")
            {
                ApplicationArea = all;
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
                ShowMandatory = true;

            }
            field("Payment Class"; rec."Payment Class")
            {
                ApplicationArea = all;
                Editable = false;
                Style = Favorable;
                StyleExpr = TRUE;
            }
            field("Solde Caisse Chantier"; rec."Solde Caisse Chantier")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = TRUE;
                Editable = false;
                Caption = 'Solde';
            }

            field("Status Name"; Rec."Status Name")
            {
                ApplicationArea = all;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("Document Date"; rec."Document Date")
            {
                ApplicationArea = all;
                Caption = 'Date Brouillards';
            }
            field("Account No."; rec."Account No.")
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
            field("Caisse Chantier"; Rec."Caisse Chantier")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Approuver; Rec.Approuver)
            {
                ApplicationArea = all;
                Editable = false;
            }
            part(Lines; "Ligne Paiement Chantier E2")
            {
                Caption = 'Sous-formulaire bordereau paiement';

                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
                // Editable = PaimentCaisseEditable;
                UpdatePropagation = Both;

            }

            field("Amount (LCY)"; rec."Amount (LCY)")
            {
                ApplicationArea = all;
                Caption = 'Montant Brouillards';
                Enabled = false;
                DecimalPlaces = 3 : 2;
                Style = Strong;
                StyleExpr = TRUE;
            }




        }
    }

    actions
    {
        area(Promoted)
        {
            actionref("Imprimer Brouillard De Caisse1"; "Imprimer Brouillard De Caisse")
            {

            }
            actionref("Imprimer Pièce de caisse à payer1"; "Imprimer Pièce de caisse à payer")
            {

            }
            group("Posting")
            {
                Caption = '&Fonction';

                actionref(Printing1; Printing)
                {

                }
                actionref("Approuver Brouillar1"; "Approuver Brouillar")
                {

                }
                actionref("Annuler Approbation  Brouillar1"; "Annuler Approbation  Brouillar")
                {

                }
                actionref("Nouveau1"; "Nouveau")
                {

                }

                actionref(Validate1; Validate)
                {

                }

            }
        }
        area(processing)
        {
            action("Imprimer Brouillard De Caisse")
            {
                Caption = 'Imprimer Brouillard De Caisse';
                Image = print;


                trigger OnAction()
                begin
                    PaymentLine.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"Brouillard de Caisse Chantier", TRUE, TRUE, PaymentLine);
                end;
            }

            action("Imprimer Pièce de caisse à payer")
            {
                Caption = 'Imprimer Pièce de caisse à payer';
                Image = print;


                trigger OnAction()
                begin
                    PaymentLine.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"Pièce de caisse à payer", TRUE, TRUE, PaymentLine);
                end;
            }
            group("P&osting")
            {
                Caption = 'Validation';
                action(Printing)
                {
                    Caption = 'Imprimer';
                    Image = Print;

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

                        CurrPage.Lines.page.MarkLines(TRUE);
                        ValidatePayment(true);
                        CurrPage.Lines.page.MarkLines(FALSE);
                    end;
                }
                action("Generate file")
                {
                    Caption = 'Générer fichier';
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text0001);
                        Steps.SETRANGE("Payment Class", rec."Payment Class");
                        Steps.SETRANGE("Previous Status", rec."Status No.");
                        Steps.SETRANGE("Action Type", Steps."Action Type"::File);
                        ValidatePayment(false);
                    end;
                }
                action(Validate)
                {
                    Caption = 'Valider';
                    ShortCutKey = 'F9';
                    Image = Post;

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
                        //abz if rec."No. of Lines" = 0 then
                        //ABZ Error(Text0001);
                        Steps.SETRANGE("Payment Class", rec."Payment Class");
                        Steps.SETRANGE("Previous Status", rec."Status No.");
                        Steps.SETFILTER("Action Type", '<>%1&<>%2&<>%3', Steps."Action Type"::Report, Steps."Action Type"::File, Steps."Action Type"::
                          "Create New Document");
                        //>> HJ DSFT 09 12 2010
                        IF RecUser.GET(UPPERCASE(USERID)) THEN;
                        IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
                        //>> HJ DSFT 09 12 2010
                        ValidatePayment(false);
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
                action("Approuver Brouillar")
                {
                    Caption = 'Approuver Brouillard';


                    trigger OnAction()
                    begin
                        IF RecUser.GET(UPPERCASE(USERID)) THEN;
                        IF NOT RecUser."Approuver Brouillard" THEN EXIT;
                        IF NOT CONFIRM(Text012) THEN EXIT;
                        RecPaymentLine.SETRANGE("No.", rec."No.");
                        IF RecPaymentLine.FINDFIRST THEN
                            REPEAT
                                RecPaymentLine.Caisse := TRUE;
                                RecPaymentLine.MODIFY;
                            UNTIL RecPaymentLine.NEXT = 0;
                        rec.Approuver := TRUE;
                        rec.MODIFY;
                    end;
                }
                action("Annuler Approbation  Brouillar")
                {

                    Caption = 'Annuler Approbation Brouillard';

                    trigger OnAction()
                    begin
                        IF RecUser.GET(UPPERCASE(USERID)) THEN;
                        IF NOT RecUser."Approuver Brouillard" THEN EXIT;
                        IF NOT CONFIRM(Text013) THEN EXIT;
                        RecPaymentLine.SETRANGE("No.", rec."No.");
                        IF RecPaymentLine.FINDFIRST THEN
                            REPEAT
                                RecPaymentLine.Caisse := FALSE;
                                RecPaymentLine.MODIFY;
                            UNTIL RecPaymentLine.NEXT = 0;
                        rec.Approuver := FALSE;
                        rec.MODIFY;
                    end;
                }
                action(Nouveau)
                {

                    Caption = 'Nouveau';

                    trigger OnAction()
                    begin
                        IF GeneralLedgerSetup.GET THEN;
                        IF NOT CONFIRM(Text016) THEN EXIT;
                        RecEntetePayement.INIT;
                        IF RecPaymentClass.GET(GeneralLedgerSetup."Type Reg. Caisse Ext") THEN;
                        RecEntetePayement."No." := NoSeriesMgt.GetNextNo(RecPaymentClass."Header No. Series", 0D, TRUE);
                        RecEntetePayement.VALIDATE("Posting Date", WORKDATE);
                        RecEntetePayement.VALIDATE("Document Date", WORKDATE);
                        RecEntetePayement.VALIDATE("Payment Class", 'ESPECES EXTERIEURE EMIS');
                        RecEntetePayement.VALIDATE("Account Type", RecEntetePayement."Account Type"::"Bank Account");
                        RecEntetePayement.VALIDATE("Account No.", GeneralLedgerSetup."Caisse EXT");
                        RecEntetePayement."Date Création" := CURRENTDATETIME;
                        RecEntetePayement."Créer par" := COPYSTR(USERID, 1, 20);
                        RecEntetePayement.Utilisateur := COPYSTR(USERID, 1, 20);
                        RecEntetePayement."Caisse Chantier" := TRUE;
                        RecEntetePayement.INSERT;
                        rec.SETRANGE("Payment Class", GeneralLedgerSetup."Type Reg. Caisse Ext");
                        rec.SETRANGE("Account No.", GeneralLedgerSetup."Caisse EXT");
                        IF rec.FINDLAST THEN;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.Lines.page.EDITABLE(TRUE);
        CurrPage.Lines.page.DisableFields(rec."No.");

    end;

    trigger OnAfterGetRecord()
    begin


        CurrPage.Lines.page.EDITABLE(TRUE);
        CurrPage.Lines.page.DisableFields(rec."No.");
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
        CurrPage.Lines.page.EDITABLE(TRUE);
        CurrPage.Lines.page.DisableFields(rec."No.");



    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        NoSeries: Codeunit "No. Series";
        // PaymentClass: Record "Payment Class";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        IsHandled: Boolean;
        Job: Record job;
    begin
        // >> HJ DSFT 21-01-2009
        IF RecUser.GET(UPPERCASE(USERID)) THEN rec.Agence := RecUser.Agence;
        rec.Utilisateur := UPPERCASE(USERID);
        rec."Caisse Chantier" := TRUE;
        // << HJ DSFT 21-01-2009
        //GL2024
        if Job.Get(rec."N° Affaire") then;
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(Job."No. Series Caisse", xRec."No. Series", 0D, rec."No.", rec."No. Series", IsHandled);
        if not IsHandled then begin

            rec."No. Series" := Job."No. Series Caisse";
            if NoSeries.AreRelated(rec."No. Series", xRec."No. Series") then
                rec."No. Series" := xRec."No. Series";
            rec."No." := NoSeries.GetNextNo(rec."No. Series");

            NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(rec."No. Series", Job."No. Series Caisse", 0D, rec."No.");
        end;
        //GL2024

        rec."Date Création" := CURRENTDATETIME;
        rec."Créer par" := COPYSTR(USERID, 1, 20);
        rec.Utilisateur := COPYSTR(USERID, 1, 20);


    end;

    trigger OnOpenPage()
    var
        usersteup: Record "User Setup";
    begin

        // << HJ DSFT 21-01-2009
        RecUser.GET(UPPERCASE(USERID));
        IF RecUser.Niveau = 0 THEN ERROR(Text017);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        rec.SETRANGE("Account Type", rec."Account Type"::"Bank Account");

        CurrPage.Lines.page.EDITABLE(TRUE);
        CurrPage.Lines.page.DisableFields(rec."No.");
        // << HJ DSFT 21-01-2009



    end;

    var
        ChangeExchangeRate: page 511;
        Navigate: page 344;
        Steps: Record 10862;
        Text0001: Label 'Il n’y a aucune ligne à traiter';
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
        PaymentStatus_gr: Record 10861;
        PaymentLine_gr: Record 10866;
        "Chèquemouvementé_gr": Record 50038;

        Text010: Label 'Veuillez saisir le N° Chèque dans la ligne %1';
        Text011: Label 'N° chèque %1 utlisé plus d''une fois';
        RecBankAccount: Record 270;
        "-HJ-": Integer;
        RecAutorisationEtapes: Record "Autorisation Etapes2"; //ABZ

        RecUser: Record 91;
        RecEntetePayement: Record 10865;
        RecPaymentLine: Record 10866;
        RecBank: Record 270;
        REcPaymentSteps: Record 10862;
        RecPaymentStatus: Record 10861;
        TxtEtapesSuivante: Text[1000];
        RecEntete: Record 10865;
        Text012: Label 'Approuver ce Brouillard ?';
        Text017: Label 'Annuler Approbation  Brouillard ?';

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
        PaymentLine: Record 10866;
        GeneralLedgerSetup: Record 98;
        PaymentClassList: page 10860;
        Text016: Label 'Nouveau Brouillard ?';
        Process: Record 10860;
        NoSeriesMgt: Codeunit 396;
        PaimentCaisseEditable: Boolean;
        UserSetup: Record "User Setup";
        SoldeAffaire: Decimal;

    procedure CalcSoldeCaisse(): Decimal
    begin
        SoldeAffaire := 0;

        if UserSetup.Get(UserId) then begin
            PaymentLine.SetRange("Caisse Chantier", true);
            PaymentLine.SetRange("N° Affaire", UserSetup."Affaire");
            if PaymentLine.FindSet() then
                repeat
                    SoldeAffaire -= PaymentLine.Amount;
                until PaymentLine.Next() = 0;
        end;

        exit(SoldeAffaire);
    end;

    local procedure ValidatePayment(PrintOrPost: Boolean)
    var
        Ok: Boolean;
        PostingStatement: Codeunit "Payment Management Copy";
        Options: Text[400];
        Choice: Integer;
        I: Integer;
    begin
        //////
        if PrintOrPost then begin


            Steps.SETRANGE("Payment Class", rec."Payment Class");
            Steps.SETRANGE("Previous Status", rec."Status No.");
            Steps.SETRANGE("Action Type", Steps."Action Type"::Report);
            //>> HJ DSFT 09 12 2010
            IF RecUser.GET(UPPERCASE(USERID)) THEN;
            IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
        end;
        /// ////
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

        //  IF Ok THEN
        //  PostingStatement.Valbord(Rec, Steps);
        if not PrintOrPost then
            Steps.SetFilter(
                              "Action Type",
                              '%1|%2|%3',
                              Steps."Action Type"::None, Steps."Action Type"::Ledger, Steps."Action Type"::"Cancel File");
        PostingStatement.ProcessPaymentSteps(Rec, Steps);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        usersteup: Record "User Setup";
    begin

        rec."Payment Class" := 'ESPECES EXTERIEURE EMIS';
        // >> HJ DSFT 21-01-2009
        if Process.get(rec."Payment Class") then begin
            //>> HJ SOROT 16-06-2014
            IF Process.EXT THEN BEGIN
                rec."Account Type" := rec."Account Type"::"Bank Account";
                rec.VALIDATE("Account No.", Process."Caisse Par Defaut");
            END;
        end;
        if usersteup.Get(UserId) then begin
            rec."N° Affaire" := usersteup.Affaire;
        end;


    end;


    procedure SetEditableStatus()
    begin
        // Si "Status Name" est différent de 'SAISIE', alors non modifiable
        rec.CalcFields("Status Name");
        if rec."Status Name" <> 'SAISIE' then
            PaimentCaisseEditable := false
        else
            PaimentCaisseEditable := true;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        PaymentLine: Record "Payment Line";
    begin
        // Vérifie si le montant n'est pas égal à zéro
        if Rec."Amount (LCY)" <> 0 then begin
            Error('Impossible de supprimer cette Caisse Chantier car le montant n''est pas nul.');
            exit(false);
        end;
        // Forcer le statut à 0 pour permettre la suppression
        if Rec."Status No." > 0 then begin
            Rec."Status No." := 0;
            Rec.Modify(); // Met à jour le statut dans la table
        end;
        // Forcer le statut des lignes associées à 0

        PaymentLine.SetRange("No.", Rec."No.");
        if PaymentLine.FindSet() then
            repeat
                if PaymentLine."Status No." > 0 then begin
                    PaymentLine."Status No." := 0;
                    PaymentLine.Modify(true);
                end;
            until PaymentLine.Next() = 0;

        exit(true); // Autorise la suppression si le montant = 0
    end;
    /*procedure UpdateLinesAffaire(AffaireNo: Code[20])
    var
        LineRec: Record "Payment Line";
    begin
        LineRec.SetRange("No.", Rec."No."); // Filtre sur les lignes de l'entête
        if LineRec.FindSet() then
            repeat
                LineRec."N° Affaire" := AffaireNo;
                LineRec.Modify();
            until LineRec.Next() = 0;
    end;*/
}

