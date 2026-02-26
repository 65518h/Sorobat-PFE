report 52048883 "Tableau Amortissement Prêt @"
{
    //GL2024  ID dans Nav 2009 : "39001407"
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TableauAmortissementPrêt.rdlc';

    dataset
    {
        dataitem("Loan & Advance"; "Loan & Advance")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Loan___Advance__N__document_Extr__; "N° document Extr.")
            {
            }
            column(Loan___Advance_Name; Name)
            {
            }
            column(Loan___Advance__Document_type_; "Document type")
            {
            }
            column(Loan___Advance__Date_d_effet_; "Date d'effet")
            {
            }
            column(Loan___Advance_Amount; Amount)
            {
            }
            column(Loan___Advance__Interest___; "Interest %")
            {
            }
            column(Loan___Advance__Repayment_slices_; "Repayment slices")
            {
            }
            column(Loan___Advance_Employee; Employee)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loan___AdvanceCaption; Loan___AdvanceCaptionLbl)
            {
            }
            column(Loan___Advance__N__document_Extr__Caption; FIELDCAPTION("N° document Extr."))
            {
            }
            column(Loan___Advance__Document_type_Caption; FIELDCAPTION("Document type"))
            {
            }
            column("Date_décision__Caption"; Date_décision__CaptionLbl)
            {
            }
            column("Montant_Prêt__Caption"; Montant_Prêt__CaptionLbl)
            {
            }
            column(Loan___Advance__Interest___Caption; FIELDCAPTION("Interest %"))
            {
            }
            column(Loan___Advance__Repayment_slices_Caption; FIELDCAPTION("Repayment slices"))
            {
            }
            column(Loan___Advance_EmployeeCaption; FIELDCAPTION(Employee))
            {
            }
            column(Loan___Advance_No_; "No.")
            {
            }
            dataitem(Integer; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(DateEch; DateEch)
                {
                }
                column(MntRest; MntRest)
                {
                    AutoFormatType = 2;
                }
                column(MntRet; MntRet)
                {
                    AutoFormatType = 2;
                }
                column(MntInt; MntInt)
                {
                    AutoFormatType = 2;
                }
                column(MntRet_MntInt; MntRet + MntInt)
                {
                    AutoFormatType = 2;
                }
                column(Cumul; Cumul)
                {
                    AutoFormatType = 2;
                }
                column(TotMntRet_TotMntInt; TotMntRet + TotMntInt)
                {
                    AutoFormatType = 2;
                }
                column(TotMntInt; TotMntInt)
                {
                    AutoFormatType = 2;
                }
                column(TotMntRet; TotMntRet)
                {
                    AutoFormatType = 2;
                }
                column(CumulCaption; CumulCaptionLbl)
                {
                }
                column(PRIN___INTCaption; PRIN___INTCaptionLbl)
                {
                }
                column(INTERETCaption; INTERETCaptionLbl)
                {
                }
                column(PRINCIPALCaption; PRINCIPALCaptionLbl)
                {
                }
                column(K_RES_DUCaption; K_RES_DUCaptionLbl)
                {
                }
                column("EchéanceCaption"; EchéanceCaptionLbl)
                {
                }
                column(TOTAL__Caption; TOTAL__CaptionLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    MntRest := MntRest - MntRet;
                    MntRet := 0;
                    MntRet := ROUND(MntRest / ("Loan & Advance"."Repayment slices" - (Number - 1)), 0.001);
                    MntInt := 0;
                    DateEch := CALCDATE('+1J', DateEch);
                    MntInt := ROUND("Loan & Advance".CalcMntInetretReport(DateEch, CALCDATE('+FM', DateEch)), 0.001);
                    DateEch := CALCDATE('+FM', DateEch);
                    TotMntRet := TotMntRet + MntRet;
                    TotMntInt := TotMntInt + MntInt;
                    Cumul := Cumul + MntRet + MntInt;
                end;

                trigger OnPreDataItem()
                begin
                    IF ("Loan & Advance".Type = 0) OR ("Loan & Advance"."Repayment slices" = 0) THEN
                        CurrReport.BREAK;
                    SETFILTER(Number, '1..%1', "Loan & Advance"."Repayment slices");
                    MntRest := "Loan & Advance".Amount;
                    //MBY 25/02/2010
                    //    DateEch:=CALCDATE('-15J+FM',"Loan & Advance"."Date d'effet");
                    DateEch := "Loan & Advance"."Date d'effet";
                    //MBY 25/02/2010
                    // CurrReport.CREATETOTALS(MntInt,MntRet);
                    MntRet := 0;
                    TotMntRet := 0;
                    TotMntInt := 0;
                    Cumul := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        MntRest: Decimal;
        MntRet: Decimal;
        MntInt: Decimal;
        DateEch: Date;
        TotMntRet: Decimal;
        TotMntInt: Decimal;
        Cumul: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Loan___AdvanceCaptionLbl: Label 'Tableau d''amortissement';
        "Date_décision__CaptionLbl": Label 'Date décision :';
        "Montant_Prêt__CaptionLbl": Label 'Montant Prêt :';
        CumulCaptionLbl: Label 'Cumul';
        PRIN___INTCaptionLbl: Label 'PRIN + INT';
        INTERETCaptionLbl: Label 'INTERET';
        PRINCIPALCaptionLbl: Label 'PRINCIPAL';
        K_RES_DUCaptionLbl: Label 'K.RES.DU';
        "EchéanceCaptionLbl": Label 'Echéance';
        TOTAL__CaptionLbl: Label 'TOTAL :';
}

