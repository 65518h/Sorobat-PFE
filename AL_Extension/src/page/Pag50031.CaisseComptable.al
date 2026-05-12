page 50031 "Caisse Comptable"
{
    // //>>>MBK:05/02/2010: Référence chèque
    // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs

    Caption = 'Caisse Comptable';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    // SourceTableView = WHERE("Payment Class" = CONST('CAISSECPT')); 
    SourceTableView = WHERE("Payment Class" = CONST('ESPECE COMPTABLE EMIS'), "Caisse Chantier" = CONST(false));
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {

            field("No."; rec."No.")
            {
                Caption = 'N° Brouillars';
                Editable = false;
                Style = Unfavorable;
                StyleExpr = TRUE;
                ApplicationArea = all;
            }
            // field("Document Date"; rec."Document Date")
            // {
            //     Caption = 'Fog Date';
            //     ApplicationArea = all;
            // }


            field("Payment Class"; rec."Payment Class")
            {
                Editable = false;
                Style = Favorable;
                StyleExpr = TRUE;
                ApplicationArea = all;
            }
            field("Solde Caisse"; rec."Solde Caisse")
            {
                Style = Unfavorable;
                StyleExpr = TRUE;
                ApplicationArea = all;
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
                Editable = IsPageEditable;
                Caption = 'Date Brouillards';
            }
            field("Account No."; rec."Account No.")
            {
                ApplicationArea = all;

                Style = Strong;
                StyleExpr = TRUE;
            }
            field("Validé Par"; rec."Validé Par")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Reouvrir; rec.Reouvrir)
            {
                ApplicationArea = all;
            }

            part(Lines; "Ligne Paiement CPT")
            {
                // Editable = PaimentCaisseEditable;
                ApplicationArea = all;
                Caption = 'Ligne Paiement CPT';
                UpdatePropagation = Both;
                SubPageLink = "No." = FIELD("No.");
                Editable = IsPageEditable;
            }

            field("Amount (LCY)"; rec."Amount (LCY)")
            {
                ApplicationArea = all;
                Caption = 'Montant Brouillards';
                DecimalPlaces = 3 : 2;
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
            actionref("Imprimer Brouillard De Caisse1"; "Imprimer Brouillard De Caisse")
            {

            }
            group("Posting")
            {
                Caption = 'Validation';

                actionref(Printing1; Printing)
                {

                }
                actionref("Generate file1"; "Generate file")
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
                Image = Print;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    PaymentLine.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"Brouillard de Caisse", TRUE, TRUE, PaymentLine);
                end;
            }
            action("Bordereau Chéques Banque")
            {
                Caption = 'Bordereau Chéques Banque';
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(REPORT::"Bureau Ordre", TRUE, TRUE, PaymentLine);
                end;
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                /* action(Insertion)
                 {
                     ApplicationArea = all;
                     Caption = 'Insertion';

                     trigger OnAction()
                     begin
                         IF GeneralLedgerSetup.GET THEN;
                         IF NOT CONFIRM(Text016) THEN EXIT;
                         RecEntetePayement.INIT;
                         IF RecPaymentClass.GET(GeneralLedgerSetup."Type Caisse CPT") THEN;
                         RecEntetePayement."No." := NoSeriesMgt.GetNextNo(RecPaymentClass."Header No. Series", 0D, TRUE);
                         RecEntetePayement.VALIDATE("Posting Date", TODAY);
                         RecEntetePayement.VALIDATE("Document Date", TODAY);
                         RecEntetePayement.VALIDATE("Payment Class", GeneralLedgerSetup."Type Caisse CPT");
                         RecEntetePayement.VALIDATE("Account Type", RecEntetePayement."Account Type"::"Bank Account");
                         RecEntetePayement.VALIDATE("Account No.", GeneralLedgerSetup.Caisse);
                         RecEntetePayement."Date Création" := CURRENTDATETIME;
                         RecEntetePayement."Créer par" := COPYSTR(USERID, 1, 20);
                         RecEntetePayement.Utilisateur := COPYSTR(USERID, 1, 20);
                         RecEntetePayement.INSERT;
                         IF rec.FINDLAST THEN;
                     end;
                 }*/
                action(Printing)
                {
                    Caption = 'Imprimer';
                    ApplicationArea = all;
                    Image = Print;
                    trigger OnAction()
                    var
                        Text1: Label 'Il n’y a aucune ligne à traiter';
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

                        CurrPage.Lines.page.MarkLines(TRUE);
                        ValidatePayment(true);
                        CurrPage.Lines.page.MarkLines(FALSE);
                    end;
                }
                action("Generate file")
                {
                    Caption = 'Générer fichier';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        Text1: Label 'Il n’y a aucune ligne à traiter';
                    begin
                        //GL2024 License   rec.TestNbOfLines;
                        rec.CalcFields("No. of Lines");
                        if rec."No. of Lines" = 0 then
                            Error(Text1);

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
                    ApplicationArea = all;
                    Image = Post;
                    trigger OnAction()
                    var
                        Text1: Label 'Il n’y a aucune ligne à traiter';
                    begin

                        //>>>MBK:05/02/2010: Référence chèque
                        /* {
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
                            }*/
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



                        //GL2024 License   rec.TestNbOfLines;
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
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        //    SetEditableStatus;
        CurrPage.Lines.page.EDITABLE(TRUE);
        CurrPage.Lines.PAGE.DisableFields(rec."No.");
    end;

    trigger OnAfterGetRecord()
    var
        UserSetup: record "User Setup";
    begin


        CurrPage.Lines.page.EDITABLE(TRUE);
        CurrPage.Lines.PAGE.DisableFields(rec."No.");
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
        //    SetEditableStatus;

        if UserSetup.Get(UserId) then begin
            if UserSetup."Autoriser modif caisse extra" then
                IsPageEditable := true;
        end;
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
    var
        UserSetup: record "User Setup";
    begin
        CurrPage.Lines.page.EDITABLE(TRUE);
        CurrPage.Lines.PAGE.DisableFields(rec."No.");
        // << HJ DSFT 21-01-2009
        RecUser.GET(UPPERCASE(USERID));
        IF RecUser.Niveau = 0 THEN ERROR(Text0011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        rec.SETRANGE("Account Type", rec."Account Type"::"Bank Account");


        // << HJ DSFT 21-01-2009
        // SetEditableStatus;

        rec."Date Création" := CURRENTDATETIME;
        rec."Créer par" := COPYSTR(USERID, 1, 20);
        rec.Utilisateur := COPYSTR(USERID, 1, 20);

        if UserSetup.Get(UserId) then begin
            if UserSetup."Autoriser modif caisse extra" then
                IsPageEditable := true;
        end;
    end;

    var
        //DYS
        //  ChangeExchangeRate: Page 511;
        IsPageEditable: Boolean;
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
        //  RecAgence: Record "Chantier Loyer";
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
        Text016: Label 'New Fog ?';
        Process: Record 10860;
        PaimentCaisseEditable: Boolean;


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
        if not PrintOrPost then
            Steps.SetFilter(
                              "Action Type",
                              '%1|%2|%3',
                              Steps."Action Type"::None, Steps."Action Type"::Ledger, Steps."Action Type"::"Cancel File");
        PostingStatement.ProcessPaymentSteps(Rec, Steps);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        rec."Payment Class" := 'ESPECE COMPTABLE EMIS';
        // >> HJ DSFT 21-01-2009
        if Process.get(rec."Payment Class") then begin
            //>> HJ SOROT 16-06-2014
            IF Process.EXT THEN BEGIN
                rec."Account Type" := rec."Account Type"::"Bank Account";
                rec.VALIDATE("Account No.", Process."Caisse Par Defaut");
            END;
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
}

