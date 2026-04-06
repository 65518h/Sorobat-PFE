// Table 39001525 "Temp G/L Entry"
// {
//     //GL2024  ID dans Nav 2009 : "39001525"
//     // //+REP+ GESWAY 17/10/01 Ajout champ 8003500 Analytical distribution
//     //                         Ajout clé : Analytical Distribution,G/L Account No.,Global Dimension 1 Code,
//     //                                     Global Dimension 2 Code,Reason Code,Gen. Bus. Posting Group,
//     //                                     Gen. Prod. Posting Group,Job No.,Source Code,Business Unit Code,Posting Date
//     // //+REF+FR_APPLYLEDGER CLA 25/04/05 Ajout champs en 10800 pour lettrage
//     //                                    Ajout clé G/L Account No.,Letter
//     // //+ABO+ GESWAY 15/07/02 +"Subscription Starting Date","Subscription End Date","Subscription Entry No."
//     //                         +key/"Subscription Entry No."
//     // //BE CW 04/05/05 Clé "G/L Account No.,Posting Date" + "Document Type" pour report 12
//     // //PERF MB 28/08/06 MAJ SIFT Index

//     Caption = 'G/L Entry';

//     fields
//     {
//         field(1; "Entry No."; Integer)
//         {
//             Caption = 'Entry No.';
//         }
//         field(3; "G/L Account No."; Code[20])
//         {
//             Caption = 'G/L Account No.';
//             TableRelation = "G/L Account";
//         }
//         field(4; "Posting Date"; Date)
//         {
//             Caption = 'Posting Date';
//             ClosingDates = true;
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
//         field(10; "Bal. Account No."; Code[20])
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
//             if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset"
//             else
//             if ("Bal. Account Type" = const("IC Partner")) "IC Partner";
//         }
//         field(17; Amount; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Amount';
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
//         field(29; "System-Created Entry"; Boolean)
//         {
//             Caption = 'System-Created Entry';
//         }
//         field(30; "Prior-Year Entry"; Boolean)
//         {
//             Caption = 'Prior-Year Entry';
//         }
//         field(41; "Job No."; Code[20])
//         {
//             Caption = 'Job No.';
//             TableRelation = Job;
//         }
//         field(42; Quantity; Decimal)
//         {
//             Caption = 'Quantity';
//             DecimalPlaces = 0 : 5;
//         }
//         field(43; "VAT Amount"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'VAT Amount';
//         }
//         field(45; "Business Unit Code"; Code[10])
//         {
//             Caption = 'Business Unit Code';
//             TableRelation = "Business Unit";
//         }
//         field(46; "Journal Batch Name"; Code[10])
//         {
//             Caption = 'Journal Batch Name';
//         }
//         field(47; "Reason Code"; Code[10])
//         {
//             Caption = 'Reason Code';
//             TableRelation = "Reason Code";
//         }
//         field(48; "Gen. Posting Type"; Option)
//         {
//             Caption = 'Gen. Posting Type';
//             OptionCaption = ' ,Purchase,Sale,Settlement';
//             OptionMembers = " ",Purchase,Sale,Settlement;
//         }
//         field(49; "Gen. Bus. Posting Group"; Code[10])
//         {
//             Caption = 'Gen. Bus. Posting Group';
//             TableRelation = "Gen. Business Posting Group";
//         }
//         field(50; "Gen. Prod. Posting Group"; Code[10])
//         {
//             Caption = 'Gen. Prod. Posting Group';
//             TableRelation = "Gen. Product Posting Group";
//         }
//         field(51; "Bal. Account Type"; Option)
//         {
//             Caption = 'Bal. Account Type';
//             OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
//             OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
//         }
//         field(52; "Transaction No."; Integer)
//         {
//             Caption = 'Transaction No.';
//         }
//         field(53; "Debit Amount"; Decimal)
//         {
//             AutoFormatType = 1;
//             //blankzero = true;
//             Caption = 'Debit Amount';
//         }
//         field(54; "Credit Amount"; Decimal)
//         {
//             AutoFormatType = 1;
//             //blankzero = true;
//             Caption = 'Credit Amount';
//         }
//         field(55; "Document Date"; Date)
//         {
//             Caption = 'Document Date';
//             ClosingDates = true;
//         }
//         field(56; "External Document No."; Code[50])
//         {
//             Caption = 'External Document No.';
//         }
//         field(57; "Source Type"; Option)
//         {
//             Caption = 'Source Type';
//             OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Asset';
//             OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset","Salarié";
//         }
//         field(58; "Source No."; Code[20])
//         {
//             Caption = 'Source No.';
//             TableRelation = if ("Source Type" = const(Customer)) Customer
//             else
//             if ("Source Type" = const(Vendor)) Vendor
//             else
//             if ("Source Type" = const("Bank Account")) "Bank Account"
//             else
//             if ("Source Type" = const("Fixed Asset")) "Fixed Asset";

//             trigger OnValidate()
//             var
//                 RecVendor: Record Vendor;
//                 RecCustomer: Record Customer;
//             begin
//             end;
//         }
//         field(59; "No. Series"; Code[10])
//         {
//             Caption = 'No. Series';
//             TableRelation = "No. Series";
//         }
//         field(60; "Tax Area Code"; Code[20])
//         {
//             Caption = 'Tax Area Code';
//             TableRelation = "Tax Area";
//         }
//         field(61; "Tax Liable"; Boolean)
//         {
//             Caption = 'Tax Liable';
//         }
//         field(62; "Tax Group Code"; Code[10])
//         {
//             Caption = 'Tax Group Code';
//             TableRelation = "Tax Group";
//         }
//         field(63; "Use Tax"; Boolean)
//         {
//             Caption = 'Use Tax';
//         }
//         field(64; "VAT Bus. Posting Group"; Code[10])
//         {
//             Caption = 'VAT Bus. Posting Group';
//             TableRelation = "VAT Business Posting Group";
//         }
//         field(65; "VAT Prod. Posting Group"; Code[10])
//         {
//             Caption = 'VAT Prod. Posting Group';
//             TableRelation = "VAT Product Posting Group";
//         }
//         field(68; "Additional-Currency Amount"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Additional-Currency Amount';
//         }
//         field(69; "Add.-Currency Debit Amount"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Add.-Currency Debit Amount';
//         }
//         field(70; "Add.-Currency Credit Amount"; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Add.-Currency Credit Amount';
//         }
//         field(71; "Close Income Statement Dim. ID"; Integer)
//         {
//             Caption = 'Close Income Statement Dim. ID';
//         }
//         field(72; "IC Partner Code"; Code[20])
//         {
//             Caption = 'IC Partner Code';
//             TableRelation = "IC Partner";
//         }
//         field(73; Reversed; Boolean)
//         {
//             Caption = 'Reversed';
//         }
//         field(74; "Reversed by Entry No."; Integer)
//         {
//             //blankzero = true;
//             Caption = 'Reversed by Entry No.';
//             TableRelation = "G/L Entry";
//         }
//         field(75; "Reversed Entry No."; Integer)
//         {
//             //blankzero = true;
//             Caption = 'Reversed Entry No.';
//             TableRelation = "G/L Entry";
//         }
//         field(76; "G/L Account Name"; Text[50])
//         {
//             CalcFormula = lookup("G/L Account".Name where("No." = field("G/L Account No.")));
//             Caption = 'G/L Account Name';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(5400; "Prod. Order No."; Code[20])
//         {
//             Caption = 'Prod. Order No.';
//         }
//         field(5600; "FA Entry Type"; Option)
//         {
//             Caption = 'FA Entry Type';
//             OptionCaption = ' ,Fixed Asset,Maintenance';
//             OptionMembers = " ","Fixed Asset",Maintenance;
//         }
//         field(5601; "FA Entry No."; Integer)
//         {
//             //blankzero = true;
//             Caption = 'FA Entry No.';
//             TableRelation = if ("FA Entry Type" = const("Fixed Asset")) "FA Ledger Entry"
//             else
//             if ("FA Entry Type" = const(Maintenance)) "Maintenance Ledger Entry";
//         }
//         field(10810; "Entry Type"; Option)
//         {
//             Caption = 'Entry Type';
//             OptionCaption = 'Definitive,Simulation';
//             OptionMembers = Definitive,Simulation;
//         }
//         field(10811; "Applies-to ID"; Code[20])
//         {
//             Caption = 'Applies-to ID';
//             Editable = false;
//         }
//         field(10812; Letter; Text[3])
//         {
//             Caption = 'Letter';
//             Editable = false;
//         }
//         field(10813; "Letter Date"; Date)
//         {
//             Caption = 'Letter Date';
//             Editable = false;
//         }
//         field(50001; "Date Echeance"; Text[10])
//         {
//             Description = 'HJ SORO 09-0-2014 Modifier RB SORO 16/03/16';
//         }
//         field(50002; Lettre; Text[3])
//         {
//             Description = 'HJ SORO 09-0-2014';
//         }
//         field(50020; "Folio N°"; Code[20])
//         {
//             Description = 'HJ DSFT 25 03 2012';
//         }
//         field(50021; Avance; Boolean)
//         {
//             // CalcFormula = lookup("Payment Header".Avance where("No." = field("Document No.")));
//             // Description = 'RB SORO 27/03/2015';
//             // FieldClass = FlowField;
//         }
//         field(50022; salarie; Code[20])
//         {
//             Description = 'HJ SORO 06-04-2015';
//             TableRelation = Salarier;
//         }
//         field(50023; "Débiteur clt"; Boolean)
//         {
//             CalcFormula = exist(Customer where("No." = field("Source No."),
//                                                 Balance = filter(> 0)));
//             FieldClass = FlowField;
//         }
//         field(50025; "Auxiliaire déb/créd1"; Option)
//         {
//             OptionCaption = 'Débiteur,Crediteur';
//             OptionMembers = "Débiteur",Crediteur;
//         }
//         field(50026; "Débiteur frs"; Boolean)
//         {
//             CalcFormula = exist(Vendor where("No." = field("Source No."),
//                                               Balance = filter(> 0)));
//             FieldClass = FlowField;
//         }
//         field(50027; "Auxiliaire déb/créd2"; Option)
//         {
//             OptionCaption = 'Débiteur,Crediteur';
//             OptionMembers = "Débiteur",Crediteur;
//         }
//         field(50031; "Folio N° RS"; Code[20])
//         {
//             Description = 'RB SORO 27/04/2015';
//         }
//         field(50032; NOM; Text[100])
//         {
//             Description = 'RB SORO 12/05/2015 NOM DE CLIENT OU NOM DE FOURNISSEUR';
//         }
//         field(50033; "Date D'echeance"; Date)
//         {
//             Description = 'RB SORO 16/03/2016';
//         }
//         field(50034; "Affectation Financiere"; Code[60])
//         {
//             Description = 'HJ SORO 23-02-2017';
//         }
//         field(50035; "Affectation Client"; Code[20])
//         {
//             // CalcFormula = lookup("Payment Line"."Affectation Client" where("No." = field("Document No.")));
//             // Description = 'RB SORO 13/07/2017';
//             // FieldClass = FlowField;
//             // TableRelation = Customer."No.";
//         }
//         field(50036; "Nom Client"; Text[50])
//         {
//             CalcFormula = lookup(Customer.Name where("No." = field("Affectation Client")));
//             Description = 'RB SORO 13/07/2017';
//             FieldClass = FlowField;
//         }
//         field(50099; "Date D'échéance Ligne"; Date)
//         {
//             CalcFormula = lookup("Payment Line"."Due Date" where("No." = field("Document No.")));
//             Description = 'MH SORO 17-08-2020';
//             FieldClass = FlowField;
//         }
//         field(8001900; "Subscription Starting Date"; Date)
//         {
//             Caption = 'Subscription Starting Date';
//         }
//         field(8001901; "Subscription End Date"; Date)
//         {
//             Caption = 'Subscription End Date';
//         }
//         field(8001904; "Subscription Entry No."; Integer)
//         {
//             //blankzero = true;
//             Caption = 'Subscription Entry No.';
//         }
//         field(8003500; "Analytical Distribution"; Boolean)
//         {
//             Caption = 'Analytical Distribution';
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "Entry No.")
//         {
//             Clustered = true;
//         }
//         key(STG_Key2; "G/L Account No.", "Posting Date", "Entry Type")
//         {
//             SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
//         }
//         key(STG_Key3; "G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date")
//         {
//             SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
//         }
//         key(STG_Key4; "G/L Account No.", "Business Unit Code", "Posting Date")
//         {
//             SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
//         }
//         key(STG_Key5; "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date")
//         {
//             SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
//         }
//         key(STG_Key6; "Document No.", "Posting Date")
//         {
//         }
//         key(STG_Key7; "Transaction No.")
//         {
//         }
//         key(STG_Key8; "IC Partner Code")
//         {
//         }
//         key(STG_Key9; "G/L Account No.", "Job No.", "Posting Date")
//         {
//             SumIndexFields = Amount;
//         }
//         key(STG_Key10; "G/L Account No.", Letter)
//         {
//         }
//         key(STG_Key11; "Subscription Entry No.")
//         {
//         }
//         key(STG_Key12; "Analytical Distribution", "G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Reason Code", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "Job No.", "Source Code", "Business Unit Code", "Posting Date")
//         {
//             MaintainSIFTIndex = false;
//         }
//         key(STG_Key13; "G/L Account No.", "Posting Date", "Document Type")
//         {
//             SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
//         }
//         key(STG_Key14; "Source No.")
//         {
//         }
//         key(STG_Key15; "Posting Date")
//         {
//         }
//         key(STG_Key16; "Source No.", "G/L Account No.", "Posting Date")
//         {
//         }
//         key(STG_Key17; "Source Code", "Posting Date")
//         {
//         }
//         key(STG_Key18; "G/L Account No.", "Posting Date", "Source Code")
//         {
//         }
//         key(STG_Key19; "Source Type", "Source No.")
//         {
//             SumIndexFields = Amount;
//         }
//         key(STG_Key20; "Source Code", "Posting Date", "Document No.")
//         {
//         }
//         key(STG_Key21; "Applies-to ID")
//         {
//         }
//         key(STG_Key22; Letter, "Source No.", "External Document No.", "Posting Date", Amount, "G/L Account No.")
//         {
//         }
//         key(STG_Key23; "G/L Account No.", "Source No.")
//         {
//         }
//         key(STG_Key24; salarie)
//         {
//         }
//         key(STG_Key25; "Source No.", "Source Type", Lettre, "G/L Account No.")
//         {
//             SumIndexFields = Amount;
//         }
//         key(STG_Key26; "G/L Account No.", "Posting Date", "Source No.", "Entry Type", "Auxiliaire déb/créd1", "Auxiliaire déb/créd2")
//         {
//             SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
//         }
//     }

//     fieldgroups
//     {
//         fieldgroup(DropDown; "Entry No.", Description, "G/L Account No.", "Posting Date", "Document Type", "Document No.")
//         {
//         }
//     }
// }

