Table 8001480 "Filter Header"
{
    // //+BGW+FILTER CW 11/07/09

    Caption = 'Filter';
    DataCaptionFields = "Table Caption", "Code", Description;
    //DrillDownPageID = 8001482;
    //LookupPageID = 8001482;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License

            trigger OnLookup()
            var
                //GL2024 License  lObject: Record "Object";
                //GL2024 License
                lObject: Record AllObj;
            //GL2024 License
            begin
                lObject.SetRange("Object Type", lObject."Object Type"::Table);
                if PAGE.RunModal(page::Objects, lObject) = Action::LookupOK then
                    "Table ID" := lObject."Object ID";
            end;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(107; "Table Caption"; Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Table),
                                                                           "Object ID" = field("Table ID")));
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lLine: Record "Filter Line";
    begin
        lLine.SetRange(TableNo, "Table ID");
        lLine.SetRange(FilterCode, Code);
        lLine.DeleteAll(true);
    end;

    var
        tConfirmDeleteLines: label 'Do you want to delete all lines ?';
        lNoImport: label 'No import define for table %1, Template %2, Bacth %3.';
        lNotUniqueImport: label 'No import define for table %1, Template %2, Bacth %3.';
        tConfirmImport: label 'Do you want to import file %1?';


    procedure Get_View() Return: Text[1000]
    var
        lFilterLine: Record "Filter Line";
        lSet: Boolean;
    begin
        lFilterLine.SetRange(TableNo, "Table ID");
        lFilterLine.SetRange(FilterCode, Code);
        lFilterLine.SetFilter(Filter, '<>%1', '');
        if not lFilterLine.FindSet then
            exit('')
        else
            repeat
                if lSet then
                    StrAppend(Return, ',')
                else
                    StrAppend(Return, ' WHERE(');
                StrAppend(Return, StrSubstNo('Field%1=1(%2)', lFilterLine.FieldNo, lFilterLine.Filter));
                lSet := true;
            until lFilterLine.Next = 0;
        if not lSet then
            StrAppend(Return, ')');
        StrAppend(Return, ')');
    end;


    procedure StrAppend(var pText: Text[1000]; pAppend: Text[1000]) ltNewString: Text[1024]
    var
        ltTooLong: label 'There are to many filters set. Filter string will be too long.\Please remove some filters.';
    begin
        if StrLen(pText) + StrLen(pAppend) > MaxStrLen(pText) then
            Error(ltTooLong)
        else
            pText := pText + pAppend;
    end;


    procedure Set_View(var pRecordRef: RecordRef)
    var
        lFieldRef: FieldRef;
        lFilterLine: Record "Filter Line";
        i: Integer;
        lField: Record "Field";
    begin
        if not pRecordRef.HasFilter then
            exit;
        for i := 1 to pRecordRef.FieldCount do begin
            lFieldRef := pRecordRef.FieldIndex(i);
            Evaluate(lField.Class, Format(lFieldRef.CLASS));
            if (lField.Class <> lField.Class::FlowFilter) and (lFieldRef.GetFilter <> '') then begin
                lFilterLine.TableNo := "Table ID";
                lFilterLine.FilterCode := Code;
                lFilterLine.FieldNo := lFieldRef.Number;
                lFilterLine.Filter := lFieldRef.GetFilter;
                lFilterLine.Insert;
            end;
        end;
    end;


    procedure IsInFilter(var pRecordRef: RecordRef): Boolean
    var
        lRecordRef: RecordRef;
    begin
        lRecordRef := pRecordRef.Duplicate;
        lRecordRef.SetView(Get_View);
        exit(lRecordRef.Find('='));
    end;
}

