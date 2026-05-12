page 52048896 "Employment Contracts List"
{
    //GL2024  ID dans Nav 2009 : "39001417"
    Caption = 'Employment Contracts';
    Editable = false;
    PageType = List;
    SourceTable = "Employment Contract";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Regular payments"; Rec."Regular payments")
                {
                    ApplicationArea = Basic;
                }
                field("Temporary payments"; Rec."Temporary payments")
                {
                    ApplicationArea = Basic;
                }
                field("Employee's type"; Rec."Employee's type")
                {
                    ApplicationArea = Basic;
                }
                field("Regimes of work"; Rec."Regimes of work")
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

