Table 8003913 "NaviBat Logo"
{
    // //NAVIBAT GESWAY 23/10/02 Nouvelle table, multi-company

    Caption = 'NaviBat Logo';
    DataPerCompany = false;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Navibat Picture"; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
    }

    keys
    {
        key(STG_Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //"Navibat Picture".IMPORT('S:\Marketing\Logos\Logo Navibat\Navibatlogo60.bmp');
        //GL2024 License  "Navibat Picture".Import('C:\Temp\Navibat.bmp');
    end;
}

