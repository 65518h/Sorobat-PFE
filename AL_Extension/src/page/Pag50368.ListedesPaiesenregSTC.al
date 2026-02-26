page 50368 "Liste des Paies enreg. STC"
{//GL2024  ID dans Nav 2009 : "39001463"
    Caption = 'Liste des Paies enreg. STC';
    Editable = false;
    PageType = List;
    SourceTable = "Rec. Salary Headers";
    //ABZ ApplicationArea = all;
    UsageCategory = Lists;
    CardPageId = "Recorded Payment List";
    // SourceTableView = SORTING("Posting Date", "No.") WHERE(STC = CONST(true));
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'N°';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mois';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic;
                    Caption = 'Année';
                }

            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

