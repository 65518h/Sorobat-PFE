PageExtension 50240 "Service Contract Sub_PagEXT" extends "Service Contract Subform"
{
    layout
    {
        modify("Service Item No.")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Serial No.")
        {
            Visible = false;
        }
        modify("Item No.")
        {
            Visible = false;
        }
        modify("Response Time (Hours)")
        {
            Visible = false;
        }
        modify("Next Planned Service Date")
        {
            Visible = false;
        }
        modify("Starting Date")
        {
            Visible = false;
        }


        addafter("Response Time (Hours)")
        {
            field(Quantity; rec.Quantity)
            {
                ApplicationArea = all;
            }
            field("Unit Cost"; rec."Unit Cost")
            {
                ApplicationArea = all;
            }
        }
        addafter("Line Cost")
        {
            field("Unit Price"; rec."Unit Price")
            {
                ApplicationArea = all;
            }
        }
        addafter(Profit)
        {
            field("Job No."; rec."Job No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Job Task No."; rec."Job Task No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }

}

