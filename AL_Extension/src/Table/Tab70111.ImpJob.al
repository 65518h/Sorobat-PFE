Table 70111 "Imp Job"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Search Description"; Code[50])
        {
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Description 2"; Text[50])
        {
        }
        field(5; "Bill-to Customer No."; Code[20])
        {
        }
        field(12; "Creation Date"; Date)
        {
        }
        field(13; "Starting Date"; Date)
        {
        }
        field(14; "Ending Date"; Date)
        {
        }
        field(15; "Completion Date"; Date)
        {
        }
        field(16; "Job Posting Date"; Date)
        {
        }
        field(17; "Recognition Date"; Date)
        {
        }
        field(18; "Completion %"; Decimal)
        {
        }
        field(19; Status; Option)
        {
            OptionMembers = Planning,Quote,"Order",Completed;
        }
        field(20; "Person Responsible"; Code[20])
        {
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
        }
        field(23; "Job Posting Group"; Code[10])
        {
        }
        field(24; Blocked; Boolean)
        {
        }
        field(28; "Recognition Method"; Option)
        {
            OptionMembers = "Percentage of Completion","Completed Contract";
        }
        field(29; "Last Date Modified"; Date)
        {
        }
        field(41; "Application Method"; Option)
        {
            OptionMembers = "Apply to Oldest",Manual;
        }
        field(42; "Job Usage Posting"; Option)
        {
            OptionMembers = "None",Costs,Prices;
        }
        field(57; Picture; Blob)
        {
        }
        field(66; "No. Series"; Code[10])
        {
        }
        field(82750; "Mask Code"; Code[10])
        {
        }
        field(8001301; "Criteria 1"; Code[20])
        {
        }
        field(8001302; "Criteria 2"; Code[20])
        {
        }
        field(8001303; "Criteria 3"; Code[20])
        {
        }
        field(8001304; "Criteria 4"; Code[20])
        {
        }
        field(8001305; "Criteria 5"; Code[20])
        {
        }
        field(8001306; "Criteria 6"; Code[20])
        {
        }
        field(8001307; "Criteria 7"; Code[20])
        {
        }
        field(8001308; "Criteria 8"; Code[20])
        {
        }
        field(8001309; "Criteria 9"; Code[20])
        {
        }
        field(8001310; "Criteria 10"; Code[20])
        {
        }
        field(8001428; Template; Code[10])
        {
        }
        field(8003900; Level; Integer)
        {
        }
        field(8003901; "Last Audit Date"; Date)
        {
        }
        field(8003910; "Job Address"; Text[30])
        {
        }
        field(8003911; "Job Address 2"; Text[30])
        {
        }
        field(8003912; "Job City"; Text[30])
        {
        }
        field(8003913; "Job County"; Text[30])
        {
        }
        field(8003914; "Job Post Code"; Code[20])
        {
        }
        field(8003915; "Job Country Code"; Code[10])
        {
        }
        field(8003916; Subject; Text[50])
        {
        }
        field(8003917; "Salesperson Code"; Code[10])
        {
        }
        field(8003918; "Distribution Type (Planning)"; Option)
        {
            OptionMembers = Manual,"Prorata temporis","Normal Curve";
        }
        field(8003920; "IC Partner Code"; Code[20])
        {
        }
        field(8003925; Finished; Boolean)
        {
        }
        field(8003926; "Intervention Zone Code"; Code[10])
        {
        }
        field(8003933; Summarize; Boolean)
        {
        }
        field(8003938; "Default Phase"; Code[10])
        {
        }
        field(8003939; "Intervention Zone Quantity"; Decimal)
        {
        }
        field(8003940; "Job Type"; Option)
        {
            OptionMembers = External,Internal,Stock;
        }
        field(8003941; "Driver Area Code"; Code[10])
        {
        }
        field(8003947; "Person Responsible 2"; Code[20])
        {
        }
        field(8003948; "Person Responsible 3"; Code[20])
        {
        }
        field(8003949; "Person Responsible 4"; Code[20])
        {
        }
        field(8003950; "Person Responsible 5"; Code[20])
        {
        }
        field(8003951; "Free Text 1"; Text[30])
        {
        }
        field(8003952; "Free Text 2"; Text[30])
        {
        }
        field(8003953; "Free Text 3"; Text[30])
        {
        }
        field(8003954; "Free Text 4"; Text[30])
        {
        }
        field(8003955; "Free Text 5"; Text[30])
        {
        }
        field(8003956; "Free Field 1"; Code[20])
        {
        }
        field(8003957; "Free Field 2"; Code[20])
        {
        }
        field(8003958; "Free Field 3"; Code[20])
        {
        }
        field(8003959; "Free Field 4"; Code[20])
        {
        }
        field(8003960; "Free Field 5"; Code[20])
        {
        }
        field(8003961; "Free Field 6"; Code[20])
        {
        }
        field(8003962; "Free Field 7"; Code[20])
        {
        }
        field(8003963; "Free Field 8"; Code[20])
        {
        }
        field(8003964; "Free Field 9"; Code[20])
        {
        }
        field(8003965; "Free Field 10"; Code[20])
        {
        }
        field(8003966; "Free Date 1"; Date)
        {
        }
        field(8003967; "Free Date 2"; Date)
        {
        }
        field(8003968; "Free Date 3"; Date)
        {
        }
        field(8003969; "Free Date 4"; Date)
        {
        }
        field(8003970; "Free Date 5"; Date)
        {
        }
        field(8003971; "Free Date 6"; Date)
        {
        }
        field(8003972; "Free Date 7"; Date)
        {
        }
        field(8003973; "Free Date 8"; Date)
        {
        }
        field(8003974; "Free Date 9"; Date)
        {
        }
        field(8003975; "Free Date 10"; Date)
        {
        }
        field(8003976; "Free Value 1"; Decimal)
        {
        }
        field(8003977; "Free Value 2"; Decimal)
        {
        }
        field(8003978; "Free Value 3"; Decimal)
        {
        }
        field(8003979; "Free Value 4"; Decimal)
        {
        }
        field(8003980; "Free Value 5"; Decimal)
        {
        }
        field(8003981; "Free Boolean 1"; Boolean)
        {
        }
        field(8003982; "Free Boolean 2"; Boolean)
        {
        }
        field(8003983; "Free Boolean 3"; Boolean)
        {
        }
        field(8003984; "Free Boolean 4"; Boolean)
        {
        }
        field(8003985; "Free Boolean 5"; Boolean)
        {
        }
        field(8003986; "Job Status"; Code[10])
        {
        }
        field(8004009; "Ship-to Contact"; Text[30])
        {
        }
        field(8004132; "Working Time Mode"; Option)
        {
            OptionMembers = ,"Order Line";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

