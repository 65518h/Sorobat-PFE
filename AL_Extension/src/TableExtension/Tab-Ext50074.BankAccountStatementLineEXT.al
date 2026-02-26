TableExtension 50074 "Bank Account Statement LineEXT" extends "Bank Account Statement Line"
{
    fields
    {
        field(8001402; "Source Type"; Option)
        {
            Caption = 'Type Source';
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ",Customer,Vendor;
        }
        field(8001403; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else
            if ("Source Type" = const(Vendor)) Vendor;
        }
        field(8001404; "Source Bank Account No."; Code[20])
        {
            Caption = 'Source Bank Account No.';
            TableRelation = if ("Source Type" = const(Customer)) "Customer Bank Account".Code where("Customer No." = field("Source No."))
            else
            if ("Source Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Source No."));
        }
        field(8001406; "Bill Type"; Option)
        {
            Caption = 'Bill Type';
            OptionCaption = ' ,Not Accepted,Accepted,BOR';
            OptionMembers = " ","Not Accepted",Accepted,BOR;
        }
        field(8001621; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(8001625; "External Document No."; Code[20])
        {
            Caption = 'N° Document Externe';
        }
    }
    keys
    {

        /*GL2024 key(Key3;"Bank Account No.","Statement No.","Due Date","Applied Amount")
         {
         SumIndexFields = "Statement Amount",Difference;
         }

         key(Key4;"Bank Account No.","Statement No.","Due Date")
         {
         SumIndexFields = "Statement Amount",Difference;
         }*/

        key(Key5; "Bank Account No.", "Statement No.", "Applied Amount")
        {
        }
    }
}

