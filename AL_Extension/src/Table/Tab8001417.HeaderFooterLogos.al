Table 8001417 "Header/Footer Logos"
{
    // //TRS-2009 XPE 08/12/09 Ajout du sous-type Bitmap à l'ensemble des champs BLOB
    // //+BGW+LOGO GESWAY 23/06/03 Table images documents

    Caption = 'Header/Footer Logos';
    //DrillDownPageID = 8001428;
    //LookupPageID = 8001428;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Header Picture"; Blob)
        {
            Caption = 'Header Picture';
            Description = 'Application du soustype au BLOB';
            SubType = Bitmap;
        }
        field(4; "Footer Picture"; Blob)
        {
            Caption = 'Footer Picture';
            Description = 'Application du soustype au BLOB';
            SubType = Bitmap;
        }
        field(6; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(7; "Picture Type"; Code[10])
        {
            Caption = 'Picture Type';
            Editable = false;
        }
        field(8; "Next Header Picture"; Blob)
        {
            Caption = 'Next Header Picture';
            Description = 'Application du soustype au BLOB';
            SubType = Bitmap;
        }
        field(9; "Next Footer Picture"; Blob)
        {
            Caption = 'Next Footer Picture';
            Description = 'Application du soustype au BLOB';
            SubType = Bitmap;
        }
    }

    keys
    {
        key(STG_Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    var
        Text000: label 'untitled';
        Text001: label 'Voulez-vous remplacer l''image existante ?';
        Text002: label 'Voulez-vous supprimer l''image ?';
}
