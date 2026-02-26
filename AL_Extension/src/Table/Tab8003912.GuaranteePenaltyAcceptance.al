Table 8003912 "Guarantee,Penalty & Acceptance"
{
    // //PROJET GESWAY 30/09/02 Nouvelle table des dates de caution, pénalités, réceptions provisoires

    Caption = 'Guarantee,Penalty & Acceptance';

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            NotBlank = true;
            TableRelation = Job;
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Guarantee,Penalty,Provisional Acceptance';
            OptionMembers = Guarantee,Penalty,"Provisional Acceptance";
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            NotBlank = true;
        }
        field(4; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(5; "Amount LCY"; Decimal)
        {
            //blankzero = true;
            Caption = 'Amount (LCY)';
        }
        field(6; "Official Acceptance Date"; Date)
        {
            Caption = 'Official Acceptance Date';
        }
        field(7; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(8; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(9; Open; Boolean)
        {
            Caption = 'Open';
            InitValue = true;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Job No.")
        {
            Clustered = true;
        }
        key(Key2; "Job No.", Type, Open, Date)
        {
            SumIndexFields = "Amount LCY";
        }
        key(Key3; Open, "Due Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //??TESTFIELD(Date);
        if Guarantee.Find('+') then
            "Entry No." := Guarantee."Entry No." + 1
        else
            "Entry No." := 1;
    end;

    var
        Guarantee: Record "Guarantee,Penalty & Acceptance";
}

