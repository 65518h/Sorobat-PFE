Table 8004133 "Planning Setup"
{
    // //PLANNING_TASK CW 12/07/09 +"Schedule Horizon"
    //                 OF 25/11/09  Project Exported Description pointe /Job et non plus Sales Header
    // //AFF PLAN PLANNINGFORCE OFE 12/06/09
    // //RESSOURCE GESWAY 06/03/03 Ajout champs "Internal Person Nos.","External Person Nos.","Generic Person Nos."
    //                              "Internal Machine Nos.","Generic Machine Nos.","Structure Nos.","External Machine Nos."
    // //PLANNING CW 23/03/04 Ajout "Planning calendar code"
    //            DL 18/08/04 Ajout champs "Journal Template Name" et "Journal Batch Name"
    //            AC 15/04/09 Add field  8035005

    Caption = 'Planning Setup';
    // LookupPageID = 8004137;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(3; "NonWorking Color"; Integer)
        {
            Caption = 'NonWorking Color';
            InitValue = 255;
        }
        field(4; "Quote Status Color"; Integer)
        {
            Caption = 'Quote Status Color';
            InitValue = 32768;
        }
        field(5; "Order Status Color"; Integer)
        {
            Caption = 'Order Status Color';
            InitValue = 8388608;
        }
        field(8; "Def. Hours per Day"; Decimal)
        {
            Caption = 'Def. Hours per Day';
            DecimalPlaces = 0 : 2;
        }
        field(9; "Planning Status Color"; Integer)
        {
            Caption = 'Planning Status Color';
            InitValue = 8388608;
        }
        field(10; "Project Nos."; Code[10])
        {
            Caption = 'Project Plan Nos.';
            TableRelation = "No. Series";
        }
        field(11; "Task Nos."; Text[10])
        {
            Caption = 'Task Nos.';

            trigger OnValidate()
            var
                i: Integer;
                lOK: Boolean;
            begin
                if ("Task Nos." <> '') then begin
                    for i := 1 to StrLen("Task Nos.") do
                        lOK := lOK or ("Task Nos."[i] in ['0' .. '9']);
                    if not lOK then
                        Error(Text001, FieldCaption("Task Nos."));
                end;
            end;
        }
        field(8004130; PlanningExecFileName; Text[250])
        {
            Caption = 'Application Filename';
        }
        field(8004131; PlanningProjectFileName; Text[250])
        {
            Caption = 'Project FileName';
        }
        field(8004132; PlanningProjectExport; Text[250])
        {
            Caption = 'Export FileName';
        }
        field(8004133; PlanningProjectImport; Text[250])
        {
            Caption = 'Import FileName';
        }
        field(8004134; "MS-Project Mapping"; Text[30])
        {
            Caption = 'MS-Project Mapping';
        }
        field(8004135; "Schedule Horizon"; DateFormula)
        {
            Caption = 'Schedule Horizon';
        }
        field(8004136; "Work Type Code Required"; Boolean)
        {
            Caption = 'Work Type Code Required';
        }
        field(8004137; PlanningProjetSchema; Text[250])
        {
            Caption = 'XML path schema';
        }
        field(8004138; "Planning Entry"; Integer)
        {
            Caption = 'Planning entry';
        }
        field(8004139; "Planning Change Notify"; Boolean)
        {
            Caption = 'Planning Change Notify';
        }
        field(8004140; "Gen. Prod. Post Required"; Boolean)
        {
            Caption = 'Gen. Prod. Post Required';
        }
        field(8035005; "Scheduler Template Default"; Code[20])
        {
            Caption = 'Scheduler Template Default';
            TableRelation = "Weekly Schedule Template".Code;
        }
        field(8035006; "Project Exported Description"; Text[50])
        {
            Caption = 'Project Exported Description';

            trigger OnLookup()
            var
                lField: Record "Field";
                //   lBasic: Codeunit Basic;
                ltext: Text[250];
            begin
                //lField.SETRANGE(TableNo,DATABASE::"Sales Header");
                lField.SetRange(TableNo, Database::Job);
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", lField) = Action::LookupOK then begin
                //     ltext := "Project Exported Description" + '%' + Format(lField."No.");
                //     "Project Exported Description" := ltext;
                //     if Modify then;
                // end;
            end;
        }
        field(8035007; "Export Type"; Option)
        {
            Caption = 'Export Type';
            OptionMembers = MSProject,PlanningForce;
        }
    }

    keys
    {
        key(STG_Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label 'The %1 must contain some caracteres between 0 to 9';
}

