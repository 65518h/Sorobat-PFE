page 50309 "Liste Alimentations Caisse"
{

    //GL2024 NEW PAGE
    Caption = 'Liste Alimentations Caisse';
    PageType = list;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Class" = CONST('ALIMCAISS'));
    ApplicationArea = all;
    UsageCategory = lists;
    //  CardPageId = "Alimentations Caisse";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;

                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }

                field("Payment Class"; rec."Payment Class")
                {
                    ApplicationArea = all;
                    //   Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Solde Caisse"; rec."Solde Caisse")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Reouvrir; rec.Reouvrir)
                {
                    ApplicationArea = all;
                }


                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Aount Brouillards';
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        RecUser: Record "User Setup";
        Text0011: label 'You are not authorized for the Cash Collection - Disbursement module.';
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


        // << HJ DSFT 21-01-2009
    end;

    trigger OnAfterGetRecord()
    var
        RecUser: Record "User Setup";
        Text011: Label 'Check No. %1 used more than once';
    begin
        // << HJ DSFT 08-11-2009
        RecUser.GET(UPPERCASE(USERID));
        IF RecUser.Niveau = 0 THEN ERROR(Text011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        // >> HJ DSFT 08 11 2010
    end;
}