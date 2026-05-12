Table 8004144 "Job Task Standard"
{
    Caption = 'Job Task Standard';
    //LookupPageID = 8004146;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Task Code';
            NotBlank = true;

            trigger OnValidate()
            begin
                // Warning : FieldNo must be the same as JobTask ones (TransferFields by Suggest function)
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(1000; "Customer Filter Code"; Code[20])
        {
            Caption = 'Customer Filter';
            TableRelation = "Filter Header".Code where("Table ID" = const(18));
        }
        field(1001; "Job Filter Code"; Code[20])
        {
            Caption = 'Job Filter';
            TableRelation = "Filter Header".Code where("Table ID" = const(167));
        }
        field(8004106; "Frequency Code"; Code[10])
        {
            Caption = 'Frequency Code';
            TableRelation = "Job Task Period";
        }
        field(8004109; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            TableRelation = "Resource Group";

            trigger OnValidate()
            var
                lResourceGroup: Record "Resource Group";
            begin
                if lResourceGroup.Get("Resource Group No.") then
                    "Gen. Prod. Posting Group" := lResourceGroup."Gen. Prod. Posting Group";
            end;
        }
        field(8004112; "Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(8004113; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            var
                GenProdPostingGrp: Record "Gen. Product Posting Group";
            begin
            end;
        }
        field(8004115; External; Boolean)
        {
            Caption = 'External';
        }
        field(8004122; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(8004129; "Next Service Calc. Method"; Option)
        {
            Caption = 'Next Service Calc. Method';
            OptionCaption = 'Planned,Actual';
            OptionMembers = Planned,Actual;
        }
        field(8004131; Quantity; Decimal)
        {
            //blankzero = true;
            Caption = 'Quantity';
            DecimalPlaces = 0 : 2;
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

