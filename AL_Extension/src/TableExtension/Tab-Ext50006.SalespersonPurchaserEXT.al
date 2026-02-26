TableExtension 50006 "Salesperson/PurchaserEXT" extends "Salesperson/Purchaser"
{
    fields
    {
        /*GL2024 modify(Name)
         {
             Editable = true;
         }*/

        field(8001900; "Sales Contract Gain/Loss Amt."; Decimal)
        {
            AutoFormatType = 1;
            //DYS table addon non migrer
            //CalcFormula = sum("Sales Contract Gain/Loss Entry".Amount where("Salesperson Code" = field(Code),
            //                                                               "Change Date" = field("Date Filter")));
            Caption = 'Contract Gain/Loss Amount';
            Editable = false;
            //FieldClass = FlowField;
        }
    }
}

