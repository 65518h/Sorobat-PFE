Table 52048894 "Salary grid header"
{//GL2024  ID dans Nav 2009 : "39001420"
    Caption = 'Salary grid header';
    DrillDownPageID = "Salary grid List";
    LookupPageID = "Salary grid List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(10; "Date Debut"; Date)
        {
            Caption = 'Date Debut';
        }
        field(11; "Date Fin"; Date)
        {
        }
        field(100; "No. Series"; Code[10])
        {
        }
        field(120; "Filter Collège"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = CATEGORIES;
        }
        field(121; "Filter Grade"; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(122; "Filter Echelle"; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(123; "Filter Classe"; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = " ",A,B,C;
        }
        field(50000; Catégorie; code[20])
        {
            TableRelation = CATEGORIES;
            NotBlank = true;
            Editable = true;
            caption = 'Catégorie';
        }
        field(50210; "Av. auto. Classe"; Boolean)
        {
        }
        field(50211; "Av. auto. Echelon"; Boolean)
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
        field(8099200; "expiry date"; Date)
        {
            Caption = 'expiry date';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Date Debut", "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //GL3900 
        /*   SalaryGridLines.SetRange(Code, Code);
           if SalaryGridLines.Find('-') then
               SalaryGridLines.DeleteAll;*/ //GL3900 
    end;

    trigger OnInsert()
    begin
        if Code = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Salary grid Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Salary grid Nos.", xRec."No. Series", 0D, Code, "No. Series");
        end;
        "Date Debut" := WorkDate;
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit 396;
        EmployeeResUpdate: Codeunit "Employee/Resource Update";
        EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
        DimMgt: Codeunit DimensionManagement;
        SalaryGridHeader: Record "Salary grid header";
    //GL3900  SalaryGridLines: Record "Salary grid lines";


    procedure AssistEdit(OldSalaryGridHeader: Record "Salary grid header"): Boolean
    begin
        with SalaryGridHeader do begin
            SalaryGridHeader := Rec;
            HumanResSetup.Get;
            HumanResSetup.TestField("Salary grid Nos.");
            if NoSeriesMgt.SelectSeries(HumanResSetup."Salary grid Nos.", OldSalaryGridHeader."No. Series", "No. Series") then begin
                HumanResSetup.Get;
                HumanResSetup.TestField("Salary grid Nos.");
                NoSeriesMgt.SetSeries(Code);
                Rec := SalaryGridHeader;
                exit(true);
            end;
        end;
    end;
}

