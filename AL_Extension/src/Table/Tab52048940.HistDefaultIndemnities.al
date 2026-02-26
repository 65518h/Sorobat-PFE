Table 52048940 "Hist. Default Indemnities"
{//GL2024  ID dans Nav 2009 : "39001511"
    Caption = 'Default Indemnities';
    DrillDownPageID = "Default IndemnitiesX";
    LookupPageID = "Default IndemnitiesX";

    fields
    {
        field(1; "Employment Contract Code"; Code[10])
        {
            Caption = 'Employment Contract Code';
            Editable = true;
            TableRelation = "Historique contrat de travail";

            trigger OnValidate()
            begin
                Validate("Indemnity Code");
            end;
        }
        field(2; "Indemnity Code"; Code[20])
        {
            Caption = 'Indemnity Code';
            NotBlank = true;
            TableRelation = Indemnity;

            trigger OnLookup()
            begin
                Clear(FormIndemnity);

                EmploymentContract.Get("Employment Contract Code");
                case EmploymentContract."Employee's type" of
                    0:
                        begin
                            Indemnity.SetFilter("Evaluation mode", '0|1|2|3|4|5|6');  //0|3|5|6
                            FormIndemnity.SetTableview(Indemnity);
                            if Indemnity.Find('-') then begin
                                if FormIndemnity.RunModal = Action::LookupOK then begin
                                    FormIndemnity.GetRecord(SelectedInd);
                                    Validate("Indemnity Code", SelectedInd.Code);
                                end;
                            end;
                        end;
                    1:
                        begin
                            Indemnity.SetFilter("Evaluation mode", '0|1|2|3|4|5|6');  //0|1|2|3|5|6
                            FormIndemnity.SetTableview(Indemnity);
                            if Indemnity.Find('-') then begin
                                if FormIndemnity.RunModal = Action::LookupOK then begin
                                    FormIndemnity.GetRecord(SelectedInd);
                                    Validate("Indemnity Code", SelectedInd.Code);
                                end;
                            end;
                        end;
                end;

                //============Spécifique pour UNPA
                if "Indemnity Code" = 'IND.TRAN' then begin
                    Emp.SetRange("No.", "Employment Contract Code");
                    if Emp.Find('-') then begin

                        Collège1.SetRange(Code, Emp.Catégorie);
                        if Collège1.Find('-') then
                            "Default amount" := Collège1."Mnt Ind Transp";
                        Validate("Default amount", Collège1."Mnt Ind Transp");
                    end;
                end
                else
                    if "Indemnity Code" = 'IND.LOG' then begin
                        Emp.SetRange("No.", "Employment Contract Code");
                        if Emp.Find('-') then begin
                            Collège1.SetRange(Code, Emp.Catégorie);
                            if Collège1.Find('-') then
                                "Default amount" := Collège1."Mnt Ind Log";
                            Validate("Default amount", Collège1."Mnt Ind Log");

                        end;
                    end
            end;

            trigger OnValidate()
            begin

                if Indemnity.Get("Indemnity Code") then begin
                    /*IF EmploymentContract.GET ("Employment Contract Code") THEN ;
                 IF ((EmploymentContract."Employee's type" = 0)
                     AND
                     ((Indemnity."Evaluation mode" <> 0)
                      AND
                      (Indemnity."Evaluation mode" <> 3))
                    ) THEN ERROR (errMsg);*/

                    Description := Indemnity.Description;
                    Type := Indemnity.Type;
                    "Evaluation mode" := Indemnity."Evaluation mode";
                    "Default amount" := Indemnity."Default amount";
                    "Minimum value" := Indemnity."Minimum value";
                    Taux := Indemnity.Taux;
                    "Type Indemnité" := Indemnity."Type Indemnité";
                    "Non Inclis en AV NAt" := Indemnity."Non Inclis en AV NAt";
                    "non inclus en compta" := Indemnity."non inclus en compta";
                    "Non Inclus en Prime" := Indemnity."Non Inclus en Prime";
                    "Precision Arrondi Montant" := Indemnity."Precision Arrondi Montant";
                    "Direction Arrondi" := Indemnity."Direction Arrondi";
                    "Non Inclis en Jours Fer" := Indemnity."Non Inclue en jours férier";
                    "Inclus dans base assurance" := Indemnity."Inclus dans base assurance";
                    "Non Inclue en jours congé" := Indemnity."Non Inclue en jours congé";

                end;

                "Soc. Contribution per Ind.".SetRange("Indemnity Code", "Indemnity Code");
                if "Soc. Contribution per Ind.".Find('-') then
                    repeat
                        "Default Soc. Contribution".Reset;
                        "Default Soc. Contribution"."Employment Contract Code" := "Employment Contract Code";
                        "Default Soc. Contribution"."Social Contribution Code" := "Soc. Contribution per Ind."."Social Contribution Code";
                        "Default Soc. Contribution"."Indemnity Code" := "Soc. Contribution per Ind."."Indemnity Code";
                        "Default Soc. Contribution"."Employer's part" := "Soc. Contribution per Ind."."Employer's part";
                        "Default Soc. Contribution"."Employee's part" := "Soc. Contribution per Ind."."Employee's part";
                        "Default Soc. Contribution"."Basis of calculation" := "Soc. Contribution per Ind."."Basis of calculation";
                        "Default Soc. Contribution"."Deductible of taxable basis" := "Soc. Contribution per Ind."."Deductible of taxable basis";
                        "Default Soc. Contribution"."User ID" := UserId;
                        "Default Soc. Contribution"."Last Date Modified" := WorkDate;
                        if not "Default Soc. Contribution".Insert
                          then
                            Error(msg);
                    until "Soc. Contribution per Ind.".Next = 0;

                // DSFT AGA 16/03/2010
                if EmploymentContract.Get("Employment Contract Code") then begin
                    if Regimesofwork.Get(EmploymentContract."Regimes of work") then
                        if "Evaluation mode" = 3 then
                            "Basis amount" := "Default amount" * Regimesofwork."Work Hours per month"
                        else
                            if "Evaluation mode" = 4 then
                                "Basis amount" := "Default amount" * Taux
                            else
                                "Basis amount" := "Default amount"
                end;
                // DSFT AGA 16/03/2010

            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            Editable = true;
            OptionCaption = 'Taxable,Non taxable';
            OptionMembers = Imposable,"Non imposable","Imposable (Non Assujettie Socialement)";
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

            trigger OnValidate()
            begin
                // DSFT AGA 16/03/2010
                if EmploymentContract.Get("Employment Contract Code") then begin
                    if Regimesofwork.Get(EmploymentContract."Regimes of work") then
                        if "Evaluation mode" = 3 then
                            "Basis amount" := "Default amount" * Regimesofwork."Work Hours per month"
                        else
                            "Basis amount" := "Default amount"
                end;
                // DSFT AGA 16/03/2010
            end;
        }
        field(50000; "Minimum value"; Decimal)
        {
            Caption = 'Minimum value';
            DecimalPlaces = 3 : 3;
        }
        field(50010; "Mois d'application"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50050; "Non Inclis en AV NAt"; Boolean)
        {
        }
        field(50051; "Non Inclis en Jours Fer"; Boolean)
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
        field(39001440; Taux; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                // MAJ PAR RAMZI LE 23/02
                //Regimesofwork.RESET;
                //Regimesofwork.FIND('-');
                //  "Default amount"  :=   Taux * Regimesofwork."taux indem panier";
            end;
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
            Caption = 'Montant de base';
        }
        field(39001464; "Non Inclue en jours congé"; Boolean)
        {
        }
        field(39001537; "Code contrat archivé"; Integer)
        {
            TableRelation = "Historique contrat de travail";
        }
    }

    keys
    {
        key(Key1; "Employment Contract Code", "Indemnity Code", "Code contrat archivé")
        {
            Clustered = true;
            SumIndexFields = "Default amount", "Basis amount";
        }
        key(Key2; "Type Indemnité", "Indemnity Code", "Employment Contract Code")
        {
            SumIndexFields = "Basis amount";
        }
        key(Key3; "Employment Contract Code", "Evaluation mode", "Non Inclue en jours congé")
        {
            SumIndexFields = "Basis amount";
        }
        key(Key4; "Code contrat archivé", "Employment Contract Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
        TestField("Employment Contract Code");
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
        if "Type Indemnité" = 0 then
            Error('La !!!!');
    end;

    var
        Indemnity: Record Indemnity;
        SelectedInd: Record Indemnity;
        SocialContribution: Record "Social Contribution";
        "Soc. Contribution per Ind.": Record "Soc. Contribution per Ind.";
        "Default Soc. Contribution": Record "Default Soc. Contribution";
        msg: label 'Social contribution line exiting. Unable to insert the new line.';
        EmploymentContract: Record "Employment Contract";
        errMsg: label 'Mode d''évaluation de l''Indemnité doit être "sur Heures travaillées" ou "Forfaitaire"';
        FormIndemnity: page Indemnity;
        Regimesofwork: Record "Regimes of work";
        "Collège1": Record "CATEGORIES";
        Emp: Record Employee;
        RecGParamResshum: Record "Human Resources Setup";
}

