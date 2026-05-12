Page 99991 "UEI - Field Mapping"
{
    // //
    // // Universal Excel Importer
    // // (c) 2006-2008 Slawek Guzek, sguzek@onet.pl
    // //

    AutoSplitKey = true;
    Caption = 'UEI - Field Mapping';
    DataCaptionExpression = mapDescriptor;
    DeleteAllowed = true;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = List;
    SourceTable = "Excel Buffer";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Cell Value as Text"; rec."Cell Value as Text")
                {
                    ApplicationArea = Basic;
                    Caption = 'Excel header column';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        ValidateMapFromExcelHeader;
                        CellValueasTextOnAfterValidate;
                    end;
                }
                field(MapToField; rec.Formula)
                {
                    ApplicationArea = Basic;
                    Caption = 'Map to';
                    Editable = true;
                    Enabled = MapToFieldEnable;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        FName: Text[50];
                        fno: Integer;
                        OtherMapSoure: Text[50];
                    begin
                        fno := TargetFieldLookup(FName);
                        if fno > 0 then begin
                            OtherMapSoure := UEICode.activeMappingExists(Format(fno, 0, 2), true, Rec);
                            if OtherMapSoure <> '' then begin
                                Error(Text004, rec.Formula, OtherMapSoure);
                            end;
                            Field.Get(TableNo, fno);
                            fillMappingInfo(Rec, Field);
                        end;
                    end;

                    trigger OnValidate()
                    var
                        i: Integer;
                        OtherMapSoure: Text[50];
                    begin
                        ValidateMapToField;
                        FormulaOnAfterValidate;
                    end;
                }
                field(doImport; rec.Italic)
                {
                    ApplicationArea = Basic;
                    Caption = 'Import';
                    Enabled = doImportEnable;

                    trigger OnValidate()
                    var
                        OtherMapSoure: Text[50];
                        MapTo: Integer;
                    begin
                        if rec.Italic and (rec.Comment <> '') then begin
                            OtherMapSoure := UEICode.activeMappingExists(rec.Comment, true, Rec);
                            if OtherMapSoure <> '' then
                                Error(Text004, rec.Formula, OtherMapSoure);
                        end;
                        case true of
                            rec.NumberFormat = '':
                                rec.Italic := false; // non importable field
                            rec.Formula = '':
                                rec.Italic := false; // no mapping exist
                            rec.Formula2 <> '':
                                rec.Italic := true;  // primary key required
                        end;
                    end;
                }
                field(DoValidate; rec.Bold)
                {
                    ApplicationArea = Basic;
                    Caption = 'Validate';
                    Enabled = DoValidateEnable;

                    trigger OnValidate()
                    begin
                        if oDontChangeValidation then
                            Error('');

                        case true of
                            rec.NumberFormat = '':
                                rec.Bold := false;// non importable field
                        end;
                    end;
                }
            }
            field(InsertCheckBox; optInsert)
            {
                ApplicationArea = Basic;
                Caption = 'Insert';
                Enabled = InsertCheckBoxEnable;

                trigger OnValidate()
                begin
                    optInsertOnPush;
                end;
            }
            field(updateCheckBox; optUpdate)
            {
                ApplicationArea = Basic;
                Caption = 'Update';
                Enabled = updateCheckBoxEnable;

                trigger OnValidate()
                begin
                    optUpdateOnPush;
                end;
            }
            field(doDelayedInsert; optDelayedInsert)
            {
                ApplicationArea = Basic;
                Caption = 'Delayed INSERT';
            }
            field(OnInsertCheckbox; oSkipOnInsertTrigger)
            {
                ApplicationArea = Basic;
                Caption = 'Don''t use OnInsert trigger';
                Enabled = OnInsertCheckboxEnable;
            }
            field(ShowPKCheckBox; HideUnchangeable)
            {
                ApplicationArea = Basic;
                Caption = 'Hide required and non-importable';

                trigger OnValidate()
                begin
                    HideUnchangeableOnAfterValidate;
                end;
            }
        }
    }

    actions
    {
        area(Promoted)
        {

            group(fFieldValidate1)
            {
                Caption = '&Validate';
                actionref("Inverse Validate settings1"; "Inverse Validate settings") { }
                actionref("Validate All1"; "Validate All") { }


            }

            group(fFieldSelect1)
            {
                Caption = '&Import';
                actionref("&Inverse column selection1"; "&Inverse column selection") { }
                actionref("Select &all1"; "Select &all") { }
                actionref("Set &constant as source1"; "Set &constant as source") { }
                actionref("Set cou&nter as source1"; "Set cou&nter as source") { }
                actionref("Set &source column1"; "Set &source column") { }
            }
        }
        area(navigation)
        {
            group(fFieldValidate)
            {
                Caption = '&Validate';
                action("Inverse Validate settings")
                {
                    ApplicationArea = Basic;
                    Caption = 'Inverse Validate settings';

                    trigger OnAction()
                    begin
                        RecCopy := Rec;
                        rec.FilterGroup(10);
                        rec.SetFilter(NumberFormat, '<>%1', '');
                        if rec.Find('-') then
                            repeat
                                rec.Bold := not rec.Bold;
                                rec.Modify;
                            until rec.Next = 0;
                        rec.SetRange(NumberFormat);
                        rec.FilterGroup(0);
                        Rec := RecCopy;
                        rec.Bold := not rec.Bold;
                        CurrPage.Update(false);
                    end;
                }
                action("Validate All")
                {
                    ApplicationArea = Basic;
                    Caption = 'Validate All';

                    trigger OnAction()
                    begin
                        rec.FilterGroup(10);
                        rec.SetFilter(NumberFormat, '<>%1', '');
                        rec.ModifyAll(Bold, true);
                        rec.SetRange(NumberFormat);
                        CurrPage.Update(false);
                        rec.FilterGroup(0);
                    end;
                }
            }
            group(fFieldSelect)
            {
                Caption = '&Import';
                action("&Inverse column selection")
                {
                    ApplicationArea = Basic;
                    Caption = '&Inverse column selection';

                    trigger OnAction()
                    begin
                        RecCopy := Rec;
                        rec.FilterGroup(10);
                        rec.SetFilter(NumberFormat, '<>%1', ''); // all importable
                        rec.SetFilter(Formula2, '%1', '');  // non PK
                        if rec.Find('-') then
                            repeat
                                rec.Italic := not rec.Italic;
                                rec.Modify;
                            until rec.Next = 0;
                        rec.SetRange(Formula2);
                        rec.SetRange(NumberFormat);
                        CurrPage.Update(false);
                        rec.FilterGroup(0);
                        Rec := RecCopy;
                        rec.Italic := not rec.Italic;
                    end;
                }
                action("Select &all")
                {
                    ApplicationArea = Basic;
                    Caption = 'Select &all';

                    trigger OnAction()
                    begin
                        SelectAllToImport;
                    end;
                }
                separator(Action1000000017)
                {
                }
                action("Set &constant as source")
                {
                    ApplicationArea = Basic;
                    Caption = 'Set &constant as source';

                    trigger OnAction()
                    begin
                        rec.Validate("Cell Value as Text", UEICode.getPARAMDEF_CONSTANT + ':sample const');
                        ValidateMapFromExcelHeader;
                    end;
                }
                action("Set cou&nter as source")
                {
                    ApplicationArea = Basic;
                    Caption = 'Set cou&nter as source';

                    trigger OnAction()
                    begin
                        rec.Validate("Cell Value as Text", UEICode.getPARAMDEF_INCREMENT + ':00001');
                        ValidateMapFromExcelHeader;
                    end;
                }
                action("Set &source column")
                {
                    ApplicationArea = Basic;
                    Caption = 'Set &source column';
                    Visible = false;

                    trigger OnAction()
                    begin
                        SourceFieldLookup('');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CellValueasTextOnFormat(Format(rec."Cell Value as Text"));
        FormulaOnFormat;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        exit(true);
    end;

    trigger OnInit()
    begin
        OnInsertCheckboxEnable := true;
        updateCheckBoxEnable := true;
        InsertCheckBoxEnable := true;
        MapToFieldEnable := true;
        doImportEnable := true;
        fFieldValidateEnable := true;
        DoValidateEnable := true;
        RED := 255;
        GRAY := 255 + (127 * 256) + (0 * 256 * 256);
        BLUE := 0 + (0 * 256) + (255 * 256 * 256);

        rec.FilterGroup(8);
        rec.SetRange("Row No.", UEICode.FieldMappingMinRange, UEICode.FieldMappingMaxRange);
        rec.FilterGroup(0);
        //HideUnchangeable := TRUE;
        calcOptions;
        // TableNo := 60037;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if SkipOnModify then begin
            SkipOnModify := false;
            exit(false);
        end;
        exit(true);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        xlBuffer2: Record 370;
        xlBuffer3: Record 370;
        i: Integer;
    begin
        if xRec."Row No." <= UEICode.PrimaryKeyInfoEndRow() then
            Error('');

        if BelowxRec then begin
            xlBuffer2.Find('+');
            i := xlBuffer2."Row No." + 5;
        end else begin
            xlBuffer2 := xRec;
            xlBuffer2.SetRange("Row No.", UEICode.ConstantsAreaBeginRow(), UEICode.FieldMapEndRow());
            case xlBuffer2.Next(-1) of
                -1:
                    i := xRec."Row No." - ROUND((Abs(xlBuffer2."Row No.") - Abs(xRec."Row No.")) / 2, 1);
                0:
                    i := xlBuffer2."Row No." - 2;
            end;
        end;
        rec."Row No." := i;
    end;

    trigger OnOpenPage()
    begin
        enableConstFieldsView;
        enableOptions;
        // CurrForm.doInsert.VISIBLE(FALSE);
        DoValidateEnable := not oDontChangeValidation;
        fFieldValidateEnable := not oDontChangeValidation;
        doImportEnable := not oDontChangeMapping;
        MapToFieldEnable := not oDontChangeMapping;
        if rec.Find('-') then;
    end;

    var
        "Field": Record "Field";
        UEICode: Codeunit "Universal Excel Importer";
        RecCopy: Record "Excel Buffer";
        optInsert: Boolean;
        optUpdate: Boolean;
        optDelayedInsert: Boolean;
        importerOptions: Integer;
        TableNo: Integer;
        ColumnFilter: Text[1024];
        Text001: label 'Nagêowek w Excelu';
        oDontChangeOptions: Boolean;
        oDontChangeMapping: Boolean;
        oSkipOnInsertTrigger: Boolean;
        oDontChangeValidation: Boolean;
        HideUnchangeable: Boolean;
        Text002: label 'This is primary key field. You cannot exclude it';
        Text003: label 'This if FlowFiled or FlowFilter. You cannot import anything to this type field.';
        Text004: label 'Two sources cannot be mapped to one target: Mapping to field %1 already exist (from %2)';
        Text005: label 'There is no field %2 in table no %1';
        Text006: label 'unnamed';
        Text007: label 'Insert constans instead of value from Excel column';
        Text008: label '!!no source defined!!';
        SkipOnModify: Boolean;
        RED: Integer;
        GRAY: Integer;
        BLUE: Integer;
        [InDataSet]
        DoValidateEnable: Boolean;
        [InDataSet]
        fFieldValidateEnable: Boolean;
        [InDataSet]
        doImportEnable: Boolean;
        [InDataSet]
        MapToFieldEnable: Boolean;
        [InDataSet]
        "Cell Value as TextEmphasize": Boolean;
        [InDataSet]
        MapToFieldEmphasize: Boolean;
        [InDataSet]
        InsertCheckBoxEnable: Boolean;
        [InDataSet]
        updateCheckBoxEnable: Boolean;
        [InDataSet]
        OnInsertCheckboxEnable: Boolean;


    procedure SetColor(): Integer
    begin
        if rec.Formula2 <> '' then                                       // formula2 <>'' -> PK field
            if (not rec.Italic)                                           // not selected to import
              or ((rec."Column No." = 0) and (rec.Formula3 = ''))               // column=0 -> constant source
              or ((rec."Column No." <> 0) and (rec."Cell Value as Text" = ''))// no source column
            then
                exit(RED);

        if rec.NumberFormat = '' then                       // NumberFormat = '' -> not importable
            exit(GRAY);

        if (rec."Column No." = 0) and (rec.Formula3 <> '') then
            exit(BLUE);
    end;


    procedure setParameters(TabNo: Integer; opt: Integer; ColFilter: Text[1024])
    begin
        TableNo := TabNo;
        importerOptions := opt;
        ColumnFilter := ColFilter;

        calcOptions;
        enableOptions;
    end;


    procedure calcOptions()
    begin
        if importerOptions MOD 4 = 0 then
            importerOptions += 3;

        optInsert := UEICode.testBit(0, importerOptions);
        optUpdate := UEICode.testBit(1, importerOptions);
        optDelayedInsert := UEICode.testBit(2, importerOptions);
        oSkipOnInsertTrigger := UEICode.testBit(8, importerOptions);
        oDontChangeOptions := UEICode.testBit(10, importerOptions);
        oDontChangeMapping := UEICode.testBit(11, importerOptions);
        oDontChangeValidation := UEICode.testBit(12, importerOptions);
    end;


    procedure getOptions(): Integer
    begin

        if optInsert then UEICode.setBit(1, importerOptions);
        if optUpdate then UEICode.setBit(2, importerOptions);
        if optDelayedInsert then UEICode.setBit(3, importerOptions);
        if oSkipOnInsertTrigger then UEICode.setBit(8, importerOptions);

        exit(importerOptions);
    end;


    procedure enableConstFieldsView()
    begin
        rec.FilterGroup(2);
        if HideUnchangeable then begin
            rec.SetFilter(NumberFormat, '<>%1', ''); // only importable fields
            rec.SetRange(Formula2, ''); // non primary keys visible
        end else begin
            rec.SetRange(NumberFormat);
            rec.SetRange(Formula2)
        end;
        rec.FilterGroup(0);

        if rec.Find('=') then;
    end;


    procedure enableOptions()
    var
        en: Boolean;
    begin
        InsertCheckBoxEnable := not oDontChangeOptions;
        updateCheckBoxEnable := not oDontChangeOptions;
        OnInsertCheckboxEnable := not oDontChangeOptions;
    end;


    procedure SelectAllToImport()
    begin
        RecCopy := Rec;
        rec.FilterGroup(10);
        rec.SetFilter(NumberFormat, '<>%1', '');
        rec.SetRange(Italic, false);
        if rec.Find('-') then
            repeat
                rec.Italic := ((rec."Column No." = 0) or (rec."Cell Value as Text" <> ''))
                  and (UEICode.activeMappingExists(rec.Comment, true, Rec) = '');
                rec.Modify;
            until rec.Next = 0;
        rec.SetRange(NumberFormat);
        rec.SetRange(Italic);
        rec.FilterGroup(0);
        CurrPage.Update(false);
        Rec := RecCopy;
    end;


    procedure FindTargetFieldByName(var "Field": Record "Field"; TabNo: Integer; Fname: Text[50])
    begin
        Field.Reset;
        Field.SetRange(TableNo, TabNo);
        Field.SetRange(Class, Field.Class::Normal);
        Field.SetFilter(FieldName, '@' + Fname + '*');
        if not Field.Find('-') then
            Error(Text005, TabNo, Fname);
    end;


    procedure cleanMappingInfo(var CurrRec: Record 370)
    begin
        with CurrRec do begin
            Bold := false; // fire VALIDATE flag
            Formula := ''; // Destinaiton Field Name
            Comment := ''; // Destinaiton Field No.
            Formula2 := '';// Primary Key Field No.
            Formula3 := '';//
            Formula4 := '';// Destination Field Type
            NumberFormat := ''; // Importable flag
            Italic := false; // Selected to import
        end;
    end;


    procedure fillMappingInfo(var CurrRec: Record 370; "Field": Record "Field")
    var
        i: Integer;
    begin
        with CurrRec do begin
            Formula := Field.FieldName;         // Destinaiton Field Name
            Comment := Format(Field."No.", 0, 2); // Destinaiton Field No.
            Formula4 := Format(Field.Type);     // Destination Field Type
            if Field.Class = Field.Class::Normal then
                NumberFormat := 'Importable';     // Importable
            Italic := ("Cell Value as Text" <> '') or (Formula3 <> ''); // Selected to import

            i := UEICode.checkPrimaryKeyFieldNo(TableNo, Field."No.");
            if i > 0 then begin
                Formula2 := 'KeyField' + Format(i, 0, 2);   // Primary Key Field No.
                if Field.Class = Field.Class::Normal then
                    NumberFormat := 'KeyField';
            end;
        end;
    end;


    procedure ValidateMapToField()
    var
        i: Integer;
        OtherMapSoure: Text[50];
    begin
        if rec.Formula = '' then begin
            if (rec.Formula2 <> '') and (UEICode.activeMappingExists(rec.Comment, false, Rec) = '') then
                Error(''); //
            cleanMappingInfo(Rec);
            exit;
        end;

        if Evaluate(i, rec.Formula) then
            Field.Get(TableNo, i)
        else
            FindTargetFieldByName(Field, TableNo, rec.Formula);

        OtherMapSoure := UEICode.activeMappingExists(Format(Field."No.", 0, 2), true, Rec);
        if OtherMapSoure <> '' then
            Error(Text004, Field.FieldName, OtherMapSoure);

        fillMappingInfo(Rec, Field);
        rec.Modify;
    end;


    procedure TargetFieldLookup(var FieldName: Text[50]): Integer
    var
        "Field": Record "Field";
        FieldChooseForm: page 99992;
    begin
        if TableNo = 0 then
            exit;

        Field.Reset;
        Field.FilterGroup(2);
        Field.SetRange(TableNo, TableNo);
        Field.SetRange(Class, Field.Class::Normal);
        if ColumnFilter <> '' then
            Field.SetFilter("No.", ColumnFilter);
        Field.FilterGroup(0);

        Clear(FieldChooseForm);
        FieldChooseForm.LookupMode(true);
        FieldChooseForm.SetTableview(Field);
        if FieldChooseForm.RunModal = Action::LookupOK then begin
            FieldChooseForm.GetRecord(Field);
            FieldName := Field.FieldName;
            exit(Field."No.");
        end;
    end;


    procedure ValidateMapFromExcelHeader()
    var
        sFormula: Text[250];
        row: Integer;
        col: Integer;
    begin
        sFormula := Lowercase(rec."Cell Value as Text");
        case true of
            CopyStr(sFormula, 1, StrLen(UEICode.getPARAMDEF_INCREMENT) + 1) = Lowercase(UEICode.getPARAMDEF_INCREMENT + ':'):
                begin
                    rec.Formula3 := CopyStr(rec."Cell Value as Text", StrLen(UEICode.getPARAMDEF_INCREMENT) + 2);
                    rec.NumberFormat := UEICode.getPARAMDEF_INCREMENT;
                    rec."Cell Value as Text" := '';
                    rec.Underline := true;  // Increment
                    rec.Italic := true;  // import
                    rec.Modify;
                    SkipOnModify := true;
                    rec.Rename(rec."Row No.", 0);
                    rec.Get(rec."Row No.", 0);
                    exit;
                end;
            CopyStr(sFormula, 1, StrLen(UEICode.getPARAMDEF_INCREMENT2) + 1) = Lowercase(UEICode.getPARAMDEF_INCREMENT2 + ':'):
                begin
                    rec.Formula3 := CopyStr(rec."Cell Value as Text", StrLen(UEICode.getPARAMDEF_INCREMENT2) + 2);
                    rec.NumberFormat := UEICode.getPARAMDEF_INCREMENT;
                    rec."Cell Value as Text" := '';
                    rec.Underline := true;  // Increment
                    rec.Italic := true;  // import
                    rec.Modify;
                    SkipOnModify := true;
                    rec.Rename(rec."Row No.", 0);
                    rec.Get(rec."Row No.", 0);
                    exit;
                end;
            CopyStr(sFormula, 1, StrLen(UEICode.getPARAMDEF_CONSTANT) + 1) = Lowercase(UEICode.getPARAMDEF_CONSTANT + ':'):
                begin
                    rec.Formula3 := CopyStr(rec."Cell Value as Text", StrLen(UEICode.getPARAMDEF_CONSTANT) + 2);
                    rec.NumberFormat := UEICode.getPARAMDEF_CONSTANT;
                    rec."Cell Value as Text" := '';
                    rec.Underline := false;
                    rec.Italic := true;
                    rec.Modify;
                    SkipOnModify := true;
                    rec.Rename(rec."Row No.", 0);
                    rec.Get(rec."Row No.", 0);
                    exit;
                end;
        end;

        if not SourceFieldLookup(sFormula) then
            rec."Cell Value as Text" := xRec."Cell Value as Text";
    end;


    procedure SourceFieldLookup(fname: Text[200]): Boolean
    var
        xlBuffer: Record 370;
        SourceFields: Record 370 temporary;
        SourceFieldLookupFrm: page 9994;
    begin
        fname := Lowercase(fname);

        xlBuffer.Reset;
        xlBuffer.SetRange("Column No.", 1, 256);
        xlBuffer.SetRange("Row No.", 0);
        if fname <> '' then
            xlBuffer.SetFilter("Cell Value as Text", '@' + fname + '*')
        else
            xlBuffer.SetFilter("Cell Value as Text", '<>%1', '');

        if not xlBuffer.Find('-') then
            xlBuffer.SetFilter("Cell Value as Text", '<>%1', '')
        else
            if xlBuffer.Next = 0 then begin
                rec."Cell Value as Text" := xlBuffer."Cell Value as Text";
                rec.Formula3 := '';
                rec.Italic := true;
                rec.Modify;
                SkipOnModify := true;
                rec.Rename(rec."Row No.", xlBuffer."Column No.");
                exit(true);
            end;

        if xlBuffer.Find('-') then
            repeat
                if not SourceFields.Get(0, xlBuffer."Column No.") then begin
                    SourceFields := xlBuffer;
                    SourceFields."Row No." := 0;
                    SourceFields.Insert;
                end;
            until xlBuffer.Next = 0;

        SourceFields.Find('-');
        if page.RunModal(page::"UEI - Source Field List", SourceFields) = Action::LookupOK then begin
            rec."Cell Value as Text" := SourceFields."Cell Value as Text";
            rec.Formula3 := '';
            rec.Italic := true;
            rec.Modify;
            SkipOnModify := true;
            rec.Rename(rec."Row No.", SourceFields."Column No.");
            exit(true);
        end
    end;


    procedure mapDescriptor(): Text[250]
    var
        t: Text[250];
    begin
        if rec."Column No." = 0 then
            t := rec.NumberFormat + ': ' + rec.Formula3
        else
            t := rec."Cell Value as Text";

        if t = '' then
            t := Text008;

        exit(StrSubstNo('%1 >> %2(%3)', t, rec.Formula, rec.Comment))
    end;

    local procedure CellValueasTextOnAfterValidate()
    begin
        rec.FilterGroup(3);
        rec.SetRange(Formula, '');
        rec.SetRange("Cell Value as Text", rec."Cell Value as Text");
        rec.DeleteAll;
        rec.SetRange(Formula);
        rec.SetRange("Cell Value as Text");
        rec.FilterGroup(0);
        CurrPage.Update;
    end;

    local procedure FormulaOnAfterValidate()
    begin
        rec.FilterGroup(3);
        rec.SetRange(Formula, rec.Formula);
        rec.SetRange("Cell Value as Text", '');
        rec.DeleteAll;
        rec.SetRange(Formula);
        rec.SetRange("Cell Value as Text");
        rec.FilterGroup(0);
        CurrPage.Update;
    end;

    local procedure HideUnchangeableOnAfterValidate()
    begin
        enableConstFieldsView;
        CurrPage.Update(false);
        //NEXT(-1);
    end;

    local procedure optInsertOnPush()
    begin
        if not optInsert then
            optUpdate := true;
    end;

    local procedure optUpdateOnPush()
    begin
        if not optUpdate then
            optInsert := true;
    end;

    local procedure CellValueasTextOnFormat(Text: Text[1024])
    begin
        if rec.Formula2 <> '' then                 // formula2 <>'' -> PK field
            "Cell Value as TextEmphasize" := true;

        if rec.Italic and (rec."Column No." = 0) then   // italic=true -> selected for import
            Text := rec.NumberFormat + ': ' + rec.Formula3;
    end;

    local procedure FormulaOnFormat()
    begin
        if rec.Formula2 <> '' then                 // formula2 <>'' -> PK field
            MapToFieldEmphasize := true;
    end;
}

