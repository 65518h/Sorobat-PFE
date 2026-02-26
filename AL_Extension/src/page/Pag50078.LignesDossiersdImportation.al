Page 50078 "Lignes Dossiers d'Importation"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Ligne Dossiers d'Importation";
    Caption = 'Lignes Dossiers d''Importation';
    ApplicationArea = All;

    //DYS problème declaration page 511
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° réception"; rec."N° réception")
                {
                    ApplicationArea = all;
                }
                field("N° ligne réception"; rec."N° ligne réception")
                {
                    ApplicationArea = all;
                }
                field("N° article"; rec."N° article")
                {
                    ApplicationArea = all;
                }
                field("Quantité par unité"; rec."Quantité par unité")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Désignation"; rec.Désignation)
                {
                    ApplicationArea = all;
                }
                field("Date Déclaration"; rec."Date Déclaration")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Quantité"; rec.Quantité)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Quantité (base)"; rec."Quantité (base)")
                {
                    ApplicationArea = all;
                }
                field("Coût unitaire direct"; rec."Coût unitaire direct")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Coût unitaire direct (base)"; rec."Coût unitaire direct (base)")
                {
                    ApplicationArea = all;
                }
                field("Coût unitaire"; rec."Coût unitaire")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Coût unitaire (dev soc)"; rec."Coût unitaire (dev soc)")
                {
                    ApplicationArea = all;
                }
                field(Montant; rec.Montant)
                {
                    ApplicationArea = all;
                }
                field("Montant (dev soc)"; rec."Montant (dev soc)")
                {
                    ApplicationArea = all;
                }
                field("% remise ligne"; rec."% remise ligne")
                {
                    ApplicationArea = all;
                }
                field("Code devise"; rec."Code devise")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        //DYS problème declaration page 511
                        /*  ModifierTauxChange.SetParameter(rec."Code devise", rec."Facteur devise", WorkDate);
                          if ModifierTauxChange.RunModal = Action::OK then begin
                              rec.Validate("Facteur devise", ModifierTauxChange.GetParameter);
                          end;
                          Clear(ModifierTauxChange);*/
                    end;
                }
                field("Prix unitaire (dev soc)"; rec."Prix unitaire (dev soc)")
                {
                    ApplicationArea = all;
                }
                field(Volume; rec.Volume)
                {
                    ApplicationArea = all;
                }
                field("N° commande"; rec."N° commande")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        PrestLigneDossier: Record "Dossiers d'Importation";
    //DYS problème declaration page 511
    // ModifierTauxChange: Page "Change Exchange Rate";


    procedure AfficherPrestations()
    begin
        /*PrestLigneDossier.RESET;
        PrestLigneDossier.SETRANGE("N° dossier", "N° dossier");
        PrestLigneDossier.SETRANGE("N° ligne", "N° ligne");
        FORM.RUNMODAL(FORM::"Liste Evaluation Fournisseurs",PrestLigneDossier);
        */

    end;
}

