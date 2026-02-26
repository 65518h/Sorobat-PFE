Table 52048882 "Regimes of work"
{//GL2024  ID dans Nav 2009 : "39001404"
    Caption = 'Regimes of work';
    DrillDownPageID = "List : Regimes of work";
    LookupPageID = "List : Regimes of work";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; "Désignation"; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Work Hours per week"; Decimal)
        {
            Caption = 'Working hours per week';
        }
        field(10; "Max. Supp. Hours per month"; Decimal)
        {
            Caption = 'Max. Supp. Hours per month';
        }
        field(15; "Days off per month"; Decimal)
        {
            Caption = 'Days off per month';
        }
        field(16; "Assignement mode"; Option)
        {
            Caption = 'Assignement mode';
            OptionCaption = 'Relative,Absolute';
            OptionMembers = Relative,Absolute;
        }
        field(40; "Default Regime"; Boolean)
        {
            Caption = 'Default Regime';
        }
        field(50; "Worked Day Per Month"; Decimal)
        {
            Caption = 'Worked Day Per Month';

            trigger OnValidate()
            begin
                "Nbre Jour Payé Per Month" := "Worked Day Per Month";
                Modify
            end;
        }
        field(100; "Work Hours per month"; Decimal)
        {
            Caption = 'Heures par mois';
        }
        /*   field(50000; "Nombre Heure Par Jour"; Integer)
           {
           }
           field(50001; "Appliquer Heure Supp"; Boolean)
           {
           }*/
        field(50100; "Rate of Night"; Decimal)
        {
            Caption = 'Rate of Night';
        }
        field(50101; "Rate of No Working Day"; Decimal)
        {
            Caption = 'Rate of No Working Day';
        }
        field(50102; "Rate of No Working Paied Day"; Decimal)
        {
            Caption = 'taux chôme Payé';
        }
        field(50200; "Rate of Roulement"; Decimal)
        {
            Caption = 'Rate of Roulement';
        }
        field(50201; "Appliquer Régime"; Boolean)
        {
        }
        field(50202; "taux indem panier"; Decimal)
        {
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
        field(39001440; "Type Calendar"; Option)
        {
            OptionMembers = " ",Administratif,Roulement,Chantier;
        }
        field(39001450; "Activer Jour Repos"; Boolean)
        {
        }
        field(39001460; "Rate of Repos Days"; Decimal)
        {
            Caption = 'taux jours Repos';
        }
        field(39001461; "Type Calcul H. Supp."; Option)
        {
            OptionCaption = 'Hebdomadaire,Mensuel,Pas D''heures Supp.';
            OptionMembers = Hebdomadaire,Mensuel,"Pas D'heures Supp.";
        }
        field(39001462; "Type Calcul H Nuit"; Option)
        {
            OptionMembers = "Seulement H Nuit","Avec H Normale";
        }
        field(39001463; "Nbre Jour Payé Per Month"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(39001464; "Taux heure supp maj"; Decimal)
        {
            Description = '//mby SAMI';
        }
        field(39001465; "From Work day to Work hour"; Decimal)
        {
            Caption = 'From Work day to Work hour';
            DecimalPlaces = 3 : 3;
        }
        field(39001466; "Taux Jours Férié"; Decimal)
        {
        }
        field(39001467; "Rétributions Ancienneté/An"; Decimal)
        {
        }
        field(39001468; "Plafond Ancienneté/An"; Decimal)
        {
        }
        field(39001470; "Limite ancienneté"; Decimal)
        {
        }
        field(39001490; "type calcul paie"; Option)
        {
            OptionCaption = 'Mensuel,Quinzaine';
            OptionMembers = Mensuel,Quinzaine;
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

    trigger OnDelete()
    var
        errorDelete: label 'Erreur :\Impossible de supprimer cette ligne car elle est en relation avec certain salariés existants.';
    begin
    end;

    trigger OnInsert()
    begin
        /*"Last Date Modified" := WORKDATE;
        "User ID"          := USERID;
        */

    end;

    trigger OnModify()
    begin
        /*"Last Date Modified" := WORKDATE;
        "User ID"          := USERID; */

    end;

    trigger OnRename()
    begin
        /*"Last Date Modified" := WORKDATE;
        "User ID"          := USERID;   */

    end;

    var
        "RégimeTravail": Record "Bon Reglement";
        "RégimeTravailTmp": Record "Bon Reglement";
        "Salarié": Record Employee;
}

