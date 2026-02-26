
Table 52048951 "Note Remplacement Enreg"
{
    LookupPageID = "Liste Notes De Rempl. enreg.";
    //GL2024  ID dans Nav 2009 : "39001444"
    fields
    {
        field(1; "N° Sequence"; Integer)
        {
        }
        field(2; "Date Remplacement"; Date)
        {
        }
        field(3; "N° Salariée"; Code[20])
        {
            TableRelation = Employee;
        }
        field(4; "N° Remplacant"; Code[20])
        {
            TableRelation = Employee;
        }
        field(5; "Heure Début"; Time)
        {
        }
        field(6; "Heure Fin"; Time)
        {
        }
        field(7; Cause; Text[100])
        {
        }
        field(8; Utilisateur; Code[10])
        {
        }
        field(9; Date; Date)
        {
        }
        field(10; haure; Time)
        {
        }
        field(11; Type; Option)
        {
            OptionMembers = Remplacement,"Changement Poste";
        }
        field(20; "N° Carte Remplacée"; Code[20])
        {
        }
        field(21; "N° Carte Remplacant"; Code[20])
        {
        }
        field(8099010; "Employee's Type"; Option)
        {
            Caption = 'Employee''s type';
            OptionCaption = 'Hour based,Month based';
            OptionMembers = "Hour based","Month based";
        }
        field(8099020; "Regimes of work"; Code[10])
        {
            Caption = 'Regime of work';
            TableRelation = "Regimes of work".Code where("Type Calendar" = field("Type Calendar"));
        }
        field(39001440; "Type Calendar"; Option)
        {
            OptionMembers = " ",Administratif,Roulement;
        }
        field(39001441; "Code Calendar"; Code[20])
        {
            TableRelation = if ("Type Calendar" = filter(Roulement)) "Caledar Roulement"."Code calend Roulement"
            else
            if ("Type Calendar" = filter(Administratif)) "Base Calendar".Code;
        }
        field(39001442; "Date Debut Roulement"; Date)
        {
        }
        field(39001443; "N° Ligne Roulement"; Integer)
        {
            TableRelation = "Line Calendar Roulement"."Line no." where(Code = field("Code Calendar"));
        }
        field(39001444; "Date Fin Changement"; Date)
        {
        }
        field(39001445; System; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "N° Sequence")
        {
            Clustered = true;
        }
        key(Key2; "N° Remplacant", "Date Remplacement", "Heure Début", "Heure Fin")
        {
        }
        key(Key3; "N° Salariée", "N° Remplacant", "Date Remplacement")
        {
        }
        key(Key4; Type, "N° Salariée", "Date Remplacement")
        {
        }
        key(Key5; "N° Salariée", "Date Remplacement", "N° Sequence")
        {
        }
        key(Key6; System, "N° Sequence")
        {
        }
    }

    fieldgroups
    {
    }
}

