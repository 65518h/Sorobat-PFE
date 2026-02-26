Report 52048949 "MAJ  de Souche 2024"
{
    // il faut le lancer avec le filtre 01/01/15..31/12/15 sur le champ "Starting Date"

    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("No. Series Line"; "No. Series Line")
        {
            DataItemTableView = where("Starting Date" = filter(<> ''));
            RequestFilterFields = "Series Code", "Starting Date";
            column(ReportForNavId_9252; 9252)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(No__Series_Line__Series_Code_; "Series Code")
            {
            }
            column(No__Series_Line__Line_No__; "Line No.")
            {
            }
            column(No__Series_Line__Starting_Date_; "Starting Date")
            {
            }
            column(No__Series_Line__Starting_No__; "Starting No.")
            {
            }
            column(No__Series_LineCaption; No__Series_LineCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No__Series_Line__Series_Code_Caption; FieldCaption("Series Code"))
            {
            }
            column(No__Series_Line__Line_No__Caption; FieldCaption("Line No."))
            {
            }
            column(No__Series_Line__Starting_Date_Caption; FieldCaption("Starting Date"))
            {
            }
            column(No__Series_Line__Starting_No__Caption; FieldCaption("Starting No."))
            {
            }

            trigger OnAfterGetRecord()
            begin
                if StrPos("No. Series Line"."Starting No.", '25') < 1 then
                    CurrReport.Skip;

                PosAP := StrPos("No. Series Line"."Starting No.", '25');

                NSerieLine.Reset;
                NSerieLine.SetFilter(NSerieLine."Series Code", "No. Series Line"."Series Code");
                NSerieLine.Find('+');
                NumLig := NSerieLine."Line No.";
                NSerieLine.Init;
                NSerieLine."Series Code" := "No. Series Line"."Series Code";
                NSerieLine."Line No." := NumLig + 10000;

                NSerieLine."Starting Date" := CalcDate('1A', "No. Series Line"."Starting Date");
                CodNA := DelStr("No. Series Line"."Starting No.", PosAP, 2);

                CodNA := InsStr(CodNA, '26', PosAP);


                NSerieLine."Starting No." := CodNA;
                if NSerieLine.Insert then;
            end;

            trigger OnPreDataItem()
            begin
                //NSerieLine.SETRANGE(NSerieLine."Starting Date",20190101D,20193112D);
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
        NSerieLine: Record "No. Series Line";
        NumLig: Integer;
        PosAP: Integer;
        CodNA: Code[20];
        No__Series_LineCaptionLbl: label 'No. Series Line';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}

