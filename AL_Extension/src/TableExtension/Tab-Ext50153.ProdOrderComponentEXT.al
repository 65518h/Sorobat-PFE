TableExtension 50153 "Prod. Order ComponentEXT" extends "Prod. Order Component"
{
    fields
    {

        modify(Description)
        {
            Description = 'Navibat';
        }

        field(50000; Centrale; Code[20])
        {
            CalcFormula = lookup("Production Order".Centrale where("No." = field("Prod. Order No."),
                                                                    Status = field(Status)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Date Bon Sortie"; Date)
        {
            CalcFormula = lookup("Production Order"."Due Date" where("No." = field("Prod. Order No."),
                                                                      Status = field(Status)));
            Editable = false;
            FieldClass = FlowField;
        }
    }


}

