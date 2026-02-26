page 52048950 "Object list"
{//GL2024  ID dans Nav 2009 : "39001471"
    Editable = false;
    PageType = List;
    //GL2024 License SourceTable = "Object";
    SourceTable = AllObj;
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Object list';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(ID; Rec."Object ID")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec."Object Name")
                {
                    ApplicationArea = Basic;
                }
                /*   //GL2024 License   field(Compiled; Rec.Compiled)
                      {
                          ApplicationArea = Basic;
                      }
                      field("Version List"; Rec."Version List")
                      {
                          ApplicationArea = Basic;
                      } //GL2024 License*/
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

