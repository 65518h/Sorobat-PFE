page 50312 "Liste Caisse Chantier 2"
{
    //GL2024 NEW PAGE
    Caption = 'Liste Caisse Chantier 2';
    DeleteAllowed = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Caisse Chantier" = CONST(true));

    //CardPageId = "Caisse Chantier 2";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° Document';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
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
                field(Valider; rec.Valider)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Validé Par"; rec."Validé Par")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
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

    }
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


        //IF Valider=TRUE   THEN
        //  BEGIN
        //  Currpage.EDITABLE(FALSE);
        //  // Currpage.Lines.Page.EDITABLE(FALSE);
        // END
        //ELSE Currpage.EDITABLE(TRUE);

        //<< HJ DSFT 21-01-2009IF (Valider)   THEN
    end;

    var
        RecUser: Record "User Setup";
        Text0011: Label 'Vous N''ete Pas Autorisé Au Module Encaissement - Decaissement';
        Text011: Label 'N° chèque %1 utlisé plus d''une fois';
}