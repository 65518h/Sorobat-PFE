page 52048935 Indemnities
{
    //GL2024  ID dans Nav 2009 : "39001456"
    Caption = 'Indemnities';
    DataCaptionFields = "Employee No.", Type;
    PageType = List;
    SourceTable = Indemnities;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Nom; Rec.Nom)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nom du salarié';
                    Editable = false;
                }
                field(Indemnity; Rec.Indemnity)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Base Amount"; Rec."Base Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Real Amount"; Rec."Real Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        Empl: Record Employee;
}

