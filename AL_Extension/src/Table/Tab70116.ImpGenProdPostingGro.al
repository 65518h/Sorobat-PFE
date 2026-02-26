Table 70116 "Imp Gen. Prod. Posting Gro"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Def. VAT Prod. Posting Group"; Code[10])
        {
        }
        field(4; "Auto Insert Default"; Boolean)
        {
        }
        field(8001405; "Default Type"; Option)
        {
            OptionMembers = Resource,Item,"Account (G/L)","Group (Resource)";
        }
        field(8003900; "Bal. Job No."; Code[20])
        {
        }
        field(8003901; Summarize; Boolean)
        {
        }
        field(8003902; Totaling; Text[50])
        {
        }
        field(8003903; Indentation; Integer)
        {
        }
        field(8003910; "Job Totaling"; Code[50])
        {
        }
        field(8003911; "Entry Type"; Option)
        {
            OptionMembers = ,Usage,Sale;
        }
        field(8004057; "Overhead Rate"; Decimal)
        {
        }
        field(8004058; "Margin Rate"; Decimal)
        {
        }
        field(8004059; "Person Unit Cost"; Decimal)
        {
        }
        field(8004068; "New Cost Forecast"; Decimal)
        {
        }
        field(8004069; "New Rest To Be Done"; Decimal)
        {
        }
        field(8004073; "New Budget Difference"; Decimal)
        {
        }
        field(8004083; "Rule Overhead Rate"; Decimal)
        {
        }
        field(8004084; "Rule Margin Rate"; Decimal)
        {
        }
        field(8004085; "Overhead Calculation Method"; Option)
        {
            OptionMembers = "Amount %","Person Quantity";
        }
        field(8004086; "Margin Calculation Method"; Option)
        {
            OptionMembers = "Amount %",Quantity;
        }
        field(8004131; "Resource Type"; Option)
        {
            OptionMembers = ,Person,Machine;
        }
        field(8004132; "Work Type Default"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

