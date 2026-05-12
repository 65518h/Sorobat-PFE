Table 8001419 "Import Column"
{
    // //+REF+IMPORT CW 21/07/03 Import

    Caption = 'Import Column';

    fields
    {
        field(1; "Import Code"; Code[20])
        {
            Caption = 'Import Code';
            TableRelation = Import;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; TableNo; Integer)
        {
            Caption = 'TableNo';
            //GL2024 License  TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
            trigger OnLookup()
            var
                //GL2024 License      lObject: Record "Object";
                //GL2024 License
                Object: Record AllObj;
            //GL2024 License
            begin
            end;

            trigger OnValidate()
            var
                Objtransl: Record "Object Translation";
            begin
            end;
        }
        field(4; FieldNo; Integer)
        {
            //blankzero = true;
            Caption = 'FieldNo';
            TableRelation = Field."No." where(TableNo = field(TableNo));

            trigger OnLookup()
            var
                FieldLoc: Record "Field";
            begin
                FieldLoc.SetRange(TableNo, TableNo);
                //DYS page Addon non migrer
                // if Action::LookupOK = PAGE.RunModal(page::"Field List BGW", FieldLoc) then
                //     FieldNo := FieldLoc."No.";
                CalcFields("Field Caption", "Field Type Name");
            end;

            trigger OnValidate()
            begin
                CalcFields("Field Caption", "Field Type Name");
            end;
        }
        field(5; "Column No."; Integer)
        {
            //blankzero = true;
            Caption = 'N° colonne';
        }
        field(6; "Start Position"; Integer)
        {
            //blankzero = true;
            Caption = 'Start Position';

            trigger OnValidate()
            begin
                Validate(Length);
            end;
        }
        field(7; "End Position"; Integer)
        {
            //blankzero = true;
            Caption = 'End Position';

            trigger OnValidate()
            begin
                if "End Position" = 0 then
                    Length := 0
                else
                    Length := "End Position" - "Start Position" + 1;
            end;
        }
        field(8; Length; Integer)
        {
            //blankzero = true;
            Caption = 'Field Length';

            trigger OnValidate()
            begin
                "End Position" := "Start Position" + Length - 1;
                if "End Position" < 0 then
                    "End Position" := 0;
            end;
        }
        field(9; Divisor; Decimal)
        {
            //blankzero = true;
            Caption = 'Diviseur';
            DecimalPlaces = 0 : 5;
        }
        field(12; Constant; Text[30])
        {
            Caption = 'Constante';

            trigger OnLookup()
            var
                lTableRelation: Codeunit TableRelation;
                lCode: Code[20];
            begin
                if lTableRelation.LookUp(TableNo, FieldNo, lCode) then
                    Constant := lCode;
            end;
        }
        field(13; "Convertion Table"; Boolean)
        {
            //blankzero = true;
            CalcFormula = exist("Import Correspondence" where("Import Code" = field("Import Code"),
                                                               "Field No." = field(FieldNo)));
            Caption = 'Convertion Table';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Codeunit ID"; Integer)
        {
            //blankzero = true;
            Caption = 'N° codeunit';
        }
        field(15; CallFieldValidate; Boolean)
        {
            Caption = 'CallFieldValidate';
        }
        field(16; Comment; Text[250])
        {
            Caption = 'Commentaire';
        }
        field(17; Title; Text[30])
        {
            Caption = 'Titre';
        }
        field(18; Mandatory; Boolean)
        {
            Caption = 'Obligatoire';
        }
        field(19; "Text Filter"; Text[250])
        {
            Caption = 'Filter';
        }
        field(100; "Field Caption"; Text[80])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field(TableNo),
                                                              "No." = field(FieldNo)));
            Caption = 'Field Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(101; "Field Type Name"; Text[30])
        {
            CalcFormula = lookup(Field."Type Name" where(TableNo = field(TableNo),
                                                          "No." = field(FieldNo)));
            Caption = 'Type';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Import Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lCorres: Record "Import Correspondence";
    begin
        if Import.Get("Import Code") and Import.Protected then
            Import.TestField(Protected, false);
        CalcFields("Convertion Table");
        if "Convertion Table" then
            if Confirm(TextCorres, false, FieldNo) then begin
                lCorres.SetCurrentkey("Import Code");
                lCorres.SetRange("Import Code", "Import Code");
                lCorres.SetRange("Field No.", FieldNo);
                lCorres.DeleteAll(true);
            end;
    end;

    trigger OnInsert()
    begin
        if Import.Get("Import Code") and Import.Protected then
            Import.TestField(Protected, false);
    end;

    trigger OnModify()
    begin
        if Import.Get("Import Code") and Import.Protected then
            Import.TestField(Protected, false);
    end;

    var
        Import: Record Import;
        TextCorres: label 'Correspondences exist for field No. %1. Do you want to delete them ?';
}

