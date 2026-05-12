page 52049054 "WIP Report Line Archive"
{
    PageType = ListPart;
    //ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = "WIP Report Line";
    caption = 'WIP Report Lines Archive';
    AutoSplitKey = true;
    // DelayedInsert = true;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
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
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;

                }
                field("DysJob Planning Line No."; Rec."DysJob Planning Line No.") { ApplicationArea = all; }
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
                field(Bin; Rec.Bin) { ApplicationArea = all; }
                field(Quantity; Rec.Quantity)
                {

                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                    end;

                }
                field("Resource Number"; Rec."Resource Number") { ApplicationArea = all; }
                field("Executed measurement"; Rec."Executed measurement") { ApplicationArea = all; }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;

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

}