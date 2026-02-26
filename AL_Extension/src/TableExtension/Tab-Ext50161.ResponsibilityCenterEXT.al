TableExtension 50161 "Responsibility CenterEXT" extends "Responsibility Center"
{
    fields
    {
        field(8001400; "Picture No."; Code[10])
        {
            Caption = 'Picture No.';
            DataClassification = ToBeClassified;
            TableRelation = "Header/Footer Logos"."No.";
        }
    }
}

