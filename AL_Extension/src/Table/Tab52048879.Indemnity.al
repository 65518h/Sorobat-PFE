Table 52048879 Indemnity
{
    //GL2024  ID dans Nav 2009 : "39001400" 
    Caption = 'Indemnity code';
    // DrillDownPageID = 71400;
    LookupPageID = Indemnity;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Taxable,Non taxable,Imposable (Non Assujettie Socialement),Assujettie non imposable';
            OptionMembers = Imposable,"Non imposable","Imposable (Non Assujettie Socialement)","Assujettie non imposable";
        }
        field(4; "Evaluation mode"; Option)
        {
            Caption = 'Evaluation mode';
            OptionCaption = 'Forfaitaire,sur Période payée,sur Période ouvrée,sur Heures travaillées,Nombre X Montant par défaut,Nbre Jours Travaillées,Montant = Brut * taux,Montant = Base * Montant,3*Smig Hor. Base,STC,Base*Nbr Jour';
            OptionMembers = Forfaitaire,"sur Période payée","sur Période ouvrée","sur Heures travaillées","Nombre X Montant par défaut","Nbre Jours Travaillées","Montant = Brut * taux","Montant = Base * Montant","3*Smig Hor. Base",STC,"Base*Nbr Jour";
        }
        field(10; "Default amount"; Decimal)
        {
            Caption = 'Default amount';
            DecimalPlaces = 3 : 3;
        }
        field(100; "Employee Posting Grp. filter"; Code[10])
        {
            Caption = 'Employee Posting Grp. filter';
            FieldClass = FlowFilter;
            TableRelation = "Employee Posting Group2";
        }
        field(101; "Payment No. filter"; Code[10])
        {
            Caption = 'Paie No. filter';
            FieldClass = FlowFilter;
            TableRelation = "Salary Headers";
        }
        field(110; "Total Indemnity"; Decimal)
        {
            AutoFormatType = 0;
            CalcFormula = sum(Indemnities."Real Amount" where(Indemnity = field(Code),
                                                               "No." = field("Payment No. filter"),
                                                               "Employee Posting Group" = field("Employee Posting Grp. filter")));
            Caption = 'Total indemnity amount';
            DecimalPlaces = 3 : 3;
            Editable = false;
            FieldClass = FlowField;
        }
        field(111; "Total Rec. Indemnity"; Decimal)
        {
            CalcFormula = sum("Rec. Indemnities"."Real Amount" where(Indemnity = field(Code),
                                                                      "No." = field("Payment No. filter"),
                                                                      "Employee Posting Group" = field("Employee Posting Grp. filter")));
            Caption = 'Total Indemnités enreg.';
            DecimalPlaces = 3 : 3;
            FieldClass = FlowField;
        }
        field(50000; "Minimum value"; Decimal)
        {
            Caption = 'Minimum value';
            DecimalPlaces = 3 : 3;
        }
        field(50002; "Nombre de jours"; Integer)
        {
        }
        field(50003; "Non déductible accident de Tra"; Boolean)
        {
        }
        field(50004; "Inclus dans heures supp"; Boolean)
        {
        }
        field(50005; Abattement; Boolean)
        {
        }
        field(50006; "% Abattement"; Decimal)
        {
        }
        field(50007; "Exonération"; Boolean)
        {
        }
        field(50008; "% Exonération"; Decimal)
        {
        }
        field(50009; "Plafond Exonération"; Decimal)
        {
        }
        field(50010; "Non Inclus en Calcul CNSS"; Boolean)
        {
        }
        field(50012; "Montant Exonération"; Decimal)
        {
        }
        field(50013; "Montant Abattement"; Decimal)
        {
        }
        field(50014; "Type STC"; Option)
        {
            OptionMembers = " ",Licenciement,"Decés","Depart Retraite","Congé Payé",Preavis,Forfaitaire;
        }
        field(50015; "Inclu Calcul Brut STC"; Boolean)
        {
        }
        field(50050; "Non Inclis en AV NAt"; Boolean)
        {
        }
        field(50051; "Non Inclue en jours férier"; Boolean)
        {
        }
        field(50052; "Compte indemnité"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50053; "Compte contre partie indemnité"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50060; "% salaire de base"; Boolean)
        {
        }
        field(50061; "Taux % salaire de base"; Decimal)
        {
        }
        /* field(50062; Retraite; Boolean)
         {
         }
         field(50064; "Non Cotisable"; Boolean)
         {
             Description = 'RB SORO 05/04/2016';
         }
         field(50065; "Panier Au Prorata Deplacement"; Boolean)
         {
             Description = 'HJ SORO 08-06-2016';
         }
         field(50066; "Non Imposable"; Boolean)
         {
             Description = 'HJ SORO 02/06/2018';
         }
         field(50067; STC; Boolean)
         {
             Description = 'HJ SORO 21-06-2018';
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
        field(39001440; Taux; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(39001441; "Type Indemnité"; Option)
        {
            OptionMembers = Regular,"Non Regular";
        }
        field(39001450; "non inclus en compta"; Boolean)
        {
        }
        field(39001451; "Non Inclus en Prime"; Boolean)
        {
        }
        field(39001460; "Precision Arrondi Montant"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(39001461; "Direction Arrondi"; Option)
        {
            OptionMembers = "=","<",">";
        }
        field(39001462; "Inclus dans base assurance"; Boolean)
        {
        }
        field(39001463; "Non Inclue en jours congé"; Boolean)
        {
        }
        field(39001464; "Indemnité conventionnelle"; Boolean)
        {
        }
        field(39001465; "base deduction indemnité/jours"; Integer)
        {
        }
        field(39001466; "base deduction indemnité/heure"; Integer)
        {
        }
        field(39001467; "Avantage en nature"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
        paramcpta.Get;
        "Precision Arrondi Montant" := paramcpta."Amount Rounding Precision";
        "Direction Arrondi" := 0;
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
        paramcpta: Record "General Ledger Setup";
}

