Table 8001469 "Header/Footer Logos Setup"
{
    // #8676 CW 27/12/10
    // //+BGW+LOGO CW 27/12/10

    Caption = 'Header/Footer Logos Setup';
    //LookupPageID = 8001469;

    fields
    {
        field(1; "Report ID"; Integer)
        {
            //blankzero = true;
            Caption = 'Report ID';
            //GL2024 License   TableRelation = Object.ID where(Type = const(Report));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Report));
            //GL2024 License

            trigger OnValidate()
            begin
                CalcFields("Report Name");
            end;
        }
        field(2; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(3; "Picture No."; Code[10])
        {
            Caption = 'Picture No.';
            TableRelation = "Header/Footer Logos"."No.";
        }
        field(101; "Report Name"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report),
                                                                           "Object ID" = field("Report ID")));
            Caption = 'Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Report ID", "Responsibility Center")
        {
            Clustered = true;
        }
        key(STG_Key2; "Responsibility Center")
        {
        }
    }

    fieldgroups
    {
    }
}

