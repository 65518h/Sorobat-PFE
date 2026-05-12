page 50051 "Ligne Provisoire"
{
    // //>>>MBK:05/02/2010: Référence chèque

    AutoSplitKey = true;
    Caption = 'Ligne Provisoire';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = 10866;


    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                field("Numero Seq"; rec."Numero Seq")
                {
                    Editable = false;
                }
                field("Due Date"; rec."Due Date")
                {
                    Caption = 'Date';
                    Editable = IsEditable;


                    trigger OnValidate()
                    begin
                        IF rec."Due Date" > TODAY THEN ERROR(Text003);
                    end;
                }
                field("External Document No."; rec."External Document No.")
                {

                    Caption = 'N° Piece De Paiement';
                    Editable = false;
                }
                field("Type de compte"; rec."Type de compte")
                {
                    Caption = 'Type de Compte';
                    Editable = IsEditable;

                    OptionCaption = 'Général,Client,Fournisseur,Banque Où Caisse,Immobilisation,Frais annexe,Salarier';
                }
                field("Code compte"; rec."Code compte")
                {
                    Caption = 'N° Compte';
                    Editable = IsEditable;

                }
                field("Motif Depense Ex"; rec."Motif Depense Ex")
                {
                    Editable = IsEditable;
                }
                field(Benificiaire; rec.Benificiaire)
                {
                    Editable = IsEditable;

                }
                field(Commentaires; rec.Commentaires)
                {
                    Editable = IsEditable;

                }
                field("Payment Class"; rec."Payment Class")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Status Name"; rec."Status Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Libellé  "; rec.Libellé)
                {
                    Editable = IsEditable;
                    Description = '<AGA>';

                }
                field("Debit Amount"; rec."Debit Amount")
                {
                    Editable = IsEditable;
                    Caption = 'Montant';
                    DecimalPlaces = 3 : 3;

                    Style = Unfavorable;
                    StyleExpr = TRUE;

                    trigger OnValidate()
                    begin
                        //PaymentLine.SETCURRENTKEY("Numero Seq");
                        //PaymentLine.SETFILTER("Numero Seq",'<>%1',0);
                        //IF PaymentLine.FINDLAST THEN IF "Numero Seq"=0 THEN "Numero Seq":=PaymentLine."Numero Seq"+1;
                        rec.TESTFIELD("Code compte");
                        IF rec."Numero Seq" = 0 THEN EVALUATE(rec."Numero Seq", NoSeriesManagment.GetNextNo('SEQEXT', TODAY, TRUE));
                        CurrPage.Update();
                    end;
                }
                field("Envoyé Vers"; rec."Envoyé Vers")
                {
                    //Editable = IsEditable;
                    Editable = true;


                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF GeneralLedgerSetup.GET THEN;
                        Header.SETfilter(Header."Payment Class", '%1|%2', GeneralLedgerSetup."Type Reg. Caisse Cpt", GeneralLedgerSetup."Type Reg. Caisse Ext");
                        Header.SetRange("Caisse Chantier", false);
                        Header.SetRange("Status No.", 0);
                        IF page.RUNMODAL(10870, Header) = ACTION::LookupOK THEN BEGIN
                            rec."Envoyé Vers" := Header."No.";
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        Envoy233VersOnAfterValidate;
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("&Payment Slip")
            {
                Caption = '&Payment Slip';
                Visible = false;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ApplicationArea = all;
                    RunpageLink = "No." = FIELD("No.");
                    RunObject = Page "Payment Slip";
                    ShortCutKey = 'Maj+F5';
                }
                action(Envoyer)
                {
                    Caption = 'Envoyer vers Cpt/Ext';

                    ShortCutKey = 'F7';
                    Image = SendConfirmation;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50092. Unsupported part was commented. Please check it.
                        /*CurrPage.Lines.FORM.*/
                        Envoye(TRUE);

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ActivateControls;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.SetUpNewLine(xRec, BelowxRec);
    end;

    local procedure Envoy233VersOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    procedure Envoye(ParaCPT: Boolean)
    var
        RecLPaymentHeaderDestination: Record "Payment Header";
    begin
        IF NOT CONFIRM(Text004, FALSE) THEN EXIT;
        IF GeneralLedgerSetup.GET THEN;
        CLEAR(PaymentLine);
        CLEAR(PaymentLine2);
        PaymentLine3.RESET;
        PaymentLine2.RESET;
        PaymentLine2.SETRANGE("No.", rec."No.");
        PaymentLine2.SETFILTER("Envoyé Vers", '<>%1', '');
        IF PaymentLine2.FINDFIRST THEN
            REPEAT
                PaymentLine.TRANSFERFIELDS(PaymentLine2);
                PaymentLine."No." := PaymentLine2."Envoyé Vers";
                RecLPaymentHeaderDestination.get(PaymentLine2."No.");
                PaymentLine3.SETRANGE("No.", PaymentLine2."Envoyé Vers");
                IF PaymentLine3.FINDLAST THEN;
                PaymentLine."Line No." := PaymentLine3."Line No." + 1;
                // IF ParaCPT THEN
                //     PaymentLine."Payment Class" := GeneralLedgerSetup."Type Reg. Caisse Cpt"
                // ELSE
                //     PaymentLine."Payment Class" := GeneralLedgerSetup."Type Reg. Caisse Ext";
                PaymentLine."Payment Class" := RecLPaymentHeaderDestination."Payment Class";
                PaymentLine."Envoyé Vers" := '';
                PaymentLine."N° Origine" := PaymentLine2."No.";
                PaymentLine."Ligne Origine" := PaymentLine2."Line No.";
                PaymentLine.INSERT;
                PaymentLine2.DELETE;
            UNTIL PaymentLine2.NEXT = 0;
        COMMIT;
    end;


    var
        GeneralLedgerSetup: Record 98;
        Text000: Label 'Assign No. ?';
        Header: Record 10865;
        Status: Record 10861;
        Text001: Label 'There is no line to modify';
        Text002: Label 'A posted line cannot be modified.';
        PaymentClass: Record 10860;
        PaymentLine: Record 10866;
        PaymentLine2: Record 10866;
        PaymentLine3: Record 10866;
        NoSeriesManagment: Codeunit 396;
        Text003: Label 'Date Ne Peut pas Ettre > Date Jour';
        Text004: Label 'Envoyer Lignes ?';
        IsEditable: Boolean;


    procedure Application()
    begin
        CODEUNIT.RUN(CODEUNIT::"Payment-Apply", Rec);
    end;


    procedure ShowDimensions()
    begin
        ShowDimensions;
    end;


    procedure DisableFields(DocumentNo: Code[20])
    begin
        IF Header.GET(DocumentNo) THEN BEGIN
            IF ((Header."Status No." = 0) AND (rec."Copied To No." = '')) OR (Header.Reouvrir) THEN
                IsEditable := true
            ELSE
                IsEditable := false;
        END
        else if DocumentNo = '' then begin
            IsEditable := true
        end;
        CurrPage.Update(false);
    end;


    procedure Modify()
    var
        PaymentLine: Record 10866;
        PaymentModification: page 10871;
    begin
        IF rec."Line No." = 0 THEN
            MESSAGE(Text001)
        ELSE IF NOT rec.Posted THEN BEGIN
            PaymentLine.COPY(Rec);
            PaymentLine.SETRANGE("No.", rec."No.");
            PaymentLine.SETRANGE("Line No.", rec."Line No.");
            PaymentModification.SETTABLEVIEW(PaymentLine);
            PaymentModification.RUNMODAL;
        END ELSE
            MESSAGE(Text002);
    end;


    procedure Delete()
    var
        PostingStatement: Codeunit 10860;
        StatementLine: Record 10866;
    begin
        StatementLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(StatementLine);
        //  PostingStatement.DeleteLigBorCopy(StatementLine);
    end;


    procedure SetDocumentID()
    var
        StatementLine: Record 10866;
        PostingStatement: Codeunit 10860;
        No: Code[20];
    begin
        IF CONFIRM(Text000) THEN BEGIN
            CurrPage.SETSELECTIONFILTER(StatementLine);
            StatementLine.MARKEDONLY(TRUE);
            IF NOT StatementLine.FIND('-') THEN
                StatementLine.MARKEDONLY(FALSE);
            IF StatementLine.FIND('-') THEN BEGIN
                No := StatementLine."Document No.";
                WHILE StatementLine.NEXT <> 0 DO BEGIN
                    // PostingStatement.IncrementNoText(No,1);
                    StatementLine."Document No." := No;
                    StatementLine.MODIFY;
                END;
            END;
        END;
    end;


    procedure ShowAccount()
    var
        GenJnlLine: Record 81;
    begin
        GenJnlLine."Account Type" := rec."Account Type";
        GenJnlLine."Account No." := rec."Account No.";
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Show Card", GenJnlLine);
    end;


    procedure ShowEntries()
    var
        GenJnlLine: Record 81;
    begin
        GenJnlLine."Account Type" := rec."Account Type";
        GenJnlLine."Account No." := rec."Account No.";
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Show Entries", GenJnlLine);
    end;


    procedure MarkLines(ToMark: Boolean)
    var
        LineCopy: Record 10866;
        PaymtManagt: Codeunit 10860;
        NumLines: Integer;
    begin
        IF ToMark THEN BEGIN
            CurrPage.SETSELECTIONFILTER(LineCopy);
            LineCopy.MARKEDONLY(TRUE);
            NumLines := LineCopy.COUNT;
            IF NumLines > 0 THEN BEGIN
                LineCopy.FIND('-');
                REPEAT
                    IF LineCopy.MARK THEN BEGIN
                        LineCopy.Marked := TRUE;
                        LineCopy.MODIFY;
                    END;
                UNTIL LineCopy.NEXT = 0;
            END ELSE
                LineCopy.RESET;
            LineCopy.SETRANGE("No.", rec."No.");
            LineCopy.MODIFYALL(Marked, TRUE);
        END ELSE BEGIN
            rec.CLEARMARKS;
            LineCopy.SETRANGE("No.", rec."No.");
            LineCopy.MODIFYALL(Marked, FALSE);
        END;
        COMMIT;
    end;


    procedure ActivateControls()
    begin
    end;


    procedure CalculerRetenu()
    begin
        rec.CalcRetenu;
    end;


    procedure Actualiser()
    begin
        rec.CalcAmount;
    end;


    procedure Affichelib() Lib: Text[100]
    var
        banq: Record 270;
        Frs: Record 23;
        cust: Record 18;
        Cmpt: Record 15;
        Sal: Record 5200;
    begin
        Frs.RESET;
        cust.RESET;
        Cmpt.RESET;
        Sal.RESET;
        banq.RESET;
        Lib := '';
        IF rec."Account No." <> '' THEN
            CASE rec."Account Type" OF
                rec."Account Type"::Vendor:
                    BEGIN
                        IF Frs.GET(rec."Account No.") THEN
                            Lib := Frs.Name;
                    END;
                rec."Account Type"::"G/L Account":
                    BEGIN
                        IF Cmpt.GET(rec."Account No.") THEN
                            Lib := Cmpt.Name;
                    END;

                rec."Account Type"::Customer:
                    BEGIN
                        IF cust.GET(rec."Account No.") THEN
                            Lib := cust.Name;
                    END;
                /*"Account Type"::Salary : BEGIN
                   IF Sal.GET("Account No.") THEN
                      Lib:=Sal."Last Name"+' '+Sal."First Name";
                   END;*/
                rec."Account Type"::"Bank Account":
                    BEGIN
                        IF banq.GET(rec."Account No.") THEN
                            Lib := banq.Name;
                    END;
            END;

    end;


    procedure fractLine()
    begin
        rec.FractionnerLine;
    end;


    procedure "---MBK---"()
    begin
    end;


    procedure REFCHEQUE(): Code[20]
    begin
        //>>>MBK:05/02/2010: Référence chèque
        EXIT(rec."Référence chèque");
    end;
}


// page 50084 "Ligne Paiement"
// {
//     // //>>>MBK:05/02/2010: Référence chèque

//     AutoSplitKey = true;
//     Caption = 'Ligne Paiement';
//     DelayedInsert = true;
//     Editable = false;
//     PageType = List;
//     SourceTable = "Payment Line";
//     SourceTableView = SORTING("Copied To No.", "Copied To Line", Caisse) WHERE("Copied To No." = FILTER(''), Caisse = FILTER(false));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Line No.1"; rec."Line No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Type de compte"; rec."Type de compte")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Account Type';

//                     OptionCaption = 'General, Client, Vendor, Bank or Cash, Fixed Asset, Item charge, Employee';
//                     Visible = true;
//                 }
//                 // field("N° commande"; Rec."N° commande")
//                 // {
//                 //     ApplicationArea = all;
//                 //     Style = Favorable;
//                 // }
//                 field("Commande N°"; Rec."Commande N°")
//                 {
//                     ApplicationArea = all;
//                     Style = Favorable;
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }

//                 field("Drawee Reference Soroubat"; Rec."Drawee Reference Soroubat")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Aval; rec.Aval)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Copied To No."; rec."Copied To No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Account No."; rec."Account No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Libellé  "; rec.Libellé)
//                 {
//                     ApplicationArea = all;
//                     Description = 'AGA';
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Amount (LCY)1"; rec."Amount (LCY)")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Payment Class"; rec."Payment Class")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Status Name"; rec."Status Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Folio N°"; rec."Folio N°")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Montant Retenue"; rec."Montant Retenue")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date Echeance';
//                 }
//                 field("Date Loyer"; rec."Date Loyer")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Benificiaire; rec.Benificiaire)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         BenificiaireOnAfterValidate;
//                     end;
//                 }
//                 field("Nom Benificiaire"; rec."Nom Benificiaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Mois Concerné"; rec."Mois Concerné")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Mode Paiement"; rec."Mode Paiement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Debut"; rec."Date Debut")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         IF (NOT rec.Avance) AND (NOT rec.Prêt) THEN ERROR(Text005);
//                         rec."Date Fin" := rec."Date Debut";
//                     end;
//                 }
//                 field(Tranche; rec.Tranche)
//                 {
//                     ApplicationArea = all;
//                     //blankzero = true;
//                     Visible = true;

//                     trigger OnValidate()
//                     begin
//                         IF (NOT rec.Prêt) THEN ERROR(Text005);
//                     end;
//                 }
//                 field("Date Fin"; rec."Date Fin")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         IF (NOT rec.Avance) AND (NOT rec.Prêt) THEN ERROR(Text005);
//                     end;
//                 }
//                 field("Amount (LCY)"; rec."Amount (LCY)")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Avance; rec.Avance)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Prêt; rec.Prêt)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Code Opération"; rec."Code Opération")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Operation Code';
//                     Style = Strong;
//                     StyleExpr = TRUE;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         //MotifDepense.SETRANGE(Sens,'E') ;
//                         IF page.RUNMODAL(page::"Code Opération Caisse", OperationCaisse) = ACTION::LookupOK THEN BEGIN
//                             rec."Code Opération" := OperationCaisse.Code;
//                             rec.VALIDATE("Type de compte", rec."Type de compte"::"Frais annexe");
//                             rec.VALIDATE("Code compte", 'CC-DIVERS');
//                             rec.Libellé := OperationCaisse.Description;
//                             rec.Caisse := TRUE;
//                             IF OperationCaisse.Sens = 'E' THEN rec."Type Caisse" := 2;    // 2: Depense Caisse E
//                             IF OperationCaisse.Sens = 'C' THEN rec."Type Caisse" := 3;    // 2: Depense Caisse C
//                             rec.Avance := OperationCaisse.Avance;
//                             rec.Prêt := OperationCaisse.Prêt;
//                             rec.Paie := OperationCaisse.Paie;
//                             rec.Brouillard := OperationCaisse.Brouillard;
//                             rec.Journal := OperationCaisse.Journal;
//                             rec.Provisoire := OperationCaisse.Provisoire;

//                         END;
//                     end;

//                     trigger OnValidate()
//                     begin
//                         IF OperationCaisse.GET(rec."Code Opération") THEN;
//                         rec."Code Opération" := OperationCaisse.Code;
//                         rec.VALIDATE("Type de compte", rec."Type de compte"::"Frais annexe");
//                         rec.VALIDATE("Code compte", 'CC-DIVERS');
//                         rec.Libellé := OperationCaisse.Description;
//                         rec.Caisse := TRUE;
//                         IF OperationCaisse.Sens = 'E' THEN rec."Type Caisse" := 2;    // 2: Depense Caisse E
//                         IF OperationCaisse.Sens = 'C' THEN rec."Type Caisse" := 3;    // 2: Depense Caisse C
//                         rec.Avance := OperationCaisse.Avance;
//                         rec.Prêt := OperationCaisse.Prêt;
//                         rec.Paie := OperationCaisse.Paie;
//                         rec.Brouillard := OperationCaisse.Brouillard;
//                         rec.Journal := OperationCaisse.Journal;
//                         rec.Provisoire := OperationCaisse.Provisoire;
//                     end;
//                 }
//                 field("Montant Retour"; rec."Montant Retour")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         IF rec."Montant Retour" > rec."Credit Amount" THEN ERROR(Text003);
//                         rec.VALIDATE("Credit Amount", rec."Credit Amount" - rec."Montant Retour");
//                     end;
//                 }
//                 field(Paie; rec.Paie)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Brouillard; rec.Brouillard)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field(Journal; rec.Journal)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field(Provisoire; rec.Provisoire)
//                 {
//                 }
//                 field("Code compte"; rec."Code compte")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Account No.';
//                     Visible = false;
//                 }
//                 field("Folio N° RS"; rec."Folio N° RS")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Acc. No. Last Entry Debit"; rec."Acc. No. Last Entry Debit")
//                 {
//                     ApplicationArea = all;
//                     Visible = true;
//                 }
//                 field("Acc. No. Last Entry Credit"; rec."Acc. No. Last Entry Credit")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Line No."; rec."Line No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Folio BOR"; rec."Folio BOR")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Applies-to ID"; rec."Applies-to ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affectation; rec.Affectation)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Compte Bancaire"; rec."Compte Bancaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Utilisateur; rec.Utilisateur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group("&Payment Slip1")
//             {
//                 Caption = '&Payment Slip';
//                 actionref(Card1; Card) { }

//             }

//         }
//         area(navigation)
//         {
//             group("&Payment Slip")
//             {
//                 Caption = 'Bordereau &paiement';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Payment Slip";
//                     RunPageLink = "No." = FIELD("No.");
//                     ShortCutKey = 'Maj+F7';
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         ActivateControls;
//         PaymentLine.SETRANGE("Copied To No.", rec."No.");
//         PaymentLine.SETRANGE("Copied To Line", rec."Line No.");
//         IF PaymentLine.FINDFIRST THEN BEGIN
//             PaymentLine.CALCFIELDS("Folio N°");
//             rec."Folio BOR" := PaymentLine."Folio N°";
//         END;
//         CodeOp233rationOnFormat;
//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         IF rec.Avance OR rec.Prêt THEN BEGIN
//             LoanAdvance2.SETRANGE("N° Bon Caisse", rec."Numero Seq");
//             IF (LoanAdvance2.FINDFIRST) AND (rec."Numero Seq" <> '') THEN ERROR(Text006);
//         END;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         rec.SetUpNewLine(xRec, BelowxRec);
//     end;

//     var
//         Text000: Label 'Assign No. ?';
//         Header: Record "Payment Header";
//         Status: Record "Payment Status";
//         Text001: Label 'There is no line to modify';
//         Text002: Label 'A posted line cannot be modified.';
//         PaymentClass: Record "Payment Class";
//         PaymentLine: Record "Payment Line";
//         NoSeriesManagment: Codeunit NoSeriesManagement;
//         OperationCaisse: Record "Code Opération Caisse";
//         Text003: Label 'Return amount greater than the principal amount.';
//         Text004: Label 'Please specify all fields for this type of operation.';
//         Text005: Label 'Fields filled in only for advance and loan.';
//         LoanAdvance: Record "Loan & Advance";
//         LoanAdvance2: Record "Loan & Advance";
//         Text006: Label 'You must first delete the Advance Payroll Document before deleting this line.';


//     procedure Application()
//     begin
//         CODEUNIT.RUN(CODEUNIT::"Payment-Apply", Rec);
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
//         IF Header.GET(rec."No.") THEN BEGIN
//             IF ((Header."Status No." = 0) AND (rec."Copied To No." = '')) OR (Header.Reouvrir) THEN
//                 CurrPage.EDITABLE(TRUE)
//             ELSE
//                 CurrPage.EDITABLE(FALSE);
//         END;
//     end;


//     procedure Modify()
//     var
//         PaymentLine: Record "Payment Line";
//         PaymentModification: Page "Payment Line Modification";
//     begin
//         IF rec."Line No." = 0 THEN
//             MESSAGE(Text001)
//         ELSE
//             IF NOT rec.Posted THEN BEGIN
//                 PaymentLine.COPY(Rec);
//                 PaymentLine.SETRANGE("No.", rec."No.");
//                 PaymentLine.SETRANGE("Line No.", rec."Line No.");
//                 PaymentModification.SETTABLEVIEW(PaymentLine);
//                 PaymentModification.RUNMODAL;
//             END ELSE
//                 MESSAGE(Text002);
//     end;


//     procedure Delete()
//     var
//         PostingStatement: Codeunit "Payment Management";
//         StatementLine: Record "Payment Line";
//     begin
//         StatementLine.COPY(Rec);
//         CurrPage.SETSELECTIONFILTER(StatementLine);
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
//         IF CONFIRM(Text000) THEN BEGIN
//             CurrPage.SETSELECTIONFILTER(StatementLine);
//             StatementLine.MARKEDONLY(TRUE);
//             IF NOT StatementLine.FIND('-') THEN
//                 StatementLine.MARKEDONLY(FALSE);
//             IF StatementLine.FIND('-') THEN BEGIN
//                 No := StatementLine."Document No.";
//                 WHILE StatementLine.NEXT <> 0 DO BEGIN
//                     //GL2024 License  PostingStatement.IncrementNoText(No, 1);
//                     StatementLine."Document No." := No;
//                     StatementLine.MODIFY;
//                 END;
//             END;
//         END;
//     end;


//     procedure ShowAccount()
//     var
//         GenJnlLine: Record "Gen. Journal Line";
//     begin
//         GenJnlLine."Account Type" := rec."Account Type";
//         GenJnlLine."Account No." := rec."Account No.";
//         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Show Card", GenJnlLine);
//     end;


//     procedure ShowEntries()
//     var
//         GenJnlLine: Record "Gen. Journal Line";
//     begin
//         GenJnlLine."Account Type" := rec."Account Type";
//         GenJnlLine."Account No." := rec."Account No.";
//         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Show Entries", GenJnlLine);
//     end;


//     procedure MarkLines(ToMark: Boolean)
//     var
//         LineCopy: Record "Payment Line";
//         PaymtManagt: Codeunit "Payment Management";
//         NumLines: Integer;
//     begin
//         IF ToMark THEN BEGIN
//             CurrPage.SETSELECTIONFILTER(LineCopy);
//             LineCopy.MARKEDONLY(TRUE);
//             NumLines := LineCopy.COUNT;
//             IF NumLines > 0 THEN BEGIN
//                 LineCopy.FIND('-');
//                 REPEAT
//                     IF LineCopy.MARK THEN BEGIN
//                         LineCopy.Marked := TRUE;
//                         LineCopy.MODIFY;
//                     END;
//                 UNTIL LineCopy.NEXT = 0;
//             END ELSE
//                 LineCopy.RESET;
//             LineCopy.SETRANGE("No.", rec."No.");
//             LineCopy.MODIFYALL(Marked, TRUE);
//         END ELSE BEGIN
//             rec.CLEARMARKS;
//             LineCopy.SETRANGE("No.", rec."No.");
//             LineCopy.MODIFYALL(Marked, FALSE);
//         END;
//         COMMIT;
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
//         Frs.RESET;
//         cust.RESET;
//         Cmpt.RESET;
//         Sal.RESET;
//         banq.RESET;
//         Lib := '';
//         IF rec."Account No." <> '' THEN
//             CASE rec."Account Type" OF
//                 rec."Account Type"::Vendor:
//                     BEGIN
//                         IF Frs.GET(rec."Account No.") THEN
//                             Lib := Frs.Name;
//                     END;
//                 rec."Account Type"::"G/L Account":
//                     BEGIN
//                         IF Cmpt.GET(rec."Account No.") THEN
//                             Lib := Cmpt.Name;
//                     END;

//                 rec."Account Type"::Customer:
//                     BEGIN
//                         IF cust.GET(rec."Account No.") THEN
//                             Lib := cust.Name;
//                     END;
//                 /*"Account Type"::Salary : BEGIN
//                    IF Sal.GET("Account No.") THEN
//                       Lib:=Sal."Last Name"+' '+Sal."First Name";
//                    END;*/
//                 rec."Account Type"::"Bank Account":
//                     BEGIN
//                         IF banq.GET(rec."Account No.") THEN
//                             Lib := banq.Name;
//                     END;
//             END;

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
//         EXIT(rec."Référence chèque");
//     end;


//     procedure AfficherAvancePret()
//     begin
//         LoanAdvance2.SETRANGE("N° Bon Caisse", rec."Numero Seq");
//         IF rec.Avance THEN page.RUNMODAL(page::Advances, LoanAdvance2);
//         IF rec.Prêt THEN page.RUNMODAL(page::Loans, LoanAdvance2);
//     end;


//     procedure GetNumSeq() NumSeq: Code[20]
//     begin
//         EXIT(rec."Numero Seq");
//     end;

//     local procedure BenificiaireOnAfterValidate()
//     begin
//         rec.CALCFIELDS("Nom Benificiaire");
//     end;

//     local procedure CodeOp233rationOnFormat()
//     begin
//         IF rec."Type Caisse" = 2 THEN;
//         IF rec."Type Caisse" = 3 THEN;
//     end;
// }

