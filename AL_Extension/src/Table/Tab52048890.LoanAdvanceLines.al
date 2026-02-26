Table 52048890 "Loan & Advance Lines"
{//GL2024  ID dans Nav 2009 : "39001414"
    Caption = 'Loan & Advance Lines';
    DrillDownPageID = "Repayment lines";
    LookupPageID = "Repayment lines";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "Loan & Advance Header";
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; Employee; Code[10])
        {
            Caption = 'Employee';
            TableRelation = Employee;
        }
        field(5; "Employee Posting Group"; Code[30])
        {
            Caption = 'Employee Posting Group';
            Editable = false;
            TableRelation = "Employee Posting Group2";
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Advance,Loan';
            OptionMembers = Advance,Loan;
        }
        field(7; "Document type"; Code[10])
        {
            Caption = 'Document type';
            TableRelation = "Loan & Advance Type" where(Type = field(Type));
        }
        field(10; "Line Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Line Amount';

            trigger OnValidate()
            begin
                if Header.Get("No.") then begin
                    "Line %" := ("Line Amount" / Header."Total to repay") * 100
                end
            end;
        }
        field(11; "Line %"; Decimal)
        {
            Caption = 'Line %';

            trigger OnValidate()
            begin
                if Header.Get("No.") then begin
                    "Line Amount" := ("Line %" * Header."Total to repay") / 100
                end
            end;
        }
        field(20; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
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
        field(30; "Payment No."; Code[20])
        {
            Caption = 'Payment No.';
            Editable = false;
            TableRelation = if (Paid = filter(false)) "Salary Headers"
            else
            if (Paid = filter(true)) "Rec. Salary Headers";
        }
        field(31; Paid; Boolean)
        {
            Caption = 'Paié';
            Editable = false;
        }
        field(32; "Global dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(33; "Global dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50; "Principal Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Montant Principale';
        }
        field(51; "Interest Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Montant Interêt';
        }
        /*  field(50000; "Pret CNSS"; Option)
          {
              CalcFormula = lookup("Loan & Advance Header"."Pret CNSS" where("No." = field("No.")));
              Editable = false;
              FieldClass = FlowField;
              OptionMembers = " ",Logement,Voiture,Cession;
          }
          field(50001; "Remboursement Anticipé"; Boolean)
          {
          }*/
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
        field(39001405; "Type Compte"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Employee;
        }
        field(39001406; "N° Compte"; Code[20])
        {
        }
        field(39001407; "N° Doc Extern"; Code[20])
        {
        }
        field(39001408; "Date comptabilisation"; Date)
        {
        }
        field(39001495; "Avance Repas"; Boolean)
        {
        }
        field(39001496; "Employee Statistic Group"; Code[30])
        {
            Caption = 'Employee Posting Group';
            Editable = false;
            TableRelation = "Employee Statistics Group";
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
        key(Key1; "No.", "Entry No.")
        {
            Clustered = true;
            SumIndexFields = "Line Amount", "Line %";
        }
        key(Key2; "Document type", "Employee Posting Group", "Payment No.", Status, Type, Employee, "Global dimension 1", "Global dimension 2", "Employee Statistic Group")
        {
            SumIndexFields = "Line Amount", "Line %";
        }
        key(Key3; "Payment No.", Status, Type, Employee)
        {
            SumIndexFields = "Line Amount", "Line %";
        }
        key(Key4; "No.", Status, Type, Employee)
        {
            SumIndexFields = "Line Amount", "Line %", "Principal Amount", "Interest Amount";
        }
        key(Key5; "Payment No.", Paid, Employee)
        {
            SumIndexFields = "Line Amount", "Line %", "Principal Amount", "Interest Amount";
        }
        key(Key6; "No.", Status, Type, Employee, Paid)
        {
            SumIndexFields = "Line Amount", "Line %", "Principal Amount", "Interest Amount";
        }
        key(Key7; "Document type", "Global dimension 1", "Global dimension 2", Employee)
        {
            SumIndexFields = "Line Amount", "Line %", "Principal Amount", "Interest Amount";
        }
        key(Key8; "No.", Employee, Paid)
        {
            SumIndexFields = "Line Amount", "Line %", "Principal Amount", "Interest Amount";
        }
        key(Key9; "No.", "Document type", Paid)
        {
            SumIndexFields = "Line Amount", "Line %", "Principal Amount", "Interest Amount";
        }
        key(Key10; "No.", Employee, Status, Type, Paid, "Entry No.")
        {
            SumIndexFields = "Line Amount", "Line %", "Principal Amount", "Interest Amount";
        }
        key(Key11; Type, "Payment No.", Employee, "Employee Posting Group", Month, Year, "Global dimension 1", "Global dimension 2", "Document type", "Employee Statistic Group")
        {
            SumIndexFields = "Line Amount", "Line %", "Principal Amount", "Interest Amount";
        }
        key(Key12; Employee, Type, "Date comptabilisation")
        {
        }
        key(Key13; Year, Month)
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

        if Header.Get("No.") then begin
            Header.CalcFields("Repaid amount", "Repaid %");

            //"Remaining amount"   := Header."Total to repay" - Header."Repaid amount";
            //"Remaining %"        := 100 - Header."Repaid %";
        end
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;

        if Header.Get("No.") then begin
            Header.CalcFields("Repaid amount", "Repaid %");
            //"Remaining amount"   := Header."Total to repay" - Header."Repaid amount";
            //"Remaining %"        := 100 - Header."Repaid %";
        end
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    var
        Header: Record "Loan & Advance Header";
        errAmount: label 'Error on the inserted Amount.';
}

