Page 50167 "Alerte Echeance"
{
    PageType = List;
    SourceTable = "Vendor Ledger Entry";
    SourceTableView = sorting("Vendor No.", Open, Positive, "Due Date", "Currency Code")
                      where(Open = const(true),
                            "Document Type" = const(Invoice));
    ApplicationArea = all;
    Caption = 'Alerte Echeance';
    layout
    {
        area(content)
        {
            label(Control1)
            {
                ApplicationArea = all;
                Caption = 'ALERTE MONTANT ECHU';
                Style = Unfavorable;
                StyleExpr = true;
            }
            repeater(Control1100267000)
            {
                Editable = false;
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Vendor No."; REC."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; REC."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field("Remaining Amount"; REC."Remaining Amount")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Original Amt. (LCY)"; REC."Original Amt. (LCY)")
                {
                    ApplicationArea = all;
                }
            }

        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        REC.SetRange("Due Date", WorkDate + 10, WorkDate + 15);
        if REC.Count = 0 then CurrPage.Close;
    end;

    var
        Text19021135: label 'ALERTE MONTANT ECHU';
}

