Page 50141 "Liste Factures A Simuler"
{
    Editable = true;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = sorting("Posting Date")
                      where("Document Type" = filter(Invoice));
    ApplicationArea = all;
    Caption = 'Liste Factures A Simuler';
    layout
    {
        area(content)
        {
            field(FilterDate; FilterDate)
            {
                ApplicationArea = all;
                Caption = 'Filter Date';

                trigger OnValidate()
                begin
                    FilterDateOnAfterValidate;
                end;
            }
            repeater(Control1)
            {
                Editable = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Invoice No."; REC."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Pay-to Vendor No."; REC."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Name"; REC."Pay-to Name")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; REC."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; REC."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Job No."; REC."Job No.")
                {
                    ApplicationArea = all;
                }
                field(Amount; REC.Amount)
                {
                    ApplicationArea = all;
                }
                field("Amount Including VAT"; REC."Amount Including VAT")
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
        REC.SetFilter("Posting Date", '<= %1', WorkDate - 30);
        if REC.Count = 0 then CurrPage.Close;
    end;

    var
        FilterDate: Date;

    local procedure FilterDateOnAfterValidate()
    begin
        if FilterDate <> 0D then begin
            REC.SetFilter("Posting Date", '<= %1', FilterDate);
            CurrPage.Update;
        end;
    end;
}

