Table 8001560 "Workflow Setup"
{
    //GL2024  ID dans Nav 2009 : "8004207"
    // #7296 SD 15/06/09 New Field Manage Employee Absence
    // //+WKF+ CW 03/08/02 Paramètres
    // //+WKF+ MB 11/09/06 Ajout info bulle + modif taille image

    Caption = 'Workflow Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Notify Sales Quote to Order"; Boolean)
        {
            Caption = 'Notify Sales Quote to Order';
        }
        field(3; "Purchases OnHold"; Boolean)
        {
            Caption = 'Purchase OnHold';
        }
        field(4; "Credit Limit Overflow"; Boolean)
        {
            Caption = 'Credit Limit Overflow';
        }
        field(5; "Release Purchase Document"; Boolean)
        {
            Caption = 'Release Purchase Document';
        }
        field(6; "Block New Item"; Boolean)
        {
            Caption = 'Block New Item';
        }
        field(7; "Generate Purchase Order"; Boolean)
        {
            Caption = 'Generate Purchase Order';
        }
        field(8; "Block New Resource"; Boolean)
        {
            Caption = 'Block New Resource';
        }
        field(29; Picture; Blob)
        {
            Caption = 'Picture 80x60mm';
            Description = '80x60mm';
            SubType = Bitmap;
        }
        field(30; "Manage Employee Absence"; Boolean)
        {
            Caption = 'Manage Employee Absence';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

