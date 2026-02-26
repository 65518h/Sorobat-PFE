table 52048922 "FOR-Centres Formations"
{
    //GL2024  ID dans Nav 2009 : "39001471"

    //  DrillDownPageID = "FOR-Centres Formations";
    //  LookupPageID = "FOR-Centres Formations";

    fields
    {
        field(1; "Code"; Code[10])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            var
                RecLVendor: Record 23;
            begin
                IF RecLVendor.GET(Code) THEN BEGIN
                    Description := RecLVendor.Name;
                    Address := RecLVendor.Address;
                    "Address 2" := RecLVendor."Address 2";
                    City := RecLVendor.City;
                    "Post Code" := RecLVendor."Post Code";
                    County := RecLVendor.County;
                    "Phone No." := RecLVendor."Phone No.";
                    //"Web site":=
                    "Fax No." := RecLVendor."Fax No.";
                    "E-Mail" := RecLVendor."E-Mail";
                    "Country Code" := RecLVendor."Country/Region Code";
                END;
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Désignation';
        }
        field(3; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(4; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(5; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //GL2024   PostCode.LookUpCity(City, "Post Code", TRUE);
            end;

            trigger OnValidate()
            begin
                //GL2024     PostCode.ValidateCity(City, "Post Code");
            end;
        }
        field(6; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //GL2024    PostCode.LookUpPostCode(City, "Post Code", TRUE);
            end;

            trigger OnValidate()
            begin
                //GL2024    PostCode.ValidatePostCode(City, "Post Code");
            end;
        }
        field(7; County; Text[30])
        {
            Caption = 'County';
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(9; "Web site"; Text[50])
        {
            Caption = 'Site web';
        }
        field(10; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(11; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE(Code = FIELD(Code)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(14; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External';
            OptionMembers = ,Internal,External;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record 225;
}

