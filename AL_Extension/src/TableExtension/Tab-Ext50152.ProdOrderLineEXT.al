TableExtension 50152 "Prod. Order LineEXT" extends "Prod. Order Line"
{
    fields
    {



        /* GL2024   modify("Finished Quantity")
            {
                NotBlank = false;
            }*/

        /*GL2024    modify("Unit of Measure Code")
            {
                trigger OnAfterValidate()
                var
                    Item: Record item;
                begin
                    if Item.Get("Item No.") then
                        "Unit Cost" := Item."Last Direct Cost";
                end;
            }*/
        field(50000; "Largeur (M)"; Integer)
        {
            Description = 'HJ SORO 18-04-2016';

            trigger OnValidate()
            begin
                Dosage;
            end;
        }
        field(50001; "Longueur (M)"; Decimal)
        {
            Description = 'HJ SORO 18-04-2016';

            trigger OnValidate()
            begin
                Dosage;
            end;
        }
    }





    procedure Dosage()
    var
        FamilyLine: Record "Family Line";
    begin
        FamilyLine.SetRange("Item No.", "Item No.");
        if FamilyLine.FindFirst then begin
            Validate(Quantity, FamilyLine.Dosage * "Largeur (M)" * "Longueur (M)" / 1000);
            Modify;
        end;
    end;
}

