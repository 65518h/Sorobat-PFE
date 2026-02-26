page 50313 "Liste Caisse Comptable"
{
    //GL2024 NEW PAGE
    Caption = 'Caisse Comptable';

    DeleteAllowed = true;
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Class" = CONST('ESPECE COMPTABLE EMIS'), "Caisse Chantier" = CONST(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    CardPageId = "Caisse Comptable";

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
    trigger OnAfterGetRecord()
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
    ENd;

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
        rec.SETRANGE("Account Type", rec."Account Type"::"Bank Account");
    end;

    var
        Text011: Label 'N° chèque %1 utlisé plus d''une fois';
        Text0011: Label 'Vous N''ete Pas Autorisé Au Module Encaissement - Decaissement';
        RecUser: Record "User Setup";
}