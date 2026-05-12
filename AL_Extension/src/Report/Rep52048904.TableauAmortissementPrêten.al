report 52048904 "Tableau Amortissement Prêt en@"
//Jasser -b 2025  ID dans Nav 2009 : "39001408"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TableauAmortissementPrêten.rdlc';

    dataset
    {
        dataitem("Loan & Advance Header"; 52048889)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Loan___Advance_Header_Amount; Amount)
            {
            }
            column(Loan___Advance_Header__N__document_Extr__; "N° document Extr.")
            {
            }
            column(Loan___Advance_Header__Date_d_effet_; "Date d'effet")
            {
            }
            column(Loan___Advance_Header_Name; Name)
            {
            }
            column(Loan___Advance_Header__Document_type_; "Document type")
            {
            }
            column(Loan___Advance_Header__Interest___; "Interest %")
            {
            }
            column(Loan___Advance_Header__Repayment_slices_; "Repayment slices")
            {
            }
            column(Loan___Advance_Header_Employee; Employee)
            {
            }
            column(Loan___AdvanceCaption; Loan___AdvanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Montant_Prêt__Caption"; Montant_Prêt__CaptionLbl)
            {
            }
            column("Date_décision__Caption"; Date_décision__CaptionLbl)
            {
            }
            column(Loan___Advance_Header__N__document_Extr__Caption; FIELDCAPTION("N° document Extr."))
            {
            }
            column(Loan___Advance_Header__Document_type_Caption; FIELDCAPTION("Document type"))
            {
            }
            column(Loan___Advance_Header__Interest___Caption; FIELDCAPTION("Interest %"))
            {
            }
            column(Loan___Advance_Header__Repayment_slices_Caption; FIELDCAPTION("Repayment slices"))
            {
            }
            column(Loan___Advance_Header_EmployeeCaption; FIELDCAPTION(Employee))
            {
            }
            column(Loan___Advance_Header_No_; "No.")
            {
            }
            dataitem(DataItem5444; 2000000026)
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
                column(DateEchCaption; DateEchCaptionLbl)
                {
                }
                column(MntRestCaption; MntRestCaptionLbl)
                {
                }
                column(MntRetCaption; MntRetCaptionLbl)
                {
                }
                column(MntIntCaption; MntIntCaptionLbl)
                {
                }
                column(MntRet_MntIntCaption; MntRet_MntIntCaptionLbl)
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
                    MntInt := 0;
                    DateEch := CALCDATE('+1J', DateEch);
                    MntRet := ROUND("Loan & Advance Header".CalcMnPrinciPeriode(DateEch, CALCDATE('+FM', DateEch)), 0.001);
                    MntInt := ROUND("Loan & Advance Header".CalcMntInetretReport(DateEch, CALCDATE('+FM', DateEch)), 0.001);
                    DateEch := CALCDATE('+FM', DateEch);
                    TotMntRet := TotMntRet + MntRet;
                    TotMntInt := TotMntInt + MntInt;
                end;

                trigger OnPreDataItem()
                begin
                    IF ("Loan & Advance Header".Type = 0) OR ("Loan & Advance Header"."Repayment slices" = 0) THEN
                        CurrReport.BREAK;
                    SETFILTER(Number, '1..%1', "Loan & Advance Header"."Repayment slices");
                    MntRest := "Loan & Advance Header".Amount;
                    DateEch := CALCDATE('-15J+FM', "Loan & Advance Header"."Date d'effet");
                    // CurrReport.CREATETOTALS(MntInt,MntRet);
                    MntRet := 0;
                    TotMntRet := 0;
                    TotMntInt := 0;
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
        Loan___AdvanceCaptionLbl: Label 'Loan & Advance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "Montant_Prêt__CaptionLbl": Label 'Montant Prêt :';
        "Date_décision__CaptionLbl": Label 'Date décision :';
        DateEchCaptionLbl: Label 'Echéances';
        MntRestCaptionLbl: Label 'K.RES.DU';
        MntRetCaptionLbl: Label 'PRINCIPAL';
        MntIntCaptionLbl: Label 'INTERET';
        MntRet_MntIntCaptionLbl: Label 'PRIN + INT';
        TOTAL__CaptionLbl: Label 'TOTAL :';
}

