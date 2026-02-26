// Page 50068 "Payment Slip Subform 3"
// {
//     // //>>>MBK:05/02/2010: Référence chèque

//     AutoSplitKey = true;
//     Caption = 'Payment Slip Subform 3';
//     DelayedInsert = true;
//     PageType = ListPart;
//     SourceTable = "Payment Line";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field(Chantier; rec.Chantier)
//                 {
//                     ApplicationArea = all;
//                     Visible = true;
//                 }
//                 field(Proprietaire; rec.Proprietaire)
//                 {
//                     ApplicationArea = all;
//                     Visible = true;
//                 }
//                 field("Mode Paiement"; rec."Mode Paiement")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Line No."; rec."Line No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Account Type"; rec."Account Type")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Type de compte"; rec."Type de compte")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Type de compte';
//                     OptionCaption = 'Général, Client, Fournisseur, Banque Ou Caisse, Immobilisations, Frais annexe';

//                 }
//                 field("Code compte"; rec."Code compte")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° Compte';
//                 }
//                 field("Account No."; rec."Account No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Code Opération"; rec."Code Opération")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Libellé  "; rec.Libellé)
//                 {
//                     ApplicationArea = all;
//                     Description = '<AGA>';
//                 }
//                 field("Drawee Reference"; rec."Drawee Reference")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Montant Commission"; rec."Montant Commission")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Amount (LCY)"; rec."Amount (LCY)")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = true;
//                     Visible = false;
//                 }
//                 field("Montant Initial"; rec."Montant Initial")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Visible = false;
//                 }
//                 field("Montant Initial DS"; rec."Montant Initial DS")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Visible = false;
//                 }
//                 field(Commentaires; rec.Commentaires)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Référence chèque"; rec."Référence chèque")
//                 {
//                     ApplicationArea = all;
//                     Enabled = "Référence chèqueEnable";
//                     Visible = false;
//                 }
//                 field("Header Account Type"; rec."Header Account Type")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Header Account No."; rec."Header Account No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("N° chèque"; rec."N° chèque")
//                 {
//                     ApplicationArea = all;
//                     Enabled = "N° chèqueEnable";
//                     Visible = false;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = all;
//                 }

//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = true;
//                 }
//                 field("Commande N°"; rec."Commande N°")
//                 {
//                     ApplicationArea = all;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         PurchaseHeader.SetRange("Buy-from Vendor No.", rec."Account No.");
//                         PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
//                         PurchaseHeader.SetRange("Document Type", PurchaseHeader."document type"::Order);
//                         if page.RunModal(page::"Purchase List", PurchaseHeader) = Action::LookupOK then rec."Commande N°" := PurchaseHeader."No.";
//                     end;
//                 }
//                 field("Applies-to ID"; rec."Applies-to ID")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Bank Account Name"; rec."Bank Account Name")
//                 {
//                     ApplicationArea = all;
//                     Visible = "Bank Account NameVisible";
//                 }
//                 field("Code Retenue à la Source"; rec."Code Retenue à la Source")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Montant Retenue"; rec."Montant Retenue")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field("Montant Retenue Validé"; rec."Montant Retenue Validé")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Montant Retenue TVA"; rec."Montant Retenue TVA")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Montant Retenue G."; rec."Montant Retenue G.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Amount; rec.Amount)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Visible = AmountVisible;
//                 }
//                 field("Debit Amount"; rec."Debit Amount")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     //   Visible = "Debit AmountVisible";
//                 }
//                 field("Credit Amount"; rec."Credit Amount")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     //   Visible = "Credit AmountVisible";
//                 }
//                 field("Acceptation Code"; rec."Acceptation Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = "Acceptation CodeVisible";
//                 }
//                 field("Payment Address Code"; rec."Payment Address Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Bank Branch No."; rec."Bank Branch No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = "Bank Branch No.Visible";
//                 }
//                 field("Agency Code"; rec."Agency Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = "Agency CodeVisible";
//                 }
//                 field("Bank Account No."; rec."Bank Account No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = "Bank Account No.Visible";
//                 }
//                 field("Bank City"; rec."Bank City")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Affectation Client"; rec."Affectation Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Nom Client"; rec."Nom Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Benificiaire; rec.Benificiaire)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("RIB Key"; rec."RIB Key")
//                 {
//                     ApplicationArea = all;
//                     Visible = "RIB KeyVisible";
//                 }
//                 field("RIB Checked"; rec."RIB Checked")
//                 {
//                     ApplicationArea = all;
//                     Visible = "RIB CheckedVisible";
//                 }
//                 field("Compte Bancaire"; rec."Compte Bancaire")
//                 {
//                     ApplicationArea = all;
//                     Visible = true;
//                 }
//                 field(Afficher; Afficher)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Doc';
//                     Visible = false;

//                     trigger OnAssistEdit()
//                     begin
//                         //10868
//                         PaymentHeader.SetRange("Mode Paiement", rec."Mode Paiement");
//                         PaymentHeader.SetRange("N° Brouillard", rec."No.");
//                         PaymentHeader.SetRange("Num Ligne", rec."Line No.");
//                         page.RunModal(Page::"Payment Slip", PaymentHeader);
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord()
//     begin
//         ActivateControls;
//     end;

//     trigger OnInit()
//     begin
//         "N° chèqueEnable" := true;
//         "Référence chèqueEnable" := true;
//         "Credit AmountVisible" := true;
//         "Debit AmountVisible" := true;
//         AmountVisible := true;
//         "Bank Account NameVisible" := true;
//         "Bank Account No.Visible" := true;
//         "Agency CodeVisible" := true;
//         "Bank Branch No.Visible" := true;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         rec.SetUpNewLine(xRec, BelowxRec);
//     end;

//     var
//         Text000: label 'Assign No. ?';
//         Header: Record "Payment Header";
//         Status: Record "Payment Status";
//         Text001: label 'Il n’y a aucune ligne à modifier.';
//         Text002: label 'Une ligne validée ne peut pas être modifiée.';
//         PaymentClass: Record "Payment Class";
//         Afficher: Code[20];
//         PaymentHeader: Record "Payment Header";
//         PurchaseHeader: Record "Purchase Header";
//         [InDataSet]
//         "Bank Branch No.Visible": Boolean;
//         [InDataSet]
//         "Agency CodeVisible": Boolean;
//         [InDataSet]
//         "Bank Account No.Visible": Boolean;
//         [InDataSet]
//         "Bank Account NameVisible": Boolean;
//         [InDataSet]
//         "RIB KeyVisible": Boolean;
//         [InDataSet]
//         "RIB CheckedVisible": Boolean;
//         [InDataSet]
//         "Acceptation CodeVisible": Boolean;
//         [InDataSet]
//         AmountVisible: Boolean;
//         [InDataSet]
//         "Debit AmountVisible": Boolean;
//         [InDataSet]
//         "Credit AmountVisible": Boolean;
//         [InDataSet]
//         "Référence chèqueEnable": Boolean;
//         [InDataSet]
//         "N° chèqueEnable": Boolean;


//     procedure Application()
//     begin
//         Codeunit.Run(Codeunit::"Payment-Apply", Rec);
//     end;



//     procedure ShowDimensions()
//     var
//         DimMgt: Codeunit DimensionManagement;
//     begin
//         //GL2024 License   Rec.ShowDimensions;
//         //GL2024 License 
//         rec."Dimension Set ID" :=
//        DimMgt.EditDimensionSet(rec."Dimension Set ID", StrSubstNo('%1 %2 %3', rec.TableCaption(), rec."No.", rec."Line No."));
//         //GL2024 License 
//     end;

//     procedure DisableFields()
//     begin
//         if Header.Get(rec."No.") then begin
//             if (Header."Status No." = 0) and (rec."Copied To No." = '') then
//                 CurrPage.Editable(true)
//             else
//                 CurrPage.Editable(false);
//         end;
//     end;


//     procedure Modify()
//     var
//         PaymentLine: Record "Payment Line";
//         PaymentModification: Page "Payment Line Modification";
//     begin
//         if rec."Line No." = 0 then
//             Message(Text001)
//         else
//             if not rec.Posted then begin
//                 PaymentLine.Copy(Rec);
//                 PaymentLine.SetRange("No.", rec."No.");
//                 PaymentLine.SetRange("Line No.", rec."Line No.");
//                 PaymentModification.SetTableview(PaymentLine);
//                 PaymentModification.RunModal;
//             end else
//                 Message(Text002);
//     end;


//     procedure Delete()
//     var
//         PostingStatement: Codeunit "Payment Management";
//         StatementLine: Record "Payment Line";
//     begin
//         StatementLine.Copy(Rec);
//         CurrPage.SetSelectionFilter(StatementLine);
//         //GL2024 License  PostingStatement.DeleteLigBorCopy(StatementLine);
//         DeleteLigBorCopy2(StatementLine);
//     end;
//     //GL2024 License 
//     procedure DeleteLigBorCopy2(var FromPaymentLine: Record "Payment Line")
//     var
//         ToPaymentLine: Record "Payment Line";
//         Text016: Label 'Une ligne validée ne peut pas être supprimée.';
//     begin
//         ToPaymentLine.SetCurrentKey("Copied To No.", "Copied To Line");

//         if FromPaymentLine.Find('-') then
//             if FromPaymentLine.Posted then
//                 Message(Text016)
//             else
//                 repeat
//                     ToPaymentLine.SetRange("Copied To No.", FromPaymentLine."No.");
//                     ToPaymentLine.SetRange("Copied To Line", FromPaymentLine."Line No.");
//                     ToPaymentLine.FindFirst();
//                     ToPaymentLine."Copied To No." := '';
//                     ToPaymentLine."Copied To Line" := 0;
//                     ToPaymentLine.Modify();
//                     FromPaymentLine.Delete(true);
//                 until FromPaymentLine.Next() = 0;
//     end;
//     //GL2024 License 



//     procedure SetDocumentID()
//     var
//         StatementLine: Record "Payment Line";
//         PostingStatement: Codeunit "Payment Management";
//         No: Code[20];
//     begin
//         if Confirm(Text000) then begin
//             CurrPage.SetSelectionFilter(StatementLine);
//             StatementLine.MarkedOnly(true);
//             if not StatementLine.Find('-') then
//                 StatementLine.MarkedOnly(false);
//             if StatementLine.Find('-') then begin
//                 No := StatementLine."Document No.";
//                 while StatementLine.Next <> 0 do begin
//                     //GL2024 License     PostingStatement.IncrementNoText(No, 1);
//                     StatementLine."Document No." := No;
//                     StatementLine.Modify;
//                 end;
//             end;
//         end;
//     end;


//     procedure ShowAccount()
//     var
//         GenJnlLine: Record "Gen. Journal Line";
//     begin
//         GenJnlLine."Account Type" := rec."Account Type";
//         GenJnlLine."Account No." := rec."Account No.";
//         Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", GenJnlLine);
//     end;


//     procedure ShowEntries()
//     var
//         GenJnlLine: Record "Gen. Journal Line";
//     begin
//         GenJnlLine."Account Type" := rec."Account Type";
//         GenJnlLine."Account No." := rec."Account No.";
//         Codeunit.Run(Codeunit::"Gen. Jnl.-Show Entries", GenJnlLine);
//     end;


//     procedure MarkLines(ToMark: Boolean)
//     var
//         LineCopy: Record "Payment Line";
//         PaymtManagt: Codeunit "Payment Management";
//         NumLines: Integer;
//     begin
//         if ToMark then begin
//             CurrPage.SetSelectionFilter(LineCopy);
//             LineCopy.MarkedOnly(true);
//             NumLines := LineCopy.Count;
//             if NumLines > 0 then begin
//                 LineCopy.Find('-');
//                 repeat
//                     if LineCopy.Mark then begin
//                         LineCopy.Marked := true;
//                         LineCopy.Modify;
//                     end;
//                 until LineCopy.Next = 0;
//             end else
//                 LineCopy.Reset;
//             LineCopy.SetRange("No.", rec."No.");
//             LineCopy.ModifyAll(Marked, true);
//         end else begin
//             rec.ClearMarks;
//             LineCopy.SetRange("No.", rec."No.");
//             LineCopy.ModifyAll(Marked, false);
//         end;
//         Commit;
//     end;


//     procedure ActivateControls()
//     begin
//         if Header.Get(rec."No.") then begin
//             Status.Get(Header."Payment Class", Header."Status No.");
//             if Status.RIB then begin
//                 "Bank Branch No.Visible" := true;
//                 "Agency CodeVisible" := true;
//                 "Bank Account No.Visible" := true;
//                 "Bank Account NameVisible" := true;
//                 "RIB KeyVisible" := true;
//                 "RIB CheckedVisible" := true;
//             end else begin
//                 "Bank Branch No.Visible" := false;
//                 "Agency CodeVisible" := false;
//                 "Bank Account No.Visible" := false;
//                 "Bank Account NameVisible" := false;
//                 "RIB KeyVisible" := false;
//                 "RIB CheckedVisible" := false;
//             end;
//             if Status."Acceptation Code" then begin
//                 "Acceptation CodeVisible" := true;
//             end else begin
//                 "Acceptation CodeVisible" := false;
//             end;
//             AmountVisible := Status.Amount;
//             "Debit AmountVisible" := Status.Debit;
//             "Credit AmountVisible" := Status.Credit;
//             //>>>MBK:05/02/2010: Référence chèque
//             "Référence chèqueEnable" := Status."Référence Chèque";
//             "N° chèqueEnable" := Status."Référence Chèque";
//             //<<<MBK:05/02/2010: Référence chèque

//             DisableFields;
//         end;
//     end;


//     procedure CalculerRetenu()
//     begin
//         rec.CalcRetenu;
//     end;


//     procedure Actualiser()
//     begin
//         rec.CalcAmount;
//     end;


//     procedure Affichelib() Lib: Text[100]
//     var
//         banq: Record "Bank Account";
//         Frs: Record Vendor;
//         cust: Record Customer;
//         Cmpt: Record "G/L Account";
//         Sal: Record Employee;
//     begin
//         Frs.Reset;
//         cust.Reset;
//         Cmpt.Reset;
//         Sal.Reset;
//         banq.Reset;
//         Lib := '';
//         if rec."Account No." <> '' then
//             case rec."Account Type" of
//                 rec."account type"::Vendor:
//                     begin
//                         if Frs.Get(rec."Account No.") then
//                             Lib := Frs.Name;
//                     end;
//                 rec."account type"::"G/L Account":
//                     begin
//                         if Cmpt.Get(rec."Account No.") then
//                             Lib := Cmpt.Name;
//                     end;

//                 rec."account type"::Customer:
//                     begin
//                         if cust.Get(rec."Account No.") then
//                             Lib := cust.Name;
//                     end;
//                 /*"Account Type"::Salary : BEGIN
//                    IF Sal.GET("Account No.") THEN
//                       Lib:=Sal."Last Name"+' '+Sal."First Name";
//                    END;*/
//                 rec."account type"::"Bank Account":
//                     begin
//                         if banq.Get(rec."Account No.") then
//                             Lib := banq.Name;
//                     end;
//             end;

//     end;


//     procedure fractLine()
//     begin
//         //GL2024 FractionnerLine;
//     end;


//     procedure "---MBK---"()
//     begin
//     end;


//     procedure REFCHEQUE(): Code[20]
//     begin
//         //>>>MBK:05/02/2010: Référence chèque
//         exit(rec."Référence chèque");
//     end;
// }

