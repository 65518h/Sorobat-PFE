// Table 39001522 "Tmp Ecritures Lettrage Frs"
// {
//     //GL2024  ID dans Nav 2009 : "39001522"

//     // //STATSEXPLORER STATSEXPLORER 17/01/00 New keys :
//     // - Vendor No.,Vendor Posting Group,Global Dimension 1 Code,Global Dimension 2 Code,Currency Code,Due Date
//     // - Vendor No.,Vendor Posting Group,Global Dimension 1 Code,Global Dimension 2 Code,Currency Code,Posting Date
//     // //+RAP+TRESO GESWAY 09/09/03 AJOUT du champ "Value Date"
//     //                          Ajout de la clé Open,Value Date
//     //                          Mise à jour de "Value date" dans Onvalidate de "Due date"
//     // //PROJET GESWAY 01/11/01 +"Job No." + Key
//     // //+CH+2300 CW 31/10/07 from NAVCH4.00.02
//     // //PMT_DIRECT GESWAY 30/06/03 +8003900 "Apply-to Sales Doc. No." with Key

//     Caption = 'Tmp Ecritures Lettrage Frs';
//     DrillDownPageID = "Vendor Ledger Entries";
//     LookupPageID = "Vendor Ledger Entries";

//     fields
//     {
//         field(1; "Entry No."; Integer)
//         {
//             Caption = 'Entry No.';
//         }
//         field(3; "Vendor No."; Code[20])
//         {
//             Caption = 'Vendor No.';
//             TableRelation = Vendor;
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
//             CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor Ledger Entry No." = field("Entry No."),
//                                                                           "Entry Type" = filter("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)"),
//                                                                           "Posting Date" = field("Date Filter")));
//             Caption = 'Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(14; "Remaining Amount"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor Ledger Entry No." = field("Entry No."),
//                                                                           "Posting Date" = field("Date Filter")));
//             Caption = 'Remaining Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(15; "Original Amt. (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor Ledger Entry No." = field("Entry No."),
//                                                                                   "Entry Type" = filter("Initial Entry"),
//                                                                                   "Posting Date" = field("Date Filter")));
//             Caption = 'Original Amt. (LCY)';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(16; "Remaining Amt. (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor Ledger Entry No." = field("Entry No."),
//                                                                                   "Posting Date" = field("Date Filter")));
//             Caption = 'Remaining Amt. (LCY)';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(17; "Amount (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor Ledger Entry No." = field("Entry No."),
//                                                                                   "Entry Type" = filter("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)"),
//                                                                                   "Posting Date" = field("Date Filter")));
//             Caption = 'Amount (LCY)';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(18; "Purchase (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Purchase (LCY)';
//         }
//         field(20; "Inv. Discount (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Inv. Discount (LCY)';
//         }
//         field(21; "Buy-from Vendor No."; Code[20])
//         {
//             Caption = 'Buy-from Vendor No.';
//             TableRelation = Vendor;
//         }
//         field(22; "Vendor Posting Group"; Code[10])
//         {
//             Caption = 'Vendor Posting Group';
//             TableRelation = "Vendor Posting Group";
//         }
//         field(23; "Global Dimension 1 Code"; Code[20])
//         {
//             //CaptionClass = '1,1,1';
//             Caption = 'Global Dimension 1 Code';
//             TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
//         }
//         field(24; "Global Dimension 2 Code"; Code[20])
//         {
//             //CaptionClass = '1,1,2';
//             Caption = 'Global Dimension 2 Code';
//             TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
//         }
//         field(25; "Purchaser Code"; Code[10])
//         {
//             Caption = 'Purchaser Code';
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

//             // trigger OnValidate()
//             // var
//             //     lBARMgt: Codeunit "BAR Management";
//             // begin
//             //     //+RAP+TRESO
//             //     if (CurrFieldNo = FieldNo("Due Date")) or not gAddOnLicencePermission.HasPermissionRAP then
//             //         //+RAP+TRESO//
//             //         TestField(Open, true);
//             //     //+RAP+TRESO
//             //     if gAddOnLicencePermission.HasPermissionRAP then;
//             // end;

//         }
//         field(38; "Pmt. Discount Date"; Date)
//         {
//             Caption = 'Pmt. Discount Date';
//         }
//         field(39; "Original Pmt. Disc. Possible"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Original Pmt. Disc. Possible';
//             Editable = false;
//         }
//         field(40; "Pmt. Disc. Rcd.(LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Pmt. Disc. Rcd.(LCY)';
//         }
//         field(43; Positive; Boolean)
//         {
//             Caption = 'Positive';
//         }
//         field(44; "Closed by Entry No."; Integer)
//         {
//             Caption = 'Closed by Entry No.';
//             TableRelation = "Vendor Ledger Entry";
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
//             //This property is currently not supported
//             //TestTableRelation = false;
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
//             CalcFormula = sum("Detailed Vendor Ledg. Entry"."Debit Amount" where("Vendor Ledger Entry No." = field("Entry No."),
//                                                                                   "Entry Type" = filter(<> Application),
//                                                                                   "Posting Date" = field("Date Filter")));
//             Caption = 'Debit Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(59; "Credit Amount"; Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             //blankzero = true;
//             CalcFormula = sum("Detailed Vendor Ledg. Entry"."Credit Amount" where("Vendor Ledger Entry No." = field("Entry No."),
//                                                                                    "Entry Type" = filter(<> Application),
//                                                                                    "Posting Date" = field("Date Filter")));
//             Caption = 'Credit Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(60; "Debit Amount (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             //blankzero = true;
//             CalcFormula = sum("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)" where("Vendor Ledger Entry No." = field("Entry No."),
//                                                                                         "Entry Type" = filter(<> Application),
//                                                                                         "Posting Date" = field("Date Filter")));
//             Caption = 'Debit Amount (LCY)';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(61; "Credit Amount (LCY)"; Decimal)
//         {
//             AutoFormatType = 1;
//             //blankzero = true;
//             CalcFormula = sum("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)" where("Vendor Ledger Entry No." = field("Entry No."),
//                                                                                          "Entry Type" = filter(<> Application),
//                                                                                          "Posting Date" = field("Date Filter")));
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
//         field(64; "No. Series"; Code[10])
//         {
//             Caption = 'No. Series';
//             TableRelation = "No. Series";
//         }
//         field(65; "Closed by Currency Code"; Code[10])
//         {
//             Caption = 'Closed by Currency Code';
//             TableRelation = Currency;
//         }
//         field(66; "Closed by Currency Amount"; Decimal)
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
//             CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor Ledger Entry No." = field("Entry No."),
//                                                                           "Entry Type" = filter("Initial Entry"),
//                                                                           "Posting Date" = field("Date Filter")));
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
//                 //PMT_DIRECT
//                 if "Remaining Pmt. Disc. Possible" <> 0 then
//                     TestField("Apply-to Sales Order No.", '');
//                 //PMT_DIRECT//
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
//             Caption = 'Reversed';
//         }
//         field(88; "Reversed by Entry No."; Integer)
//         {
//             //blankzero = true;
//             Caption = 'Reversed by Entry No.';
//             TableRelation = "Vendor Ledger Entry";
//         }
//         field(89; "Reversed Entry No."; Integer)
//         {
//             //blankzero = true;
//             Caption = 'Reversed Entry No.';
//             TableRelation = "Vendor Ledger Entry";
//         }
//         field(90; Prepayment; Boolean)
//         {
//             Caption = 'Prepayment';
//         }
//         field(50000; Lettre; Text[4])
//         {
//             Description = 'HJ SORO 03-05-2015';
//         }
//         field(50002; Avance; Boolean)
//         {
//             // CalcFormula = lookup("Payment Header".Avance where("No." = field("Document No.")));
//             // Description = 'RB SORO 27/03/2015';
//             // FieldClass = FlowField;
//         }
//         field(50020; "Folio N°"; Code[20])
//         {
//             // CalcFormula = lookup("G/L Entry"."Folio N°" where("Source Type" = filter("Bank Account"),
//             //                                                    "Document No." = field("Document No.")));
//             // FieldClass = FlowField;
//         }
//         field(50021; "Date Préparation Payement"; Date)
//         {
//             // CalcFormula = lookup("Purch. Inv. Header"."Date Préparation Payement" where("Buy-from Vendor No." = field("Vendor No."),
//             //                                                                              "No." = field("Document No.")));
//             // Description = 'HJ SORO 24-10-2014';
//             // FieldClass = FlowField;
//         }
//         field(50022; "Date Signature"; Date)
//         {
//             // CalcFormula = lookup("Purch. Inv. Header"."Date Signature" where("Buy-from Vendor No." = field("Vendor No."),
//             //                                                                   "No." = field("Document No.")));
//             // Description = 'HJ SORO 24-10-2014';
//             // FieldClass = FlowField;
//         }
//         field(50023; "Date Paiement"; Date)
//         {
//             // CalcFormula = lookup("Purch. Inv. Header"."Date Paiement" where("Buy-from Vendor No." = field("Vendor No."),
//             //                                                                  "No." = field("Document No.")));
//             // Description = 'HJ SORO 24-10-2014';
//             // FieldClass = FlowField;
//         }
//         field(50024; "Sequence Lié"; Integer)
//         {
//             Description = 'HJ SORO 11-04-2015';
//         }
//         field(50025; "Fature Associé"; Code[20])
//         {
//             Description = 'HJ SORO 11-04-2015';
//         }
//         field(50050; "Statut Facture"; Option)
//         {
//             CalcFormula = lookup("Purch. Inv. Header"."Statut Facture" where("Buy-from Vendor No." = field("Vendor No."),
//                                                                               "No." = field("Document No.")));
//             Description = 'HJ SORO 24-10-2014';
//             FieldClass = FlowField;
//             OptionMembers = "Vérifié","En Cours De Paiement","En Cours De Signature","Signée","Payée";
//         }
//         field(50051; "Date En Cours Signature"; Date)
//         {
//             // CalcFormula = lookup("Purch. Inv. Header"."Date En Cours Signature" where("Buy-from Vendor No." = field("Vendor No."),
//             //                                                                            "No." = field("Document No.")));
//             // Description = 'HJ SORO 24-10-2014';
//             // FieldClass = FlowField;
//         }
//         field(50052; "Date Vérification"; Date)
//         {
//             CalcFormula = lookup("Purch. Inv. Header"."Date Vérification" where("Buy-from Vendor No." = field("Vendor No."),
//                                                                                  "No." = field("Document No.")));
//             Description = 'HJ SORO 24-10-2014';
//             FieldClass = FlowField;
//         }
//         field(50100; "Code Lettrage"; Text[3])
//         {
//             Description = 'HJ SORO 11-04-2015';
//             Editable = false;
//             FieldClass = Normal;
//         }
//         field(3010541; "Reference No."; Code[30])
//         {
//             Caption = 'Reference No.';
//         }
//         field(8001600; "Value Date"; Date)
//         {
//             Caption = 'Value Date';
//         }
//         field(8003923; "Job No."; Code[20])
//         {
//             Caption = 'Job No.';
//             TableRelation = Job;
//         }
//         field(8003924; "Apply-to Sales Order No."; Code[20])
//         {
//             Caption = 'Apply-to Sales Doc. No.';
//             TableRelation = "Sales Header"."No." where("Document Type" = const(Order),
//                                                         "No." = field("Apply-to Sales Order No."),
//                                                         "Order Type" = const(" "));

//             trigger OnValidate()
//             begin
//                 //PMT_DIRECT
//                 TestField(Open);
//                 if "Apply-to Sales Order No." <> '' then begin
//                     "Original Pmt. Disc. Possible" := 0;
//                     "Remaining Pmt. Disc. Possible" := 0;
//                 end;
//                 //PMT_DIRECT//
//             end;
//         }
//         field(8004100; "Bank Code"; Code[10])
//         {
//             Caption = 'Bank Code';
//             TableRelation = "Vendor Bank Account".Code where("Vendor No." = field("Vendor No."));
//         }
//     }

//     keys
//     {
//         key(Key1; "Entry No.", "Closed by Entry No.", "Fature Associé")
//         {
//             Clustered = true;
//         }
//         key(Key2; "Vendor No.", "Posting Date", "Currency Code")
//         {
//             SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
//         }
//         key(Key3; "Vendor No.", "Currency Code", "Posting Date")
//         {
//             Enabled = false;
//         }
//         key(Key4; "Document No.")
//         {
//         }
//         key(Key5; "External Document No.")
//         {
//         }
//         key(Key6; "Vendor No.", Open, Positive, "Due Date", "Currency Code")
//         {
//         }
//         key(Key7; Open, "Due Date")
//         {
//         }
//         key(Key8; "Document Type", "Vendor No.", "Posting Date", "Currency Code")
//         {
//             MaintainSIFTIndex = false;
//             MaintainSQLIndex = false;
//             SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
//         }
//         key(Key9; "Closed by Entry No.")
//         {
//         }
//         key(Key10; "Transaction No.")
//         {
//         }
//         key(Key11; "Vendor No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code")
//         {
//             Enabled = false;
//             SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
//         }
//         key(Key12; "Vendor No.", Open, "Global Dimension 1 Code", "Global Dimension 2 Code", Positive, "Due Date", "Currency Code")
//         {
//             Enabled = false;
//         }
//         key(Key13; Open, "Global Dimension 1 Code", "Global Dimension 2 Code", "Due Date")
//         {
//             Enabled = false;
//         }
//         key(Key14; "Document Type", "Vendor No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code")
//         {
//             Enabled = false;
//             MaintainSIFTIndex = false;
//             MaintainSQLIndex = false;
//         }
//         key(Key15; "Vendor No.", "Applies-to ID", Open, Positive, "Due Date")
//         {
//         }
//         key(Key16; Open, "Value Date")
//         {
//         }
//         key(Key17; "Vendor No.", "Vendor Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code", "Currency Code", "Due Date")
//         {
//         }
//         key(Key18; "Vendor No.", "Vendor Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code", "Currency Code", "Posting Date")
//         {
//         }
//         key(Key19; "Apply-to Sales Order No.")
//         {
//         }
//         key(Key20; "Job No.")
//         {
//         }
//         key(Key21; "Applies-to ID")
//         {
//         }
//         key(Key22; "Source Code", "Posting Date")
//         {
//         }
//         key(Key23; "Source Code", "Posting Date", "Document No.")
//         {
//         }
//         key(Key24; "Document Type")
//         {
//         }
//         key(Key25; "Vendor No.", "Document No.", Open)
//         {
//         }
//         key(Key26; Lettre)
//         {
//         }
//     }

//     fieldgroups
//     {
//         fieldgroup(DropDown; "Entry No.", Description, "Vendor No.", "Posting Date", "Document Type", "Document No.")
//         {
//         }
//     }

//     var
//         Text000: label 'must have the same sign as %1';
//         Text001: label 'must not be larger than %1';
//     // gAddOnLicencePermission: Codeunit IntegrManagement;


//     procedure DrillDownOnEntries(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry")
//     var
//         VendLedgEntry: Record "Vendor Ledger Entry";
//     begin
//         VendLedgEntry.Reset;
//         DtldVendLedgEntry.Copyfilter("Vendor No.", VendLedgEntry."Vendor No.");
//         DtldVendLedgEntry.Copyfilter("Currency Code", VendLedgEntry."Currency Code");
//         DtldVendLedgEntry.Copyfilter("Initial Entry Global Dim. 1", VendLedgEntry."Global Dimension 1 Code");
//         DtldVendLedgEntry.Copyfilter("Initial Entry Global Dim. 2", VendLedgEntry."Global Dimension 2 Code");
//         VendLedgEntry.SetCurrentkey("Vendor No.", "Posting Date");
//         VendLedgEntry.SetRange(Open, true);
//         page.Run(0, VendLedgEntry);
//     end;


//     procedure DrillDownOnOverdueEntries(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry")
//     var
//         VendLedgEntry: Record "Vendor Ledger Entry";
//     begin
//         VendLedgEntry.Reset;
//         DtldVendLedgEntry.Copyfilter("Vendor No.", VendLedgEntry."Vendor No.");
//         DtldVendLedgEntry.Copyfilter("Currency Code", VendLedgEntry."Currency Code");
//         DtldVendLedgEntry.Copyfilter("Initial Entry Global Dim. 1", VendLedgEntry."Global Dimension 1 Code");
//         DtldVendLedgEntry.Copyfilter("Initial Entry Global Dim. 2", VendLedgEntry."Global Dimension 2 Code");
//         VendLedgEntry.SetCurrentkey("Vendor No.", "Posting Date");
//         VendLedgEntry.SetFilter("Date Filter", '..%1', WorkDate);
//         VendLedgEntry.SetFilter("Due Date", '..%1', WorkDate);
//         VendLedgEntry.SetFilter("Remaining Amount", '<>%1', 0);
//         page.Run(0, VendLedgEntry);
//     end;


//     procedure GetOriginalCurrencyFactor(): Decimal
//     begin
//         if "Original Currency Factor" = 0 then
//             exit(1);
//         exit("Original Currency Factor");
//     end;
// }

