// Page 50187 "Validation Avance"
// {
//     // //>>>MBK:05/02/2010: Référence chèque

//     AutoSplitKey = true;
//     Caption = 'Validation Avance';
//     DelayedInsert = true;

//     PageType = List;
//     SourceTable = "Payment Line";
//     SourceTableView = where("Copied To No." = filter(' '), "Code Opération" = const('P2'), "Avance Valider" = const(false), "Due Date" = filter(>= '01/01/23'));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Numero Seq"; REC."Numero Seq")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                     Visible = true;
//                 }
//                 field("Due Date"; REC."Due Date")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date';
//                     Editable = false;
//                 }
//                 field("Libellé  "; REC.Libellé)
//                 {
//                     ApplicationArea = all;
//                     Description = '<AGA>';
//                     Editable = false;
//                 }
//                 field("Type Origine"; REC."Type Origine")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Type Benificiaire';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Benificiaire; REC.Benificiaire)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Nom Benificiaire"; REC."Nom Benificiaire")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date Debut"; REC."Date Debut")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date Affectation';
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         if REC.Avance then CreerAvancePret(true);
//                         if REC.Prêt then CreerAvancePret(false);
//                     end;
//                 }
//                 field(Tranche; REC.Tranche)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Credit Amount"; REC."Credit Amount")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Depenses';
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;

//                     trigger OnValidate()
//                     begin
//                         if REC.Avance then CreerAvancePret(true);
//                         if REC.Prêt then CreerAvancePret(false);
//                         /*IF  "Type Caisse"=3 THEN
//                         BEGIN
//                         IF "Numero Seq"='' THEN "Numero Seq":=NoSeriesManagment.GetNextNo('SEQEXT',TODAY,TRUE);
//                         END;

//                         IF  "Type Caisse"=2 THEN
//                         BEGIN
//                         IF "Numero Seq"='' THEN "Numero Seq":=NoSeriesManagment.GetNextNo('SEQEXTCE',TODAY,TRUE);
//                         END;*/

//                         /*IF "Code Opération"='P1' THEN
//                         BEGIN
//                         PaymentLine.RESET;
//                         PaymentLine.SETRANGE(PaymentLine."Mois Echeance","Mois Echeance");
//                         PaymentLine.SETRANGE(PaymentLine."Code Opération",'P1');
//                         PaymentLine.SETRANGE(PaymentLine.Benificiaire,Benificiaire);
//                         IF (PaymentLine.FINDFIRST) AND (PaymentLine."Numero Seq"<>'') THEN ERROR(Text007,"Nom Benificiaire");
//                         END;*/

//                         //(PaymentLine.FIND('-'))
//                         /*IF "Code Opération"='P2' THEN
//                         BEGIN

//                         PaymentLine.RESET;
//                         PaymentLine.SETRANGE(PaymentLine."Mois Echeance","Mois Echeance");
//                         PaymentLine.SETRANGE(PaymentLine."Code Opération",'P2');
//                         PaymentLine.SETRANGE(PaymentLine.Benificiaire,Benificiaire);

//                         IF (PaymentLine.FINDFIRST) AND (PaymentLine."Numero Seq"<>'') THEN ERROR(Text008,"Nom Benificiaire");
//                         END;*/

//                     end;
//                 }
//                 field("Avance Valider"; REC."Avance Valider")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         AvanceValiderOnPush;
//                         AvanceValiderOnAfterValidate;
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnDeleteRecord(): Boolean
//     begin
//         if REC.Avance or REC.Prêt then begin
//             LoanAdvance2.SetRange("N° Bon Caisse", REC."Numero Seq");
//             if (LoanAdvance2.FindFirst) and (REC."Numero Seq" <> '') then Error(Text006);
//         end;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         REC.SetUpNewLine(xRec, BelowxRec);
//     end;

//     trigger OnOpenPage()
//     begin
//         CurrPage.Editable := true;
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
//         Text003: label 'Montant Retour Supérieure au Montant Principal';
//         Text004: label 'Veuillez Spécifier Tous Les Champs Pour Ce Type d''Opération';
//         Text005: label 'Champs Rempli Seulement Pour Avance Et Prêt';
//         LoanAdvance: Record "Loan & Advance";
//         LoanAdvance2: Record "Loan & Advance";
//         Text006: label 'Vous Devez Supprimer d''abord le Docment Avance de la Paie Avant de Supprimer Cette Ligne';
//         Text007: label 'L''employe %1 Possede Plus qu''un Paie dans le meme Mois';
//         NbrePaie: Integer;
//         Text008: label 'L''employe %1 Possede Plus qu''un Avance dans le meme Mois';
//         HumanResSetup: Record "Human Resources Setup";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         RecSalarier: Record Salarier;
//         RecCustomer: Record Customer;
//         RecVendor: Record Vendor;
//         Text023: label 'Vous devez selectionner une lignie de type Avance sur Salaire !!!';
//         LoanAdvanceHeader: Record "Loan & Advance Header";
//         DtDebut: Date;
//         Text009: label 'Voulez-vous Valider Cette Avance ?';


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
//     end;


//     procedure Modify()
//     var
//         PaymentLine: Record "Payment Line";
//         PaymentModification: Page "Payment Line Modification";
//     begin
//         if REC."Line No." = 0 then
//             Message(Text001)
//         else
//             if not REC.Posted then begin
//                 PaymentLine.Copy(Rec);
//                 PaymentLine.SetRange("No.", REC."No.");
//                 PaymentLine.SetRange("Line No.", REC."Line No.");
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
//         GenJnlLine."Account Type" := REC."Account Type";
//         GenJnlLine."Account No." := REC."Account No.";
//         Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", GenJnlLine);
//     end;


//     procedure ShowEntries()
//     var
//         GenJnlLine: Record "Gen. Journal Line";
//     begin
//         GenJnlLine."Account Type" := REC."Account Type";
//         GenJnlLine."Account No." := REC."Account No.";
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
//             LineCopy.SetRange("No.", REC."No.");
//             LineCopy.ModifyAll(Marked, true);
//         end else begin
//             REC.ClearMarks;
//             LineCopy.SetRange("No.", REC."No.");
//             LineCopy.ModifyAll(Marked, false);
//         end;
//         Commit;
//     end;


//     procedure ActivateControls()
//     begin
//     end;


//     procedure CalculerRetenu()
//     begin
//         REC.CalcRetenu;
//     end;


//     procedure Actualiser()
//     begin
//         REC.CalcAmount;
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
//         if REC."Account No." <> '' then
//             case REC."Account Type" of
//                 REC."account type"::Vendor:
//                     begin
//                         if Frs.Get(REC."Account No.") then
//                             Lib := Frs.Name;
//                     end;
//                 REC."account type"::"G/L Account":
//                     begin
//                         if Cmpt.Get(REC."Account No.") then
//                             Lib := Cmpt.Name;
//                     end;

//                 REC."account type"::Customer:
//                     begin
//                         if cust.Get(REC."Account No.") then
//                             Lib := cust.Name;
//                     end;
//                 /*"Account Type"::Salary : BEGIN
//                    IF Sal.GET("Account No.") THEN
//                       Lib:=Sal."Last Name"+' '+Sal."First Name";
//                    END;*/
//                 REC."account type"::"Bank Account":
//                     begin
//                         if banq.Get(REC."Account No.") then
//                             Lib := banq.Name;
//                     end;
//             end;

//     end;


//     procedure fractLine()
//     begin
//         REC.FractionnerLine;
//     end;


//     procedure "---MBK---"()
//     begin
//     end;


//     procedure REFCHEQUE(): Code[20]
//     begin
//         //>>>MBK:05/02/2010: Référence chèque
//         exit(REC."Référence chèque");
//     end;


//     procedure AfficherAvancePret()
//     begin
//         LoanAdvance2.SetRange("N° Bon Caisse", REC."Numero Seq");
//         if REC.Avance then PAGE.RunModal(PAGE::"Advances a la Caisse", LoanAdvance2);
//         if REC.Prêt then PAGE.RunModal(PAGE::"Loans Par Caisse", LoanAdvance2);
//     end;


//     procedure GetNumSeq() NumSeq: Code[20]
//     begin
//         exit(REC."Numero Seq");
//     end;


//     procedure CreerAvancePret(ParaAvance: Boolean)
//     var
//         LoanAdvance: Record "Loan & Advance";
//         TextL001: label 'Document  Créer N° %1';
//         LoanAdvance2: Record "Loan & Advance";
//         MgmtLoansAdvances: Codeunit "Mgmt. of Loans and Advances";
//     begin
//         Clear(LoanAdvanceHeader);
//         Clear(LoanAdvance2);
//         Clear(LoanAdvance);
//         Clear(MgmtLoansAdvances);
//         if REC."Credit Amount" = 0 then exit;
//         LoanAdvanceHeader.SetRange("N° Bon Caisse", REC."Numero Seq");
//         if LoanAdvanceHeader.FindFirst then exit;
//         if ParaAvance then begin
//             LoanAdvance2.SetRange("N° Bon Caisse", REC."Numero Seq");
//             if not LoanAdvance2.FindFirst then begin
//                 LoanAdvance.Init;
//                 LoanAdvance.Validate(Employee, REC.Benificiaire);
//                 LoanAdvance.Type := LoanAdvance.Type::Advance;
//                 LoanAdvance."Document type" := 'AVANCE';
//                 DtDebut := Dmy2date(1, Date2dmy(REC."Date Debut", 2), Date2dmy(REC."Date Debut", 3));
//                 LoanAdvance.Validate("Date d'effet", DtDebut);
//                 LoanAdvance."Date fin Prêt" := CalcDate('1M', DtDebut);
//                 LoanAdvance.Validate(Amount, REC."Credit Amount");
//                 if REC.Tranche = 0 then REC.Tranche := 1;
//                 LoanAdvance.Validate("Repayment slices", REC.Tranche);
//                 LoanAdvance."N° Bon Caisse" := REC."Numero Seq";
//                 LoanAdvance."Generer Par Caisse" := true;
//                 LoanAdvance.Insert(true);
//                 Message(TextL001, LoanAdvance."No.");
//             end
//             else begin
//                 if LoanAdvance.Get(LoanAdvance2."No.") then begin
//                     DtDebut := Dmy2date(1, Date2dmy(REC."Date Debut", 2), Date2dmy(REC."Date Debut", 3));
//                     LoanAdvance.Validate("Date d'effet", DtDebut);
//                     LoanAdvance."Date fin Prêt" := CalcDate('1M', DtDebut);
//                     if REC.Tranche = 0 then REC.Tranche := 1;
//                     LoanAdvance.Validate("Repayment slices", REC.Tranche);
//                     LoanAdvance.Validate(Amount, REC."Credit Amount");
//                     LoanAdvance."Generer Par Caisse" := true;
//                     LoanAdvance.Modify;
//                 end;
//             end;
//         end;
//         if not ParaAvance then begin
//             LoanAdvance2.Reset;
//             LoanAdvance2.SetRange("N° Bon Caisse", REC."Numero Seq");
//             if not LoanAdvance2.FindFirst then begin
//                 LoanAdvance.Init;
//                 LoanAdvance.Validate(Employee, REC.Benificiaire);
//                 LoanAdvance.Type := LoanAdvance.Type::Loan;
//                 LoanAdvance."Document type" := 'PRET';
//                 DtDebut := Dmy2date(1, Date2dmy(REC."Date Debut", 2), Date2dmy(REC."Date Debut", 3));
//                 LoanAdvance.Validate("Date d'effet", DtDebut);
//                 LoanAdvance."Date fin Prêt" := CalcDate('1M', DtDebut);
//                 LoanAdvance.Validate(Amount, REC."Credit Amount");
//                 if REC.Tranche = 0 then REC.Tranche := 1;
//                 LoanAdvance.Validate("Repayment slices", REC.Tranche);
//                 LoanAdvance."N° Bon Caisse" := REC."Numero Seq";
//                 LoanAdvance."Generer Par Caisse" := true;
//                 LoanAdvance.Insert(true);
//                 Message(TextL001, LoanAdvance."No.");
//             end
//             else begin
//                 if LoanAdvance.Get(LoanAdvance2."No.") then begin
//                     DtDebut := Dmy2date(1, Date2dmy(REC."Date Debut", 2), Date2dmy(REC."Date Debut", 3));
//                     LoanAdvance.Validate("Date d'effet", DtDebut);
//                     LoanAdvance."Date fin Prêt" := CalcDate('1M', DtDebut);
//                     LoanAdvance.Validate(Amount, REC."Credit Amount");
//                     if REC.Tranche = 0 then REC.Tranche := 1;
//                     LoanAdvance.Validate("Repayment slices", REC.Tranche);
//                     LoanAdvance."Generer Par Caisse" := true;
//                     LoanAdvance.Modify;
//                 end;
//             end;
//         end;
//         MgmtLoansAdvances.EnregDocument(LoanAdvance, REC."Date Debut");
//     end;

//     local procedure AvanceValiderOnAfterValidate()
//     begin
//         if not Confirm(Text009) then exit;
//         if REC.Avance then CreerAvancePret(true);
//         Clear(LoanAdvanceHeader);
//         LoanAdvanceHeader.SetRange("N° Bon Caisse", REC."Numero Seq");
//         if not LoanAdvanceHeader.FindFirst then
//             REC."Avance Valider" := false;
//         CurrPage.Update(true);
//     end;

//     local procedure AvanceValiderOnPush()
//     begin
//         if REC."Avance Valider" then exit;
//     end;
// }

