Page 52049013 "Affectation Marche"
{//GL2024  ID dans Nav 2009 : "39004783"
    PageType = List;
    SourceTable = "Affectation Marche";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Marche; Rec.Marche)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CurrPage.Editable(not CurrPage.LookupMode);
        if UserSetup.Get(UpperCase(UserId)) then;
        // if UserSetup."Affaire Par Defaut" <> '' then
        //     Rec.SetFilter(Marche, UserSetup."Affaire Par Defaut" + '*');
    end;

    var
        UserSetup: Record "User Setup";
}

