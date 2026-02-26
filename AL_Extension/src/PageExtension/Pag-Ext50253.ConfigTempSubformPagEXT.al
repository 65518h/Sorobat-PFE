PageExtension 50253 "Config. Temp. Subform_PagEXT" extends "Config. Template Subform"
{
    layout
    {
        addafter("Template Code")
        {
            field("Article de service"; Rec."Article de service")
            {
                ApplicationArea = all;
            }
            field("ID Champs Synchronisation"; Rec."ID Champs Synchronisation")
            {
                ApplicationArea = all;
            }
            field("Descrip Champs Synchronisation"; Rec."Descrip Champs Synchronisation")
            {
                ApplicationArea = all;
            }
        }
    }

}
