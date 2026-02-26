Page 58025 "RTC Compare Price Offers"
{
    // //COR-RTC OFE 19/05/2010
    // //+OFF+OFFRE GESWAY 17/10/02 Compare les offres de prix fournisseurs
    //                        26/05/03 Ajout colonne Type
    //                        27/08/03 Ajout VALIDATE sur "Selected Doc. No." et "Selected Doc. Line No." -> UpdateSelectedVendor

    Caption = 'RTC Compare Price Offers';
    DataCaptionExpression = STRSUBSTNO('%1 %2', rec.GETFILTER("Document No."), Text007);
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = 39;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                group(Control800390000)
                {
                    Caption = 'Options';
                    field(RoundingFactor; RoundingFactor)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Rounding Factor';
                        OptionCaption = 'None,1,1000,1000000';
                    }
                    field(ShowColumnName; ShowColumnName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Column Name';
                    }
                    field(ShowFieldValue; ShowFieldValue)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Field';
                        OptionCaption = 'Quantity,Unit Cost (LCY),Line Amount (LCY)';
                    }
                }
                group("Matrix Options")
                {
                    Caption = 'Matrix Options';
                    field(MATRIX_CaptionRange; MATRIX_CaptionRange)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Column Set';
                        Editable = false;
                    }
                }
            }
            repeater(Control800390012)
            {
                ShowCaption = false;
                field(Type; rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = Basic;
                }
                field("Ordered Line"; rec."Ordered Line")
                {
                    ApplicationArea = Basic;
                }
                field(SelectedVendorNo; SelectedVendorNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Selected Vendor No.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        OfferPurchHeader.Reset;
                        OfferPurchHeader.SetCurrentkey("Attached to Doc. Type", "Attached to Doc. No.");
                        OfferPurchHeader.SetRange("Attached to Doc. Type", rec."Document Type");
                        OfferPurchHeader.SetRange("Attached to Doc. No.", rec."Document No.");

                        /*GL2024  if OfferPurchHeader.Find('-') then
                          if page.RunModal(page::"Related Price Offers List", OfferPurchHeader) = Action::LookupOK then begin
                                SelectedVendorNo := OfferPurchHeader."Buy-from Vendor No.";
                                UpdateSelectedVendor;
                                GetSelectedData;
                                CurrPage.Update(false);
                            end;*/
                    end;

                    trigger OnValidate()
                    begin
                        UpdateSelectedVendor;


                        SelectedVendorNoOnAfterValidat;
                    end;
                }
                field(SelectedValue; SelectedValue)
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    Caption = 'Selected Value';
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6];
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7];
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[8];
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[9];
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[10];
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[11];
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[12];
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[13];
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[14];
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[15];
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[16];
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[17];
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[18];
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[19];
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[20];
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[21];
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[22];
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[23];
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[24];
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[25];
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[26];
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[27];
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[28];
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[29];
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[30];
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[31];
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = Basic;
                    // BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_CaptionSet[32];
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
                actionref("Suggest Vendor1"; "Suggest Vendor") { }
                actionref("Generated Files List1"; "Generated Files List") { }

            }
            actionref("Previous Set1"; "Previous Set") { }

            actionref("Next Set1"; "Next Set") { }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Suggest Vendor")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Vendor';

                    trigger OnAction()
                    begin
                        Clear(PriceOfferMngt);
                        PriceOfferMngt.SuggestVendor(rec."Document No.", rec."Document Type");
                        CurrPage.Update(false);
                    end;
                }
                /*//GL2024  action("Select Vendor")
                 {
                     ApplicationArea = Basic;
                     Caption = 'Select Vendor';

                     trigger OnAction()
                     var
                         SelectPriceOffer: Report 8004090;
                     begin
                         PurchLine.Copy(Rec);
                         CurrPage.SetSelectionFilter(PurchLine);
                         Clear(SelectPriceOffer);
                         SelectPriceOffer.SetTableview(PurchLine);
                         SelectPriceOffer.InitRequest(rec."Document No.");
                         SelectPriceOffer.Run;
                     end;
                 }
                  action("Show Related Offers Lines")
                 {
                     ApplicationArea = Basic;
                     Caption = 'Show Related Offers Lines';
                     RunFormLink = Attached to Doc. No.="FIELD"(Document No.),Attached to Doc. Type="FIELD"(Document Type),No.="FIELD"(No.),Line No.="FIELD"(Line No.);
                     RunObject = Page 8004093;
                 }
                 separator(Action1100280025)
                 {
                 }*/
                /*  //GL2024    action("Create &New Offer")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Create &New Offer';

                        trigger OnAction()
                        var
                            PurchHeader: Record 38;
                          //GL2024  CreateNewPriceOffer: Report 8004091;
                        begin
                            PurchHeader.Reset;
                            PurchHeader.SetRange("Document Type",rec."Document Type");
                            PurchHeader.SetRange("No.",rec."Document No.");
                            PurchHeader.Find('-');
                            Clear(CreateNewPriceOffer);
                            CreateNewPriceOffer.InitRequest(PurchHeader."No.");
                            CreateNewPriceOffer.SetTableview(PurchHeader);
                            CreateNewPriceOffer.Run;
                        end;
                    }*/
                /* //GL2024   action("Make &Order")
                  {
                      ApplicationArea = Basic;
                      Caption = 'Make &Order';
                      Image = MakeOrder;

                      trigger OnAction()
                      var
                          OfferPriceToOrder: Report 8004094;
                      begin
                          OfferPurchHeader.Reset;
                          OfferPurchHeader.SetCurrentkey("Attached to Doc. Type","Attached to Doc. No.");
                          OfferPurchHeader.FilterGroup(2);
                          OfferPurchHeader.SetRange("Attached to Doc. Type",rec."Document Type");
                          OfferPurchHeader.SetRange("Attached to Doc. No.",rec."Document No.");
                          OfferPurchHeader.FilterGroup(0);

                          Clear(OfferPriceToOrder);
                          OfferPriceToOrder.SetTableview(OfferPurchHeader);
                          OfferPriceToOrder.Run;
                          CurrPage.Update(false);
                      end;
                  }
                  separator(Action1100280021)
                  {
                  }
                  action("Export Offers to Excel")
                  {
                      ApplicationArea = Basic;
                      Caption = 'Export Offers to Excel';

                      trigger OnAction()
                      var
                          ExportToExcel: Report 8004092;
                      begin
                          OfferPurchHeader.Reset;
                          OfferPurchHeader.SetCurrentkey("Attached to Doc. Type","Attached to Doc. No.");
                          OfferPurchHeader.FilterGroup(2);
                          OfferPurchHeader.SetRange("Attached to Doc. Type",rec."Document Type");
                          OfferPurchHeader.SetRange("Attached to Doc. No.",rec."Document No.");
                          OfferPurchHeader.FilterGroup(0);

                          Clear(ExportToExcel);
                          ExportToExcel.SetTableview(OfferPurchHeader);
                          ExportToExcel.Run;
                      end;
                  }
                  action("Import Offers from Excel")
                  {
                      ApplicationArea = Basic;
                      Caption = 'Import Offers from Excel';

                      trigger OnAction()
                      var
                          ImportToExcel: Report 8004093;
                      begin
                          Clear(ImportToExcel);
                          ImportToExcel.InitSourceDoc(rec."Document No.");
                          ImportToExcel.Run;
                      end;
                  }*/
                action("Generated Files List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generated Files List';

                    trigger OnAction()
                    var
                        PriceOfferSetup: Record 8004090;
                        OK: Integer;
                    begin
                        PriceOfferMngt.ShowGenerateFilesList;
                    end;
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
                    SetColumns(Matrix_setwanted::Previous);
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
                    SetColumns(Matrix_setwanted::Next);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        lIndex: Integer;
    begin
        GetSelectedData;
        for lIndex := 1 to MATRIX_CurrSetLength do begin
            MATRIX_OnAfterGetRecord(lIndex);
        end;
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

    trigger OnOpenPage()
    begin
        ShowFieldValue := Showfieldvalue::"Unit Cost";
        GLSetup.Get;
        OnActivateForm;
    end;

    var
        GLSetup: Record 98;
        PurchLine: Record 39;
        InitialPurchLine: Record 39;
        OrderPurchLine: Record 39;
        OfferPurchLine: Record 39;
        OfferPurchHeader: Record 38;
        Currency: Record 4;
        CurrExchRate: Record 330;
        PriceOfferMngt: Codeunit 8004090;
        MatrixHeader: Text[250];
        ShowColumnName: Boolean;
        ShowFieldValue: Option Quantity,"Unit Cost","Line Amount";
        FieldValue: Decimal;
        TextValue: Text[30];
        PrevSelectedVendorNo: Code[20];
        SelectedVendorNo: Code[20];
        SelectedValue: Text[30];
        RoundingFactor: Option "None","1","1000","1000000";
        Window: Dialog;
        Text000: label '<Sign><Integer Thousand><Decimals,2>';
        Text001: label 'Suggest Vendor.\Item No. #1#############';
        Text002: label 'Vendor no. %1  was not consulted for quote no. %2.';
        Text003: label '<Precision,2:2><Standard Format,0>';
        Text004: label '<Standard Format,0>';
        Text005: label 'You cannot change Selected Vendor No. because the line is associated with purchases order no. %1.';
        Text006: label 'You cannot change Selected Vendor No. because the line is associated has been ordered.';
        Text007: label 'Purchase Quote';
        UseDate: Date;
        "-------": Integer;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        MATRIX_CurrSetLength: Integer;
        MATRIX_CellData: array[32] of Text[1024];
        MatrixRecord: Record 38;
        MatrixRecords: array[32] of Record 38;
        MatrixRecordRef: RecordRef;
        gMatrixBold: array[32] of Boolean;
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


    procedure UpdateSelectedVendor()
    begin
        if rec."Ordered Line" then begin
            OrderPurchLine.SetRange("Document Type", OrderPurchLine."document type"::Order);
            OrderPurchLine.SetRange("Line No.", rec."Line No.");
            OrderPurchLine.SetRange("Price Offer No.", rec."Document No.");
            if OrderPurchLine.Find('-') then
                Error(Text005, OrderPurchLine."Document No.")
            else
                Error(Text006);
        end;

        if SelectedVendorNo = '' then begin
            rec.Validate("Selected Doc. No.", '');
            rec.Validate("Selected Doc. Line No.", 0);
        end else begin
            OfferPurchLine.Reset;
            OfferPurchLine.SetCurrentkey("Attached to Doc. Type", "Attached to Doc. No.");
            OfferPurchLine.SetRange("Attached to Doc. Type", rec."Document Type");
            OfferPurchLine.SetRange("Attached to Doc. No.", rec."Document No.");
            OfferPurchLine.SetRange("Line No.", rec."Line No.");
            OfferPurchLine.SetRange("Buy-from Vendor No.", SelectedVendorNo);
            OfferPurchLine.SetRange("No.", rec."No.");

            if not OfferPurchLine.FindFirst then
                Error(Text002, SelectedVendorNo, rec."Document No.");

            rec.Validate("Selected Doc. No.", OfferPurchLine."Document No.");
            rec.Validate("Selected Doc. Line No.", OfferPurchLine."Line No.");
            rec."Direct Unit Cost" := OfferPurchLine."Direct Unit Cost";
            rec."Unit Cost (LCY)" := OfferPurchLine."Unit Cost (LCY)";
            rec.Validate("Discount 1 %", OfferPurchLine."Discount 1 %");
            rec.Validate("Discount 2 %", OfferPurchLine."Discount 2 %");
            rec.Validate("Discount 3 %", OfferPurchLine."Discount 3 %");
        end;
        rec.Modify;
    end;


    procedure GetSelectedData()
    var
        TempValue: Decimal;
        LineAmount: Decimal;
        PurchHeader: Record 38;
    begin
        SelectedValue := '';
        SelectedVendorNo := '';
        if rec."Selected Doc. No." <> '' then begin
            if PurchLine.Get(rec."Document Type", rec."Selected Doc. No.", rec."Selected Doc. Line No.") then begin
                PurchHeader.Get(rec."Document Type", rec."Selected Doc. No.");
                SelectedVendorNo := PurchLine."Buy-from Vendor No.";
                LineAmount := CalcLineAmount(PurchHeader, PurchLine);

                case ShowFieldValue of
                    Showfieldvalue::Quantity:
                        TempValue := PurchLine.Quantity;
                    Showfieldvalue::"Unit Cost":
                        if PurchLine.Quantity <> 0 then
                            TempValue := LineAmount / PurchLine.Quantity
                        else
                            TempValue := 0;
                    Showfieldvalue::"Line Amount":
                        TempValue := LineAmount;
                end;

                case RoundingFactor of
                    Roundingfactor::"1":
                        TempValue := ROUND(TempValue, 1);
                    Roundingfactor::"1000":
                        TempValue := ROUND(TempValue / 1000, 0.1);
                    Roundingfactor::"1000000":
                        TempValue := ROUND(TempValue / 1000000, 0.1);
                end;

                if ShowFieldValue = Showfieldvalue::Quantity then
                    SelectedValue := Format(TempValue, 0, Text004)
                else
                    SelectedValue := Format(TempValue, 0, Text003);
            end;
        end;
    end;


    procedure CalcLineAmount(pPurchHeader: Record 38; var pPurchLine: Record 39): Decimal
    var
        lAmount: Decimal;
    begin
        with pPurchLine do
            if Quantity = 0 then
                lAmount := 0
            else begin
                if pPurchHeader.Status = pPurchHeader.Status::Open then begin
                    lAmount := "Line Amount" - "Inv. Discount Amount";
                    if ("VAT %" <> 0) and (pPurchHeader."Prices Including VAT") then
                        lAmount := lAmount / (1 + ("VAT %" / 100));
                end else
                    if "VAT %" <> 0 then
                        lAmount := "Outstanding Amount (LCY)" / (1 + ("VAT %" / 100))
                    else
                        lAmount := "Outstanding Amount (LCY)";
            end;
        exit(lAmount);
    end;


    procedure SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit 9200;
        DateFilter: Text[30];
        lIndex: Integer;
        CaptionFieldNo: Integer;
    begin
        Clear(MATRIX_CaptionSet);
        Clear(MatrixRecords);

        MatrixRecordRef.GetTable(MatrixRecord);
        MatrixRecordRef.SetTable(MatrixRecord);

        if ShowColumnName then
            CaptionFieldNo := MatrixRecord.FieldNo("Buy-from Vendor Name")
        else
            CaptionFieldNo := MatrixRecord.FieldNo("Buy-from Vendor No.");

        MatrixMgt.GenerateMatrixData(MatrixRecordRef, pPeriodType, ArrayLen(MatrixRecords), CaptionFieldNo, MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

        if MATRIX_CurrSetLength > 0 then begin
            lIndex := 1;
            //COR-RTC OFE 19/05/2010
            //MatrixRecord.SETPOSITION(MATRIX_PKFirstRecInCurrSet);
            //MatrixRecord.FIND;
            MatrixRecord.FindSet;
            //COR-RTC//
            repeat
                MatrixRecords[lIndex].Copy(MatrixRecord);
                lIndex += +1;
            until (lIndex > MATRIX_CurrSetLength) or (MatrixRecord.Next <> 1);
        end;
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    var
        FoundRec: Boolean;
        LineAmount: Decimal;
        PurchHeader: Record 38;
    begin
        PurchHeader.Get(rec."Document Type", MatrixRecords[ColumnID]."No.");
        if PurchHeader."Posting Date" = 0D then
            UseDate := WorkDate
        else
            UseDate := OfferPurchHeader."Posting Date";

        MatrixRecords[ColumnID].CalcFields("Price Offer Amount");
        FieldValue := MatrixRecords[ColumnID]."Price Offer Amount";
        FieldValue :=
          CurrExchRate.ExchangeAmtFCYToLCY(
            UseDate, PurchHeader."Currency Code", FieldValue, PurchHeader."Currency Factor");
        //#5798
        //FoundRec := PurchLine.GET("Document Type",CurrForm.ShowInMatrix.MatrixRec."No.","Line No.");
        FoundRec := false;
        if PurchLine.Get(rec."Document Type", MatrixRecords[ColumnID]."No.", rec."Line No.") then begin
            if (PurchLine.Type = rec.Type) and (PurchLine."No." = rec."No.") then
                FoundRec := true
        end;
        if FoundRec = false then begin
            PurchLine.SetRange("Document Type", rec."Document Type");
            PurchLine.SetRange("Document No.", MatrixRecords[ColumnID]."No.");
            PurchLine.SetRange(Type, rec.Type);
            PurchLine.SetRange("No.", rec."No.");
            FoundRec := PurchLine.FindFirst
        end;
        //#5798//

        if not FoundRec then
            PurchLine.Init;
        LineAmount := CalcLineAmount(PurchHeader, PurchLine);

        case ShowFieldValue of
            Showfieldvalue::Quantity:
                FieldValue := PurchLine.Quantity;
            Showfieldvalue::"Unit Cost":
                if PurchLine.Quantity <> 0 then
                    FieldValue := LineAmount / PurchLine.Quantity
                else
                    FieldValue := 0;
            Showfieldvalue::"Line Amount":
                FieldValue := LineAmount;
        end;

        case RoundingFactor of
            Roundingfactor::"1":
                FieldValue := ROUND(FieldValue, 1);
            Roundingfactor::"1000":
                FieldValue := ROUND(FieldValue / 1000, 0.1);
            Roundingfactor::"1000000":
                FieldValue := ROUND(FieldValue / 1000000, 0.1);
        end;

        MATRIX_CellData[ColumnID] := '';
        if FoundRec then begin
            if FieldValue = 0 then
                MATRIX_CellData[ColumnID] := '?.??'
            else
                if ShowFieldValue = Showfieldvalue::Quantity then
                    MATRIX_CellData[ColumnID] := Format(FieldValue, 0, Text004)
                else
                    //#4756
                    //      TextValue := FORMAT(FieldValue,0,Text003);
                    MATRIX_CellData[ColumnID] := Format(CurrExchRate.ExchangeAmtFCYToLCY(
                           UseDate, PurchHeader."Currency Code", FieldValue, PurchHeader."Currency Factor"), 0, Text003);
            //#4756//
        end;

        gMatrixBold[ColumnID] := ((rec."Selected Doc. No." = PurchLine."Document No.") and
                                  (rec."Selected Doc. Line No." = PurchLine."Line No."));
    end;


    procedure fInitialize()
    begin
        MatrixRecord.SetCurrentkey("Attached to Doc. Type", "Attached to Doc. No.");
        MatrixRecord.SetRange("Attached to Doc. Type", rec."Document Type");
        MatrixRecord.SetRange("Attached to Doc. No.", rec."Document No.");
    end;

    local procedure SelectedVendorNoOnAfterValidat()
    begin
        GetSelectedData;
        CurrPage.Update(false);
    end;

    local procedure OnActivateForm()
    begin
        /*
        CurrForm.ShowInMatrix.MatrixRec.SETCURRENTKEY("Attached to Doc. Type","Attached to Doc. No.");
        CurrForm.ShowInMatrix.MatrixRec.SETRANGE("Attached to Doc. Type","Document Type");
        CurrForm.ShowInMatrix.MatrixRec.SETRANGE("Attached to Doc. No.","Document No.");
        */
        fInitialize();
        SetColumns(Matrix_setwanted::Initial);

    end;

    local procedure MATRIXCellData1OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[1];
        Field1Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData2OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[2];
        Field2Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData3OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[3];
        Field3Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData4OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[4];
        Field4Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData5OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[5];
        Field5Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData6OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[6];
        Field6Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData7OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[7];
        Field7Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData8OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[8];
        Field8Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData9OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[9];
        Field9Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData10OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[10];
        Field10Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData11OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[11];
        Field11Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData12OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[12];
        Field12Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData13OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[13];
        Field13Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData14OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[14];
        Field14Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData15OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[15];
        Field15Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData16OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[16];
        Field16Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData17OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[17];
        Field17Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData18OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[18];
        Field18Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData19OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[19];
        Field19Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData20OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[20];
        Field20Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData21OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[21];
        Field21Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData22OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[22];
        Field22Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData23OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[23];
        Field23Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData24OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[24];
        Field24Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData25OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[25];
        Field25Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData26OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[26];
        Field26Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData27OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[27];
        Field27Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData28OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[28];
        Field28Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData29OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[29];
        Field29Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData30OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[30];
        Field30Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData31OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[31];
        Field31Emphasize := lFontBold;
    end;

    local procedure MATRIXCellData32OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := gMatrixBold[32];
        Field32Emphasize := lFontBold;
    end;
}

