TableExtension 50874 "Job Journal TemplateEXT" extends "Job Journal Template"
{
    fields
    {
        field(8003901; "Default Location Code"; Code[20])
        {
            Caption = 'Default Location Code';
            TableRelation = Location;
        }
    }
}