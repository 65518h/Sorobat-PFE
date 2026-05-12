
Table 52048957 "Chantier Enreg."
{
    //GL2024  ID dans Nav 2009 : "39001453"
    fields
    {
        field(1; Sequence; Integer)
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; Chantier; Code[20])
        {
            TableRelation = Chantier."Code Chantier";
        }
        field(4; Employee; Code[20])
        {
            TableRelation = Employee;
        }
        field(5; "Transaction No."; Integer)
        {
        }
        field(10; month; Option)
        {
            Caption = 'Posting month';
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = January," February"," March"," April"," May"," June"," July"," August"," September"," October"," November"," December";
        }
        field(11; year; Integer)
        {
            Caption = 'Posting year';
        }
        field(12; Shift; Option)
        {
            OptionMembers = " ","Day Shift","Night Shift";
        }
        field(13; "Paie No."; Code[20])
        {
        }
        field(14; "Date Paie"; Date)
        {
        }
        field(15; Name; Text[100])
        {
        }
        field(20; "Code Utilisateur"; Code[20])
        {
        }
        field(21; "Date Création"; Date)
        {
        }
        field(22; "Montant Repas"; Decimal)
        {
            AutoFormatType = 2;
        }
        field(30; "Jours du transport"; Boolean)
        {
        }
        field(31; "a Payé"; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; Sequence)
        {
            Clustered = true;
        }
        key(STG_Key2; Employee, Date)
        {
            SumIndexFields = "Montant Repas";
        }
        key(STG_Key3; Employee, year, "Paie No.", Sequence)
        {
            SumIndexFields = "Montant Repas";
        }
        key(STG_Key4; Employee, year, month, "Jours du transport", Sequence)
        {
        }
        key(STG_Key5; Employee, year, month, "a Payé", Sequence)
        {
        }
        key(STG_Key6; month, year, Date, Employee)
        {
        }
        key(STG_Key7; Employee, Date, month, year)
        {
        }
    }

    fieldgroups
    {
    }
}

