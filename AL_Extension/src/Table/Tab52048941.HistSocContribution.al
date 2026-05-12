Table 52048941 "Hist. Soc. Contribution"
{
    //GL2024  ID dans Nav 2009 : "39001512"
    fields
    {
        field(1; "Employment Contract Code"; Code[10])
        {
            Caption = 'Employment Contract Code';
            Editable = false;
            TableRelation = "Historique contrat de travail";
        }
        field(2; "Social Contribution Code"; Code[10])
        {
            Caption = 'Social Contribution Code';
            NotBlank = true;
            TableRelation = "Social Contribution";

            trigger OnValidate()
            begin
                if SocialContribution.Get("Social Contribution Code") then begin
                    "Employer's part" := SocialContribution."Employer's part";
                    "Employee's part" := SocialContribution."Employee's part";
                    "Basis of calculation" := SocialContribution."Basis of calculation";
                    "Deductible of taxable basis" := SocialContribution."Deductible of taxable basis";
                    "Maximum value - Employee" := SocialContribution."Maximum value - Employee";
                    "Maximum value - Employer" := SocialContribution."Maximum value - Employer";

                    "Mode dévaluation" := SocialContribution."Mode dévaluation";
                    "Forfait salarial" := SocialContribution."Forfait salarial";
                    "Forfait patronal" := SocialContribution."Forfait patronal";
                    "Non inclus en compta" := SocialContribution."non inclus en compta";
                end;
                SAL.Reset;
                if "Social Contribution Code" = 'ASS GRP' then begin
                    if SAL.Get("Employment Contract Code") then
                        SAL.TestField("Affilé ASS GRP", true);
                end
            end;
        }
        field(3; "Indemnity Code"; Code[20])
        {
            Caption = 'Indemnity Code';
            TableRelation = "Default Indemnities"."Indemnity Code" where("Employment Contract Code" = field("Employment Contract Code"));
        }
        field(4; "Employer's part"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Employer''s part';
            Editable = true;
        }
        field(5; "Employee's part"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Employee''s part';
            Editable = true;
        }
        field(15; "Basis of calculation"; Option)
        {
            Caption = 'Basis of calculation';
            Editable = false;
            OptionCaption = 'Base = Brut du mois,Base = Brut du mois-(6*SMIG),Base = Salaire de base';
            OptionMembers = "Base = Brut du mois","Base = Brut du mois-(6*SMIG)","Base = Salaire de base";
        }
        field(25; "Deductible of taxable basis"; Boolean)
        {
            Caption = 'Deductible of taxable basis';
            Editable = true;
        }
        field(50000; "Maximum value - Employee"; Decimal)
        {
            Caption = 'Maximum value - Employee';
            DecimalPlaces = 3 : 3;
        }
        field(50001; "Maximum value - Employer"; Decimal)
        {
            Caption = 'Maximum value - Employer';
            DecimalPlaces = 3 : 3;
        }
        field(50010; "Mode dévaluation"; Option)
        {
            OptionMembers = "Montant = Base * Taux","Montant = Montant Forfaitaire","Montant = Imposable * Taux","Montant = Brut (Sans AV) * Taux";
        }
        field(50011; "Forfait salarial"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50012; "Forfait patronal"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(8099198; "User ID"; Code[10])
        {
            Editable = false;
            TableRelation = User;
        }
        field(8099199; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(39001450; "Non inclus en compta"; Boolean)
        {
        }
        field(39001451; "Non Inclus en Prime"; Boolean)
        {
        }
        field(39001537; "Code contrat archivé"; Integer)
        {
            TableRelation = "Historique contrat de travail";
        }
    }

    keys
    {
        key(STG_Key1; "Employment Contract Code", "Social Contribution Code", "Indemnity Code", "Code contrat archivé")
        {
            Clustered = true;
        }
        key(STG_Key2; "Code contrat archivé", "Employment Contract Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := UserId;
        "Last Date Modified" := WorkDate;
    end;

    trigger OnModify()
    begin
        "User ID" := UserId;
        "Last Date Modified" := WorkDate;
    end;

    trigger OnRename()
    begin
        "User ID" := UserId;
        "Last Date Modified" := WorkDate;
    end;

    var
        SocialContribution: Record "Social Contribution";
        SAL: Record Employee;
}

