Table 50036 "Montant Bourse Etudiant"
{
    DrillDownPageID = "Bourse Etudiant";
    LookupPageID = "Bourse Etudiant";

    fields
    {
        field(1; Annee; Integer)
        {
        }
        field(2; "Employé"; Code[10])
        {
            TableRelation = Employee."No.";
        }
        field(3; "Code"; Code[10])
        {
            //GL3900     TableRelation = "Type Assurance Vie".Code;
        }
        field(4; Montant; Decimal)
        {
            DecimalPlaces = 3 : 3;
            //GL3900 
            /*      trigger OnValidate()
                  begin
                      RecTypeAss.Reset;
                      RecTypeAss.SetRange(Code, Code);
                      if RecTypeAss.Find('-') then
                          if Montant > RecTypeAss."Montant plafond" then
                              Error('Vérifiez le montant');
                  end;*/
        }
        field(5; "Nom & prénom"; Text[60])
        {
            //GL2024 CalcFormula = lookup(Employee."First Name" where("No." = field(Employé)));
            CalcFormula = lookup(Employee."First Name" where("No." = field(Employé)));
            FieldClass = FlowField;
        }
        field(50000; "Date Debut"; Date)
        {
        }
        field(50001; "Date Fin"; Date)
        {
        }
        field(50002; Bourse; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; Annee, "Employé")
        {
            Clustered = true;
        }
        key(STG_Key2; "Employé")
        {
            SumIndexFields = Montant;
        }
    }

    fieldgroups
    {
    }

    var
    //GL3900   RecTypeAss: Record "Type Assurance Vie";
}

