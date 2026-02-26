reportextension 50005 "GL Detail Trial Balance Ext" extends "G/L Detail Trial Balance"
{  // RDLCLayout = './Layouts/GLDetailTrialBalanceCopy.rdlc';
    dataset
    {
        add("G/L Account")
        {
            column(FiltreDateCalcCodeunit; FORMAT(FiltreDateCalc)) { }
            column(FYFiscalCloseCodeunit; FORMAT(FYFiscalClose)) { }
            column(CompanyInfoName; CompanyInfo.Name) { }
            column(CompanyInfoAddress; CompanyInfo.Address) { }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyInfoFaxNo; CompanyInfo."Fax No.") { }
            column(CompanyInfoVATRegistrationNo; CompanyInfo."VAT Registration No.") { }
            column(CompanyInfoMatFiscale; CompanyInfo."Matricule Fiscale") { }
            column(FiltreCompteField; FiltreCompte) { }
            column(NoFolioField; NoFolio) { }
            column(ExcelBufField; FORMAT(ExcelBuf)) { }
            column(PrintToExcelField; PrintToExcel) { }
            column(BlankFillerField; BlankFiller) { }
            column(FiltreDateField; FiltreDate) { }
            column(FiltreTypeEcritureField; FiltreTypeEcriture) { }
            column(FiltreTypeOrigineField; FiltreTypeOrigine) { }
            column(FiltreNumOrigineField; FiltreNumOrigine) { }
            column(FiltreCodeJournalField; FiltreCodeJournal) { }
            column(FiltreLettreField; FiltreLettre) { }
            column(FiltreAffichLettrageField; FORMAT(FiltreAffichLettrage)) { }
            column(RecGLEntryEntryNo; RecGLEntry."Entry No.") { }
            column(FiltreCompte; FiltreCompte) { }
            column(Total_Date_Range2CaptionLbl; Total_Date_Range2CaptionLbl)
            {

            }
            column(DescriptionCaption2; DescriptionCaptionLbl2)
            {
            }
            column(debit2; debit2)
            {

            }
            column(credit2; credit2)
            {

            }





        }


        modify("G/L Account")
        {
            trigger OnAfterPreDataItem()
            begin
                StartDate2 := GETRANGEMIN("Date Filter");

                PreviousEndDate2 := CLOSINGDATE(StartDate2 - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate2, TextDate2, StartDate2, 0);
                TextDate2 := CONVERTSTR(TextDate2, '.', ',');
                // FiltreDateCalc.VerifiyDateFilter(TextDate);
                EVALUATE(PreviousStartDate2, TextDate2);
                IF COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' THEN
                    EndDate2 := 0D
                ELSE
                    EndDate2 := GETRANGEMAX("Date Filter");
            end;

            trigger OnBeforePreDataItem()
            begin

                SetRange("Account Type", "G/L Account"."Account Type"::Posting);
            end;

            trigger OnAfterAfterGetRecord()
            begin

                IF "G/L Account".GETFILTER("G/L Account"."No.") <> '' THEN
                    FiltreCompte := "G/L Account".GETFILTER("G/L Account"."No.")
                ELSE
                    FiltreCompte := 'Tous';
                //test
                FiltreDate := GETFILTER("Date Filter");
                CompanyInfo.GET();



                GLAccount22.Copy("G/L Account");
                if GLAccount22."Income/Balance" = 0 then
                    GLAccount22.SetRange("Date Filter", PreviousStartDate2, PreviousEndDate2)
                else
                    GLAccount22.SetRange("Date Filter", 0D, PreviousEndDate2);
                GLAccount22.CalcFields("Debit Amount", "Credit Amount");
                GLAccount22.Balance := GLAccount22."Debit Amount" - GLAccount22."Credit Amount";
                if "Income/Balance" = 0 then
                    SetRange("Date Filter", StartDate2, EndDate2)
                else
                    SetRange("Date Filter", 0D, EndDate2);
                CalcFields("Debit Amount", "Credit Amount");
                if ("Debit Amount" = 0) and ("Credit Amount" = 0) then
                    CurrReport.Skip();



                debit2 += GLAccount22."Debit Amount";
                credit2 += GLAccount22."Credit Amount";

            end;
        }
        // modify(Date)
        // {
        //     trigger OnAfterAfterGetRecord()
        //     begin
        //     end;
        // }

        addafter("G/L Entry")
        {

        }
        add("G/L Entry")
        {
            column(Letter; Letter)
            {

            }
            column(Source_No_; "Source No.")
            {

            }
            column(Folio_N__RS; "Folio N° RS")
            {

            }
        }
        modify("G/L Entry")
        {
            RequestFilterFields = "Source Type", "Source No.", "Source Code", Letter;
            trigger OnAfterAfterGetRecord()
            begin

                // NoFolio := '';
                // RecGLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                // RecGLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                // RecGLEntry.SETFILTER("Folio N°", '<> %1', '');
                // IF RecGLEntry.FINDFIRST THEN
                //     REPEAT
                //         IF RecGLEntry."Folio N°" <> '0' THEN
                //             NoFolio := RecGLEntry."Folio N°";
                //     UNTIL RecGLEntry.NEXT = 0;

                // // RB SORO 17/04/2015

            end;
        }

    }
    /* requestpage
     {
         // Add changes to the requestpage here
         layout
         {
             addbefore(Options)
             {
                 group("Ecriture Comptable")
                 {
                     Caption = 'Ecriture Comptable';
                     field("Type d'origine"; "G/L Entry"."Source Type")
                     {
                         ApplicationArea = Basic, Suite;
                         Caption = 'Type Origine';

                     }
                     field("N° Origine"; "G/L Entry"."Source No.")
                     {
                         ApplicationArea = Basic, Suite;
                         Caption = 'N° Origine';

                     }
                     field("Code Journal"; "G/L Entry"."Source Code")
                     {
                         ApplicationArea = Basic, Suite;
                         Caption = 'Code Journal';

                     }
                     field("Letter"; "G/L Entry"."Letter")
                     {
                         ApplicationArea = Basic, Suite;
                         Caption = 'Letter';

                     }

                 }
             }
         }
     }*/


    trigger OnPreReport()
    begin

        //<< Ajouté MYC 101008

        /*  IF "G/L Account".GETFILTER("G/L Account"."G/L Entry Type Filter") <> '' THEN
              FiltreTypeEcriture := 'Type Ecriture : ' + "G/L Account".GETFILTER("G/L Account"."G/L Entry Type Filter")
          ELSE
              FiltreTypeEcriture := '';*/

        IF "G/L Entry".GETFILTER("G/L Entry"."Source Type") <> '' THEN
            FiltreTypeOrigine := 'Type Origine: ' + "G/L Entry".GETFILTER("G/L Entry"."Source Type")
        ELSE
            FiltreTypeOrigine := '';

        IF "G/L Entry".GETFILTER("G/L Entry"."Source No.") <> '' THEN
            FiltreNumOrigine := 'N° Origine: ' + "G/L Entry".GETFILTER("G/L Entry"."Source No.")
        ELSE
            FiltreNumOrigine := '';

        IF "G/L Entry".GETFILTER("G/L Entry"."Source Code") <> '' THEN
            FiltreCodeJournal := 'Code Journal: ' + "G/L Entry".GETFILTER("G/L Entry"."Source Code")
        ELSE
            FiltreCodeJournal := '';

        IF "G/L Entry".GETFILTER("G/L Entry".Letter) <> '' THEN
            FiltreLettre := 'Lettre: ' + "G/L Entry".GETFILTER("G/L Entry".Letter)
        ELSE
            FiltreLettre := '';


        //>> Ajouté MYC 101008

    end;




    // rendering
    //     {
    //         layout(ReminderExt)
    //         {
    //             Type = RDLC;
    //             LayoutFile = '.rdl';
    //         }
    //     }
    var
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        FYFiscalClose: Codeunit "Fiscal Year-FiscalClose";
        CompanyInfo: Record "Company Information";
        FiltreCompte: Text[30];
        NoFolio: Code[20];
        ExcelBuf: Record "Excel Buffer";
        PrintToExcel: Boolean;
        BlankFiller: Text[250];
        FiltreDate: Text[30];
        FiltreTypeEcriture: Text[100];
        FiltreTypeOrigine: Text[30];
        FiltreNumOrigine: Text[50];
        FiltreCodeJournal: Text[30];
        FiltreLettre: Text[100];
        FiltreAffichLettrage: Option;
        RecGLEntry: Record "G/L Entry";
        Total_Date_Range2CaptionLbl: Label 'Total de la période';
        DescriptionCaptionLbl2: Label 'Libellé écriture';
        debit2: Decimal;
        credit2: Decimal;
        GLAccount22: Record 15;
        TextDate2: Text[30];
        PreviousEndDate2: Date;
        PreviousStartDate2: Date;
        StartDate2: Date;
        EndDate2: Date;

}