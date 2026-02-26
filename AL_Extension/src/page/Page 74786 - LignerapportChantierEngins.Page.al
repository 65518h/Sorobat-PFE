Page 52049057 "Ligne rapport Chantier Engins2"
{
    PageType = listPart;
    SourceTable = "Job Report Line";
    SourceTableView = where(Resource = const(Equipment));
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the N° Tâche Projet field.', Comment = '%';
                }
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
                    Caption = 'Total Heurs';
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

