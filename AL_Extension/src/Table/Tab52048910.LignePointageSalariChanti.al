Table 52048910 "Ligne Pointage Salarié Chanti"
{//GL2024  ID dans Nav 2009 : "39001440"
 // DrillDownPageID = "Alerte Imminente DA";
 //  LookupPageID = "Alerte Imminente DA";

    fields
    {
        field(1; "No. Pointage"; code[50])
        {
            caption = 'N° Pointage';
        }

        field(2; Matricule; Code[10])
        {
            SQLDataType = Integer;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                GRecSalary.RESET;
                IF GRecSalary.GET(Matricule) THEN BEGIN
                    GCodNomPrenom := GRecSalary."First Name" + ' ' + GRecSalary."Last Name";
                    Nom := GCodNomPrenom;
                    "Type Salarié" := GRecSalary."Employee's type";
                    MODIFY;
                END;
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
                GRecSalary.RESET;
                GRecSalary.SETRANGE("N° Badge", Bage);
                IF GRecSalary.FIND('-') THEN
                    VALIDATE(Matricule, GRecSalary."No.")
                ELSE BEGIN
                    Matricule := '';
                    Nom := '';
                    MESSAGE('ATTENTION CIN INEXISTANTE !!!');
                END;
                //<<MBY
            end;
        }
        field(16; "Heure 50"; Decimal)
        {

            trigger OnValidate()
            begin
                Salisure := Salisure + "Heure 35";
                MODIFY
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
            DecimalPlaces = 0 : 2;
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
                PramResH.GET();
                IF "Type Salarié" = 0 THEN
                    Salisure := Salisure + "Heures Normal"
                ELSE
                    Salisure := Salisure + ("Heures Normal" * PramResH."From Work day to Work hour");
            end;
        }
        field(28; "Séquence"; integer)
        {

        }
        field(29; Fonction; code[60])
        {

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
            OptionMembers = " ",Janvier,Fevrier,Mars,Avril,Mai,Juin,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
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
        field(50065; "Total Presence"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0 : 1;
            CalcFormula = sum("Ecriture Pointage Journalier".Heure where("week Number" = filter('1|2|3|4|5|6'), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50066; Remarque; Text[100])
        {
        }
        field(50067; S1; Decimal)
        {
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".Heure where("week Number" = const(1), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50068; S2; Decimal)
        {
            DecimalPlaces = 0 :;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".Heure where("week Number" = const(2), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50069; S3; Decimal)
        {
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".Heure where("week Number" = const(3), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50070; S4; Decimal)
        {
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".Heure where("week Number" = const(4), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50071; S5; Decimal)
        {
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".Heure where("week Number" = const(5), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50072; "15%"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier"."HSup 15" where("Entry No." = filter('15'), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50073; "35%"; Decimal)
        {

            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier"."HSup 35" where("Entry No." = filter('35'), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50074; "60%"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(50075; S6; Decimal)
        {
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".Heure where("week Number" = const(6), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50076; "Montant HSup 15%"; Decimal)
        {
            Editable = false;
        }
        field(50077; "Montant HSup 60%"; Decimal)
        {
            Editable = false;
        }
        field(50078; "Base Jour"; Decimal)
        {
        }
        field(50079; "Nombre De Jours Travaillé"; Decimal)
        {
            Editable = false;
        }
        field(50080; "Remize a Zero"; Boolean)
        {
        }
        field(50081; Statut; Option)
        {
            OptionMembers = Ouvert,Valider;
        }
        field(50082; "Montant HSup 35%"; Decimal)
        {
            Editable = false;
        }
        field(50083; D1; Decimal)
        {
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".day where("week Number" = const(1), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50084; D2; Decimal)
        {
            DecimalPlaces = 0 :;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".day where("week Number" = const(2), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50085; D3; Decimal)
        {
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".day where("week Number" = const(3), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50086; D4; Decimal)
        {
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".day where("week Number" = const(4), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50087; D5; Decimal)
        {
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".day where("week Number" = const(5), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50088; D6; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".day where("week Number" = const(6), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(50089; "Presence à Payer"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(50090; "15% Ant"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(50091; "35% Ant"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(50092; "Dimanche Non Travailléé"; Integer)
        {
        }
        field(50093; "Heures Feriés Sup 60%"; Integer)
        {
        }
        field(70067; "Total heurs week"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum("Ecriture Pointage Journalier".Heure where(week = field("Week Filter"), "No. Pointage" = field("No. Pointage"), Matricule = field(Matricule)));
        }
        field(70068; "Week Filter"; Integer)
        {
            FieldClass = FlowFilter;
        }

        field(39001490; "type calcul paie"; Option)
        {
            OptionCaption = 'Mensuel,Quinzaine';
            OptionMembers = Mensuel,Quinzaine;
        }
        field(39001491; "Presence Perso"; Decimal)
        {
        }
        field(39001492; "Productivité"; Decimal)
        {
        }
        field(39001493; Dimanches; Decimal)
        {
        }
        field(39001494; "Total nb heures"; Decimal)
        {
            CalcFormula = Sum("Etat Mensuelle Paie".Heure WHERE("Type Salarié" = FILTER("Base Horaire")));
            FieldClass = FlowField;
        }
        field(39001495; "Nombre Salarier"; Integer)
        {
            CalcFormula = Count("Etat Mensuelle Paie");
            FieldClass = FlowField;
        }
        field(39001496; Journee; Date)
        {
        }
        field(39001497; Affectation; Code[20])
        {
            TableRelation = "Employee Statistics Group" WHERE(Type = CONST(Service));

            trigger OnValidate()
            var
                ff: record 5212;
            begin
                IF Employee.GET(Matricule) THEN BEGIN
                    Employee.Section := Affectation;
                    Employee.MODIFY;
                END;
            end;
        }
    }

    keys
    {
        key(STG_Key1; "No. Pointage", Matricule, "Annee Attachement", "Mois Attachement", Affectation)
        {
            Clustered = true;
        }
        key(STG_Key2; Affectation, "Base Jour", Matricule)
        {
        }
    }

    fieldgroups
    {
    }

    var
        GCodNomPrenom: Text[100];
        GRecSalary: Record 5200;
        PramResH: Record 5218;
        EmploymentContract: Record 5211;
        RegimesoFwork: Record "Regimes of work";
        NombrJour: Decimal;
        NombreHeure: Decimal;
        HeureCalcule: Decimal;
        Val1: Decimal;
        Val2: Decimal;
        Val3: Decimal;
        Employee: Record 5200;
}

