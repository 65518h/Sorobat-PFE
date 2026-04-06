Table 8001404 "CaptionClass Translation"
{
    // #8048 AC 03/06/10
    // //+BGW+CAPTIONCLASS CW 14/06/08

    Caption = 'CaptionClass Translation';

    fields
    {
        field(1; "Table No."; Integer)
        {
            //blankzero = true;
            Caption = 'Table No.';
            NotBlank = true;
            //GL2024 License   TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
            trigger OnValidate()
            begin
                CalcFields("Table Caption");
            end;
        }
        field(2; "Field No."; Integer)
        {
            //blankzero = true;
            Caption = 'Field No.';
            TableRelation = Field."No." where(TableNo = field("Table No."));

            trigger OnValidate()
            begin
                CalcFields("Field Caption");
            end;
        }
        field(3; "Language ID"; Integer)
        {
            //blankzero = true;
            Caption = 'Language Code';
            TableRelation = "Windows Language" where("STX File Exist" = const(true));

            trigger OnValidate()
            begin
                CalcFields("Language Name");
            end;
        }
        field(4; Caption; Text[30])
        {
            Caption = 'Caption';

            trigger OnValidate()
            begin
                if "Code Caption" = '' then
                    "Code Caption" := CopyStr(StrSubstNo(Text001, Caption), 1, MaxStrLen("Code Caption"));
                if "Filter Caption" = '' then
                    "Filter Caption" := CopyStr(StrSubstNo(Text002, Caption), 1, MaxStrLen("Filter Caption"));
            end;
        }
        field(5; "Code Caption"; Text[30])
        {
            Caption = 'Code Caption';
        }
        field(6; "Filter Caption"; Text[30])
        {
            Caption = 'Filter Caption';
        }
        field(7; "Language Name"; Text[30])
        {
            CalcFormula = lookup("Windows Language".Name where("Language ID" = field("Language ID")));
            Caption = 'Language Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Table Caption"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Table),
                                                                           "Object ID" = field("Table No.")));
            Caption = 'Table Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Field Caption"; Text[80])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."),
                                                              "No." = field("Field No.")));
            Caption = 'Field Caption';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Table No.", "Field No.", "Language ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label '%1 Code';
        Text002: label '%1 Filter';


    procedure GetCaptionClass(pLanguage: Integer; pCaptionExpr: Text[80]): Text[80]
    var
        lCaptionType: Text[80];
        lCaptionRef: Text[80];
        lText: Text[30];
        lCommaPosition: Integer;
        lCaptionClass: Record "CaptionClass Translation";
        lField: Record "Field";
        //GL2024 License   lObject: Record "Object";
        //GL2024 
        lObject: Record AllObj;
    //GL2024 
    begin
        // CaptionClass syntax : 8001400,Captiontype {1:Code, 3:Filter},TableNo,FieldNo
        lCommaPosition := StrPos(pCaptionExpr, ',');
        if lCommaPosition = 0 then
            exit(pCaptionExpr);
        lCaptionType := CopyStr(pCaptionExpr, 1, lCommaPosition - 1);
        lCaptionRef := CopyStr(pCaptionExpr, lCommaPosition + 1);
        lCommaPosition := StrPos(lCaptionRef, ',');
        if lCommaPosition = 0 then begin
            Evaluate(lCaptionClass."Table No.", lCaptionRef);
        end else begin
            lText := CopyStr(lCaptionRef, 1, lCommaPosition - 1);
            Evaluate(lCaptionClass."Table No.", lText);
            lText := CopyStr(lCaptionRef, lCommaPosition + 1);
            Evaluate(lCaptionClass."Field No.", lText);
        end;
        if lCaptionClass.Get(lCaptionClass."Table No.", lCaptionClass."Field No.", pLanguage) then begin // Translation
            case lCaptionType of
                '1':
                    exit(lCaptionClass."Code Caption");
                '3':
                    exit(lCaptionClass."Filter Caption");
                else
                    exit(lCaptionClass.Caption);
            end;
        end else
            if lCaptionClass.Get(lCaptionClass."Table No.", lCaptionClass."Field No.", 0) then begin // else Default (Language = 0)
                case lCaptionType of
                    '1':
                        exit(lCaptionClass."Code Caption");
                    '3':
                        exit(lCaptionClass."Filter Caption");
                    else
                        exit(lCaptionClass.Caption);
                end;
            end else
                if lCaptionClass."Field No." = 0 then begin
                    lObject.Get(lObject."Object Type"::Table, '', lCaptionClass."Table No.");
                    //GL2024 License      lObject.CalcFields(Caption);
                    //GL2024 License    lCaptionClass.Validate(Caption, lObject.Caption);
                    case lCaptionType of
                        '1':
                            exit(lCaptionClass."Code Caption");
                        '3':
                            exit(lCaptionClass."Filter Caption");
                        else
                            exit(lCaptionClass.Caption);
                    end;
                end else begin
                    if lField.Get(lCaptionClass."Table No.", lCaptionClass."Field No.") then
                        exit(lField."Field Caption");
                end;
    end;


    procedure Exists(pTableNo: Integer; pFieldNo: Integer; pLanguageID: Integer): Boolean
    begin
        if Get(pTableNo, pFieldNo, pLanguageID) then
            exit(true)
        else
            exit(Get(pTableNo, pFieldNo, 0));
    end;


    procedure GetCaption(pTableNo: Integer; pFieldNo: Integer; pLanguageID: Integer): Boolean
    begin
        exit(GetCaptionClass(pLanguageID, StrSubstNo('%1,%2,%3', 8001400, pTableNo, pFieldNo)) <> '');
    end;


    procedure InsertCaption(pTableNo: Integer; pFieldNo: Integer; pLanguageID: Integer; pCaption: Text[30])
    begin
        "Table No." := pTableNo;
        "Field No." := pFieldNo;
        "Language ID" := pLanguageID;
        if pCaption = '' then begin
            if Get("Table No.", "Field No.", "Language ID") then
                Delete;
            exit;
        end;
        "Code Caption" := '';
        "Filter Caption" := '';
        Validate(Caption, pCaption);
        if not Insert then
            Modify;
    end;


    procedure DeleteAllCaption(pTableNo: Integer; pFieldNo: Integer)
    begin
        SetRange("Table No.", pTableNo);
        SetRange("Field No.", pFieldNo);
        if not IsEmpty then
            DeleteAll();
    end;


    procedure SetAssistEdit(pTableNo: Integer; pFieldNo: Integer)
    var
        lRec: Record "CaptionClass Translation";
    begin
        lRec.SetRange("Table No.", pTableNo);
        lRec.SetRange("Field No.", pFieldNo);
        //DYS page Addon non migrer
        // if PAGE.RunModal(page::"CaptionClass Translation", lRec) = Action::LookupOK then;
    end;


    procedure GetCaptionValue(pTableNo: Integer; pFieldNo: Integer; pLanguageID: Integer; pCaption: Text[30]) rValue: Text[1024]
    begin
        //rValue := GetCaptionClass(pLanguageID,STRSUBSTNO('%1,%2,%3',8001400,pTableNo,pFieldNo));
        if not Exists(pTableNo, pFieldNo, pLanguageID) then begin
            if (pCaption <> '') then
                rValue := '<' + pCaption + '>';
        end else begin
            rValue := GetCaptionClass(pLanguageID, StrSubstNo('%1,%2,%3', 8001400, pTableNo, pFieldNo));
            if (rValue = '') and (pCaption <> '') then
                rValue := '<' + pCaption + '>';
        end;
    end;
}

