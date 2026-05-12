Table 2000040 "CODA Statement"
{
    Caption = 'CODA Statement';
    DataCaptionFields = "Bank Account No.", "Statement No.";
    // LookupPageID = 2000042;

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            NotBlank = true;
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if "Statement No." = '' then begin
                    BankAcc.Get("Bank Account No.");
                    "Statement No." := IncStr(BankAcc."Last Statement No.");
                    "Balance Last Statement" := BankAcc."Balance Last Statement";
                end;
            end;
        }
        field(2; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            NotBlank = true;
        }
        field(3; "Statement Ending Balance"; Decimal)
        {
            Caption = 'Statement Ending Balance';
        }
        field(4; "Statement Date"; Date)
        {
            Caption = 'Statement Date';
        }
        field(5; "Balance Last Statement"; Decimal)
        {
            Caption = 'Balance Last Statement';
        }
        field(6; "CODA Statement No."; Integer)
        {
            Caption = 'CODA Statement No.';
        }
        field(7; Information; Integer)
        {
            BlankNumbers = BlankZeroAndPos;
            //blankzero = true;
            CalcFormula = count("CODA Statement Line" where("Bank Account No." = field("Bank Account No."),
                                                             "Statement No." = field("Statement No."),
                                                             ID = const("Free Message"),
                                                             "Attached to Line No." = const(0)));
            Caption = 'Information';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Bank Account No.", "Statement No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CodBankStmtLine.Reset;
        CodBankStmtLine.SetRange("Bank Account No.", "Bank Account No.");
        CodBankStmtLine.SetRange("Statement No.", "Statement No.");
        CodBankStmtLine.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        TestField("Bank Account No.");
        TestField("Statement No.");
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Text000: label 'You cannot rename a %1.';
        BankAcc: Record "Bank Account";
        CodBankStmt: Record "CODA Statement";
        CodBankStmtLine: Record "CODA Statement Line";
}

