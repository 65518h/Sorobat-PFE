PageExtension 50163 "Job Queue Entry Card_PagEXT" extends "Job Queue Entry Card"
{

    layout
    {
        addafter("No. of Minutes between Runs")
        {
            field(Periodicity; Rec.Periodicity)
            {
                ApplicationArea = all;
            }
        }


    }
    actions
    {
        addafter("Set On Hold")
        {
            action(History)
            {
                Caption = 'History';
                ApplicationArea = all;
                RunObject = Page "Job Queue Log Entries";
                RunPageView = SORTING(ID);
                RunPageLink = ID = FIELD(ID);
            }
        }
        addafter("Set On Hold_Promoted")
        {
            actionref(History1; History)
            {

            }
        }
    }

    var

}
