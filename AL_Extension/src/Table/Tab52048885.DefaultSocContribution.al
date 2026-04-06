Table 52048885 "Default Soc. Contribution"
{//GL2024  ID dans Nav 2009 : "39001407"
    // //>>DELTASOFT ACHOUR 27/02/2013
    // Ajout option dans base de calcul ,Base = Net du mois


    fields
    {
        field(1; "Employment Contract Code"; Code[10])
        {
            Caption = 'Employment Contract Code';
            Editable = false;
            TableRelation = "Employment Contract";
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
                    "Plafond SBase*8%" := SocialContribution."Plafond SBase*8%";
                    CNSS := SocialContribution.CNSS;
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
            Description = 'ACHOUR 27/02/2013 ajout option ,Base = Net du mois';
            Editable = false;
            OptionCaption = 'Base = Brut du mois,Base = Brut du mois-(6*SMIG),Base = Salaire de base,Base = Net du mois,Net imposable';
            OptionMembers = "Base = Brut du mois","Base = Brut du mois-(6*SMIG)","Base = Salaire de base","Base = Net du mois","Net imposable";
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
        field(50013; "Plafond SBase*8%"; Boolean)
        {
        }
        field(50014; "Designation Contribution"; Text[50])
        {
            CalcFormula = Lookup("Social Contribution".Description WHERE(Code = FIELD("Social Contribution Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; CNSS; Boolean)
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
        field(39001450; "Non inclus en compta"; Boolean)
        {
        }
        field(39001451; "Non Inclus en Prime"; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Employment Contract Code", "Social Contribution Code", "Indemnity Code")
        {
            Clustered = true;
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

