TableExtension 50173 "Item Statistics BufferEXT" extends "Item Statistics Buffer"
{
    fields
    {
        modify("Item Ledger Entry Type Filter")
        {
            Caption = 'Item Ledger Entry Type Filter';
        }
        field(8003915; "Job Invoiced Quantity"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Job Quantity" where("Item No." = field("Item Filter"),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Location Code" = field("Location Filter"),
                                                                  "Entry Type" = field("Entry Type Filter"),
                                                                  "Item Ledger Entry Type" = field("Item Ledger Entry Type Filter"),
                                                                  "Item Charge No." = field("Item Charge No. Filter"),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Source Type" = field("Source Type Filter"),
                                                                  "Source No." = field("Source No. Filter")));
            Caption = 'Job Invoiced Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003917; "Job Cost Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Value Entry"."Job Cost" where("Item No." = field("Item Filter"),
                                                              "Posting Date" = field("Date Filter"),
                                                              "Item Ledger Entry Type" = field("Item Ledger Entry Type Filter"),
                                                              "Entry Type" = field("Entry Type Filter"),
                                                              "Location Code" = field("Location Filter"),
                                                              "Variant Code" = field("Variant Filter"),
                                                              "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                              "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                              "Item Charge No." = field("Item Charge No. Filter"),
                                                              "Source Type" = field("Source Type Filter"),
                                                              "Source No." = field("Source No. Filter")));
            Caption = 'Job Cost Amount (Actual)';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

