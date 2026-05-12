report 52048905 "Extrait De Compte Avec Lettrag"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ExtraitDeCompteAvecLettrag.rdl';

    dataset
    {
        dataitem(OrigineE; "Vendor Ledger Entry")
        {
            CalcFields = "Amount (LCY)", "Remaining Amount";
            DataItemTableView = SORTING("Closed by Entry No.")
                                WHERE("Closed by Entry No." = CONST(0));
            RequestFilterFields = "Vendor No.", "Entry No.", "Closed by Entry No.", "External Document No.";
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(Vendor_Address; Vendor.Address)
            {
            }
            column(Vendor__VAT_Registration_No__; Vendor."VAT Registration No.")
            {
            }
            column(OrigineE__Entry_No__; "Entry No.")
            {
            }
            column(OrigineE__Posting_Date_; "Posting Date")
            {
            }
            column(OrigineE__Due_Date_; "Due Date")
            {
            }
            column(OrigineE__Document_No__; "Document No.")
            {
            }
            column(OrigineE__Debit_Amount__LCY__; "Debit Amount (LCY)")
            {
            }
            column(OrigineE__Credit_Amount__LCY__; "Credit Amount (LCY)")
            {
            }
            column(OrigineE_Description; Description)
            {
            }
            column(ABS__Remaining_Amount__; ABS("Remaining Amount"))
            {
            }
            column(N_Caption; N_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(N__PieceCaption; N__PieceCaptionLbl)
            {
            }
            column(LettrageCaption; LettrageCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(EcheanceCaption; EcheanceCaptionLbl)
            {
            }
            column("DébitCaption"; DébitCaptionLbl)
            {
            }
            column(EXTRAIT_DE_COMPTECaption; EXTRAIT_DE_COMPTECaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(SoldeCaption; SoldeCaptionLbl)
            {
            }
            dataitem(Lettrage; "Vendor Ledger Entry")
            {
                CalcFields = "Amount (LCY)", "Remaining Amount";
                DataItemLink = "Closed by Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Closed by Entry No.");
                column(Lettrage__Posting_Date_; "Posting Date")
                {
                }
                column(Lettrage__Due_Date_; "Due Date")
                {
                }
                column(Lettrage__Document_No__; "Document No.")
                {
                }
                column(Lettrage__Debit_Amount__LCY__; "Debit Amount (LCY)")
                {
                }
                column(Lettrage__Credit_Amount__LCY__; "Credit Amount (LCY)")
                {
                }
                column(Lettrage_Description; Description)
                {
                }
                column(Lettrage__Closed_by_Entry_No__; "Closed by Entry No.")
                {
                }
                column(ABS__Remaining_Amount___Control1000000035; ABS("Remaining Amount"))
                {
                }
                column(Lettrage_Entry_No_; "Entry No.")
                {
                }
                dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Closed by Entry No." = FIELD("Entry No.");
                    column(Vendor_Ledger_Entry__Posting_Date_; "Posting Date")
                    {
                    }
                    column(Vendor_Ledger_Entry__Due_Date_; "Due Date")
                    {
                    }
                    column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(Vendor_Ledger_Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                    {
                    }
                    column(Vendor_Ledger_Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                    {
                    }
                    column(Vendor_Ledger_Entry_Description; Description)
                    {
                    }
                    column(Vendor_Ledger_Entry__Closed_by_Entry_No__; "Closed by Entry No.")
                    {
                    }
                    column(ABS__Remaining_Amount___Control1000000041; ABS("Remaining Amount"))
                    {
                    }
                    column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                var
                begin
                    CALCFIELDS("Remaining Amount");
                end;
            }
            trigger OnAfterGetRecord()
            begin
                IF Vendor.GET("Vendor No.") THEN;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        VendorLedgerEntry: Record 25;
        VendorLedgerEntry2: Record 25;
        Vendor: Record 23;
        Solde: Decimal;
        Cumul: Decimal;
        Origine: Text[1];
        TxtSolde: Text[30];
        N_CaptionLbl: Label 'N°';
        DateCaptionLbl: Label 'Date';
        N__PieceCaptionLbl: Label 'N° Piece';
        LettrageCaptionLbl: Label 'Lettrage';
        CreditCaptionLbl: Label 'Credit';
        EcheanceCaptionLbl: Label 'Echeance';
        "DébitCaptionLbl": Label 'Débit';
        EXTRAIT_DE_COMPTECaptionLbl: Label 'EXTRAIT DE COMPTE';
        DescriptionCaptionLbl: Label 'Description';
        SoldeCaptionLbl: Label 'Solde';
}

