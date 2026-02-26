Table 8001526 "Statistic Scheduler line"
{
    //GL2024  ID dans Nav 2009 : "8001320"
    // //STATSEXPLORER STATSEXPLORER 01/10/10 Statistic Scheduler line

    Caption = 'Statistic Scheduler line';

    fields
    {
        field(1; "Code treatment"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = "Statistic Scheduler header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Statistic code"; Code[10])
        {
            Caption = 'Statistic code';
            TableRelation = "Standard statistic".Code;

            trigger OnValidate()
            begin
                CalcFields(Name);
                "Detail level" := 1;
                "Print total" := true;
                ExcelFile;
            end;
        }
        field(5; Name; Text[80])
        {
            CalcFormula = lookup("Standard statistic".Name where(Code = field("Statistic code")));
            Caption = 'Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Process from date"; DateFormula)
        {
            Caption = 'Process from date';
        }
        field(16; "Process to date"; DateFormula)
        {
            Caption = 'Process to date';
        }
        field(18; "Type of Treatment"; Option)
        {
            Caption = 'Type of Treatment';
            OptionCaption = 'Calculate,Print,Save as HTML,Send Excel';
            OptionMembers = Calculer,Imprimer,"Fichier HTML","Envoi dans Excel";

            trigger OnValidate()
            begin
                ExcelFile;
            end;
        }
        field(20; "Detail level"; Integer)
        {
            Caption = 'Detail level';
            NotBlank = true;

            trigger OnLookup()
            begin
                CreerDefinition;
                Commit;
                DefinitionTemp.FilterGroup(7);
                DefinitionTemp.SetRange("User ID", '##' + CopyStr(UserId, 1, 16) + '##');
                DefinitionTemp.SetFilter("Line No.", '<=%1', 10);
                DefinitionTemp.FilterGroup(0);
                //DYS page Addon non migrer
                // if PAGE.RunModal(page::"Statistic definition", DefinitionTemp) = Action::LookupOK then begin
                //     "Detail level" := DefinitionTemp."Line No.";
                // end;
                DefinitionTemp.SetRange("User ID", '##' + CopyStr(UserId, 1, 16) + '##');
                if not DefinitionTemp.IsEmpty then
                    DefinitionTemp.DeleteAll;
                DefinitionTemp.Reset;
            end;
        }
        field(21; "Print definition"; Boolean)
        {
            Caption = 'Print definition';
        }
        field(22; "Print total"; Boolean)
        {
            Caption = 'Print total';
        }
        field(50; "File Name"; Text[250])
        {
            Caption = 'File Name';
        }
        field(51; "Excel sheet"; Text[30])
        {
            Caption = 'Excel sheet';
        }
        field(52; "Save Excel file"; Boolean)
        {
            Caption = 'Save Excel File';
        }
        field(53; "Close Excel file"; Boolean)
        {
            Caption = 'Close Excel File';
        }
        field(60; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = "User Setup";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                // LoginMgt.LookupUserID("User ID");
                Validate("User ID");
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //  LoginMgt.ValidateUserID("User ID");
            end;
        }
        field(61; "Archive Excel File"; Boolean)
        {
            Caption = 'Archive Excel File';
            Description = '#8489';
        }
        field(62; "Path Archive Excel File"; Text[250])
        {
            Caption = 'Path Archive Excel File';
            Description = '#8489';
        }
    }

    keys
    {
        key(Key1; "Code treatment", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        UserAutomate.SetRange("Sheduler code", "Code treatment");
        UserAutomate.SetRange("Statistic code", "Statistic code");
        if not UserAutomate.IsEmpty then
            UserAutomate.DeleteAll;
    end;

    var
        DefinitionTemp: Record "Statistic definition";
        StatistiquePredefinie: Record "Standard statistic";
        UserAutomate: Record "Statistic User";
        TexteDesignation: Text[250];


    procedure CreerDefinition()
    begin
        StatistiquePredefinie.Get("Statistic code");
        StatistiquePredefinie.Get("Statistic code");
        DefinitionTemp.SetRange("User ID", '##' + CopyStr(UserId, 1, 16) + '##');
        if not DefinitionTemp.IsEmpty then
            DefinitionTemp.DeleteAll;
        DefinitionTemp.Reset;
        with StatistiquePredefinie do begin
            if "1st sort level" <> '' then
                CreerLigneDefinition("1st sort level", 1);
            if "2nd sort level" <> '' then
                CreerLigneDefinition("2nd sort level", 2);
            if "3rd sort level" <> '' then
                CreerLigneDefinition("3rd sort level", 3);
            if "4th sort level" <> '' then
                CreerLigneDefinition("4th sort level", 4);
            if "5th sort level" <> '' then
                CreerLigneDefinition("5th sort level", 5);
            if "6th sort level" <> '' then
                CreerLigneDefinition("6th sort level", 6);
            if "7th sort level" <> '' then
                CreerLigneDefinition("7th sort level", 7);
            if "8th sort level" <> '' then
                CreerLigneDefinition("8th sort level", 8);
            if "9th sort level" <> '' then
                CreerLigneDefinition("9th sort level", 9);
            if "10th sort level" <> '' then
                CreerLigneDefinition("10th sort level", 1);
        end;
    end;


    procedure CreerLigneDefinition(TexteTri: Text[30]; NumeroLigne: Integer)
    begin
        with DefinitionTemp do begin
            if NumeroLigne = 1 then
                TexteDesignation := TexteTri
            else
                TexteDesignation := CopyStr(TexteDesignation + ', ' + TexteTri, 1, 250);
            Init;
            "User ID" := '##' + CopyStr(UserId, 1, 16) + '##';
            "Line No." := NumeroLigne;
            Description := TexteDesignation;
            Insert;
        end;
    end;


    procedure ExcelFile()
    begin
        if ("Type of Treatment" = "type of treatment"::"Envoi dans Excel") and ("File Name" = '') then begin
            StatistiquePredefinie.Get("Statistic code");
            "File Name" := StatistiquePredefinie."Excel model name";
            "Excel sheet" := StatistiquePredefinie."Excel sheet";
        end;
    end;
}

