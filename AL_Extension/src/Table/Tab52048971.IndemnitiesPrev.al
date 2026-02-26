table 52048971 "Indemnities Prev"
{ //GL2024  ID dans Nav 2009 : "39001484"
    // {
    // CLEAR (FormIndemnity);
    // SalaryLine.SETRANGE ("No.","No.");
    // SalaryLine.SETRANGE (Employee,"Employee No.");
    // IF SalaryLine.FIND ('-') THEN
    //   BEGIN
    //     EmploymentContract.GET (SalaryLine."Emplymt. Contract Code");
    //     CASE EmploymentContract."Employee's type" OF
    //       0 :
    //       BEGIN
    //         recIndemnity.SETFILTER ("Evaluation mode",'0|3');
    //         FormIndemnity.SETTABLEVIEW (recIndemnity);
    //         IF recIndemnity.FIND ('-') THEN
    //           BEGIN
    //             IF FormIndemnity.RUNMODAL = ACTION::LookupOK THEN
    //               BEGIN
    //                 FormIndemnity.GETRECORD (SelectedInd);
    //                 VALIDATE (Indemnity,SelectedInd.Code);
    //               END;
    //           END;
    //       END;
    //       1 :
    //       BEGIN
    //         recIndemnity.SETFILTER ("Evaluation mode",'0|1|2');
    //         FormIndemnity.SETTABLEVIEW (recIndemnity);
    //         IF recIndemnity.FIND ('-') THEN
    //           BEGIN
    //             IF FormIndemnity.RUNMODAL = ACTION::LookupOK THEN
    //               BEGIN
    //                 FormIndemnity.GETRECORD (SelectedInd);
    //                 VALIDATE (Indemnity,SelectedInd.Code);
    //               END;
    //           END;
    //       END;
    //     END;
    //   END;

    Caption = 'Indemnities';
    // DrillDownPageID = "Indemnités slr Prév";
    //   LookupPageID = "Indemnités slr Prév";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            TableRelation = "Salary Headers";
        }
        field(2; "Employee No."; Code[10])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(3; "Employee Posting Group"; Code[10])
        {
            Caption = 'Employee Posting Group';
            Editable = false;
            TableRelation = "Employee Posting Group";
        }
        field(4; Indemnity; Code[20])
        {
            Caption = 'Indemnity';
            TableRelation = Indemnity;

            trigger OnValidate()
            begin
                Ind.RESET;
                Ind.GET(Indemnity);
                Description := Ind.Description;
                Type := Ind.Type;
                "Evaluation mode" := Ind."Evaluation mode";
                "Base Amount" := Ind."Default amount";
                "Minimum value" := Ind."Minimum value";
            end;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
            OptionCaption = 'Taxable,Non taxable';
            OptionMembers = Imposable,"Non imposable","Imposable (Non Assujettie Socialement)";
        }
        field(7; "Evaluation mode"; Option)
        {
            Caption = 'Evaluation mode';
            OptionCaption = 'Inclusive,on Paid period,on Worked period,on Worked hour,on Flight hours,Nbre Days Worked,Montant = Brut * taux,Montant = Base * Montant,on Worked Day Mission, No worked day mission';
            OptionMembers = Inclusive,"on Paid period","on Worked period","on Worked hour","on Flight hours","Nbre Days Worked","Montant = Brut * taux","Montant = Base * Taux","on Worked Day Mission","No worked day mission";
        }
        field(10; "Base Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Base Amount';

            trigger OnValidate()
            begin
                "Real Amount" := "Base Amount" * Rate / 100;
            end;
        }
        field(11; "Real Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Real Amount';
            Editable = false;
        }
        field(12; Rate; Decimal)
        {
            Caption = 'Ratio';
            DecimalPlaces = 0 : 3;
            Editable = true;
        }
        field(13; "Global Dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Global Dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(211; "Real Amount PR"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Real Amount';
            Editable = false;
        }
        field(50000; "Minimum value"; Decimal)
        {
            Caption = 'Minimum value';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(50001; Nom; Text[60])
        {
        }
        field(50050; "Non Inclis en AV NAt"; Boolean)
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
        }
        field(39001441; "Type Indemnité"; Option)
        {
            OptionMembers = Regular,"Non Regular";
        }
        field(39001450; "inclus en compta"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Employee No.", Indemnity)
        {
            Clustered = true;
            SumIndexFields = "Real Amount";
        }
        key(Key2; "Employee Posting Group", Type, "No.", "Employee No.", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Real Amount";
        }
        key(Key3; Indemnity, "Employee Posting Group", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Real Amount";
        }
        key(Key4; "No.", "Employee No.", Type)
        {
            SumIndexFields = "Real Amount", "Real Amount PR";
        }
        key(Key5; "No.", "Employee No.", Type, "Non Inclis en AV NAt")
        {
            SumIndexFields = "Real Amount", "Real Amount PR";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        SocialContributions.RESET;
        SocialContributions.SETRANGE("No.", "No.");
        SocialContributions.SETRANGE(Employee, "Employee No.");
        SocialContributions.SETRANGE(Indemnity, Indemnity);

        IF SocialContributions.FIND('-') THEN
            SocialContributions.DELETEALL;
    end;

    trigger OnInsert()
    begin
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
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
    end;

    var

    var
        SalaryLine: Record "Salary Lines";
        Employee: Record 5200;
        EmploymentContract: Record 5211;
        DefaultIndemnities: Record "Default Indemnities";
        DefaultSocContribution: Record "Default Soc. Contribution";
        SocialContributions: Record "Social Contributions";
        SocialContribution: Record "Social Contribution";
        FormIndemnity: Page Indemnity;
        recIndemnity: Record Indemnity;
        SelectedInd: Record Indemnity;
        Ind: Record Indemnity;
}

