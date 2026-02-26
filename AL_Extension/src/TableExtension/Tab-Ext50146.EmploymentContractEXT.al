TableExtension 50146 "Employment ContractEXT" extends "Employment Contract"
{
    fields
    {



        field(50000; "Employee's type Contrat"; Option)
        {
            Description = 'Ramzi : Spéciallement pour Altek';
            OptionCaption = ' ,CDD,CDI,SIVP I 1iere Année,SIVP I 2ieme Année,SIVP II,Stagiaire,Particulier';
            OptionMembers = ,CDD,CDI,"SIVP I 1iere Année","SIVP I 2ieme Année","SIVP II",Stagiaire,Particulier;

            trigger OnValidate()
            begin
                if (("Employee's type Contrat" <> "employee's type contrat"::CDD)
                       and ("Employee's type Contrat" <> "employee's type contrat"::CDI)) then
                    Taxable := false
                else
                    Taxable := true
            end;
        }
        field(50001; "Cotisable Sans Imposable"; Boolean)
        {
            Description = 'HJ SORO 11-01-2018';
        }
        field(8099000; "Regular payments"; Integer)
        {
            Caption = 'Regular payments';
        }
        field(8099001; "Temporary payments"; Integer)
        {
            Caption = 'Temporary payments';
        }
        field(8099005; "Adjust indemnity amount"; Boolean)
        {
            Caption = 'Adjust indemnity amount';
        }
        field(8099010; "Employee's type"; Option)
        {
            Caption = 'Employee''s type';
            OptionCaption = 'Base Horaire,Base Mensuelle';
            OptionMembers = "Hour based","Month based";
        }
        field(8099020; "Regimes of work"; Code[10])
        {
            Caption = 'Regime of work';
            TableRelation = "Regimes of work".Code;

            trigger OnValidate()
            begin
                Clear(Regim);
                if Regim.Get("Regimes of work") then;
                "Type Calendar" := Regim."Type Calendar";
            end;
        }
        field(8099030; "Salary grid"; Code[10])
        {
            Caption = 'Salary grid';
            TableRelation = "Salary grid header".Code;
        }
        field(8099100; Taxable; Boolean)
        {
            Caption = 'Taxable';
        }
        field(8099101; "Take in account deductions"; Boolean)
        {
            Caption = 'Take in account deductions';
        }
        field(8099110; "Calculation mode of the taxes"; Option)
        {
            Caption = 'Calculation mode of the taxes';
            OptionCaption = 'Standard Mode,Inclusive Mode';
            OptionMembers = "Barème standard",Forfaitaire;
        }
        field(8099111; "Inclusive ratio"; Decimal)
        {
            Caption = 'Inclusive ratio';
        }
        field(8099150; "Default Employment Contract"; Boolean)
        {
            Caption = 'Default Employment Contract';
        }
        field(8099190; "No. Series"; Code[10])
        {
            //GL2024   TableRelation = Table0;
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

            trigger OnValidate()
            begin
                Clear("Regimes of work");
            end;
        }
        field(39001441; "Code Calendar"; Code[20])
        {
            TableRelation = if ("Type Calendar" = filter(Roulement)) "Caledar Roulement"."Code calend Roulement"
            else
            if ("Type Calendar" = filter(Administratif)) "Base Calendar".Code
            else
            if ("Type Calendar" = filter(Chantier)) "Base Calendar".Code;
        }
        field(39001450; "Appliquer Heure Supp"; Boolean)
        {
            Caption = 'Appliquer Heure Supp';
        }
        field(39001451; "Type Assiduité"; Option)
        {
            OptionMembers = "Par Heure","Par Jour";
        }
        field(39001452; "Slice of imposition"; Code[4])
        {
            Caption = 'Tranche d''imposition';
            TableRelation = "Slices of imposition".Code;
        }
        field(39001453; "Régime gardien/Chauffeur"; Boolean)
        {
        }
    }
    keys
    {
        key(Key2; "Employee's type Contrat")
        {
        }
        /*    key(Key3; "Salary grid", Code)
            {
            }*/
    }

    trigger OnInsert()
    BEGIN
        IF Code = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Employee Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Employment Contract Nos.", xRec."No. Series", 0D, Code, "No. Series");
        END;

        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    END;

    trigger OnModify()
    BEGIN
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    END;

    trigger OnRename()
    BEGIN
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    END;


    procedure AssistEdit(OldEmploymentContract: Record "Employment Contract"): Boolean
    begin
        with EmploymentContract do begin
            EmploymentContract := Rec;
            HumanResSetup.Get;
            HumanResSetup.TestField("Employee Nos.");
            if NoSeriesMgt.SelectSeries(HumanResSetup."Employment Contract Nos.", OldEmploymentContract."No. Series", "No. Series") then begin
                HumanResSetup.Get;
                HumanResSetup.TestField("Employment Contract Nos.");
                NoSeriesMgt.SetSeries(Code);
                Rec := EmploymentContract;
                exit(true);
            end;
        end;
    end;

    var
        SaveContrat: Record "Employment Contract";
        Contrat: Record "Employment Contract";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmploymentContract: Record "Employment Contract";
        Regim: record "Regimes of work";
}

