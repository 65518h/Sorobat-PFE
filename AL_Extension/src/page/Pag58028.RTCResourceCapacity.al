Page 58028 "RTC Resource Capacity"
{
    // //POINTAGE GESWAY 28/08/02 Bouton Planning : "Budget chantier" en Visible NO
    // //OUVRAGE GESWAY 13/03/03 Avoir la fiche qui correspond au type
    // //PLANNING MB 25/04/06 Couleur des titre de colonne en fonction des jour chomés

    Caption = 'Resource Capacity';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = 156;
    SourceTableView = sorting(Type, "No.")
                      where(Type = filter(<> Structure));

    layout
    {
        area(content)
        {
            group("Matrix Options")
            {
                Caption = 'Matrix Options';
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = Basic;
                    Caption = 'View by';
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
                    Caption = 'View as';
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
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[1];
                    DecimalPlaces = 0 : 5;
                }
                field(Field2; ColumnValue[2])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[2];
                    DecimalPlaces = 0 : 5;
                }
                field(Field3; ColumnValue[3])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[3];
                    DecimalPlaces = 0 : 5;
                }
                field(Field4; ColumnValue[4])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[4];
                    DecimalPlaces = 0 : 5;
                }
                field(Field5; ColumnValue[5])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[5];
                    DecimalPlaces = 0 : 5;
                }
                field(Field6; ColumnValue[6])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[6];
                    DecimalPlaces = 0 : 5;
                }
                field(Field7; ColumnValue[7])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[7];
                    DecimalPlaces = 0 : 5;
                }
                field(Field8; ColumnValue[8])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[8];
                    DecimalPlaces = 0 : 5;
                }
                field(Field9; ColumnValue[9])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[9];
                    DecimalPlaces = 0 : 5;
                }
                field(Field10; ColumnValue[10])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[10];
                    DecimalPlaces = 0 : 5;
                }
                field(Field11; ColumnValue[11])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[11];
                    DecimalPlaces = 0 : 5;
                }
                field(Field12; ColumnValue[12])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[12];
                    DecimalPlaces = 0 : 5;
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
            group("Plan&ning1")
            {
                Caption = 'Plan&ning';
                actionref("&Set Capacity1"; "&Set Capacity") { }

            }

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
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        case rec.Type of
                            rec.Type::Person:
                                Page.RunModal(Page::"Resource Card", Rec);
                            //GL2024    rec.Type::Machine: Page.RunModal(Page::"Machine Resource",Rec);
                            //GL2024   rec.Type::Structure: Page.RunModal(Page::"Structure Card",Rec);
                            else
                                ;
                        end;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;

                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Unit of Measure Filter" = FIELD("Unit of Measure Filter"), "Chargeable Filter" = FIELD("Chargeable Filter");
                    RunObject = Page 223;
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunPageLink = "Table Name" = CONST(Resource), "No." = FIELD("No.");
                    RunObject = Page 124;
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunPageLink = "Table ID" = CONST(156), "No." = FIELD("No.");
                    RunObject = Page 540;
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    RunPageLink = "Resource No." = FIELD("No.");
                    RunPageView = SORTING("Resource No.");
                    RunObject = Page 202;
                    ShortCutKey = 'Ctrl+F7';
                }
            }
            group("&Prices")
            {
                Caption = '&Prices';
                /*GL2024 action(Costs)
                 {
                     ApplicationArea = Basic;
                     Caption = 'Costs';
                     Image = ResourceCosts;
                     RunPageLink = Type=CONST(Resource),Code="FIELD"(No.);
                     RunObject = Page 8004165;
                 }*/
                action(Prices)
                {
                    ApplicationArea = Basic;
                    Caption = 'Prices';
                    Image = ResourcePrice;
                    RunPageLink = Type = CONST(Resource), Code = FIELD("No.");
                    RunObject = Page 204;
                }
            }
            group("Plan&ning")
            {
                Caption = 'Plan&ning';
                action("&Set Capacity")
                {
                    ApplicationArea = Basic;
                    Caption = '&Set Capacity';
                    RunPageLink = "No." = FIELD("No.");
                    RunObject = Page 6013;
                }
                /*GL2024  action("Resource A&vailability")
                  {
                      ApplicationArea = Basic;
                      Caption = 'Resource A&vailability';
                      RunPageLink = No.="FIELD"(No.),Unit of Measure "Filter"="FIELD"(Unit of Measure "Filter"),Chargeable "Filter"="FIELD"(Chargeable "Filter");
                      RunObject = Page 8004171;
                  }*/
            }
        }
        area(processing)
        {
            action("Previous Set")
            {
                ApplicationArea = Basic;
                Caption = 'Previous Set';
                Image = PreviousSet;

                ToolTip = 'Previous Set';

                trigger OnAction()
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
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
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
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
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
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
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
                begin
                    SetColumns(Setwanted::Next);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetColumns(Setwanted::Initial);
    end;

    var
        PeriodFormMgt: Codeunit PeriodPageManagement;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        QtyType: Option "Net Change","Balance at Date";
        PlanningSetup: Record 8004133;
        PlanningMgt: Codeunit 8004130;
        "-----": Integer;
        gQtyPlanning: Decimal;
        ColumnValue: array[12] of Decimal;
        gMatrixPeriods: array[32] of Record Date;
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        CurrSetLength: Integer;
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        gColumnIndex: Integer;

    local procedure SetDateFilter(pColumnID: Integer)
    begin
        if QtyType = Qtytype::"Net Change" then
            if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
                rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start")
            else
                rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End")
        else
            rec.SetRange("Date Filter", 0D, gMatrixPeriods[pColumnID]."Period End");
    end;


    procedure SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit 9200;
        DateFilter: Text[30];
        lIndex: Integer;
    begin
        MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ArrayLen(ColumnValue), false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, gMatrixPeriods);
        for lIndex := 1 to CurrSetLength do begin
            fFormatCaption(MatrixColumnCaptions[lIndex], gMatrixPeriods[lIndex]);
        end;
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin
        SetDateFilter(ColumnID);
        rec.CalcFields(Capacity);
        //wJob.CALCFIELDS("Period Planning Quantity");
        ColumnValue[ColumnID] := Rec.Capacity;
    end;


    procedure fFormatCaption(var pCaption: Text[255]; var pDate: Record Date)
    var
        lForeColor: Integer;
    begin
        if PeriodType = Periodtype::Day then begin
            PlanningMgt.DateTitle(pDate, pCaption, lForeColor);
            if lForeColor <> 0 then begin
                pDate.Mark(true);
            end;
        end;
    end;
}

