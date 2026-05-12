// Page 50035 "Ligne Paiement Caisse"
// {
//     // //>>>MBK:05/02/2010: Référence chèque

//     AutoSplitKey = true;
//     Caption = 'Ligne Paiement Caisse';
//     DelayedInsert = false;
//     //  Editable = false;
//     PageType = ListPart;
//     SourceTable = "Payment Line";
//     SourceTableView = where("Copied To No." = filter('')); 
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Numero Seq"; rec."Numero Seq")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Numero Seq';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                     Visible = true;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date d''échéance';
//                 }
//                 field("Code Opération"; rec."Code Opération")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code Opération';
//                     Style = Strong;
//                     StyleExpr = true;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         //MotifDepense.SETRANGE(Sens,'E') ;
//                         if page.RunModal(page::"Code Opération Caisse", OperationCaisse) = Action::LookupOK then begin
//                             rec."Code Opération" := OperationCaisse.Code;
//                             rec.Validate("Type de compte", rec."type de compte"::"Frais annexe");
//                             rec.Validate("Code compte", 'CC-DIVERS');
//                             rec.Libellé := OperationCaisse.Description;
//                             rec.Caisse := true;
//                             if OperationCaisse.Sens = 'E' then rec."Type Caisse" := 2;    // 2: Depense Caisse E
//                             if OperationCaisse.Sens = 'C' then rec."Type Caisse" := 3;    // 2: Depense Caisse C
//                             rec.Avance := OperationCaisse.Avance;
//                             rec.Prêt := OperationCaisse.Prêt;
//                             rec.Paie := OperationCaisse.Paie;
//                             rec.Brouillard := OperationCaisse.Brouillard;
//                             rec.Journal := OperationCaisse.Journal;
//                             rec.Provisoire := OperationCaisse.Provisoire;

//                         end;
//                     end;

//                     trigger OnValidate()
//                     begin
//                         rec."Type Origine" := 1;
//                         CodeOp233rationOnAfterValidate;
//                     end;
//                 }
//                 field("Type Caisse"; rec."Type Caisse")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Libellé  "; rec.Libellé)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Libellé';

//                     trigger OnAssistEdit()
//                     begin
//                         //>> HJ 30-11-2017
//                         Get11X12X;
//                         //>> HJ 30-11-2017
//                     end;
//                 }
//                 field(Motif; rec.Motif)
//                 {
//                     Caption = 'Motif';
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Affaire; rec.Affaire)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                     Caption = 'Chantier';
//                 }
//                 field("Type Origine"; rec."Type Origine")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Type Benificiaire';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Benificiaire; rec.Benificiaire)
//                 {
//                     Caption = 'Benificiaire';
//                     ApplicationArea = all;
//                 }
//                 field("Nom Benificiaire"; rec."Nom Benificiaire")
//                 {
//                     Caption = 'Nom Benificiaire';
//                     ApplicationArea = all;
//                 }
//                 field("Date Debut"; rec."Date Debut")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date Affectation';

//                     trigger OnValidate()
//                     begin
//                         if rec.Avance then CreerAvancePret(true);
//                         if rec.Prêt then CreerAvancePret(false);
//                     end;
//                 }
//                 field(Tranche; rec.Tranche)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Tranche';
//                     DecimalPlaces = 0 : 0;
//                     Style = Strong;
//                     StyleExpr = true;


//                     trigger OnAssistEdit()
//                     var
//                         RecPaymentLineAvance: Record "Payment Line";
//                         RecPaymentLineInsertAvance: Record "Payment Line";
//                         NumLignie: Integer;
//                         MontantAvance: Decimal;
//                         Compteur: Integer;
//                         NbTranche: Integer;
//                         CodeSalarie: Code[20];
//                         DateDebut: Date;
//                     begin

//                         if rec."Code Opération" = 'P2' then begin
//                             // RB SORO 03/01/2017 CALCUL AVANCE SALARIE
//                             RecPaymentLineAvance.Reset;
//                             RecPaymentLineInsertAvance.Reset;
//                             NumLignie := 0;
//                             MontantAvance := 0;

//                             RecPaymentLineAvance.Get(rec."No.", rec."Line No.");

//                             //IF RecPaymentLineAvance.COUNT<> 1 THEN
//                             //   ERROR(Text023);
//                             RecPaymentLineAvance.TestField(Caisse, true);
//                             RecPaymentLineAvance.TestField("Code Opération", 'P2');
//                             RecPaymentLineAvance.TestField("Montant Avance/Pret");
//                             RecPaymentLineAvance.TestField("Type Origine", RecPaymentLineAvance."type origine"::Salarié);
//                             RecPaymentLineAvance.TestField(Benificiaire);
//                             RecPaymentLineAvance.TestField(Tranche);
//                             RecPaymentLineAvance.TestField("Date Debut");
//                             if RecPaymentLineAvance.Tranche >= 1 then begin
//                                 NumLignie := RecPaymentLineAvance."Line No.";
//                                 NbTranche := RecPaymentLineAvance.Tranche;
//                                 MontantAvance := RecPaymentLineAvance."Montant Avance/Pret";
//                                 CodeSalarie := RecPaymentLineAvance.Benificiaire;
//                                 DateDebut := RecPaymentLineAvance."Date Debut";
//                                 RecPaymentLineInsertAvance.SetRange("No.", rec."No.");
//                                 RecPaymentLineInsertAvance.SetRange("Line No.", RecPaymentLineAvance."Line No.");
//                                 if RecPaymentLineAvance.FindFirst then begin
//                                     for Compteur := 1 to NbTranche do begin

//                                         RecPaymentLineInsertAvance.Validate("No.", rec."No.");
//                                         RecPaymentLineInsertAvance.Validate("Line No.", NumLignie);
//                                         RecPaymentLineInsertAvance.Validate("Due Date", rec."Due Date");
//                                         RecPaymentLineInsertAvance.Caisse := true;
//                                         RecPaymentLineInsertAvance.Validate("Code Opération", 'P2');
//                                         RecPaymentLineInsertAvance.Validate("Type Origine", RecPaymentLineInsertAvance."type origine"::Salarié);
//                                         RecPaymentLineInsertAvance.Validate(Benificiaire, CodeSalarie);
//                                         RecPaymentLineInsertAvance."Montant Avance/Pret" := MontantAvance;
//                                         // RecPaymentLineInsertAvance.Tranche:=NbTranche;
//                                         RecPaymentLineInsertAvance.Tranche := 1;
//                                         RecPaymentLineInsertAvance."Date Debut" := DateDebut;
//                                         //RecPaymentLineInsertAvance.VALIDATE("Credit Amount",MontantAvance / NbTranche);
//                                         RecPaymentLineInsertAvance."Credit Amount" := MontantAvance / NbTranche;
//                                         RecPaymentLineInsertAvance.Validate(Amount, -(MontantAvance / NbTranche));
//                                         RecPaymentLineInsertAvance."Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXTAV', Today, true);

//                                         if not RecPaymentLineInsertAvance.Modify then RecPaymentLineInsertAvance.Insert;
//                                         NumLignie += 100;
//                                         DateDebut := CalcDate('+1M', DateDebut);

//                                     end;
//                                 end;

//                             end;
//                             CurrPage.Update;
//                         end
//                         else
//                             if rec."Code Opération" = 'P3' then begin
//                                 RecPaymentLineAvance.Reset;
//                                 RecPaymentLineInsertAvance.Reset;
//                                 NumLignie := 0;
//                                 MontantAvance := 0;

//                                 RecPaymentLineAvance.Get(rec."No.", rec."Line No.");

//                                 //IF RecPaymentLineAvance.COUNT<> 1 THEN
//                                 //   ERROR(Text023);
//                                 RecPaymentLineAvance.TestField(Caisse, true);
//                                 RecPaymentLineAvance.TestField("Code Opération", 'P3');
//                                 RecPaymentLineAvance.TestField("Montant Avance/Pret");
//                                 RecPaymentLineAvance.TestField("Type Origine", RecPaymentLineAvance."type origine"::Salarié);
//                                 RecPaymentLineAvance.TestField(Benificiaire);
//                                 RecPaymentLineAvance.TestField(Tranche);
//                                 RecPaymentLineAvance.TestField("Date Debut");
//                                 if RecPaymentLineAvance.Tranche > 1 then begin
//                                     NumLignie := RecPaymentLineAvance."Line No.";
//                                     NbTranche := RecPaymentLineAvance.Tranche;
//                                     MontantAvance := RecPaymentLineAvance."Montant Avance/Pret";
//                                     CodeSalarie := RecPaymentLineAvance.Benificiaire;
//                                     DateDebut := RecPaymentLineAvance."Date Debut";
//                                     RecPaymentLineInsertAvance.SetRange("No.", rec."No.");
//                                     RecPaymentLineInsertAvance.SetRange("Line No.", RecPaymentLineAvance."Line No.");
//                                     if RecPaymentLineAvance.FindFirst then begin
//                                         for Compteur := 1 to NbTranche do begin

//                                             RecPaymentLineInsertAvance.Validate("No.", rec."No.");
//                                             RecPaymentLineInsertAvance.Validate("Line No.", NumLignie);
//                                             RecPaymentLineInsertAvance.Validate("Due Date", rec."Due Date");
//                                             RecPaymentLineInsertAvance.Caisse := true;
//                                             RecPaymentLineInsertAvance.Validate("Code Opération", 'P3');
//                                             RecPaymentLineInsertAvance.Validate("Type Origine", RecPaymentLineInsertAvance."type origine"::Salarié);
//                                             RecPaymentLineInsertAvance.Validate(Benificiaire, CodeSalarie);
//                                             RecPaymentLineInsertAvance."Montant Avance/Pret" := MontantAvance;
//                                             RecPaymentLineInsertAvance.Tranche := NbTranche;
//                                             RecPaymentLineInsertAvance."Date Debut" := DateDebut;
//                                             RecPaymentLineInsertAvance.Validate("Credit Amount",
//                                                     MontantAvance / NbTranche);

//                                             if not RecPaymentLineInsertAvance.Modify then RecPaymentLineInsertAvance.Insert;
//                                             NumLignie += 100;
//                                             DateDebut := CalcDate('+1M', DateDebut);

//                                         end;
//                                     end;
//                                 end;
//                                 CurrPage.Update;

//                             end;
//                         // RB SORO 03/01/2017
//                     end;
//                 }
//                 field(NumAvance; NumAvance)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° Advance';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Credit Amount"; rec."Credit Amount")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Depenses';
//                     Style = Unfavorable;

//                     StyleExpr = true;
//                     trigger OnValidate()
//                     begin
//                         CurrPage.Update();
//                     end;
//                 }
//                 field("Debit Amount"; rec."Debit Amount")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Recettes';
//                     DecimalPlaces = 3 : 3;
//                     Style = Favorable;
//                     StyleExpr = true;
//                     trigger OnValidate()
//                     begin
//                         CurrPage.Update();
//                     end;
//                 }
//                 field(Receptionneur; rec.Receptionneur)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Receptionneur';
//                 }
//                 field("Nom Receptionneur"; rec."Nom Receptionneur")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Nom Receptionneur';
//                 }
//                 field("Montant Avance/Pret"; rec."Montant Avance/Pret")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     Caption = 'Montant Avance/Pret';
//                     StyleExpr = true;
//                 }
//                 field("Designation Affectation"; rec."Designation Affectation")
//                 {
//                     Caption = 'Designation Affectation';
//                     ApplicationArea = all;
//                     // Editable = false;
//                 }
//                 field("N° Paie"; rec."N° Paie")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Caption = 'N° Paie';
//                 }
//                 field("Description Paie"; rec."Description Paie")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Caption = 'Description Paie';
//                 }
//                 field(MoisPaie; rec.MoisPaie)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'MoisPaie';
//                 }
//                 field("Numero Seq Retour"; rec."Numero Seq Retour")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                     Caption = 'Numero Seq Retour';
//                 }
//                 field(Avance; rec.Avance)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Avance';
//                     Editable = false;
//                     // Visible = false;
//                 }
//                 field(Provisoire; rec.Provisoire)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Provisoire';
//                     Editable = false;
//                     // Visible = false;
//                 }
//                 field(Paie; rec.Paie)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'External Document No.';
//                 }
//                 field("Drawee Reference Soroubat"; Rec."Drawee Reference Soroubat")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Validé Caisse"; rec."Validé Caisse")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Validé Caisse';
//                     Editable = false;
//                 }
//                 field("N° Affaire"; rec."N° Affaire")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° Affaire';
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {





//             action("Valider les Avances")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Validate Advances';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Visible = false;

//                 trigger OnAction()
//                 var
//                     txt001: label 'The tranche must not exceed 1';
//                     txt002: label 'dvance validation completed successfully.';
//                 begin
//                     if not Confirm(Text010, false) then exit;
//                     Rec.SetRange("Code Opération", 'P2');
//                     if Rec.FindFirst then
//                         repeat
//                             if Rec.Tranche > 1 then Error(txt001);

//                             CreerAvancePret(true);
//                             Rec."Avance Valider" := true;
//                             Rec.Modify;
//                         until Rec.Next = 0;
//                     Message(txt002);
//                     Rec.Reset;
//                     Rec.SetRange("No.", Rec."No.");
//                 end;
//             }

//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         ActivateControls;
//         PaymentLine.SetRange("Copied To No.", rec."No.");
//         PaymentLine.SetRange("Copied To Line", rec."Line No.");
//         if PaymentLine.FindFirst then begin
//             PaymentLine.CalcFields("Folio N°");
//             rec."Folio BOR" := PaymentLine."Folio N°";
//         end;

//         NumAvance := '';
//         if rec."Code Opération" = 'P2' then begin
//             RecAvance.Reset;
//             RecAvance.SetRange("N° Bon Caisse", rec."Numero Seq");
//             if RecAvance.FindFirst then NumAvance := RecAvance."No.";
//         end;
//         //GL2024  CodeOp233rationOnFormat;
//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         if rec.Avance or rec.Prêt then begin
//             LoanAdvance2.SetRange("N° Bon Caisse", rec."Numero Seq");
//             if (LoanAdvance2.FindFirst) and (rec."Numero Seq" <> '') then Error(Text006);
//         end;
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
//         PaymentLine: Record "Payment Line";
//         NoSeriesManagment: Codeunit NoSeriesManagement;
//         OperationCaisse: Record "Code Opération Caisse";
//         Text003: label 'Return Amount Exceeds Principal Amount.';
//         Text004: label 'Please Specify All Fields for This Type of Operation.';
//         Text005: label 'Fields Filled Only for Advance and Loan.';
//         LoanAdvance: Record "Loan & Advance";
//         LoanAdvance2: Record "Loan & Advance";
//         Text006: label 'You must first delete the Payroll Advance document before deleting this line.';
//         Text007: label 'Employee %1 has more than one payroll in the same month.';
//         NbrePaie: Integer;
//         Text008: label 'Employee %1 has more than one advance in the same month';
//         HumanResSetup: Record "Human Resources Setup";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         RecSalarier: Record Salarier;
//         RecCustomer: Record Customer;
//         RecVendor: Record Vendor;
//         Text023: label 'You must select a line of type Salary Advance !!!';
//         LoanAdvanceHeader: Record "Loan & Advance Header";
//         DtDebut: Date;
//         ValidationPayementBR: Page "Integrer Payement BR à la cais";
//         ValidationPayementSTC: Page "Integrer Payement STC à la cai";
//         Text009: label 'Integration Completed';
//         RecAvance: Record "Loan & Advance Header";
//         NumAvance: Code[20];
//         Text010: label 'Do you want to validate the advances ?';


//     procedure Application()
//     begin
//         Codeunit.Run(Codeunit::"Payment-Apply", Rec);
//     end;


//     procedure ShowDimensions1()
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
//             if ((Header."Status No." = 0) and (rec."Copied To No." = '')) or (Header.Reouvrir) then
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
//                     //GL2024 License  PostingStatement.IncrementNoText(No, 1);
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





//     procedure REFCHEQUE(): Code[20]
//     begin
//         //>>>MBK:05/02/2010: Référence chèque
//         exit(rec."Référence chèque");
//     end;


//     procedure AfficherAvancePret()
//     begin
//         LoanAdvance2.SetRange("N° Bon Caisse", rec."Numero Seq");
//         if rec.Avance then page.RunModal(page::"Advances a la Caisse", LoanAdvance2);
//         if rec.Prêt then page.RunModal(page::"Loans Par Caisse", LoanAdvance2);
//     end;


//     procedure GetNumSeq() NumSeq: Code[20]
//     begin
//         exit(rec."Numero Seq");
//     end;


//     procedure CreerAvancePret(ParaAvance: Boolean)
//     var
//         LoanAdvance: Record "Loan & Advance";
//         TextL001: label 'Document  Créer N° %1';
//         LoanAdvance2: Record "Loan & Advance";
//         MgmtLoansAdvances: Codeunit "Mgmt. of Loans and Advances";
//     begin
//         /*// Arret Du Code Provisoire
//         //EXIT;
//         IF "Credit Amount"=0 THEN EXIT;
//         LoanAdvanceHeader.SETRANGE("N° Bon Caisse","Numero Seq");
//         IF LoanAdvanceHeader.FINDFIRST THEN EXIT;
//         IF ParaAvance THEN
//           BEGIN
//             LoanAdvance2.SETRANGE("N° Bon Caisse","Numero Seq");
//             IF NOT LoanAdvance2.FINDFIRST THEN BEGIN
//             LoanAdvance.INIT;
//             LoanAdvance.VALIDATE(Employee,Benificiaire);
//             LoanAdvance.Type:=LoanAdvance.Type::Advance;
//             LoanAdvance."Document type":='AVANCE';
//             DtDebut:=DMY2DATE(1,DATE2DMY("Date Debut",2),DATE2DMY("Date Debut",3));
//             LoanAdvance.VALIDATE("Date d'effet",DtDebut);
//             LoanAdvance."Date fin Prêt":=CALCDATE('1M',DtDebut);
//             LoanAdvance.VALIDATE(Amount,"Credit Amount");
//             IF Tranche=0 THEN Tranche:=1;
//             LoanAdvance.VALIDATE("Repayment slices" ,1);
//             LoanAdvance."N° Bon Caisse":="Numero Seq" ;
//             LoanAdvance."Generer Par Caisse":=TRUE;
//             LoanAdvance.INSERT(TRUE);
//             //MESSAGE(TextL001,LoanAdvance."No.");
//             END
//             ELSE
//             BEGIN
//               IF LoanAdvance.GET( LoanAdvance2."No.") THEN
//                 BEGIN
//                    DtDebut:=DMY2DATE(1,DATE2DMY("Date Debut",2),DATE2DMY("Date Debut",3));
//                    LoanAdvance.VALIDATE("Date d'effet",DtDebut);
//                    LoanAdvance."Date fin Prêt":=CALCDATE('1M',DtDebut);
//                    IF Tranche=0 THEN Tranche:=1;
//                    LoanAdvance.VALIDATE("Repayment slices" ,1);
//                    LoanAdvance.VALIDATE(Amount,"Credit Amount");
//                    LoanAdvance."Generer Par Caisse":=TRUE;
//                    LoanAdvance.MODIFY;
//                 END;
//             END;
//           END;
//         IF NOT ParaAvance THEN
//           BEGIN
//             LoanAdvance2.RESET;
//             LoanAdvance2.SETRANGE("N° Bon Caisse","Numero Seq");
//             IF NOT LoanAdvance2.FINDFIRST THEN BEGIN
//             LoanAdvance.INIT;
//             LoanAdvance.VALIDATE(Employee,Benificiaire);
//             LoanAdvance.Type:=LoanAdvance.Type::Loan;
//             LoanAdvance."Document type":='PRET';
//             DtDebut:=DMY2DATE(1,DATE2DMY("Date Debut",2),DATE2DMY("Date Debut",3));
//             LoanAdvance.VALIDATE("Date d'effet",DtDebut);
//             LoanAdvance."Date fin Prêt":=CALCDATE('1M',DtDebut);
//             LoanAdvance.VALIDATE(Amount,"Credit Amount");
//             IF Tranche=0 THEN Tranche:=1;
//             LoanAdvance.VALIDATE("Repayment slices" ,1);
//             LoanAdvance."N° Bon Caisse":="Numero Seq" ;
//             LoanAdvance."Generer Par Caisse":=TRUE;
//             LoanAdvance.INSERT(TRUE);
//            // MESSAGE(TextL001,LoanAdvance."No.");
//             END
//             ELSE
//             BEGIN
//               IF LoanAdvance.GET( LoanAdvance2."No.") THEN
//                 BEGIN
//                    DtDebut:=DMY2DATE(1,DATE2DMY("Date Debut",2),DATE2DMY("Date Debut",3));
//                    LoanAdvance.VALIDATE("Date d'effet",DtDebut);
//                    LoanAdvance."Date fin Prêt":=CALCDATE('1M',DtDebut);
//                    LoanAdvance.VALIDATE(Amount,"Credit Amount");
//                    IF Tranche=0 THEN Tranche:=1;
//                    LoanAdvance.VALIDATE("Repayment slices" ,1);
//                    LoanAdvance."Generer Par Caisse":=TRUE;
//                    LoanAdvance.MODIFY;
//                 END;
//             END;
//           END;
//          MgmtLoansAdvances.EnregDocument (LoanAdvance,"Date Debut"); */

//     end;


//     procedure Get11X12X()
//     begin
//         if rec."Code Opération" = '11X' then begin
//             ValidationPayementBR.GetParametre(rec."No.", rec."Line No.");
//             ValidationPayementBR.Run;

//         end
//         else
//             if rec."Code Opération" = '12X' then begin
//                 ValidationPayementSTC.GetParametre(rec."No.", rec."Line No.");
//                 ValidationPayementSTC.Run;
//             end;
//     end;

//     local procedure CodeOp233rationOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;

//     local procedure CodeOp233rationOnFormat()
//     begin
//         if rec."Type Caisse" = 2 then;
//         if rec."Type Caisse" = 3 then;
//     end;
// }

