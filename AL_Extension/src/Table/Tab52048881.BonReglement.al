Table 52048881 "Bon Reglement"
{//GL2024  ID dans Nav 2009 : "39001403"
    Caption = 'Overcharge of hour cost';
    //  DrillDownPageID = 50088;
    // LookupPageID = 50088;

    fields
    {
        field(1; "N° Bon"; Code[20])
        {
            Caption = 'Regime of work';
            Editable = true;
        }
        field(2; Annee; Integer)
        {
            Caption = 'Identifier';
            Editable = false;

            trigger OnValidate()
            begin
                if Mois <> 0 then "Date Reglement" := Dmy2date(1, Mois, Annee);
            end;
        }
        field(3; Mois; Option)
        {
            Caption = 'Lower limit';
            OptionMembers = " ",Janvier,Fevrier,Mars,Avril,Mai,Jui,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;

            trigger OnValidate()
            begin
                if Annee <> 0 then "Date Reglement" := Dmy2date(1, Mois, Annee);
            end;
        }
        field(4; Matricule; Code[20])
        {
            Caption = 'Upper limit';
            TableRelation = IF ("Type Salaire" = FILTER(<> Journalier)) Employee ELSE IF ("Type Salaire" = FILTER(Journalier)) Chantier;

            trigger OnValidate()
            begin

                IF "Type Salaire" = "Type Salaire"::"Dimanche Et Fete" THEN BEGIN
                    Annee := DATE2DMY(WORKDATE, 3);
                    Mois := DATE2DMY(WORKDATE, 2);
                    BonReglement.SETRANGE(Annee, Annee);
                    BonReglement.SETRANGE(Mois, Mois);
                    BonReglement.SETRANGE("Type Salaire", BonReglement."Type Salaire"::"Dimanche Et Fete");
                    BonReglement.SETRANGE(Statut, BonReglement.Statut::Ouvert);
                    BonReglement.SETRANGE("Date Reglement", "Date Reglement");
                    BonReglement.SETRANGE(Matricule, Matricule);
                    IF BonReglement.COUNT > 0 THEN ERROR(Text003, Matricule);
                END;
                GetInfo;
            end;
        }
        field(5; Categorie; Code[20])
        {
            Caption = 'Rate of overcharge';
            Editable = false;
        }
        field(50000; Qualification; Code[20])
        {
            Editable = false;
            TableRelation = "Employee Statistics Group" WHERE(Type = CONST(Departement));
        }
        field(50001; Affectation; Code[20])
        {
            Editable = true;
            TableRelation = "Employee Statistics Group" WHERE(Type = CONST(Service));


        }
        field(50002; Montant; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Editable = true;

            trigger OnValidate()
            begin
                GetInfo;
            end;
        }
        field(50003; Mensuel; Boolean)
        {
            Editable = true;
        }
        field(50004; Nombre; Decimal)
        {

            trigger OnValidate()
            begin

                IF "Type Salaire" = "Type Salaire"::"Dimanche Et Fete" THEN IF (Nombre < 0) OR (Nombre > 1) THEN ERROR(Text002);
                IF "Type Salaire" <> "Type Salaire"::"Bon Reglement" THEN
                    "Net Initial" := ROUND(Montant * Nombre, 1)
                ELSE
                    "Net Initial" := ROUND(Montant * Nombre / 26, 1) - "Total Avance";

                IF "Type Salaire" = "Type Salaire"::Avance THEN BEGIN
                    IF Nombre > 1 THEN ERROR(Text001);
                    "Net Initial" := ROUND(Montant * -Nombre, 1);
                END;

                CalculerNet;
            end;
        }
        field(50005; "Jours Deplacement"; Decimal)
        {

            trigger OnValidate()
            begin
                if HumanResourcesSetup.Get then;
                CalculerNet;
            end;
        }
        field(50006; "Montant Deplacement"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Editable = true;


        }
        field(50007; Divers; Decimal)
        {

            trigger OnValidate()
            begin
                CalculerNet;
            end;
        }
        field(50008; Observation; Text[200])
        {
        }
        field(50009; "Net à Payer"; Decimal)
        {

        }
        field(50010; "Nom Et Prenom"; Text[100])
        {
            Editable = true;
        }
        field(50011; "Net Initial"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(50012; "Type Salaire"; Option)
        {
            OptionMembers = "Bon Reglement","Dimanche Et Fete",Journalier,"Heure Supp","Frais Logement Et Nourriture",Extra,Autres,Conge,Avance;

            trigger OnValidate()
            begin
                Annee := Date2dmy(WorkDate, 3);
                Mois := Date2dmy(WorkDate, 2);
                GetInfo;
            end;
        }
        field(50013; Statut; Option)
        {
            OptionMembers = Ouvert,"Validé";
        }
        field(50014; "Debut Reglement"; Date)
        {
        }
        field(50015; "Fin Reglement"; Date)
        {
        }
        field(50016; Validation; Boolean)
        {
        }
        field(50017; Section; Code[30])
        {
            TableRelation = "Employee Statistics Group".Code WHERE(Type = CONST(Section));

            trigger OnValidate()
            begin
                if "Type Salaire" = "type salaire"::"Frais Logement Et Nourriture" then begin
                    Departement.SetRange(Type, Departement.Type::Section);
                    Departement.SetRange(Code, Section);
                    /*GL2024  if Departement.FindFirst then;
                      Montant := Departement.Montant;*/
                end;
            end;
        }
        field(50018; "Total Avance"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(50019; "Description Qualification"; Text[100])
        {
            Editable = false;
        }
        field(50020; "Description Affectation"; Text[100])
        {
            Editable = false;
        }
        field(50021; Retenue; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'RB SORO 13/09/2017';

            trigger OnValidate()
            begin
                CalculerNet;
            end;
        }
        field(50022; Payer; Boolean)
        {
        }
        field(50023; Chantier; Code[20])
        {
            Description = 'HJ SORO 04-10-2017';
            Editable = true;
        }
        field(50024; "Heure Sup"; Decimal)
        {

            trigger OnValidate()
            begin
                GetInfo;
                CalculerNet;
            end;
        }
        field(50025; "Montant Heure Sup"; Decimal)
        {
            Editable = false;
        }
        field(50026; "Base Horaire"; Decimal)
        {
            Editable = false;
        }
        field(50027; "Integrer à la Caisse"; Boolean)
        {
            Description = 'MH-22-11-2017';
        }
        field(50028; "Montant HSP"; Decimal)
        {
            Description = 'MH-09-02-2018';
        }
        field(50029; "Type Affectation"; Code[10])
        {
            Description = 'MH SORO 14-03-2018';
            TableRelation = Service.Service;
        }
        field(50030; "Groupe Qualification"; Code[10])
        {
            Description = 'MH SORO 14-03-2018';
            TableRelation = Direction.Code;
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
        field(8099200; Service; Code[20])
        {
            TableRelation = Direction;
        }
        field(8099201; "Date Reglement"; Date)
        {
            Editable = true;

            trigger OnValidate()
            begin
                if ("Type Salaire" = "type salaire"::"Dimanche Et Fete") and (Matricule <> '') then begin
                    Annee := Date2dmy(WorkDate, 3);
                    Mois := Date2dmy(WorkDate, 2);
                    BonReglement.SetRange(Annee, Annee);
                    BonReglement.SetRange(Mois, Mois);
                    BonReglement.SetRange("Type Salaire", BonReglement."type salaire"::"Dimanche Et Fete");
                    BonReglement.SetRange(Statut, BonReglement.Statut::Ouvert);
                    BonReglement.SetRange("Date Reglement", "Date Reglement");
                    BonReglement.SetRange(Matricule, Matricule);
                    if BonReglement.Count > 1 then Error(Text003, Matricule);
                end;
            end;
        }
    }

    keys
    {
        key(STG_Key1; "N° Bon")
        {
            Clustered = true;
        }
        key(STG_Key2; Matricule, Annee, Mois)
        {
        }
        key(STG_Key3; Affectation)
        {
        }
        key(STG_Key4; "Nom Et Prenom")
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
        Annee := Date2dmy(WorkDate, 3);
        Mois := Date2dmy(WorkDate, 2);
        if HumanResourcesSetup.Get then;
        //GL2024  if "N° Bon" = '' then "N° Bon" := NoSeriesManagment.GetNextNo(HumanResourcesSetup."Recap Paie", TODAY, true);
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
        NoSeriesManagment: Codeunit NoSeriesManagement;
        HumanResourcesSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        //GL2024 EmployeeJournalier: Record "Affectation Opération Bancaire";
        Linegrid: Record "Line grid";
        EmploymentContract: Record "Employment Contract";
        RegimesofWork: Record "Regimes of work";
        Departement: Record "Employee Statistics Group";
        BonReglement: Record "Bon Reglement";
        TotAvance: Decimal;
        Text001: label 'Nombre Avance Ne Doit Pas Depasser 1';
        Text002: label 'Nombre Dimanche Ne Doit Pas Depasser 1';
        Text003: label 'Dimanche Deja Saise Pour Le Salrié %12';
        NbreHeureRegime: Decimal;
        MontantHSP: Decimal;
        BaseHeureSup: Decimal;


    procedure CalculerNet()
    begin

        "Net à Payer" := "Net Initial" + "Montant Deplacement" + Divers;
    end;


    procedure GetInfo()
    begin

        TotAvance := 0;
        IF "Type Salaire" <> "Type Salaire"::Journalier THEN BEGIN
            IF Employee.GET(Matricule) THEN;
            Departement.SETRANGE(Type, Departement.Type::Departement);
            Departement.SETRANGE(Code, format(Employee."Cumul Charge Salariale"));
            IF Departement.FINDFIRST THEN;
            Categorie := Employee.Catégorie;
            Qualification := FORMAT(Employee."Cumul Charge Salariale");
            Affectation := Employee.Section;
            "Nom Et Prenom" := Employee."First Name";
            IF "Type Salaire" <> "Type Salaire"::"Dimanche Et Fete" THEN BEGIN
                BonReglement.SETRANGE(Annee, Annee);
                BonReglement.SETRANGE(Mois, Mois);
                BonReglement.SETRANGE(Matricule, Matricule);
                BonReglement.SETRANGE("Type Salaire", BonReglement."Type Salaire"::Avance);
                IF BonReglement.FINDFIRST THEN
                    REPEAT
                        TotAvance += BonReglement.Montant;
                    UNTIL BonReglement.NEXT = 0;

                IF "Type Salaire" = "Type Salaire"::"Bon Reglement" THEN BEGIN
                    Montant := Employee."Basis salary";
                    "Total Avance" := TotAvance;
                END;
            END;
            /*GL2024 ELSE
                 Montant := Departement.Montant;*/
        END
        ELSE BEGIN
            // IF EmployeeJournalier.GET(Matricule) THEN;
            // "Nom Et Prenom":=EmployeeJournalier.Designation;
            // Montant:=EmployeeJournalier."Montnant Repas/ Jours";
            // Affectation  :=EmployeeJournalier.Affecation;
            // Qualification :=EmployeeJournalier.Qualification;
        END;

        /*GL2024  IF "Type Salaire" = "Type Salaire"::"Heure Supp" THEN BEGIN
              IF Employee.GET(Matricule) THEN;
              IF Employee."Nombre Mois Congé Payé" THEN
                  Montant := ROUND(Employee."Basis salary" / 260, 1);
              // ELSE
              //   ;
              // Montant:=ROUND(Employee."Net Negocié"/260,1);
          END;*/

    end;
}

