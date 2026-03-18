Table 8001401 "Characteristic Code"
{
    // //+REF+CHARACT GESWAY 01/01/00 Table des types de caractéristiques complémentaires

    Caption = 'Characteristic code';
    //LookupPageID = 8001401;

    fields
    {
        field(1; "Table Name"; Option)
        {
            Caption = 'Table Name';
            OptionCaption = 'Account (G/L),Customer,Contact,Vendor,Item,Resource,Job,Fixed Asset,Employee';
            OptionMembers = "Account (G/L)",Customer,Contact,Vendor,Item,Resource,Job,"Fixed Asset",Employee;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Text,Option,Integer,Decimal,Boolean,Date';
            OptionMembers = Text,Option,"Integer",Decimal,Boolean,Date;
        }
        field(5; "Filter Group"; Text[80])
        {
            Caption = 'Group Filter';
            TableRelation = if ("Table Name" = filter("Account (G/L)")) "G/L Account"."No."
            else
            if ("Table Name" = filter(Customer)) "Customer Posting Group".Code
            else
            if ("Table Name" = filter(Contact)) Territory.Code
            else
            if ("Table Name" = filter(Vendor)) "Vendor Posting Group".Code
            else
            if ("Table Name" = filter(Item)) "Inventory Posting Group".Code
            else
            if ("Table Name" = filter(Resource)) "Resource Group"."No."
            else
            if ("Table Name" = filter(Job)) "Gen. Product Posting Group".Code
            else
            if ("Table Name" = filter("Fixed Asset")) "FA Class".Code
            else
            if ("Table Name" = filter(Employee)) "Employee Statistics Group".Code;
        }
    }

    keys
    {
        key(STG_Key1; "Table Name", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lOptionCaract: Record "Characteristic Option";


    begin
        lOptionCaract.SetRange("Table Name", "Table Name");
        lOptionCaract.SetRange("Characteristic code", Code);
        lOptionCaract.DeleteAll;
    end;
}

