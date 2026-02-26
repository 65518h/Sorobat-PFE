Table 52048884 "Default Indemnities"
{//GL2024  ID dans Nav 2009 : "39001406"
    Caption = 'Default Indemnities';
    DrillDownPageID = "Default IndemnitiesX";
    LookupPageID = "Default IndemnitiesX";
    fields
    {
        field(1; "Employment Contract Code"; Code[10])
        {
            Caption = 'Employment Contract Code';
            Editable = true;
            SQLDataType = Integer;
            TableRelation = "Employment Contract";

            trigger OnValidate()
            begin
                VALIDATE("Indemnity Code");
            end;
        }
        field(2; "Indemnity Code"; Code[20])
        {
            Caption = 'Indemnity Code';
            NotBlank = true;
            TableRelation = Indemnity;

            trigger OnLookup()
            begin
                CLEAR(FormIndemnity);

                EmploymentContract.GET("Employment Contract Code");
                CASE EmploymentContract."Employee's type" OF
                    0:
                        BEGIN
                            // Indemnity.SETFILTER ("Evaluation mode",'0|1|2|3|4|5|6');  //0|3|5|6
                            FormIndemnity.SETTABLEVIEW(Indemnity);
                            IF Indemnity.FIND('-') THEN BEGIN
                                IF FormIndemnity.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                    FormIndemnity.GETRECORD(SelectedInd);
                                    VALIDATE("Indemnity Code", SelectedInd.Code);
                                END;
                            END;
                        END;
                    1:
                        BEGIN
                            //Indemnity.SETFILTER ("Evaluation mode",'0|1|2|3|4|5|6');  //0|1|2|3|5|6
                            FormIndemnity.SETTABLEVIEW(Indemnity);
                            IF Indemnity.FIND('-') THEN BEGIN
                                IF FormIndemnity.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                    FormIndemnity.GETRECORD(SelectedInd);
                                    VALIDATE("Indemnity Code", SelectedInd.Code);
                                END;
                            END;
                        END;
                END;

                //============Spécifique pour UNPA
                IF "Indemnity Code" = 'IND.TRAN' THEN BEGIN
                    Emp.SETRANGE("No.", "Employment Contract Code");
                    IF Emp.FIND('-') THEN BEGIN

                        Collège1.SETRANGE(Code, Emp.Catégorie);
                        IF Collège1.FIND('-') THEN
                            "Default amount" := Collège1."Mnt Ind Transp";
                        VALIDATE("Default amount", Collège1."Mnt Ind Transp");
                    END;
                END
                ELSE
                    IF "Indemnity Code" = 'IND.LOG' THEN BEGIN
                        Emp.SETRANGE("No.", "Employment Contract Code");
                        IF Emp.FIND('-') THEN BEGIN
                            Collège1.SETRANGE(Code, Emp.Catégorie);
                            IF Collège1.FIND('-') THEN
                                "Default amount" := Collège1."Mnt Ind Log";
                            VALIDATE("Default amount", Collège1."Mnt Ind Log");

                        END;
                    END
            end;

            trigger OnValidate()
            begin

                IF Indemnity.GET("Indemnity Code") THEN BEGIN

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
                    "Indemnité conventionnelle" := Indemnity."Indemnité conventionnelle";
                    "base deduction indemnité/jours" := Indemnity."base deduction indemnité/jours";
                    "base deduction indemnité/heure" := Indemnity."base deduction indemnité/heure";
                    "Avantage en nature" := Indemnity."Avantage en nature";
                    "% salaire de base" := Indemnity."% salaire de base";
                    "Taux % salaire de base" := Indemnity."Taux % salaire de base";
                    "Nombre de jours" := Indemnity."Nombre de jours";
                    "Compte indemnité" := Indemnity."Compte indemnité";
                    "Compte contre partie indemnité" := Indemnity."Compte contre partie indemnité";
                    "Non déductible accident de Tra" := Indemnity."Non déductible accident de Tra";
                    Abattement := Indemnity.Abattement;
                    "Non Inclus en Calcul CNSS" := Indemnity."Non Inclus en Calcul CNSS";
                    "% Abattement" := 0;
                    "Type STC" := Indemnity."Type STC";

                    "Inclu Calcul Brut STC" := Indemnity."Inclu Calcul Brut STC";
                    IF Abattement THEN BEGIN
                        IF Emp.GET("Employment Contract Code") THEN;
                        LineGrid.SETRANGE(Catégorie, Emp.Catégorie);
                        LineGrid.SETRANGE(LineGrid.Echelons, Emp.Echelons);
                        IF LineGrid.FINDFIRST THEN "% Abattement" := LineGrid."Bareme Abattement";
                    END;
                    Exonération := Indemnity.Exonération;
                    "% Exonération" := Indemnity."% Exonération";
                    "Plafond Exonération" := Indemnity."Plafond Exonération";
                END;


                "Soc. Contribution per Ind.".SETRANGE("Indemnity Code", "Indemnity Code");
                IF "Soc. Contribution per Ind.".FIND('-') THEN
                    REPEAT
                        "Default Soc. Contribution".RESET;
                        "Default Soc. Contribution"."Employment Contract Code" := "Employment Contract Code";
                        "Default Soc. Contribution"."Social Contribution Code" := "Soc. Contribution per Ind."."Social Contribution Code";
                        "Default Soc. Contribution"."Indemnity Code" := "Soc. Contribution per Ind."."Indemnity Code";
                        "Default Soc. Contribution"."Employer's part" := "Soc. Contribution per Ind."."Employer's part";
                        "Default Soc. Contribution"."Employee's part" := "Soc. Contribution per Ind."."Employee's part";
                        "Default Soc. Contribution"."Basis of calculation" := "Soc. Contribution per Ind."."Basis of calculation";
                        "Default Soc. Contribution"."Deductible of taxable basis" := "Soc. Contribution per Ind."."Deductible of taxable basis";
                        "Default Soc. Contribution"."User ID" := USERID;
                        "Default Soc. Contribution"."Last Date Modified" := WORKDATE;
                        IF NOT "Default Soc. Contribution".INSERT
                          THEN
                            ERROR(msg);
                    UNTIL "Soc. Contribution per Ind.".NEXT = 0;
                IF "% salaire de base" THEN
                    IF Emp.GET("Employment Contract Code") THEN BEGIN
                        IF EmploymentContract.GET("Employment Contract Code") THEN BEGIN
                            IF Regimesofwork.GET(EmploymentContract."Regimes of work") THEN
                                IF Emp."Employee's type" = 0 THEN
                                    "Default amount" := Emp."Basis salary" * "Taux % salaire de base"
                                ELSE
                                    "Default amount" := (Emp."Basis salary" / Regimesofwork."Work Hours per month") * "Taux % salaire de base";
                        END;
                    END;
                // DSFT AGA 16/03/2010
                IF EmploymentContract.GET("Employment Contract Code") THEN BEGIN
                    IF Regimesofwork.GET(EmploymentContract."Regimes of work") THEN
                        IF "Evaluation mode" = 3 THEN
                            "Basis amount" := "Default amount" * Regimesofwork."Work Hours per month"
                        ELSE
                            IF "Evaluation mode" = 4 THEN
                                "Basis amount" := "Default amount" * Taux

                            ELSE
                                IF "Evaluation mode" = 5 THEN
                                    "Basis amount" := "Default amount" * Regimesofwork."Worked Day Per Month"
                                ELSE
                                    "Basis amount" := "Default amount"
                END;
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
            OptionCaption = 'Imposable,Non imposable,Imposable (Non Assujettie Socialement)';
            OptionMembers = Imposable,"Non imposable","Imposable (Non Assujettie Socialement)";
        }
        field(5; "Evaluation mode"; Option)
        {
            Caption = 'Evaluation mode';
            Editable = true;
            OptionCaption = 'Forfaitaire,sur Période payée,sur Période ouvrée,sur Heures travaillées,Nombre X Montant par défaut,Nbre Jours Travaillées,Montant = Brut * taux,Montant = Base * Montant,3*Smig Hor. Base,STC,Base*Nbr Jour';
            OptionMembers = Forfaitaire,"sur Période payée","sur Période ouvrée","sur Heures travaillées","Nombre X Montant par défaut","Nbre Jours Travaillées","Montant = Brut * taux","Montant = Base * Montant","3*Smig Hor. Base",STC,"Base*Nbr Jour";
        }
        field(10; "Default amount"; Decimal)
        {
            Caption = 'Default amount';
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                // DSFT AGA 16/03/2010
                IF EmploymentContract.GET("Employment Contract Code") THEN BEGIN
                    IF Regimesofwork.GET(EmploymentContract."Regimes of work") THEN
                        IF "Evaluation mode" = 3 THEN
                            "Basis amount" := "Default amount" * Regimesofwork."Work Hours per month"
                        ELSE
                            IF "Evaluation mode" = 4 THEN
                                "Basis amount" := "Default amount" * Taux

                            ELSE
                                IF "Evaluation mode" = 5 THEN
                                    "Basis amount" := "Default amount" * Regimesofwork."Worked Day Per Month"
                                ELSE
                                    "Basis amount" := "Default amount"
                END;
                // DSFT AGA 16/03/2010
            end;
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
        field(50010; "Mois d'application"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50011; "Non Inclus en Calcul CNSS"; Boolean)
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
        field(50016; "Ancien Sursalaire"; Decimal)
        {
        }
        field(50050; "Non Inclis en AV NAt"; Boolean)
        {
        }
        field(50051; "Non Inclis en Jours Fer"; Boolean)
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
                // DSFT AGA 16/03/2010
                IF EmploymentContract.GET("Employment Contract Code") THEN BEGIN
                    IF Regimesofwork.GET(EmploymentContract."Regimes of work") THEN
                        IF "Evaluation mode" = 4 THEN
                            "Basis amount" := "Default amount" * Taux
                        ELSE
                            "Basis amount" := "Default amount"
                END;
                // DSFT AGA 16/03/2010
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
        key(Key1; "Employment Contract Code", "Indemnity Code", "Non Inclus en Prime")
        {
            Clustered = true;
            SumIndexFields = "Default amount", "Basis amount";
        }
        key(Key2; "Type Indemnité", "Indemnity Code", "Employment Contract Code")
        {
            SumIndexFields = "Basis amount";
        }
        key(Key3; "Employment Contract Code", "Evaluation mode", "Non Inclue en jours congé", Type, "Indemnité conventionnelle")
        {
            SumIndexFields = "Basis amount";
        }
        key(Key4; "Indemnity Code", "Employment Contract Code", "Type Indemnité")
        {
            SumIndexFields = "Basis amount";
        }
        key(Key5; "Employment Contract Code", Type)
        {
            SumIndexFields = "Default amount", "Basis amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
        TESTFIELD("Employment Contract Code");
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
        //IF "Type Indemnité"=0 THEN
        //   ERROR('La !!!!');
    end;

    var
        Indemnity: Record Indemnity;
        SelectedInd: Record Indemnity;
        SocialContribution: Record "Social Contribution";
        "Soc. Contribution per Ind.": Record "Soc. Contribution per Ind.";
        "Default Soc. Contribution": Record "Default Soc. Contribution";
        msg: Label 'Social contribution line exiting. Unable to insert the new line.';
        EmploymentContract: Record 5211;
        errMsg: Label 'Mode d''évaluation de l''Indemnité doit être "sur Heures travaillées" ou "Forfaitaire"';
        FormIndemnity: page Indemnity;
        Regimesofwork: Record "Regimes of work";
        "Collège1": Record CATEGORIES;
        Emp: Record 5200;
        RecGParamResshum: Record 5218;
        LineGrid: Record "Line grid";
}

