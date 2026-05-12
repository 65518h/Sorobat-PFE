Table 52048900 "Rec. Salary Headers"
{//GL2024  ID dans Nav 2009 : "39001427"
    // //>>DELTASOFT ACHOUR  27/02/2013
    //   AJOUT CHAMP 50000 ET 50001

    Caption = 'Salary Headers';
    /*GL2024 DrillDownPageID = "Recorded Payment List";
     LookupPageID = "Recorded Payment List";*/

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[60])
        {
            Caption = 'Description';
        }
        field(5; Month; Option)
        {
            Caption = 'Month';
            OptionCaption = 'Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,Congé,Prime,STC,Solder jour de congé';


            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,STC,"Solder jour de congé";
        }
        field(6; Year; Integer)
        {
            Caption = 'Year';
        }
        field(10; "Paid days"; Decimal)
        {
            Caption = 'Paid days';
        }
        field(11; "Worked days"; Decimal)
        {
            Caption = 'Worked days';
        }
        field(40; "Nbre Day Panier"; Decimal)
        {
            Caption = 'Nbre Jours Paniers';
        }
        field(48; "Taxable indemnities (Not Gross"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Indemnities"."Real Amount" where("No." = field("No."),
                                                                      Type = filter("Imposable (Non Assujettie Socialement)"),
                                                                      "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                      "Employee No." = field("Employee No. filter"),
                                                                      "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                      "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                      "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Indemnités imposables (Non Brut)';
            DecimalPlaces = 3 : 3;
            Description = 'Sum("Rec. Indemnities"."Real Amount" WHERE (No.=FIELD(No.),Type=FILTER(''Imposable (Non Assujettie Socialement)''),Employee Posting Group=FIELD(Employee posting grp. filter),Employee No.=FIELD(Employee No. filter),Global dimension 1=FIELD(Global dimension 1 Filter),Global dimension 2=FIELD(Global dimension 2 Filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Salary basis total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Salary Lines"."Real basis salary" where("No." = field("No."),
                                                                             "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                             Employee = field("Employee No. filter"),
                                                                             "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                             "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                             "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Salary basis total';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Taxable indemnities total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Salary Lines"."Taxable indemnities" where("No." = field("No."),
                                                                               "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                               Employee = field("Employee No. filter"),
                                                                               "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                               "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                               "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Taxable indemnities total';
            DecimalPlaces = 3 : 3;
            Description = 'Sum("Rec. Indemnities"."Real Amount" WHERE (No.=FIELD(No.),Type=FILTER(Imposable),Employee Posting Group=FIELD(Employee posting grp. filter),Employee No.=FIELD(Employee No. filter),Global dimension 1=FIELD(Global dimension 1 Filter),Global dimension 2=FIELD(Global dimension 2 Filter),Employee Statistic Group=FIELD(Filter gpe statistic)))';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Taxable indemnities total" := ROUND("Taxable indemnities total", 0.001);
                Modify;
            end;
        }
        field(52; "Non Taxable indemnities total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Indemnities"."Real Amount" where("No." = field("No."),
                                                                      Type = filter("Non imposable"),
                                                                      "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                      "Employee No." = field("Employee No. filter"),
                                                                      "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                      "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                      "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Non Taxable indemnities total';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(53; "Mission expenses total"; Decimal)
        {
            AutoFormatType = 0;

            CalcFormula = sum("Expenses to repay Header"."Document amount" where("Payment No." = field("No."),
                                                                                      "Employee No." = field("Employee No. filter"),
                                                                                      "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                      "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                                      "Global dimension 2" = field("Global dimension 2 Filter")));
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(54; "Non Taxable Soc. Contrib."; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Social Contributions"."Real Amount : Employee" where("No." = field("No."),
                                                                                          "Deductible of taxable basis" = filter(true),
                                                                                          "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                          Employee = field("Employee No. filter"),
                                                                                          "Globla dimension 1" = field("Global dimension 1 Filter"),
                                                                                          "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                                          "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Non Taxable Soc. Contrib.';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(55; "Taxable Soc. Contrib."; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Social Contributions"."Real Amount : Employee" where("No." = field("No."),
                                                                                          "Deductible of taxable basis" = filter(false),
                                                                                          "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                          Employee = field("Employee No. filter"),
                                                                                          "Globla dimension 1" = field("Global dimension 1 Filter"),
                                                                                          "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                                          "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Taxable Soc. Contrib.';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(56; "Total Charges patronales"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Social Contributions"."Real Amount : Employer" where("No." = field("No."),
                                                                                          "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                          Employee = field("Employee No. filter"),
                                                                                          "Globla dimension 1" = field("Global dimension 1 Filter"),
                                                                                          "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                                          "Employee Statistic Group" = field("Filter gpe statistic")));
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Loans repaiment total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Loan & Advance Lines"."Line Amount" where("Payment No." = field("No."),
                                                                          Type = filter(Loan),
                                                                          "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                          Employee = field("Employee No. filter"),
                                                                          "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                          "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                          "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Loans repaiment total';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(58; "Advances repaiment total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Loan & Advance Lines"."Line Amount" where("Payment No." = field("No."),
                                                                          Type = filter(Advance),
                                                                          "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                          Employee = field("Employee No. filter"),
                                                                          "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                          "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                          "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Advances repaiment total';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Taxes total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Salary Lines"."Taxe (Month)" where("No." = field("No."),
                                                                        "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                        Employee = field("Employee No. filter"),
                                                                        "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                        "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                        "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Taxes total';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Net salary total"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Salary Lines"."Net salary" where("No." = field("No."),
                                                                      "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                      Employee = field("Employee No. filter"),
                                                                      "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                      "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                      "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Net salary total';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Net salary cashed"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" where("No." = field("No."),
                                                                             "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                             Employee = field("Employee No. filter"),
                                                                             "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                             "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                             "Num Compte" = field("Filtre Num Compte"),
                                                                             "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Net salary cashed';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Total Gross salary"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Salary Lines"."Gross Salary" where("No." = field("No."),
                                                                        "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                        Employee = field("Employee No. filter"),
                                                                        "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                        "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                        "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Total Gross salary';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Total taxable"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Salary Lines"."Taxable salary" where("No." = field("No."),
                                                                          "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                          Employee = field("Employee No. filter"),
                                                                          "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                          "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                          "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Total taxable';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Total Supp. Hours"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Salary Lines"."Supp. hours" where("No." = field("No."),
                                                                       Employee = field("Employee No. filter"),
                                                                       Month = field(Month),
                                                                       Year = field(Year),
                                                                       "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                       "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Total Supp. Hours';
            DecimalPlaces = 3 : 3;
            Description = 'Sum("Heures sup. eregistrées"."Montant ligne" WHERE (Paiement No.=FIELD(No.),Mois de paiement=FIELD(Month),Année de paiement=FIELD(Year),N° Salarié=FIELD(Employee No. filter),Code departement=FIELD(Global Dimension 1 Filter),Code dossier=FIELD(Global Dimension 2 Filter),Employee Posting Group=FIELD(Employee posting grp. filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; Abcences; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = - sum("Employee's days off Entry"."Quantity (Days)" where("Posting month" = field(Month),
                                                                                    "Posting year" = field(Year),
                                                                                    "Employee No." = field("Employee No. filter"),
                                                                                    "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                    "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                                    "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                                    "Line type" = filter("Deductible of salary" | "1/2 paied"),
                                                                                    "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Absences';
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "Congés pris"; Decimal)
        {
            CalcFormula = - sum("Employee's days off Entry"."Quantity (Days)" where("Posting month" = field(Month),
                                                                                    "Posting year" = field(Year),
                                                                                    "Employee No." = field("Employee No. filter"),
                                                                                    "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                                    "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                                    "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                                    "Line type" = filter("Day off Consumption"),
                                                                                    "Employee Statistic Group" = field("Filter gpe statistic")));
            Caption = 'Days off';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90; "Salary lines"; Integer)
        {
            CalcFormula = count("Rec. Salary Lines" where("No." = field("No."),
                                                           "Employee Posting Group" = field("Employee posting grp. filter"),
                                                           Employee = field("Employee No. filter"),
                                                           "Global dimension 1" = field("Global dimension 1 Filter"),
                                                           "Global dimension 2" = field("Global dimension 2 Filter"),
                                                           "Statistics Group Code" = field("Filter gpe statistic")));
            Caption = 'Salary lines';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99; "Employee No. filter"; Code[10])
        {
            Caption = 'Employee No. filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(100; "Employee posting grp. filter"; Code[10])
        {
            Caption = 'Employee posting grp. filter';
            FieldClass = FlowFilter;
            TableRelation = "Employee Posting Group2";
        }
        field(101; "Global dimension 1 Filter"; Code[10])
        {
            Caption = 'Filtre Département';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(102; "Global dimension 2 Filter"; Code[10])
        {
            Caption = 'Filtre Dossier';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(110; "Intégré en comptabilité"; Boolean)
        {
            Editable = true;
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

        }
        field(900; "year of Calculate"; Integer)
        {
            Caption = 'Year of Calculate';
        }
        /*    field(50000; "Liquidation RCGC"; Boolean)
            {
                Description = 'ACHOUR 27/02/2013';
            }
            field(50001; "Retenue CGC"; Decimal)
            {
                // CalcFormula = sum("Rec. Salary Lines"."Retenue CGC" where("No." = field("No."),
                //                                                            "Employee Posting Group" = field("Employee posting grp. filter"),
                //                                                            Employee = field("Employee No. filter"),
                //                                                            "Global dimension 1" = field("Global dimension 1 Filter"),
                //                                                            "Global dimension 2" = field("Global dimension 2 Filter")));
                // DecimalPlaces = 0 : 0;
                // Description = 'ACHOUR 27/02/2013';
                // FieldClass = FlowField;
            }
            field(50004; STC; Boolean)
            {
                Description = 'HJ SORO 21-06-2018';
            }*/
        field(50020; "Filtre Site de travail"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = Direction;
        }
        field(50040; "Caisse fond social"; Decimal)
        {
            CalcFormula = sum("Rec. Salary Lines"."Montant retenu caisse FS" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(60000; "Number of monthes"; Option)
        {
            Caption = 'Number of monthes';
            OptionMembers = "Paies régulières","Rétributions provisoires","Paies régulières + Rétributions provisoires";
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
        field(39001456; "Filtre Num Compte"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(39001457; "Ajout en +"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Salary Lines"."Ajout  en +" where("No." = field("No."),
                                                                       "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                       Employee = field("Employee No. filter"),
                                                                       "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                       "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                       "Statistics Group Code" = field("Filter gpe statistic")));
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(39001458; "Report en -"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum("Rec. Salary Lines"."Report en -" where("No." = field("No."),
                                                                       "Employee Posting Group" = field("Employee posting grp. filter"),
                                                                       Employee = field("Employee No. filter"),
                                                                       "Global dimension 1" = field("Global dimension 1 Filter"),
                                                                       "Global dimension 2" = field("Global dimension 2 Filter"),
                                                                       "Statistics Group Code" = field("Filter gpe statistic")));
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(39001459; "Filter gpe statistic"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Employee Statistics Group";
        }
        field(39001463; "Regime quinzaine"; Code[10])
        {
            TableRelation = "Regimes of work".Code;
        }
        field(39001464; Quinzaine; Option)
        {
            Description = 'AGA DSFT 020-05-2011';
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
        key(STG_Key2; Year, Month, "No.")
        {
        }
        key(STG_Key3; "Posting Date", "No.")
        {
        }
        key(STG_Key4; "Posting Date", Month, "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        //  EmployeeResUpdate: Codeunit "Employee/Resource Update";
        //   EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
        //  DimMgt: Codeunit DimensionManagement;
        Header: Record "Rec. Salary Headers";
}

