Page 58030 "RTC Planning Task Matrix"
{
    // #8225 AC 15/09/10
    // //PLANNING_TASK CW 18/08/09 Planning

    Caption = 'RTC Planning Task Matrix';
    DataCaptionExpression = FormCaption;
    //GL2024 DataCaptionFields = Field8004104;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Planning Task Buffer";
    SourceTableTemporary = true;
    SourceTableView = sorting("Project Header No.", "WBS Code", "Task No.");

    layout
    {
        area(content)
        {
            group(Display)
            {
                Caption = 'Display';
                field(ShowOption; ShowOption)
                {
                    ApplicationArea = Basic;
                    Caption = 'Show';
                    // DecimalPlaces = 0:2;
                    OptionCaption = 'Work Load (h),Description,Resource Name,Resource No.,,,Count';

                    trigger OnValidate()
                    begin
                        ShowOptionOnAfterValidate;
                    end;
                }
                field("Resource Group Filter"; rec."Resource Group Filter")
                {
                    ApplicationArea = Basic;
                    LookuppageID = "Resource Groups";
                }
                field(wShowDetail; wShowDetail)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(wNbLine; wNbLine)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            group(Options)
            {
                Caption = 'Options';
                group("Matrix Options")
                {
                    Caption = 'Matrix Options';
                    field(PeriodType; PeriodType)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period';
                        OptionCaption = 'Day,Week,Month,Quarter,Year';

                        trigger OnValidate()
                        begin
                            MATRIX_SetColumns(0);
                        end;
                    }
                    field(CaptionSet; CaptionSet)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Column Set';
                        Editable = false;
                    }
                }
            }
            repeater(Control800413002)
            {
                ShowCaption = false;
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                field(Indentation; rec.Indentation)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Job Task No."; rec."Job Task No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Version No."; rec."Version No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Person Responsible"; rec."Person Responsible")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Work Load (h)"; rec."Work Load (h)")
                {
                    ApplicationArea = Basic;
                }
                field("Person Posted Time (h)"; rec."Person Posted Time (h)")
                {
                    ApplicationArea = Basic;
                }
                field("Planned Time (h)"; rec."Planned Time (h)")
                {
                    ApplicationArea = Basic;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Field1; ColumnValue[1])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[1];
                    Editable = Field1Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(1);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(1);
                    end;
                }
                field(Field2; ColumnValue[2])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[2];
                    Editable = Field2Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(2);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(2);
                    end;
                }
                field(Field3; ColumnValue[3])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[3];
                    Editable = Field3Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(3);
                    end;

                    trigger OnValidate()
                    begin
                        ColumnValue3OnAfterValidate;
                    end;
                }
                field(Field4; ColumnValue[4])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[4];
                    Editable = Field4Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(4);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(4);
                    end;
                }
                field(Field5; ColumnValue[5])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[5];
                    Editable = Field5Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(5);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(5);
                    end;
                }
                field(Field6; ColumnValue[6])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[6];
                    Editable = Field6Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(6);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(6);
                    end;
                }
                field(Field7; ColumnValue[7])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[7];
                    Editable = Field7Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(7);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(7);
                    end;
                }
                field(Field8; ColumnValue[8])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[8];
                    Editable = Field8Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(8);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(8);
                    end;
                }
                field(Field9; ColumnValue[9])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[9];
                    Editable = Field9Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(9);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(9);
                    end;
                }
                field(Field10; ColumnValue[10])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[10];
                    Editable = Field10Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(10);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(10);
                    end;
                }
                field(Field11; ColumnValue[11])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[11];
                    Editable = Field11Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(11);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(11);
                    end;
                }
                field(Field12; ColumnValue[12])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[12];
                    Editable = Field12Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(12);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(12);
                    end;
                }
                field(Field13; ColumnValue[13])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[13];
                    Editable = Field13Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(13);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(13);
                    end;
                }
                field(Field14; ColumnValue[14])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[14];
                    Editable = Field14Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(14);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(14);
                    end;
                }
                field(Field15; ColumnValue[15])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[15];
                    Editable = Field15Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(15);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(15);
                    end;
                }
                field(Field16; ColumnValue[16])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[16];
                    Editable = Field16Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(16);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(16);
                    end;
                }
                field(Field17; ColumnValue[17])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[17];
                    Editable = Field17Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(17);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(17);
                    end;
                }
                field(Field18; ColumnValue[18])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[18];
                    Editable = Field18Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(18);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(18);
                    end;
                }
                field(Field19; ColumnValue[19])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[19];
                    Editable = Field19Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(19);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(19);
                    end;
                }
                field(Field20; ColumnValue[20])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[20];
                    Editable = Field20Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(20);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(20);
                    end;
                }
                field(Field21; ColumnValue[21])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[21];
                    Editable = Field21Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(21);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(21);
                    end;
                }
                field(Field22; ColumnValue[22])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[22];
                    Editable = Field22Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(22);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(22);
                    end;
                }
                field(Field23; ColumnValue[23])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[23];
                    Editable = Field23Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(23);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(23);
                    end;
                }
                field(Field24; ColumnValue[24])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[24];
                    Editable = Field24Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(24);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(24);
                    end;
                }
                field(Field25; ColumnValue[25])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[25];
                    Editable = Field25Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(25);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(25);
                    end;
                }
                field(Field26; ColumnValue[26])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[26];
                    Editable = Field26Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(26);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(26);
                    end;
                }
                field(Field27; ColumnValue[27])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[27];
                    Editable = Field27Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(27);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(27);
                    end;
                }
                field(Field28; ColumnValue[28])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[28];
                    Editable = Field28Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(28);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(28);
                    end;
                }
                field(Field29; ColumnValue[29])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[29];
                    Editable = Field29Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(29);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(29);
                    end;
                }
                field(Field30; ColumnValue[30])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[30];
                    Editable = Field30Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(30);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(30);
                    end;
                }
                field(Field31; ColumnValue[31])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[31];
                    Editable = Field31Editable;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(31);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(31);
                    end;
                }
            }

        }
    }

    actions
    {
        area(Promoted)
        {
            group(Task1)
            {
                Caption = 'Task';
                actionref(Reports1; Reports) { }

            }
            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("Expand All1"; "Expand All") { }
                actionref("Collapse All1"; "Collapse All") { }
                actionref("Link Document1"; "Link Document") { }
                actionref("Suggest from Document1"; "Suggest from Document") { }
                actionref("Show Document1"; "Show Document") { }
                actionref("Connecteur MS-Project1"; "Connecteur MS-Project") { }
                actionref("PlanningForce Connector1"; "PlanningForce Connector") { }

            }
            actionref("Previous Set1"; "Previous Set") { }
            actionref("Previous Column1"; "Previous Column") { }
            actionref("Next Column1"; "Next Column") { }
            actionref("Next Set1"; "Next Set") { }
        }
        area(navigation)
        {
            group(Task)
            {
                Caption = 'Task';
                /*GL2024   group(Ordonnancement)
                   {
                       Caption = 'Ordonnancement';
                       action(Predecessors)
                       {
                           ApplicationArea = Basic;
                           Caption = 'Predecessors';
                           RunpageLink = Project Header="FIELD"(Project Header No.),Task No.="FIELD"(Task No.);
                           RunObject = Page 8004149;
                       }
                       action(Antecedents)
                       {
                           ApplicationArea = Basic;
                           Caption = 'Antecedents';
                           RunpageLink = Project Header="FIELD"(Project Header No.),Task No. Predecessor="FIELD"(Task No.);
                           RunObject = Page 8004149;
                       }
                   }*/
                action(Reports)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reports';

                    trigger OnAction()
                    var
                        lReportList: Record 8001428;
                        lId: Integer;
                        lRecRef: RecordRef;
                    begin
                        with lReportList do begin
                            Evaluate(lId, CopyStr(CurrPage.ObjectId(false), 6));
                            lRecRef.GetTable(Rec);
                            lRecRef.SetRecfilter;
                            SetRecordRef(lRecRef, true);
                            ShowList(lId);
                        end;
                    end;
                }
                /*GL2024   separator(Action65)
                    {
                        Caption = '-';
                    }
                    action("Planning Detail")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Planning Detail';
                        RunpageLink = Project Header No.="FIELD"(Project Header No.),Planning Task No.="FIELD"(Task No.);
                        RunpageView = SORTING(Job No., Job Task No., Date);
                        RunObject = Page 8004130;
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("Ledger Entries")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ledger Entries';
                        RunpageLink = Project Header No.="FIELD"(Project Header No.),Planning Task No.="FIELD"(Task No.);
                        RunpageView = SORTING(Job No., Job Task No., Entry Type, Posting Date);
                        RunObject = Page 8004162;
                    }*/
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Expand All")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expand All';

                    trigger OnAction()
                    begin
                        PlanningMgt.ExpandAll(Rec, true);
                        CurrPage.Update;
                    end;
                }
                action("Collapse All")
                {
                    ApplicationArea = Basic;
                    Caption = 'Collapse All';

                    trigger OnAction()
                    begin
                        PlanningMgt.ExpandAll(Rec, false);
                        CurrPage.Update;
                    end;
                }
                action("Link Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Link Document';

                    trigger OnAction()
                    var
                        lRec: Record 8001577;
                    begin
                        lRec.TransferFields(Rec, true);
                        RecordIDMgt.Lookup(lRec);
                    end;
                }
                action("Suggest from Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest from Document';

                    trigger OnAction()
                    var
                        ltRecordIDFilter: label 'Document must be define as filter %1.';
                        ltContinue: label 'Tasks are already defined for this document. Do you wish to continue?';
                        lRecordID: RecordID;
                    begin
                        if rec.GetFilter("Source Record ID") = '' then
                            Error(ltRecordIDFilter, rec.FieldCaption("Source Record ID"));
                        if not rec.IsEmpty then
                            if not Confirm(ltContinue, false) then
                                exit;
                        //EVALUATE(lJobTask."Source Record ID",GETFILTER("Source Record ID"));
                        Evaluate(lRecordID, rec.GetFilter("Source Record ID"));
                        //lRecordRef.GET(lJobTask."Source Record ID");
                        //RecordIDMgt.suggest(lJobTask."Source Record ID");
                        if RecordIDMgt.Suggest(lRecordID) then
                            PlanningMgt.InitTempTable(Rec);
                    end;
                }
                action("Show Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show Document';
                    Image = View;

                    trigger OnAction()
                    begin
                        RecordIDMgt.Show(rec."Source Record ID");
                    end;
                }
                action("Connecteur MS-Project")
                {
                    ApplicationArea = Basic;
                    Caption = 'Connecteur MS-Project';
                    RunObject = Codeunit 8004143;
                }
                action("PlanningForce Connector")
                {
                    ApplicationArea = Basic;
                    Caption = 'PlanningForce Connector';
                    RunObject = Codeunit 8001553;
                }
            }
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
                    MATRIX_SetColumns(Matrix_setwanted::Previous);
                    MATRIX_RefreshData();
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
                    MATRIX_SetColumns(Matrix_setwanted::PreviousColumn);
                    MATRIX_RefreshData();
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
                    MATRIX_SetColumns(Matrix_setwanted::NextColumn);
                    MATRIX_RefreshData();
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
                    MATRIX_SetColumns(Matrix_setwanted::Next);
                    MATRIX_RefreshData();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        lRec: Record 8001577;
        lWBSMgt: Codeunit 8001554;
    begin
        DescriptionIndent := 0;
        //SETFILTER("WBS Code",'<>%1','');
        if PlanningMgt.IsExpanded(Rec) then
            ExpansionStatus := Expansionstatus::Collapse
        else if PlanningMgt.IsCollapsed(Rec) then
            ExpansionStatus := Expansionstatus::Expand
        else
            ExpansionStatus := 0;

        //GetFields(Rec);

        //Affichage de la charge
        rec.CalcFields("Work Load (h)", Status);
        if rec.Type = rec.Type::"Group Task" then begin
            lRec.TransferFields(Rec, true);
            rec.SetFilter("WBS Code Filter", lWBSMgt.gGetFilter(lRec));
            rec.CalcFields("Work Load Totaling (h)");
            rec."Work Load (h)" := rec."Work Load Totaling (h)";
        end;
        gDuration := gProjectPlan.fDec2Duration(rec."Work Load (h)", gPlanningSetup."Def. Hours per Day");
        MATRIX_RefreshData();
        Form_FontBold := rec.Type in [rec.Type::" ", rec.Type::"Group Task"];
        OnAfterGetCurrRecord;
        DescriptionOnFormat;
        ColumnValue1OnFormat;
        ColumnValue2OnFormat;
        ColumnValue3OnFormat;
        ColumnValue4OnFormat;
        ColumnValue5OnFormat;
        ColumnValue6OnFormat;
        ColumnValue7OnFormat;
        ColumnValue8OnFormat;
        ColumnValue9OnFormat;
        ColumnValue10OnFormat;
        ColumnValue11OnFormat;
        ColumnValue12OnFormat;
        ColumnValue13OnFormat;
        ColumnValue14OnFormat;
        ColumnValue15OnFormat;
        ColumnValue16OnFormat;
        ColumnValue17OnFormat;
        ColumnValue18OnFormat;
        ColumnValue19OnFormat;
        ColumnValue20OnFormat;
        ColumnValue21OnFormat;
        ColumnValue22OnFormat;
        ColumnValue23OnFormat;
        ColumnValue24OnFormat;
        ColumnValue25OnFormat;
        ColumnValue26OnFormat;
        ColumnValue27OnFormat;
        ColumnValue28OnFormat;
        ColumnValue29OnFormat;
        ColumnValue30OnFormat;
        ColumnValue31OnFormat;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        lRec: Record 8001577;
    begin
        lRec.TransferFields(Rec, true);
        Rec.TransferFields(lRec, true);
    end;

    trigger OnInit()
    begin
        Field31Editable := true;
        Field30Editable := true;
        Field29Editable := true;
        Field28Editable := true;
        Field27Editable := true;
        Field26Editable := true;
        Field25Editable := true;
        Field24Editable := true;
        Field23Editable := true;
        Field22Editable := true;
        Field21Editable := true;
        Field20Editable := true;
        Field19Editable := true;
        Field18Editable := true;
        Field17Editable := true;
        Field16Editable := true;
        Field15Editable := true;
        Field14Editable := true;
        Field13Editable := true;
        Field12Editable := true;
        Field11Editable := true;
        Field10Editable := true;
        Field9Editable := true;
        Field8Editable := true;
        Field7Editable := true;
        Field6Editable := true;
        Field5Editable := true;
        Field4Editable := true;
        Field3Editable := true;
        Field2Editable := true;
        Field1Editable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        lRec: Record 8001577;
    begin
        lRec.TransferFields(Rec, true);
        lRec.Insert(true);
        Rec.TransferFields(lRec, true);
    end;

    trigger OnModifyRecord(): Boolean
    var
        lRec: Record 8001577;
    begin
        lRec.TransferFields(Rec, true);
        lRec.Modify(true);
        Rec.TransferFields(lRec, true);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        lRec: Record 8001577;
        lxRec: Record 8001577;
        lProjectPlanMgt: Codeunit 8001554;
    begin
        Evaluate(rec."Source Record ID", rec.GetFilter("Source Record ID"));
        lRec.TransferFields(Rec, true);
        lxRec."Task No." := xRec."Task No.";
        lxRec."Project Header No." := xRec."Project Header No.";
        lxRec."WBS Code" := xRec."WBS Code";
        lxRec."Job No." := xRec."Job No.";
        lxRec."Source Record ID" := xRec."Source Record ID";
        lxRec."Source Line No." := xRec."Document Line No.";
        lxRec.Indentation := xRec.Indentation;
        lxRec."Attached To Task No." := xRec."Attached To Task No.";
        lProjectPlanMgt.OnNewRecord(lRec, lxRec, BelowxRec, false);
        Rec.TransferFields(lRec, true);
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        QtyType := Qtytype::"Net Change";
        PlanningMgt.Setup;
        PlanningMgt.InitTempTable(Rec);
        PlanningMgt.ExpandAll(Rec, true);
        if rec.FindFirst then;
        gPlanningSetup.Get;
        MATRIX_CurrSetLength := 31;
        MATRIX_SetColumns(Periodtype::Day);
    end;

    var
        Default: Record 8004130;
        HoldPlanning: Record 8004130;
        PeriodFormMgt: Codeunit PeriodPageManagement;
        PlanningMgt: Codeunit 8004130;
        CalendarMgt: Codeunit 7600;
        PeriodType: Option Day,Week,Month,Quarter,Year,FiscalYear;
        QtyType: Option "Net Change","Balance at Date";
        ShowOption: Option Quantity,Description,"Resource Name","Resource No.","Job Name","Job No.","Count",Capacity,Availability,"Load %";
        tMustBeUnique: label '%1 must be alone.';
        Cut: Boolean;
        DocumentTypeFilter: Option All,Quote,"Order",Invoice,"Credit Memo";
        PersonResponsibleFilter: Text[250];
        ResourceGroupFilter: Text[250];
        JobTaskMgt: Codeunit 8004140;
        tResourceGroup: label '%1 a un groupe ressource différent de %2';
        PlanningEntry: Record 8004130;
        RecordIDMgt: Codeunit 8004141;
        tNoAssignment: label 'No resource assigned';
        ExpansionStatus: Option ,Expand,Collapse;
        tPosted: label 'can''t be Posted';
        gDuration: Duration;
        gPlanningSetup: Record 8004133;
        gProjectPlan: Codeunit 8001555;
        gPlanningMgt: Codeunit 8004130;
        wNbLine: Integer;
        wShowDetail: Boolean;
        gResLedgEntry: Record 203;
        "---": InStream;
        ColumnValue: array[32] of Text[1024];
        MatrixColumnCaptions: array[32] of Text[1024];
        CurrSetLength: Integer;
        gPeriodIndex: Integer;
        MatrixRecordRef: RecordRef;
        MatrixRecord: Record 8001578 temporary;
        MatrixRecords: array[32] of Record Date temporary;
        MatrixCaptionFieldNo: Integer;
        "----": Integer;
        CaptionSet: Text[1024];
        MATRIX_SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        MATRIX_CurrSetLength: Integer;
        MATRIX_CellData: array[32] of Text[1024];
        gTempTable: Record 8001578 temporary;
        MATRIX_ForeColor: array[32] of Integer;
        MATRIX_FontBold: array[32] of Boolean;
        MATRIX_Editable: Boolean;
        Form_FontBold: Boolean;
        PKFirstRecInCurrSet: Text[100];
        [InDataSet]
        Field1Editable: Boolean;
        [InDataSet]
        Field2Editable: Boolean;
        [InDataSet]
        Field3Editable: Boolean;
        [InDataSet]
        Field4Editable: Boolean;
        [InDataSet]
        Field5Editable: Boolean;
        [InDataSet]
        Field6Editable: Boolean;
        [InDataSet]
        Field7Editable: Boolean;
        [InDataSet]
        Field8Editable: Boolean;
        [InDataSet]
        Field9Editable: Boolean;
        [InDataSet]
        Field10Editable: Boolean;
        [InDataSet]
        Field11Editable: Boolean;
        [InDataSet]
        Field12Editable: Boolean;
        [InDataSet]
        Field13Editable: Boolean;
        [InDataSet]
        Field14Editable: Boolean;
        [InDataSet]
        Field15Editable: Boolean;
        [InDataSet]
        Field16Editable: Boolean;
        [InDataSet]
        Field17Editable: Boolean;
        [InDataSet]
        Field18Editable: Boolean;
        [InDataSet]
        Field19Editable: Boolean;
        [InDataSet]
        Field20Editable: Boolean;
        [InDataSet]
        Field21Editable: Boolean;
        [InDataSet]
        Field22Editable: Boolean;
        [InDataSet]
        Field23Editable: Boolean;
        [InDataSet]
        Field24Editable: Boolean;
        [InDataSet]
        Field25Editable: Boolean;
        [InDataSet]
        Field26Editable: Boolean;
        [InDataSet]
        Field27Editable: Boolean;
        [InDataSet]
        Field28Editable: Boolean;
        [InDataSet]
        Field29Editable: Boolean;
        [InDataSet]
        Field30Editable: Boolean;
        [InDataSet]
        Field31Editable: Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;
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
        [InDataSet]
        Field13Emphasize: Boolean;
        [InDataSet]
        Field14Emphasize: Boolean;
        [InDataSet]
        Field15Emphasize: Boolean;
        [InDataSet]
        Field16Emphasize: Boolean;
        [InDataSet]
        Field17Emphasize: Boolean;
        [InDataSet]
        Field18Emphasize: Boolean;
        [InDataSet]
        Field19Emphasize: Boolean;
        [InDataSet]
        Field20Emphasize: Boolean;
        [InDataSet]
        Field21Emphasize: Boolean;
        [InDataSet]
        Field22Emphasize: Boolean;
        [InDataSet]
        Field23Emphasize: Boolean;
        [InDataSet]
        Field24Emphasize: Boolean;
        [InDataSet]
        Field25Emphasize: Boolean;
        [InDataSet]
        Field26Emphasize: Boolean;
        [InDataSet]
        Field27Emphasize: Boolean;
        [InDataSet]
        Field28Emphasize: Boolean;
        [InDataSet]
        Field29Emphasize: Boolean;
        [InDataSet]
        Field30Emphasize: Boolean;
        [InDataSet]
        Field31Emphasize: Boolean;

    local procedure SetDateFilter(pColumnID: Integer)
    begin
        if QtyType = Qtytype::"Net Change" then
            if MatrixRecords[pColumnID]."Period Start" = MatrixRecords[pColumnID]."Period End" then
                rec.SetRange("Date Filter", MatrixRecords[pColumnID]."Period Start")
            else
                rec.SetRange("Date Filter", MatrixRecords[pColumnID]."Period Start", MatrixRecords[pColumnID]."Period End")
        else
            rec.SetRange("Date Filter", 0D, MatrixRecords[pColumnID]."Period End");
    end;


    procedure SetCellFilters(pColumnID: Integer; var pPlanning: Record 8004130)
    begin
        pPlanning.SetCurrentkey("Planning Task No.", Date);

        pPlanning.SetRange("Project Header No.", rec."Project Header No.");

        if rec."Task No." <> '' then
            pPlanning.SetRange("Planning Task No.", rec."Task No.");
        if rec.GetFilter("Resource Group Filter") <> '' then
            pPlanning.SetFilter("Resource Group No.", rec.GetFilter("Resource Group Filter"));

        if MatrixRecords[pColumnID]."Period Start" = MatrixRecords[pColumnID]."Period End" then
            pPlanning.SetRange(Date, MatrixRecords[pColumnID]."Period Start")
        else
            pPlanning.SetRange(Date, MatrixRecords[pColumnID]."Period Start", MatrixRecords[pColumnID]."Period End");
    end;


    procedure MatrixUpdate(pQtyType: Integer; pPeriodType: Integer)
    begin
        QtyType := pQtyType;
        PeriodType := pPeriodType;
        CurrPage.Update(false);
    end;


    procedure Paste(pColumnID: Integer; var pPlanning: Record 8004130)
    var
        lJobTaskAssignment: Record 8004141;
    begin
        pPlanning."Job No." := rec."Job No.";
        pPlanning."Planning Task No." := rec."Task No.";
        pPlanning."Prod. Posting Group" := rec."Gen. Prod. Posting Group";
        //pPlanning."Resource Group No." := ;
        pPlanning.Description := rec.Description;

        lJobTaskAssignment.SetRange("Project Header No.", rec."Job No.");
        lJobTaskAssignment.SetRange("Task No.", rec."Task No.");
        if not lJobTaskAssignment.FindSet then
            PlanningMgt.CheckInsert(pPlanning, MatrixRecords[pColumnID]."Period Start", Default)
        else
            repeat
                pPlanning.Validate("No.", lJobTaskAssignment."No.");
                PlanningMgt.CheckInsert(pPlanning, MatrixRecords[pColumnID]."Period Start", Default);
            until lJobTaskAssignment.Next = 0;
    end;


    procedure Filters()
    begin
        if PersonResponsibleFilter = '' then
            rec.SetRange("Person Responsible")
        else
            rec.SetFilter("Person Responsible", PersonResponsibleFilter);

        if ResourceGroupFilter = '' then
            rec.SetRange("Resource Group Filter")
        else
            rec.SetFilter("Resource Group Filter", ResourceGroupFilter);
    end;


    procedure GetFormFilters()
    var
        lStatus: Option All,Planning,Quote,"Order",Completed;
    begin
        PersonResponsibleFilter := rec.GetFilter("Person Responsible");
        ResourceGroupFilter := rec.GetFilter("Resource Group Filter");
    end;


    procedure GetFields(pRec: Record 8001578)
    var
        i: Integer;
        lMoreResources: Boolean;
        lAssignment: Record 8004141;
        lPlanningEntry: Record 8004130;
    begin
        with pRec do begin
            lPlanningEntry.SetCurrentkey("Planning Task No.", Date);
            lPlanningEntry.SetRange("Planning Task No.", rec."Task No.");
            lPlanningEntry.SetFilter(Date, StrSubstNo('%1..', WorkDate));
            if lPlanningEntry.IsEmpty then
                lPlanningEntry.Init
            else
                lPlanningEntry.FindFirst;
        end;
    end;


    procedure ShowPlanning()
    var
        lPlanningEntry: Record 8004130;
        lRecordRef: RecordRef;
    begin
        lPlanningEntry.SetCurrentkey("Planning Task No.", Date);
        lPlanningEntry.SetRange("Planning Task No.", rec."Task No.");
        //GL2024 page.RunModal(page::"Planning Detail", lPlanningEntry);
    end;


    procedure FormCaption(): Text[250]
    var
        lJob: Record job;
        lRecordID: RecordID;
    begin
        if rec.GetFilter("Source Record ID") <> '' then begin
            Evaluate(lRecordID, rec.GetFilter("Source Record ID"));
            exit(RecordIDMgt.Caption(lRecordID));
        end;
        if rec.GetFilter("Job No.") <> '' then
            if lJob.Get(rec.GetFilter("Job No.")) then
                exit(lJob."No." + ' ' + lJob.Description);
    end;


    procedure "--"()
    begin
    end;


    procedure MATRIX_SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit 9200;
        DateFilter: Text[30];
        lIndex: Integer;
    begin
        MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ArrayLen(ColumnValue), false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, CaptionSet, CurrSetLength, MatrixRecords);
        for lIndex := 1 to CurrSetLength do begin
            fFormatCaption(MatrixColumnCaptions[lIndex], MatrixRecords[lIndex]);
        end;
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

    local procedure MATRIX_OnAfterGetRecord(pColumnID: Integer)
    begin
        ColumnValue[pColumnID] := MATRIX_SetValue(pColumnID, MATRIX_ForeColor, MATRIX_FontBold, MATRIX_Editable);
    end;


    procedure MATRIX_OnDrillDown(pColumnID: Integer)
    var
        lPlanningTemp: Record 8004130 temporary;
    begin
        SetCellFilters(pColumnID, lPlanningTemp);
        lPlanningTemp.SetRange(Type);
        //GL2024     page.Run(page::"Planning Detail", lPlanningTemp);
    end;


    procedure MATRIX_SetPeriodIndex(pColumnID: Integer)
    begin
        gPeriodIndex := 0;
    end;


    procedure MATRIX_OnValidate(pColumnID: Integer)
    var
        lPlanning: Record 8004130;
    begin
        if ColumnValue[pColumnID] = '' then begin
            SetCellFilters(pColumnID, lPlanning);
            lPlanning.SetRange(Status, lPlanning.Status::Deleted);
            if not lPlanning.IsEmpty then
                if lPlanning.FindFirst then
                    lPlanning.FieldError(Status, tPosted);
            lPlanning.SetRange(Status);
            lPlanning.DeleteAll(true)
        end else begin
            lPlanning := Default;
            Evaluate(lPlanning.Quantity, ColumnValue[pColumnID]);
            lPlanning.Quantity -= rec."Period Planning Quantity";
            Paste(pColumnID, lPlanning);
        end;
        rec.CalcFields("Planned Time (h)");
    end;


    procedure MATRIX_SetValue(pColumnID: Integer; pForeColor: array[32] of Integer; pFontBold: array[32] of Boolean; pEditable: Boolean) return: Text[1024]
    var
        lPlanning: Record 8004130;
    begin
        SetDateFilter(pColumnID);
        rec.CalcFields("Period Planning Quantity", "Period Person Posted Time (h)");

        if (PeriodType <> Periodtype::Day) or (ShowOption = Showoption::Quantity) then begin
            if rec."Period Planning Quantity" + rec."Period Person Posted Time (h)" = 0 then begin
            end
            else if PeriodType <> Periodtype::Day then
                return := Format(rec."Period Planning Quantity" + rec."Period Person Posted Time (h)", 0, '<Precision,0:0><Standard Format,0>')
            else
                return := Format(rec."Period Planning Quantity" + rec."Period Person Posted Time (h)");
        end else begin
            SetCellFilters(pColumnID, lPlanning);
            if lPlanning.IsEmpty then begin
            end
            else if ShowOption = Showoption::Count then
                return := Format(lPlanning.Count)
            else
                //#8225
                return := PlanningMgt.Description(lPlanning, gResLedgEntry, ShowOption, pForeColor[pColumnID], pFontBold[pColumnID], false);
            //#8225//
        end;
        if (return = '') and MatrixRecords[pColumnID].Mark then
            return := '-----';
        //pFontBold[pColumnID] := Type IN [Type::" ",Type::"Group Task"];
        pEditable := (rec.Type = rec.Type::Task);
    end;


    procedure MATRIX_InitialiseValue(pColumnID: Integer)
    begin
        ColumnValue[pColumnID] := '';
    end;


    procedure MATRIX_RefreshData()
    var
        lIndex: Integer;
    begin
        lIndex := 0;
        while (lIndex < MATRIX_CurrSetLength) do begin
            lIndex += 1;
            MATRIX_OnAfterGetRecord(lIndex);
        end;
        for lIndex := MATRIX_CurrSetLength + 1 to ArrayLen(ColumnValue) do
            ColumnValue[lIndex] := '';
    end;

    local procedure ShowOptionOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure ColumnValue3OnAfterValidate()
    begin
        MATRIX_OnValidate(3);
    end;

    local procedure OnAfterGetCurrRecord()
    var
        lRec: Record 8001577;
    begin
        xRec := Rec;
        //CurrForm.WorkLoad.EDITABLE(Type = Type::Task);
        //CurrForm."Work Load (h)".EDITABLE(Type = Type::Task);
        //CurrForm."Planned Time (h)".EDITABLE(Type = Type::Task);
        MATRIX_Editable := (rec.Status = rec.Status::Release) and not (rec.Type in [rec.Type::" ", rec.Type::"Group Task"]);
        //lRec.TRANSFERFIELDS(Rec,TRUE);
        MATRIX_RefreshData();
        Field1Editable := MATRIX_Editable;
        Field2Editable := MATRIX_Editable;
        Field3Editable := MATRIX_Editable;
        Field4Editable := MATRIX_Editable;
        Field5Editable := MATRIX_Editable;
        Field6Editable := MATRIX_Editable;
        Field7Editable := MATRIX_Editable;
        Field8Editable := MATRIX_Editable;
        Field9Editable := MATRIX_Editable;
        Field10Editable := MATRIX_Editable;
        Field11Editable := MATRIX_Editable;
        Field12Editable := MATRIX_Editable;
        Field13Editable := MATRIX_Editable;
        Field14Editable := MATRIX_Editable;
        Field15Editable := MATRIX_Editable;
        Field16Editable := MATRIX_Editable;
        Field17Editable := MATRIX_Editable;
        Field18Editable := MATRIX_Editable;
        Field19Editable := MATRIX_Editable;
        Field20Editable := MATRIX_Editable;
        Field21Editable := MATRIX_Editable;
        Field22Editable := MATRIX_Editable;
        Field23Editable := MATRIX_Editable;
        Field24Editable := MATRIX_Editable;
        Field25Editable := MATRIX_Editable;
        Field26Editable := MATRIX_Editable;
        Field27Editable := MATRIX_Editable;
        Field28Editable := MATRIX_Editable;
        Field29Editable := MATRIX_Editable;
        Field30Editable := MATRIX_Editable;
        Field31Editable := MATRIX_Editable;
    end;

    local procedure DescriptionOnFormat()
    var
        lIndent: Integer;
    begin
        if rec."Task No." = '' then begin
            //  CurrForm.Description.UPDATESELECTED(TRUE);
            DescriptionEmphasize := true;
        end else begin
            lIndent := rec.Indentation + 1;
            if ISSERVICETIER then begin
            end
            else
                DescriptionIndent := lIndent;
            DescriptionEmphasize := Form_FontBold;
        end;
    end;

    local procedure ColumnValue1OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[1];
        Field1Emphasize := lVarBold;
    end;

    local procedure ColumnValue2OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[2];
        Field2Emphasize := lVarBold;
    end;

    local procedure ColumnValue3OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[3];
        Field3Emphasize := lVarBold;
    end;

    local procedure ColumnValue4OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[4];
        Field4Emphasize := lVarBold;
    end;

    local procedure ColumnValue5OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[5];
        Field5Emphasize := lVarBold;
    end;

    local procedure ColumnValue6OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[6];
        Field6Emphasize := lVarBold;
    end;

    local procedure ColumnValue7OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[7];
        Field7Emphasize := lVarBold;
    end;

    local procedure ColumnValue8OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[8];
        Field8Emphasize := lVarBold;
    end;

    local procedure ColumnValue9OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[9];
        Field9Emphasize := lVarBold;
    end;

    local procedure ColumnValue10OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[10];
        Field10Emphasize := lVarBold;
    end;

    local procedure ColumnValue11OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[11];
        Field11Emphasize := lVarBold;
    end;

    local procedure ColumnValue12OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[12];
        Field12Emphasize := lVarBold;
    end;

    local procedure ColumnValue13OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[13];
        Field13Emphasize := lVarBold;
    end;

    local procedure ColumnValue14OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[14];
        Field14Emphasize := lVarBold;
    end;

    local procedure ColumnValue15OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[15];
        Field15Emphasize := lVarBold;
    end;

    local procedure ColumnValue16OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[16];
        Field16Emphasize := lVarBold;
    end;

    local procedure ColumnValue17OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[17];
        Field17Emphasize := lVarBold;
    end;

    local procedure ColumnValue18OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[18];
        Field18Emphasize := lVarBold;
    end;

    local procedure ColumnValue19OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[19];
        Field19Emphasize := lVarBold;
    end;

    local procedure ColumnValue20OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[20];
        Field20Emphasize := lVarBold;
    end;

    local procedure ColumnValue21OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[21];
        Field21Emphasize := lVarBold;
    end;

    local procedure ColumnValue22OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[22];
        Field22Emphasize := lVarBold;
    end;

    local procedure ColumnValue23OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[23];
        Field23Emphasize := lVarBold;
    end;

    local procedure ColumnValue24OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[24];
        Field24Emphasize := lVarBold;
    end;

    local procedure ColumnValue25OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[25];
        Field25Emphasize := lVarBold;
    end;

    local procedure ColumnValue26OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[26];
        Field26Emphasize := lVarBold;
    end;

    local procedure ColumnValue27OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[27];
        Field27Emphasize := lVarBold;
    end;

    local procedure ColumnValue28OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[28];
        Field28Emphasize := lVarBold;
    end;

    local procedure ColumnValue29OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[29];
        Field29Emphasize := lVarBold;
    end;

    local procedure ColumnValue30OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[30];
        Field30Emphasize := lVarBold;
    end;

    local procedure ColumnValue31OnFormat()
    var
        lVarBold: Boolean;
    begin
        lVarBold := Form_FontBold or MATRIX_FontBold[31];
        Field31Emphasize := lVarBold;
    end;
}

