Table 52048891 "Loan & Advance Entry"
{//GL2024  ID dans Nav 2009 : "39001415"
    Caption = 'Loan & Advance Entry';
    DrillDownPageID = "Détail Prêt Avance";
    LookupPageID = "Détail Prêt Avance";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; Employee; Code[10])
        {
            Caption = 'Employee';
            Editable = false;
            TableRelation = Employee;
        }
        field(3; Name; Text[60])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(4; "Employee Posting Group"; Code[30])
        {
            Caption = 'Employee Posting Group';
            Editable = false;
            TableRelation = "Employee Posting Group2";
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            Editable = true;
            OptionCaption = 'Advance,Loan';
            OptionMembers = Advance,Loan;
        }
        field(6; "Document type"; Code[10])
        {
            Caption = 'Document type';
            Editable = true;
            TableRelation = "Loan & Advance Type" where(Type = field(Type));
        }
        field(7; "Entry type"; Option)
        {
            Caption = 'Entry type';
            OptionCaption = 'Paiment,Repaiment';
            OptionMembers = Paiment,Repaiment;
        }
        field(10; Amount; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Amount';
            Editable = true;
        }
        field(20; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'In progress,Enclosed';
            OptionMembers = "In progress",Enclosed;
        }
        field(21; Month; Option)
        {
            Caption = 'Month';
            Editable = false;
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December,13rd,14th,Other';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Autre;
        }
        field(22; Year; Integer)
        {
            Caption = 'Year';
            Editable = false;
        }
        field(23; "Date Paie"; Date)
        {
        }
        field(25; "Payment No."; Code[10])
        {
            Caption = 'Payment No.';
            Editable = true;
        }
        field(30; "Global dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(31; "Global dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(8099197; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
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
        field(39001495; "Avance Repas"; Boolean)
        {
        }
        field(39001496; "Employee Statistic Group"; Code[30])
        {
            Caption = 'Employee Posting Group';
            Editable = false;
            TableRelation = Employee;
        }
        field(39001497; direction; Code[10])
        {
        }
        field(39001498; service; Code[10])
        {
        }
        field(39001499; section; Code[10])
        {
        }
    }

    keys
    {
        key(STG_Key1; "No.", "Entry No.")
        {
            Clustered = true;
        }
        key(STG_Key2; Status, Type, Employee, "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = Amount;
        }
        key(STG_Key3; "Document type", "Employee Posting Group", Employee, "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = Amount;
        }
        key(STG_Key4; Status, Type, Employee, "Last Date Modified", "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = Amount;
        }
        key(STG_Key5; "No.", Employee, "Entry No.")
        {
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
}

