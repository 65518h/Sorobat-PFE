Table 52048901 "Rec. Salary Lines"
{//GL2024  ID dans Nav 2009 : "39001428"
    // //>>DELTASOFT ACHOUR 27/02/2013

    Caption = 'Rec. Salary Lines';
    /*GL2024 DrillDownPageID = "Recorded Payment lines";
     LookupPageID = "Recorded Payment lines";*/

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'N°';
            TableRelation = "Rec. Salary Headers"."No.";
        }
        field(2; Employee; Code[10])
        {
            Caption = 'Salarié';
            Editable = false;
            TableRelation = Employee;
        }
        field(3; Name; Text[90])
        {
            Caption = 'Nom';
            Editable = false;
        }
        field(4; "Employee Posting Group"; Code[10])
        {
            Caption = 'Employee Posting Group';
            Editable = true;
            TableRelation = "Employee Posting Group2";
        }
        field(5; "Regime of work"; Code[10])
        {
            Caption = 'Régime de travail';
            Editable = false;
            TableRelation = "Regimes of work";
        }
        field(50909; Fonction; Text[60])
        {
            Caption = 'Fonction';
            Description = '//MBY ENDA';
        }

        field(6; "Emplymt. Contract Code"; Code[10])
        {
            Caption = 'Code contrat de travail';
            TableRelation = "Employment Contract";
        }
        field(7; "Bank Account Code"; Code[10])
        {
            Caption = 'Compte bancaire';
            TableRelation = "Employee Bank Account".Code where("Employee No." = field(Employee));
        }
        field(8; "Employee's type"; Option)
        {
            Caption = 'type salarié';
            Editable = false;
            OptionCaption = 'Hour based,Month based';
            OptionMembers = "Hour based","Month based";
        }
        field(10; Description; Text[60])
        {
            Caption = 'Désignation';
        }
        field(11; Note; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(12; Pourcentage; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(13; "Mois travaillés"; Decimal)
        {
        }
        field(20; Month; Option)
        {
            Caption = 'Mois';

            OptionCaption = 'Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,Congé,Prime,STC,Solder jour de congé';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,STC,"Solder jour de congé";
        }
        field(21; Year; Integer)
        {
            Caption = 'Année';
        }
        field(22; Quarter; Option)
        {
            Caption = 'Trimestre';
            OptionCaption = '1st,2nd,3rd,4th,+';
            OptionMembers = "1er","2ème","3ème","4ème","+";
        }
        field(23; "Days off remaining"; Decimal)
        {
            Caption = 'Days off remaining';
            Editable = true;
            FieldClass = Normal;
        }
        field(24; "Days off balacement"; Decimal)
        {
            Caption = 'Days off balacement';
            Editable = false;
        }
        field(25; Absences; Decimal)
        {
            Caption = 'Absences';
            FieldClass = Normal;
        }
        field(26; "Adjustment of absences"; Decimal)
        {
            Caption = 'Ajustement des absences';
        }
        field(27; "Days off"; Decimal)
        {
            Caption = 'Days off';
            Editable = false;
        }
        field(28; "Assiduity (Paid days)"; Decimal)
        {
            Caption = 'Assiduity (Paid days)';
        }
        field(29; "Assiduity (Worked days)"; Decimal)
        {
            Caption = 'Assiduity (Worked days)';
        }
        field(30; "Congé Pris"; Decimal)
        {
            Caption = 'Congé Pris';
        }
        field(35; "Worked hours"; Decimal)
        {
            Caption = 'Worked hours';
            FieldClass = Normal;
        }
        field(36; "Basis hours"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Basis hours';
            Editable = false;
            FieldClass = Normal;
        }
        field(37; "Amount Days Off balacement"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Montant congé Soldé';
        }
        field(38; "Assiduity (days off balacement"; Decimal)
        {
            Caption = 'Assiduité (Congé Soldé)';
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
            FieldClass = Normal;
        }
        field(43; "Real basis salary"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Real basis salary';
            DecimalPlaces = 3 : 3;
            Editable = true;
        }
        field(44; "Gross Salary"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Gross Salary';
            DecimalPlaces = 3 : 3;
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
            DecimalPlaces = 3 : 3;
        }
        field(48; "Indm. Impo. (N. Déd. Cot. Sc)"; Decimal)
        {
            AutoFormatType = 0;
            DecimalPlaces = 3 : 3;
        }
        field(49; "Gross Salary (sans Av) PR"; Decimal)
        {
            AutoFormatType = 0;
            DecimalPlaces = 3 : 3;
        }
        field(50; "Taxable salary"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxable salary';
            DecimalPlaces = 3 : 3;
        }
        field(55; "Deduction Family chief"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Deduction Family chief';
            DecimalPlaces = 3 : 3;
        }
        field(56; "Deduction Loaded child"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Deduction Loaded child';
            DecimalPlaces = 3 : 3;
        }
        field(57; "Deduction Prof. expenses"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Deduction Prof. expenses';
            DecimalPlaces = 3 : 3;
        }
        field(60; "Real taxable"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Real taxable';
            DecimalPlaces = 3 : 3;
        }
        field(65; "Total taxable rec."; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Total taxable rec.';
            DecimalPlaces = 3 : 3;
        }
        field(66; "Rec. payments"; Integer)
        {
            AutoFormatType = 0;
            Caption = 'Rec. payments';
        }
        field(67; "Real taxable (Year)"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Real taxable (Year)';
            DecimalPlaces = 3 : 3;
        }
        field(70; "Taxe (Year)"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxe (Year)';
            DecimalPlaces = 3 : 3;
        }
        field(71; "Total taxes rec."; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Total taxes rec.';
            DecimalPlaces = 3 : 3;
        }
        field(72; "Taxe (Month)"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxe (Month)';
            DecimalPlaces = 3 : 3;
        }
        field(80; "Non Taxable indemnities"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Non Taxable indemnities';
            DecimalPlaces = 3 : 3;
            FieldClass = Normal;
        }
        field(81; "Taxable Soc. Contrib."; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxable Soc. Contrib.';
            DecimalPlaces = 3 : 3;
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
            FieldClass = Normal;
        }
        field(121; "Global dimension 1"; Code[20])
        {
            Caption = 'Code département';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(122; "Global dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(244; "Gross Salary PR"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Gross Salary';
            DecimalPlaces = 3 : 3;
            Editable = true;
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
            DecimalPlaces = 3 : 3;
        }
        field(250; "Taxable salary PR"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Taxable salary';
            DecimalPlaces = 3 : 3;
            Editable = true;
        }
        field(500; "6 * SMIG"; Decimal)
        {
            AutoFormatType = 0;
            DecimalPlaces = 3 : 3;
        }
        field(600; "Type Prime"; Code[10])
        {
        }
        field(800; "Heures consomation congé"; Decimal)
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
            Description = '//MBY ENDA';
        }
        field(50001; Service; Code[10])
        {

        }
        field(50123; "Description Service"; Text[50])
        {
            Description = '//MBY ENDA';
            Editable = false;
        }
        field(50002; section; Code[10])
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
        field(50006; "Montant Jours Fériés travaillé"; Decimal)
        {
            CalcFormula = sum("Employee's days off Entry"."Montant Ligne" where("Employee No." = field(Employee),
                                                                                 "Posting month" = field(Month),
                                                                                 "Posting year" = field(Year),
                                                                                 "Line type" = filter("Jour férier payé")));
            FieldClass = FlowField;
        }

        field(50010; "Nombre de jours"; Decimal)
        {
        }
        field(50015; "Impot sur salaire"; Decimal)
        {
        }
        field(50017; "Revenu imposable"; Decimal)
        {
            Caption = 'Revenu imposable';
        }
        field(50018; "Nbr Jour Panier"; Decimal)
        {
        }
        field(50020; "Site de travail"; Code[10])
        {
            TableRelation = Direction;
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
        field(50030; TPA; Decimal)
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
            OptionMembers = "Espèce","Chéque",Virement;
        }
        /* field(50909; "Type Contrat Employee"; Option)
         {
             CalcFormula = lookup("Employment Contract"."Employee's type Contrat" where(Code = field("Emplymt. Contract Code")));
             FieldClass = FlowField;
             OptionCaption = ' ,CDD,CDI,SIVP I 1iere Année,SIVP I 2ieme Année,SIVP II,Stagiaire,Particulier';
             OptionMembers = " ",CDD,CDI,"SIVP I 1iere Année","SIVP I 2ieme Année","SIVP II",Stagiaire,Particulier;
         }
         field(60001; "Droit Acquis Par Ancienneté"; Decimal)
         {
             DecimalPlaces = 3 : 3;
             Description = 'HJ SORO 01-07-2016';
         }
         field(60003; Conducteur; Boolean)
         {
             Description = 'HJ SORO 01-03-2017';
         }
         field(60004; Chantier; Code[20])
         {
             Description = '27-05-2017';
         }
         field(60005; "Salaire Net sur fiche"; Decimal)
         {
             Description = 'HJ SORO 14-06-2017';
         }
         field(60006; "Contribution Social"; Decimal)
         {
             DecimalPlaces = 3 : 3;
             Description = 'HJ SORO 27-01-2018';
         }
         field(60007; "Impot Annuelle 2"; Decimal)
         {
             Description = 'HJ 30-01-2018';
         }
         field(60008; "Duplicata Imprimer"; Boolean)
         {
             Description = 'HJ SORO 16-04-2018';
         }
         field(60009; STC; Boolean)
         {
             Description = 'HJ SORO 21-06-20180';
         }
         field(60010; "Description Affectation"; Text[150])
         {
             // CalcFormula = lookup(Section.Decription where(Section = field(Affectation)));
             // Description = 'Mehdi.Haddad SORO 03-10-2019';
             // FieldClass = FlowField;
         }
         field(60011; "Description Qualification"; Text[150])
         {
             // CalcFormula = lookup(Qualification.Description where(Code = field(Qualification)));
             // Description = 'Mehdi.Haddad SORO 03-10-2019';
             // FieldClass = FlowField;
         }
         field(60012; "Salaire Brut sur Fiche"; Decimal)
         {
             Description = 'MH SORO 22-04-2024';
         }
         field(60013; "Total Indémnité sur Fiche"; Decimal)
         {
             Description = 'MH SORO 22-04-2024';
         }
         field(60014; "Salaire de base sur Fiche"; Decimal)
         {
             Description = 'MH SORO 22-04-2024';
         }
         field(60015; "Montant Heure Retenue"; Decimal)
         {
             Description = 'MH SORO 22-04-2024';
         }
         field(60016; "Montant Heure Normale"; Decimal)
         {
             Description = 'MH SORO 22-04-2024';
         }
         field(60017; "Montant Rappel"; Decimal)
         {
             Description = 'MH SORO 22-04-2024';
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
        field(8099200; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(8099201; "Heure Jours Free"; Decimal)
        {
        }
        field(39001490; Quinzainea; Option)
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
            Caption = 'Jours Payés';
        }
        field(39001497; "Compte Bancaire Societe"; Code[10])
        {
            TableRelation = "Bank Account"."No.";
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
        key(Key1; "No.", Employee)
        {
            Clustered = true;
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Supp. hours", "Taxable indemnities", "Ajout  en +", "Report en -", "Montant retenu caisse FS", "Salaire Net Imposable", "IUTS Net";
        }
        key(Key2; "Employee Posting Group", "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key3; Year, Employee, "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key4; Employee, Quarter, Year, "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key5; Employee, "Last Date Modified", "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key6; Year, Employee, Month, "No.", Imposable)
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key7; Year, Month, Employee, "No.", "Real taxable", CNSS, Imposable)
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Days off remaining", "Days off balacement", Absences, "Days off", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key8; Employee, Year, Month, "Type Prime")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key9; "No.", "Employee Posting Group", Employee)
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key10; Year, Month, "Global dimension 1", "Global dimension 2", "No.")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key11; "No.", "Num Compte")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key12; "year of Calculate", "Posting Date", Month, "Type Prime", "No.")
        {
        }
        key(Key13; Employee, "year of Calculate", Month, "Type Prime")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "6 * SMIG", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key14; Employee, "Posting Date", Month, "Type Prime")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "6 * SMIG", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key15; Year, Month, "Type Prime", Employee, "No.")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "6 * SMIG", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key16; Employee, "Employee Posting Group")
        {
        }
        key(Key17; "Statistics Group Code", Employee)
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities";
        }
        key(Key18; Year, Month, "No.")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
        key(Key19; "Statistics Group Code", Year, Month, "No.")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
        key(Key20; "Employee Posting Group", Employee)
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
        key(Key21; Year, Month, Employee, "No.", Imposable)
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours";
        }
        key(Key22; Year, Employee, "No.")
        {
            SumIndexFields = "Gross Salary", "Basis salary", "Real basis salary", "Net salary", "Net salary cashed", "Taxe (Month)", "Taxable salary", "Real taxable", "Ajout  en +", "Report en -", "Taxable indemnities", "Supp. hours", "Montant retenu caisse FS";
        }
        key(Key23; "Date Entree")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //IF CONFIRM (confDeleteMess,FALSE) THEN
        begin
            Indemnities.SetRange("No.", "No.");
            Indemnities.SetRange("Employee No.", Employee);
            if Indemnities.Find('-') then
                Indemnities.DeleteAll;

            SocialContributions.SetRange("No.", "No.");
            SocialContributions.SetRange(Employee, Employee);
            if SocialContributions.Find('-') then
                SocialContributions.DeleteAll;


        end
    end;

    trigger OnInsert()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
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
        Indemnities: Record Indemnities;
        SocialContributions: Record "Social Contributions";
        confDeleteMess: label 'Press Yes to confirm the suppression of the selected line(s).';
        LoanAdvanceLines: Record "Loan & Advance Lines";
}

