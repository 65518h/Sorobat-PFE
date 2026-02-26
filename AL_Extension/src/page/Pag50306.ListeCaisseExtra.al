page 50306 "Liste Caisse Extra"

{
    //GL2024 NEW PAGE
    Caption = 'Liste Caisse Extra';

    PageType = list;

    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Class" = CONST('ESPECES EXTERIEURE EMIS'), "Caisse Chantier" = CONST(false));
    ModifyAllowed = false;
    ApplicationArea = all;
    UsageCategory = lists;
    CardPageId = "Caisse Extra";
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
                field("Validé Par"; rec."Validé Par")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
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
                  }*/

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
    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Autoriser modif caisse extra" then
                Error(
                'Vous n''êtes pas autorisé à supprimer la caisse extra.'
                );
        end;
    end;

    trigger OnOpenPage()
    var
        RecUser: Record "User Setup";
        Text0011: Label 'You are not authorized for the Cash Receipt - Disbursement module.';
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
        //  // Currpage.Lines.FORM.EDITABLE(FALSE);
        // END
        //ELSE Currpage.EDITABLE(TRUE);

        //<< HJ DSFT 21-01-2009IF (Valider)   THEN
    end;

    trigger OnAfterGetRecord()
    var
        RecUser: Record "User Setup";
        Text011: Label 'Check Number %1 used more than once';
    begin
        RecUser.GET(UPPERCASE(USERID));
        // << HJ DSFT 08-11-2009
        IF RecUser.Niveau = 0 THEN ERROR(Text011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        // >> HJ DSFT 08 11 2010
    END;
}