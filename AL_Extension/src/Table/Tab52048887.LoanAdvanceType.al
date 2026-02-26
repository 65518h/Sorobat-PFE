Table 52048887 "Loan & Advance Type"
{//GL2024  ID dans Nav 2009 : "39001411"
    Caption = 'Loan & Advance Type';
    DrillDownPageID = "Loan & Advance Types List";
    LookupPageID = "Loan & Advance Types List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Advance,Loan';
            OptionMembers = Advance,Loan;
        }
        field(4; "Repayment slices"; Integer)
        {
            Caption = 'Repayment slices';
        }
        field(11; "Interest %"; Decimal)
        {
            Caption = 'Interest %';
            DecimalPlaces = 0 : 2;
        }
        field(30; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";

            trigger OnValidate()
            begin
                if (("Account Type" = "Bal. Account Type")
                    and
                    ("Account Type" = 1))
                 then
                    case "Account Type" of
                        0:
                            begin
                                "Bal. Account Type" := 1;
                                "Bal. Account No." := '';

                            end;
                        1:
                            begin
                                "Bal. Account Type" := 0;
                                "Bal. Account No." := '';
                                "Avance sur Prime" := false;
                            end;
                    end;
            end;
        }
        field(31; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = filter("G/L Account")) "G/L Account"
            else
            if ("Account Type" = filter("Bank Account")) "Bank Account" where("Currency Code" = filter(''));
        }
        field(32; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";

            trigger OnValidate()
            begin
                if (("Account Type" = "Bal. Account Type")
                    and
                    ("Account Type" = 1))
                 then
                    case "Bal. Account Type" of
                        0:
                            begin
                                "Account Type" := 1;
                                "Account No." := '';
                            end;
                        1:
                            begin
                                "Account Type" := 0;
                                "Account No." := '';
                            end;
                    end;
            end;
        }
        field(33; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = filter("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = filter("Bank Account")) "Bank Account" where("Currency Code" = filter(''));
        }
        field(40; "Account Type Long Terme"; Option)
        {
            Caption = 'Type Compte Long Terme';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(41; "Account No. Lng Termeo"; Text[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type Long Terme" = filter("G/L Account"),
                                Type = const(Loan)) "G/L Account"
            else
            if ("Account Type Long Terme" = filter("Bank Account"),
                                         Type = const(Loan)) "Bank Account" where("Currency Code" = filter(''));
        }
        field(50; "Interest Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = "G/L Account";
        }
        field(101; "Employee Posting Grp. filter"; Code[30])
        {
            Caption = 'Employee Posting Grp. filter';
            FieldClass = FlowFilter;
            TableRelation = "Employee Posting Group2";
        }
        field(102; Balance; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Loan & Advance Entry".Amount where("Document type" = field(Code),
                                                                   "Employee Posting Group" = field("Employee Posting Grp. filter")));
            Caption = 'Balance';
            FieldClass = FlowField;
        }
        field(105; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(110; "Avance sur Prime"; Boolean)
        {

            trigger OnValidate()
            begin
                if Type <> 0 then
                    Error('C''est un Prêt !!!!!!');
            end;
        }
        field(5000; "Type par déf"; Boolean)
        {

            trigger OnValidate()
            begin
                T1.Reset;
                T1.SetRange(Type, Type);
                T1.SetRange("Type par déf", true);
                if "Type par déf" and (T1.Find('-')) then
                    Error('Vous ne Pouvez pas attribuer un autre Type Par Défault !!!');
            end;
        }
        field(50000; "Avance sur congé"; Boolean)
        {
        }
        field(39001450; "type amortissement"; Option)
        {
            OptionCaption = 'Dégressif,Lineaire,Constant';
            OptionMembers = "Dégressif",Lineaire,Constant;
        }
        field(39001451; "Imputation Comptable"; Option)
        {
            OptionCaption = 'Imputable,Non Imputable';
            OptionMembers = Imputable,"Non Imputable";
        }
        field(39001470; "Avance Aid"; Boolean)
        {
        }
        field(39001490; "Precision Arrondi Principale"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(39001491; "affectation Diff Arrondi"; Option)
        {
            OptionCaption = 'debut,Fin';
            OptionMembers = debut,Fin;
        }
        field(39001495; "Avance Repas"; Boolean)
        {
        }
        field(39001496; "Type reglement"; Text[30])
        {
            Description = '"Payment Class" WHERE (Suggestions=CONST(Employee))';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        T1: Record "Loan & Advance Type";
}

