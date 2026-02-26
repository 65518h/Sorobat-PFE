PageExtension 50273 "Payment Line Modifi_PagEXT" extends "Payment Line Modification"
{
    layout
    {
        addafter("RIB Checked")
        {
            field("Affectation Financiere"; rec."Affectation Financiere")
            {
                ApplicationArea = all;
            }


            field(Commentaires; rec.Commentaires)
            {
                ApplicationArea = all;
            }

            field("Montant TVA sur Commission"; rec."Montant TVA sur Commission")
            {
                ApplicationArea = all;
            }

            field("Montant Commission"; rec."Montant Commission")
            {
                ApplicationArea = all;
            }
            field("intérêt FED"; rec."intérêt FED")
            {
                ApplicationArea = all;

            }
            field("intérêt FED (DS)"; rec."intérêt FED (DS)")
            {
                ApplicationArea = all;

            }
            field("intérêt Escompte"; rec."intérêt Escompte")
            {
                ApplicationArea = all;

            }
            field("intérêt Escompte (DS)"; rec."intérêt Escompte (DS)")
            {
                ApplicationArea = all;

            }
            field("intérêt sur Prêt"; rec."Intérêt sur Prêt")
            {
                ApplicationArea = all;

            }
            field("intérêt sur Prêt (DS)"; rec."Intérêt sur Prêt (DS)")
            {
                ApplicationArea = all;

            }
        }
    }

}