page 52049043 "Ligne rapport Chantier MO"
{
    //  id dans nav"39004766"
    PageType = Card;
    SourceTable = "Ligne Rapport Chantier";
    SourceTableView = WHERE(Ressource = CONST(MO));

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                field(MO; rec.MO)
                {
                }
                field("MO Description"; rec."MO Description")
                {
                }
                field("Cout Direct"; rec."Cout Direct")
                {
                }
                field("Nombre Ressource"; rec."Nombre Ressource")
                {
                }
                field("Heure Debut"; rec."Heure Debut")
                {
                }
                field("Heure Fin"; rec."Heure Fin")
                {
                }
                field("Tot Heure"; rec."Tot Heure")
                {
                }
                field(Observation; rec.Observation)
                {
                }
                field(Cout; rec.Cout)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Ressource := rec.Ressource::MO;
    end;
}

