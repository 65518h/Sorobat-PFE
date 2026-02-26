table 52049036 "Enveloppe Bank"
{ //GL2024  ID dans Nav 2009 : "39001505"
  //GL2024 DrillDownPageID = 70150;
  //GL2024  LookupPageID = 70150;

    fields
    {
        field(1; "N° Enveloppe"; Code[20])
        {
        }
        field(2; "Code bank"; Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccount: Record 270;
            begin
                BankAccount.GET("Code bank");
                "Nom Bank" := BankAccount.Name;
            end;
        }
        field(3; "Nom Bank"; Text[50])
        {
        }
        field(4; Periode; Text[30])
        {
        }
        field(5; "Code devise"; Code[20])
        {
            // TableRelation = Table0;
        }
        field(6; "Montant DS"; Decimal)
        {
        }
        field(7; Montant; Decimal)
        {
        }
        field(8; "Montant ammorti"; Decimal)
        {
            CalcFormula = Sum("Ligne frais de mission"."Montant DS" WHERE("Enveloppe Bank" = FIELD("N° Enveloppe")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "N° Enveloppe")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

