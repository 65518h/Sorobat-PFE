page 52048908 "Détail Heures sup. enreg."
{
    //GL2024  ID dans Nav 2009 : "39001429"
    Editable = false;
    PageType = List;
    SourceTable = "Heures sup. eregistrées m";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Détail Heures sup. enreg.s';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Salarié"; Rec."N° Salarié")
                {
                    ApplicationArea = Basic;
                }
                field("Nom salarié"; Rec.Prénom + ' ' + Rec."Nom usuel")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Code departement"; Rec."Code departement")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Code dossier"; Rec."Code dossier")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                // field("Nombre Heures Supp"; Rec."Nombre Heures Supp")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Tarif unitaire"; Rec."Tarif unitaire")
                {
                    ApplicationArea = Basic;
                }
                field("Montant Ligne"; Rec."Montant Ligne")
                {
                    ApplicationArea = Basic;
                }
                field("Date comptabilisation"; Rec."Date comptabilisation")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mois de paiement"; Rec."Mois de paiement")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Année de paiement"; Rec."Année de paiement")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

