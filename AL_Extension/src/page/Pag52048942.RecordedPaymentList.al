page 52048942 "Recorded Payment List"
{//GL2024  ID dans Nav 2009 : "39001463"
    Caption = 'Liste des Paies enreg.';
    Editable = false;
    PageType = List;
    SourceTable = "Rec. Salary Headers";
    //ABZApplicationArea = all;
    UsageCategory = Lists;
    CardPageId = "Recorded salaries";
    // SourceTableView = SORTING("Posting Date", "No.") WHERE(STC = CONST(false));
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
                // field(STC; Rec.STC)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'STC';
                // }
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

