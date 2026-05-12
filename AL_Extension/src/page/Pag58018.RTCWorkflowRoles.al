Page 58018 "RTC Workflow Roles"
{
    // //+WKF+ MB 10/01/07 Delete(true) sur interdire
    // //+WKF+ CW 07/08/02 New

    Caption = 'RTC Workflow Roles';
    DataCaptionExpression = '';
    PageType = List;
    SaveValues = true;
    SourceTable = "Workflow Role";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(ShowColumnName; ShowColumnName)
                {
                    ApplicationArea = all;
                    Caption = 'Show Column Name';

                    /*GL2024  trigger OnValidate()
                      begin
                          ShowColumnNameOnAfterValidate;
                      end;*/
                }
                field(MATRIX_CaptionRange; MATRIX_CaptionRange)
                {
                    ApplicationArea = all;
                    Caption = 'Column Set';
                    Editable = false;
                    Visible = false;
                }
            }
            repeater(Control800390006)
            {
                ShowCaption = false;
                field("Role ID"; rec."Role ID")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Main User ID"; rec."Main User ID")
                {
                    ApplicationArea = all;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = all;
                    BlankNumbers = DontBlank;
                    //blankzero = false;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    NotBlank = false;

                    trigger OnValidate()
                    begin
                        MATRIXCellData1OnAfterValidate;
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[2];

                    trigger OnValidate()
                    begin
                        MATRIXCellData2OnAfterValidate;
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[3];

                    trigger OnValidate()
                    begin
                        MATRIXCellData3OnAfterValidate;
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[4];

                    trigger OnValidate()
                    begin
                        MATRIXCellData4OnAfterValidate;
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[5];

                    trigger OnValidate()
                    begin
                        MATRIXCellData5OnAfterValidate;
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[6];

                    trigger OnValidate()
                    begin
                        MATRIXCellData6OnAfterValidate;
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[7];

                    trigger OnValidate()
                    begin
                        MATRIXCellData7OnAfterValidate;
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[8];

                    trigger OnValidate()
                    begin
                        MATRIXCellData8OnAfterValidate;
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[9];

                    trigger OnValidate()
                    begin
                        MATRIXCellData9OnAfterValidate;
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[10];

                    trigger OnValidate()
                    begin
                        MATRIXCellData10OnAfterValidat;
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[11];

                    trigger OnValidate()
                    begin
                        MATRIXCellData11OnAfterValidat;
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[12];

                    trigger OnValidate()
                    begin
                        MATRIXCellData12OnAfterValidat;
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[13];

                    trigger OnValidate()
                    begin
                        MATRIXCellData13OnAfterValidat;
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[14];

                    trigger OnValidate()
                    begin
                        MATRIXCellData14OnAfterValidat;
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[15];

                    trigger OnValidate()
                    begin
                        MATRIXCellData15OnAfterValidat;
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[16];

                    trigger OnValidate()
                    begin
                        MATRIXCellData16OnAfterValidat;
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[17];

                    trigger OnValidate()
                    begin
                        MATRIXCellData17OnAfterValidat;
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[18];

                    trigger OnValidate()
                    begin
                        MATRIXCellData18OnAfterValidat;
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[19];

                    trigger OnValidate()
                    begin
                        MATRIXCellData19OnAfterValidat;
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[20];

                    trigger OnValidate()
                    begin
                        MATRIXCellData20OnAfterValidat;
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[21];

                    trigger OnValidate()
                    begin
                        MATRIXCellData21OnAfterValidat;
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[22];

                    trigger OnValidate()
                    begin
                        MATRIXCellData22OnAfterValidat;
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[23];

                    trigger OnValidate()
                    begin
                        MATRIXCellData23OnAfterValidat;
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[24];

                    trigger OnValidate()
                    begin
                        MATRIXCellData24OnAfterValidat;
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[25];

                    trigger OnValidate()
                    begin
                        MATRIXCellData25OnAfterValidat;
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[26];

                    trigger OnValidate()
                    begin
                        MATRIXCellData26OnAfterValidat;
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[27];

                    trigger OnValidate()
                    begin
                        MATRIXCellData27OnAfterValidat;
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[28];

                    trigger OnValidate()
                    begin
                        MATRIXCellData28OnAfterValidat;
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[29];

                    trigger OnValidate()
                    begin
                        MATRIXCellData29OnAfterValidat;
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[30];

                    trigger OnValidate()
                    begin
                        MATRIXCellData30OnAfterValidat;
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[31];

                    trigger OnValidate()
                    begin
                        MATRIXCellData31OnAfterValidat;
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[32];

                    trigger OnValidate()
                    begin
                        MATRIXCellData32OnAfterValidat;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            /*GL202
          //     action("Previous Set")
          //     {
          //         ApplicationArea = all;
          //         Caption = 'Previous Set';
          //         Image = PreviousSet;
          //         Promoted = true;
          //         PromotedCategory = Process;
          //         PromotedIsBig = true;
          //         ToolTip = 'Previous Set';

          //         /*  //GL2024   trigger OnAction()
          //            begin
          //                SetColumns(Matrix_setwanted::Previous);
          //            end;*/
            //    }
            // action("Previous Column")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Previous Column';
            //     Image = PreviousRecord;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ToolTip = 'Previous Column';

            //     /*  //GL2024   trigger OnAction()
            //        begin
            //            SetColumns(Matrix_setwanted::PreviousColumn);
            //        end;*/
            // }
            // action("Next Column")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Next Column';
            //     Image = NextRecord;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ToolTip = 'Next Column';

            //     /*  //GL2024 trigger OnAction()
            //      begin
            //          SetColumns(Matrix_setwanted::NextColumn);
            //      end;*/
            // }
            // action("Next Set")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Next Set';
            //     Image = NextSet;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ToolTip = 'Next Set';

            //     /*  //GL2024   trigger OnAction()
            //        begin
            //          //GL2024   SetColumns(Matrix_setwanted::Next);
            //        end;*/
            // }
        }
    }

    trigger OnAfterGetRecord()
    var
        lIndex: Integer;
    begin
        for lIndex := 1 to MATRIX_CurrSetLength do begin
            //GL2024 MATRIX_OnAfterGetRecord(lIndex);
        end;
    end;

    trigger OnOpenPage()
    var
        lLogin: Record "Allocation Policy";
    begin
        LoginManagement.fPopulateLogin(lLogin);

        //GL2024 SetColumns(Matrix_setwanted::Initial);
    end;

    var
        RoleUser: Record "Workflow Role - User";
        MatrixHeader: Text[250];
        ShowColumnName: Boolean;
        CheckMark: Boolean;
        //GL2024 LoginManagement: Codeunit 418;
        LoginManagement: Codeunit SoroubatFucntion;
        "--------": Integer;
        //GL2024 MatrixRecord: Record Login;
        MatrixRecords: array[32] of Record "Allocation Policy";
        MatrixRecordRef: RecordRef;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[1024];
        MATRIX_CurrSetLength: Integer;
        MATRIX_CellData: array[32] of Boolean;


    /* procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next)
     var
         MatrixMgt: Codeunit 9200;
         CaptionFieldNo: Integer;
         CurrentMatrixRecordOrdinal: Integer;
     begin
         Clear(MATRIX_CaptionSet);
         Clear(MatrixRecords);
         CurrentMatrixRecordOrdinal := 1;

         MatrixRecordRef.GetTable(MatrixRecord);
        MatrixRecordRef.SetTable(MatrixRecord);

         if (ShowColumnName) then
             CaptionFieldNo := MatrixRecord.FieldNo(Name)
         else
             CaptionFieldNo := MatrixRecord.FieldNo("User ID");

         MatrixMgt.GenerateMatrixData(MatrixRecordRef, SetWanted, ArrayLen(MatrixRecords), CaptionFieldNo, MATRIX_PKFirstRecInCurrSet,
           MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

         if MATRIX_CurrSetLength > 0 then begin
            //GL2024  MatrixRecord.SetPosition(MATRIX_PKFirstRecInCurrSet);
             //GL2024 MatrixRecord.Find;
             repeat
              //GL2024    MatrixRecords[CurrentMatrixRecordOrdinal].Copy(MatrixRecord);
                 //#8371
                 fSetCaptionSet(MATRIX_CaptionSet[CurrentMatrixRecordOrdinal], MatrixRecords[CurrentMatrixRecordOrdinal]);
                 //#8371//
                 CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
             until (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) or (MatrixRecord.Next <> 1);
         end;
     end;*/

    /*GL2024 local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
     var
         lRes: Record 156;
         lResLoc: Record 156 temporary;
     begin
      //GL2024    rec.SetRange("User Filter", MatrixRecords[ColumnID]."User ID");
         Rec.CalcFields("User Granted");
         /*
         IF "User Granted" THEN
           MATRIX_CellData[ColumnID] := FORMAT(Rec."User Granted")
         ELSE
           MATRIX_CellData[ColumnID] := '';
         */
    /*  MATRIX_CellData[ColumnID] := Rec."User Granted";

  end;*/


    procedure MATRIX_OnAfterValidate(pColumnID: Integer)
    begin
        if (MATRIX_CellData[pColumnID]) then begin
            RoleUser.Init();
            RoleUser."Role ID" := rec."Role ID";
            //GL2024  RoleUser."User ID" := MatrixRecords[pColumnID]."User ID";
            if RoleUser.Insert then;
        end else begin
            //GL2024  if RoleUser.Get(rec."Role ID", MatrixRecords[pColumnID]."User ID") then begin
            //  RoleUser.DELETE;
            //+WKF+
            //GL2024   RoleUser.Delete(true);
            //+WKF+//
            //GL2024  end;
        end;
    end;


    /*  GL2024 procedure fSetCaptionSet(var pHeader: Text[1024]; pLogin: Record 387)
       begin
           //#8371
           if ShowColumnName then
               pHeader := pLogin.Name
           else
               if pLogin."Windows Login" then
                   pHeader := Lowercase(pLogin."User ID")
               else
                   pHeader := pLogin."User ID";

           //#8371//
       end;*/

    /*  //GL2024 local procedure ShowColumnNameOnAfterValidate()
     begin
         SetColumns(Matrix_setwanted::Same);
     end;*/

    local procedure MATRIXCellData1OnAfterValidate()
    begin
        MATRIX_OnAfterValidate(1);
    end;

    local procedure MATRIXCellData2OnAfterValidate()
    begin
        MATRIX_OnAfterValidate(2);
    end;

    local procedure MATRIXCellData3OnAfterValidate()
    begin
        MATRIX_OnAfterValidate(3);
    end;

    local procedure MATRIXCellData4OnAfterValidate()
    begin
        MATRIX_OnAfterValidate(4);
    end;

    local procedure MATRIXCellData5OnAfterValidate()
    begin
        MATRIX_OnAfterValidate(5);
    end;

    local procedure MATRIXCellData6OnAfterValidate()
    begin
        MATRIX_OnAfterValidate(6);
    end;

    local procedure MATRIXCellData7OnAfterValidate()
    begin
        MATRIX_OnAfterValidate(7);
    end;

    local procedure MATRIXCellData8OnAfterValidate()
    begin
        MATRIX_OnAfterValidate(8);
    end;

    local procedure MATRIXCellData9OnAfterValidate()
    begin
        MATRIX_OnAfterValidate(9);
    end;

    local procedure MATRIXCellData10OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(10);
    end;

    local procedure MATRIXCellData11OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(11);
    end;

    local procedure MATRIXCellData12OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(12);
    end;

    local procedure MATRIXCellData13OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(13);
    end;

    local procedure MATRIXCellData14OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(14);
    end;

    local procedure MATRIXCellData15OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(15);
    end;

    local procedure MATRIXCellData16OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(16);
    end;

    local procedure MATRIXCellData17OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(17);
    end;

    local procedure MATRIXCellData18OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(18);
    end;

    local procedure MATRIXCellData19OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(19);
    end;

    local procedure MATRIXCellData20OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(20);
    end;

    local procedure MATRIXCellData21OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(21);
    end;

    local procedure MATRIXCellData22OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(22);
    end;

    local procedure MATRIXCellData23OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(23);
    end;

    local procedure MATRIXCellData24OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(24);
    end;

    local procedure MATRIXCellData25OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(25);
    end;

    local procedure MATRIXCellData26OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(26);
    end;

    local procedure MATRIXCellData27OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(27);
    end;

    local procedure MATRIXCellData28OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(28);
    end;

    local procedure MATRIXCellData29OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(29);
    end;

    local procedure MATRIXCellData30OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(30);
    end;

    local procedure MATRIXCellData31OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(31);
    end;

    local procedure MATRIXCellData32OnAfterValidat()
    begin
        MATRIX_OnAfterValidate(32);
    end;
}

