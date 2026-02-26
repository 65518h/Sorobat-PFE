// Page 50060 "Payment Slip Subform 2"
// {
//     // //>>>MBK:05/02/2010: Référence chèque

//     AutoSplitKey = true;
//     Caption = 'Payment Slip Subform 2';
//     DelayedInsert = true;
//     PageType = listPart;
//     SourceTable = "Payment Line";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Chantier; rec.Chantier)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Proprietaire; rec.Proprietaire)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Line No."; rec."Line No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                     Caption = 'N° ligne';
//                 }
//                 field("Account Type"; rec."Account Type")
//                 {
//                     Caption = 'Type compte';
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Type de compte"; rec."Type de compte")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Type de compte';

//                     //    OptionCaption = 'General, Customer,Vendor, Bank and Cash, Fixed Assets, Item charge';
//                 }
//                 field("Code compte"; rec."Code compte")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code compte';
//                 }
//                 field("Account No."; rec."Account No.")
//                 {
//                     Caption = 'N° compte';
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Code Opération"; rec."Code Opération")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code Opération';
//                     Visible = false;
//                 }
//                 field("Copied To No."; rec."Copied To No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° destination';
//                     Visible = false;
//                 }
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                     Caption = 'Code devise';
//                 }
//                 field("Libellé  "; rec.Libellé)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Libellé';
//                 }
//                 field("Mode Paiement"; rec."Mode Paiement")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Mode Paiement';
//                 }
//                 field("Affectation Financiere"; rec."Affectation Financiere")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Affectation Financiere';
//                     //GL2024 Editable = false;
//                 }
//                 field("Drawee Reference"; rec."Drawee Reference")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Drawee Reference';
//                     Visible = false;
//                 }
//                 field("Montant Commission"; rec."Montant Commission")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                     Caption = 'Montant Commission';
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
//                     Caption = 'Montant Initial';
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
//                     Caption = 'Commentaires';
//                 }
//                 field(Banque; rec.Banque)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                     Caption = 'Banque';
//                 }
//                 field("Référence chèque"; rec."Référence chèque")
//                 {
//                     ApplicationArea = all;
//                     Enabled = "Référence chèqueEnable";
//                     Caption = 'Référence chèque';
//                     Visible = false;
//                 }
//                 field("Header Account Type"; rec."Header Account Type")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Type Compte en-tête';
//                     Visible = false;
//                 }
//                 field("Header Account No."; rec."Header Account No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                     Caption = 'N° Compte en-tête';
//                 }
//                 field("N° chèque"; rec."N° chèque")
//                 {
//                     Caption = 'N° chèque';
//                     ApplicationArea = all;
//                     Enabled = "N° chèqueEnable";
//                     Visible = false;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     Caption = 'Date d''échéance';
//                     ApplicationArea = all;
//                 }
//                 field("Date Loyer"; rec."Date Loyer")
//                 {
//                     Caption = 'Date Loyer';
//                     ApplicationArea = all;
//                 }
//                 field("Debit Amount"; rec."Debit Amount")
//                 {
//                     Caption = 'Montant débit';
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Visible = "Debit AmountVisible";
//                 }
//                 field("Credit Amount"; rec."Credit Amount")
//                 {
//                     Caption = 'Montant crédit';
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Visible = "Credit AmountVisible";
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° Piece De Paiement';
//                     Visible = true;
//                 }
//                 field(Aval; rec.Aval)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Commande N°"; rec."Commande N°")
//                 {
//                     Caption = 'Commande N°';
//                     ApplicationArea = all;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         PurchaseHeader.SetRange("Buy-from Vendor No.", rec."Account No.");
//                         PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
//                         PurchaseHeader.SetRange("Document Type", PurchaseHeader."document type"::Order);
//                         if page.RunModal(page::"Purchase List", PurchaseHeader) = Action::LookupOK then rec."Commande N°" := PurchaseHeader."No.";
//                     end;
//                 }
//                 field("Facture N°"; rec."Facture N°")
//                 {
//                     Caption = 'Facture N°';
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         PurchaseHeader.Reset;
//                         PurchaseHeader.SetRange("Buy-from Vendor No.", rec."Account No.");
//                         PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
//                         PurchaseHeader.SetRange("Document Type", PurchaseHeader."document type"::Invoice);
//                         if page.RunModal(page::"Purchase List", PurchaseHeader) = Action::LookupOK then rec."Facture N°" := PurchaseHeader."No.";
//                     end;
//                 }
//                 field(Imprimer; rec.Imprimer)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Applies-to ID"; rec."Applies-to ID")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                     Caption = 'ID lettrage';
//                 }
//                 field("Bank Account Name"; rec."Bank Account Name")
//                 {
//                     Caption = 'Nom compte bancaire';
//                     ApplicationArea = all;
//                     Visible = "Bank Account NameVisible";
//                 }
//                 field("Code Retenue à la Source"; rec."Code Retenue à la Source")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code Retenue à la Source';
//                 }
//                 field("Montant Retenue"; rec."Montant Retenue")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Montant Retenue';
//                     Editable = true;
//                 }
//                 field("Montant Retenue Validé"; rec."Montant Retenue Validé")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Montant Retenue Validé';
//                     Visible = true;
//                 }
//                 field("Montant Retenue TVA"; rec."Montant Retenue TVA")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Montant Retenue TVA';
//                     Visible = false;
//                 }
//                 field("Montant Retenue G."; rec."Montant Retenue G.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Montant Retenue G.';
//                 }
//                 field(Amount; rec.Amount)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Montant';
//                     DecimalPlaces = 3 : 3;
//                     Visible = AmountVisible;
//                 }
//                 field("Acceptation Code"; rec."Acceptation Code")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Acceptation Code';
//                     Visible = "Acceptation CodeVisible";
//                 }
//                 field("Payment Address Code"; rec."Payment Address Code")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code adresse de règlement';
//                     Visible = false;
//                 }
//                 field("Bank Branch No."; rec."Bank Branch No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code établissement';
//                     Visible = "Bank Branch No.Visible";
//                 }
//                 field("Agency Code"; rec."Agency Code")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code agence';
//                     Visible = "Agency CodeVisible";
//                 }
//                 field("Bank Account No."; rec."Bank Account No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = "Bank Account No.Visible";
//                     Caption = 'N° compte bancaire';
//                 }
//                 field("Bank City"; rec."Bank City")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Ville banque';
//                     Visible = false;
//                 }
//                 field(Benificiaire; rec.Benificiaire)
//                 {
//                     Caption = 'Benificiaire';
//                     ApplicationArea = all;
//                 }
//                 field("RIB Key"; rec."RIB Key")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Clé RIB';
//                     Visible = "RIB KeyVisible";
//                 }
//                 field("RIB Checked"; rec."RIB Checked")
//                 {
//                     ApplicationArea = all;
//                     caption = 'Vérification RIB';
//                     Visible = "RIB CheckedVisible";
//                 }
//                 field("Compte Bancaire"; rec."Compte Bancaire")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Compte Bancaire';
//                 }
//                 field(Afficher; Afficher)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Doc';

//                     trigger OnAssistEdit()
//                     begin
//                         //10868
//                         //PaymentHeader.SETRANGE("Mode Paiement","Mode Paiement");
//                         PaymentHeader.SetRange("N° Brouillard", rec."No.");
//                         //PaymentHeader.SETRANGE("Num Ligne","Line No.");
//                         if PaymentHeader.FindFirst then page.RunModal(Page::"Payment Slip", PaymentHeader);
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Lettrer2)
//             {
//                 ApplicationArea = all;
//                 Caption = '1  - Lettrer';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     recPaymentHeader: record "Payment Header";
//                     RecPaymentLineAV: Record "Payment Line";
//                     RecVendor: Record Vendor;
//                     RecPurchaseHeader: Record "Purchase Header";
//                     RecPaymentLineAV2: Record "Payment Line";
//                     Text005: label 'Deja Valider';
//                 begin

//                     if recPaymentHeader.get(Rec."No.") then;
//                     IF recPaymentHeader.Valider THEN ERROR(Text005);

//                     // MH SORO 03-05-2023


//                     IF (recPaymentHeader."Payment Class" = 'AVANCE-FRS-CHEQ') OR (recPaymentHeader."Payment Class" = 'AVANCE-FRS-TRT') THEN BEGIN

//                         RecPaymentLineAV.RESET();
//                         RecPaymentLineAV.SETRANGE("No.", recPaymentHeader."No.");
//                         IF RecPaymentLineAV.FINDFIRST THEN BEGIN
//                             RecVendor.RESET();
//                             IF RecVendor.GET(RecPaymentLineAV."Code compte") THEN;
//                             IF (RecVendor."Autoriser Avance" = TRUE) OR (recPaymentHeader."Autoriser avance Fournisseur" = TRUE) THEN BEGIN
//                                 //************************
//                                 IF RecPaymentLineAV."Commande N°" = '' THEN
//                                     ERROR('Champs oblogatoire : N° Commande')
//                                 ELSE BEGIN
//                                     RecPurchaseHeader.RESET();
//                                     RecPurchaseHeader.SETRANGE("No.", RecPaymentLineAV."Commande N°");
//                                     IF NOT RecPurchaseHeader.FINDFIRST THEN
//                                         ERROR('N° Bon commande n existe pas')
//                                     ELSE BEGIN
//                                         RecPaymentLineAV2.RESET();
//                                         RecPaymentLineAV2.SETFILTER("No.", '<>%1', rec."No.");
//                                         RecPaymentLineAV2.SETRANGE("Commande N°", RecPaymentLineAV."Commande N°");
//                                         IF RecPaymentLineAV2.FINDFIRST THEN
//                                             ERROR('N° Bon commande déja affecter à lavance N°: %1', RecPaymentLineAV2."No.");

//                                     END;
//                                 END;
//                                 //**********************
//                             END
//                             ELSE
//                                 ERROR('Fournisseur Non Autoriser pour avoir une Avance');

//                         END;
//                     END;
//                     //**********************
//                     // MH SORO 03-05-2023

//                     Application;
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         ActivateControls;
//         ImprimerOnFormat;
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
//         Text001: label 'There is no line to modify';
//         Text002: label 'A posted line cannot be modified.';
//         PaymentClass: Record "Payment Class";
//         Afficher: Code[20];
//         PaymentHeader: Record "Payment Header";
//         PurchaseHeader: Record "Purchase Header";
//         Text003: label 'Impression Achevée Avec Succée ?';
//         Text004: label 'Deja Imprimer ';
//         [InDataSet]
//         ImprimerEmphasize: Boolean;
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
//         Codeunit.Run(Codeunit::"Payment-ApplyCopy", Rec);
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
//         Text016: Label 'A posted line cannot be deleted.';
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
//                     //GL2024 License       PostingStatement.IncrementNoText(No, 1);
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
//         // >> HJ SORO 13-01-2015
//         //IF "Payment Class"='PAIEMENT' THEN
//         // CurrForm."Compte Bancaire".VISIBLE:=TRUE ELSE CurrForm."Compte Bancaire".VISIBLE:=FALSE;
//         // >> HJ SORO 13-01-2015
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
//         rec.FractionnerLine;
//     end;


//     procedure "---MBK---"()
//     begin
//     end;


//     procedure REFCHEQUE(): Code[20]
//     begin
//         //>>>MBK:05/02/2010: Référence chèque
//         exit(rec."Référence chèque");
//     end;


//     procedure GetLineNumber() LineNumber: Integer
//     begin
//         exit(rec."Line No.");
//     end;


//     procedure IsPrinted()
//     begin
//         if Confirm(Text003) then rec.Imprimer := 'O';
//     end;


//     procedure GetImprimer()
//     begin
//         if rec.Imprimer = 'O' then Error(Text004);
//     end;

//     local procedure ImprimerOnFormat()
//     begin
//         if rec.Imprimer = 'O' then begin
//             ImprimerEmphasize := true;
//         end;
//     end;
// }

