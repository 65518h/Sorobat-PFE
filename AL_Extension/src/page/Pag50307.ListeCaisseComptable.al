page 50307 "Liste Caisse Comptable2"

{
    //GL2024 NEW PAGE

    Caption = 'Liste Caisse Comptable';
    PageType = list;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Class" = CONST('CAISSECPT'));
    ApplicationArea = all;
    UsageCategory = lists;
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
                    Caption = 'Fog No.';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Document Date"; rec."Document Date")
                {
                    Caption = 'Fog Date';
                    ApplicationArea = all;
                }
                field("Account No."; rec."Account No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }

                field("Payment Class"; rec."Payment Class")
                {
                    // Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Solde Caisse"; rec."Solde Caisse")
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field(Reouvrir; rec.Reouvrir)
                {
                    ApplicationArea = all;
                }



                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Fog Amount';
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }

            }
        }
    }



    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Payment Class" := 'CAISSECPT';
    end;
}