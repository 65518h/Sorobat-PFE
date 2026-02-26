Page 50033 "Liste PV Reception"
{
    Editable = false;
    PageType = List;
    SourceTable = "PV Reception";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Liste PV Reception';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Commande"; rec."N° Commande")
                {
                    ApplicationArea = all;
                }
                field("N° Article"; rec."N° Article")
                {
                    ApplicationArea = all;
                }
                field("Date Commande"; rec."Date Commande")
                {
                    ApplicationArea = all;
                }
                field("Lieu De Chargement"; rec."Lieu De Chargement")
                {
                    ApplicationArea = all;
                }
                field("N° BL Fournisseur"; rec."N° BL Fournisseur")
                {
                    ApplicationArea = all;
                }
                field("N° Camion"; rec."N° Camion")
                {
                    ApplicationArea = all;
                }
                field("Date Heure depart Chatier"; rec."Date Heure depart Chatier")
                {
                    ApplicationArea = all;
                }
                field("Date Heure Chargement Frs"; rec."Date Heure Chargement Frs")
                {
                    ApplicationArea = all;
                }
                field("Date Heure Retour Chantier"; rec."Date Heure Retour Chantier")
                {
                    ApplicationArea = all;
                }
                field("Tare Chez Fournisseur"; rec."Tare Chez Fournisseur")
                {
                    ApplicationArea = all;
                }
                field("Poids Brut Fournisseur"; rec."Poids Brut Fournisseur")
                {
                    ApplicationArea = all;
                }
                field("Poids Net Fournisseur"; rec."Poids Net Fournisseur")
                {
                    ApplicationArea = all;
                }
                field("Tare Chantier"; rec."Tare Chantier")
                {
                    ApplicationArea = all;
                }
                field("Poids Brut Chantier"; rec."Poids Brut Chantier")
                {
                    ApplicationArea = all;
                }
                field("Poids Net Chantier"; rec."Poids Net Chantier")
                {
                    ApplicationArea = all;
                }
                field("Ecart Poids Net Chantier"; rec."Ecart Poids Net Chantier")
                {
                    ApplicationArea = all;
                }
                field("Poids Apres SC"; rec."Poids Apres SC")
                {
                    ApplicationArea = all;
                }
                field("Quantité SC"; rec."Quantité SC")
                {
                    ApplicationArea = all;
                }
                field("Poids Aprés CB"; rec."Poids Aprés CB")
                {
                    ApplicationArea = all;
                }
                field("Quantité CB"; rec."Quantité CB")
                {
                    ApplicationArea = all;
                }
                field("N° Ligne"; rec."N° Ligne")
                {
                    ApplicationArea = all;
                }
                field("N° Sequence"; rec."N° Sequence")
                {
                    ApplicationArea = all;
                }
                field("N° Affaire"; rec."N° Affaire")
                {
                    ApplicationArea = all;
                }
                field("N° Receptipon"; rec."N° Receptipon")
                {
                    ApplicationArea = all;
                }
                field("Ecart Final"; rec."Ecart Final")
                {
                    ApplicationArea = all;
                }
                field(Remarque; rec.Remarque)
                {
                    ApplicationArea = all;
                }
                field("N° Reception Enregistré"; rec."N° Reception Enregistré")
                {
                    ApplicationArea = all;
                }
                field("Code Fournisseur"; rec."Code Fournisseur")
                {
                    ApplicationArea = all;
                }
                field("Designation Article"; rec."Designation Article")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Fonction)
            {
                Caption = 'Function';
                action(Fiche)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    ShortCutKey = 'Maj+F7';

                    trigger OnAction()
                    begin
                        if RecPvReception.Get(rec."N° Sequence", rec."N° Commande", rec."N° Article") then
                            page.RunModal(page::"PV Reception", RecPvReception);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Fonction1)
            {
                Caption = 'Function';
                actionref(Fiche1; Fiche)
                {

                }
            }
        }
    }

    var
        RecPvReception: Record "PV Reception";
}

