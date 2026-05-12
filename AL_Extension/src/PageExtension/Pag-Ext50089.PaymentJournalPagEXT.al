PageExtension 50089 "Payment Journal_PagEXT" extends "Payment Journal"
{
    layout
    {
        addbefore("Posting Date")
        {
            field("Subscription Starting Date"; Rec."Subscription Starting Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Subscription End Date"; Rec."Subscription End Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        modify("External Document No.")
        {
            Visible = false;
        }

        addafter("Account No.")
        {
            field("Payment Bank Account"; Rec."Payment Bank Account")
            {
                ApplicationArea = all;
            }
        }

        addafter(Description)
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Job Task No."; Rec."Job Task No.")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
        }

        addafter("Campaign No.")
        {
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = all;
            }
        }
        modify(GetAppliesToDocDueDate)
        {
            Editable = false;
        }

        addafter("Bank Payment Type")
        {
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = all;
            }
        }
        addafter("Check Printed")
        {
            field("Bill Type"; Rec."Bill Type")
            {
                ApplicationArea = all;
            }
        }


    }
    actions
    {
        /*GL2024  addafter(SuggestVendorPayments)
          {
              action("Domicilier paiements")
              {
                  Caption = 'Bal. Bank Account';
                  ApplicationArea = all;
                  trigger OnAction()
                  var
                  //DYS REPORT addon non migrer
                  // lBalBankAcc: Report 8004107;
                  begin
                      GenJnlLine.RESET;
                      GenJnlLine.COPY(Rec);
                      GenJnlLine.FILTERGROUP(10);
                      GenJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                      GenJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                      GenJnlLine.SETRANGE("Check Printed", FALSE);
                      GenJnlLine.FILTERGROUP(0);
                      // lBalBankAcc.SETTABLEVIEW(GenJnlLine);
                      // lBalBankAcc.wInitRequest(TRUE);
                      // lBalBankAcc.RUNMODAL;
                  end;
              }
          }*/
        modify(PrintCheck)
        {
            trigger OnBeforeAction()
            var
                Texte0001: Label 'Due Date can''t be empty';
            BEGIN
                //+PMT+
                IF (GenJnlLine."Due Date" = 0D) AND (GenJnlLine."Payment Type" = GenJnlLine."Payment Type"::VCOM) THEN
                    ERROR(Texte0001);
                //+PMT+//
            end;
        }
        modify("Void Check")
        {
            Visible = false;
        }
        addafter("Void Check")
        {
            action("Void Check2")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Void Check';
                Image = VoidCheck;

                trigger OnAction()
                var
                    CheckManagement: Codeunit CheckManagement;
                    ConfirmManagement: Codeunit "Confirm Management";
                    VoidCheckQst: Label 'Void Check %1?', Comment = '%1 - check number';

                    lGenJnlLine: Record "Gen. Journal Line";
                begin
                    Rec.TestField("Bank Payment Type", Rec."Bank Payment Type"::"Computer Check");
                    Rec.TestField("Check Printed", true);
                    if ConfirmManagement.GetResponseOrDefault(StrSubstNo(VoidCheckQst, Rec."Document No."), true) then
                        //+PMT+PAYMENT
                        IF rec."Payment Type" = rec."Payment Type"::Transfer THEN BEGIN
                            GenJnlLine.RESET;
                            GenJnlLine.COPY(Rec);
                            GenJnlLine.SETRANGE("Bank Payment Type", rec."Bank Payment Type");
                            GenJnlLine.SETRANGE("Payment Type", rec."Payment Type");
                            GenJnlLine.SETRANGE("Document No.", rec."Document No.");
                            GenJnlLine.SETRANGE("Check Printed", TRUE);
                            IF GenJnlLine.FIND('-') THEN
                                REPEAT
                                    lGenJnlLine := GenJnlLine;
                                    IF GenJnlLine."Check Ledger Entry No." <> 0 THEN
                                        CheckManagement.VoidCheck(lGenJnlLine)
                                    ELSE BEGIN
                                        GenJnlLine."Check Printed" := FALSE;
                                        GenJnlLine.DELETE(TRUE);
                                    END;
                                UNTIL GenJnlLine.NEXT = 0;
                        END
                        ELSE
                            //+PMT+PAYMENT//
                            CheckManagement.VoidCheck(Rec);
                end;
            }
        }
        addafter("Void Check_Promoted")
        {
            actionref("Void Check21"; "Void Check2")
            {

            }
        }
        addafter("Void &All Checks")
        {
            action("Generate ETEBAC")
            {
                Caption = 'Generate ETEBAC';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lBankPayment: Record "Bank Payment Type";
                    //DYS REPORT addon non migrer
                    // lGroupBalBankAccount: Report 8004114;
                    // lETEBAC: Report 8004108;
                    // lSEPA: Report 8004110;
                    lBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
                    lPaymentMgt: Codeunit "Payment Management1";
                    lCheckLedgerEntry: Record "Check Ledger Entry";
                    lCheckLedgerEntry2: Record "Check Ledger Entry";
                    //DYS REPORT addon non migrer
                    // lReportSEPA: Report 8004110;
                    lFileName: Text[250];
                    ltInvalidPaymentType: Label 'Invalide Payment Type';
                begin

                    //+PMT+
                    IF NOT (rec."Payment Type" IN [rec."Payment Type"::Transfer, rec."Payment Type"::VCOM]) THEN
                        ERROR(ltInvalidPaymentType);
                    //+PMT+//
                    rec.TESTFIELD("Check Printed", TRUE);
                    rec.TESTFIELD("Check Ledger Entry No.");

                    lPaymentMgt.CheckJournal(rec."Check Ledger Entry No.");

                    IF (rec."Bal. Account Type" = rec."Bal. Account Type"::"Bank Account") AND (rec."Bal. Account No." <> '') AND
                      lBankPayment.GET(rec."Bal. Account No.", rec."Payment Type") AND lBankPayment."Bal. Summarize" THEN BEGIN
                        //DYS
                        // lGroupBalBankAccount.InitRequest(TRUE, Rec);
                        // lGroupBalBankAccount.SETTABLEVIEW(Rec);
                        // lGroupBalBankAccount.USEREQUESTFORM(FALSE);
                        // lGroupBalBankAccount.RUNMODAL;
                        COMMIT;
                    END;

                    //+PMT+SEPA
                    lCheckLedgerEntry.GET(rec."Check Ledger Entry No.");
                    IF (lBankPayment.GET(lCheckLedgerEntry."Bank Account No.", lCheckLedgerEntry."Payment Type")) AND
                     (lBankPayment."Export Type" = lBankPayment."Export Type"::SEPA) THEN BEGIN
                        lCheckLedgerEntry2.SETRANGE("Entry No.", lCheckLedgerEntry."Entry No.");    // ??? filtre sur Entry no.
                                                                                                    //#9134
                                                                                                    //  REPORT.RUNMODAL(REPORT::"SEPA ISO20022",TRUE,TRUE,lCheckLedgerEntry2);
                        lFileName := lBankPayment.FileName;
                        //DYS
                        // lReportSEPA.fInitFileName(lFileName);
                        // lReportSEPA.SETTABLEVIEW(lCheckLedgerEntry2);
                        // lReportSEPA.RUNMODAL()
                        //#9134//
                    END ELSE BEGIN
                        //+PMT+SEPA//
                        //DYS
                        // lETEBAC.InitRequest(rec."Check Ledger Entry No.");
                        // lETEBAC.RUNMODAL;
                    END;
                end;
            }
            action("Générer virements échéance")
            {
                Caption = 'Generate ETEBAC per Due Date';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lBankPayment: Record "Bank Payment Type";
                    //DYS REPORT addon non migrer
                    // lGroupBalBankAccount: Report 8004114;
                    // lETEBAC: Report 8004108;
                    lGenJnlLine: Record "Gen. Journal Line";
                    lPaymentMgt: Codeunit "Payment Management1";
                    ltInvalidPaymentType: Label 'Invalide Payment Type';
                begin
                    //+PMT+
                    IF NOT (rec."Payment Type" IN [rec."Payment Type"::Transfer, rec."Payment Type"::VCOM]) THEN
                        ERROR(ltInvalidPaymentType);
                    //+PMT+//
                    rec.TESTFIELD("Check Printed", TRUE);
                    rec.TESTFIELD("Check Ledger Entry No.");

                    //#8129
                    //lETEBAC.CheckJournal("Check Ledger Entry No.");
                    lPaymentMgt.CheckJournal(rec."Check Ledger Entry No.");
                    //#8219//

                    IF (rec."Bal. Account Type" = rec."Bal. Account Type"::"Bank Account") AND (rec."Bal. Account No." <> '') AND
                      lBankPayment.GET(rec."Bal. Account No.", rec."Payment Type") AND lBankPayment."Bal. Summarize" THEN BEGIN
                        // lGroupBalBankAccount.InitRequest(TRUE,Rec);
                        //DYS
                        // lGroupBalBankAccount.fInitRequest2(TRUE, Rec);
                        // lGroupBalBankAccount.SETTABLEVIEW(Rec);
                        // lGroupBalBankAccount.USEREQUESTFORM(FALSE);
                        // lGroupBalBankAccount.RUNMODAL;
                        COMMIT;
                    END;

                    //#6869
                    lGenJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    lGenJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    //DYS
                    // lETEBAC.InitRequest2(lGenJnlLine);
                    // lETEBAC.RUNMODAL;
                    //#6869//
                end;
            }
            action("Generate SEPA Transfer")
            {
                Caption = 'Generate SEPA Transfer';
                ApplicationArea = all;
                trigger OnAction()
                var
                    //DYS REPORT addon non migrer
                    //lSEPA: Report 8004110;
                    lBankPayment: Record "Bank Payment Type";
                    //DYS REPORT addon non migrer
                    //lGroupBalBankAccount: Report 8004114;
                    lIntegerDataItem: Record Integer;
                begin

                    //+PMT+SEPA
                    rec.TESTFIELD("Payment Type", rec."Payment Type"::Transfer);
                    rec.TESTFIELD("Check Printed", TRUE);
                    rec.TESTFIELD("Check Ledger Entry No.");

                    IF (rec."Bal. Account Type" = rec."Bal. Account Type"::"Bank Account") AND (rec."Bal. Account No." <> '') AND
                      lBankPayment.GET(rec."Bal. Account No.", rec."Payment Type") AND lBankPayment."Bal. Summarize" THEN BEGIN
                        //DYS
                        // lGroupBalBankAccount.InitRequest(TRUE, Rec);
                        // lGroupBalBankAccount.SETTABLEVIEW(Rec);
                        // lGroupBalBankAccount.USEREQUESTFORM(FALSE);
                        // lGroupBalBankAccount.RUNMODAL;
                        COMMIT;
                    END;

                    lIntegerDataItem.SETRANGE(Number, rec."Check Ledger Entry No.");
                    REPORT.RUNMODAL(REPORT::"SEPA ISO20022", TRUE, TRUE, lIntegerDataItem);
                    //+PMT+SEPA//
                end;
            }
        }
        addafter("Void &All Checks_Promoted")
        {
            actionref("Generate ETEBAC1"; "Generate ETEBAC")
            {

            }
            actionref("Générer virements échéance1"; "Générer virements échéance")
            {

            }
            actionref("Generate SEPA Transfer1"; "Generate SEPA Transfer")
            {

            }
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                //+PMT+PAYMENT
                wCheckTransfer;
                //+PMT+PAYMENT//
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                //+PMT+PAYMENT
                wCheckTransfer;
                //+PMT+PAYMENT//
            end;
        }

        addafter("F&unctions")
        {
            group("&DTA")
            {
                Visible = btnDTAVISIBLE;
                Caption = '&DTA';

                /*GL2024   action("&Proposer paiements four DTA")
                {
                    ApplicationArea = all;
                    Caption = 'DTA &Suggest Vendor Payment';

                    trigger OnAction()
                    begin
                        //DYS
                        // CLEAR(DtaSuggestVendPmt);
                        // DtaSuggestVendPmt.DefineJournalName(Rec);
                        // DtaSuggestVendPmt.RUNMODAL;

                    end;
                }*/
                /*GL2024  action("P&rint Payment Journal")
               {
                   ApplicationArea = all;
                   Caption = 'P&rint Payment Journal';

                   trigger OnAction()
                   begin
                       //DYS report addon non migrer
                       //REPORT.RUN(REPORT::3010545, TRUE, FALSE, Rec);
                   end;
               }*/
                /*GL2024  action("&Print Payment Ad&vice")
                  {
                      ApplicationArea = all;
                      Caption = '&Print Payment Ad&vice';

                      trigger OnAction()
                      begin
                          //DYS

                          // CLEAR(VendPmtAdvice);
                          // VendPmtAdvice.DefineJourBatch(Rec);
                          // VendPmtAdvice.RUNMODAL;


                      end;
                  }*/
                action("Show &Open Invoicess")
                {
                    Caption = 'Show &Open Invoices';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        lVendLedgEntry: Record "Vendor Ledger Entry";
                    begin

                        lVendLedgEntry.SETCURRENTKEY("Vendor No.", Open);
                        lVendLedgEntry.SETRANGE(Open, TRUE);
                        lVendLedgEntry.SETRANGE("On Hold", '');
                        PAGE.RUNMODAL(Page::"Vendor Ledger Entries", lVendLedgEntry);
                    end;
                }
                /* //DYS   separator(separator100)
                  {
                  }
                  action("Generate &DTA File")
                  {
                      Caption = 'Generate &DTA File';
                      ApplicationArea = all;
                      trigger OnAction()
                      begin
                          //DYS report addon non migrer
                          // REPORT.RUN(REPORT::3010541, TRUE, FALSE, Rec);
                      end;
                  }
                  action("DTA &Payment Order")
                  {
                      ApplicationArea = all;
                      Caption = 'DTA &Payment Order';

                      trigger OnAction()
                      begin
                          //DYS report addon non migrer
                          // REPORT.RUN(REPORT::3010543, TRUE, FALSE, Rec);
                      end;
                  }
                  separator(separator101)
                  {
                  }
                  action("Generate EZAG File")
                  {
                      ApplicationArea = all;
                      Caption = 'Generate EZAG File';

                      trigger OnAction()
                      begin
                          //DYS report addon non migrer
                          //REPORT.RUN(REPORT::3010542, TRUE, FALSE, Rec);
                      end;
                  }
                  action("E&ZAG Payment Order")
                  {
                      ApplicationArea = all;
                      Caption = 'E&ZAG Payment Order';

                      trigger OnAction()
                      begin
                          //DYS report addon non migrer
                          //  REPORT.RUN(REPORT::3010544, TRUE, FALSE, Rec);
                      end;
                  }
                  action("Start &Yellownet")
                  {
                      ApplicationArea = all;
                      Caption = 'Start &Yellownet';

                      trigger OnAction()
                      begin
                          //DYS
                          // DtaMgt.StartYellownet;
                      end;
                  }*/
                /* //DYS   separator(separator102)
                  {
                  }*/
                /* //DYS   action("Modify Document &No.")
                  {
                      ApplicationArea = all;
                      Caption = 'Modify Document &No.';

                      trigger OnAction()
                      begin
                          //DYS
                          //  DtaMgt.ModifyDocNo(Rec);
                      end;
                  }*/
                /* //DYS    action("Update &Balance Account Lines")
                   {
                       ApplicationArea = all;
                       Caption = 'Update &Balance Account Lines';

                       trigger OnAction()
                       begin

                           //DYS
                           //  DtaSuggestVendPmt.WriteBalAccountLine(Rec);
                       end;
                   }*/
                //DYS   separator(separator103)
                //DYS   {
                //DYS    }
                /* //DYS    action("DTA Setup")
                   {
                       ApplicationArea = all;
                       Caption = 'DTA Setup';
                       //DYS page n'existe pas dans NAV
                       //RunObject = Page 90602;
                   }*/
                /*GL2024  action("Dimensions")
                  {  ApplicationArea = all;
                      Caption = 'Dimensions';
                      RunObject = Page 545;
                      RunPageLink = "Table ID" = CONST(81), "Journal Template Name" = FIELD("Journal Template Name"), "Journal Batch Name" = FIELD("Journal Batch Name"), "Journal Line No." = FIELD("Line No.");
                      ShortCutKey = 'Maj+Ctrl+D';
                  }*/

            }

        }
        addafter("Renumber Document Numbers_Promoted")
        {
            group("DTA")
            {

                Caption = 'DTA';

                actionref("Show &Open Invoicess1"; "Show &Open Invoicess")
                {

                }
            }
        }

    }

    trigger OnOpenPage()
    var

        lGLsetup: Record "General Ledger Setup";
        lVisible: Boolean;
    begin
        //+CH+DTA
        lGLsetup.GET;
        //TRS-2009
        lVisible := lGLsetup.Localization = lGLsetup.Localization::CH;
        btnDTAVISIBLE := (lVisible);
        //TRS-2009//
        //+CH+DTA//
    end;

    PROCEDURE wCheckTransfer();
    VAR
        lBankPayment: Record "Bank Payment Type";
        Text8004102: label 'You must create transfer file to sum up to a bank account.';
    BEGIN
        IF rec."Payment Type" = rec."Payment Type"::Transfer THEN BEGIN
            IF (rec."Bal. Account Type" = rec."Bal. Account Type"::"Bank Account") AND (rec."Bal. Account No." <> '') THEN BEGIN
                lBankPayment.GET(rec."Bal. Account No.", rec."Payment Type");
                IF lBankPayment."Bal. Summarize" THEN
                    ERROR(Text8004102);
            END;
        END;
    END;

    var
        tInvalidPaymentType: label 'Invalide Payment Type';
        CreateVendorPmtSuggestion: Report "Suggest Vendor Payments";
        //DYS cdu n'existe pas dans NAV
        // DtaMgt: Codeunit 70541;
        //DYS REPORT addon non migrer
        // DtaSuggestVendPmt: Report 3010546;
        //DYS REPORT n'existe pas dans NAV
        // VendPmtAdvice: Report 11561;
        GenJnlLine: Record "Gen. Journal Line";
        //GL2024
        btnDTAVISIBLE: Boolean;
}


