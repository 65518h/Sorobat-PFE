Page 52049060 "Ligne rapport Chantier Engins3"
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
                field(Statut; Rec.Statut) { ApplicationArea = all; }


                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the N° Tâche Projet field.', Comment = '%';
                }
                field("Task Description"; Rec."Task Description") { ApplicationArea = all; }
                field("Total Hours"; Rec."Total Hours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Heurs';
                    trigger OnValidate()
                    var
                        RecVehicule: Record "Véhicule";
                    begin
                        if RecVehicule.Get(Rec.Equipment) then
                            Rec."Qty Gasoil" := RecVehicule."Consommation Moyen" * Rec."Total Hours";


                    end;
                }
                field("Qty Gasoil"; Rec."Qty Gasoil")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty Gasoil field.', Comment = '%';
                }

                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Executed measurement"; Rec."Qté exécutées")
                {
                    ApplicationArea = all;
                    style = Favorable;
                }
                field(Rec; Rec."Executed Unit of Measure Code")
                {

                    ApplicationArea = All;
                    editable = false;
                    style = Favorable;
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

