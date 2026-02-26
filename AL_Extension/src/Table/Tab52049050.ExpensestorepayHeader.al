
Table 52049050 "Expenses to repay Header"
{
    //GL2024  ID dans Nav 2009 : "39001409"
    Caption = 'Mission expenses Heading';
    // DrillDownPageID = "Expenses to repay (List)";
    // LookupPageID = "Expenses to repay (List)";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; "Employee No."; Code[10])
        {
            Caption = 'Emplyee No.';
            TableRelation = Employee where(Status = const(Active));

            trigger OnValidate()
            begin
                if Salarié.Get("Employee No.") then begin
                    Validate("First Name", Salarié."First Name");
                    Validate("Last Name", Salarié."Last Name");
                    Validate("Employee Posting Group", Salarié."Employee Posting Group");
                    // RK
                    Validate("Global dimension 1", Salarié."Global Dimension 1 Code");
                    Validate("Global dimension 2", Salarié."Global Dimension 2 Code");
                    // RK
                end
            end;
        }
        field(3; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(5; "Employee Posting Group"; Code[10])
        {
            Caption = 'Employee Posting Group';
            Editable = false;
            TableRelation = "Employee Posting Group2";
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(20; "Total amount"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Expenses to repay Lines"."Line amount" where("No." = field("No.")));
            Caption = 'Total amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Document amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Document amount';
            Editable = false;
        }
        field(30; "Payment month"; Option)
        {
            Caption = 'Payment month';
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December,13rd,14th,Other';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Autre;

            trigger OnValidate()
            begin
                LnFraisMission.Reset;
                LnFraisMission.SetRange("No.", "No.");
                if LnFraisMission.Find('-') then
                    repeat
                        LnFraisMission."Payment year" := "Payment year";
                        LnFraisMission."Payment month" := "Payment month";
                        LnFraisMission.Modify;
                    until LnFraisMission.Next = 0;
            end;
        }
        field(31; "Payment year"; Integer)
        {
            Caption = 'Payment year';
            Editable = false;
        }
        field(32; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Proposed,Validated';
            OptionMembers = Proposed,Validated;
        }
        field(40; Repaied; Boolean)
        {
            Caption = 'Repaied';
            Editable = false;
        }
        field(41; "Payment No."; Code[10])
        {
            Caption = 'Payment No.';
            TableRelation = "Rec. Salary Headers";
        }
        field(50; "Global dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(51; "Global dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
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
        key(Key1; "No.")
        {
            Clustered = true;
            SumIndexFields = "Document amount";
        }
        key(Key2; Status, Repaied, "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Document amount";
        }
        key(Key3; Repaied, Status, "Payment year", "Payment month", "Employee No.", "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Document amount";
        }
        key(Key4; "Employee Posting Group", "Employee No.", "Payment No.", "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Document amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LnFraisMission.SetRange(LnFraisMission."No.", "No.");
        if LnFraisMission.Find('-') then
            LnFraisMission.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Expenses to repay Nos.");

            NoSeriesMgt.InitSeries(HumanResSetup."Expenses to repay Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Validate("Payment month", Date2dmy(WorkDate, 2) - 1);
        Validate("Payment year", Date2dmy(WorkDate, 3));

        "Last Date Modified" := WorkDate;
        "User ID" := UserId;

        "Document amount" := 0;
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
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "Salarié": Record Employee;
        LnFraisMission: Record "Expenses to repay Lines";


    procedure AssistEdit("AncEntêteFraisMission": Record "Expenses to repay Header"): Boolean
    begin
        with AncEntêteFraisMission do begin
            AncEntêteFraisMission := Rec;
            HumanResSetup.Get;
            HumanResSetup.TestField("Expenses to repay Nos.");
            if NoSeriesMgt.SelectSeries(HumanResSetup."Expenses to repay Nos.",
                                        AncEntêteFraisMission."No.",
                                        "No.")
             then begin
                HumanResSetup.Get;
                HumanResSetup.TestField("Expenses to repay Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := AncEntêteFraisMission;
                exit(true);
            end;
        end;
    end;
}

