report 52048906 "Extrait Frs Par Seq. Lettrage"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ExtraitFrsParSeqLettrage.rdlc';

    dataset
    {
        dataitem(VendorLedgerEntry1; "Vendor Ledger Entry")
        {
            CalcFields = "Amount (LCY)";
            DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code");
            RequestFilterFields = "Vendor No.", "Entry No.", "Closed by Entry No.", Open, Lettre, "Posting Date", "Document No.";
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(Vendor_Address; Vendor.Address)
            {
            }
            column(Vendor__VAT_Registration_No__; Vendor."VAT Registration No.")
            {
            }
            column(Vendor__No__; Vendor."No.")
            {
            }
            column(VendorLedgerEntry1__Entry_No__; "Entry No.")
            {
            }
            column(VendorLedgerEntry1__Posting_Date_; "Posting Date")
            {
            }
            column(VendorLedgerEntry1__Document_Type_; "Document Type")
            {
            }
            column(VendorLedgerEntry1__Due_Date_; "Due Date")
            {
            }
            column(VendorLedgerEntry1__External_Document_No__; "External Document No.")
            {
            }
            column(VendorLedgerEntry1_Lettre; Lettre)
            {
            }
            column(VendorLedgerEntry1__Document_No__; "Document No.")
            {
            }
            column(VendorLedgerEntry1__Debit_Amount__LCY__; "Debit Amount (LCY)")
            {
            }
            column(VendorLedgerEntry1__Credit_Amount__LCY__; "Credit Amount (LCY)")
            {
            }
            column(Cumul; Cumul)
            {
                DecimalPlaces = 3 : 3;
            }
            column(Let; Let)
            {
            }
            column(N_Caption; N_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column("PiéceCaption"; PiéceCaptionLbl)
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
            column(SoldeCaption; SoldeCaptionLbl)
            {
            }
            column(N__DOC_EXTERNECaption; N__DOC_EXTERNECaptionLbl)
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
            trigger OnAfterGetRecord()
            var
                fefef: Report 4;
            begin

                IF Vendor.GET("Vendor No.") THEN;

                Solde += "Amount (LCY)";
                Cumul += -"Amount (LCY)";
                IF "Closed by Entry No." = 0 THEN BEGIN
                    "Closed by Entry No." := "Entry No.";
                    Let := '';
                END
                ELSE
                    Let := '';
                CALCFIELDS("Debit Amount", "Credit Amount");
                MakeExcelDataHeader;
            end;

            trigger OnPreDataItem()
            begin
                IF LetrrerSeulement THEN SETFILTER(Lettre, '<>%1', '');
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

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelbook;
    end;

    var
  
        Vendor: Record 23;
        Solde: Decimal;
        Cumul: Decimal;
        Origine: Text[1];
        TxtSolde: Text[30];
        Sequence: Integer;
        Let: Text[1];
        LetrrerSeulement: Boolean;
        ExcelBuf: Record 370 temporary;
        PrintToExcel: Boolean;
        RecVendor: Record 23;
        N_CaptionLbl: Label 'N°';
        DateCaptionLbl: Label 'Date';
        "PiéceCaptionLbl": Label 'Piéce';
        N__PieceCaptionLbl: Label 'N° Piece';
        LettrageCaptionLbl: Label 'Lettrage';
        CreditCaptionLbl: Label 'Credit';
        SoldeCaptionLbl: Label 'Solde';
        N__DOC_EXTERNECaptionLbl: Label 'N° DOC EXTERNE';
        EcheanceCaptionLbl: Label 'Echeance';
        "DébitCaptionLbl": Label 'Débit';
        EXTRAIT_DE_COMPTECaptionLbl: Label 'EXTRAIT DE COMPTE';


    procedure MakeExcelDataBody()
    begin

        ExcelBuf.NewRow;
        IF RecVendor.GET(VendorLedgerEntry1."Vendor No.") THEN;
        ExcelBuf.AddColumn(VendorLedgerEntry1."Entry No.", FALSE, '', TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(VendorLedgerEntry1."Vendor No.", FALSE, '', TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(RecVendor.Name, FALSE, '', TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(VendorLedgerEntry1."Posting Date", FALSE, '', TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(VendorLedgerEntry1."Document Type", FALSE, '', TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(VendorLedgerEntry1."Document No.", FALSE, '', TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(VendorLedgerEntry1."Due Date", FALSE, '', TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(VendorLedgerEntry1."External Document No.", FALSE, '', TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(VendorLedgerEntry1.Lettre, FALSE, '', TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(VendorLedgerEntry1."Debit Amount", FALSE, '', TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(VendorLedgerEntry1."Credit Amount", FALSE, '', TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(Cumul, FALSE, '', TRUE, FALSE, FALSE, '', 0);
    end;


    procedure MakeExcelDataHeader()
    begin

        ExcelBuf.AddColumn('N°', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Code Fournisseur', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Nom Fournisseur', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Date', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Type Piece', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('N° Piece', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Echeance', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('N° Dec Externe', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Lettrage', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Debit', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Credit', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Solde"', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    end;


    procedure MakeExcelInfo()
    begin
    end;


    procedure CreateExcelbook()
    begin

        ExcelBuf.CreateNewBook('INVENTAIRE STOCK');
        // ExcelBuf.CreateSheet('INVENTAIRE STOCK', '', COMPANYNAME, USERID);
        // ExcelBuf.GiveUserControl;
    end;
}

