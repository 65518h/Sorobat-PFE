page 52048972 "Monthly Personal Calendar"
{
    //GL2024  ID dans Nav 2009 : "39001499"
    Caption = 'Calendrier mensuel';
    DataCaptionExpression = GetCaption2;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = Date;
    SourceTableView = WHERE("Period Type" = CONST(Week));
    UsageCategory = Administration;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            field(Year; Year)
            {
                ApplicationArea = all;
                trigger OnValidate();
                begin
                    SetMatrix;
                end;
            }
            field(Month; Month)
            {
                ApplicationArea = all;
                trigger OnValidate();
                begin
                    SetMatrix;
                end;
            }
            repeater("<Control1000000002>")
            {
                ShowCaption = false;
                Editable = false;
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = all;
                }
                /*GL2024 field(Day; DATE2DMY(rec."Period Start" + DATE2DWY(Currpage.Matrix.MatrixRec."Period Start", 1) - 1, 1))
                 {
                     ApplicationArea = all;
                 }*/
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    DecimalPlaces = 0 : 5;
                    //StyleExpr = test1;
                    //Visible = Field1Visible;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    DecimalPlaces = 0 : 5;
                    //StyleExpr = test2;
                    //Visible = Field2Visible;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    DecimalPlaces = 0 : 5;
                    //StyleExpr = test3;
                    //Visible = Field3Visible;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    DecimalPlaces = 0 : 5;
                    //StyleExpr = test4;
                    //Visible = Field4Visible;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    DecimalPlaces = 0 : 5;
                    //StyleExpr = test5;
                    //Visible = Field5Visible;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6];
                    DecimalPlaces = 0 : 5;
                    //StyleExpr = test6;
                    //Visible = Field6Visible;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7];
                    DecimalPlaces = 0 : 5;
                    //StyleExpr = test7;
                    //Visible = Field7Visible;
                }

            }
            /*label(Description)
             {
                 ApplicationArea = all;
                 Caption = 'Description';
             }*/

            field(StatusDescription; StatusDescription)
            {

                Caption = 'Description';
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {
    }

    var
        MATRIX_CellData: array[32] of Decimal;
        MATRIX_CaptionSet: array[32] of Text[1024];
        Year: Integer;
        Month: Option January,February,March,April,May,June,July,August,September,October,November,December;
        FirstMonday: Date;
        LastMonday: Date;
        CurrentMonth: Date;
        FlagNonworkingDay: Boolean;
        CalendarMgmt: Codeunit "Calendar Management";
        NewDescription: Text[30];
        CurrentSourceType: Option Company,Customer,Vendor,Location,"Shipping Agent";
        CurrentSourceCode: Code[20];
        CurrentAddSourceCode: Code[20];
        CurrentBaseCalCode: Code[10];
        CurrentDate2: Date;
        TEMPDATE: Date;
        TempDay: Integer;
        BaseCalendar: Record "Base Calendar";
        CalledFromWindow: Integer;
        StatusDescription: Text[30];
        OK: Boolean;
        FrmCal: page "Base Calendar Entries";
        T1: Record Date;
        Sal: Record Employee;
        Cnt: Record "Employment Contract";
        IntMnth: Integer;
        CodVhl: Code[20];

    trigger OnOpenPage()
    begin
        Year := DATE2DMY(WORKDATE, 3);
        Month := DATE2DMY(WORKDATE, 2) - 1;
        IntMnth := DATE2DMY(WORKDATE, 2);
        MATRIX_CaptionSet[1] := 'Lundi';
        MATRIX_CaptionSet[2] := 'Mardi';
        MATRIX_CaptionSet[3] := 'Mercredi';
        MATRIX_CaptionSet[4] := 'Jeudi';
        MATRIX_CaptionSet[5] := 'Vendredi';
        MATRIX_CaptionSet[6] := 'Samedi';
        MATRIX_CaptionSet[7] := 'Dimanche';

        IF CurrentDate2 = 0D THEN
            CurrentDate2 := WORKDATE;
        CurrentMonth := DMY2DATE(1, DATE2DMY(CurrentDate2, 2), DATE2DMY(CurrentDate2, 3));
        //   Calculate(Month, year);
        //GL2024Currpage.UPDATECONTROLS;
        //MESSAGE('%1',Sal."No.");  
    end;


    trigger
     OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        Periode: Text;
        DateMngt: Record 2000000007;
    begin

        // CurrForm.Matrix.MatrixRec.SETRANGE("Period Type", "Period Type"::Date);
        //  CurrForm.Matrix.MatrixRec.SETRANGE("Period Start", CALCDATE('<-CW>', 010100D), CALCDATE('<CW>', 010100D));
        DateMngt.RESET;
        Periode := rec."Period Name";
        DateMngt.SETRANGE("Period Start", CurrentMonth, CALCDATE('<CM>', CurrentMonth));
        DateMngt.SETRANGE("Period Name", Periode);

        MATRIX_CurrentColumnOrdinal := 0;
        WHILE MATRIX_CurrentColumnOrdinal < 7 DO BEGIN

            MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
        END;
        //    FirstMonday += 7;

    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnOrdinal: Integer);
    var
        Day: Integer;
        DateMngt: Record 2000000007;
        DaT: Date;
    begin

        Day := DATE2DMY((rec."Period Start" + ColumnOrdinal) - 1, 1);
        MATRIX_CellData[ColumnOrdinal] := Day;

    end;


    procedure Calculate(Month: Option January,February,March,April,May,June,July,August,September,October,November,December; years: Integer)
    begin


        rec.FILTERGROUP(2);
        //CurrentMonth:=DMY2DATE(1,Month,years);
        /* IF years = 0 THEN BEGIN
             CurrentMonth := WORKDATE;
         END ELSE BEGIN*/
        CurrentMonth := DMY2DATE(1, Month + 1, years);
        //  MESSAGE(FORMAT(CurrentMonth));
        // END;
        //MESSAGE(VHL);


        REC.SETRANGE("Period Start", CurrentMonth, CALCDATE('<CM>', CurrentMonth));
        REC.FILTERGROUP(0);

        IF REC.FIND('+') THEN
            LastMonday := REC."Period Start";
        IF REC.FIND('-') THEN BEGIN
            FirstMonday := REC."Period Start";
            IF DATE2DMY(FirstMonday, 1) <> 1 THEN
                FirstMonday := FirstMonday - 7;
        END;

        REC.FILTERGROUP(2);
        REC.SETRANGE("Period Start", FirstMonday, LastMonday);
        REC.FILTERGROUP(0);

        Year := DATE2DMY(CurrentMonth, 3);
        Month := DATE2DMY(CurrentMonth, 2) - 1;
        CurrPAGE.UPDATE(false);
    end;

    procedure SetMatrix();
    begin



        Calculate(Month, Year);


        CurrPage.UPDATE(false);

    end;

    procedure SetCalendarCode(CalledFrom: Integer; SourceType: Option Company,Customer,Vendor,Location,"Shipping Agent"; SourceCode: Code[20]; AddSourceCode: Code[20]; BaseCalendarCode: Code[10]; CurrentDate: Date)
    begin

        CalledFromWindow := CalledFrom;
        CurrentSourceType := SourceType;
        CurrentSourceCode := SourceCode;
        CurrentAddSourceCode := AddSourceCode;
        CurrentBaseCalCode := BaseCalendarCode;
        CurrentDate2 := CurrentDate;
    end;


    procedure GetCaption2(): Text[250]
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        Location: Record Location;
        ShippingAgentService: Record "Shipping Agent Services";
    begin

        IF CalledFromWindow = 1 THEN BEGIN
            IF BaseCalendar.GET(CurrentBaseCalCode) THEN
                EXIT(BaseCalendar.Code + ' ' + BaseCalendar.Name);
        END ELSE BEGIN
            CASE CurrentSourceType OF
                CurrentSourceType::Company:
                    EXIT(COMPANYNAME);
                CurrentSourceType::Customer:
                    IF Customer.GET(CurrentSourceCode) THEN
                        EXIT(CurrentSourceCode + ' ' + Customer.Name);
                CurrentSourceType::Vendor:
                    IF Vendor.GET(CurrentSourceCode) THEN
                        EXIT(CurrentSourceCode + ' ' + Vendor.Name);
                CurrentSourceType::Location:
                    IF Location.GET(CurrentSourceCode) THEN
                        EXIT(CurrentSourceCode + ' ' + Location.Name);
                CurrentSourceType::"Shipping Agent":
                    IF ShippingAgentService.GET(CurrentSourceCode, CurrentAddSourceCode) THEN
                        EXIT(CurrentSourceCode + ' ' + CurrentAddSourceCode + ' ' + ShippingAgentService.Description);
            END;
        END;
    end;


    procedure SetSalN(Employee: Code[20])
    begin

        Sal.RESET;
        Sal.GET(Employee);
        // MESSAGE('%1   %2',Employee,Sal."No.");
    end;
}

