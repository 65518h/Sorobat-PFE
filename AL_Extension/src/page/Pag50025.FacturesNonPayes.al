page 50025 "Factures Non Payées"
{
    Editable = false;
    PageType = list;
    SourceTable = 25;
    SourceTableView = SORTING("Vendor No.", "Posting Date", "Currency Code") WHERE("Remaining Amount" = FILTER(<> 0), "Posting Date" = FILTER('01/01/14' ..), "Document Type" = CONST(Invoice));

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field("Posting Date"; rec."Posting Date")
                {
                }
                field("Vendor No."; rec."Vendor No.")
                {
                }
                field("Vendor.Name"; Vendor.Name)
                {
                    Caption = 'Nom';
                }
                field(Description; rec.Description)
                {
                }
                field("External Document No."; rec."External Document No.")
                {
                }
                field("Statut Facture"; rec."Statut Facture")
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Amount; rec.Amount)
                {
                }
                field("Remaining Amount"; rec."Remaining Amount")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF Vendor.GET(rec."Vendor No.") THEN;
    end;

    var
        Vendor: Record 23;
        NonFournisseur: Text[50];
}

