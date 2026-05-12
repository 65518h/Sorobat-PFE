Page 50784 "Liste Condition de Pointage"
{//GL2024 NEW PAGE
    PageType = List;
    SourceTable = "Condition de Pointage";

    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Liste Condition de Pointage';


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;


                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }

}

