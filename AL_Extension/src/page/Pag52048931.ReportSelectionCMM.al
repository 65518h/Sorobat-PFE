Page 52048931 "Report Selection - CMM"
{//GL2024  ID dans Nav 2009 : "39002141"
    Caption = 'Report Selection - CMM';
    PageType = list;
    SaveValues = true;
    SourceTable = "Report Selections";
    SourceTableView = where(Usage = filter('Invt. Period Test' | 'SM.Shipment' | 'S.Test Prepmt.'));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(ReportUsage2; ReportUsage2)
            {
                ApplicationArea = Basic;
                Caption = 'Usage';
                OptionCaption = 'Work Order,Work Sheet,Intervention Request';

                trigger OnValidate()
                begin
                    SetUsageFilter;
                    ReportUsage2OnAfterValidate;
                end;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = Basic;
                }
                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = Basic;
                    LookupPageID = Objects;
                }
                field("Report Name"; REC."Report Caption")
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.NewRecord;
    end;

    trigger OnOpenPage()
    begin
        SetUsageFilter;
    end;

    var
        ReportUsage2: Option WO,WS,IR;

    local procedure SetUsageFilter()
    begin
        Rec.FilterGroup(2);
        case ReportUsage2 of
            Reportusage2::WO:
                Rec.SetRange(Usage, Rec.Usage::"Invt.Period Test");
            Reportusage2::WS:
                Rec.SetRange(Usage, Rec.Usage::"SM.Shipment");
            Reportusage2::IR:
                Rec.SetRange(Usage, Rec.Usage::"S.Test Prepmt.");
        end;
        Rec.FilterGroup(0);
    end;

    local procedure ReportUsage2OnAfterValidate()
    begin
        CurrPage.Update;
    end;
}

