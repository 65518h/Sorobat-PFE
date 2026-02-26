Page 58012 "RTC BAR : Cash Flow / Bank"
{
    // //+RAP+TRESO GESWAY 26/06/02 Situation de trésorerie
    //                 23/02/04 Adaptation IBAN

    Caption = 'RTC BAR : Cash Flow / Bank';
    PageType = Card;
    SaveValues = true;
    SourceTable = Date;
    SourceTableView = sorting("Period Type", "Period Start");
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filters';
                group(Control800160013)
                {
                    Caption = 'Filters';
                    field(FiltreSoc; FiltreSoc)
                    {
                        ApplicationArea = all;
                        Caption = 'Company Filter';
                        TableRelation = Company.Name;

                        trigger OnValidate()
                        begin
                            fSetMatrix();
                            Load(
                              MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                              FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                            FiltreSocOnAfterValidate;
                        end;
                    }
                    field(FiltreBanque; FiltreBanque)
                    {
                        ApplicationArea = all;
                        Caption = 'Bank Account Filter';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            CpteRappro: Record "BAR : Bank Account";
                        begin
                            //CpteRappro.SETCURRENTKEY("Bank Branch No.","Agency Code","Bank Account No.",Company,"Bank Account Code");
                            CpteRappro.SetCurrentkey(Iban, Company, "Bank Account No.");
                            CpteRappro.SetFilter(Company, FiltreSoc);
                            //CpteRappro.SETRANGE("Excluded From Import",FALSE);
                            CpteRappro.SetRange("Excluded From Cash Flow", false);
                            /* GL2024   if Action::LookupOK = page.RunModal(page::"BAR : Bank Account List", CpteRappro) then
                                    if FiltreBanque = '' then
                                        FiltreBanque := CpteRappro."Bank Account No."
                                    else
                                        FiltreBanque += '|' + CpteRappro."Bank Account No.";*/
                            Load(
                              MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                              FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                        end;

                        trigger OnValidate()
                        begin
                            fSetMatrix();
                            Load(
                              MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                              FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                            FiltreBanqueOnAfterValidate;
                        end;
                    }
                    field(DateOpeVal; DateOpeVal)
                    {
                        ApplicationArea = all;
                        Caption = 'Date Type';
                        OptionCaption = 'Operation Date,Value Date';

                        trigger OnValidate()
                        begin
                            fSetMatrix();
                            Load(
                              MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                              FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                            DateOpeValOnAfterValidate;
                        end;
                    }
                }
                group(Display)
                {
                    Caption = 'Display';
                    field(DeviseAffichage; DeviseAffichage)
                    {
                        ApplicationArea = all;
                        Caption = 'Currency';
                        TableRelation = Currency;

                        trigger OnValidate()
                        begin
                            fSetMatrix();
                            Load(
                              MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                              FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                            DeviseAffichageOnAfterValidate;
                        end;
                    }
                    field(FacteurArrondi; FacteurArrondi)
                    {
                        ApplicationArea = all;
                        Caption = 'Unit';

                        trigger OnValidate()
                        begin
                            fSetMatrix();
                            Load(
                              MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                              FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                            FacteurArrondiOnAfterValidate;
                        end;
                    }
                    field(TypeEcr; TypeEcr)
                    {
                        ApplicationArea = all;
                        Caption = 'Entry Type';

                        trigger OnValidate()
                        begin
                            fSetMatrix();
                            Load(
                              MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                              FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                            TypeEcrOnAfterValidate;
                        end;
                    }
                }
            }
            group("Options Matrix")
            {
                Caption = 'Options Matrix';
                group(Matrix)
                {
                    Caption = 'Matrix';
                    field(TypePeriode; TypePeriode)
                    {
                        ApplicationArea = all;
                        Caption = 'Period';
                        OptionCaption = 'Day,Week,Month,Quarter,Year,Accounting Period';

                        trigger OnValidate()
                        begin
                            fSetMatrix();
                            SetColumns(Matrix_setwanted::First);
                            Load(
                              MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                              FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                            TypePeriodeOnAfterValidate;
                        end;
                    }
                    field(MATRIX_CaptionRange; MATRIX_CaptionRange)
                    {
                        ApplicationArea = all;
                        Caption = 'Column Set';
                        Editable = false;
                    }
                    field(TypeMnt; TypeMnt)
                    {
                        ApplicationArea = all;
                        Caption = 'Balance Type';
                        OptionCaption = 'Net Change,Balance at Date';

                        trigger OnValidate()
                        begin
                            Load(
                              MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                              FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                            TypeMntOnAfterValidate;
                        end;
                    }
                }
            }
            repeater(Control800160016)
            {
                Editable = false;
                ShowCaption = false;
                field("Period Start"; rec."Period Start")
                {
                    ApplicationArea = all;
                    Caption = 'Period Start';
                }
                field("Period Name"; rec."Period Name")
                {
                    ApplicationArea = all;
                    Caption = 'Period Name';
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[1];

                    /*GL2024     trigger OnDrillDown()
                     begin
                         MatrixOnDrillDown(1);
                     end;*/
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[2];

                    /*GL2024     trigger OnDrillDown()
                     begin
                         MatrixOnDrillDown(2);
                     end;*/
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[3];

                    /*GL2024     trigger OnDrillDown()
                     begin
                         MatrixOnDrillDown(3);
                     end;*/
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[4];

                    /*GL2024    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(4);
                    end;*/
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[5];

                    /*GL2024       trigger OnDrillDown()
                       begin
                           MatrixOnDrillDown(5);
                       end;*/
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[6];

                    /*GL2024    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(6);
                    end;*/
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[7];

                    /*GL2024    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(7);
                    end;*/
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[8];

                    /*GL2024   trigger OnDrillDown()
                   begin
                       MatrixOnDrillDown(8);
                   end;*/
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[9];

                    /*GL2024    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9);
                    end;*/
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[10];

                    /*GL2024    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10);
                    end;*/
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[11];

                    /*GL2024    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11);
                    end;*/
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[12];

                    /*GL2024      trigger OnDrillDown()
                      begin
                          MatrixOnDrillDown(12);
                      end;*/
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[13];

                    /*GL2024     trigger OnDrillDown()
                     begin
                         MatrixOnDrillDown(13);
                     end;*/
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[14];

                    /*GL2024      trigger OnDrillDown()
                      begin
                          MatrixOnDrillDown(14);
                      end;*/
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[15];

                    /*GL2024    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(15);
                    end;*/
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[16];

                    /*GL2024   trigger OnDrillDown()
                   begin
                       MatrixOnDrillDown(16);
                   end;*/
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[17];

                    /*GL2024      trigger OnDrillDown()
                      begin
                          MatrixOnDrillDown(17);
                      end;*/
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[18];

                    /*GL2024   trigger OnDrillDown()
                   begin
                       MatrixOnDrillDown(18);
                   end;*/
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[19];

                    /*GL2024   trigger OnDrillDown()
                   begin
                       MatrixOnDrillDown(19);
                   end;*/
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[20];

                    /*GL2024      trigger OnDrillDown()
                      begin
                          MatrixOnDrillDown(20);
                      end;*/
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[21];

                    /*GL2024     trigger OnDrillDown()
                     begin
                         MatrixOnDrillDown(21);
                     end;*/
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[22];

                    /*GL2024     trigger OnDrillDown()
                     begin
                         MatrixOnDrillDown(22);
                     end;*/
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[23];

                    /*GL2024   trigger OnDrillDown()
                   begin
                       MatrixOnDrillDown(23);
                   end;*/
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[24];

                    /*GL2024   trigger OnDrillDown()
                   begin
                       MatrixOnDrillDown(24);
                   end;*/
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[25];

                    /*GL2024    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(25);
                    end;*/
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[26];

                    /*GL2024     trigger OnDrillDown()
                     begin
                         MatrixOnDrillDown(26);
                     end;*/
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[27];

                    /*GL2024    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(27);
                    end;*/
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[28];

                    /*GL2024      trigger OnDrillDown()
                      begin
                          MatrixOnDrillDown(28);
                      end;*/
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[29];

                    /*GL2024    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(29);
                    end;*/
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[30];

                    /*GL2024    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(30);
                    end;*/
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[31];

                    /*GL2024   trigger OnDrillDown()
                   begin
                       MatrixOnDrillDown(31);
                   end;*/
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = DeviseAffichage;
                    AutoFormatType = 1;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[32];

                    /*GL2024   trigger OnDrillDown()
                       begin
                           MatrixOnDrillDown(32);
                       end;*/
                }
            }

        }
    }

    actions
    {
        area(processing)
        {
            action("Previous Set")
            {
                ApplicationArea = all;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Set';

                trigger OnAction()
                begin
                    fSetMatrix();
                    SetColumns(Matrix_setwanted::Previous);
                    Load(
                      MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                      FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                end;
            }
            action("Previous Column")
            {
                ApplicationArea = all;
                Caption = 'Previous Column';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Column';

                trigger OnAction()
                begin
                    fSetMatrix();
                    SetColumns(Matrix_setwanted::PreviousColumn);
                    Load(
                      MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                      FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                end;
            }
            action("Next Column")
            {
                ApplicationArea = all;
                Caption = 'Next Column';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Column';

                trigger OnAction()
                begin
                    fSetMatrix();
                    SetColumns(Matrix_setwanted::NextColumn);
                    Load(
                      MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                      FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                end;
            }
            action("Next Set")
            {
                ApplicationArea = all;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Set';

                trigger OnAction()
                begin
                    fSetMatrix();
                    SetColumns(Matrix_setwanted::Next);
                    Load(
                      MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
                      FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        lIndex: Integer;
    begin
        Clear(MATRIX_CellData);
        for lIndex := 1 to MATRIX_CurrentNoOfMatrixColumn do
            MATRIX_OnAfterGetRecord(lIndex);
    end;

    /* GL2024  trigger OnFindRecord(Which: Text): Boolean
       begin
           exit(GestionFormPeriode.FindDate(Which, Rec, TypePeriode));
       end;

       trigger OnNextRecord(Steps: Integer): Integer
       begin
           exit(GestionFormPeriode.NextDate(Steps, Rec, TypePeriode));
       end;*/

    trigger OnOpenPage()
    begin
        fInitialize;
        SetColumns(Matrix_setwanted::First);
        Load(
          MATRIX_CaptionSet, MatrixRecords, MATRIX_CurrSetLength,
          FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, TypeEcr);
    end;

    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin
        if CloseAction = Action::LookupOK then
            LookupOKOnPush;
    end;

    var
        //GL2024    GestionFormPeriode: Codeunit 359;
        TypePeriode: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        TypeMnt: Option "Net Change","Balance at Date";
        Societe: Record Company;
        DernDate: Date;
        FiltreSoc: Text[250];
        FiltreBanque: Text[80];
        DateOpeVal: Option "Operation Date","Value Date";
        DeviseAffichage: Code[10];
        FacteurArrondi: Option Standard,"1","1000","1000000";
        TypeEcr: Option Bancaire,Comptable,"En prévision",Tous;
        NbreSoc: Decimal;
        "-----------": Integer;
        MatrixRecord: Record "BAR : Bank Account";
        MatrixRecords: array[32] of Record "BAR : Bank Account";
        MatrixRecordRef: RecordRef;
        MATRIX_SetWanted: Option First,Previous,Same,Next,PreviousColumn,NextColumn;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        MATRIX_CurrSetLength: Integer;
        MATRIX_CellData: array[32] of Decimal;
        MATRIX_MatrixRecord: Record "BAR : Bank Account";
        TextTitre: label 'STOCK';
        TextTotal: label 'TOTAL';
        MATRIX_CurrentNoOfMatrixColumn: Integer;
        ParamCpta: Record "General Ledger Setup";


    procedure SetColumns(SetWanted: Option First,Previous,Same,Next,PreviousColumn,NextColumn)
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

        MatrixMgt.GenerateMatrixData(MatrixRecordRef, SetWanted, ArrayLen(MatrixRecords), 4, MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

        if MATRIX_CurrSetLength > 0 then begin
            MatrixRecord.SetPosition(MATRIX_PKFirstRecInCurrSet);
            if MatrixRecord.Find then
                repeat
                    MatrixRecords[CurrentMatrixRecordOrdinal].Copy(MatrixRecord);
                    CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
                until (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) or (MatrixRecord.Next <> 1);
        end;
    end;


    procedure fInitialize()
    begin
        DateOpeVal := Dateopeval::"Value Date";
        FiltreSoc := COMPANYNAME;
        TypeEcr := Typeecr::Tous;

        MatrixRecord.Reset;
        MatrixRecord.SetRange("Excluded From Cash Flow", false);

        fSetMatrix();
    end;


    procedure fSetMatrix()
    begin
        if (MatrixRecord.GetFilter(Company) <> FiltreSoc) or
           (MatrixRecord.GetFilter("Bank Account No.") <> FiltreBanque) then begin
            MatrixRecord.Reset;
            MatrixRecord.SetRange("Excluded From Cash Flow", false);
            if FiltreSoc <> '' then
                MatrixRecord.SetFilter(Company, FiltreSoc);
            if FiltreBanque <> '' then
                MatrixRecord.SetFilter("Bank Account No.", FiltreBanque);
            if MatrixRecord.FindFirst then;
        end;
        SetColumns(MATRIX_SetWanted);
    end;


    /*GL2024 procedure MatrixOnDrillDown(pColumnID: Integer)
     var
         lTreso: Page 8001615;
         lTreso2: Page 8001628;
         lTreso3: Page 8001636;
     begin
         if MatrixRecords[pColumnID]."Bank Account Internal No." >= 10000 then begin
             Clear(lTreso);
             lTreso.InitFiltres(FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, Rec);
             lTreso.RunModal;
         end
         else
             if MatrixRecords[pColumnID]."Bank Account No." <> TextTitre then begin
                 Clear(lTreso2);
                 lTreso2.InitFiltres(FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, Rec);
                 lTreso2.RunModal;
             end else begin
                 Clear(lTreso3);
                 lTreso3.InitFiltres(FiltreSoc, FiltreBanque, DateOpeVal, DeviseAffichage, TypePeriode, TypeMnt, FacteurArrondi, Rec);
                 lTreso3.RunModal;
             end;
     end;*/


    procedure Load(var MatrixColumns1: array[32] of Text[80]; var MatrixRecords1: array[32] of Record "BAR : Bank Account"; CurrentNoOfMatrixColumns: Integer; Soc: Text[250]; Bque: Text[80]; TypeVal: Option "Operation Date","Value Date"; DevAff: Code[10]; NouvBqueBasePeriode: Integer; NouvTypeMnt: Option "Solde période","Solde en date du"; Arrondi: Option Standard,"1","1000","1000000"; TypeEcrLoc: Option Bancaire,Comptable,"En simulation",Tous)
    var
        lIndex: Integer;
        lCashFlowBankMgt: Codeunit "CashFlow Bank Management";
    begin
        fSetMatrix();
        FiltreSoc := Soc;
        FiltreBanque := Bque;
        DateOpeVal := TypeVal;
        DeviseAffichage := DevAff;
        TypePeriode := NouvBqueBasePeriode;
        TypeMnt := NouvTypeMnt;
        FacteurArrondi := Arrondi;
        TypeEcr := TypeEcrLoc;

        Societe.Reset;
        if FiltreSoc <> '' then
            Societe.SetFilter(Name, FiltreSoc);
        if Societe.Find('-') then;
        NbreSoc := Societe.Count;
        //CLEAR(MatrixColumns1);
        for lIndex := 1 to ArrayLen(MatrixColumns1) do begin
            if MatrixColumns1[lIndex] = '' then
                MATRIX_CaptionSet[lIndex] := ''
            else
                MATRIX_CaptionSet[lIndex] := lCashFlowBankMgt.fFormatTitle(NbreSoc, MatrixRecords1[lIndex].Company,
                                                        MatrixRecords1[lIndex]."Bank Account No.");

            MatrixRecords[lIndex] := MatrixRecords1[lIndex];
        end;
        if MATRIX_CaptionSet[1] = '' then; // To make this form pass preCAL test
        if CurrentNoOfMatrixColumns > ArrayLen(MATRIX_CellData) then
            MATRIX_CurrentNoOfMatrixColumn := ArrayLen(MATRIX_CellData)
        else
            MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumns;
    end;


    procedure MATRIX_OnAfterGetRecord(pColumnID: Integer)
    var
        lCashFlowBankMgt: Codeunit "CashFlow Bank Management";
    begin
        MATRIX_CaptionSet[pColumnID] := lCashFlowBankMgt.fFormatTitle(NbreSoc, MatrixRecords[pColumnID].Company,
                                                    MatrixRecords[pColumnID]."Bank Account No.");
        if (rec."Period Start" <> 0D) then
            MATRIX_CellData[pColumnID] := (
                                  lCashFlowBankMgt.CalculMnt(MatrixRecords[pColumnID]."Bank Account No.", rec."Period Start", rec."Period End"
                                    , TypeEcr, TypeMnt, FacteurArrondi
                                    , DateOpeVal, MatrixRecords[pColumnID].Company, ParamCpta."LCY Code", DeviseAffichage));
    end;

    local procedure DeviseAffichageOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure FiltreSocOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure FiltreBanqueOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure FacteurArrondiOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure TypeEcrOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure DateOpeValOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure TypePeriodeOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure TypeMntOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure LookupOKOnPush()
    var
        Date: Record Date;
    begin
        DernDate := rec."Period Start";
    end;
}

