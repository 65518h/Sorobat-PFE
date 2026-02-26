TableExtension 50024 "Company InformationEXT" extends "Company Information"
{
    fields
    {

        field(50000; "Matricule Fiscale"; Code[20])
        {
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50001; "Pied de page"; Blob)
        {
            Subtype = Bitmap;
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50002; "Entete de page"; Blob)
        {
            Subtype = Bitmap;
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50003; "Base Test"; Boolean)
        {
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50004; "N° CNSS"; Code[20])
        {
        }
        field(50005; Activite; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        //GL2024 Declaration Employeur

        field(60010; "Activite Contribuable"; text[40])
        {

        }
        field(8001400; "Picture No."; Code[10])
        {
            Caption = 'Picture No.';
            TableRelation = "Header/Footer Logos"."No.";
        }
        field(8001401; "Default Language Code"; Code[10])
        {
            Caption = 'Default Language Code';
            TableRelation = Language;
        }
    }
}

