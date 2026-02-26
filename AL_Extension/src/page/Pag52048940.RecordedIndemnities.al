page 52048940 "Recorded Indemnities"
{//GL2024  ID dans Nav 2009 : "39001461"
    Caption = 'Indemnités enreg.';
    DataCaptionFields = "Employee No.", Type;
    Editable = false;
    PageType = List;
    SourceTable = "Rec. Indemnities";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field(Indemnity; Rec.Indemnity)
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
                field("Base Amount"; Rec."Base Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = Basic;
                }
                field("Real Amount"; Rec."Real Amount")
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 0;
                }
            }
        }
    }

    actions
    {
    }
}

