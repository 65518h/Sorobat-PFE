TableExtension 50098 "Item Application EntryEXT" extends "Item Application Entry"
{
    fields
    {
        field(50001; "No. Document Sortant"; Code[20])
        {
            CalcFormula = lookup("Item Ledger Entry"."Document No." where("Entry No." = field("Outbound Item Entry No.")));
            Description = 'HJ DSFT 27-03-2012';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Cout Total Document Entree"; Decimal)
        {
            CalcFormula = lookup("Value Entry"."Purchase Amount (Actual)" where("Item Ledger Entry No." = field("Inbound Item Entry No."),
                                                                                 "Item Ledger Entry Type" = const(Purchase),
                                                                                 "Cost Amount (Actual)" = filter(<> 0),
                                                                                 "Item Charge No." = filter(''),
                                                                                 "Entry Type" = const("Direct Cost")));
            Description = 'HJ DSFT 27-03-2012';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Quantité Achat Valorisé"; Decimal)
        {
            CalcFormula = lookup("Value Entry"."Valued Quantity" where("Item Ledger Entry No." = field("Inbound Item Entry No."),
                                                                        "Item Ledger Entry Type" = const(Purchase),
                                                                        "Cost Amount (Actual)" = filter(<> 0),
                                                                        "Item Charge No." = filter(''),
                                                                        "Entry Type" = const("Direct Cost")));
            Description = 'HJ DSFT 27-03-2012';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Cout Total Document Entre Prev"; Decimal)
        {
            CalcFormula = lookup("Value Entry"."Purchase Amount (Expected)" where("Item Ledger Entry No." = field("Inbound Item Entry No."),
                                                                                   "Item Ledger Entry Type" = const(Purchase),
                                                                                   "Cost Amount (Expected)" = filter(<> 0),
                                                                                   "Item Charge No." = filter(''),
                                                                                   "Entry Type" = const("Direct Cost"),
                                                                                   "Expected Cost" = const(true)));
            Description = 'HJ DSFT 27-03-2012';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Quantité Achat Valorisé Prev"; Decimal)
        {
            CalcFormula = lookup("Value Entry"."Valued Quantity" where("Item Ledger Entry No." = field("Inbound Item Entry No."),
                                                                        "Item Ledger Entry Type" = const(Purchase),
                                                                        "Cost Amount (Expected)" = filter(<> 0),
                                                                        "Item Charge No." = filter(''),
                                                                        "Entry Type" = const("Direct Cost"),
                                                                        "Expected Cost" = const(true)));
            Description = 'HJ DSFT 27-03-2012';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

