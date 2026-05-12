Page 90015 "Export Forms"
{
    Caption = 'Export Forms';
    PageType = List;
    SourceTable = AllObj;
    //GL2024 SourceTable = object;
    SourceTableView = sorting("Object Type", "Object Name", "Object ID")
                      order(ascending)
                      where("Object Type" = const(page));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Type; rec."Object Type")
                {
                    ApplicationArea = Basic;
                }
                field("Company Name"; rec."Object Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ID; rec."Object ID")
                {
                    ApplicationArea = Basic;
                }
                field(Name; rec."Object Name")
                {
                    ApplicationArea = Basic;
                }
                /*GL2024  field(Caption; rec.Caption)
                  {
                      ApplicationArea = Basic;
                  }
                  field("Version List"; rec."Version List")
                  {
                      ApplicationArea = Basic;
                  }*/
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Export)
            {
                ApplicationArea = Basic;
                Caption = 'Export';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    lExportForm: Report 90010;
                begin
                    lExportForm.fSetObject(Rec);
                    //GL2024 lExportForm.USEREQUESTFORM := true;
                    lExportForm.RunModal;
                end;
            }
        }
    }
}

