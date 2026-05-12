// Page 50276 "Ecriture Simulation Supprimé"
// {
//     PageType = List;
//     SourceTable = "Temp G/L Entry";
//     ApplicationArea = all;
//     Caption = 'Ecriture Simulation Supprimé';
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 Editable = false;
//                 ShowCaption = false;
//                 field("Entry No."; REC."Entry No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document No."; REC."Document No.")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("G/L Account No."; REC."G/L Account No.")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Letter; REC.Letter)
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Posting Date"; REC."Posting Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document Type"; REC."Document Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Description; REC.Description)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Bal. Account No."; REC."Bal. Account No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Amount; REC.Amount)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Global Dimension 1 Code"; REC."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Global Dimension 2 Code"; REC."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("User ID"; REC."User ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Source Code"; REC."Source Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("System-Created Entry"; REC."System-Created Entry")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prior-Year Entry"; REC."Prior-Year Entry")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Job No."; REC."Job No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Quantity; REC.Quantity)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("VAT Amount"; REC."VAT Amount")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Business Unit Code"; REC."Business Unit Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Journal Batch Name"; REC."Journal Batch Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Reason Code"; REC."Reason Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Gen. Posting Type"; REC."Gen. Posting Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Gen. Bus. Posting Group"; REC."Gen. Bus. Posting Group")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Gen. Prod. Posting Group"; REC."Gen. Prod. Posting Group")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Bal. Account Type"; REC."Bal. Account Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Transaction No."; REC."Transaction No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Debit Amount"; REC."Debit Amount")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Credit Amount"; REC."Credit Amount")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document Date"; REC."Document Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("External Document No."; REC."External Document No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Source Type"; REC."Source Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Source No."; REC."Source No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("No. Series"; REC."No. Series")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Tax Area Code"; REC."Tax Area Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Tax Liable"; REC."Tax Liable")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Tax Group Code"; REC."Tax Group Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Use Tax"; REC."Use Tax")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("VAT Bus. Posting Group"; REC."VAT Bus. Posting Group")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("VAT Prod. Posting Group"; REC."VAT Prod. Posting Group")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Additional-Currency Amount"; REC."Additional-Currency Amount")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Add.-Currency Debit Amount"; REC."Add.-Currency Debit Amount")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Add.-Currency Credit Amount"; REC."Add.-Currency Credit Amount")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Close Income Statement Dim. ID"; REC."Close Income Statement Dim. ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("IC Partner Code"; REC."IC Partner Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Reversed; REC.Reversed)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Reversed by Entry No."; REC."Reversed by Entry No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Reversed Entry No."; REC."Reversed Entry No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("G/L Account Name"; REC."G/L Account Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prod. Order No."; REC."Prod. Order No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("FA Entry Type"; REC."FA Entry Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("FA Entry No."; REC."FA Entry No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Entry Type"; REC."Entry Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Applies-to ID"; REC."Applies-to ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Letter Date"; REC."Letter Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Echeance"; REC."Date Echeance")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Folio N°"; REC."Folio N°")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Avance; REC.Avance)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(salarie; REC.salarie)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Débiteur clt"; REC."Débiteur clt")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Auxiliaire déb/créd1"; REC."Auxiliaire déb/créd1")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Débiteur frs"; REC."Débiteur frs")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Auxiliaire déb/créd2"; REC."Auxiliaire déb/créd2")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Folio N° RS"; REC."Folio N° RS")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(NOM; REC.NOM)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date D'echeance"; REC."Date D'echeance")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Affectation Financiere"; REC."Affectation Financiere")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Affectation Client"; REC."Affectation Client")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Client"; REC."Nom Client")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date D'échéance Ligne"; REC."Date D'échéance Ligne")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Subscription Starting Date"; REC."Subscription Starting Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Subscription End Date"; REC."Subscription End Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Subscription Entry No."; REC."Subscription Entry No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Analytical Distribution"; REC."Analytical Distribution")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

