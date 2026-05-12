Page 66666 test
{
    PageType = Card;
    Caption = 'Test';

    layout
    {
        area(content)
        {
            field(mois; mois)
            {
                ApplicationArea = Basic;
            }
            field(annee; annee)
            {
                ApplicationArea = Basic;
            }
            field(restmois; restmois)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Contrôle1000000000)
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    compteur := 0;
                    if recdev.FindLast then
                        repeat
                            compteur += 1;
                            if recdev.Count < 6 then fincomptage := recdev.Count;
                            codeart := rec27."No.";
                            Message(Format(recdev.Next));
                        until (recdev.Next(-1) = 0) or (compteur >= fincomptage);
                end;
            }
            action(Contrôle1000000001)
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    annee := mois DIV 12;
                    restmois := mois - annee * 12;
                end;
            }
        }
    }

    var
        rec27: Record 27;
        codeart: Code[20];
        compteur: Integer;
        int: Integer;
        recdev: Record 4;
        fincomptage: Integer;
        mois: Integer;
        annee: Integer;
        restmois: Integer;
}

