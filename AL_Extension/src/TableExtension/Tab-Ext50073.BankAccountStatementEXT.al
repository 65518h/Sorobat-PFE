TableExtension 50073 "Bank Account StatementEXT" extends "Bank Account Statement"
{
    fields
    {
        field(50000; "Nom Banque"; Text[50])
        {
            CalcFormula = lookup("Bank Account".Name where("No." = field("Bank Account No.")));
            Description = 'RB SORO 09/01/2017';
            FieldClass = FlowField;
        }
        field(8001401; "Handing-over Type"; Option)
        {
            Caption = 'Handing-over Type';
            OptionCaption = 'Cash,Discount,Discount In Retroactive Value,Credit After Cash,No Resident';
            OptionMembers = Cash,Discount,"Discount In Retroactive Value","Credit After Cash","No Resident";
        }
        field(8001402; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
        }
        field(8001403; "Handing-over Bank Code"; Code[20])
        {
            Caption = 'Handing-over Bank Code';
            TableRelation = "Bank Account"."No.";
        }
    }
}

