// Table 39001528 "Tmp Ecritures Lettrage Clt"
// {
//     //GL2024  ID dans Nav 2009 : "39001528"
//     // //+CH+2800 CW 31/10/07 from NAVCH4.00.03
//     // //STATSEXPLORER STATSEXPLORER 17/01/00 New keys :
//     // - Customer No.,Customer Posting Group,Global Dimension 1 Code,Global Dimension 2 Code,Currency Code,Due Date
//     // - Customer No.,Customer Posting Group,Global Dimension 1 Code,Global Dimension 2 Code,Currency Code,Posting Date
//     // //+RAP+TRESO GESWAY 09/09/03 AJOUT du champ "Value Date"
//     //                          Ajout de la clé Open,Value Date
//     //                          Mise à jour de "Value date" dans Onvalidate de "Due date"
//     // //+REF+PROJET GESWAY 01/11/01 +"Job No.", +key Job No.,Customer No.,Open,Positive,Due Date,Currency Code
//     //                               + key Job No.,Customer No.,Open,Positive,Due Date,Currency Code
//     //                          + Document No.,Document Type,Customer No. //annulation de situation
//     // //RETENTION CW 09/06/06 + clé Document Type,Document No.,Retention Code,Job No.,Open
//     //                21/08/06 + Retention %
//     // //MASK CW 16/02/06 +"Mask Code"

//     Caption = 'Cust. Ledger Entry';
//     DrillDownPageID = "Customer Ledger Entries";
//     LookupPageID = "Customer Ledger Entries";

//     fields
//     {
//         field(1; "Entry No."; Integer)
//         {
//             Caption = 'Entry No.';
//         }
//         field(3; "Customer No."; Code[20])
//         {
//             Caption = 'Customer No.';
//             TableRelation = Customer;
//         }
//         field(4; "Posting Date"; Date)
//         {
//             Caption = 'Posting Date';
//         }
//         field(5; "Document Type"; Option)
//         {
//             Caption = 'Document Type';
//             OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
//             OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
//         }
//         field(6; "Document No."; Code[20])
//         {
//             Caption = 'Document No.';
//         }
//         field(7; Description; Text[50])
//         {
//             Caption = 'Description';
//         }
//         field(11; "Currency Code"; Code[10])
//         {
//             Caption = 'Currency Code';
//             TableRelation = Currency;
//         }
//         field(13; Amount; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Cust. Ledger Entry No." = field("Entry No."),
//                                                                          "Entry Type" = filter("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)"),
//                                                                          "Posting Date" = field("Date Filter")));
//             Caption = 'Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(14; "Remaining Amount"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Cust. Ledger Entry No." = field("Entry No."),
//                                                                          "Posting Date" = field("Date Filter")));
//             Caption = 'Remaining Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(15; "Original Amt. (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Cust. Ledger Entry No." = field("Entry No."),
//                                                                                  "Entry Type" = filter("Initial Entry"),
//                                                                                  "Posting Date" = field("Date Filter")));
//             Caption = 'Original Amt. (LCY)';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(16; "Remaining Amt. (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Cust. Ledger Entry No." = field("Entry No."),
//                                                                                  "Posting Date" = field("Date Filter")));
//             Caption = 'Remaining Amt. (LCY)';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(17; "Amount (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Cust. Ledger Entry No." = field("Entry No."),
//                                                                                  "Entry Type" = filter("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)"),
//                                                                                  "Posting Date" = field("Date Filter")));
//             Caption = 'Amount (LCY)';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(18; "Sales (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Sales (LCY)';
//         }
//         field(19; "Profit (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Profit (LCY)';
//         }
//         field(20; "Inv. Discount (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Inv. Discount (LCY)';
//         }
//         field(21; "Sell-to Customer No."; Code[20])
//         {
//             Caption = 'Sell-to Customer No.';
//             TableRelation = Customer;
//         }
//         field(22; "Customer Posting Group"; Code[10])
//         {
//             Caption = 'Customer Posting Group';
//             TableRelation = "Customer Posting Group";
//         }
//         field(23; "Global Dimension 1 Code"; Code[20])
//         {
//             CaptionClass = '1,1,1';
//             Caption = 'Global Dimension 1 Code';
//             TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
//         }
//         field(24; "Global Dimension 2 Code"; Code[20])
//         {
//             CaptionClass = '1,1,2';
//             Caption = 'Global Dimension 2 Code';
//             TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
//         }
//         field(25; "Salesperson Code"; Code[10])
//         {
//             Caption = 'Salesperson Code';
//             TableRelation = "Salesperson/Purchaser";
//         }
//         field(27; "User ID"; Code[20])
//         {
//             Caption = 'User ID';
//             TableRelation = "User Setup";
//             //This property is currently not supported
//             //TestTableRelation = false;

//             trigger OnLookup()
//             var
//                 LoginMgt: Codeunit "User Management";
//             begin
//                 //DYS table user vers user setup
//                 //LoginMgt.LookupUserID("User ID");
//             end;
//         }
//         field(28; "Source Code"; Code[10])
//         {
//             Caption = 'Source Code';
//             TableRelation = "Source Code";
//         }
//         field(33; "On Hold"; Code[3])
//         {
//             Caption = 'On Hold';
//         }
//         field(34; "Applies-to Doc. Type"; Option)
//         {
//             Caption = 'Applies-to Doc. Type';
//             OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
//             OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
//         }
//         field(35; "Applies-to Doc. No."; Code[20])
//         {
//             Caption = 'Applies-to Doc. No.';
//         }
//         field(36; Open; Boolean)
//         {
//             Caption = 'Open';
//         }
//         field(37; "Due Date"; Date)
//         {
//             Caption = 'Due Date';

//             trigger OnValidate()
//             var
//                 ReminderEntry: Record "Reminder/Fin. Charge Entry";
//                 ReminderIssue: Codeunit "Reminder-Issue";
//             //  lBARMgt: Codeunit "BAR Management";
//             begin
//             end;
//         }
//         field(38; "Pmt. Discount Date"; Date)
//         {
//             Caption = 'Pmt. Discount Date';

//             trigger OnValidate()
//             begin
//                 TestField(Open, true);
//             end;
//         }
//         field(39; "Original Pmt. Disc. Possible"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Original Pmt. Disc. Possible';
//             Editable = false;
//         }
//         field(40; "Pmt. Disc. Given (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Pmt. Disc. Given (LCY)';
//         }
//         field(43; Positive; Boolean)
//         {
//             Caption = 'Positive';
//         }
//         field(44; "Closed by Entry No."; Integer)
//         {
//             Caption = 'Closed by Entry No.';
//             TableRelation = "Cust. Ledger Entry";
//         }
//         field(45; "Closed at Date"; Date)
//         {
//             Caption = 'Closed at Date';
//         }
//         field(46; "Closed by Amount"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Closed by Amount';
//         }
//         field(47; "Applies-to ID"; Code[20])
//         {
//             Caption = 'Applies-to ID';

//             trigger OnValidate()
//             begin
//                 TestField(Open, true);
//             end;
//         }
//         field(49; "Journal Batch Name"; Code[10])
//         {
//             Caption = 'Journal Batch Name';
//         }
//         field(50; "Reason Code"; Code[10])
//         {
//             Caption = 'Reason Code';
//             TableRelation = "Reason Code";
//         }
//         field(51; "Bal. Account Type"; Option)
//         {
//             Caption = 'Bal. Account Type';
//             OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
//             OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
//         }
//         field(52; "Bal. Account No."; Code[20])
//         {
//             Caption = 'Bal. Account No.';
//             TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
//             else
//             if ("Bal. Account Type" = const(Customer)) Customer
//             else
//             if ("Bal. Account Type" = const(Vendor)) Vendor
//             else
//             if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
//             else
//             if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset";
//         }
//         field(53; "Transaction No."; Integer)
//         {
//             Caption = 'Transaction No.';
//         }
//         field(54; "Closed by Amount (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Closed by Amount (LCY)';
//         }
//         field(58; "Debit Amount"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             //blankzero = true;
//             CalcFormula = sum("Detailed Cust. Ledg. Entry"."Debit Amount" where("Cust. Ledger Entry No." = field("Entry No."),
//                                                                                  "Entry Type" = filter(<> Application),
//                                                                                  "Posting Date" = field("Date Filter")));
//             Caption = 'Debit Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(59; "Credit Amount"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             //blankzero = true;
//             CalcFormula = sum("Detailed Cust. Ledg. Entry"."Credit Amount" where("Cust. Ledger Entry No." = field("Entry No."),
//                                                                                   "Entry Type" = filter(<> Application),
//                                                                                   "Posting Date" = field("Date Filter")));
//             Caption = 'Credit Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(60; "Debit Amount (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             //blankzero = true;
//             CalcFormula = sum("Detailed Cust. Ledg. Entry"."Debit Amount (LCY)" where("Cust. Ledger Entry No." = field("Entry No."),
//                                                                                        "Entry Type" = filter(<> Application),
//                                                                                        "Posting Date" = field("Date Filter")));
//             Caption = 'Debit Amount (LCY)';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(61; "Credit Amount (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             //blankzero = true;
//             CalcFormula = sum("Detailed Cust. Ledg. Entry"."Credit Amount (LCY)" where("Cust. Ledger Entry No." = field("Entry No."),
//                                                                                         "Entry Type" = filter(<> Application),
//                                                                                         "Posting Date" = field("Date Filter")));
//             Caption = 'Credit Amount (LCY)';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(62; "Document Date"; Date)
//         {
//             Caption = 'Document Date';
//         }
//         field(63; "External Document No."; Code[20])
//         {
//             Caption = 'External Document No.';
//         }
//         field(64; "Calculate Interest"; Boolean)
//         {
//             Caption = 'Calculate Interest';
//         }
//         field(65; "Closing Interest Calculated"; Boolean)
//         {
//             Caption = 'Closing Interest Calculated';
//         }
//         field(66; "No. Series"; Code[10])
//         {
//             Caption = 'No. Series';
//             TableRelation = "No. Series";
//         }
//         field(67; "Closed by Currency Code"; Code[10])
//         {
//             Caption = 'Closed by Currency Code';
//             TableRelation = Currency;
//         }
//         field(68; "Closed by Currency Amount"; Decimal)
//         {
//             AutoFormatExpression = "Closed by Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Closed by Currency Amount';
//         }
//         field(73; "Adjusted Currency Factor"; Decimal)
//         {
//             Caption = 'Adjusted Currency Factor';
//             DecimalPlaces = 0 : 15;
//         }
//         field(74; "Original Currency Factor"; Decimal)
//         {
//             Caption = 'Original Currency Factor';
//             DecimalPlaces = 0 : 15;
//         }
//         field(75; "Original Amount"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Cust. Ledger Entry No." = field("Entry No."),
//                                                                          "Entry Type" = filter("Initial Entry"),
//                                                                          "Posting Date" = field("Date Filter")));
//             Caption = 'Original Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(76; "Date Filter"; Date)
//         {
//             Caption = 'Date Filter';
//             FieldClass = FlowFilter;
//         }
//         field(77; "Remaining Pmt. Disc. Possible"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Remaining Pmt. Disc. Possible';

//             trigger OnValidate()
//             begin
//                 TestField(Open, true);
//                 CalcFields(Amount, "Original Amount");

//                 if "Remaining Pmt. Disc. Possible" * Amount < 0 then
//                     FieldError("Remaining Pmt. Disc. Possible", StrSubstNo(Text000, FieldCaption(Amount)));

//                 if Abs("Remaining Pmt. Disc. Possible") > Abs("Original Amount") then
//                     FieldError("Remaining Pmt. Disc. Possible", StrSubstNo(Text001, FieldCaption("Original Amount")));
//             end;
//         }
//         field(78; "Pmt. Disc. Tolerance Date"; Date)
//         {
//             Caption = 'Pmt. Disc. Tolerance Date';

//             trigger OnValidate()
//             begin
//                 TestField(Open, true);
//             end;
//         }
//         field(79; "Max. Payment Tolerance"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Max. Payment Tolerance';

//             trigger OnValidate()
//             begin
//                 TestField(Open, true);
//                 CalcFields(Amount, "Remaining Amount");

//                 if "Max. Payment Tolerance" * Amount < 0 then
//                     FieldError("Max. Payment Tolerance", StrSubstNo(Text000, FieldCaption(Amount)));

//                 if Abs("Max. Payment Tolerance") > Abs("Remaining Amount") then
//                     FieldError("Max. Payment Tolerance", StrSubstNo(Text001, FieldCaption("Remaining Amount")));
//             end;
//         }
//         field(80; "Last Issued Reminder Level"; Integer)
//         {
//             Caption = 'Last Issued Reminder Level';
//         }
//         field(81; "Accepted Payment Tolerance"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Accepted Payment Tolerance';
//         }
//         field(82; "Accepted Pmt. Disc. Tolerance"; Boolean)
//         {
//             Caption = 'Accepted Pmt. Disc. Tolerance';
//         }
//         field(83; "Pmt. Tolerance (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Pmt. Tolerance (LCY)';
//         }
//         field(84; "Amount to Apply"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Amount to Apply';

//             trigger OnValidate()
//             begin
//                 TestField(Open, true);
//                 CalcFields("Remaining Amount");

//                 if "Amount to Apply" * "Remaining Amount" < 0 then
//                     FieldError("Amount to Apply", StrSubstNo(Text000, FieldCaption("Remaining Amount")));

//                 if Abs("Amount to Apply") > Abs("Remaining Amount") then
//                     FieldError("Amount to Apply", StrSubstNo(Text001, FieldCaption("Remaining Amount")));
//             end;
//         }
//         field(85; "IC Partner Code"; Code[20])
//         {
//             Caption = 'IC Partner Code';
//             TableRelation = "IC Partner";
//         }
//         field(86; "Applying Entry"; Boolean)
//         {
//             Caption = 'Applying Entry';
//         }
//         field(87; Reversed; Boolean)
//         {
//             //blankzero = true;
//             Caption = 'Reversed';
//         }
//         field(88; "Reversed by Entry No."; Integer)
//         {
//             //blankzero = true;
//             Caption = 'Reversed by Entry No.';
//             TableRelation = "Cust. Ledger Entry";
//         }
//         field(89; "Reversed Entry No."; Integer)
//         {
//             //blankzero = true;
//             Caption = 'Reversed Entry No.';
//             TableRelation = "Cust. Ledger Entry";
//         }
//         field(90; Prepayment; Boolean)
//         {
//             Caption = 'Prepayment';
//         }
//         field(50000; Avance; Boolean)
//         {
//             // CalcFormula = lookup("Payment Header".Avance where("No." = field("Document No.")));
//             // Description = 'RB SORO 27/03/2015';
//             // FieldClass = FlowField;
//         }
//         field(50001; "Code Lettrage"; Text[3])
//         {
//             Description = 'HJ SORO 11-04-2015';
//         }
//         field(50024; "Sequence Lié"; Integer)
//         {
//             Description = 'HJ SORO 11-04-2015';
//         }
//         field(50025; "Fature Associé"; Code[20])
//         {
//             Description = 'HJ SORO 11-04-2015';
//         }
//         field(82750; "Mask Code"; Code[10])
//         {
//             Caption = 'Mask Code';
//             TableRelation = Mask;
//         }
//         field(3010831; "LSV No."; Integer)
//         {
//             Caption = 'LSV No.';
//             TableRelation = "LSV Journal";
//         }
//         field(8001400; "Job No."; Code[20])
//         {
//             Caption = 'Job No.';
//             TableRelation = Job;
//         }
//         field(8001600; "Value Date"; Date)
//         {
//             Caption = 'Value Date';
//         }
//         field(8003900; "Sales Order No."; Code[20])
//         {
//             Caption = 'Sales Order No.';
//             Editable = false;
//             TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
//             //This property is currently not supported
//             //TestTableRelation = false;
//         }
//         field(8004040; "Retention Code"; Code[10])
//         {
//             Caption = 'Retention Code';
//             TableRelation = Retention;
//         }
//         field(8004041; "Retention %"; Decimal)
//         {
//             Caption = 'Retention %';
//             Editable = true;
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "Entry No.")
//         {
//             Clustered = true;
//         }
//         key(STG_Key2; "Customer No.", "Posting Date", "Currency Code")
//         {
//             SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)";
//         }
//         key(STG_Key3; "Customer No.", "Currency Code", "Posting Date")
//         {
//             Enabled = false;
//         }
//         key(STG_Key4; "Document No.")
//         {
//         }
//         key(STG_Key5; "External Document No.")
//         {
//         }
//         key(STG_Key6; "Customer No.", Open, Positive, "Due Date", "Currency Code")
//         {
//         }
//         key(STG_Key7; Open, "Due Date")
//         {
//         }
//         key(STG_Key8; "Document Type", "Customer No.", "Posting Date", "Currency Code")
//         {
//             MaintainSIFTIndex = false;
//             MaintainSQLIndex = false;
//             SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)";
//         }
//         key(STG_Key9; "Salesperson Code", "Posting Date")
//         {
//         }
//         key(STG_Key10; "Closed by Entry No.")
//         {
//         }
//         key(STG_Key11; "Transaction No.")
//         {
//         }
//         key(STG_Key12; "Customer No.", Open, Positive, "Calculate Interest", "Due Date")
//         {
//             Enabled = false;
//         }
//         key(STG_Key13; "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code")
//         {
//             SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)";
//         }
//         key(STG_Key14; "Customer No.", Open, "Global Dimension 1 Code", "Global Dimension 2 Code", Positive, "Due Date", "Currency Code")
//         {
//         }
//         key(STG_Key15; Open, "Global Dimension 1 Code", "Global Dimension 2 Code", "Due Date")
//         {
//         }
//         key(STG_Key16; "Document Type", "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code")
//         {
//         }
//         key(STG_Key17; "Customer No.", "Applies-to ID", Open, Positive, "Due Date")
//         {
//         }
//         key(STG_Key18; "Customer No.", "Customer Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code", "Currency Code", "Due Date")
//         {
//         }
//         key(STG_Key19; "Customer No.", "Customer Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code", "Currency Code", "Posting Date")
//         {
//         }
//         key(STG_Key20; Open, "Value Date")
//         {
//         }
//         key(STG_Key21; "Job No.", "Customer No.", Open, Positive, "Due Date", "Currency Code")
//         {
//         }
//         key(STG_Key22; "Document Type", "Document No.", "Retention Code", "Job No.", Open)
//         {
//         }
//         key(STG_Key23; "Document No.", "Document Type", "Customer No.")
//         {
//         }
//         key(STG_Key24; "LSV No.", "Customer No.")
//         {
//         }
//         key(STG_Key25; "Source Code", "Posting Date")
//         {
//         }
//         key(STG_Key26; "Source Code", "Posting Date", "Document No.")
//         {
//         }
//         key(STG_Key27; "Applies-to ID")
//         {
//         }
//     }

//     fieldgroups
//     {
//         fieldgroup(DropDown; "Entry No.", Description, "Customer No.", "Posting Date", "Document Type", "Document No.")
//         {
//         }
//     }

//     var
//         Text000: label 'must have the same sign as %1';
//         Text001: label 'must not be larger than %1';
//     //   gAddOnLicencePermission: Codeunit IntegrManagement;


//     procedure DrillDownOnEntries(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
//     var
//         CustLedgEntry: Record "Cust. Ledger Entry";
//     begin
//         CustLedgEntry.Reset;
//         DtldCustLedgEntry.Copyfilter("Customer No.", CustLedgEntry."Customer No.");
//         DtldCustLedgEntry.Copyfilter("Currency Code", CustLedgEntry."Currency Code");
//         DtldCustLedgEntry.Copyfilter("Initial Entry Global Dim. 1", CustLedgEntry."Global Dimension 1 Code");
//         DtldCustLedgEntry.Copyfilter("Initial Entry Global Dim. 2", CustLedgEntry."Global Dimension 2 Code");
//         CustLedgEntry.SetCurrentkey("Customer No.", "Posting Date");
//         CustLedgEntry.SetRange(Open, true);
//         page.Run(0, CustLedgEntry);
//     end;


//     procedure DrillDownOnOverdueEntries(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
//     var
//         CustLedgEntry: Record "Cust. Ledger Entry";
//     begin
//         CustLedgEntry.Reset;
//         DtldCustLedgEntry.Copyfilter("Customer No.", CustLedgEntry."Customer No.");
//         DtldCustLedgEntry.Copyfilter("Currency Code", CustLedgEntry."Currency Code");
//         DtldCustLedgEntry.Copyfilter("Initial Entry Global Dim. 1", CustLedgEntry."Global Dimension 1 Code");
//         DtldCustLedgEntry.Copyfilter("Initial Entry Global Dim. 2", CustLedgEntry."Global Dimension 2 Code");
//         CustLedgEntry.SetCurrentkey("Customer No.", "Posting Date");
//         CustLedgEntry.SetFilter("Date Filter", '..%1', WorkDate);
//         CustLedgEntry.SetFilter("Due Date", '..%1', WorkDate);
//         CustLedgEntry.SetFilter("Remaining Amount", '<>%1', 0);
//         page.Run(0, CustLedgEntry);
//     end;


//     procedure GetOriginalCurrencyFactor(): Decimal
//     begin
//         if "Original Currency Factor" = 0 then
//             exit(1);
//         exit("Original Currency Factor");
//     end;
// }

