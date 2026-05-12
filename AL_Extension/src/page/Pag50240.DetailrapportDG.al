Page 50240 "Detail rapport DG"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Detail Rapport DG";
    SourceTableView = sorting(Marché, "Date Rapport", "Type Ligne", Designatiion);
    ApplicationArea = all;
    Caption = 'Detail rapport DG';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Type Ligne"; REC."Type Ligne")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Designatiion; REC.Designatiion)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Sous Traitance"; REC."Sous Traitance")
                {
                    ApplicationArea = all;
                }
                field("Unité"; REC.Unité)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Quantité Marché"; REC."Quantité Marché")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Quantité Exécuté"; REC."Quantité Exécuté")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Quantité Livré"; REC."Quantité Livré")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Prix Unitaire Moy  Marché"; REC."Prix Unitaire Moy  Marché")
                {
                    ApplicationArea = all;
                }
                field("Montant Marché"; REC."Montant Marché")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Montant Decompte"; REC."Montant Decompte")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Difference; REC.Difference)
                {
                    ApplicationArea = all;
                }
                field(Montant; REC.Montant)
                {
                    ApplicationArea = all;
                }
                field(Observation; REC.Observation)
                {
                    ApplicationArea = all;
                }
                field(Effectif; REC.Effectif)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("MS Actuelle"; REC."MS Actuelle")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("MS Cumulée"; REC."MS Cumulée")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nombre F"; REC."Nombre F")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nombre P"; REC."Nombre P")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nombre D"; REC."Nombre D")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nombre C"; REC."Nombre C")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nombre Ref"; REC."Nombre Ref")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nombre M.T"; REC."Nombre M.T")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("% Occupation"; REC."% Occupation")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nombre Heures"; REC."Nombre Heures")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Charge Fixe"; REC."Charge Fixe")
                {
                    ApplicationArea = all;
                }
                field("Code Frais"; REC."Code Frais")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

