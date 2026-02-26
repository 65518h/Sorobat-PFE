PageExtension 50019 "Vendor Ledger Entries_PagEXT" extends "Vendor Ledger Entries"
{
    layout
    {
        modify("Posting Date")
        {
            Editable = false;
        }
        modify("Document Type")
        {
            Editable = false;
        }
        modify("Document No.")
        {
            Editable = false;
        }
        modify("External Document No.")
        {
            Editable = false;
        }
        modify("Document Date")
        {

            Visible = false;
        }
        modify("Vendor No.")
        {
            Editable = false;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Global Dimension 1 Code")
        {
            Visible = false;
            Editable = false;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = false;
            Editable = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
            Editable = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
            Editable = false;
        }
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }

        addafter(Description)
        {

            field("Debit Amount1"; Rec."Debit Amount")
            {
                ApplicationArea = all;
            }
            field("Credit Amount1"; Rec."Credit Amount")
            {
                ApplicationArea = all;
            }
            /* field("Etat Facture"; Rec."Etat Facture")
             {
                 ApplicationArea = all;
             }
             field("Due Date"; Rec."Due Date")
             {
                 ApplicationArea = all;
             }*/
            field("Statut Facture"; Rec."Statut Facture")
            {
                ApplicationArea = all;
                Editable = false;
            }
            //   field("Date Vérification"; Rec."Date Vérification") { ApplicationArea = all; }
            /* field("Date Préparation Payement"; Rec."Date Préparation Payement")
             {
                 ApplicationArea = all;
             }
             field("Date En Cours Signature"; Rec."Date En Cours Signature")
             {
                 ApplicationArea = all;
             }
             field("Date Signature"; Rec."Date Signature")
             {
                 ApplicationArea = all;
             }
             field("Date Paiement"; Rec."Date Paiement")
             {

                 ApplicationArea = all;
             }*/
            field("Due Date2"; Rec."Due Date")
            {
                ApplicationArea = all;
            }
            field("Nbr Jours Date Ech-Cpt"; Rec."Due Date" - rec."Posting Date")
            {
                ApplicationArea = all;
            }
            field(Lettre; Rec.Lettre)
            {
                ApplicationArea = all;
            }
        }
        addafter("Purchaser Code")
        {
            field("Job No."; Rec."Job No.")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }
        addafter("Entry No.")
        {
            /*    field("Code Lettrage"; Rec."Code Lettrage")
                {
                    ApplicationArea = all;
                }*/
            field("Credit Amount2"; Rec."Credit Amount")
            {
                ApplicationArea = all;
            }
            /*      field("Folio N°"; Rec."Folio N°")
                  {
                      ApplicationArea = all;
                      Editable = FALSE;

                  }
                  field(Simulation; Rec.Simulation)
                  {
                      ApplicationArea = all;

                  }
                  field("Commande N°"; Rec."Commande N°")
                  {
                      ApplicationArea = all;
                      Editable = false;
                  }*/
            /*field("Facture N°"; Rec."Facture N°")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Folio N° RS"; Rec."Folio N° RS")
            {
                ApplicationArea = all;
                Editable = false;
            }*/
        }
        addafter(Control1)
        {
            group(DecMontantSelect2)
            {
                ShowCaption = false;
                field(DecMontantSelect; DecMontantSelect)
                {
                    ShowCaption = false;
                    //Caption = 'DecMontantSelect';
                    ApplicationArea = all;
                }
            }
        }



    }
    actions
    {
        modify(AppliedEntries)
        {
            trigger OnBeforeAction()
            begin

                // RB SORO 01/04/2016 SIMULATION FACTURE ACHAT
                /* CurrPage.SETSELECTIONFILTER(RecVendorLedgerEntry);
                 IF RecVendorLedgerEntry.FINDFIRST THEN BEGIN
                     IF RecVendorLedgerEntry.Simulation THEN
                         ERROR(Text001);
                 END;*/
                // RB SORO 01/04/2016 SIMULATION FACTURE ACHAT

            end;
        }
        addafter("Ent&ry")
        {
            action("Wor&Kflow")
            {
                ApplicationArea = all;
                Caption = 'Wor&Kflow';
                trigger OnAction()
                VAR
                    lRecordRef: RecordRef;
                    lWorkflowConnector: Codeunit "Workflow Connector";
                    lPurchInvHeader: Record "Purch. Inv. Header";
                    lPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
                begin
                    //#8804
                    //TESTFIELD("Document Type","Document Type"::Invoice);
                    //lPurchInvHeader.GET("Document No.");
                    //lRecordRef.GETTABLE(lPurchInvHeader);
                    //lWorkflowConnector.OnPush(FORM::"Posted Purchase Invoice",lRecordRef);
                    IF (rec."Document Type" <> rec."Document Type"::Invoice) AND (rec."Document Type" <> rec."Document Type"::"Credit Memo") THEN
                        rec.FIELDERROR("Document Type");
                    IF rec."Document Type" = rec."Document Type"::Invoice THEN BEGIN
                        lPurchInvHeader.GET(rec."Document No.");
                        lRecordRef.GETTABLE(lPurchInvHeader);
                        lWorkflowConnector.OnPush(PAGE::"Posted Purchase Invoice", lRecordRef)
                    END ELSE BEGIN
                        lPurchCrMemoHeader.GET(rec."Document No.");
                        lRecordRef.GETTABLE(lPurchCrMemoHeader);
                        lWorkflowConnector.OnPush(PAGE::"Posted Purchase Credit Memo", lRecordRef);
                    END;
                    //#8804//
                end;
            }
            action("Calculer La Selection")
            {
                ApplicationArea = all;
                Caption = 'Calculer La Selection';

                trigger OnAction()
                begin
                    // RB SORO 15/04/2016
                    DecMontantSelect := 0;
                    CurrPage.SETSELECTIONFILTER(RecVendorLedgerEntryCalc);
                    IF RecVendorLedgerEntryCalc.FINDFIRST THEN
                        REPEAT
                            RecVendorLedgerEntryCalc.CALCFIELDS("Remaining Amount");
                            DecMontantSelect += RecVendorLedgerEntryCalc."Remaining Amount";
                        UNTIL RecVendorLedgerEntryCalc.NEXT = 0;
                    // RB SORO 15/04/2016
                end;
            }
        }
        addafter(Category_Category5)
        {
            actionref("Wor&Kflow1"; "Wor&Kflow")
            {

            }
            actionref("Calculer La Selection1"; "Calculer La Selection")
            {

            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        IF rec."Posting Date" < 20150101D THEN BEGIN
            IF rec."Remaining Amount" = 0 THEN rec."Statut Facture" := 4;
        END;
        IF rec."Document Type" <> rec."Document Type"::Invoice THEN
            rec."Statut Facture" := 5;
    end;

    var
        RecVendorLedgerEntry: Record "Vendor Ledger Entry";
        RecVendorLedgerEntryCalc: Record "Vendor Ledger Entry";
        DecMontantSelect: Decimal;
        Text001: Label 'You cannot reconcile an invoice in simulation status !!!';
}


