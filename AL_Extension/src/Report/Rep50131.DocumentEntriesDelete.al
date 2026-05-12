report 50131 "Document Entries Delete"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/DocumentEntriesDelete.rdlc';
    Caption = 'Ecritures document';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                  WHERE(Number = FILTER(1 ..));
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Text001___FORMAT_DocNoFilter_; Text001 + FORMAT(DocNoFilter))
            {
            }
            column(Text002___PostingDateFilter; Text002 + PostingDateFilter)
            {
            }
            column(DocEntry__No__of_Records_; DocEntry."No. of Records")
            {
            }
            column(DocEntry__Table_Name_; DocEntry."Table Name")
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(CurrencyCaptionRBC; CurrencyCaptionRBC)
            {
            }
            column(Document_EntriesCaption; Document_EntriesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Navigate_FiltersCaption; Navigate_FiltersCaptionLbl)
            {
            }
            column(DocEntry__No__of_Records_Caption; DocEntry__No__of_Records_CaptionLbl)
            {
            }
            column(DocEntry__Table_Name_Caption; DocEntry__Table_Name_CaptionLbl)
            {
            }
            column(Integer_Number; Number)
            {
            }
            dataitem("Service Ledger Entry"; "Service Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date");
                column(Service_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Service_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Service_Ledger_Entry_Description; Description)
                {
                }
                column(Service_Ledger_Entry__Amount__LCY__; "Amount (LCY)")
                {
                }
                column(Service_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Service_Ledger_Entry__Service_Contract_No__; "Service Contract No.")
                {
                }
                column(Service_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Service_Ledger_Entry__Service_Contract_No__Caption; FIELDCAPTION("Service Contract No."))
                {
                }
                column(Service_Ledger_Entry__Amount__LCY__Caption; FIELDCAPTION("Amount (LCY)"))
                {
                }
                column(Service_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Service_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Service_Ledger_Entry__Posting_Date_Caption; Service_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Service Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Warranty Ledger Entry"; "Warranty Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date");
                column(Warranty_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Warranty_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Warranty_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Warranty_Ledger_Entry_Description; Description)
                {
                }
                column(Warranty_Ledger_Entry_Amount; Amount)
                {
                }
                column(Warranty_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Warranty_Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(Warranty_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Warranty_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Warranty_Ledger_Entry__Posting_Date_Caption; Warranty_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Warranty Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Service Shipment Header"; "Service Shipment Header")
            {
                DataItemTableView = SORTING("No.");
                column(CurrencyCaption; CurrencyCaption)
                {
                }
                column(Service_Shipment_Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Service_Shipment_Header__No__; "No.")
                {
                }
                column(Service_Shipment_Header_Description; Description)
                {
                }
                column(Service_Shipment_Header__Currency_Code_; "Currency Code")
                {
                }
                column(Service_Shipment_Header__Posting_Date__Control299; FORMAT("Posting Date"))
                {
                }
                column(Service_Shipment_Header__No___Control304; "No.")
                {
                }
                column(Service_Shipment_Header_Description_Control418; Description)
                {
                }
                column(Service_Shipment_Header_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Service_Shipment_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Service_Shipment_Header__Posting_Date_Caption; Service_Shipment_Header__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Service Shipment Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemTableView = SORTING("No.");
                column(CurrencyCaption_Control49; CurrencyCaption)
                {
                }
                column(Sales_Shipment_Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Sales_Shipment_Header__No__; "No.")
                {
                }
                column(Sales_Shipment_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
                {
                }
                column(Sales_Shipment_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
                {
                }
                column(Sales_Shipment_Header__Posting_Description_; "Posting Description")
                {
                }
                column(Sales_Shipment_Header__Currency_Code_; "Currency Code")
                {
                }
                column(Sales_Shipment_Header__Posting_Date__Control431; FORMAT("Posting Date"))
                {
                }
                column(Sales_Shipment_Header__No___Control432; "No.")
                {
                }
                column(Sales_Shipment_Header__Sell_to_Customer_No___Control433; "Sell-to Customer No.")
                {
                }
                column(Sales_Shipment_Header__Bill_to_Customer_No___Control483; "Bill-to Customer No.")
                {
                }
                column(Sales_Shipment_Header__Posting_Description__Control485; "Posting Description")
                {
                }
                column(Sales_Shipment_Header__Bill_to_Customer_No__Caption; FIELDCAPTION("Bill-to Customer No."))
                {
                }
                column(Sales_Shipment_Header__Sell_to_Customer_No__Caption; FIELDCAPTION("Sell-to Customer No."))
                {
                }
                column(Sales_Shipment_Header__Posting_Description_Caption; FIELDCAPTION("Posting Description"))
                {
                }
                column(Sales_Shipment_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Sales_Shipment_Header__Posting_Date_Caption; Sales_Shipment_Header__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Sales Shipment Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Document No.", DocNoFilter);
                end;
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemTableView = SORTING("No.");
                column(CurrencyCaption_Control116; CurrencyCaption)
                {
                }
                column(Sales_Invoice_Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Sales_Invoice_Header__No__; "No.")
                {
                }
                column(Sales_Invoice_Header__Posting_Description_; "Posting Description")
                {
                }
                column(Sales_Invoice_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
                {
                }
                column(Sales_Invoice_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
                {
                }
                column(Sales_Invoice_Header_Amount; Amount)
                {
                }
                column(Sales_Invoice_Header__Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(Sales_Invoice_Header__Currency_Code_; "Currency Code")
                {
                }
                column(Sales_Invoice_Header__Posting_Date__Control430; FORMAT("Posting Date"))
                {
                }
                column(Sales_Invoice_Header__No___Control499; "No.")
                {
                }
                column(Sales_Invoice_Header__Posting_Description__Control515; "Posting Description")
                {
                }
                column(Sales_Invoice_Header__Sell_to_Customer_No___Control520; "Sell-to Customer No.")
                {
                }
                column(Sales_Invoice_Header__Bill_to_Customer_No___Control522; "Bill-to Customer No.")
                {
                }
                column(Sales_Invoice_Header_Amount_Control536; Amount)
                {
                }
                column(Sales_Invoice_Header__Amount_Including_VAT__Control537; "Amount Including VAT")
                {
                }
                column(Sales_Invoice_Header__Bill_to_Customer_No__Caption; FIELDCAPTION("Bill-to Customer No."))
                {
                }
                column(Sales_Invoice_Header__Sell_to_Customer_No__Caption; FIELDCAPTION("Sell-to Customer No."))
                {
                }
                column(Sales_Invoice_Header__Posting_Description_Caption; FIELDCAPTION("Posting Description"))
                {
                }
                column(Sales_Invoice_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Sales_Invoice_Header__Posting_Date_Caption; Sales_Invoice_Header__Posting_Date_CaptionLbl)
                {
                }
                column(Sales_Invoice_Header_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(Sales_Invoice_Header__Amount_Including_VAT_Caption; FIELDCAPTION("Amount Including VAT"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF PrintAmountsInLCY THEN BEGIN
                        IF "Currency Code" <> '' THEN BEGIN
                            Amount := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor");
                            "Amount Including VAT" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                      "Amount Including VAT", "Currency Factor");
                        END;
                    END;
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Sales Invoice Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Document No.", DocNoFilter);
                end;
            }
            dataitem("Return Receipt Header"; "Return Receipt Header")
            {
                DataItemTableView = SORTING("No.");
                column(CurrencyCaption_Control118; CurrencyCaption)
                {
                }
                column(Return_Receipt_Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Return_Receipt_Header__No__; "No.")
                {
                }
                column(Return_Receipt_Header__Posting_Description_; "Posting Description")
                {
                }
                column(Return_Receipt_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
                {
                }
                column(Return_Receipt_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
                {
                }
                column(Return_Receipt_Header__Currency_Code_; "Currency Code")
                {
                }
                column(Return_Receipt_Header__Posting_Date__Control543; FORMAT("Posting Date"))
                {
                }
                column(Return_Receipt_Header__No___Control544; "No.")
                {
                }
                column(Return_Receipt_Header__Posting_Description__Control545; "Posting Description")
                {
                }
                column(Return_Receipt_Header__Sell_to_Customer_No___Control546; "Sell-to Customer No.")
                {
                }
                column(Return_Receipt_Header__Bill_to_Customer_No___Control547; "Bill-to Customer No.")
                {
                }
                column(Return_Receipt_Header__Bill_to_Customer_No__Caption; FIELDCAPTION("Bill-to Customer No."))
                {
                }
                column(Return_Receipt_Header__Sell_to_Customer_No__Caption; FIELDCAPTION("Sell-to Customer No."))
                {
                }
                column(Return_Receipt_Header__Posting_Description_Caption; FIELDCAPTION("Posting Description"))
                {
                }
                column(Return_Receipt_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Return_Receipt_Header__Posting_Date_Caption; Return_Receipt_Header__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Return Receipt Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Return Receipt Line"; "Return Receipt Line")
            {
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Document No.", DocNoFilter);
                end;
            }
            dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
            {
                DataItemTableView = SORTING("No.");
                column(CurrencyCaption_Control162; CurrencyCaption)
                {
                }
                column(Sales_Cr_Memo_Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Sales_Cr_Memo_Header__No__; "No.")
                {
                }
                column(Sales_Cr_Memo_Header__Posting_Description_; "Posting Description")
                {
                }
                column(Sales_Cr_Memo_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
                {
                }
                column(Sales_Cr_Memo_Header_Amount; Amount)
                {
                }
                column(Sales_Cr_Memo_Header__Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(Sales_Cr_Memo_Header__Currency_Code_; "Currency Code")
                {
                }
                column(Sales_Cr_Memo_Header__Amount_Including_VAT__Control550; "Amount Including VAT")
                {
                }
                column(Sales_Cr_Memo_Header_Amount_Control551; Amount)
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Customer_No___Control552; "Bill-to Customer No.")
                {
                }
                column(Sales_Cr_Memo_Header__Sell_to_Customer_No___Control553; "Sell-to Customer No.")
                {
                }
                column(Sales_Cr_Memo_Header__Posting_Description__Control554; "Posting Description")
                {
                }
                column(Sales_Cr_Memo_Header__No___Control555; "No.")
                {
                }
                column(Sales_Cr_Memo_Header__Posting_Date__Control556; FORMAT("Posting Date"))
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Customer_No__Caption; FIELDCAPTION("Bill-to Customer No."))
                {
                }
                column(Sales_Cr_Memo_Header__Sell_to_Customer_No__Caption; FIELDCAPTION("Sell-to Customer No."))
                {
                }
                column(Sales_Cr_Memo_Header__Posting_Description_Caption; FIELDCAPTION("Posting Description"))
                {
                }
                column(Sales_Cr_Memo_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Sales_Cr_Memo_Header__Posting_Date_Caption; Sales_Cr_Memo_Header__Posting_Date_CaptionLbl)
                {
                }
                column(Sales_Cr_Memo_Header__Amount_Including_VAT_Caption; FIELDCAPTION("Amount Including VAT"))
                {
                }
                column(Sales_Cr_Memo_Header_AmountCaption; FIELDCAPTION(Amount))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF PrintAmountsInLCY THEN BEGIN
                        IF "Currency Code" <> '' THEN BEGIN
                            Amount := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor");
                            "Amount Including VAT" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                      "Amount Including VAT", "Currency Factor");
                        END;
                    END;
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Sales Cr.Memo Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Document No.", DocNoFilter);
                end;
            }
            dataitem("Issued Reminder Header"; "Issued Reminder Header")
            {
                DataItemTableView = SORTING("No.");
                column(CurrencyCaption_Control163; CurrencyCaption)
                {
                }
                column(Issued_Reminder_Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Issued_Reminder_Header__No__; "No.")
                {
                }
                column(Issued_Reminder_Header__Posting_Description_; "Posting Description")
                {
                }
                column(Issued_Reminder_Header__Currency_Code_; "Currency Code")
                {
                }
                column(Issued_Reminder_Header__VAT_Amount_; "VAT Amount")
                {
                }
                column(Issued_Reminder_Header__Additional_Fee_; "Additional Fee")
                {
                }
                column(Issued_Reminder_Header__Interest_Amount_; "Interest Amount")
                {
                }
                column(Issued_Reminder_Header__Remaining_Amount_; "Remaining Amount")
                {
                }
                column(Issued_Reminder_Header__Posting_Date__Control557; FORMAT("Posting Date"))
                {
                }
                column(Issued_Reminder_Header__No___Control558; "No.")
                {
                }
                column(Issued_Reminder_Header__Posting_Description__Control559; "Posting Description")
                {
                }
                column(Issued_Reminder_Header__VAT_Amount__Control561; "VAT Amount")
                {
                }
                column(Issued_Reminder_Header__Additional_Fee__Control562; "Additional Fee")
                {
                }
                column(Issued_Reminder_Header__Interest_Amount__Control563; "Interest Amount")
                {
                }
                column(Issued_Reminder_Header__Remaining_Amount__Control564; "Remaining Amount")
                {
                }
                column(Issued_Reminder_Header__Posting_Description_Caption; FIELDCAPTION("Posting Description"))
                {
                }
                column(Issued_Reminder_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Issued_Reminder_Header__Posting_Date_Caption; Issued_Reminder_Header__Posting_Date_CaptionLbl)
                {
                }
                column(Issued_Reminder_Header__Remaining_Amount_Caption; FIELDCAPTION("Remaining Amount"))
                {
                }
                column(Issued_Reminder_Header__Interest_Amount_Caption; FIELDCAPTION("Interest Amount"))
                {
                }
                column(Issued_Reminder_Header__Additional_Fee_Caption; FIELDCAPTION("Additional Fee"))
                {
                }
                column(Issued_Reminder_Header__VAT_Amount_Caption; FIELDCAPTION("VAT Amount"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF PrintAmountsInLCY THEN BEGIN
                        IF "Currency Code" <> '' THEN BEGIN
                            "Remaining Amount" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                  "Remaining Amount", CurrExchRate.ExchangeRate("Posting Date", "Currency Code"));
                            "Interest Amount" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                  "Interest Amount", CurrExchRate.ExchangeRate("Posting Date", "Currency Code"));
                            "Additional Fee" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                  "Additional Fee", CurrExchRate.ExchangeRate("Posting Date", "Currency Code"));
                            "VAT Amount" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                  "VAT Amount", CurrExchRate.ExchangeRate("Posting Date", "Currency Code"));
                        END;
                    END;
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Issued Reminder Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Issued Fin. Charge Memo Header"; "Issued Fin. Charge Memo Header")
            {
                DataItemTableView = SORTING("No.");
                column(CurrencyCaption_Control164; CurrencyCaption)
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Issued_Fin__Charge_Memo_Header__No__; "No.")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Posting_Description_; "Posting Description")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Remaining_Amount_; "Remaining Amount")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Interest_Amount_; "Interest Amount")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Additional_Fee_; "Additional Fee")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__VAT_Amount_; "VAT Amount")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Currency_Code_; "Currency Code")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Posting_Date__Control565; FORMAT("Posting Date"))
                {
                }
                column(Issued_Fin__Charge_Memo_Header__No___Control566; "No.")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Posting_Description__Control567; "Posting Description")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Remaining_Amount__Control568; "Remaining Amount")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Interest_Amount__Control569; "Interest Amount")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Additional_Fee__Control570; "Additional Fee")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__VAT_Amount__Control571; "VAT Amount")
                {
                }
                column(Issued_Fin__Charge_Memo_Header__VAT_Amount_Caption; FIELDCAPTION("VAT Amount"))
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Additional_Fee_Caption; FIELDCAPTION("Additional Fee"))
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Interest_Amount_Caption; FIELDCAPTION("Interest Amount"))
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Remaining_Amount_Caption; FIELDCAPTION("Remaining Amount"))
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Posting_Description_Caption; FIELDCAPTION("Posting Description"))
                {
                }
                column(Issued_Fin__Charge_Memo_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Issued_Fin__Charge_Memo_Header__Posting_Date_Caption; Issued_Fin__Charge_Memo_Header__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF PrintAmountsInLCY THEN BEGIN
                        IF "Currency Code" <> '' THEN BEGIN
                            "Remaining Amount" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                  "Remaining Amount", CurrExchRate.ExchangeRate("Posting Date", "Currency Code"));
                            "Interest Amount" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                  "Interest Amount", CurrExchRate.ExchangeRate("Posting Date", "Currency Code"));
                            "Additional Fee" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                  "Additional Fee", CurrExchRate.ExchangeRate("Posting Date", "Currency Code"));
                            "VAT Amount" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                  "VAT Amount", CurrExchRate.ExchangeRate("Posting Date", "Currency Code"));
                        END;
                    END;
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Issued Fin. Charge Memo Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Purch. Rcpt. Header"; 120)
            {
                DataItemTableView = SORTING("No.");
                column(CurrencyCaption_Control165; CurrencyCaption)
                {
                }
                column(Purch__Rcpt__Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Purch__Rcpt__Header__No__; "No.")
                {
                }
                column(Purch__Rcpt__Header__Posting_Description_; "Posting Description")
                {
                }
                column(Purch__Rcpt__Header__Buy_from_Vendor_No__; "Buy-from Vendor No.")
                {
                }
                column(Purch__Rcpt__Header__Pay_to_Vendor_No__; "Pay-to Vendor No.")
                {
                }
                column(Purch__Rcpt__Header__Currency_Code_; "Currency Code")
                {
                }
                column(Purch__Rcpt__Header__Posting_Date__Control573; FORMAT("Posting Date"))
                {
                }
                column(Purch__Rcpt__Header__No___Control574; "No.")
                {
                }
                column(Purch__Rcpt__Header__Posting_Description__Control575; "Posting Description")
                {
                }
                column(Purch__Rcpt__Header__Buy_from_Vendor_No___Control576; "Buy-from Vendor No.")
                {
                }
                column(Purch__Rcpt__Header__Pay_to_Vendor_No___Control577; "Pay-to Vendor No.")
                {
                }
                column(Purch__Rcpt__Header__Pay_to_Vendor_No__Caption; FIELDCAPTION("Pay-to Vendor No."))
                {
                }
                column(Purch__Rcpt__Header__Buy_from_Vendor_No__Caption; FIELDCAPTION("Buy-from Vendor No."))
                {
                }
                column(Purch__Rcpt__Header__Posting_Description_Caption; FIELDCAPTION("Posting Description"))
                {
                }
                column(Purch__Rcpt__Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Purch__Rcpt__Header__Posting_Date_Caption; Purch__Rcpt__Header__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Purch. Rcpt. Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Document No.", DocNoFilter);
                end;
            }
            dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
            {
                DataItemTableView = SORTING("No.");
                column(CurrencyCaption_Control172; CurrencyCaption)
                {
                }
                column(Purch__Inv__Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Purch__Inv__Header__No__; "No.")
                {
                }
                column(Purch__Inv__Header__Posting_Description_; "Posting Description")
                {
                }
                column(Purch__Inv__Header__Buy_from_Vendor_No__; "Buy-from Vendor No.")
                {
                }
                column(Purch__Inv__Header__Pay_to_Vendor_No__; "Pay-to Vendor No.")
                {
                }
                column(Purch__Inv__Header_Amount; Amount)
                {
                }
                column(Purch__Inv__Header__Currency_Code_; "Currency Code")
                {
                }
                column(Purch__Inv__Header__Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(Purch__Inv__Header__Posting_Date__Control579; FORMAT("Posting Date"))
                {
                }
                column(Purch__Inv__Header__No___Control580; "No.")
                {
                }
                column(Purch__Inv__Header__Posting_Description__Control581; "Posting Description")
                {
                }
                column(Purch__Inv__Header__Buy_from_Vendor_No___Control582; "Buy-from Vendor No.")
                {
                }
                column(Purch__Inv__Header__Pay_to_Vendor_No___Control583; "Pay-to Vendor No.")
                {
                }
                column(Purch__Inv__Header_Amount_Control584; Amount)
                {
                }
                column(Purch__Inv__Header__Amount_Including_VAT__Control586; "Amount Including VAT")
                {
                }
                column(Purch__Inv__Header_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(Purch__Inv__Header__Pay_to_Vendor_No__Caption; FIELDCAPTION("Pay-to Vendor No."))
                {
                }
                column(Purch__Inv__Header__Buy_from_Vendor_No__Caption; FIELDCAPTION("Buy-from Vendor No."))
                {
                }
                column(Purch__Inv__Header__Posting_Description_Caption; FIELDCAPTION("Posting Description"))
                {
                }
                column(Purch__Inv__Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Purch__Inv__Header__Posting_Date_Caption; Purch__Inv__Header__Posting_Date_CaptionLbl)
                {
                }
                column(Purch__Inv__Header__Amount_Including_VAT_Caption; FIELDCAPTION("Amount Including VAT"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF PrintAmountsInLCY THEN BEGIN
                        IF "Currency Code" <> '' THEN BEGIN
                            Amount := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor");
                            "Amount Including VAT" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                      "Amount Including VAT", "Currency Factor");
                        END;
                    END;
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Purch. Inv. Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Document No.", DocNoFilter);
                end;
            }
            dataitem("Return Shipment Header"; "Return Shipment Header")
            {
                DataItemTableView = SORTING("No.");
                column(CurrencyCaption_Control173; CurrencyCaption)
                {
                }
                column(Return_Shipment_Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Return_Shipment_Header__No__; "No.")
                {
                }
                column(Return_Shipment_Header__Posting_Description_; "Posting Description")
                {
                }
                column(Return_Shipment_Header__Buy_from_Vendor_No__; "Buy-from Vendor No.")
                {
                }
                column(Return_Shipment_Header__Pay_to_Vendor_No__; "Pay-to Vendor No.")
                {
                }
                column(Return_Shipment_Header__Currency_Code_; "Currency Code")
                {
                }
                column(Return_Shipment_Header__Posting_Date__Control595; FORMAT("Posting Date"))
                {
                }
                column(Return_Shipment_Header__No___Control596; "No.")
                {
                }
                column(Return_Shipment_Header__Posting_Description__Control597; "Posting Description")
                {
                }
                column(Return_Shipment_Header__Buy_from_Vendor_No___Control598; "Buy-from Vendor No.")
                {
                }
                column(Return_Shipment_Header__Pay_to_Vendor_No___Control599; "Pay-to Vendor No.")
                {
                }
                column(Return_Shipment_Header__Pay_to_Vendor_No__Caption; FIELDCAPTION("Pay-to Vendor No."))
                {
                }
                column(Return_Shipment_Header__Buy_from_Vendor_No__Caption; FIELDCAPTION("Buy-from Vendor No."))
                {
                }
                column(Return_Shipment_Header__Posting_Description_Caption; FIELDCAPTION("Posting Description"))
                {
                }
                column(Return_Shipment_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Return_Shipment_Header__Posting_Date_Caption; Return_Shipment_Header__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Return Shipment Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Return Shipment Line"; "Return Shipment Line")
            {
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Document No.", DocNoFilter);
                end;
            }
            dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
            {
                DataItemTableView = SORTING("No.");
                column(CurrencyCaption_Control297; CurrencyCaption)
                {
                }
                column(Purch__Cr__Memo_Hdr___Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Purch__Cr__Memo_Hdr___No__; "No.")
                {
                }
                column(Purch__Cr__Memo_Hdr___Posting_Description_; "Posting Description")
                {
                }
                column(Purch__Cr__Memo_Hdr___Buy_from_Vendor_No__; "Buy-from Vendor No.")
                {
                }
                column(Purch__Cr__Memo_Hdr___Pay_to_Vendor_No__; "Pay-to Vendor No.")
                {
                }
                column(Purch__Cr__Memo_Hdr__Amount; Amount)
                {
                }
                column(Purch__Cr__Memo_Hdr___Currency_Code_; "Currency Code")
                {
                }
                column(Purch__Cr__Memo_Hdr___Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(Purch__Cr__Memo_Hdr___Posting_Date__Control601; FORMAT("Posting Date"))
                {
                }
                column(Purch__Cr__Memo_Hdr___No___Control602; "No.")
                {
                }
                column(Purch__Cr__Memo_Hdr___Posting_Description__Control603; "Posting Description")
                {
                }
                column(Purch__Cr__Memo_Hdr___Buy_from_Vendor_No___Control604; "Buy-from Vendor No.")
                {
                }
                column(Purch__Cr__Memo_Hdr___Pay_to_Vendor_No___Control605; "Pay-to Vendor No.")
                {
                }
                column(Purch__Cr__Memo_Hdr__Amount_Control606; Amount)
                {
                }
                column(Purch__Cr__Memo_Hdr___Amount_Including_VAT__Control608; "Amount Including VAT")
                {
                }
                column(Purch__Cr__Memo_Hdr__AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(Purch__Cr__Memo_Hdr___Pay_to_Vendor_No__Caption; FIELDCAPTION("Pay-to Vendor No."))
                {
                }
                column(Purch__Cr__Memo_Hdr___Buy_from_Vendor_No__Caption; FIELDCAPTION("Buy-from Vendor No."))
                {
                }
                column(Purch__Cr__Memo_Hdr___Posting_Description_Caption; FIELDCAPTION("Posting Description"))
                {
                }
                column(Purch__Cr__Memo_Hdr___No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Purch__Cr__Memo_Hdr___Posting_Date_Caption; Purch__Cr__Memo_Hdr___Posting_Date_CaptionLbl)
                {
                }
                column(Purch__Cr__Memo_Hdr___Amount_Including_VAT_Caption; FIELDCAPTION("Amount Including VAT"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF PrintAmountsInLCY THEN BEGIN
                        IF "Currency Code" <> '' THEN BEGIN
                            Amount := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor");
                            "Amount Including VAT" := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code",
                                                      "Amount Including VAT", "Currency Factor");
                        END;
                    END;
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Purch. Cr. Memo Hdr." THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Document No.", DocNoFilter);
                end;
            }
            dataitem("Production Order"; "Production Order")
            {
                DataItemTableView = SORTING(Status, "No.");
                column(Production_Order__No__; "No.")
                {
                }
                column(Production_Order_Status; Status)
                {
                }
                column(Production_Order_Description; Description)
                {
                }
                column(Production_Order__Source_Type_; "Source Type")
                {
                }
                column(Production_Order__Source_No__; "Source No.")
                {
                }
                column(Production_Order__Unit_Cost_; "Unit Cost")
                {
                }
                column(Production_Order__Cost_Amount_; "Cost Amount")
                {
                }
                column(Production_Order__Cost_Amount_Caption; FIELDCAPTION("Cost Amount"))
                {
                }
                column(Production_Order__Unit_Cost_Caption; FIELDCAPTION("Unit Cost"))
                {
                }
                column(Production_Order__Source_No__Caption; FIELDCAPTION("Source No."))
                {
                }
                column(Production_Order__Source_Type_Caption; FIELDCAPTION("Source Type"))
                {
                }
                column(Production_Order_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Production_Order__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Production_Order_StatusCaption; FIELDCAPTION(Status))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Production Order" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY(Status, "No.");
                    SETRANGE(Status, "Production Order".Status::Released, "Production Order".Status::Finished);
                    SETFILTER("No.", DocNoFilter);
                end;
            }
            dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
            {
                DataItemTableView = SORTING("No.");
                column(Transfer_Shipment_Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Transfer_Shipment_Header__No__; "No.")
                {
                }
                column(Transfer_Shipment_Header__Transfer_from_Code_; "Transfer-from Code")
                {
                }
                column(Transfer_Shipment_Header__Transfer_from_Name_; "Transfer-from Name")
                {
                }
                column(Transfer_Shipment_Header__Transfer_to_Code_; "Transfer-to Code")
                {
                }
                column(Transfer_Shipment_Header__Transfer_to_Name_; "Transfer-to Name")
                {
                }
                column(Transfer_Shipment_Header__Transfer_to_Name_Caption; FIELDCAPTION("Transfer-to Name"))
                {
                }
                column(Transfer_Shipment_Header__Transfer_to_Code_Caption; FIELDCAPTION("Transfer-to Code"))
                {
                }
                column(Transfer_Shipment_Header__Transfer_from_Name_Caption; FIELDCAPTION("Transfer-from Name"))
                {
                }
                column(Transfer_Shipment_Header__Transfer_from_Code_Caption; FIELDCAPTION("Transfer-from Code"))
                {
                }
                column(Transfer_Shipment_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Transfer_Shipment_Header__Posting_Date_Caption; Transfer_Shipment_Header__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Transfer Shipment Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Document No.", DocNoFilter);
                end;
            }
            dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
            {
                DataItemTableView = SORTING("No.");
                column(Transfer_Receipt_Header__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Transfer_Receipt_Header__No__; "No.")
                {
                }
                column(Transfer_Receipt_Header__Transfer_from_Code_; "Transfer-from Code")
                {
                }
                column(Transfer_Receipt_Header__Transfer_from_Name_; "Transfer-from Name")
                {
                }
                column(Transfer_Receipt_Header__Transfer_to_Code_; "Transfer-to Code")
                {
                }
                column(Transfer_Receipt_Header__Transfer_to_Name_; "Transfer-to Name")
                {
                }
                column(Transfer_Receipt_Header__Transfer_to_Name_Caption; FIELDCAPTION("Transfer-to Name"))
                {
                }
                column(Transfer_Receipt_Header__Transfer_to_Code_Caption; FIELDCAPTION("Transfer-to Code"))
                {
                }
                column(Transfer_Receipt_Header__Transfer_from_Name_Caption; FIELDCAPTION("Transfer-from Name"))
                {
                }
                column(Transfer_Receipt_Header__Transfer_from_Code_Caption; FIELDCAPTION("Transfer-from Code"))
                {
                }
                column(Transfer_Receipt_Header__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Transfer_Receipt_Header__Posting_Date_Caption; Transfer_Receipt_Header__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Transfer Receipt Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Document No.", DocNoFilter);
                end;
            }
            dataitem("Posted Whse. Shipment Line"; "Posted Whse. Shipment Line")
            {
                DataItemTableView = SORTING("Posted Source No.", "Posting Date");
                column(Posted_Whse__Shipment_Line__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Posted_Whse__Shipment_Line__Item_No__; "Item No.")
                {
                }
                column(Posted_Whse__Shipment_Line_Quantity; Quantity)
                {
                }
                column(Posted_Whse__Shipment_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(Posted_Whse__Shipment_Line_Description; Description)
                {
                }
                column(Posted_Whse__Shipment_Line__Posted_Source_Document_; "Posted Source Document")
                {
                }
                column(Posted_Whse__Shipment_Line__Posted_Source_No__; "Posted Source No.")
                {
                }
                column(Posted_Whse__Shipment_Line_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(Posted_Whse__Shipment_Line__Unit_of_Measure_Code_Caption; FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column(Posted_Whse__Shipment_Line_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Posted_Whse__Shipment_Line__Item_No__Caption; FIELDCAPTION("Item No."))
                {
                }
                column(Posted_Whse__Shipment_Line__Posting_Date_Caption; Posted_Whse__Shipment_Line__Posting_Date_CaptionLbl)
                {
                }
                column(Posted_Whse__Shipment_Line__Posted_Source_No__Caption; FIELDCAPTION("Posted Source No."))
                {
                }
                column(Posted_Whse__Shipment_Line__Posted_Source_Document_Caption; FIELDCAPTION("Posted Source Document"))
                {
                }
                column(Posted_Whse__Shipment_Line_No_; "No.")
                {
                }
                column(Posted_Whse__Shipment_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Posted Whse. Shipment Line" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Posted Source No.", "Posting Date");
                    SETFILTER("Posted Source No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Posted Whse. Receipt Line"; "Posted Whse. Receipt Line")
            {
                DataItemTableView = SORTING("Posted Source No.", "Posting Date");
                column(Posted_Whse__Receipt_Line__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Posted_Whse__Receipt_Line_Description; Description)
                {
                }
                column(Posted_Whse__Receipt_Line__Item_No__; "Item No.")
                {
                }
                column(Posted_Whse__Receipt_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(Posted_Whse__Receipt_Line_Quantity; Quantity)
                {
                }
                column(Posted_Whse__Receipt_Line__Posted_Source_Document_; "Posted Source Document")
                {
                }
                column(Posted_Whse__Receipt_Line__Posted_Source_No__; "Posted Source No.")
                {
                }
                column(Posted_Whse__Receipt_Line_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(Posted_Whse__Receipt_Line__Unit_of_Measure_Code_Caption; FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column(Posted_Whse__Receipt_Line_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Posted_Whse__Receipt_Line__Item_No__Caption; FIELDCAPTION("Item No."))
                {
                }
                column(Posted_Whse__Receipt_Line__Posting_Date_Caption; Posted_Whse__Receipt_Line__Posting_Date_CaptionLbl)
                {
                }
                column(Posted_Whse__Receipt_Line__Posted_Source_No__Caption; FIELDCAPTION("Posted Source No."))
                {
                }
                column(Posted_Whse__Receipt_Line__Posted_Source_Document_Caption; FIELDCAPTION("Posted Source Document"))
                {
                }
                column(Posted_Whse__Receipt_Line_No_; "No.")
                {
                }
                column(Posted_Whse__Receipt_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Posted Whse. Receipt Line" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Posted Source No.", "Posting Date");
                    SETFILTER("Posted Source No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemTableView = SORTING("G/L Account No.", "Posting Date");
                column(G_L_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(G_L_Entry__Document_No__; "Document No.")
                {
                }
                column(G_L_Entry_Description; Description)
                {
                }
                column(G_L_Entry__VAT_Amount_; "VAT Amount")
                {
                }
                column(G_L_Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(G_L_Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(G_L_Entry__Entry_No__; "Entry No.")
                {
                }
                column(G_L_Entry_Quantity; Quantity)
                {
                }
                column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
                {
                }
                column(G_L_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(G_L_Entry__Credit_Amount_Caption; FIELDCAPTION("Credit Amount"))
                {
                }
                column(G_L_Entry__Debit_Amount_Caption; FIELDCAPTION("Debit Amount"))
                {
                }
                column(G_L_Entry__VAT_Amount_Caption; FIELDCAPTION("VAT Amount"))
                {
                }
                column(G_L_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(G_L_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(G_L_Entry__Posting_Date_Caption; G_L_Entry__Posting_Date_CaptionLbl)
                {
                }
                column(G_L_Entry_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(G_L_Entry__G_L_Account_No__Caption; FIELDCAPTION("G/L Account No."))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"G/L Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("VAT Entry"; "VAT Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date");
                column(VAT_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(VAT_Entry__Document_No__; "Document No.")
                {
                }
                column(VAT_Entry_Amount; Amount)
                {
                }
                column(VAT_Entry__Entry_No__; "Entry No.")
                {
                }
                column(VAT_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(VAT_Entry_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(VAT_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(VAT_Entry__Posting_Date_Caption; VAT_Entry__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"VAT Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.");
                column(CurrencyCaption_Control329; CurrencyCaption)
                {
                }
                column(Cust__Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Amount; Amount)
                {
                }
                column(Cust__Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Cust__Ledger_Entry_Description; Description)
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amount_; "Remaining Amount")
                {
                }
                column(Cust__Ledger_Entry__Currency_Code_; "Currency Code")
                {
                }
                column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
                {
                }
                column(Cust__Ledger_Entry__Posting_Date__Control652; FORMAT("Posting Date"))
                {
                }
                column(Cust__Ledger_Entry__Document_No___Control654; "Document No.")
                {
                }
                column(Cust__Ledger_Entry_Description_Control656; Description)
                {
                }
                column(Cust__Ledger_Entry__Amount__LCY__; "Amount (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amt___LCY__; "Remaining Amt. (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Customer_No___Control666; "Customer No.")
                {
                }
                column(Cust__Ledger_Entry__Entry_No___Control560; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amount_Caption; FIELDCAPTION("Remaining Amount"))
                {
                }
                column(Cust__Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(Cust__Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Cust__Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Cust__Ledger_Entry__Posting_Date_Caption; Cust__Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }
                column(Cust__Ledger_Entry__Customer_No__Caption; FIELDCAPTION("Customer No."))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Cust. Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
            {
                DataItemTableView = SORTING("Document No.");
                column(CurrencyCaption_Control398; CurrencyCaption)
                {
                }
                column(Detailed_Cust__Ledg__Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Detailed_Cust__Ledg__Entry__Document_No__; "Document No.")
                {
                }
                column(Detailed_Cust__Ledg__Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(Detailed_Cust__Ledg__Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(Detailed_Cust__Ledg__Entry__Entry_No__; "Entry No.")
                {
                }
                column(Detailed_Cust__Ledg__Entry__Document_Type_; "Document Type")
                {
                }
                column(Detailed_Cust__Ledg__Entry__Currency_Code_; "Currency Code")
                {
                }
                column(Detailed_Cust__Ledg__Entry__Posting_Date__Control496; FORMAT("Posting Date"))
                {
                }
                column(Detailed_Cust__Ledg__Entry__Document_No___Control498; "Document No.")
                {
                }
                column(Detailed_Cust__Ledg__Entry__Document_Type__Control668; "Document Type")
                {
                }
                column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                {
                }
                column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                {
                }
                column(Detailed_Cust__Ledg__Entry__Entry_No___Control549; "Entry No.")
                {
                }
                column(Detailed_Cust__Ledg__Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Detailed_Cust__Ledg__Entry__Credit_Amount_Caption; FIELDCAPTION("Credit Amount"))
                {
                }
                column(Detailed_Cust__Ledg__Entry__Debit_Amount_Caption; FIELDCAPTION("Debit Amount"))
                {
                }
                column(Detailed_Cust__Ledg__Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Detailed_Cust__Ledg__Entry__Posting_Date_Caption; Detailed_Cust__Ledg__Entry__Posting_Date_CaptionLbl)
                {
                }
                column(Detailed_Cust__Ledg__Entry__Document_Type_Caption; FIELDCAPTION("Document Type"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Detailed Cust. Ledg. Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Reminder/Fin. Charge Entry"; "Reminder/Fin. Charge Entry")
            {
                DataItemTableView = SORTING(Type, "No.");
                column(Reminder_Fin__Charge_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Reminder_Fin__Charge_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Reminder_Fin__Charge_Entry__Document_No__; "Document No.")
                {
                }
                column(Reminder_Fin__Charge_Entry__Reminder_Level_; "Reminder Level")
                {
                }
                column(Reminder_Fin__Charge_Entry__Interest_Amount_; "Interest Amount")
                {
                }
                column(Reminder_Fin__Charge_Entry__Remaining_Amount_; "Remaining Amount")
                {
                }
                column(Reminder_Fin__Charge_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Reminder_Fin__Charge_Entry__Interest_Amount_Caption; FIELDCAPTION("Interest Amount"))
                {
                }
                column(Reminder_Fin__Charge_Entry__Reminder_Level_Caption; FIELDCAPTION("Reminder Level"))
                {
                }
                column(Reminder_Fin__Charge_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Reminder_Fin__Charge_Entry__Posting_Date_Caption; Reminder_Fin__Charge_Entry__Posting_Date_CaptionLbl)
                {
                }
                column(Reminder_Fin__Charge_Entry__Remaining_Amount_Caption; FIELDCAPTION("Remaining Amount"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Reminder/Fin. Charge Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.");
                column(CurrencyCaption_Control305; CurrencyCaption)
                {
                }
                column(Vendor_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Vendor_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Vendor_Ledger_Entry_Description; Description)
                {
                }
                column(Vendor_Ledger_Entry_Amount; Amount)
                {
                }
                column(Vendor_Ledger_Entry__Remaining_Amount_; "Remaining Amount")
                {
                }
                column(Vendor_Ledger_Entry__Currency_Code_; "Currency Code")
                {
                }
                column(Vendor_Ledger_Entry__Posting_Date__Control674; FORMAT("Posting Date"))
                {
                }
                column(Vendor_Ledger_Entry__Document_No___Control676; "Document No.")
                {
                }
                column(Vendor_Ledger_Entry_Description_Control678; Description)
                {
                }
                column(Vendor_Ledger_Entry__Amount__LCY__; "Amount (LCY)")
                {
                }
                column(Vendor_Ledger_Entry__Remaining_Amt___LCY__; "Remaining Amt. (LCY)")
                {
                }
                column(Vendor_Ledger_Entry__Entry_No___Control541; "Entry No.")
                {
                }
                column(Vendor_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Vendor_Ledger_Entry__Remaining_Amount_Caption; FIELDCAPTION("Remaining Amount"))
                {
                }
                column(Vendor_Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(Vendor_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Vendor_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Vendor_Ledger_Entry__Posting_Date_Caption; Vendor_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Vendor Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
            {
                DataItemTableView = SORTING("Document No.");
                column(CurrencyCaption_Control328; CurrencyCaption)
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Entry_No__; "Entry No.")
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Document_Type_; "Document Type")
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Document_No__; "Document No.")
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Currency_Code_; "Currency Code")
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Posting_Date__Control682; FORMAT("Posting Date"))
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Document_Type__Control686; "Document Type")
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Document_No___Control688; "Document No.")
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Entry_No___Control548; "Entry No.")
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Credit_Amount_Caption; FIELDCAPTION("Credit Amount"))
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Debit_Amount_Caption; FIELDCAPTION("Debit Amount"))
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Posting_Date_Caption; Detailed_Vendor_Ledg__Entry__Posting_Date_CaptionLbl)
                {
                }
                column(Detailed_Vendor_Ledg__Entry__Document_Type_Caption; FIELDCAPTION("Document Type"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Detailed Vendor Ledg. Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.");
                column(Item_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Item_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Item_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Item_Ledger_Entry_Description; Description)
                {
                }
                column(Item_Ledger_Entry_Quantity; Quantity)
                {
                }
                column(Item_Ledger_Entry__Remaining_Quantity_; "Remaining Quantity")
                {
                }
                column(Item_Ledger_Entry_Open; FORMAT(Open))
                {
                }
                column(Item_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Item_Ledger_Entry__Remaining_Quantity_Caption; FIELDCAPTION("Remaining Quantity"))
                {
                }
                column(Item_Ledger_Entry_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(Item_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Item_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Item_Ledger_Entry__Posting_Date_Caption; Item_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }
                column(Item_Ledger_Entry_OpenCaption; CAPTIONCLASSTRANSLATE(FIELDCAPTION(Open)))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Item Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemTableView = SORTING("Document No.");
                column(Value_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Value_Entry__Document_No__; "Document No.")
                {
                }
                column(Value_Entry_Description; Description)
                {
                }
                column(Value_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Value_Entry__Valued_Quantity_; "Valued Quantity")
                {
                }
                column(Value_Entry__Invoiced_Quantity_; "Invoiced Quantity")
                {
                }
                column(Value_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Value_Entry__Invoiced_Quantity_Caption; FIELDCAPTION("Invoiced Quantity"))
                {
                }
                column(Value_Entry__Valued_Quantity_Caption; FIELDCAPTION("Valued Quantity"))
                {
                }
                column(Value_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Value_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Value_Entry__Posting_Date_Caption; Value_Entry__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Value Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Phys. Inventory Ledger Entry"; "Phys. Inventory Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date");
                column(Phys__Inventory_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Phys__Inventory_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Phys__Inventory_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Phys__Inventory_Ledger_Entry_Description; Description)
                {
                }
                column(Phys__Inventory_Ledger_Entry_Quantity; Quantity)
                {
                }
                column(Phys__Inventory_Ledger_Entry__Unit_Amount_; "Unit Amount")
                {
                }
                column(Phys__Inventory_Ledger_Entry__Unit_Cost_; "Unit Cost")
                {
                }
                column(Phys__Inventory_Ledger_Entry_Amount; Amount)
                {
                }
                column(Phys__Inventory_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Phys__Inventory_Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(Phys__Inventory_Ledger_Entry__Unit_Cost_Caption; FIELDCAPTION("Unit Cost"))
                {
                }
                column(Phys__Inventory_Ledger_Entry__Unit_Amount_Caption; FIELDCAPTION("Unit Amount"))
                {
                }
                column(Phys__Inventory_Ledger_Entry_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(Phys__Inventory_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Phys__Inventory_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Phys__Inventory_Ledger_Entry__Posting_Date_Caption; Phys__Inventory_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Phys. Inventory Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Res. Ledger Entry"; "Res. Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date");
                column(Res__Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Res__Ledger_Entry_Description; Description)
                {
                }
                column(Res__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Res__Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Res__Ledger_Entry_Quantity; Quantity)
                {
                }
                column(Res__Ledger_Entry__Unit_Cost_; "Unit Cost")
                {
                }
                column(Res__Ledger_Entry__Unit_Price_; "Unit Price")
                {
                }
                column(Res__Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Res__Ledger_Entry__Unit_Price_Caption; FIELDCAPTION("Unit Price"))
                {
                }
                column(Res__Ledger_Entry__Unit_Cost_Caption; FIELDCAPTION("Unit Cost"))
                {
                }
                column(Res__Ledger_Entry_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(Res__Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Res__Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Res__Ledger_Entry__Posting_Date_Caption; Res__Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Res. Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Job Ledger Entry"; "Job Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date");
                column(Job_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Job_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Job_Ledger_Entry_Description; Description)
                {
                }
                column(Job_Ledger_Entry_Quantity; Quantity)
                {
                }
                column(Job_Ledger_Entry__Unit_Cost__LCY__; "Unit Cost (LCY)")
                {
                }
                column(Job_Ledger_Entry__Unit_Price__LCY__; "Unit Price (LCY)")
                {
                }
                column(Job_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Job_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Job_Ledger_Entry__Unit_Price__LCY__Caption; FIELDCAPTION("Unit Price (LCY)"))
                {
                }
                column(Job_Ledger_Entry__Unit_Cost__LCY__Caption; FIELDCAPTION("Unit Cost (LCY)"))
                {
                }
                column(Job_Ledger_Entry_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(Job_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Job_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Job_Ledger_Entry__Posting_Date_Caption; Job_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Job Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date");
                column(CurrencyCaption_Control503; CurrencyCaption)
                {
                }
                column(Bank_Account_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Bank_Account_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Bank_Account_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Description; Description)
                {
                }
                column(Bank_Account_Ledger_Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(Bank_Account_Ledger_Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(Bank_Account_Ledger_Entry__Currency_Code_; "Currency Code")
                {
                }
                column(Bank_Account_Ledger_Entry__Entry_No___Control399; "Entry No.")
                {
                }
                column(Bank_Account_Ledger_Entry__Posting_Date__Control469; FORMAT("Posting Date"))
                {
                }
                column(Bank_Account_Ledger_Entry__Document_No___Control471; "Document No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Description_Control481; Description)
                {
                }
                column(Bank_Account_Ledger_Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                {
                }
                column(Bank_Account_Ledger_Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                {
                }
                column(Bank_Account_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Bank_Account_Ledger_Entry__Credit_Amount_Caption; FIELDCAPTION("Credit Amount"))
                {
                }
                column(Bank_Account_Ledger_Entry__Debit_Amount_Caption; FIELDCAPTION("Debit Amount"))
                {
                }
                column(Bank_Account_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Bank_Account_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Bank_Account_Ledger_Entry__Posting_Date_Caption; Bank_Account_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Bank Account Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Check Ledger Entry"; "Check Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date");
                column(Check_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Check_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Check_Ledger_Entry_Description; Description)
                {
                }
                column(Check_Ledger_Entry_Amount; Amount)
                {
                }
                column(Check_Ledger_Entry_Open; Open)
                {
                }
                column(Check_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Check_Ledger_Entry__Check_Date_; FORMAT("Check Date"))
                {
                }
                column(Check_Ledger_Entry__Check_No__; "Check No.")
                {
                }
                column(Check_Ledger_Entry__Check_Type_; "Check Type")
                {
                }
                column(Check_Ledger_Entry_OpenCaption; FIELDCAPTION(Open))
                {
                }
                column(Check_Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(Check_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Check_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Check_Ledger_Entry__Posting_Date_Caption; Check_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }
                column(Check_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Check_Ledger_Entry__Check_Type_Caption; FIELDCAPTION("Check Type"))
                {
                }
                column(Check_Ledger_Entry__Check_No__Caption; FIELDCAPTION("Check No."))
                {
                }
                column(Check_Ledger_Entry__Check_Date_Caption; Check_Ledger_Entry__Check_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Check Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("FA Ledger Entry"; "FA Ledger Entry")
            {
                DataItemTableView = SORTING("Document Type", "Document No.");
                column(FA_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(FA_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(FA_Ledger_Entry_Description; Description)
                {
                }
                column(FA_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(FA_Ledger_Entry_Amount; Amount)
                {
                }
                column(FA_Ledger_Entry__Posting_Date__Control505; FORMAT("Posting Date"))
                {
                }
                column(FA_Ledger_Entry__Document_No___Control509; "Document No.")
                {
                }
                column(FA_Ledger_Entry_Description_Control511; Description)
                {
                }
                column(FA_Ledger_Entry__Entry_No___Control513; "Entry No.")
                {
                }
                column(FA_Ledger_Entry__Amount__LCY__; "Amount (LCY)")
                {
                }
                column(FA_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(FA_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(FA_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(FA_Ledger_Entry__Posting_Date_Caption; FA_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }
                column(FA_Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"FA Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Maintenance Ledger Entry"; "Maintenance Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date");
                column(Maintenance_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Maintenance_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Maintenance_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Maintenance_Ledger_Entry_Description; Description)
                {
                }
                column(Maintenance_Ledger_Entry_Amount; Amount)
                {
                }
                column(Maintenance_Ledger_Entry__Entry_No___Control523; "Entry No.")
                {
                }
                column(Maintenance_Ledger_Entry__Posting_Date__Control530; FORMAT("Posting Date"))
                {
                }
                column(Maintenance_Ledger_Entry__Document_No___Control531; "Document No.")
                {
                }
                column(Maintenance_Ledger_Entry_Description_Control540; Description)
                {
                }
                column(Maintenance_Ledger_Entry__Amount__LCY__; "Amount (LCY)")
                {
                }
                column(Maintenance_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Maintenance_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Maintenance_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Maintenance_Ledger_Entry__Posting_Date_Caption; Maintenance_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }
                column(Maintenance_Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Maintenance Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Ins. Coverage Ledger Entry"; "Ins. Coverage Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date");
                column(Ins__Coverage_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Ins__Coverage_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Ins__Coverage_Ledger_Entry_Description; Description)
                {
                }
                column(Ins__Coverage_Ledger_Entry_Amount; Amount)
                {
                }
                column(Ins__Coverage_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Ins__Coverage_Ledger_Entry__Insurance_No__; "Insurance No.")
                {
                }
                column(Ins__Coverage_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Ins__Coverage_Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(Ins__Coverage_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Ins__Coverage_Ledger_Entry__Insurance_No__Caption; FIELDCAPTION("Insurance No."))
                {
                }
                column(Ins__Coverage_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Ins__Coverage_Ledger_Entry__Posting_Date_Caption; Ins__Coverage_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Ins. Coverage Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Capacity Ledger Entry"; "Capacity Ledger Entry")
            {
                DataItemTableView = SORTING("Document No.", "Posting Date");
                column(Capacity_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Capacity_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Capacity_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Capacity_Ledger_Entry_Description; Description)
                {
                }
                column(Capacity_Ledger_Entry_Quantity; Quantity)
                {
                }
                column(Capacity_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Capacity_Ledger_Entry_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(Capacity_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Capacity_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Capacity_Ledger_Entry__Posting_Date_Caption; Capacity_Ledger_Entry__Posting_Date_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Capacity Ledger Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Document No.", "Posting Date");
                    SETFILTER("Document No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;
            }
            dataitem("Warehouse Entry"; "Warehouse Entry")
            {
                DataItemTableView = SORTING("Reference No.", "Registering Date");
                column(Warehouse_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Warehouse_Entry__Registering_Date_; FORMAT("Registering Date"))
                {
                }
                column(Warehouse_Entry__Item_No__; "Item No.")
                {
                }
                column(Warehouse_Entry_Description; Description)
                {
                }
                column(Warehouse_Entry_Quantity; Quantity)
                {
                }
                column(Warehouse_Entry__Reference_No__; "Reference No.")
                {
                }
                column(Warehouse_Entry__Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(Warehouse_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(Warehouse_Entry_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(Warehouse_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Warehouse_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
                {
                }
                column(Warehouse_Entry__Reference_No__Caption; FIELDCAPTION("Reference No."))
                {
                }
                column(Warehouse_Entry__Registering_Date_Caption; Warehouse_Entry__Registering_Date_CaptionLbl)
                {
                }
                column(Warehouse_Entry__Unit_of_Measure_Code_Caption; FIELDCAPTION("Unit of Measure Code"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Warehouse Entry" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("Reference No.", "Registering Date");
                    SETFILTER("Reference No.", DocNoFilter);
                    SETFILTER("Registering Date", PostingDateFilter);
                end;
            }
            dataitem("Payment Header"; "Payment Header")
            {
                DataItemTableView = SORTING("No.");
                column(No_PaymentHeader; "No.")
                {
                }
                column(PaymentHeaderLbl; PaymentHeaderLbl)
                {

                }
                column(Posting_DatePayment_Header; FIELDCAPTION("Posting Date"))
                {
                }
                column(PaymentHeaderPosting_Date; "Posting Date")
                {

                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;

                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Payment Header" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                    SETFILTER("Posting Date", PostingDateFilter);
                end;



            }
            dataitem("Payment Line"; "Payment Line")
            {
                DataItemTableView = SORTING("No.", "Line No.");
                column(No_PaymentLine; "No.")
                {
                }
                column(Payment_Line_Line_No_; "Line No.")
                {
                }
                column(PaymentHeaderLineLbl; PaymentHeaderLineLbl)
                {

                }
                column(Posting_DatePayment_line; FIELDCAPTION("Posting Date"))
                {
                }
                column(Posting_DateLine; "Posting Date")
                {

                }

                trigger OnAfterGetRecord()
                begin
                    DELETE;

                end;

                trigger OnPreDataItem()
                begin
                    IF DocEntry."Table ID" <> DATABASE::"Payment Line" THEN
                        CurrReport.BREAK;

                    SETCURRENTKEY("No.");
                    SETFILTER("No.", DocNoFilter);
                end;
            }
            dataitem("Job Ledger Entry2"; "Job Ledger Entry2")
            {
                DataItemTableView = SORTING("Entry No.");


                trigger OnAfterGetRecord()
                begin
                    DELETE;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Document No.", DocNoFilter);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT DocEntry.FIND('-') THEN
                        CurrReport.BREAK;
                END ELSE
                    IF DocEntry.NEXT = 0 THEN
                        CurrReport.BREAK;

                IF ISSERVICETIER THEN
                    CurrencyCaptionRBC := Text003;
            end;

            trigger OnPreDataItem()
            begin
                IF NOT PrintAmountsInLCY THEN
                    CurrencyCaption := Text003
                ELSE
                    CurrencyCaption := '';
            end;
        }
    }

    requestpage
    {
        /* SaveValues = true;


         layout
         {
             area(content)
             {
                 group(Options)
                 {
                     Caption = 'Options';
                     field(PrintAmountsInLCY; PrintAmountsInLCY)
                     {
                         Caption = 'Afficher montants DS';
                     }
                 }
             }
         }

         actions
         {
         }*/
    }

    labels
    {
    }

    var
        DocEntry: Record 265 temporary;
        CurrExchRate: Record 330;
        DocNoFilter: Code[250];
        PostingDateFilter: Text[250];
        Text001: Label 'N° document : ';
        Text002: Label 'Date comptabilisation : ';
        PrintAmountsInLCY: Boolean;
        CurrencyCaption: Text[30];
        Text003: Label 'Code devise';
        CurrencyCaptionRBC: Text[30];
        Cust: Record 18;
        Vend: Record 23;
        SOSalesHeader: Record 36;
        SISalesHeader: Record 36;
        SROSalesHeader: Record 36;
        SCMSalesHeader: Record 36;
        SalesShptHeader: Record 110;
        SalesInvHeader: Record 112;
        ReturnRcptHeader: Record 6660;
        SalesCrMemoHeader: Record 114;
        SOServHeader: Record 5900;
        SIServHeader: Record 5900;
        SCMServHeader: Record 5900;
        ServShptHeader: Record 5990;
        ServInvHeader: Record 5992;
        ServCrMemoHeader: Record 5994;
        IssuedReminderHeader: Record 297;
        IssuedFinChrgMemoHeader: Record 304;
        PurchRcptHeader: Record 120;
        PurchInvHeader: Record 122;
        ReturnShptHeader: Record 6650;
        PurchCrMemoHeader: Record 124;
        ProductionOrderHeader: Record 5405;
        TransShptHeader: Record 5744;
        TransRcptHeader: Record 5746;
        PostedWhseRcptLine: Record 7319;
        PostedWhseShptLine: Record 7323;
        GLEntry: Record 17;
        VATEntry: Record 254;
        CustLedgEntry: Record 21;
        DtldCustLedgEntry: Record 379;
        VendLedgEntry: Record 25;
        DtldVendLedgEntry: Record 380;
        ItemLedgEntry: Record 32;
        PhysInvtLedgEntry: Record 281;
        ResLedgEntry: Record 203;
        JobLedgEntry: Record 169;
        ValueEntry: Record 5802;
        BankAccLedgEntry: Record 271;
        CheckLedgEntry: Record 272;
        ReminderEntry: Record 300;
        FALedgEntry: Record 5601;
        MaintenanceLedgEntry: Record 5625;
        InsuranceCovLedgEntry: Record 5629;
        CapacityLedgEntry: Record 5832;
        ServLedgerEntry: Record 5907;
        WarrantyLedgerEntry: Record 5908;
        WhseEntry: Record 7312;
        TempRecordBuffer: Record 6529 temporary;
        Document_EntriesCaptionLbl: Label 'Ecritures document';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Navigate_FiltersCaptionLbl: Label 'Filtres de navigation';

        DocEntry__No__of_Records_CaptionLbl: Label 'Nombre d''enregistrements';

        DocEntry__Table_Name_CaptionLbl: Label 'Nom de table';
        Service_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Warranty_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Service_Shipment_Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Sales_Shipment_Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Sales_Invoice_Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Return_Receipt_Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Sales_Cr_Memo_Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Issued_Reminder_Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Issued_Fin__Charge_Memo_Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Purch__Rcpt__Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Purch__Inv__Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Return_Shipment_Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Purch__Cr__Memo_Hdr___Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Transfer_Shipment_Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Transfer_Receipt_Header__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Posted_Whse__Shipment_Line__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Posted_Whse__Receipt_Line__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        G_L_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        VAT_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Cust__Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Detailed_Cust__Ledg__Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Reminder_Fin__Charge_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Vendor_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Detailed_Vendor_Ledg__Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Item_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Value_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Phys__Inventory_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Res__Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Job_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Bank_Account_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Check_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        PaymentHeaderLbl: Label 'Date comptabilisation';
        PaymentHeaderLineLbl: Label 'Date comptabilisation';
        Check_Ledger_Entry__Check_Date_CaptionLbl: Label 'Check Date';
        FA_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Maintenance_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Ins__Coverage_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Capacity_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Date comptabilisation';
        Warehouse_Entry__Registering_Date_CaptionLbl: Label 'Date enregistrement';

    // [Scope('Internal')]
    procedure TransferDocEntries(var NewDocEntry: Record 265)
    var
        TempDocumentEntry: Record 265;
    begin
        TempDocumentEntry := NewDocEntry;
        NewDocEntry.RESET;
        IF NewDocEntry.FIND('-') THEN
            REPEAT
                DocEntry := NewDocEntry;
                DocEntry.INSERT;
            UNTIL NewDocEntry.NEXT = 0;
        NewDocEntry := TempDocumentEntry;
    end;

    // [Scope('Internal')]
    procedure TransferFilters(NewDocNoFilter: Code[250]; NewPostingDateFilter: Text[250])
    var
        DocumentEntries: Report "Document Entries Delete";
    begin
        DocNoFilter := NewDocNoFilter;
        PostingDateFilter := NewPostingDateFilter;


    end;
}

