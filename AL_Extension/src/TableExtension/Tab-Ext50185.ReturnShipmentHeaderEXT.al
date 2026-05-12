TableExtension 50185 "Return Shipment HeaderEXT" extends "Return Shipment Header"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            Caption = 'Buy-from Vendor No.';
        }
        modify("Buy-from Vendor Name")
        {
            Caption = 'Buy-from Vendor Name';
        }
        modify("Buy-from Vendor Name 2")
        {
            Caption = 'Buy-from Vendor Name 2';
        }
        modify("Buy-from Address")
        {
            Caption = 'Buy-from Address';
        }
        modify("Buy-from Address 2")
        {
            Caption = 'Buy-from Address 2';
        }
        modify("Buy-from City")
        {
            Caption = 'Buy-from City';
        }
        modify("Buy-from Contact")
        {
            Caption = 'Buy-from Contact';
        }
        modify("Buy-from Post Code")
        {
            Caption = 'Buy-from Post Code';
        }
        modify("Buy-from County")
        {
            Caption = 'Buy-from County';
        }
        modify("Buy-from Country/Region Code")
        {
            Caption = 'Buy-from Country/Region Code';
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'Modification TableRelation';
            TableRelation = Job;

            trigger OnValidate()
            var
                lContributor: Record "Sales Contributor";
                lContributor2: Record "Sales Contributor";
                lJobStatusMgt: Codeunit "Job Status Management";
                lJobStatus: Record "Job Status";
            begin
            end;
        }
    }
}

