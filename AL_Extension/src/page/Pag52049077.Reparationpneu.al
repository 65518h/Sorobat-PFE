Page 52049077 "Reparation pneu"
{//GL2024  ID dans Nav 2009 : "39004717"
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Reparation Pneu";
    ApplicationArea = All;
    Caption = 'Reparation pneu';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Type opétation"; Rec."Type opétation")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if (Rec."Type opétation" = 1) or (Rec."Type opétation" = 2) then
                            "Coût OpérationEditable" := false;
                    end;
                }
                field("N°Véhicule"; Rec."N°Véhicule")
                {
                    ApplicationArea = Basic;
                }
                field("Réf. Pneu"; Rec."Réf. Pneu")
                {
                    ApplicationArea = Basic;
                }
                field(Marque; Rec.Marque)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic;
                }
                field("Coût Opération"; Rec."Coût Opération")
                {
                    ApplicationArea = Basic;
                    Editable = "Coût OpérationEditable";
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        "Coût OpérationEditable" := true;
    end;

    var
        //GL3900   pneu: Record "Pneumatique Véhicule";
        [InDataSet]
        "Coût OpérationEditable": Boolean;
}

