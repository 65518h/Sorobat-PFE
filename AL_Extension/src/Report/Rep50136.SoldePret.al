report 50136 "Solde Pret"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SoldePret.rdlc';

    dataset
    {
        dataitem("G/L Entry"; 17)
        {
            DataItemTableView = SORTING(salarie)
                                WHERE("G/L Account No." = CONST('51600000'));
            PrintOnlyIfDetail = false;
            RequestFilterFields = salarie;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(G_L_Entry_Amount; Amount)
            {
            }
            column(Employee__No__________Employee__First_Name_; Employee."No." + '  ' + Employee."First Name")
            {
            }
            column(G_L_EntryCaption; G_L_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("SalariéCaption"; SalariéCaptionLbl)
            {
            }
            column(SoldeCaption; SoldeCaptionLbl)
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }
            column(G_L_Entry_salarie; salarie)
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF CurrReport.TOTALSCAUSEDBY = "G/L Entry".FIELDNO(salarie) THEN
                    IF Employee.GET(salarie) THEN;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(salarie);
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
        TotalFor: Label 'Total ';
        Employee: Record 5200;
        G_L_EntryCaptionLbl: Label 'SUIVI SOLDE PRET';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "SalariéCaptionLbl": Label 'Salarié';
        SoldeCaptionLbl: Label 'Solde';
}

