PageExtension 50088 "Cash Receipt Journal_PagEXT" extends "Cash Receipt Journal"
{
    layout
    {
        addbefore("Posting Date")
        {
            field("Subscription Starting Date"; Rec."Subscription Starting Date")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Subscription End Date"; Rec."Subscription End Date")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
        }

        addafter(Description)
        {
            field("Payment Bank Account"; Rec."Payment Bank Account")
            {
                Visible = "Payment Bank AccountVISIBLE";
                ApplicationArea = all;
            }
            field("Bill Type"; Rec."Bill Type")
            {
                Visible = "Bill TypeVISIBLE";
                ApplicationArea = all;
            }
            field("Due Date"; Rec."Due Date")
            {
                Visible = "Due DateVISIBLE";
                ApplicationArea = all;
            }
        }

        addafter("Campaign No.")
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

        addafter("Applies-to ID")
        {
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Check Printed"; Rec."Check Printed")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
        }

    }
    actions
    {
        addafter("Insert Conv. LCY Rndg. Lines")
        {
            /*GL2024 action("Suggest Receipts")
             {
                 ApplicationArea = all;
                 Caption = 'Suggest Receipts';

                 trigger OnAction()
                 var
                 //DYS REPORT addon non migrer
                 //lProposeReceivable: Report 8004111;
                 begin

                     //+PMT+PAYMENT
                     //DYS
                     // lProposeReceivable.InitGenJnlLine(Rec);
                     // lProposeReceivable.RUNMODAL;
                     // CLEAR(lProposeReceivable);
                     //+PMT+PAYMENT//
                 end;
             }*/
            /* GL2024   action("Bal. Bank Account")
             {
                 ApplicationArea = all;
                 Caption = 'Bal. Bank Account';

                 trigger OnAction()
                 var
                     lGenJnlLine: Record "Gen. Journal Line";
                 //DYS REPORT addon non migrer
                 //lBalBankAcc: Report 8004107;
                 begin

                     //+PMT+PAYMENT
                     lGenJnlLine.RESET;
                     lGenJnlLine.COPY(Rec);
                     lGenJnlLine.FILTERGROUP(10);
                     lGenJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                     lGenJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                     lGenJnlLine.SETRANGE("Check Printed", FALSE);
                     lGenJnlLine.FILTERGROUP(0);
                     // lBalBankAcc.SETTABLEVIEW(lGenJnlLine);
                     // lBalBankAcc.wInitRequest(FALSE);
                     // lBalBankAcc.RUNMODAL;
                     //+PMT+PAYMENT//
                 end;
             }*/
            /* GL2024 action("Print Recapitulation")
              {
                  ApplicationArea = all;
                  Caption = 'Print Recapitulation';

                  trigger OnAction()
                  var
                  //DYS REPORT addon non migrer
                  // lCreateRecapitulation: Report 8004113;
                  begin

                      //DYS
                      // CreateRecapitulation2.SETTABLEVIEW(Rec);
                      // CreateRecapitulation2.InitRequest(rec."Journal Template Name", rec."Journal Batch Name");
                      // CreateRecapitulation2.RUNMODAL;
                      // CLEAR(CreateRecapitulation2);
                      //#8517
                      //#8517//
                  end;
              }*/
            /* GL2024  action("Print Bill Of Exchange Continuous")
              {
                  Caption = 'Print Bill Of Exchange Continuous';
                  ApplicationArea = all;
                  trigger OnAction()
                  var
                      lGenJnlLine: Record "Gen. Journal Line";
                  begin

                      lGenJnlLine.RESET;
                      lGenJnlLine.COPY(Rec);
                      lGenJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                      lGenJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                      //DYS REPORT addon non migrer
                      // REPORT.RUN(REPORT::"Bill of Exchange Continuous", TRUE, FALSE, lGenJnlLine);
                  end;
              }*/
            /*  /* GL2024  action("Print Bill Of Exchange Statement")
              {
                  Caption = 'Print Bill Of Exchange Statement';
                  ApplicationArea = all;
                  trigger OnAction()
                  var
                      lGenJnlLine: Record "Gen. Journal Line";
                  begin

                      lGenJnlLine.RESET;
                      lGenJnlLine.COPY(Rec);
                      lGenJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                      lGenJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                      //DYS REPORT addon non migrer
                      //  REPORT.RUN(REPORT::"Bill of Exchange Statement", TRUE, FALSE, lGenJnlLine);
                  end;
              }*/
            group("Direct Debit")
            {
                Caption = 'Direct Debit';

                /*  /* GL2024   action("Generate debit")
                   {
                       ApplicationArea = all;
                       Caption = 'Generate debit';

                       trigger OnAction()
                       var
                           lRec: Record "Gen. Journal Line";
                       begin

                           lRec.COPY(Rec);
                           lRec.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                           lRec.SETRANGE("Journal Template Name", rec."Journal Template Name");
                           //DYS REPORT addon non migrer
                           //   REPORT.RUNMODAL(REPORT::"Generate Direct Debit", TRUE, TRUE, lRec);
                       end;
                   }*/
                action("Cancel debit")
                {
                    Caption = 'Cancel debit';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        lGenJnlLine: Record "Gen. Journal Line";
                        lGenJnlLine2: Record "Gen. Journal Line";
                        lCheckManagement: Codeunit CheckManagement;
                    begin

                        IF CONFIRM(tAvoid, FALSE, rec."Document No.") THEN BEGIN
                            lGenJnlLine.RESET;
                            lGenJnlLine.COPY(Rec);
                            lGenJnlLine.SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                            lGenJnlLine.SETRANGE("Payment Type", rec."Payment Type"::"Direct Debit");
                            lGenJnlLine.SETRANGE("Document No.", rec."Document No.");
                            lGenJnlLine.SETRANGE("Check Printed", TRUE);
                            IF lGenJnlLine.FIND('-') THEN
                                REPEAT
                                    lGenJnlLine2 := lGenJnlLine;
                                    IF lGenJnlLine."Check Ledger Entry No." <> 0 THEN
                                        lCheckManagement.VoidCheck(lGenJnlLine2)
                                    ELSE BEGIN
                                        lGenJnlLine."Check Printed" := FALSE;
                                        lGenJnlLine.DELETE(TRUE);
                                    END;
                                UNTIL lGenJnlLine.NEXT = 0;
                        END;
                    end;
                }
                /* GL2024 action("Export generation")
               {
                   Caption = 'Export generation';
                   ApplicationArea = all;
                   trigger OnAction()
                   var
                       lCheckEntry: Record "Check Ledger Entry";
                   //DYS REPORT addon non migrer
                   //    lETEBAC: Report 8004108;
                   begin

                       rec.TESTFIELD("Payment Type", rec."Payment Type"::"Direct Debit");
                       rec.TESTFIELD("Check Printed", TRUE);
                       rec.TESTFIELD("Check Ledger Entry No.");
                       // lETEBAC.InitRequest(rec."Check Ledger Entry No.");
                       // lETEBAC.RUNMODAL;
                   end;
               }*/
                /* GL2024  action("Multi-Export generation")
                {
                    ApplicationArea = all;
                    Caption = 'Multi-Export generation';

                    trigger OnAction()
                    var
                        lGenJnlLine: Record "Gen. Journal Line";
                    //DYS REPORT addon non migrer
                    //lETEBAC: Report 8004108;
                    begin

                        //#6869
                        lGenJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        lGenJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                        // lETEBAC.InitRequest2(lGenJnlLine);
                        // lETEBAC.RUNMODAL;
                        //#6869//
                    end;
                }*/
            }

        }
        addafter("Apply Entries_Promoted")
        {
            group("Direct Debit1")
            {
                Caption = 'Direct Debit';

                actionref("Cancel debit1"; "Cancel debit")
                {

                }
            }
        }

        addafter("P&osting")
        {
            group("&E-Payment")
            {
                Visible = btnElectronicPaymentVISIBLE;
                Caption = '&E-Payment';
                group("&LSV")
                {
                    Caption = '&LSV';

                    /* GL2024  action("&LSV Journal")
                     {
                         ApplicationArea = all;
                         Caption = '&LSV Journal';
                         //DYS PAGE addon non migrer
                         // RunObject = Page 3010832;
                     }*/
                    action("&Get from LSV Journal")
                    {
                        ApplicationArea = all;
                        Caption = '&Get from LSV Journal';

                        trigger OnAction()
                        var
                            LsvJournal: Record "LSV Journal";
                        begin

                            LsvJournal.FILTERGROUP := 2;
                            LsvJournal.SETRANGE("LSV Status", LsvJournal."LSV Status"::"File Created");
                            LsvJournal.FILTERGROUP := 0;
                            IF PAGE.RUNMODAL(0, LsvJournal) <> ACTION::LookupOK THEN
                                EXIT;
                            //DYS
                            //CLEAR(LsvMgt);
                            //LsvMgt.LSVJournalToGLJournal(Rec, LsvJournal);
                        end;
                    }
                }
                /* GL2024   group("&ESR")
                 {
                     Caption = '&ESR';

                     action("&Read File")
                     {
                         ApplicationArea = all;
                         Caption = '&Read File';

                         trigger OnAction()
                         begin
                             //DYS
                             // EsrManagement.ImportEsrFile(Rec);
                         end;
                     }
                     action("&Print Journal")
                     {
                         ApplicationArea = all;
                         Caption = '&Print Journal';

                         trigger OnAction()
                         begin
                             //DYS REPORT addon non migrer
                             //REPORT.RUN(REPORT::3010531, TRUE, FALSE, Rec);
                         end;
                     }
                 }*/
                /* GL2024  group(Setup)
                {
                    Caption = 'Setup';

                    action(BVR)
                    {
                        ApplicationArea = all;
                        Caption = 'BVR';
                        //DYS PAGE addon non migrer
                        //  RunObject = Page 3010531;
                    }
                    action(LSV)
                    {
                        ApplicationArea = all;
                        Caption = 'LSV';
                        //DYS PAGE addon non migrer
                        // RunObject = Page 3010831;
                    }
                }*/
            }
        }
        addafter(Reconcile_Promoted)
        {
            group("&E-Payment1")
            {

                Caption = '&E-Payment';
                group("&LSV1")
                {
                    Caption = '&LSV';
                    actionref("&Get from LSV Journal1"; "&Get from LSV Journal")
                    {

                    }
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        lGenJournalTemplate: Record "Gen. Journal Template";
        lBankAccount: Record "Bank Account";
        lBillBankAcct: Boolean;
        lGLSetup: Record "General Ledger Setup";
        lClassicVisible: Boolean;
    begin

        //+PMT+PAYMENT
        xRec."Document Type" := xRec."Document Type"::Payment;
        xRec."Account Type" := xRec."Account Type"::Customer;
        rec."Journal Template Name" := rec.GETRANGEMIN("Journal Template Name");
        lBillBankAcct :=
          lGenJournalTemplate.GET(rec."Journal Template Name") AND
          (lGenJournalTemplate."Bal. Account Type" = lGenJournalTemplate."Bal. Account Type"::"Bank Account") AND
          lBankAccount.GET(lGenJournalTemplate."Bal. Account No.") AND
          (lBankAccount."Bank Type" = lBankAccount."Bank Type"::Receivable);
        //#NAV 2009 - RTC
        lClassicVisible := lBillBankAcct;
        "Bill TypeVISIBLE" := (lClassicVisible);
        lClassicVisible := lBillBankAcct;
        "Payment Bank AccountVISIBLE" := (lClassicVisible);
        lClassicVisible := lBillBankAcct;
        "Due DateVISIBLE" := (lClassicVisible);
        //#NAV 2009 - RTC//
        //+PMT+PAYMENT//
        //+CH2800
        lGLSetup.GET;
        //TRS-2009
        lBillBankAcct := lGLSetup.Localization = lGLSetup.Localization::CH;
        btnElectronicPaymentVISIBLE := (lBillBankAcct);
        //TRS-2009/
        //+CH2800//
    end;

    PROCEDURE wSearchIBAN(): Text[50];
    VAR
        lCustBankAccount: Record "Customer Bank Account";
        lVendBankAccount: Record "Vendor Bank Account";
    BEGIN
        //+PMT+PAYMENT
        IF rec."Account Type" = rec."Account Type"::Customer THEN BEGIN
            IF lCustBankAccount.GET(rec."Account No.", rec."Payment Bank Account") THEN BEGIN
                EXIT(lCustBankAccount.IBAN);
            END;
        END
        ELSE
            IF rec."Account Type" = rec."Account Type"::Vendor THEN BEGIN
                IF lVendBankAccount.GET(rec."Account No.", rec."Payment Bank Account") THEN BEGIN
                    EXIT(lVendBankAccount.IBAN);
                END;
            END;
        //+PMT+PAYMENT//
    END;

    var


        tAvoid: label 'Void DirectDebit %1?';
        //DYS cdu n'existe pas dans NAV
        // LsvMgt: Codeunit 70831;
        //EsrManagement: Codeunit 70531;
        //DYS REPORT addon non migrer
        //  CreateRecapitulation2: Report 8004113;

        //  GL2024
        "Bill TypeVISIBLE": Boolean;
        "Payment Bank AccountVISIBLE": Boolean;
        "Due DateVISIBLE": Boolean;
        btnElectronicPaymentVISIBLE: Boolean;
}

