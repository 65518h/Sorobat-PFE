Page 50185 "Liste Materiels"
{
    PageType = List;
    SourceTable = Resource;
    SourceTableView = sorting(Compteur)
                      where(Type = const(Machine));
    ApplicationArea = all;
    Caption = 'Liste Materiels';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Compteur; REC.Compteur)
                {
                    ApplicationArea = all;
                }
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Name; REC.Name)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("IM Cout Direct"; REC."IM Cout Direct")
                {
                    ApplicationArea = all;
                }
                field("UM Cout Direct"; REC."UM Cout Direct")
                {
                    ApplicationArea = all;
                }
                field("Lubrifiant Pt Entre Cout Direc"; REC."Lubrifiant Pt Entre Cout Direc")
                {
                    ApplicationArea = all;
                }
                field("Cout Consommation Direct"; REC."Cout Consommation Direct")
                {
                    ApplicationArea = all;
                }
                field("MO Conducteur Engin"; REC."MO Conducteur Engin")
                {
                    ApplicationArea = all;
                }
                field(Conducteur; REC.Conducteur)
                {
                    ApplicationArea = all;
                }
                field("Cout MO Materielle Direct"; REC."Cout MO Materielle Direct")
                {
                    ApplicationArea = all;
                }
                field("Cout De Base"; REC."Cout De Base")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Unit Cost"; REC."Unit Cost")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        area(Promoted)

        {

            group(Fonction1)
            {
                Caption = 'Fonction';
                actionref("Importer BB1"; "Importer BB") { }
            }
        }
        area(navigation)
        {
            group(Fonction)
            {
                Caption = 'Fonction';
                action("Importer BB")
                {
                    ApplicationArea = all;
                    Caption = 'Importer BB';
                    Description = 'Runobject GL2024 Dataport Import Materiel Location';
                    ShortCutKey = 'F7';
                }
            }
        }
    }
}

