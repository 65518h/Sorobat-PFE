page 50362 "Liste Caisse Chantier"
{
    //GL2024 NEW PAGE
    Caption = 'Liste Caisse Chantiers';
    DeleteAllowed = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Class" = CONST('ESPECES EXTERIEURE EMIS'), "Caisse Chantier" = CONST(true));
    ApplicationArea = all;
    CardPageId = "Caisse Chantier";
    UsageCategory = lists;







    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° Document';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field("Type paiement"; Rec."Type paiement")
                {
                    ApplicationArea = all;
                    Caption = 'Type paiement';

                }
                field(Utilisateur; Rec.Utilisateur)
                {
                    ApplicationArea = all;

                }
                /* field("Validé Par"; rec."Validé Par")
                 {
                     ApplicationArea = all;
                     Editable = false;
                 }*/
                /*  
                   field("Solde Caisse"; rec."Solde Caisse")
                   {
                       ApplicationArea = all;
                       Style = Unfavorable;
                       StyleExpr = TRUE;
                   }*/
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;

                }
                field(Approuver; Rec.Approuver)
                {
                    ApplicationArea = all;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }


                /*  field(Valider1; rec.Valider)
                  {
                      ApplicationArea = all;
                      Editable = false;
                      Style = Strong;
                      StyleExpr = TRUE;
                  }*/
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
                }

                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Montant DS';
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Agence; Rec.Agence)
                {
                    ApplicationArea = all;
                }
                field("Payment Class"; rec."Payment Class")
                {
                    ApplicationArea = all;
                    //  Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Status Name"; Rec."Status Name")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Bénéficiaire"; Rec."Bénéficiaire")
                {
                    ApplicationArea = all;
                }
                /* field("Account No.";Rec."Account No.")
                 {
                      ApplicationArea = all;
                 }*/
            }
        }

    }

    trigger OnOpenPage()
    var
        usersteup: Record "User Setup";
    begin
        // << HJ DSFT 21-01-2009
        RecUser.GET(UPPERCASE(USERID));
        IF RecUser.Niveau = 0 THEN ERROR(Text0011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        rec.SETRANGE("Account Type", rec."Account Type"::"Bank Account");


        //IF Valider=TRUE   THEN
        //  BEGIN
        //  Currpage.EDITABLE(FALSE);
        //  // Currpage.Lines.Page.EDITABLE(FALSE);
        // END
        //ELSE Currpage.EDITABLE(TRUE);

        //<< HJ DSFT 21-01-2009IF (Valider)   THEN

        /* GL2024 if UserSetup.Get(UserId) then begin
              AffaireCode := UserSetup."Affaire";

              /*  Rec.FilterGroup(2);
                Rec.SetRange("N° Affaire", AffaireCode);
                Rec.FilterGroup(0);*/

        // On verrouille le filtre en réinitialisant toujours la vue

        /*  Rec.SetView(STRSUBSTNO('WHERE("N° Affaire"=FILTER(%1))', AffaireCode));
      end;*/

        if usersteup.Get(UserId) then begin

            Rec.FilterGroup(0);
            rec.SetCurrentKey("No.");
            Rec.SetRange("N° Affaire", usersteup.Affaire);

            Rec.FilterGroup(2);
        end;


    end;

    trigger OnAfterGetCurrRecord()
    begin
        // Si l’utilisateur tente de changer le filtre, on le remet
        if rec.GetFilter("N° Affaire") <> AffaireCode then
            Rec.SetView(STRSUBSTNO('WHERE("N° Affaire"=FILTER(%1))', AffaireCode));
    end;

    trigger OnAfterGetRecord()
    begin
        // << HJ DSFT 08-11-2009
        IF RecUser.Niveau = 0 THEN ERROR(Text011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        // >> HJ DSFT 08 11 2010



    end;

    var
        UserSetup: Record "User Setup";
        AffaireCode: Code[20];
        RecUser: Record "User Setup";
        Text011: Label 'N° chèque %1 utlisé plus d''une fois';
        Text0011: Label 'Vous N''ete Pas Autorisé Au Module Encaissement - Decaissement';
        FiltreChantier: Option "",OACA,"PENETRANTE LOT2","PENETRANTE LOT3","BIZERTE BASE AERIEN","BIZERTE PONT LOT1","RAOUED","AUTOR SBIKHA LO5","AUT KEF RR173","OUED JOUMINE MATEUR","MEDJERDA BOUSALEM","RFR LOT1",RVE719BOUSSADIA;

}

