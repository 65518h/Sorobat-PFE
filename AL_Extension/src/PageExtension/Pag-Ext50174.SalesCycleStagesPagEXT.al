PageExtension 50174 "Sales Cycle Stages_PagEXT" extends "Sales Cycle Stages"

{

    layout
    {
        addafter("Date Formula")
        {
            field("Campaign skip"; Rec."Campaign skip")
            {
                ApplicationArea = all;
            }
            field("Activate first stage"; Rec."Activate first stage")
            {
                ApplicationArea = all;
            }
            field("Estimate optional"; Rec."Estimate optional")
            {
                ApplicationArea = all;
            }
            field(Create; Rec.Create)
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    //+REF+OPPORT
                    "Interaction TemplateEDITABLE" := (rec.Create = rec.Create::Interaction);
                    //+REF+OPPORT//
                end;
            }
            field("Interaction Template"; Rec."Interaction Template")
            {
                Editable = "Interaction TemplateEDITABLE";
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }
    trigger OnAfterGetRecord()
    begin
        //+REF+OPPORT
        "Interaction TemplateEDITABLE" := (rec.Create = rec.Create::Interaction);
        //+REF+OPPORT//
    end;

    var
        "Interaction TemplateEDITABLE": Boolean;
}