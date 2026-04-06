Table 52048896 "Salary Headers"
{//GL2024  ID dans Nav 2009 : "39001423"
    // //>>DELTASOFT ACHOUR  27/02/2013
    //   AJOUT CHAMP 50000 ET 50001

    Caption = 'Salary Headers';
    DrillDownPageID = "Payment List NAP";
    LookupPageID = "Payment List NAP";

    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(5; Month; Option)
        {
            Caption = 'Mois';
            OptionCaption = 'Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,Congé,Prime,STC,Solder jour de congé';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,STC,"Solder jour de congé";

            trigger OnValidate()
            var
                EntSal: Record "Rec. Salary Headers";
            begin
                HumanResSetup.Get;

                if Month < 12 then
                    "Posting Date" := Dmy2date(HumanResSetup."Date de Calcul de Paie", Month + 1, Year);
                //ELSE
                //"Posting Date"       := WORKDATE;

                if ((Month = 13) or (Month = 14)) and ("year of Calculate" = Year) then begin
                    EntSal.Reset;
                    EntSal.SetRange(Year, Year);
                    EntSal.SetFilter(Month, '..11');
                    if EntSal.Find('+') then
                        "Posting Date" := EntSal."Posting Date";
                end;
                Description := 'Paie de ' + Format(Month) + ' ' + Format(Year);
                IF Month = Month::Prime THEN "Désactiver calcul des prêts" := TRUE ELSE "Désactiver calcul des prêts" := FALSE;
            end;
        }
        field(6; Year; Integer)
        {
            Caption = 'Année';

            trigger OnValidate()
            begin
                "year of Calculate" := Year;
            end;
        }
        field(10; "Paid days"; Decimal)
        {
            Caption = 'Paid days';
        }
        field(11; "Worked days"; Decimal)
        {
            Caption = 'Worked days';
        }
        field(48; "Taxable indemnities (Not Gross"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum(Indemnities."Real Amount" where("No." = field("No."),
                                                               Type = filter("Imposable (Non Assujettie Socialement)"),
                                                               "Employee Posting Group" = field("Employee posting grp. filter"),
                                                               "Employee No." = field("Employee No. filter"),
                                                               "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                               "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                               "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Indemnités imposables (Non Brut)';
            DecimalPlaces = 3 : 3;
            Description = 'Sum(Indemnities."Real Amount" WHERE (No.=FIELD(No.),Type=FILTER(''Imposable (Non Assujettie Socialement)''),Employee Posting Group=FIELD(Employee posting grp. filter),Employee No.=FIELD(Employee No. filter),Global Dimension 1=FIELD(Global Dimension 1 Filter),Global Dimension 2=FIELD(Global Dimension 2 Filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Salary basis total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Salary Lines"."Real basis salary" where("No." = field("No."),
                                                                        "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                        Employee = field("Employee No. filter"),
                                                                        "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                        "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Total salaire de base';
            DecimalPlaces = 3 : 3;
            Description = 'Sum("Salary Lines"."Real basis salary" WHERE (No.=FIELD(No.),Employee Posting Group=FIELD(Employee posting grp. filter),Employee=FIELD(Employee No. filter),Global Dimension 1=FIELD(Global Dimension 1 Filter),Global Dimension 2=FIELD(Global Dimension 2 Filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Taxable indemnities total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Salary Lines"."Taxable indemnities" where("No." = field("No."),
                                                                          "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                          Employee = field("Employee No. filter"),
                                                                          "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                          "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                          "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Taxable indemnities total';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; "Non Taxable indemnities total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum(Indemnities."Real Amount" where("No." = field("No."),
                                                               Type = filter("Non imposable"),
                                                               "Employee Posting Group" = field("Employee posting grp. filter"),
                                                               "Employee No." = field("Employee No. filter"),
                                                               "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                               "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                               "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Non Taxable indemnities total';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(53; "Mission expenses total"; Decimal)
        {
            AutoFormatType = 0;
            BlankNumbers = DontBlank;

            CalcFormula = sum("Expenses to repay Header"."Document amount" where("Payment No." = field("No."),
                                                                                    "Employee No." = field("Employee No. filter"),
                                                                                    "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                    "Global dimension 1" = field("Global Dimension 1 Filter"),
                                                                                    "Global dimension 2" = field("Global Dimension 2 Filter")));
            Caption = 'Mission expenses total';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(54; "Non Taxable Soc. Contrib."; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Social Contributions"."Real Amount : Employee" where("No." = field("No."),
                                                                                     "Deductible of taxable basis" = filter(true),
                                                                                     "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                     Employee = field("Employee No. filter"),
                                                                                     "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                                     "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                                     "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Non Taxable Soc. Contrib.';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(55; "Taxable Soc. Contrib."; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Social Contributions"."Real Amount : Employee" where("No." = field("No."),
                                                                                     "Deductible of taxable basis" = filter(false),
                                                                                     "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                     Employee = field("Employee No. filter"),
                                                                                     "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                                     "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                                     "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Taxable Soc. Contrib.';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(56; "Total Charges patronales"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Social Contributions"."Real Amount : Employer" where("No." = field("No."),
                                                                                     "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                     Employee = field("Employee No. filter"),
                                                                                     "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                                     "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                                     "Employee Statistic Group" = field("Filter gpe statistic")));
            DecimalPlaces = 3 : 3;
            Description = 'Sum("Social Contributions"."Real Amount : Employer" WHERE (No.=FIELD(No.),Employee Posting Group=FIELD(Employee posting grp. filter),Employee=FIELD(Employee No. filter),Global Dimension 1=FIELD(Global Dimension 1 Filter),Global Dimension 2=FIELD(Global Dimension 2 Filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Loans repaiment total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Loan & Advance Lines"."Line Amount" where(Employee = field("Employee No. filter"),
                                                                          "Payment No." = field("No."),
                                                                          Month = field(Month),
                                                                          Year = field(Year),
                                                                          "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                          "Global dimension 1" = field("Global Dimension 1 Filter"),
                                                                          "Global dimension 2" = field("Global Dimension 2 Filter"),
                                                                          Type = const(Loan),
                                                                          "Document type" = field("Loan & Advance Type filter"),
                                                                          "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Total rembourcement Prêts';
            DecimalPlaces = 3 : 3;
            Description = 'Sum("Salary Lines".Loans WHERE (No.=FIELD(No.),Employee=FIELD(Employee No. filter),Month=FIELD(Month),Year=FIELD(Year),Global Dimension 1=FIELD(Global Dimension 1 Filter),Global Dimension 2=FIELD(Global Dimension 2 Filter),Employee Posting Group=FIELD(Employee posting grp. filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(58; "Advances repaiment total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Loan & Advance Lines"."Line Amount" where(Employee = field("Employee No. filter"),
                                                                          "Payment No." = field("No."),
                                                                          Month = field(Month),
                                                                          Year = field(Year),
                                                                          "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                          "Global dimension 1" = field("Global Dimension 1 Filter"),
                                                                          "Global dimension 2" = field("Global Dimension 2 Filter"),
                                                                          Type = const(Advance),
                                                                          "Document type" = field("Loan & Advance Type filter"),
                                                                          "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Total rembourcement Avances';
            DecimalPlaces = 3 : 3;
            Description = 'Sum("Salary Lines".Advances WHERE (No.=FIELD(No.),Employee=FIELD(Employee No. filter),Month=FIELD(Month),Year=FIELD(Year),Global Dimension 1=FIELD(Global Dimension 1 Filter),Global Dimension 2=FIELD(Global Dimension 2 Filter),Employee Posting Group=FIELD(Employee posting grp. filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Taxes total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Salary Lines"."Taxe (Month)" where("No." = field("No."),
                                                                   "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                   Employee = field("Employee No. filter"),
                                                                   "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                   "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                   "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Taxes total';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Net salary total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Salary Lines"."Net salary" where("No." = field("No."),
                                                                 "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                 Employee = field("Employee No. filter"),
                                                                 "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                 "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                 "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Total Net sur salaire de base';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Net salary cashed"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Salary Lines"."Net salary cashed" where("No." = field("No."),
                                                                        "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                        Employee = field("Employee No. filter"),
                                                                        "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                        "Num Compte" = field("Filter num compte"),
                                                                        "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Net salary cashed';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Total Gross salary"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Salary Lines"."Gross Salary" where("No." = field("No."),
                                                                   "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                   Employee = field("Employee No. filter"),
                                                                   "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                   "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                   "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Total des Salaires bruts';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Total taxable"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Salary Lines"."Taxable salary" where("No." = field("No."),
                                                                     "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                     Employee = field("Employee No. filter"),
                                                                     "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                     "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                     "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Total taxable';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Total Supp. Hours"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Salary Lines"."Supp. hours" where("No." = field("No."),
                                                                  "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                  Employee = field("Employee No. filter"),
                                                                  "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                  "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Total Heures Sup.';
            DecimalPlaces = 3 : 3;
            Description = 'Sum("Salary Lines"."Supp. hours" WHERE (No.=FIELD(No.),Month=FIELD(Month),Year=FIELD(Year),Global Dimension 1=FIELD(Global Dimension 1 Filter),Global Dimension 2=FIELD(Global Dimension 2 Filter),Employee Posting Group=FIELD(Employee posting grp. filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; Abcences; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Employee's days off Entry"."Quantity (Days)" where("Posting month" = field(Month),
                                                                                   "Posting year" = field(Year),
                                                                                   "Employee No." = field("Employee No. filter"),
                                                                                   "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                   "Global dimension 1" = field("Global Dimension 1 Filter"),
                                                                                   "Global dimension 2" = field("Global Dimension 2 Filter")));
            Caption = 'Absences';
            DecimalPlaces = 3 : 3;
            Description = 'Sum("Employee''s days off Entry"."Quantity (Days)" WHERE (Posting month=FIELD(Month),Posting year=FIELD(Year),Employee No.=FIELD(Employee No. filter),Employee Posting Group=FIELD(Employee posting grp. filter),Global dimension 1=FIELD(Global Dimension 1 Filter),Global dimension 2=FIELD(Global Dimension 2 Filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "Congés pris"; Decimal)
        {
            CalcFormula = sum("Employee's days off Entry"."Quantity (Days)" where("Posting month" = field(Month),
                                                                                   "Posting year" = field(Year),
                                                                                   "Employee No." = field("Employee No. filter"),
                                                                                   "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                   "Global dimension 1" = field("Global Dimension 1 Filter"),
                                                                                   "Global dimension 2" = field("Global Dimension 2 Filter")));
            Caption = 'Days off';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90; "Salary lines"; Integer)
        {
            CalcFormula = count("Salary Lines" where("No." = field("No."),
                                                      "Employee Posting Group" = field("Employee posting grp. filter"),
                                                      Employee = field("Employee No. filter"),
                                                      "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                      "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                      "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Lignes de salaire';
            Editable = false;
            FieldClass = FlowField;
        }
        field(98; "Loan & Advance Type filter"; Code[10])
        {
            Caption = 'Loan & Advance Type filter';
            FieldClass = FlowFilter;
            TableRelation = "Loan & Advance Type";
        }
        field(99; "Employee No. filter"; Code[10])
        {
            Caption = 'Employee No. filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(100; "Employee posting grp. filter"; Code[10])
        {
            Caption = 'Filtre Groupe compta. salarié';
            FieldClass = FlowFilter;
            TableRelation = "Employee Posting Group2";
        }
        field(101; "Global Dimension 1 Filter"; Code[10])
        {
            Caption = 'Code département';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(102; "Global Dimension 2 Filter"; Code[10])
        {
            Caption = 'Code dossier';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(300; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(400; "Taxes regulation"; Option)
        {
            Caption = 'Taxes regulation';
            Editable = false;
            OptionCaption = 'Dynamic,12th and more';
            OptionMembers = Dynamic,"12th and more";
        }
        field(600; "Type Prime"; Code[10])
        {
            //GL2024 TableRelation = if (Month = const(Prime)) Table60004.Field1;
        }
        field(900; "year of Calculate"; Integer)
        {
            Caption = 'Year of Calculate';

            trigger OnValidate()
            begin
                Validate(Month);
            end;
        }
        /*  field(50000; "Liquidation RCGC"; Boolean)
          {
              Description = 'ACHOUR 27/02/2013';
          }
          field(50001; "Retenue CGC"; Decimal)
          {
              CalcFormula = sum("Salary Lines"."Retenue CGC" where("No." = field("No."),
                                                                    Employee = field("Employee No. filter"),
                                                                    "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                    "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                    "Global Dimension 2" = field("Global Dimension 2 Filter")));
              DecimalPlaces = 0 : 0;
              Description = 'ACHOUR 27/02/2013';
              FieldClass = FlowField;
          }
          field(50002; "Integrer Rappel"; Boolean)
          {
              Description = 'HJ SORO 05-01-18';
          }
          field(50003; "Année Rappel"; Integer)
          {
              Description = 'HJ SORO 05-01-18';
          }
          field(50004; STC; Boolean)
          {
              Description = 'HJ SORO 21-06-2018';
          }*/
        field(50010; "Désactiver calcul des prêts"; Boolean)
        {
            Description = 'AGA';
        }
        field(60000; "Number of monthes"; Option)
        {
            Caption = 'Number of monthes';
            OptionMembers = "Paies régulières","Rétributions provisoires","Paies régulières + Rétributions provisoires";
        }
        field(60001; "Salary lines Virrement"; Integer)
        {
            CalcFormula = count("Salary Lines" where("No." = field("No."),
                                                      "Employee Posting Group" = field("Employee posting grp. filter"),
                                                      Employee = field("Employee No. filter"),
                                                      "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                      "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                      "RIB Salarié" = filter(<> ''),
                                                      "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Salary lines';
            Description = 'Count("Salary Lines" WHERE (No.=FIELD(No.),Employee Posting Group=FIELD(Employee posting grp. filter),Employee=FIELD(Employee No. filter),Global Dimension 1=FIELD(Global Dimension 1 Filter),Global Dimension 2=FIELD(Global Dimension 2 Filter),RIB Salarié=FILTER(<>'''')))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60002; "Net salary cashed Virement"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Salary Lines"."Net salary cashed" where("No." = field("No."),
                                                                        "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                        Employee = field("Employee No. filter"),
                                                                        "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                        "Num Compte" = field("Filter num compte"),
                                                                        "RIB Salarié" = filter(<> ''),
                                                                        "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Net salary cashed';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        /*    field(60003; "N° STC"; Code[20])
            {
                Description = 'HJ SORO 02-08-2018';
            }*/
        field(8099197; "Up to date"; Boolean)
        {
            Caption = 'Up to date';
            Editable = false;
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
        field(39001456; "Filter num compte"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(39001457; "Ajout en +"; Decimal)
        {
            CalcFormula = sum("Salary Lines"."Ajout  en +" where("No." = field("No."),
                                                                  "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                  Employee = field("Employee No. filter"),
                                                                  "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                  "Statistics Group Code" = field("Filter gpe statistic")));
            DecimalPlaces = 3 : 3;
            FieldClass = FlowField;
        }
        field(39001458; "Report en -"; Decimal)
        {
            CalcFormula = sum("Salary Lines"."Report en -" where("No." = field("No."),
                                                                  "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                  Employee = field("Employee No. filter"),
                                                                  "Global Dimension 1" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2" = field("Global Dimension 2 Filter"),
                                                                  "Statistics Group Code" = field("Filter gpe statistic")));
            DecimalPlaces = 3 : 3;
            FieldClass = FlowField;
        }
        field(39001459; "Filter gpe statistic"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Employee Statistics Group";
        }
        /*  field(39001460; "Filter Direction"; Code[10])
          {
              TableRelation = Direction;
          }
          field(39001461; "Filter Service"; Code[10])
          {
              TableRelation = Service;
          }
          field(39001462; "Filter Section"; Code[10])
          {
              TableRelation = "Tranche STC";
          }*/
        field(39001463; "Regime quinzaine"; Code[10])
        {
            TableRelation = "Regimes of work".Code;
        }
        field(39001464; Quinzaine; Option)
        {
            Description = 'AGA DSFT 02-05-2011';
            OptionCaption = '1er,2ème,Autre';
            OptionMembers = "1er","2ème",Autre;
        }
    }

    keys
    {
        key(STG_Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var

    begin


        /*GL Lines.SetRange("No.", "No.");
               Lines.DeleteAll;

               Ind.SetRange("No.", "No.");
               Ind.DeleteAll;

               Cot.SetRange("No.", "No.");
               Cot.DeleteAll;

               LoanAdvanceLines.SetRange(Status, 0);
               LoanAdvanceLines.SetRange("Payment No.", "No.");
               LoanAdvanceLines.SetRange(Paid, false);
               LoanAdvanceLines.DeleteAll;*/


        //GL2024
        // Vérifier si des lignes existent pour ce Header
        SalaryLine.Reset();
        Lines.SetRange("No.", Rec."No.");


        if Lines.FindFirst() then begin
            if Lines."No." <> 'SIMULATION' then
                Error('Vous ne pouvez pas supprimer la paie %1, car elle contient des lignes.', Rec."No.")
        end
        else
            Lines.SetRange("No.", "No.");
        Lines.DeleteAll;

        Ind.SetRange("No.", "No.");
        Ind.DeleteAll;

        Cot.SetRange("No.", "No.");
        Cot.DeleteAll;

        LoanAdvanceLines.SetRange(Status, 0);
        LoanAdvanceLines.SetRange("Payment No.", "No.");
        LoanAdvanceLines.SetRange(Paid, false);
        LoanAdvanceLines.DeleteAll;

    end;

    trigger OnInsert()
    begin

        IF HumanResSetup.GET THEN;

        IF "No." = '' THEN BEGIN
            HumanResSetup.TESTFIELD("Paiment Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Paiment Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;

        "Paid days" := HumanResSetup."Paid days";
        "Worked days" := HumanResSetup."Worked days";
        RecSalaryHeader.SETCURRENTKEY("Posting Date", Month, "No.");
        RecSalaryHeader.SETRANGE(Month, 0, 12);
        IF RecSalaryHeader.FIND('+') THEN BEGIN
            IF RecSalaryHeader.Month < 11 THEN BEGIN
                Month := RecSalaryHeader.Month + 1;
                Year := RecSalaryHeader.Year;
                "year of Calculate" := Year;
            END
            ELSE BEGIN
                Month := 0;
                Year := RecSalaryHeader.Year + 1;
                "year of Calculate" := Year;
            END;
        END
        ELSE BEGIN
            Month := DATE2DMY(WORKDATE, 2) - 1;
            Year := DATE2DMY(WORKDATE, 3);
            "year of Calculate" := Year;
        END;

        Description := 'Paie de ' + FORMAT(Month) + ' ' + FORMAT(Year);

        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
        "Posting Date" := DMY2DATE(HumanResSetup."Date de Calcul de Paie", Month + 1, Year);
    end;

    trigger OnModify()
    begin
        Lines.SetRange("No.", "No.");
        if Lines.Find('-') then
            Error(errExistingLines);

        "Up to date" := false;
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    var

        HumanResSetup: Record "Human Resources Setup";
        SalaryLine: Record "Salary Lines";
        NoSeriesMgt: Codeunit 396;
        EmployeeResUpdate: Codeunit "Employee/Resource Update";
        EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
        DimMgt: Codeunit DimensionManagement;
        Header: Record "Salary Headers";
        Lines: Record "Salary Lines";
        Ind: Record Indemnities;
        Cot: Record "Social Contributions";
        LoanAdvanceLines: Record "Loan & Advance Lines";
        RecSalaryHeader: Record "Rec. Salary Headers";
        errExistingLines: label 'En-tête salaire ne peut pas être mise à jour tant qu''il y a des lignes de salaires qui y sont rattachées.';


    procedure AssistEdit(OldHeader: Record "Salary Headers"): Boolean
    begin
        with Header do begin
            Header := Rec;
            HumanResSetup.Get;
            HumanResSetup.TestField("Paiment Nos.");
            if NoSeriesMgt.SelectSeries(HumanResSetup."Paiment Nos.", OldHeader."No. Series", "No. Series") then begin
                HumanResSetup.Get;
                HumanResSetup.TestField("Paiment Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := Header;
                exit(true);
            end;
        end;
    end;
}

