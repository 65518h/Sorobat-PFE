PageExtension 50107 "Bank Account Ledger Ent_PagEXT" extends "Bank Account Ledger Entries"
{

    layout
    {
        addbefore("Control1")
        {
            field(DecMontantSelect; DecMontantSelect)
            {
                Caption = 'Dec Montant Select';
                ShowCaption = false;
                ApplicationArea = all;
            }
        }
        modify(Control1)
        {
            Editable = false;
        }

        addafter("Posting Date")
        {
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = all;
                trigger OnValidate()
                VAR
                    lRec: Record "Bank Account Ledger Entry";
                BEGIN

                    IF lRec.GET(rec."Closed by Entry No.") THEN BEGIN
                        lRec."Due Date" := rec."Due Date";
                        lRec.MODIFY;
                    END;
                    //+RAP+TRESO
                    CurrPage.UPDATE;
                    //+RAP+TRESO//

                end;
            }
        }
        addafter("Document No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Description)
        {
            /* field("Date Relevé"; Rec."Date Relevé")
             {
                 ApplicationArea = all;
             }*/
            field("Statement Status"; Rec."Statement Status")
            {
                ApplicationArea = all;
            }
            field("Statement No."; Rec."Statement No.")
            {
                ApplicationArea = all;
            }
            field("Statement Line No."; Rec."Statement Line No.")
            {
                ApplicationArea = all;
            }
        }
        modify("Currency Code")
        {
            Editable = true;
        }
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = true;
        }
        modify("Debit Amount (LCY)")
        {
            Editable = true;
            Visible = false;
        }
        addafter("User ID")
        {
            field("N° Folio"; Rec."N° Folio")
            {
                ApplicationArea = all;
            }
            /* field("Affectation Financiere"; Rec."Affectation Financiere")
             {
                 ApplicationArea = all;
             }*/
        }
    }

    actions
    {
        addafter("Reverse Transaction_Promoted")
        {
            actionref("Reverse Transaction1"; "Reverse Transaction")
            {

            }
        }
        addafter("Reverse Transaction")
        {
            action("Regénérer paiement")
            {
                Caption = 'Payment duplicate';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lCheckEntry: Record "Check Ledger Entry";
                    //DYS REPORT ADDON NON MIGRER
                    // lETEBAC: Report 8004108;
                    lBankPaymentType: Record "Bank Payment Type";
                    lBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
                    lCheckEntry2: Record "Check Ledger Entry";
                    lOption1: Text[30];
                    lOption2: Text[30];
                    lOption3: Text[30];
                    lCheckEntryoption: Record "Check Ledger Entry";
                begin


                    //+PMT+PAYMENT
                    lCheckEntry.SETCURRENTKEY("Bank Account Ledger Entry No.");
                    lCheckEntry.SETRANGE("Bank Account Ledger Entry No.", rec."Entry No.");
                    lCheckEntry.FIND('-');

                    IF NOT (lCheckEntry."Payment Type" IN
                     [lCheckEntry."Payment Type"::Transfer, lCheckEntry."Payment Type"::"Direct Debit", lCheckEntry."Payment Type"::VCOM]) THEN
                        //#8578
                        //  lCheckEntry.FIELDERROR("Payment Type",
                        //    STRSUBSTNO(tEtebac,
                        //      FORMAT(lCheckEntry."Payment Type"::Transfer,0),
                        //      FORMAT(lCheckEntry."Payment Type"::"Direct Debit"),
                        //      FORMAT(lCheckEntry."Payment Type"::VCOM,0),1,'<Text>'));
                        lCheckEntryoption."Payment Type" := lCheckEntry."Payment Type"::Transfer;
                    lOption1 := FORMAT(lCheckEntryoption."Payment Type", 0, '<Text>');
                    lCheckEntryoption."Payment Type" := lCheckEntry."Payment Type"::"Direct Debit";
                    lOption2 := FORMAT(lCheckEntryoption."Payment Type", 0, '<Text>');
                    lCheckEntryoption."Payment Type" := lCheckEntry."Payment Type"::VCOM;
                    lOption3 := FORMAT(lCheckEntryoption."Payment Type", 0, '<Text>');
                    lCheckEntry.FIELDERROR("Payment Type",
                      STRSUBSTNO(tEtebac, '', lOption1, lOption2, lOption3));
                    //#8578//
                    //+PMT+SEPA
                    lBankPaymentType.GET(rec."Bank Account No.", lCheckEntry."Payment Type");
                    IF lBankPaymentType."Export Type" = lBankPaymentType."Export Type"::SEPA THEN BEGIN
                        lCheckEntry2.SETRANGE("Entry No.", lCheckEntry."Entry No.");
                        REPORT.RUNMODAL(REPORT::"SEPA ISO20022", TRUE, TRUE, lCheckEntry2);
                    END ELSE BEGIN
                        //+PMT+SEPA//
                        //DYS
                        // lETEBAC.InitRequest(lCheckEntry."Entry No.");
                        //lETEBAC.USEREQUESTFORM(TRUE);
                        //lETEBAC.RUNMODAL;
                        //+PMT+PAYMENT//
                    END;


                end;
            }
            /* GL2024     action("Modifier effet")
                 {
                     Caption = 'Change Bill';
                     ApplicationArea = all;
                     trigger OnAction()
                     begin

                         //+PMT+BILL
                         //DYS page addon non migrer
                         //PAGE.RUNMODAL(PAGE::"Bill Bank Ledger Entry UpdVoid", Rec);
                         CurrPage.UPDATE(TRUE);
                         //+PMT+BILL
                     end;
                 }*/
            /* GL2024    action("Extourner effet")
                {
                    Caption = 'Bill Receivable Update/Void';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        //DYS page addon non migrer
                        //  lBillBankEntryUpdVoid: Page 8004109;
                        lBillVoid: Codeunit "Bill Bank Ledger Entry UpdVoid";
                        lRec: Record "Bank Account Ledger Entry";
                    begin

                        //+PMT+BILL
                        //DYS
                        // lBillBankEntryUpdVoid.SETRECORD(Rec);
                        // lBillBankEntryUpdVoid.Void;
                        // IF lBillBankEntryUpdVoid.RUNMODAL = ACTION::OK THEN
                        //     IF CONFIRM(tBalanceToOrigin, FALSE, WORKDATE) THEN BEGIN
                        //         lRec := Rec;
                        //         lBillVoid.RUN(lRec);
                        //     END;
                        CurrPage.UPDATE;
                        //+PMT+BILL//
                    end;
                }*/
        }



        addafter("&Navigate")
        {
            action("Calculer La Selection")
            {
                ApplicationArea = all;
                Caption = 'Calculate the selection';
                trigger OnAction()
                begin

                    // RB SORO 15/04/2016
                    DecMontantSelect := 0;
                    CurrPage.SETSELECTIONFILTER(RecBqLedEntryCalc);
                    IF RecBqLedEntryCalc.FINDFIRST THEN
                        REPEAT
                            //RecBqLedEntryCalc.CALCFIELDS(Amount);
                            DecMontantSelect += RecBqLedEntryCalc.Amount;
                        UNTIL RecBqLedEntryCalc.NEXT = 0;
                    // RB SORO 15/04/2016
                end;
            }
        }
        addafter("&Navigate_Promoted")
        {
            actionref("Calculer La Selection1"; "Calculer La Selection")
            {

            }
        }
    }

    var
        RecBqLedEntryCalc: Record "Bank Account Ledger Entry";
        DecMontantSelect: Decimal;
        tEtebac: Label 'must be %2 or %3';
        tVoidPayment: Label 'Financially void payment %1 to %2 %3 ?';
        tBalanceToOrigin: Label 'Would you account for original account on %1?';





}