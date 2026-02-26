
Table 52048949 "Ligne Pointage Journ. Validé"
{//GL2024  ID dans Nav 2009 : "39001441"

    fields
    {
        field(1; "Séquence"; Integer)
        {
        }
        field(2; Matricule; Code[10])
        {
            SQLDataType = Varchar;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                GRecSalary.Reset;
                if GRecSalary.Get(Matricule) then begin
                    GCodNomPrenom := GRecSalary."First Name" + ' ' + GRecSalary."Last Name";
                    Nom := GCodNomPrenom;
                    "Type Salarié" := GRecSalary."Employee's type";
                    Modify;
                end;
            end;
        }
        field(3; Nom; Text[100])
        {
        }
        field(4; "Nom 1"; Code[10])
        {
        }
        field(5; "D.Hr sup"; Text[30])
        {
        }
        field(6; Panier; Decimal)
        {
        }
        field(7; "Tot Heurs"; Decimal)
        {
        }
        field(8; "Hr nuit"; Decimal)
        {
        }
        field(9; "Heure 15"; Decimal)
        {
        }
        field(10; "Heure 35"; Decimal)
        {
        }
        field(11; "Présence"; Decimal)
        {
        }
        field(12; "Congé"; Decimal)
        {
        }
        field(13; "Férier"; Decimal)
        {
        }
        field(14; "Jour repos"; Decimal)
        {
        }
        field(15; Bage; Code[10])
        {

            trigger OnValidate()
            begin
                //>>MBY 14/04/2009
                GRecSalary.Reset;
                GRecSalary.SetRange("N° Badge", Bage);
                if GRecSalary.Find('-') then
                    Validate(Matricule, GRecSalary."No.")
                else begin
                    Matricule := '';
                    Nom := '';
                    Message('ATTENTION CIN INEXISTANTE !!!');
                end;
                //<<MBY
            end;
        }
        field(16; "Heure 50"; Decimal)
        {

            trigger OnValidate()
            begin
                Salisure := Salisure + "Heure 35";
                Modify
            end;
        }
        field(17; Semaine; Integer)
        {
        }
        field(18; Heure; Decimal)
        {
        }
        field(19; "Type Heure"; Text[30])
        {
        }
        field(20; Absence; Decimal)
        {
        }
        field(21; "Heure ferier"; Decimal)
        {
        }
        field(22; Observation; Text[30])
        {
        }
        field(23; "Suivi Modification"; Code[200])
        {
        }
        field(24; Utilisateur; Code[10])
        {
        }
        field(25; "Heure 120"; Decimal)
        {
        }
        field(26; "Type Salarié"; Option)
        {
            OptionCaption = 'Base Horaire,Base Mensuelle';
            OptionMembers = "Base Horaire","Base Mensuelle";
        }
        field(27; "Heures Normal"; Decimal)
        {

            trigger OnValidate()
            begin
                Heure := "Heures Normal";
                Présence := "Heures Normal";
                Salisure := 0;
                PramResH.Get();
                if "Type Salarié" = 0 then
                    Salisure := Salisure + "Heures Normal"
                else
                    Salisure := Salisure + ("Heures Normal" * PramResH."From Work day to Work hour");
            end;
        }
        field(50000; "Rembourcement frais"; Decimal)
        {
        }
        field(50001; "Heures compensation"; Decimal)
        {
        }
        field(50002; "Nombre de jour indemnité exep"; Decimal)
        {
        }
        field(50003; Salisure; Decimal)
        {
        }
        field(50004; Douche; Decimal)
        {
        }
        field(50011; "Heure Congé maladie"; Decimal)
        {
        }
        field(50012; "Heure accident de travail"; Decimal)
        {
        }
        field(50013; "Indemnité ration de force"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50014; "Indemnité Habillement"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50015; "Prime semestrielle"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50016; "Indemnité samedi"; Integer)
        {
        }
        field(50017; "Montant congé"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50018; "Nombre Jour Prime Panier"; Decimal)
        {
        }
        field(50019; "Heure 60"; Decimal)
        {
        }
        field(50021; Expatrie; Boolean)
        {
        }
        field(50022; "Mois Attachement"; Option)
        {
            OptionMembers = " ",Janvier,Fevrier,Mars,Avril,Mai,Jiun,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
        }
        field(50023; "Semaine Attachement"; Option)
        {
            OptionMembers = S1,S2,S3,S4;
        }
        field(50024; "Annee Attachement"; Integer)
        {
        }
        field(50025; "1"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50026; "2"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50027; "3"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50028; "4"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50029; "5"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50030; "6"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50031; "7"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50032; "8"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50033; "9"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50034; "10"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50035; "11"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50036; "12"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50037; "13"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50038; "14"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50039; "15"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50040; "16"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50041; "17"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50042; "18"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50043; "19"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50044; "20"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50045; "21"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50046; "22"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50047; "23"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50048; "24"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50049; "25"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50050; "26"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50051; "27"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50052; "28"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50053; "29"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50054; "30"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50055; "31"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50056; Qualification; Code[20])
        {
        }
        field(50065; "Total Presence"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(50066; Remarque; Text[100])
        {
        }
        field(50067; "Dimanche 1"; Integer)
        {
        }
        field(50068; "Dimanche 2"; Integer)
        {
        }
        field(50069; "Dimanche 3"; Integer)
        {
        }
        field(50070; "Dimanche 4"; Integer)
        {
        }
        field(50071; "Dimanche 5"; Integer)
        {
        }
        field(50072; "20%"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(50073; "40%"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(50074; "65%"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(39001490; "type calcul paie"; Option)
        {
            OptionCaption = 'Mensuel,Quinzaine';
            OptionMembers = Mensuel,Quinzaine;
        }
        field(39001491; "Nombre de jour"; Decimal)
        {
        }
        field(39001492; "Productivité"; Decimal)
        {
        }
        field(39001493; "Total nb jours"; Decimal)
        {
            CalcFormula = sum("Etat Mensuelle Paie"."Nombre de jour");
            FieldClass = FlowField;
        }
        field(39001494; "Total nb heures"; Decimal)
        {
            CalcFormula = sum("Etat Mensuelle Paie".Heure where("Type Salarié" = filter("Base Horaire")));
            FieldClass = FlowField;
        }
        field(39001495; "Nombre Salarier"; Integer)
        {
            CalcFormula = count("Etat Mensuelle Paie");
            FieldClass = FlowField;
        }
        field(39001496; Journee; Date)
        {
        }
        field(39001497; Affectation; Code[20])
        {
            TableRelation = "Tranche STC";
        }
    }

    keys
    {
        key(Key1; Matricule, "Annee Attachement", "Mois Attachement", Affectation)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GCodNomPrenom: Text[100];
        GRecSalary: Record Employee;
        PramResH: Record "Human Resources Setup";
        EmploymentContract: Record "Employment Contract";
        RegimesoFwork: Record "Regimes of work";
        NombrJour: Decimal;
        NombreHeure: Decimal;
        HeureCalcule: Decimal;
        Val1: Decimal;
        Val2: Decimal;
        Val3: Decimal;
}

