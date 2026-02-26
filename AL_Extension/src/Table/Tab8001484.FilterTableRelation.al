Table 8001484 "Filter Table Relation"
{
    // #8675 CW 27/12/10
    // //+BGW+FILTER CW 27/12/10

    Caption = 'Filter Table Relation';

    fields
    {
        field(1; TableNo; Integer)
        {
            Caption = 'TableNo';
            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(2; "Source Type FieldNo"; Integer)
        {
            //blankzero = true;
            Caption = 'Source Type FieldNo';
            TableRelation = Field."No." where(TableNo = field(TableNo));

            trigger OnLookup()
            var
                lField: Record "Field";
            begin
                lField.SetRange(TableNo, TableNo);
                lField."No." := "Source Type FieldNo";
                if lField.Find('=') then;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Filter Field List", lField) = Action::LookupOK then
                //     "Source Type FieldNo" := lField."No.";
                CalcFields("Source No. Field Caption");
            end;

            trigger OnValidate()
            begin
                CalcFields("Source Type Field Caption");
            end;
        }
        field(3; "Source No. FieldNo"; Integer)
        {
            //blankzero = true;
            Caption = 'Source No. FieldNo';
            TableRelation = Field."No." where(TableNo = field(TableNo));

            trigger OnLookup()
            var
                lField: Record "Field";
            begin
                lField.SetRange(TableNo, TableNo);
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Filter Field List", lField) = Action::LookupOK then
                //     "Source No. FieldNo" := lField."No.";
                CalcFields("Source No. Field Caption");
            end;

            trigger OnValidate()
            begin
                CalcFields("Source No. Field Caption");
            end;
        }
        field(4; "Source Description FieldNo"; Integer)
        {
            //blankzero = true;
            Caption = 'Source Description FieldNo';
            TableRelation = Field."No." where(TableNo = field(TableNo));

            trigger OnLookup()
            var
                lField: Record "Field";
            begin
                lField.SetRange(TableNo, TableNo);
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Filter Field List", lField) = Action::LookupOK then
                //     "Source Description FieldNo" := lField."No.";
                CalcFields("Description Field Caption");
            end;

            trigger OnValidate()
            begin
                CalcFields("Description Field Caption");
            end;
        }
        field(101; "Table Caption"; Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Table),
                                                                           "Object ID" = field(TableNo)));
            Caption = 'Table Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "Source Type Field Caption"; Text[250])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field(TableNo),
                                                              "No." = field("Source Type FieldNo")));
            Caption = 'Source Type Field Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(103; "Source No. Field Caption"; Text[250])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field(TableNo),
                                                              "No." = field("Source No. FieldNo")));
            Caption = 'No. Field Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(104; "Description Field Caption"; Text[250])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field(TableNo),
                                                              "No." = field("Source Description FieldNo")));
            Caption = 'Description Field Caption';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; TableNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        gTableRelation: Record "Filter Table Relation";


    procedure SourceType(var pRecordRef: RecordRef): Integer
    var
        lFieldRef: FieldRef;
    begin
        if pRecordRef.Number <> gTableRelation.TableNo then
            //  IF NOT gTableRelation.GET(pRecordRef.NUMBER) THEN
            //    EXIT(0);
            gTableRelation.Get(pRecordRef.Number);
        if gTableRelation."Source Type FieldNo" = 0 then
            exit(0)
        else begin
            lFieldRef := pRecordRef.FieldIndex(gTableRelation."Source Type FieldNo");
            exit(lFieldRef.Value);
        end;
    end;


    procedure SourceNo(var pRecordRef: RecordRef): Code[20]
    var
        lFieldRef: FieldRef;
    begin
        if pRecordRef.Number <> gTableRelation.TableNo then
            //  IF NOT gTableRelation.GET(pRecordRef.NUMBER) THEN
            //    EXIT('');
            gTableRelation.Get(pRecordRef.Number);
        if gTableRelation."Source No. FieldNo" = 0 then
            exit('')
        else begin
            lFieldRef := pRecordRef.Field(gTableRelation."Source No. FieldNo");
            exit(lFieldRef.Value);
        end;
    end;


    procedure SourceDescription(var pRecordRef: RecordRef): Text[50]
    var
        lFieldRef: FieldRef;
    begin
        if pRecordRef.Number <> gTableRelation.TableNo then
            //  IF NOT gTableRelation.GET(pRecordRef.NUMBER) THEN
            //    EXIT('');
            gTableRelation.Get(pRecordRef.Number);
        if gTableRelation."Source Description FieldNo" = 0 then
            exit('')
        else begin
            lFieldRef := pRecordRef.Field(gTableRelation."Source Description FieldNo");
            exit(lFieldRef.Value);
        end;
    end;
}

