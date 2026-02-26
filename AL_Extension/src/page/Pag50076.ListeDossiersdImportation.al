Page 50076 "Liste Dossiers d'Importation"
{
    Editable = false;
    PageType = list;
    SourceTable = "Dossiers d'Importation";
    SourceTableView = sorting("N° Dossier")
                      order(ascending);
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Liste Dossiers d''Importation';
    //HS
    CardPageId = "Dossiers d'Importation";
    //HS
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Dossier"; rec."N° Dossier")
                {
                    ApplicationArea = all;
                }
                field("Date d'ouverture"; rec."Date d'ouverture")
                {
                    ApplicationArea = all;
                }
                field("Date de clôture"; rec."Date de clôture")
                {
                    ApplicationArea = all;
                }
                field("N° Fournisseur"; rec."N° Fournisseur")
                {
                    ApplicationArea = all;
                }
                field("Nom fournisseur"; rec."Nom fournisseur")
                {
                    ApplicationArea = all;
                }
                field(Statut; rec.Statut)
                {
                    ApplicationArea = all;
                }
                field("N° dern Commande"; rec."N° dern Commande")
                {
                    ApplicationArea = all;
                }
                field(Control12; rec.Statut)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group(Dossier1)
            {
                Caption = 'Folder';
                actionref("&Fiche1"; "&Fiche")
                {

                }
            }

        }
        area(navigation)
        {
            group(Dossier)
            {
                //HS
                Visible = false;
                //HS
                Caption = 'Folder';
                action("&Fiche")
                {
                    ApplicationArea = all;
                    Caption = '&Card';
                    ShortCutKey = 'Maj+F7';

                    trigger OnAction()
                    begin
                        page.Run(Page::"Dossiers d'Importation", Rec);
                    end;
                }
            }
        }
    }

    var
        Doss: Page "Dossiers d'Importation";
}

