Page 58008 "_Statictic array display"
{
    // #7071 AC 23/03/09
    // #5075 AC 10/10/07
    // //STATSEXPLORER STATSEXPLORER 20/01/00 Statistic display
    // //STATSEXPLORER STATSEXPLORER 19/07/04 Bug with 3.70A : option was bad in OnFormat

    Caption = 'Statictic array display';
    DataCaptionExpression = Definition.Description;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SaveValues = true;
    UsageCategory = Lists;
    SourceTable = "Statistic array line";
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                group(Option)
                {
                    Caption = 'Option';
                    field(CodeStatistique; CodeStatistique)
                    {
                        ApplicationArea = all;
                        Caption = 'Statistic code';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Definition.FilterGroup(7);
                            Definition.SetRange("Statistic code");
                            Definition.SetRange("Line No.", 9999);
                            Definition.FilterGroup(0);

                            /* GL2024  if Page.RunModal(Page::"Statistic definition", Definition) = Action::LookupOK then begin
                                   CodeStatistique := Definition."Statistic code";
                                   rec.SetRange("Statistic code", CodeStatistique);
                                   fSetFilter();
                                   CurrPage.Update(false);
                               end;*/

                            fSetFilter();
                        end;

                        trigger OnValidate()
                        begin
                            CodeStatistiqueOnAfterValidate;
                        end;
                    }
                }
                group("Matrix Options")
                {
                    Caption = 'Matrix Options';
                    field(MATRIX_CaptionRange; MATRIX_CaptionRange)
                    {
                        ApplicationArea = all;
                        Caption = 'Column Set';
                        Editable = false;
                    }
                }
            }
            repeater(Control1100287002)
            {
                Editable = false;
                IndentationColumn = DescriptionIndent;
                IndentationControls = "Code";
                ShowCaption = false;
                field("Code"; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field1Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field2Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field3Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field4Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field5Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[6];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field6Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[7];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field7Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[8];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field8Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[9];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field9Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[10];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field10Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[11];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field11Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[12];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field12Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[13];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field13Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[14];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field14Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[15];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field15Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[16];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field16Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[17];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field17Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[18];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field18Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[19];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field19Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[20];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field20Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[21];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field21Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[22];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field22Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[23];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field23Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[24];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field24Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[25];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field25Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[26];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field26Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[27];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field27Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[28];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field28Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[29];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field29Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[30];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field30Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[31];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field31Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = all;
                    //GL2024 //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[32];
                    //GL2024 DecimalPlaces = 0 : 5;
                    Visible = Field32Visible;

                    trigger OnAssistEdit()
                    begin
                        wAssistEdit();
                    end;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {


            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("Process statistic1"; "Process statistic") { }
                actionref("Process standard statistic1"; "Process standard statistic") { }
                actionref("Delete statistics1"; "Delete statistics") { }
            }

            actionref("Previous Set1"; "Previous Set") { }
            actionref("Next Set1"; "Next Set") { }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Process statistic")
                {
                    ApplicationArea = all;
                    Caption = 'Process statistic';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //GL2024  Report.RunModal(Report::"Process statistic array");
                        if Definition.Get(UserId, '', 0) then
                            CodeStatistique := Definition.Description;
                        wOuverture;
                    end;
                }
                action("Process standard statistic")
                {
                    ApplicationArea = all;
                    Caption = 'Process standard statistic';

                    trigger OnAction()
                    begin
                        //GL2024  Report.RunModal(Report::"Process standard statistic");
                        if Definition.Get(UserId, '', 0) then
                            CodeStatistique := Definition.Description;
                        wOuverture;
                    end;
                }
                /*   //GL2024  action("&Definition")
                   {
                       ApplicationArea = all;
                       Caption = '&Definition';

                       trigger OnAction()
                       begin
                           page.RunModal(page::"Statistic definition", Definition);
                       end;
                   }*/
                /* GL2024 action(Forward)
                  {
                      ApplicationArea = all;
                      Caption = 'Forward';

                      trigger OnAction()
                      begin
                          if page.RunModal(page::Users, Users) = Action::LookupOK then begin
                              wForward;
                          end;
                      end;
                  }*/
                separator(Action16)
                {
                }
                /*  action("Send to Excel")
                 {
                     ApplicationArea = all;
                     Caption = 'Send to Excel';

                    trigger OnAction()
                     var
                         ReportExcel: Report 8001307;
                     begin
                         //#8489
                         ReportExcel.InitRequete(CodeStatistique, 1, false, '', '', UserId, false, false, false, '');
                         //#8489//
                         ReportExcel.RunModal;
                     end;
                 }*/
                separator(Action8)
                {
                }
                action("Delete statistics")
                {
                    ApplicationArea = all;
                    Caption = 'Delete statistics';

                    trigger OnAction()
                    var
                        Definition2: Record "Statistic definition";
                    //GL2024   ReportPurge: Report 8001312;
                    begin
                        //GL2024   ReportPurge.InitRequete(CodeStatistique);
                        //GL2024   ReportPurge.RunModal;
                        Definition.FilterGroup(7);
                        Definition.SetRange("Statistic code");
                        Definition.SetRange("Line No.", 10000);
                        Definition.FilterGroup(0);

                        if not Definition.Get(UserId, CodeStatistique, 10000) then
                            if Definition.Find('-') then begin
                                if Definition2.Get(UserId, '', 0) then begin
                                    Definition2.Description := Definition."Statistic code";
                                    Definition2.Modify;
                                    CodeStatistique := Definition2.Description;
                                end;
                            end else begin
                                if Definition2.Get(UserId, '', 0) then
                                    Definition2.Delete;
                                CodeStatistique := '';
                            end;

                        fSetFilter;
                        wOuverture;
                        CurrPage.Update(false);
                    end;
                }
            }
            /*  GL2024 action("&Print")
               {
                   ApplicationArea = all;
                   Caption = '&Print';
                   Ellipsis = true;
                   Image = Print;
                   Promoted = true;
                   PromotedCategory = Process;

                   trigger OnAction()
                   var
                       ReportEdition: Report UnknownReport8001302;
                   begin
                       ReportEdition.InitRequete(CodeStatistique, 1, false, true, UserId);
                       ReportEdition.RunModal;
                   end;
               }*/
            action("Previous Set")
            {
                ApplicationArea = all;
                Caption = 'Previous Set';
                Image = PreviousSet;

                ToolTip = 'Previous Set';

                trigger OnAction()
                begin
                    SetColumns(Matrix_setwanted::Previous);
                end;
            }
            action("Next Set")
            {
                ApplicationArea = all;
                Caption = 'Next Set';
                Image = NextSet;

                ToolTip = 'Next Set';

                trigger OnAction()
                begin
                    SetColumns(Matrix_setwanted::Next);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CodeIndent := 0;
        FORM_OnAfterGetRecord;
        CodeOnFormat;
        DescriptionOnFormat;
        MATRIXCellData1OnFormat;
        MATRIXCellData2OnFormat;
        MATRIXCellData3OnFormat;
        MATRIXCellData4OnFormat;
        MATRIXCellData5OnFormat;
        MATRIXCellData6OnFormat;
        MATRIXCellData7OnFormat;
        MATRIXCellData8OnFormat;
        MATRIXCellData9OnFormat;
        MATRIXCellData10OnFormat;
        MATRIXCellData11OnFormat;
        MATRIXCellData12OnFormat;
        MATRIXCellData13OnFormat;
        MATRIXCellData14OnFormat;
        MATRIXCellData15OnFormat;
        MATRIXCellData16OnFormat;
        MATRIXCellData17OnFormat;
        MATRIXCellData18OnFormat;
        MATRIXCellData19OnFormat;
        MATRIXCellData20OnFormat;
        MATRIXCellData21OnFormat;
        MATRIXCellData22OnFormat;
        MATRIXCellData23OnFormat;
        MATRIXCellData24OnFormat;
        MATRIXCellData25OnFormat;
        MATRIXCellData26OnFormat;
        MATRIXCellData27OnFormat;
        MATRIXCellData28OnFormat;
        MATRIXCellData29OnFormat;
        MATRIXCellData30OnFormat;
        MATRIXCellData31OnFormat;
        MATRIXCellData32OnFormat;
    end;

    trigger OnInit()
    begin
        Field32Visible := true;
        Field31Visible := true;
        Field30Visible := true;
        Field29Visible := true;
        Field28Visible := true;
        Field27Visible := true;
        Field26Visible := true;
        Field25Visible := true;
        Field24Visible := true;
        Field23Visible := true;
        Field22Visible := true;
        Field21Visible := true;
        Field20Visible := true;
        Field19Visible := true;
        Field18Visible := true;
        Field17Visible := true;
        Field16Visible := true;
        Field15Visible := true;
        Field14Visible := true;
        Field13Visible := true;
        Field12Visible := true;
        Field11Visible := true;
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;
        MATRIX_CurrSetLength := ArrayLen(MATRIX_CaptionSet);
    end;

    trigger OnOpenPage()
    begin
        fInitialize();
        SetColumns(Matrix_setwanted::Initial);
    end;

    var
        ParamCompta: Record "General Ledger Setup";
        LigneTableauStat2: Record "Statistic array line";
        Cellule: Record "Statistic cell";
        Definition: Record "Statistic definition";
        //GL2024    Users: Record Login temporary;
        CodeStatistique: Code[10];
        xCodeStatistique: Code[10];
        FormatStringNormal: Text[80];
        Ouverture: Boolean;
        Fenetre: Dialog;
        NumLig: Integer;
        Preparation: label 'Prepare in progress...';
        Error1: label 'Statistic %1 was not calculated';
        TexteCodePredefini: label 'MANUAL';
        //GL2024   wLoginMgt: Codeunit 418;
        wLoginMgt: Codeunit SoroubatFucntion;
        MatrixColumCaption: array[32] of Text[1024];
        ColumValue: array[32] of Text[1024];
        CurrSetLengh: Integer;
        "---------": Integer;
        MatrixRecord: Record "Statistic array column";
        MatrixRecords: array[32] of Record "Statistic array column";
        MatrixRecordRef: RecordRef;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        MATRIX_CurrSetLength: Integer;
        MATRIX_CellData: array[32] of Text[80];
        [InDataSet]
        CodeEmphasize: Boolean;
        [InDataSet]
        CodeIndent: Integer;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;
        [InDataSet]
        Field11Visible: Boolean;
        [InDataSet]
        Field12Visible: Boolean;
        [InDataSet]
        Field13Visible: Boolean;
        [InDataSet]
        Field14Visible: Boolean;
        [InDataSet]
        Field15Visible: Boolean;
        [InDataSet]
        Field16Visible: Boolean;
        [InDataSet]
        Field17Visible: Boolean;
        [InDataSet]
        Field18Visible: Boolean;
        [InDataSet]
        Field19Visible: Boolean;
        [InDataSet]
        Field20Visible: Boolean;
        [InDataSet]
        Field21Visible: Boolean;
        [InDataSet]
        Field22Visible: Boolean;
        [InDataSet]
        Field23Visible: Boolean;
        [InDataSet]
        Field24Visible: Boolean;
        [InDataSet]
        Field25Visible: Boolean;
        [InDataSet]
        Field26Visible: Boolean;
        [InDataSet]
        Field27Visible: Boolean;
        [InDataSet]
        Field28Visible: Boolean;
        [InDataSet]
        Field29Visible: Boolean;
        [InDataSet]
        Field30Visible: Boolean;
        [InDataSet]
        Field31Visible: Boolean;
        [InDataSet]
        Field32Visible: Boolean;
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
        [InDataSet]
        Field32Emphasize: Boolean;


    procedure fInitialize()
    begin
        if FormatStringNormal = '' then begin
            ParamCompta.Get;
            FormatStringNormal := '<Precision,' + ParamCompta."Amount Decimal Places" + '><Standard Format,0>';
        end;

        if (CodeStatistique = '') and (Definition.Get(UserId, '', 0)) then
            CodeStatistique := Definition.Description;

        fSetFilter();

        if Definition.Get(UserId, CodeStatistique, 10000) then
            wMark(true);

        //#5075
        //GL2024  wLoginMgt.fPopulateLogin(Users);
        //#5075//
    end;


    procedure fSetFilter()
    begin
        rec.FilterGroup(7);
        rec.SetRange("User ID", UserId);
        rec.SetRange("Statistic code", CodeStatistique);
        rec.FilterGroup(0);

        Definition.FilterGroup(7);
        Definition.SetRange("User ID", UserId);
        Definition.SetRange("Statistic code", CodeStatistique);
        Definition.SetFilter("Line No.", '>=%1', 10000);
        Definition.FilterGroup(0);
    end;


    procedure wOuverture()
    begin
        Definition.FilterGroup(7);
        Definition.SetRange("User ID", UserId);
        Definition.SetRange("Statistic code", CodeStatistique);
        Definition.FilterGroup(0);
        if Definition.Get(UserId, CodeStatistique, 10000) then
            wMark(true)
        else begin
            Definition.Init;
            rec.ClearMarks;
        end;
    end;


    procedure wMark(Open: Boolean)
    begin
        if ISSERVICETIER then
            exit;

        Fenetre.Open(Preparation);

        rec.Reset;

        rec.FilterGroup(7);
        rec.SetRange("User ID", UserId);
        rec.FilterGroup(0);
        /*DELETE
        CurrForm.MatriceStat.MatrixRec.FILTERGROUP(7);
        CurrForm.MatriceStat.MatrixRec.SETRANGE("User ID",USERID);
        CurrForm.MatriceStat.MatrixRec.SETRANGE("Statistic code",CodeStatistique);
        CurrForm.MatriceStat.MatrixRec.FILTERGROUP(0);
        DELETE*/
        if Open then begin
            rec.SetCurrentkey("User ID", rec."Section level", Open);
            rec.SetRange("Section level", 2, 100);
            rec.SetRange(Open, true);
            rec.ModifyAll(Open, false);
            rec.SetRange(Open);
        end;

        rec.SetRange("Section level", 1);
        rec.ModifyAll(Open, true);

        rec.SetRange("Section level", 1, 2);
        if not rec.IsEmpty then begin
            rec.FindFirst;
            repeat
                rec.Mark(true);
            until rec.Next = 0;
            rec.FindFirst;
        end;
        rec.SetRange("Section level");
        rec.MarkedOnly(true);
        rec.SetCurrentkey(rec."User ID", rec."Statistic code", rec."Line No.");
        rec.SetRange("Statistic code", CodeStatistique);
        if not rec.IsEmpty then
            if rec.FindFirst then;
        CurrPage.Update(false);

        Fenetre.Close;

    end;


    procedure wAssistEdit()
    begin
        if ISSERVICETIER then
            exit;

        if (rec."Section level" = 1) and (rec.Open) then begin
            wMark(true);
            CurrPage.Update(false);
        end else
            if rec."Lower lines count" > 0 then begin
                rec.MarkedOnly(false);
                if not rec.Open then begin
                    rec.SetRange("Section level", rec."Section level" + 1);
                    rec.Open := true;
                    Ouverture := true;
                end else begin
                    rec.Open := false;
                    rec.SetRange("Section level", rec."Section level" + 1, rec."Section level" + 100);
                    Ouverture := false;
                end;
                rec.Modify;

                case rec."Section level" of
                    2:
                        begin
                            rec.SetRange("Break 1", rec."Break 1");
                        end;
                    3:
                        begin
                            rec.SetRange("Break 1", rec."Break 1");
                            rec.SetRange("Break 2", rec."Break 2");
                        end;
                    4:
                        begin
                            rec.SetRange("Break 1", rec."Break 1");
                            rec.SetRange("Break 2", rec."Break 2");
                            rec.SetRange("Break 3", rec."Break 3");
                        end;
                    5:
                        begin
                            rec.SetRange("Break 1", rec."Break 1");
                            rec.SetRange("Break 2", rec."Break 2");
                            rec.SetRange("Break 3", rec."Break 3");
                            rec.SetRange("Break 4", rec."Break 4");
                        end;
                    6:
                        begin
                            rec.SetRange("Break 1", rec."Break 1");
                            rec.SetRange("Break 2", rec."Break 2");
                            rec.SetRange("Break 3", rec."Break 3");
                            rec.SetRange("Break 4", rec."Break 4");
                            rec.SetRange("Break 5", rec."Break 5");
                        end;
                    7:
                        begin
                            rec.SetRange("Break 1", rec."Break 1");
                            rec.SetRange("Break 2", rec."Break 2");
                            rec.SetRange("Break 3", rec."Break 3");
                            rec.SetRange("Break 4", rec."Break 4");
                            rec.SetRange("Break 5", rec."Break 5");
                            rec.SetRange("Break 6", rec."Break 6");
                        end;
                    8:
                        begin
                            rec.SetRange("Break 1", rec."Break 1");
                            rec.SetRange("Break 2", rec."Break 2");
                            rec.SetRange("Break 3", rec."Break 3");
                            rec.SetRange("Break 4", rec."Break 4");
                            rec.SetRange("Break 5", rec."Break 5");
                            rec.SetRange("Break 6", rec."Break 6");
                            rec.SetRange("Break 7", rec."Break 7");
                        end;
                    9:
                        begin
                            rec.SetRange("Break 1", rec."Break 1");
                            rec.SetRange("Break 2", rec."Break 2");
                            rec.SetRange("Break 3", rec."Break 3");
                            rec.SetRange("Break 4", rec."Break 4");
                            rec.SetRange("Break 5", rec."Break 5");
                            rec.SetRange("Break 6", rec."Break 6");
                            rec.SetRange("Break 7", rec."Break 7");
                            rec.SetRange("Break 8", rec."Break 8");
                        end;
                    10:
                        begin
                            rec.SetRange("Break 1", rec."Break 1");
                            rec.SetRange("Break 2", rec."Break 2");
                            rec.SetRange("Break 3", rec."Break 3");
                            rec.SetRange("Break 4", rec."Break 4");
                            rec.SetRange("Break 5", rec."Break 5");
                            rec.SetRange("Break 6", rec."Break 6");
                            rec.SetRange("Break 7", rec."Break 7");
                            rec.SetRange("Break 8", rec."Break 8");
                            rec.SetRange("Break 9", rec."Break 9");
                        end;
                    11:
                        begin
                            rec.SetRange("Break 1", rec."Break 1");
                            rec.SetRange("Break 2", rec."Break 2");
                            rec.SetRange("Break 3", rec."Break 3");
                            rec.SetRange("Break 4", rec."Break 4");
                            rec.SetRange("Break 5", rec."Break 5");
                            rec.SetRange("Break 6", rec."Break 6");
                            rec.SetRange("Break 7", rec."Break 7");
                            rec.SetRange("Break 8", rec."Break 8");
                            rec.SetRange("Break 9", rec."Break 9");
                            rec.SetRange("Break 10", rec."Break 10");
                        end;
                end;
                if not rec.IsEmpty then begin
                    rec.FindFirst;
                    repeat
                        if not Ouverture then begin
                            rec.Open := false;
                            rec.Modify;
                            rec.Mark(false);
                        end else
                            rec.Mark(true);
                    until rec.Next = 0;
                    rec.FindFirst;
                end;
                Commit;
                rec.SetRange("Break 1");
                rec.SetRange("Break 2");
                rec.SetRange("Break 3");
                rec.SetRange("Break 4");
                rec.SetRange("Break 5");
                rec.SetRange("Break 6");
                rec.SetRange("Break 7");
                rec.SetRange("Break 8");
                rec.SetRange("Break 9");
                rec.SetRange("Break 10");
                rec.SetRange("Section level");
                rec.MarkedOnly(true);
                if (Ouverture) and rec.Find('<') then;
                CurrPage.Update(false);
            end;
    end;


    procedure wColor() Col: Integer
    begin
        case rec."Section level" of
            2:
                Col := 1;
            3:
                Col := 8388608;
            4:
                Col := 500000000;
            5:
                Col := 82000000;
            6:
                Col := 16000000;
            7:
                Col := 8410000;
        end;
    end;


    procedure wForward()
    var
        LignesStatistiquesTemp: Record "Statistic array line";
        ColonnesStatistiquesTemp: Record "Statistic array column";
        ResultatsStatistiquesTemp: Record "Statistic cell";
        DefinitionStatistiquesTemp: Record "Statistic definition";
        LignesStatistiquesTemp2: Record "Statistic array line";
        ColonnesStatistiquesTemp2: Record "Statistic array column";
        ResultatsStatistiquesTemp2: Record "Statistic cell";
        DefinitionStatistiquesTemp2: Record "Statistic definition";
    begin
        // Other users
        //GL2024   if Users."User ID" <> UserId then begin

        LignesStatistiquesTemp.SetRange("Statistic code", CodeStatistique);
        LignesStatistiquesTemp.SetRange("User ID", UserId);

        if not LignesStatistiquesTemp.IsEmpty then begin
            LignesStatistiquesTemp.FindFirst;
            LignesStatistiquesTemp2.SetRange("Statistic code", CodeStatistique);
            //GL2024  LignesStatistiquesTemp2.SetRange("User ID", Users."User ID");
            LignesStatistiquesTemp2.DeleteAll;
            repeat
                LignesStatistiquesTemp2.Reset;
                LignesStatistiquesTemp2.Init;
                LignesStatistiquesTemp2 := LignesStatistiquesTemp;
                //GL2024    LignesStatistiquesTemp2."User ID" := Users."User ID";
                LignesStatistiquesTemp2.Insert;
            until LignesStatistiquesTemp.Next = 0;
        end;

        ColonnesStatistiquesTemp.SetRange("Statistic code", CodeStatistique);
        ColonnesStatistiquesTemp.SetRange("User ID", UserId);
        if not ColonnesStatistiquesTemp.IsEmpty then begin
            ColonnesStatistiquesTemp.FindFirst;
            ColonnesStatistiquesTemp2.SetRange("Statistic code", CodeStatistique);
            //GL2024    ColonnesStatistiquesTemp2.SetRange("User ID", Users."User ID");
            ColonnesStatistiquesTemp2.DeleteAll;
            repeat
                ColonnesStatistiquesTemp2.Reset;
                ColonnesStatistiquesTemp2.Init;
                ColonnesStatistiquesTemp2 := ColonnesStatistiquesTemp;
                //GL2024     ColonnesStatistiquesTemp2."User ID" := Users."User ID";
                ColonnesStatistiquesTemp2.Insert;
            until ColonnesStatistiquesTemp.Next = 0;
        end;

        ResultatsStatistiquesTemp.SetRange("Statistic code", CodeStatistique);
        ResultatsStatistiquesTemp.SetRange("User ID", UserId);
        if not ResultatsStatistiquesTemp.IsEmpty then begin
            ResultatsStatistiquesTemp.FindFirst;
            ResultatsStatistiquesTemp2.SetRange("Statistic code", CodeStatistique);
            //GL2024  ResultatsStatistiquesTemp2.SetRange("User ID", Users."User ID");
            ResultatsStatistiquesTemp2.DeleteAll;
            repeat
                ResultatsStatistiquesTemp2.Reset;
                ResultatsStatistiquesTemp2.Init;
                ResultatsStatistiquesTemp2 := ResultatsStatistiquesTemp;
                //GL2024   ResultatsStatistiquesTemp2."User ID" := Users."User ID";
                ResultatsStatistiquesTemp2.Insert;
            until ResultatsStatistiquesTemp.Next = 0;
        end;

        DefinitionStatistiquesTemp.SetRange("Statistic code", CodeStatistique);
        DefinitionStatistiquesTemp.SetRange("User ID", UserId);
        if not DefinitionStatistiquesTemp.IsEmpty then begin
            DefinitionStatistiquesTemp.FindFirst;
            DefinitionStatistiquesTemp2.SetRange("Statistic code", CodeStatistique);
            //GL2024   DefinitionStatistiquesTemp2.SetRange("User ID", Users."User ID");
            DefinitionStatistiquesTemp2.DeleteAll;
            repeat
                DefinitionStatistiquesTemp2.Reset;
                DefinitionStatistiquesTemp2.Init;
                DefinitionStatistiquesTemp2 := DefinitionStatistiquesTemp;
                //GL2024   DefinitionStatistiquesTemp2."User ID" := Users."User ID";
                DefinitionStatistiquesTemp2.Insert;
            until DefinitionStatistiquesTemp.Next = 0;
        end;
        //GL2024  end;
    end;


    procedure "-----"()
    begin
    end;


    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next)
    var
        MatrixMgt: Codeunit "Matrix Management";
        CaptionFieldNo: Integer;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        Clear(MATRIX_CaptionSet);
        Clear(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        MatrixRecordRef.GetTable(MatrixRecord);
        MatrixRecordRef.SetTable(MatrixRecord);

        CaptionFieldNo := MatrixRecord.FieldNo("Column title");


        MatrixMgt.GenerateMatrixData(MatrixRecordRef, SetWanted, ArrayLen(MatrixRecords), CaptionFieldNo, MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

        if MATRIX_CurrSetLength > 0 then begin
            MatrixRecord.SetPosition(MATRIX_PKFirstRecInCurrSet);
            MatrixRecord.Find;
            repeat
                MatrixRecords[CurrentMatrixRecordOrdinal].Copy(MatrixRecord);
                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            until (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) or (MatrixRecord.Next <> 1);
        end;
    end;


    procedure FORM_OnAfterGetRecord()
    var
        lIndex: Integer;
    begin
        fSetFilter();
        lIndex := 0;
        if MatrixRecord.Find('-') then
            repeat
                lIndex += 1;
                MATRIX_OnAfterGetRecord(lIndex);
            until (MatrixRecord.Next() = 0) or (lIndex = MATRIX_CurrSetLength);
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    var
        lStatArrayLine: Record "Statistic array line";
    begin
        lStatArrayLine.Copy(Rec);
        lStatArrayLine.SetRange("Column no. filter", MatrixRecord."Colonne No. pos.");
        lStatArrayLine.CalcFields(Result);
        MATRIX_CellData[ColumnID] := fSetFormatValue(lStatArrayLine.Result, ColumnID);
        SetVisible;
    end;


    procedure SetVisible()
    var
        lVisible: Boolean;
    begin
        lVisible := MATRIX_CaptionSet[1] <> '';
        Field1Visible := lVisible;
        lVisible := MATRIX_CaptionSet[2] <> '';
        Field2Visible := lVisible;
        lVisible := MATRIX_CaptionSet[3] <> '';
        Field3Visible := lVisible;
        lVisible := MATRIX_CaptionSet[4] <> '';
        Field4Visible := lVisible;
        lVisible := MATRIX_CaptionSet[5] <> '';
        Field5Visible := lVisible;
        lVisible := MATRIX_CaptionSet[6] <> '';
        Field6Visible := lVisible;
        lVisible := MATRIX_CaptionSet[7] <> '';
        Field7Visible := lVisible;
        lVisible := MATRIX_CaptionSet[8] <> '';
        Field8Visible := lVisible;
        lVisible := MATRIX_CaptionSet[9] <> '';
        Field9Visible := lVisible;
        lVisible := MATRIX_CaptionSet[10] <> '';
        Field10Visible := lVisible;
        lVisible := MATRIX_CaptionSet[11] <> '';
        Field11Visible := lVisible;
        lVisible := MATRIX_CaptionSet[12] <> '';
        Field12Visible := lVisible;
        lVisible := MATRIX_CaptionSet[13] <> '';
        Field13Visible := lVisible;
        lVisible := MATRIX_CaptionSet[14] <> '';
        Field14Visible := lVisible;
        lVisible := MATRIX_CaptionSet[15] <> '';
        Field15Visible := lVisible;
        lVisible := MATRIX_CaptionSet[16] <> '';
        Field16Visible := lVisible;
        lVisible := MATRIX_CaptionSet[17] <> '';
        Field17Visible := lVisible;
        lVisible := MATRIX_CaptionSet[18] <> '';
        Field18Visible := lVisible;
        lVisible := MATRIX_CaptionSet[19] <> '';
        Field19Visible := lVisible;
        lVisible := MATRIX_CaptionSet[20] <> '';
        Field20Visible := lVisible;
        lVisible := MATRIX_CaptionSet[21] <> '';
        Field21Visible := lVisible;
        lVisible := MATRIX_CaptionSet[22] <> '';
        Field22Visible := lVisible;
        lVisible := MATRIX_CaptionSet[23] <> '';
        Field23Visible := lVisible;
        lVisible := MATRIX_CaptionSet[24] <> '';
        Field24Visible := lVisible;
        lVisible := MATRIX_CaptionSet[25] <> '';
        Field25Visible := lVisible;
        lVisible := MATRIX_CaptionSet[26] <> '';
        Field26Visible := lVisible;
        lVisible := MATRIX_CaptionSet[27] <> '';
        Field27Visible := lVisible;
        lVisible := MATRIX_CaptionSet[28] <> '';
        Field28Visible := lVisible;
        lVisible := MATRIX_CaptionSet[29] <> '';
        Field29Visible := lVisible;
        lVisible := MATRIX_CaptionSet[30] <> '';
        Field30Visible := lVisible;
        lVisible := MATRIX_CaptionSet[31] <> '';
        Field31Visible := lVisible;
        lVisible := MATRIX_CaptionSet[32] <> '';
        Field32Visible := lVisible;
    end;


    procedure fSetFormatValue(pValue: Decimal; pColumnID: Integer) Retour: Text[80]
    begin
        Retour := '';
        if pValue <> 0 then begin
            case MatrixRecords[pColumnID]."Rounding Factor" of
                0:
                    Retour := CopyStr(Format(pValue, 0, FormatStringNormal), 1, MaxStrLen(Retour));
                1:
                    Retour := CopyStr(Format(ROUND(pValue, 1)), 1, MaxStrLen(Retour));
                2:
                    Retour := CopyStr(Format(ROUND(pValue / 1000, 0.1), 0, '<Precision,1><Standard Format,0>'), 1, MaxStrLen(Retour));
                3:
                    Retour := CopyStr(Format(ROUND(pValue / 1000000, 0.1), 0, '<Precision,1><Standard Format,0>'), 1, MaxStrLen(Retour));
                else
                    ;
            end;
        end;
    end;


    procedure MATRIX_OnFormat(pColumnID: Integer)
    var
        lFontBold: Boolean;
    begin
        lFontBold := (rec."Section level" <= 2);
        case (pColumnID) of
            1:
                begin
                    Field1Emphasize := lFontBold;
                end;
            2:
                begin
                    Field2Emphasize := lFontBold;
                end;
            3:
                begin
                    Field3Emphasize := lFontBold;
                end;
            4:
                begin
                    Field4Emphasize := lFontBold;
                end;
            5:
                begin
                    Field5Emphasize := lFontBold;
                end;
            6:
                begin
                    Field6Emphasize := lFontBold;
                end;
            7:
                begin
                    Field7Emphasize := lFontBold;
                end;
            8:
                begin
                    Field8Emphasize := lFontBold;
                end;
            9:
                begin
                    Field9Emphasize := lFontBold;
                end;
            10:
                begin
                    Field10Emphasize := lFontBold;
                end;
            11:
                begin
                    Field11Emphasize := lFontBold;
                end;
            12:
                begin
                    Field12Emphasize := lFontBold;
                end;
            13:
                begin
                    Field13Emphasize := lFontBold;
                end;
            14:
                begin
                    Field14Emphasize := lFontBold;
                end;
            15:
                begin
                    Field15Emphasize := lFontBold;
                end;
            16:
                begin
                    Field16Emphasize := lFontBold;
                end;
            17:
                begin
                    Field17Emphasize := lFontBold;
                end;
            18:
                begin
                    Field18Emphasize := lFontBold;
                end;
            19:
                begin
                    Field19Emphasize := lFontBold;
                end;
            20:
                begin
                    Field20Emphasize := lFontBold;
                end;
            21:
                begin
                    Field21Emphasize := lFontBold;
                end;
            22:
                begin
                    Field22Emphasize := lFontBold;
                end;
            23:
                begin
                    Field23Emphasize := lFontBold;
                end;
            24:
                begin
                    Field24Emphasize := lFontBold;
                end;
            25:
                begin
                    Field25Emphasize := lFontBold;
                end;
            26:
                begin
                    Field26Emphasize := lFontBold;
                end;
            27:
                begin
                    Field27Emphasize := lFontBold;
                end;
            28:
                begin
                    Field28Emphasize := lFontBold;
                end;
            29:
                begin
                    Field29Emphasize := lFontBold;
                end;
            30:
                begin
                    Field30Emphasize := lFontBold;
                end;
            31:
                begin
                    Field31Emphasize := lFontBold;
                end;
            32:
                begin
                    Field32Emphasize := lFontBold;
                end;
        end;
    end;

    local procedure CodeStatistiqueOnAfterValidate()
    begin
        if not Definition.Get(UserId, CodeStatistique, 10000) then begin
            Message(Error1, CodeStatistique);
            CodeStatistique := xCodeStatistique;
        end else begin
            rec.SetRange("Statistic code", CodeStatistique);
            fSetFilter();
            CurrPage.Update(false);
        end;
    end;

    local procedure CodeStatistiqueOnBeforeInput()
    begin
        xCodeStatistique := CodeStatistique;
    end;

    local procedure CodeOnFormat()
    var
        lLevel: Integer;
        lFontBold: Boolean;
    begin
        if (not ISSERVICETIER) then
            lLevel := rec."Section level" * 110
        else
            lLevel := rec."Section level";
        lFontBold := (rec."Section level" <= 2);
        CodeIndent := lLevel;
        CodeEmphasize := lFontBold;
    end;

    local procedure DescriptionOnFormat()
    var
        lLevel: Integer;
        lFontBold: Boolean;
    begin
        if (not ISSERVICETIER) then
            lLevel := rec."Section level" * 110
        else
            lLevel := rec."Section level";
        lFontBold := (rec."Section level" <= 2);
        DescriptionIndent := lLevel;
        DescriptionEmphasize := lFontBold;
    end;

    local procedure MATRIXCellData1OnFormat()
    begin
        MATRIX_OnFormat(1);
    end;

    local procedure MATRIXCellData2OnFormat()
    begin
        MATRIX_OnFormat(2);
    end;

    local procedure MATRIXCellData3OnFormat()
    begin
        MATRIX_OnFormat(3);
    end;

    local procedure MATRIXCellData4OnFormat()
    begin
        MATRIX_OnFormat(4);
    end;

    local procedure MATRIXCellData5OnFormat()
    begin
        MATRIX_OnFormat(5);
    end;

    local procedure MATRIXCellData6OnFormat()
    begin
        MATRIX_OnFormat(6);
    end;

    local procedure MATRIXCellData7OnFormat()
    begin
        MATRIX_OnFormat(7);
    end;

    local procedure MATRIXCellData8OnFormat()
    begin
        MATRIX_OnFormat(8);
    end;

    local procedure MATRIXCellData9OnFormat()
    begin
        MATRIX_OnFormat(9);
    end;

    local procedure MATRIXCellData10OnFormat()
    begin
        MATRIX_OnFormat(10);
    end;

    local procedure MATRIXCellData11OnFormat()
    begin
        MATRIX_OnFormat(11);
    end;

    local procedure MATRIXCellData12OnFormat()
    begin
        MATRIX_OnFormat(12);
    end;

    local procedure MATRIXCellData13OnFormat()
    begin
        MATRIX_OnFormat(13);
    end;

    local procedure MATRIXCellData14OnFormat()
    begin
        MATRIX_OnFormat(14);
    end;

    local procedure MATRIXCellData15OnFormat()
    begin
        MATRIX_OnFormat(15);
    end;

    local procedure MATRIXCellData16OnFormat()
    begin
        MATRIX_OnFormat(16);
    end;

    local procedure MATRIXCellData17OnFormat()
    begin
        MATRIX_OnFormat(17);
    end;

    local procedure MATRIXCellData18OnFormat()
    begin
        MATRIX_OnFormat(18);
    end;

    local procedure MATRIXCellData19OnFormat()
    begin
        MATRIX_OnFormat(19);
    end;

    local procedure MATRIXCellData20OnFormat()
    begin
        MATRIX_OnFormat(20);
    end;

    local procedure MATRIXCellData21OnFormat()
    begin
        MATRIX_OnFormat(21);
    end;

    local procedure MATRIXCellData22OnFormat()
    begin
        MATRIX_OnFormat(22);
    end;

    local procedure MATRIXCellData23OnFormat()
    begin
        MATRIX_OnFormat(23);
    end;

    local procedure MATRIXCellData24OnFormat()
    begin
        MATRIX_OnFormat(24);
    end;

    local procedure MATRIXCellData25OnFormat()
    begin
        MATRIX_OnFormat(25);
    end;

    local procedure MATRIXCellData26OnFormat()
    begin
        MATRIX_OnFormat(26);
    end;

    local procedure MATRIXCellData27OnFormat()
    begin
        MATRIX_OnFormat(27);
    end;

    local procedure MATRIXCellData28OnFormat()
    begin
        MATRIX_OnFormat(28);
    end;

    local procedure MATRIXCellData29OnFormat()
    begin
        MATRIX_OnFormat(29);
    end;

    local procedure MATRIXCellData30OnFormat()
    begin
        MATRIX_OnFormat(30);
    end;

    local procedure MATRIXCellData31OnFormat()
    begin
        MATRIX_OnFormat(31);
    end;

    local procedure MATRIXCellData32OnFormat()
    begin
        MATRIX_OnFormat(32);
    end;
}

