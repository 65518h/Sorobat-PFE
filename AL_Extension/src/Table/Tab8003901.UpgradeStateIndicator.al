Table 8003901 "Upgrade State Indicator"
{
    // //TOOL CW 22/01/05 Time Type variables replaced by DateTime


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
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
        NoOfRecords: BigInteger;
        RecordNo: BigInteger;
        TableNoOfRecords: BigInteger;
        TableRecordNo: BigInteger;
        StartTime: DateTime;
        LastUpdateTime: DateTime;
        Started: Boolean;
        Opened: Boolean;
        Window: Dialog;
        Text000: label 'Database...\';
        Text001: label ' No. of Records #1######\';
        Text002: label ' Progress       @2@@@@@@@@@@@@@\';
        Text003: label ' Ending Time    #3##########\\';
        Text004: label 'Table...\';
        Text005: label ' Company        #4#######################\';
        Text006: label ' Table          #5#######################\';
        Text007: label ' No. of Records #6######\';
        Text008: label ' Progress       @7@@@@@@@@@@@@@';
        big: BigInteger;


    procedure Open()
    begin
        Window.Open(
          Text000 +
          Text001 +
          Text002 +
          Text003 +
          Text004 +
          Text005 +
          Text006 +
          Text007 +
          Text008);
        LastUpdateTime := CurrentDatetime;
        Opened := true;
    end;


    procedure UpdateTable(TableName: Text[30]): Boolean
    var
        //GL2024 License   "Object": Record "Object";
        //GL2024 License
        "Object": Record AllObj;
    //GL2024 License
    //GL2024 License   TableInformation: Record "Table Information";


    begin
        Object.SetCurrentkey("Object Type", "Object name");
        Object.SetRange("Object Type", Object."Object Type"::Table);
        Object.SetRange("Object name", TableName);
        Object.Find('-');
        //GL2024 License  TableInformation.SetFilter("Company Name", '%1|%2', '', COMPANYNAME);
        //GL2024 License  TableInformation.SetRange("Table No.", Object."Object ID");
        //GL2024 License   if TableInformation.Find('-') then;

        if not Opened then
            Open;

        if not Started then begin
            //GL2024 License   NoOfRecords := NoOfRecords + TableInformation."No. of Records";
            Window.Update(1, NoOfRecords);
            exit;
        end;

        if TableRecordNo <> TableNoOfRecords then begin
            NoOfRecords := NoOfRecords - (TableNoOfRecords - TableRecordNo);
            Window.Update(1, NoOfRecords);
        end;

        TableRecordNo := 0L;
        //GL2024 License   TableNoOfRecords := TableInformation."No. of Records";

        Window.Update(4, COMPANYNAME);
        Window.Update(5, TableName);
        Window.Update(6, TableNoOfRecords);
        Window.Update(7, 0);
        UpdateWindow;
        exit(true);
    end;


    procedure Start()
    begin
        Started := true;
        StartTime := CurrentDatetime;
        TableRecordNo := TableNoOfRecords;
    end;


    procedure Update()
    begin
        RecordNo := RecordNo + 1L;
        TableRecordNo := TableRecordNo + 1L;
        if Abs(CurrentDatetime - LastUpdateTime) > 100 then
            UpdateWindow;
    end;

    local procedure UpdateWindow()
    var
        t: DateTime;
        lDecimal: Decimal;
    begin
        if (RecordNo <> 0) and (NoOfRecords <> 0) then begin
            Window.Update(2, ROUND(RecordNo / NoOfRecords * 10000L, 1));
            Window.Update(
              3,
              StartTime +
              ROUND((CurrentDatetime - StartTime) * (NoOfRecords / RecordNo), 1));
        end;
        if (TableRecordNo <> 0) and (TableNoOfRecords <> 0) then
            Window.Update(7, ROUND(TableRecordNo / TableNoOfRecords * 10000L, 1));
        LastUpdateTime := CurrentDatetime;
    end;
}

