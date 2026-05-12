TableExtension 50100 "Analysis View EntryEXT" extends "Analysis View Entry"
{
    fields
    {
        field(50000; "Libelle CC"; Text[30])
        {
            // CalcFormula = lookup("Dimension Value".Name where (Code=field("Dimension 1 Value Code")));
            // FieldClass = FlowField;
        }
        field(50001; "Libelle Natures"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
}

