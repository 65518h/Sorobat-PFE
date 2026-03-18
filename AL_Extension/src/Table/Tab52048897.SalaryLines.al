Table 52048897 "Salary Lines"
{//GL2024  ID dans Nav 2009 : "39001424"
    // //>>DELTASOFT ACHOUR  27/02/2013
    //   AJOUT CHAMP 50007 ET 50008

    Caption = 'Salary Lines';
    DrillDownPageID = "Calculation lines";
    LookupPageID = "Calculation lines";

    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;
            TableRelation = "Salary Headers"."No.";
        }
        field(2; Employee; Code[10])
        {
            Caption = 'Employee';
            Editable = false;
            SQLDataType = Integer;
            TableRelation = Employee;
        }
        field(3; Name; Text[90])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(4; "Employee Posting Group"; Code[10])
        {
            Caption = 'Employee Posting Group';
            Editable = true;
            TableRelation = "Employee Posting Group2";
        }
        field(5; "Employee Regime of work"; Code[10])
        {
            Caption = 'Employee Regime of work';
            Editable = false;

            trigger OnLookup()
            begin
                RegimesWork.SetRange(Code, "Employee Regime of work");
                if RegimesWork.Find('-') then begin
                    RegimeOfWork.SetTableview(RegimesWork);
                    RegimeOfWork.Run;
                end;
            end;
        }
        field(50123; "Description Service"; Text[50])
        {
            Description = '//MBY ENDA';
            Editable = false;
        }
        field(6; "Emplymt. Contract Code"; Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            Editable = false;
            TableRelation = "Employment Contract";

            trigger OnLookup()
            begin
                EmploymentContract.SetRange(Code, "Emplymt. Contract Code");
                if EmploymentContract.Find('-') then begin
                    EmploymentContractNE.SetTableview(EmploymentContract);
                    EmploymentContractNE.Run;
                end
            end;
        }
        field(7; "Bank Account Code"; Code[10])
        {
            Caption = 'Bank Account';
            Editable = false;
            TableRelation = "Employee Bank Account".Code where("Employee No." = field(Employee));
        }
        field(8; "Employee's type"; Option)
        {
            Caption = 'Employee''s type';
            Editable = false;
            OptionCaption = 'Hour based,Month based';
            OptionMembers = "Hour based","Month based";
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(11; Note; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(12; Pourcentage; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(13; "Mois travaillés"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(20; Month; Option)
        {
            Caption = 'Month';
            Editable = true;
            OptionCaption = 'Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,Congé,Prime,STC,Solder jour de congé';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,STC,"Solder jour de congé";
        }
        field(21; Year; Integer)
        {
            Caption = 'Year';
            Editable = false;
        }
        field(23; "Days off remaining"; Decimal)
        {
            Caption = 'Days off remaining';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = Normal;
        }
        field(24; "Days off balacement"; Decimal)
        {
            Caption = 'Days off balacement';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(25; Absences; Decimal)
        {
            Caption = 'Absences';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = Normal;
        }
        field(26; "Adjustment of absences"; Decimal)
        {
            Caption = 'Adjustment of absences';
            DecimalPlaces = 3 : 3;
        }
        field(27; "Days off"; Decimal)
        {
            Caption = 'Days off';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(28; "Assiduity (Paid days)"; Decimal)
        {
            Caption = 'Assiduity (Paid days)';
            DecimalPlaces = 3 : 3;
            Editable = true;
        }
        field(29; "Assiduity (Worked days)"; Decimal)
        {
            Caption = 'Assiduity (Worked days)';
            DecimalPlaces = 3 : 3;
            Editable = true;
        }
        field(30; "congé"; Decimal)
        {
        }
        field(35; "Worked hours"; Decimal)
        {
            Caption = 'Worked hours';
            FieldClass = Normal;
        }
        field(36; "Basis hours"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Basis hours';
            Editable = false;
            FieldClass = Normal;
        }
        field(37; "Amount Days Off balacement"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Montant congé Soldé';
            DecimalPlaces = 3 : 3;
        }
        field(38; "Assiduity (days off balacement"; Decimal)
        {
            Caption = 'Assiduité (Congé Soldé)';
            DecimalPlaces = 3 : 3;
        }
        field(39; "Hours off Balacement"; Decimal)
        {
            Caption = 'Heure Congé Soldé';
            DecimalPlaces = 3 : 3;
        }
        field(40; "Basis salary"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Basis salary';
            DecimalPlaces = 3 : 3;
        }
        field(41; "Taxable indemnities"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxable indemnities';
            DecimalPlaces = 3 : 3;
            FieldClass = Normal;
        }
        field(42; "Supp. hours"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Supp. hours';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = Normal;
        }
        field(43; "Real basis salary"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Real basis salary';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(44; "Gross Salary"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Gross Salary';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(45; CNSS; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Cot. soc. non imposables';
            DecimalPlaces = 3 : 3;
        }
        field(47; "Gross Salary (sans Av)"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Salaire Brut (Sans AV)';
            DecimalPlaces = 3 : 3;
        }
        field(48; "Taxable indemnities (Not Gross"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Indemnités imposables (Non Brut)';
            DecimalPlaces = 3 : 3;
        }
        field(49; "Gross Salary (sans Av) PR"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Salaire Brut (Sans AV) PR';
            DecimalPlaces = 3 : 3;
        }
        field(50; "Taxable salary"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxable salary';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(55; "Deduction Family chief"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Deduction Family chief';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(56; "Deduction Loaded child"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Deduction Loaded child';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(57; "Deduction Prof. expenses"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Deduction Prof. expenses';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(60; "Real taxable"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Real taxable';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(65; "Total taxable rec."; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Total taxable rec.';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = Normal;
        }
        field(66; "Rec. payments"; Integer)
        {
            AutoFormatType = 2;
            Caption = 'Rec. payments';
            Editable = false;
            FieldClass = Normal;
        }
        field(67; "Real taxable (Year)"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Real taxable (Year)';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(70; "Taxe (Year)"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxe (Year)';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(71; "Total taxes rec."; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Total taxes rec.';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = Normal;
        }
        field(72; "Taxe (Month)"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxe (Month)';
            DecimalPlaces = 3 : 3;
            Editable = true;
        }
        field(80; "Non Taxable indemnities"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Non Taxable indemnities';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = Normal;
        }
        field(81; "Taxable Soc. Contrib."; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxable Soc. Contrib.';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = Normal;
        }
        field(82; "Mission expenses"; Decimal)
        {
            Caption = 'Mission expenses Heading';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = Normal;
        }
        field(100; "Net salary"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Net salary';
            DecimalPlaces = 3 : 3;
        }
        field(110; Loans; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Loans';
            DecimalPlaces = 3 : 3;
            FieldClass = Normal;
        }
        field(111; Advances; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Advances';
            DecimalPlaces = 3 : 3;
            FieldClass = Normal;
        }
        field(120; "Net salary cashed"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Net salary cashed';
            DecimalPlaces = 3 : 3;
            Editable = true;
            FieldClass = Normal;
        }
        field(121; "Global Dimension 1"; Code[20])
        {
            Caption = 'Code département';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(122; "Global Dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(241; "Taxable indemnities PR"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxable indemnities';
            DecimalPlaces = 3 : 3;
        }
        field(244; "Gross Salary PR"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Gross Salary';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(245; "Non Taxable Soc. Contrib. PR"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Non Taxable Soc. Contrib.';
            DecimalPlaces = 3 : 3;
        }
        field(247; "Taxable indem. PR (Not Gross)"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'indemnities Impo. PR (Non Brut)';
            DecimalPlaces = 3 : 3;
        }
        field(250; "Taxable salary PR"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxable salary';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(260; "Real taxable PR"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Real taxable';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(270; "Real Taxable PR (Year)"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Real Taxable PR (Year)';
            DecimalPlaces = 3 : 3;
        }
        field(272; "Taxe PR (Month)"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxe (Month)';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(275; "Taxe PR (Year)"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxe PR (Year)';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(500; "6 * SMIG"; Decimal)
        {
            AutoFormatType = 0;
            Caption = '6 * SMIG';
            DecimalPlaces = 3 : 3;
        }
        field(600; "Type Prime"; Code[10])
        {

        }
        field(800; "Heures consomation congé"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(900; "Paie Inverse"; Boolean)
        {
        }
        field(910; "year of Calculate"; Integer)
        {
            Caption = 'Year of Calculate';
        }
        field(5000; "Num Compte"; Code[20])
        {
        }
        field(50000; Departement; Code[10])
        {
            TableRelation = "Employee Statistics Group" WHERE(Type = CONST(Departement));
        }
        field(50001; Service; Code[10])
        {
            TableRelation = "Employee Statistics Group" WHERE(Type = CONST(Service));
        }
        field(50002; Section; Code[10])
        {
        }
        field(50003; "Montant retenu caisse FS"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50004; "Montant Congé de maladie"; Decimal)
        {
            CalcFormula = sum("Employee's days off Entry"."Montant Ligne" where("Employee No." = field(Employee),
                                                                                 "Posting month" = field(Month),
                                                                                 "Posting year" = field(Year),
                                                                                 Unit = filter("Heure de travail"),
                                                                                 "Motif D'absence" = filter("Congé de Maladie")));
            FieldClass = FlowField;
        }
        field(50005; "Montant accident de travail"; Decimal)
        {
            CalcFormula = sum("Employee's days off Entry"."Montant Ligne" where("Employee No." = field(Employee),
                                                                                 "Posting month" = field(Month),
                                                                                 "Posting year" = field(Year),
                                                                                 Unit = filter("Heure de travail"),
                                                                                 "Motif D'absence" = const("Accident de travail")));
            FieldClass = FlowField;
        }
        /*   field(50007; "Base RCGC"; Decimal)
           {
               DecimalPlaces = 3 : 3;
           }
           field(50008; "Retenue CGC"; Decimal)
           {
               DecimalPlaces = 3 : 3;
           }*/
        field(50010; "Nombre de jours"; Decimal)
        {
        }

        field(50015; "Impot sur salaire"; Decimal)
        {
        }
        field(50016; "Montant CN"; Decimal)
        {
        }
        field(50017; "Revenu imposable"; Decimal)
        {
            Caption = 'Revenu imposable';
        }
        field(50018; "Nbr Jour Panier"; Decimal)
        {
        }
        field(50021; Imposable; Boolean)
        {
        }
        field(50022; Abattement; Decimal)
        {
        }
        field(50023; "Exonération"; Decimal)
        {
        }
        field(50024; "Salaire Net Imposable"; Decimal)
        {
        }
        field(50025; "Base Imposable"; Decimal)
        {
        }
        field(50026; "IUTS Brut"; Decimal)
        {
        }
        field(50027; "IUTS Net"; Decimal)
        {
        }
        field(50028; "Nombre De Charge"; Integer)
        {
        }
        field(50029; "Salaire Net Objectif"; Decimal)
        {
        }
        field(50030; TPA; Decimal)
        {
        }
        field(50031; "Net Simuler"; Decimal)
        {
        }
        field(50032; Prime; Boolean)
        {
        }
        field(50033; "Base Imposable Avec 8%"; Decimal)
        {
        }
        field(50034; "Salaire Net Imposable Avec 8%"; Decimal)
        {
        }
        field(50035; "Banque Salarie"; Code[30])
        {
        }
        field(50036; "Date Entree"; Date)
        {
        }
        field(50037; "Retenue FSP"; Decimal)
        {
        }
        field(50038; "Retenue SNP"; Decimal)
        {
        }
        field(50043; "Salaire Net Contrat"; Decimal)
        {
            Editable = false;
        }
        field(50044; "Num Mobile Money"; code[20])
        {
            Editable = false;
        }
        field(50900; Trimestre; Option)
        {
            OptionCaption = ' ,1ère,2ème,3ème,4ème';
            OptionMembers = " ","1ère","2ème","3ème","4ème";
        }
        field(50901; "Ajout  en +"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50902; "Report en -"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50903; "RIB Salarié"; Code[50])
        {
            Description = '//ALTEK';
        }
        field(50904; "Statistics Group Code"; Code[30])
        {
            TableRelation = "Employee Statistics Group".Code;
        }

        field(39001526; "Statistic Gpe Descrip"; Text[30])
        {
        }
        field(50905; "Employee's Type Contrat"; Option)
        {
            OptionCaption = ' ,CDD,CDI,SIVP,SIVP II,Autre';
            OptionMembers = " ",CDD,CDI,SIVP,"SIVP II",Autre;
            TableRelation = "Employment Contract";
        }
        field(50906; "Num CNSS"; Code[30])
        {
        }
        field(50907; "Num CIN"; Code[20])
        {
        }
        field(50908; "Code Mode Réglement"; Option)
        {
            OptionMembers = Espèce,"Mobile money",Virement;
        }
        field(50909; Fonction; Text[60])
        {
            Caption = 'Fonction';
            Description = '//MBY ENDA';
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
        field(8099200; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(8099201; "Heure Jours Free"; Decimal)
        {
        }
        field(39001490; Quinzaine; Option)
        {
            Description = 'AGA DSFT 02-05-2011';
            OptionCaption = '1er,2ème,Autre';
            OptionMembers = "1er","2ème",Autre;
        }
        field(39001492; Charge; Option)
        {
            OptionMembers = Fixe,Variable,"Fixe/Variable";
        }
        field(39001493; "droit de congé du mois"; Decimal)
        {

        }
        field(39001494; "Salaire Impos. Ann. Conge"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(39001495; "Taux Tranche Impos. Conge"; Decimal)
        {
        }
        field(39001496; "Paied days"; Decimal)
        {
            Caption = 'Jours payés';

        }
        field(39001497; "Compte Bancaire Societe"; Code[10])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(39001498; "Jours Fériés"; Decimal)
        {
            FieldClass = Normal;
        }
        field(39001499; "Montant Jours Fériés"; Decimal)
        {
            FieldClass = Normal;
        }
        field(39001500; "Nombre d'heures suppl."; Decimal)
        {
            FieldClass = Normal;
        }
        field(39001501; "Jours Fériés travaillés"; Decimal)
        {
            FieldClass = Normal;
        }
        field(39001502; "Montant Jours Fériés travaillé"; Decimal)
        {
            FieldClass = Normal;
        }
        field(39001503; "Droit de congé ancienneté"; Decimal)
        {
        }
        field(39001504; "Code grille de salaire"; Code[10])
        {
        }
        field(39001505; "Catégorie"; Code[10])
        {
        }
        field(39001506; Echellon; Code[10])
        {
        }
        field(39001507; "salaire de base grille"; Decimal)
        {
        }
        field(39001508; "Montant Heures"; Decimal)
        {
            AutoFormatType = 0;
            DecimalPlaces = 3 : 3;
        }
    }

    keys
    {
        key(STG_Key1; "No.", Employee)
        {
            Clustered = true;
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
        key(STG_Key2; "Employee Posting Group", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
        key(STG_Key3; "No.", Month, Year, "Employee Posting Group", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Supp. hours", Absences, "Days off", Advances, Loans, "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(STG_Key4; "No.", "Num Compte")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
        key(STG_Key5; Employee, "year of Calculate", Month, "Type Prime")
        {
            SumIndexFields = "Gross Salary", "Net salary", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
        key(STG_Key6; "No.", "RIB Salarié")
        {
            SumIndexFields = "Net salary cashed";
        }
        key(STG_Key7; "No.", "Statistics Group Code", "Employee Posting Group")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
        key(STG_Key8; Employee, "Employee Posting Group", "Statistics Group Code")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
        key(STG_Key9; "Statistics Group Code", Employee)
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
        key(STG_Key10; "Num Compte")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        SuppHourLine: Record "Heures sup. eregistrées m";
        LigneTravail: Record "Heures occa. enreg. m";
    begin
        /*   RecSalaryLines.SetRange(RecSalaryLines.Employee, Employee);
           RecSalaryLines.FindFirst();
           if RecSalaryLines."Lot Virement Salaire" <> '' then Error('Ce salarier appartient a un Lot de Virement');

           SalaryLinesEnreg.SetRange(Employee, Employee);
           SalaryLinesEnreg.SetRange(Year, Year);
           SalaryLinesEnreg.SetRange(Month, Month);
           if SalaryLinesEnreg.FindFirst then exit;*/

        Indemnities.SetRange("No.", "No.");
        Indemnities.SetRange("Employee No.", Employee);
        Indemnities.DeleteAll;

        SuppHourLine.Reset;
        SuppHourLine.SetCurrentkey("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement");
        SuppHourLine.SetFilter("N° Salarié", Employee);
        SuppHourLine.SetFilter("Année de paiement", '%1', Year);
        SuppHourLine.SetFilter("Mois de paiement", '%1', Month);
        // SuppHourLine.DeleteAll;
        // SuppHourLine.SETFILTER("Employee Posting Group","Employee Posting Group");
        //SuppHourLine.SETFILTER("Taux de majoration",'>0');
        SuppHourLine.MODIFYALL("Paiement No.", '');


        LigneTravail.Reset;
        LigneTravail.SetCurrentkey("N° Salarié", "Mois de paiement", "Année de paiement");
        LigneTravail.SetFilter("N° Salarié", Employee);
        LigneTravail.SetRange("Mois de paiement", Month);
        LigneTravail.SetRange("Année de paiement", Year);
        LigneTravail.SetRange("Paiement No.", "No.");
        LigneTravail.MODIFYALL("Paiement No.", '');


        SocialContributions.SetRange("No.", "No.");
        SocialContributions.SetRange(Employee, Employee);
        SocialContributions.DeleteAll;

        /*  Indemnities.SetRange("No.", "No.");
          Indemnities.SetRange("Employee No.", Employee);
          Indemnities.DeleteAll;*/

        LoanAdvanceLines.SetRange(Employee, Employee);
        LoanAdvanceLines.SetRange(Status, 0);
        LoanAdvanceLines.SetRange("Payment No.", "No.");
        LoanAdvanceLines.SetRange(Paid, false);
        LoanAdvanceLines.DeleteAll;

        /* EmployeeDaysOffEntry.Reset;
         EmployeeDaysOffEntry.SetFilter("Employee No.", Employee);
         EmployeeDaysOffEntry.SetRange("Posting month", Month);
         EmployeeDaysOffEntry.SetRange("Posting year", Year);
         EmployeeDaysOffEntry.DeleteAll;*/
    end;

    trigger OnInsert()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    trigger OnModify()
    begin
        /* RecSalaryLines.SetRange(RecSalaryLines.Employee, Employee);
         RecSalaryLines.FindFirst();
         //  if RecSalaryLines."Lot Virement Salaire" <> '' then Error('Ce salarier appartient a un Lot de Virement');
 */

        if SalaryHeader.Get("No.") then begin
            SalaryHeader."Up to date" := false;
            SalaryHeader.Modify;
        end;

        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
        "Posting Date" := SalaryHeader."Posting Date";
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    var
        SalaryHeader: Record "Salary Headers";
        Indemnities: Record Indemnities;
        SocialContributions: Record "Social Contributions";
        confDeleteMess: label 'Press Yes to confirm the suppression of the selected line(s).';
        LoanAdvanceLines: Record "Loan & Advance Lines";
        RegimeOfWork: page "Regime of work";
        EmploymentContractNE: page "Employment Contract NE";
        RegimesWork: Record "Regimes of work";
        EmploymentContract: Record "Employment Contract";
        RecSalaryLines: Record "Salary Lines";
        EmployeeDaysOffEntry: Record "Employee's days off Entry";
        SalaryLinesEnreg: Record "Rec. Salary Lines";


    /*  procedure InsertIndem(TypeInde: Integer; Montant: Decimal)
      var
          LHumanResourcesSetup: Record "Human Resources Setup";
          LIndemnities: Record Indemnities;
          TextL001: label 'Vous Devez Relancer Le Calcul < Proposer Lignes Salaires>';
      begin
          if Montant = 0 then exit;
          if "Net salary" <> 0 then Error(TextL001);
          if LHumanResourcesSetup.Get then;
          if TypeInde = 1 then begin
              LIndemnities.SetRange("No.", "No.");
              LIndemnities.SetRange("Employee No.", Employee);
              LIndemnities.SetRange(Indemnity, LHumanResourcesSetup."Indemnite Rappel");
              if LIndemnities.FindFirst then begin
                  LIndemnities."Base Amount" := Montant;
                  LIndemnities.Modify;
              end;
          end;
          if TypeInde = 2 then begin
              LIndemnities.SetRange("No.", "No.");
              LIndemnities.SetRange("Employee No.", Employee);
              LIndemnities.SetRange(Indemnity, LHumanResourcesSetup."Indemnite Retenu");
              if LIndemnities.FindFirst then begin
                  LIndemnities."Base Amount" := -Montant;
                  LIndemnities.Modify;
              end;
          end;
          if TypeInde = 3 then begin
              LIndemnities.SetRange("No.", "No.");
              LIndemnities.SetRange("Employee No.", Employee);
              LIndemnities.SetRange(Indemnity, LHumanResourcesSetup."Indemnite Cession");
              if LIndemnities.FindFirst then begin
                  LIndemnities."Base Amount" := -Montant;
                  LIndemnities.Modify;
              end;
          end;
      end;*/
}

