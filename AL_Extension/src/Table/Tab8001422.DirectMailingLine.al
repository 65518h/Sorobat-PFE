Table 8001422 "Direct Mailing Line"
{
    // #5306 CLA 03/12/07 Taille des textes passée à 50 car.
    // //PUBLIPOSTAGE GESWAY 18/12/03 Nouvelle table ligne Publipostage
    //                AC     06/01/05 Ajout de la table des Ecritures Caution et des comptes bancaires dans InitTableList;
    // //ACHAT_SUIVI GD 25/04/069 Ajout des tables 23,38 dans InitTableList()
    // //PV ML 19/10/06 Ajout de la table 8003981 Invoice Scheduler dans InitTableList()   #3702

    Caption = 'Direct Mailing Line';

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Table No."; Integer)
        {
            Caption = 'Table No.';

            trigger OnLookup()
            begin
                InitTableList;
                if PAGE.RunModal(page::Objects, Table) = Action::LookupOK then begin
                    Validate("Table No.", Table."Object ID");
                end;
            end;

            trigger OnValidate()
            begin
                InitTableList;
                if not isTableInFilter("Table No.") then
                    Error(Text001);
                //GL2024 License Table.CalcFields(Caption);
                //GL2024 License  "Table Caption" := Table.Caption;
                "Table Name" := Table."Object name";
            end;
        }
        field(4; "Table Caption"; Text[50])
        {
            Caption = 'Table Caption';
            Editable = false;
        }
        field(5; "Table Name"; Text[50])
        {
            Caption = 'Table Name';
            Editable = false;
        }
        field(6; "Field No."; Integer)
        {
            Caption = 'Field No.';

            trigger OnLookup()
            begin
                TestField("Table No.");
                InitFieldList;
                //DYS page Addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Field No.", FieldTable."No.");
            end;

            trigger OnValidate()
            begin
                TestField("Table No.");
                Validate("Table No.");
                InitFieldList;
                if "Field No." > 0 then begin
                    if not FieldTable.Get("Table No.", "Field No.") then
                        Error(Text001);
                    "Field Caption" := FieldTable."Field Caption";
                    "Field Name" := FieldTable.FieldName;
                end else begin
                    "Field Caption" := '';
                    "Field Name" := '';
                end;
            end;
        }
        field(7; "Field Caption"; Text[50])
        {
            Caption = 'Field Caption';
            Editable = false;
        }
        field(8; "Field Name"; Text[50])
        {
            Caption = 'Field Name';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code", "Table No.", "Field No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        isFieldAlreadySelected;

        DirectMailingLine.Reset;
        DirectMailingLine.SetRange(Code, Code);
        if DirectMailingLine.Find('+') then
            "Line No." := DirectMailingLine."Line No." + 10000
        else
            "Line No." := 10000;
    end;

    trigger OnModify()
    begin
        isFieldAlreadySelected;
    end;

    var
        //GL2024 License    "Table": Record "Object";
        //GL2024 License
        "Table": Record AllObj;
        //GL2024 License
        FieldTable: Record "Field";
        TableFilter: Text[250];
        Text001: label 'You have entered an illegal value.';
        DirectMailingLine: Record "Direct Mailing Line";
        Text002: label 'Field has already been selected.';


    procedure InitTableList()
    begin
        TableFilter := '3|4|10|13|18|36|79|8004160|289|5050|5714';
        //CAUTION
        TableFilter := TableFilter + '|8003993';
        //CAUTION//
        //PV
        TableFilter := TableFilter + '|8003981';
        //PV//
        //ACHAT_SUIVI
        TableFilter := TableFilter + '|23|38';
        //ACHAT_SUIVI//
        Table.SetRange("Object Type", Table."Object Type"::Table);
        Table.SetFilter("Object ID", TableFilter);
        Table.Find('-');
    end;


    procedure InitFieldList()
    var
        lFilter: Text[250];
    begin
        FieldTable.Reset;
        FieldTable.SetRange(TableNo, "Table No.");
    end;


    procedure isTableInFilter(pTableNo: Integer): Boolean
    begin
        if Table.Find('-') then
            repeat
                if Table."Object ID" = pTableNo then
                    exit(true);
            until Table.Next = 0;
        exit(false);
    end;


    procedure isFieldAlreadySelected()
    begin
        TestField("Field No.");
        DirectMailingLine.SetRange(Code, Code);
        DirectMailingLine.SetRange("Table No.", "Table No.");
        DirectMailingLine.SetRange("Field No.", "Field No.");
        if DirectMailingLine.Find('-') then
            Error(Text002);
    end;
}

