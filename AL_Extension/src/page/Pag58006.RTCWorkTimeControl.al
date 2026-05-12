Page 58006 "RTC Work Time Control"
{
    // //POINTAGE GESWAY 29/08/02 Contrôle des pointages
    // //OUVRAGE GESWAY 22/04/05 Avoir la fiche qui correspond au type

    Caption = 'RTC Work Time Control';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    Permissions = TableData 8004133 = r;
    SaveValues = true;
    SourceTable = 156;
    SourceTableView = sorting(Type, "WT Allowed", Status, "No.")
                      where(Type = filter(Person | Machine),
                            "WT Allowed" = const(true));

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filters';
                field(FiltreType; FiltreType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Resource Type Filter';
                    OptionCaption = ' ,Person,Machine';

                    trigger OnValidate()
                    begin
                        case FiltreType of
                            Filtretype::" ":
                                rec.SetRange(Type);
                            Filtretype::Person:
                                rec.SetRange(Type, rec.Type::Person);
                            Filtretype::Machine:
                                rec.SetRange(Type, rec.Type::Machine);
                            else
                                ;
                        end;
                        FiltreTypeOnAfterValidate;
                    end;
                }
                field(FiltreHeures; FiltreHeures)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hours Filter';

                    trigger OnValidate()
                    var
                        i: Integer;
                    begin
                        for i := 1 to StrLen(FiltreHeures) do
                            if not (FiltreHeures[i] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '&', '|', '<', '=', '>']) then
                                Error(Text8003901);
                    end;
                }
                field(FT; FiltreTypeTravail)
                {
                    ApplicationArea = Basic;
                    Caption = 'Work Type Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lWT: Record 200;
                    begin
                        FiltreTypeTravail := Text;
                        lWT.SetFilter(lWT.Code, FiltreWT);
                        if page.RunModal(0, lWT) = Action::LookupOK then begin
                            if FiltreTypeTravail <> '' then
                                if FiltreTypeTravail[StrLen(FiltreTypeTravail)] <> '|' then
                                    FiltreTypeTravail := '';
                            FiltreTypeTravail += lWT.Code;
                            rec.SetFilter("Work Type Filter", FiltreTypeTravail);
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        if FiltreTypeTravail = '' then
                            rec.SetFilter("Work Type Filter", FiltreWT)
                        else
                            rec.SetFilter("Work Type Filter", FiltreTypeTravail);
                    end;
                }
                field(FiltreValide; FiltreValide)
                {
                    ApplicationArea = Basic;
                    Caption = 'Show Entries';
                    OptionCaption = 'All,Posted,Journal';

                    trigger OnValidate()
                    begin
                        FiltreValideOnAfterValidate;
                    end;
                }
            }
            group("Options Matrix")
            {
                Caption = 'Options Matrix';
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period';
                    OptionCaption = 'Day,Week,Month,Quarter,Year,Accounting Period';

                    trigger OnValidate()
                    begin
                        SetColumns(Setwanted::Initial);
                    end;
                }
                field(ColumnSet; ColumnSet)
                {
                    ApplicationArea = Basic;
                    Caption = 'Column Set';
                    Editable = false;
                }
                field(QtyType; QtyType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Quantity Type';
                    OptionCaption = 'Net Change,Balance at Date';
                }
            }
            repeater(Control800390011)
            {
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Field1; ColumnValue[1])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[1];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(1);
                    end;
                }
                field(Field2; ColumnValue[2])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[2];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(2);
                    end;
                }
                field(Field3; ColumnValue[3])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[3];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(3);
                    end;
                }
                field(Field4; ColumnValue[4])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[4];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(4);
                    end;
                }
                field(Field5; ColumnValue[5])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[5];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(5);
                    end;
                }
                field(Field6; ColumnValue[6])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[6];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(6);
                    end;
                }
                field(Field7; ColumnValue[7])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[7];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(7);
                    end;
                }
                field(Field8; ColumnValue[8])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[8];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(8);
                    end;
                }
                field(Field9; ColumnValue[9])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[9];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9);
                    end;
                }
                field(Field10; ColumnValue[10])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[10];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10);
                    end;
                }
                field(Field11; ColumnValue[11])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[11];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11);
                    end;
                }
                field(Field12; ColumnValue[12])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[12];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(12);
                    end;
                }
            }

        }
    }

    actions
    {
        area(Promoted)
        {

            group("&Resource1")
            {
                Caption = '&Resource';
                actionref(Card1; Card) { }
                actionref(Statistics1; Statistics) { }
                actionref("Co&mments1"; "Co&mments") { }
                actionref(Dimensions1; Dimensions) { }

                actionref("Ledger E&ntries1"; "Ledger E&ntries") { }


            }

            group("&Prices1")
            {
                Caption = '&Prices';
                actionref(Prices1; Prices) { }
            }

            actionref("Data Refresh1"; "Data Refresh") { }





            actionref("Previous Set1"; "Previous Set") { }
            actionref("Previous Column1"; "Previous Column") { }
            actionref("Next Column1"; "Next Column") { }
            actionref("Next Set1"; "Next Set") { }
        }
        area(navigation)
        {
            group("&Resource")
            {
                Caption = '&Resource';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    //  ShortCutKey = 'Maj+F5';

                    trigger OnAction()
                    begin
                        case rec.Type of
                            rec.Type::Person:
                                page.RunModal(page::"Resource Card", Rec);
                        /*GL2024 rec.Type::Machine:
                             page.RunModal(page::"Machine Resource", Rec);
                         rec.Type::Structure:
                             page.RunModal(page::"Structure Card", Rec);
                         else
                             ;*/
                        end;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;

                    RunpageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Unit of Measure Filter" = FIELD("Base Unit of Measure"),
                                  "Chargeable Filter" = FIELD("Chargeable Filter");
                    RunObject = Page "Resource Statistics";
                    //  ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunpageLink = "Table Name" = CONST(Resource),
                                  "No." = FIELD("No.");
                    RunObject = Page "Comment Sheet";
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunpageLink = "Table ID" = CONST(156),
                                  "No." = FIELD("No.");
                    RunObject = Page "Default Dimensions";
                    //  ShortCutKey = 'Maj+Ctrl+D';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    RunpageLink = "Resource No." = FIELD("No.");
                    RunpageView = SORTING("Resource No.");
                    RunObject = Page "Resource Ledger Entries";
                    //  ShortCutKey = 'Ctrl+F7';
                }
            }
            group("&Prices")
            {
                Caption = '&Prices';
                /*GL2024    action(Costs)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Costs';
                        Image = ResourceCosts;
                        RunpageLink = Type=CONST(Resource),
                                      Code=FIELD("No.");
                        RunObject = Page 8004165;
                    }*/
                action(Prices)
                {
                    ApplicationArea = Basic;
                    Caption = 'Prices';
                    Image = ResourcePrice;
                    RunpageLink = Type = CONST(Resource),
                                  Code = FIELD("No.");
                    RunObject = Page "Resource Prices";
                }
            }
            group("Plan&ning")
            {
                Caption = 'Plan&ning';
                /*GL2024  action("Resource &Allocated per Job")
                  {
                      ApplicationArea = Basic;
                      Caption = 'Resource &Allocated per Job';
                      RunpageLink = Resource "Filter"=FIELD("No.");
                      RunObject = Page 8004169;
                  }
                  action("&Set Capacity")
                  {
                      ApplicationArea = Basic;
                      Caption = '&Set Capacity';
                      RunpageLink = "No."=FIELD("No.");
                      RunObject = Page 6013;
                  }
                  action("Resource A&vailability")
                  {
                      ApplicationArea = Basic;
                      Caption = 'Resource A&vailability';
                      RunpageLink = "No."=FIELD("No."),
                                    "Unit of Measure Filter"=FIELD(Base Unit of Measure),
                                    Chargeable "Filter"=FIELD(Chargeable "Filter");
                      RunObject = Page 8004171;
                  }
                  separator(Action17)
                  {
                  }*/
                /*GL2024  action("Job Budget")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Job Budget';
                       RunObject = Page 212;
                       Visible = false;
                   }*/
            }
        }
        area(processing)
        {
            action("Data Refresh")
            {
                ApplicationArea = Basic;
                Caption = 'Data Refresh';

                ToolTip = 'Data Refresh';

                trigger OnAction()
                var
                    lCreateJobJnlLine: Codeunit 8004000;
                begin
                    wJobJnlTmp.Reset;
                    wJobJnlTmp.DeleteAll;
                    lCreateJobJnlLine.wInsertTmpJnlLine(wJobJnlTmp);
                    CurrPage.Update;
                end;
            }
            action("Previous Set")
            {
                ApplicationArea = Basic;
                Caption = 'Previous Set';
                Image = PreviousSet;

                ToolTip = 'Previous Set';

                trigger OnAction()
                begin
                    SetColumns(Setwanted::Previous);
                end;
            }
            action("Previous Column")
            {
                ApplicationArea = Basic;
                Caption = 'Previous Column';
                Image = PreviousRecord;

                ToolTip = 'Previous Column';

                trigger OnAction()
                begin
                    SetColumns(Setwanted::PreviousColumn);
                end;
            }
            action("Next Column")
            {
                ApplicationArea = Basic;
                Caption = 'Next Column';
                Image = NextRecord;

                ToolTip = 'Next Column';

                trigger OnAction()
                begin
                    SetColumns(Setwanted::NextColumn);
                end;
            }
            action("Next Set")
            {
                ApplicationArea = Basic;
                Caption = 'Next Set';
                Image = NextSet;

                ToolTip = 'Next Set';

                trigger OnAction()
                begin
                    SetColumns(Setwanted::Next);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        lIndex: Integer;
    begin
        lIndex := 0;
        while (lIndex < CurrSetLength) do begin
            lIndex += 1;
            MATRIX_OnAfterGetRecord(lIndex);
        end;
    end;

    trigger OnOpenPage()
    var
        lWT: Record 200;
        lCreateJobJnlLine: Codeunit 8004000;
    begin
        lWT.SetFilter("Work Time Type", '%1|%2|%3', lWT."work time type"::"Producted Hours",
                       lWT."work time type"::"Unproduced Hours", lWT."work time type"::"Absence Hours");
        if lWT.Find('-') then
            repeat
                if FiltreWT <> '' then
                    FiltreWT += '|';
                FiltreWT += lWT.Code;
            until lWT.Next = 0;
        rec.SetFilter("Work Type Filter", FiltreWT);
        FiltreTypeTravail := '';
        FiltreValide := Filtrevalide::All;
        if PlanningSetup.ReadPermission then
            PlanningSetup.Get
        else
            if PrincCal.Find('-') then;

        lCreateJobJnlLine.wSetTempRec(true);
        lCreateJobJnlLine.wInsertTmpJnlLine(wJobJnlTmp);

        SetColumns(Setwanted::Initial);
    end;

    var
        JobsInternalSaleSetup: Record 8003900;
        PlanningSetup: Record 8004133;
        PrincCal: Record 7600;
        wJobJnlTmp: record 210 temporary;
        PeriodFormMgt: Codeunit PeriodPageManagement;
        CalendarMgmt: Codeunit "Calendar Management";
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        QtyType: Option "Net Change","Balance at Date";
        FiltreType: Option " ",Person,Machine;
        FiltreValide: Option All,Posted,Journal;
        FiltreWT: Text[250];
        FiltreHeures: Text[250];
        FiltreTypeTravail: Text[30];
        KO: Boolean;
        Text8003901: label 'The filter is unavailable.';
        Text8003900: label 'Working time setup incorrect for %1.';
        wPlanningQty: Decimal;
        "---------": Integer;
        ColumnValue: array[12] of Decimal;
        gMatrixPeriods: array[32] of Record Date;
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        CurrSetLength: Integer;
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        [InDataSet]
        Field1Emphasize: Boolean;
        [InDataSet]
        Field2Emphasize: Boolean;
        [InDataSet]
        Field3Emphasize: Boolean;
        [InDataSet]
        Field4Emphasize: Boolean;
        [InDataSet]
        Field5Emphasize: Boolean;
        [InDataSet]
        Field6Emphasize: Boolean;
        [InDataSet]
        Field7Emphasize: Boolean;
        [InDataSet]
        Field8Emphasize: Boolean;
        [InDataSet]
        Field9Emphasize: Boolean;
        [InDataSet]
        Field10Emphasize: Boolean;
        [InDataSet]
        Field11Emphasize: Boolean;
        [InDataSet]
        Field12Emphasize: Boolean;

    local procedure SetDateFilter(pColumnID: Integer)
    var
        ResLocTmp: Record 156 temporary;
        lCreateJobJnlLine: Codeunit 8004000;
    begin
        if QtyType = Qtytype::"Net Change" then
            if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
                rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start")
            else
                rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End")
        else
            rec.SetRange("Date Filter", 0D, gMatrixPeriods[pColumnID]."Period End");
        //CALCFIELDS("Usage (Qty.)","Working Time");
        rec.CalcFields("Usage (Qty.)");

        wPlanningQty := lCreateJobJnlLine.wCalcQtyPerRes(Rec, wJobJnlTmp);

        if FiltreValide = Filtrevalide::Posted then
            wPlanningQty := 0;
        if FiltreValide = Filtrevalide::Journal then
            rec."Usage (Qty.)" := 0;
        KO := false;
        if FiltreHeures <> '' then begin
            ResLocTmp.Copy(Rec);    //Table temporaire
            ResLocTmp.Insert;
            ResLocTmp.CalcFields("Usage (Qty.)");
            if FiltreValide = Filtrevalide::Posted then
                ResLocTmp."Working Time" := 0;
            if FiltreValide = Filtrevalide::Journal then
                ResLocTmp."Usage (Qty.)" := 0;
            ResLocTmp."Unit Cost" := wPlanningQty + ResLocTmp."Usage (Qty.)";
            ResLocTmp.Modify;
            ResLocTmp.SetFilter("Unit Cost", FiltreHeures);
            KO := not ResLocTmp.IsEmpty;
        end;
        case FiltreType of
            Filtretype::" ":
                rec.SetRange(Type);
            Filtretype::Person:
                rec.SetRange(Type, rec.Type::Person);
            Filtretype::Machine:
                rec.SetRange(Type, rec.Type::Machine);
            else
                ;
        end;
    end;


    procedure SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";
        DateFilter: Text[30];
        lIndex: Integer;
    begin
        MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ArrayLen(ColumnValue), false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, gMatrixPeriods);
        for lIndex := 1 to CurrSetLength do begin
            fSetCaption(gMatrixPeriods[lIndex], MatrixColumnCaptions[lIndex]);
        end;
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin
        SetDateFilter(ColumnID);
        ColumnValue[ColumnID] := rec."Usage (Qty.)" + wPlanningQty;
        //fSetFormatField(ColumnID);
    end;


    procedure MatrixOnDrillDown(ColumnID: Integer)
    var
        lRes: Record 156;
    //GL2024     lForm: page 8004002;
    begin
        lRes.Copy(Rec);
        lRes.SetRange("No.", rec."No.");
        //GL2024 lForm.SetTableview(lRes);
        //GL2024  lForm.InitForm(FiltreValide);
        //GL2024   lpage.RunModal;
    end;


    procedure fSetCaption(var pDate: Record Date; var pCaption: Text[255])
    var
        lForeColor: Integer;
        lPlanningMgt: Codeunit 8004130;
    begin
        if PeriodType = Periodtype::Day then begin
            if PlanningSetup.ReadPermission then begin
                lPlanningMgt.DateTitle(pDate, pCaption, lForeColor);
                if lForeColor <> 0 then begin
                    pDate.Mark(true);
                end;
            end;
        end;
    end;


    procedure fSetFormatField(pColumnID: Integer)
    begin
        case (pColumnID) of
            1:
                Field1Emphasize := KO;
            2:
                Field2Emphasize := KO;
            3:
                Field3Emphasize := KO;
            4:
                Field4Emphasize := KO;
            5:
                Field5Emphasize := KO;
            6:
                Field6Emphasize := KO;
            7:
                Field7Emphasize := KO;
            8:
                Field8Emphasize := KO;
            9:
                Field9Emphasize := KO;
            10:
                Field10Emphasize := KO;
            11:
                Field11Emphasize := KO;
            12:
                Field12Emphasize := KO;
        end;
    end;

    local procedure FiltreValideOnAfterValidate()
    begin
        //SetDateFilter;
        CurrPage.Update;
    end;

    local procedure FiltreTypeOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure ColumnValue1OnActivate()
    begin
        SetDateFilter(1);
    end;

    local procedure ColumnValue2OnActivate()
    begin
        SetDateFilter(2);
    end;

    local procedure ColumnValue3OnActivate()
    begin
        SetDateFilter(3);
    end;

    local procedure ColumnValue4OnActivate()
    begin
        SetDateFilter(4);
    end;

    local procedure ColumnValue5OnActivate()
    begin
        SetDateFilter(5);
    end;

    local procedure ColumnValue6OnActivate()
    begin
        SetDateFilter(6);
    end;

    local procedure ColumnValue7OnActivate()
    begin
        SetDateFilter(7);
    end;

    local procedure ColumnValue8OnActivate()
    begin
        SetDateFilter(8);
    end;

    local procedure ColumnValue9OnActivate()
    begin
        SetDateFilter(9);
    end;

    local procedure ColumnValue10OnActivate()
    begin
        SetDateFilter(10);
    end;

    local procedure ColumnValue11OnActivate()
    begin
        SetDateFilter(11);
    end;

    local procedure ColumnValue12OnActivate()
    begin
        SetDateFilter(12);
    end;
}

