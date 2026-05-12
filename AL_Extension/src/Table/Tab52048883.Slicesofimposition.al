Table 52048883 "Slices of imposition"
{//GL2024  ID dans Nav 2009 : "39001405"
    Caption = 'Slices of imposition';
    LookupPageID = "Slices of imposition";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
        }
        field(2; "Code"; Code[4])
        {
        }
        field(3; "Lower limit"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Lower limit';

            trigger OnValidate()
            begin
                if ("Lower limit" < "Superior limit") then
                    "Slice amount" := ("Superior limit" - "Lower limit") * Rate / 100
                else
                    "Slice amount" := 0;
            end;
        }
        field(4; "Superior limit"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Superior limit';

            trigger OnValidate()
            begin
                if ("Lower limit" < "Superior limit") then
                    "Slice amount" := ("Superior limit" - "Lower limit") * Rate / 100
                else
                    "Slice amount" := 0;
            end;
        }
        field(5; Rate; Decimal)
        {
            Caption = 'Rate';

            trigger OnValidate()
            begin
                if ("Lower limit" < "Superior limit") then
                    "Slice amount" := ("Superior limit" - "Lower limit") * Rate / 100
                else
                    "Slice amount" := 0;
            end;
        }
        field(100; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
        }
        field(200; "Slice amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Slice amount';
            Editable = true;
        }
        field(50000; Taux; Decimal)
        {
            DecimalPlaces = 6 : 6;
        }
        field(50001; "Nombre*Nombre de part"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(8099198; "User ID"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(8099199; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
    }

    keys
    {
        key(STG_Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    var
        GestionNoSouche: Codeunit NoSeriesManagement;
        ParamGRH: Record "Human Resources Setup";
}

