report 8003989 "Set New Completion"
{
    // //PROJET_FACT GESWAY 03/03/03 Renseigner un nouveau % avancement sur les lignes vente

    Caption = 'Set New Completion';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = SORTING("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.") WHERE("Document Type" = CONST(Order));

            trigger OnAfterGetRecord()
            begin
                IF NewProduction <> 0 THEN
                    Completion.UpdateLine("Sales Line", NewProduction = 100, 6, 0, NewProduction);
                IF "Sales Line"."Line Type" = "Sales Line"."Line Type"::Totaling THEN
                    Completion.TotalingLine(
                       0, NewProduction, "Sales Line"."Document No.", "Sales Line"."Line No.", "Sales Line"."Presentation Code");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NewProduction; NewProduction)
                    {
                        BlankZero = true;
                        Caption = 'New production (%)';
                        MaxValue = 100;
                        MinValue = 0;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        NewProduction: Decimal;
        Completion: Page 50354;
}

