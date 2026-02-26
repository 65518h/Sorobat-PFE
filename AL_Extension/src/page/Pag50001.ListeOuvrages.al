Page 50001 "Liste Ouvrages"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = ListPart;
    Caption = 'Liste Ouvrages';
    SourceTable = Resource;
    SourceTableView = where(Type = const(Structure));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Intégrer"; rec.Intégrer)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("...")
            {
                ApplicationArea = all;
                Caption = '...';
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    Selection := StrMenu(Text001, 1);
                    if Selection = 0 then exit;
                    if Selection = 1 then begin
                        RecResource.Copy(Rec);
                        RecResource.ModifyAll(Intégrer, true);
                    end
                    else begin
                        RecResource.Copy(Rec);
                        RecResource.ModifyAll(Intégrer, false);
                    end;
                end;
            }
        }
    }

    var
        RecResource: Record Resource;
        Selection: Integer;
        Text001: label 'Assign All, Assign None';
}

