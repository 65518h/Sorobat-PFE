
Table 52049051 "Expenses to repay Lines"
{//GL2024  ID dans Nav 2009 : "39001410"
    Caption = 'Mission expenses Lines';
    // DrillDownPageID = "Expenses to repay Lines List";
    // LookupPageID = "Expenses to repay Lines List";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Editable = false;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';

            trigger OnValidate()
            begin
                if EnTeteFraisMission.Get("No.") then begin
                    if (
                      (((Date2dmy(Date, 2) - 1) > EnTeteFraisMission."Payment month") and ((Date2dmy(Date, 3)) > EnTeteFraisMission."Payment year"))
                      or
                      (Date2dmy(Date, 3) > EnTeteFraisMission."Payment year")
                      or
                      (((Date2dmy(Date, 2) - 1) > EnTeteFraisMission."Payment month") and ((Date2dmy(Date, 3)) = EnTeteFraisMission."Payment year"))
                      or
                      (((Date2dmy(Date, 2) - 1) = EnTeteFraisMission."Payment month") and ((Date2dmy(Date, 3)) > EnTeteFraisMission."Payment year"))
                       ) then begin
                        EnTeteFraisMission.Reset;
                        EnTeteFraisMission."Payment month" := Date2dmy(Date, 2) - 1;
                        EnTeteFraisMission."Payment year" := Date2dmy(Date, 3);
                        EnTeteFraisMission.Modify;
                    end;
                end;
            end;
        }
        field(4; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";

            trigger OnValidate()
            begin
                if CodeMotif.Get("Reason Code") then
                    Description := CodeMotif.Description;
            end;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(20; "Line amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Line amount';
        }
        field(30; "Payment month"; Option)
        {
            Caption = 'Payment month';
            Editable = false;
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December,13rd,14th,Other';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Autre;
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
        key(STG_Key1; "No.", "Entry No.")
        {
            Clustered = true;
            SumIndexFields = "Line amount";
        }
        key(STG_Key2; Date)
        {
            SumIndexFields = "Line amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;

        if EnTeteFraisMission.Get("No.") then begin
            "Payment month" := EnTeteFraisMission."Payment month";
            "Payment year" := EnTeteFraisMission."Payment year";
        end;

        ExpensesRepayLines.SetRange("No.", "No.");
        if ExpensesRepayLines.Find('+') then
            "Entry No." := ExpensesRepayLines."Entry No." + 10000
        else
            "Entry No." := 10000
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
        EnTeteFraisMission: Record "Expenses to repay Header";
        CodeMotif: Record "Reason Code";
        ExpensesRepayLines: Record "Expenses to repay Lines";
}

