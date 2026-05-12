page 52049052 "WIP Report Line"
{
    PageType = ListPart;
    //ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = "WIP Report Line";
    AutoSplitKey = true;
    RefreshOnActivate = true;
    // DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;

                }
                field("DysJob Planning Line No."; Rec."DysJob Planning Line No.") { ApplicationArea = all; Visible = false; }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(Bin; Rec.Bin) { ApplicationArea = all; Visible = false; }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    style = unFavorable;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    style = unFavorable;
                }
                field("Resource Number"; Rec."Resource Number") { ApplicationArea = all; }
                field("Executed measurement"; Rec."Executed measurement")
                {
                    ApplicationArea = all;
                    style = Favorable;
                }
                field(Rec; Rec."Executed Unit of Measure Code")
                {

                    ApplicationArea = All;
                    editable = false;
                    style = Favorable;
                }
                field(Length; Rec.Length)
                {
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Width; Rec.Width)
                {
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Heigth; Rec.Heigth)
                {
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Wip Total Line"; Rec."Wip Total Line")
                {
                    ApplicationArea = all;
                    Visible = false;
                }

            }
        }

    }

    actions
    {
        area(Processing)
        {

        }
    }
    trigger OnAfterGetRecord()
    begin
        rec.CalcFields("Executed Unit of Measure Code");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        RecLWipReportHeader: record "WIP Report Header";
    begin
        RecLWipReportHeader.get(rec."WIP Report No.");
        rec."Job Task No." := RecLWipReportHeader."Job Task No.";
    end;
}