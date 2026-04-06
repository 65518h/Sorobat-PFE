Table 50055 "Recup Default Indemnities 0305"
{
    Caption = 'Default Indemnities';
    //DYS
    // DrillDownPageID = 52048899;
    LookupPageID = "Default IndemnitiesX";

    fields
    {
        field(1; "Employment Contract Code"; Code[10])
        {
            Caption = 'Employment Contract Code';
            Editable = true;
            TableRelation = "Employment Contract";
        }
        field(2; "Indemnity Code"; Code[20])
        {
            Caption = 'Indemnity Code';
            NotBlank = true;
            TableRelation = Indemnity;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            Editable = true;
            OptionCaption = 'Taxable,Non taxable,Imposable (Non Assujettie Socialement),Assujettie non imposable';
            OptionMembers = Imposable,"Non imposable","Imposable (Non Assujettie Socialement)","Assujettie non imposable";
        }
        field(5; "Evaluation mode"; Option)
        {
            Caption = 'Evaluation mode';
            Editable = true;
            OptionCaption = 'Inclusive,on Paid period,on Worked period,on Worked hour,on Flight hours,Nbre Days Worked,Montant = Brut * taux,Montant = Base * Montant,on Worked Day Mission, No worked day mission';
            OptionMembers = Inclusive,"on Paid period","on Worked period","on Worked hour","on Flight hours","Nbre Days Worked","Montant = Brut * taux","Montant = Base * Taux","on Worked Day Mission","No worked day mission";
        }
        field(10; "Default amount"; Decimal)
        {
            Caption = 'Default amount';
            DecimalPlaces = 3 : 3;
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
        field(50006; "Ferié Congé Inclus Jours Payés"; Boolean)
        {
        }
        field(50007; "Inclure Calcul Exo Impot"; Boolean)
        {
        }
        field(50008; "Min Comptabilisable"; Decimal)
        {
        }
        field(50010; "Mois d'application"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50050; "Non Inclis en AV NAt"; Boolean)
        {
        }
        field(50051; "Inclus Base Calcul Ferié-Congé"; Boolean)
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
        field(50062; Retraite; Boolean)
        {
        }
        field(50063; Trouver; Boolean)
        {
        }
        field(50064; "Non Cotisable"; Boolean)
        {
            Description = 'RB SORO 05/04/2016';
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
        field(39001463; "Basis amount"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Montant de base';
            DecimalPlaces = 3 : 3;
        }
        field(39001464; "Non Inclue en jours congé"; Boolean)
        {
        }
        field(39001465; "Indemnité conventionnelle"; Boolean)
        {
        }
        field(39001466; "base deduction indemnité/jours"; Integer)
        {
        }
        field(39001467; "base deduction indemnité/heure"; Integer)
        {
        }
        field(39001468; "Avantage en nature"; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Employment Contract Code", "Indemnity Code", "Non Inclus en Prime")
        {
            Clustered = true;
            SumIndexFields = "Default amount", "Basis amount";
        }
        key(STG_Key2; "Type Indemnité", "Indemnity Code", "Employment Contract Code")
        {
            SumIndexFields = "Basis amount";
        }
        key(STG_Key3; "Employment Contract Code", "Evaluation mode", "Non Inclue en jours congé", Type, "Indemnité conventionnelle")
        {
            SumIndexFields = "Basis amount";
        }
        key(STG_Key4; "Indemnity Code", "Employment Contract Code", "Type Indemnité", "Inclure Calcul Exo Impot")
        {
            SumIndexFields = "Basis amount", "Default amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
        lEmployee: Record Employee;
    begin
    end;

    var
        Indemnity: Record Indemnity;
        SelectedInd: Record Indemnity;
        SocialContribution: Record "Social Contribution";
        //GL3900  "Soc. Contribution per Ind.": Record "Soc. Contribution per Ind.";
        "Default Soc. Contribution": Record "Default Soc. Contribution";
        msg: label 'Social contribution line exiting. Unable to insert the new line.';
        EmploymentContract: Record "Employment Contract";
        errMsg: label 'Mode d''évaluation de l''Indemnité doit être "sur Heures travaillées" ou "Forfaitaire"';
        //GL2024  FormIndemnity: page 52048879;
        Regimesofwork: Record "Regimes of work";
        "Collège1": Record "CATEGORIES";
        Emp: Record Employee;
        RecGParamResshum: Record "Human Resources Setup";
}

