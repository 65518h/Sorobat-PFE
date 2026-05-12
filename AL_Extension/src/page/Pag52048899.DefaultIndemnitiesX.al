page 52048899 "Default IndemnitiesX"
{
    //GL2024  ID dans Nav 2009 : "39001420"
    Editable = false;
    PageType = list;
    SourceTable = "Default Indemnities";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Default IndemnitiesX';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Indemnity Code"; Rec."Indemnity Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation mode"; Rec."Evaluation mode")
                {
                    ApplicationArea = Basic;
                }
                field("Basis amount"; Rec."Basis amount")
                {
                    ApplicationArea = Basic;
                }
                field("Default amount"; Rec."Default amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

