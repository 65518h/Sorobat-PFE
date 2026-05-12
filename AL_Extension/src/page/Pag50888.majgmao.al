Page 50888 "maj gmao"
{
    PageType = Card;
    Caption = 'maj gmao';
    ApplicationArea = all;
    layout
    {
    }

    actions
    {
        area(processing)
        {
            action(Action1000000000)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    vehic.SetRange(vehic."N° Vehicule", 'BD-001');
                    //if vehic.FindFirst then cdugmao.AlerteDelai(vehic);
                end;
            }
        }
    }

    var
        vehic: Record "Véhicule";
        cdugmao: Codeunit "Soroubat cdu";
}

