Page 50419 "Ligne rapport Engins Archive"
{
    PageType = ListPart;
    SourceTable = "Job Report Line";
    SourceTableView = where(Resource = const(Equipment));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Equipment; Rec.Equipment)
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    ApplicationArea = Basic;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = Basic;
                }
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Total Hours"; Rec."Total Hours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Number day';
                }
                field("Qty Gasoil"; Rec."Qty Gasoil")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty Gasoil field.', Comment = '%';
                }
                field(Observation; Rec.Observation)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Resource := Rec.Resource::Equipment;
    end;
}

