Table 8001428 ReportList
{
    // //+BGW+REPORT_LIST GESWAY 15/01/04 new functions : SetRecordRef, Format, AfterValidate

    Caption = 'Report List';
    DataPerCompany = false;
    //LookupPageID = 8001416;

    fields
    {
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Text; Text[100])
        {
            Caption = 'Text';
        }
        field(4; "Report ID"; Integer)
        {
            //blankzero = true;
            Caption = 'Report ID';
            //GL2024 License  TableRelation = Object.ID where(Type = const(Report));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Report));
            //GL2024 License
            trigger OnValidate()
            begin
                CalcFields("Report Name");
            end;
        }
        field(5; "Report Name"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report),
                                                                           "Object ID" = field("Report ID")));
            Caption = 'Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Form ID"; Integer)
        {
            Caption = 'Form ID';
        }
        field(7; "Form Name"; Text[30])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(page),
                                                                           "Object ID" = field("Form ID")));
            Caption = 'Form Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Form ID", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RepListTransl.SetRange("Menu ID", "Form ID");
        RepListTransl.SetRange("Line No.", "Line No.");
        RepListTransl.DeleteAll;
    end;

    var
        RepListTransl: Record "ReportList Translation";
        gRecordRef: RecordRef;


    procedure ShowList(FormID: Integer)
    var
        ReportList: Record ReportList temporary;
    //DYS page Addon non migrer
    // lReportSelections: Page 8001416;
    begin
        ReportList."Form ID" := FormID;
        Refresh(ReportList);
        //+BGW+REPORT_LIST
        if not FieldExists(FormID) then begin
            //DYS page Addon non migrer
            // lReportSelections.SetRecordRef(gRecordRef);
            // lReportSelections.SetTableview(ReportList);
            // lReportSelections.RunModal;
            // lReportSelections.GetRecord(ReportList);
        end else
            //+BGW+REPORT_LIST//
            page.Run(0, ReportList);
    end;


    procedure Refresh(var TranslatedReportList: Record ReportList)
    var
        ReportList: Record ReportList;
        RepListTransl: Record "ReportList Translation";
    begin
        TranslatedReportList.FilterGroup := 2;
        TranslatedReportList.SetRange("Form ID", TranslatedReportList."Form ID");
        TranslatedReportList.FilterGroup := 0;
        ReportList.FilterGroup := 2;
        ReportList.SetRange("Form ID", TranslatedReportList."Form ID");
        ReportList.FilterGroup := 0;
        //+BGW+REPORT_LIST
        /*
        TranslatedReportList.DELETEALL;
        IF ReportList.FIND('-') THEN BEGIN
          REPEAT
            TranslatedReportList.COPY(ReportList);
            TranslatedReportList.CALCFIELDS("Report Name");
            IF RepListTransl.GET(ReportList."Menu ID",ReportList."Line No.",GLOBALLANGUAGE) THEN
              TranslatedReportList.Text := RepListTransl.Description
            ELSE
              IF ReportList.Text <> '' THEN
                TranslatedReportList.Text := ReportList.Text
              ELSE
                TranslatedReportList.Text := TranslatedReportList."Report Name";
            TranslatedReportList.INSERT;
          UNTIL ReportList.NEXT = 0;
        END ELSE BEGIN
          TranslatedReportList.FILTERGROUP := 2;
          TranslatedReportList.SETRANGE("Menu ID",TranslatedReportList."Menu ID");
          TranslatedReportList.FILTERGROUP := 0;
        END;
        */
        //+BGW+REPORT_LIST//

    end;


    procedure SetRecordRef(pRecordRef: RecordRef; pSetRecFilter: Boolean)
    begin
        //+BGW+REPORT_LIST
        gRecordRef := pRecordRef.Duplicate;
        if pSetRecFilter then
            gRecordRef.SetRecfilter;
        //+BGW+REPORT_LIST//
    end;


    procedure FieldExists(pFieldNo: Integer): Boolean
    var
        lRecordRef: RecordRef;
        lFieldRef: FieldRef;
    begin
        lRecordRef.GetTable(Rec);
        exit(lRecordRef.FieldExist(pFieldNo));
    end;


    procedure TranslateOnFormat(pLanguageID: Integer; var pText: Text[50])
    var
        lLanguage: Record Language;
    begin
        if RepListTransl.Get("Form ID", "Line No.", pLanguageID) then
            pText := RepListTransl.Description
        else
            if pText <> '' then
                exit
            else
                if "Report ID" = 0 then
                    pText := PadStr(pText, 30, '-')
                else begin
                    CalcFields("Report Name");
                    pText := "Report Name";
                end;
    end;


    procedure TranslateOnAfterValidate(pLanguageID: Integer; xText: Text[250]; var pText: Text[250])
    var
        lLanguage: Record Language;
    begin
        if not RepListTransl.Get("Form ID", "Line No.", pLanguageID) then begin
            RepListTransl."Menu ID" := "Form ID";
            RepListTransl."Line No." := "Line No.";
            RepListTransl."Language ID" := pLanguageID;
            RepListTransl.Description := pText;
            RepListTransl.Insert(true);
        end else
            if pText = '' then
                RepListTransl.Delete(true)
            else begin
                RepListTransl.Description := pText;
                RepListTransl.Modify(true);
            end;
        pText := xText; // Restore
    end;


    procedure TranslateOnAssistEdit()
    begin
        RepListTransl.FilterGroup(10);
        RepListTransl.SetRange("Menu ID", "Form ID");
        RepListTransl.SetRange("Line No.", "Line No.");
        RepListTransl.FilterGroup(0);
        //GL2024   PAGE.RunModal(page:572, RepListTransl);

    end;
}

