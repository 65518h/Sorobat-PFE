page 52049059 "List Véhicules"
{//GL2024  ID dans Nav 2009 : "39004671"
    Editable = false;
    CardPageId = "Fiche Véhicule";
    PageType = List;
    Caption = 'Liste Véhicules';
    UsageCategory = Lists;
    SourceTable = "Véhicule";
    ApplicationArea = All;

    SourceTableView = SORTING("Grande Famille", Famille, "Sous Famille")
                    WHERE(Bloquer = CONST(false));


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Vehicule"; REC."N° Vehicule")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Désignation; REC.Désignation)
                {
                    ApplicationArea = all;
                }
                field("Type Index"; REC."Type Index")
                {
                    ApplicationArea = all;
                }
                field(Marque; REC.Marque)
                {
                    ApplicationArea = all;
                }
                // field("Reste Pour Alerte"; REC."Reste Pour Alerte")
                // {
                //     ApplicationArea = all;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }
                // field("No. Series"; REC."No. Series")
                // {
                //     ApplicationArea = all;
                // }
                field("Grande Famille"; REC."Grande Famille")
                {
                    ApplicationArea = all;
                    Caption = 'Grande Famille';
                }
                field(Famille; REC.Famille)
                {
                    ApplicationArea = all;
                    Caption = 'Famille';
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
                field("Sous Famille1"; REC."Sous Famille")
                {
                    ApplicationArea = all;
                    Caption = 'Sous Famille';
                }
                // field("Nbre Jours"; REC."Nbre Jours")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                field(Immatriculation; REC.Immatriculation)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Compteur Actuel"; Rec."Compteur Actuel")
                {
                    ApplicationArea = all;
                }
                field(marche; Rec.marche)
                {
                    ApplicationArea = all;
                }
                // field("Date PMC"; REC."Date PMC")
                // {
                //     ApplicationArea = all;
                // }
                // field("Statut Vehicule"; REC."Statut Vehicule")
                // {
                //     ApplicationArea = all;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }
                // field(Enrobé; REC.Enrobé)
                // {
                //     ApplicationArea = all;
                // }

                field("Dernier Vidange"; Rec."Dernier Vidange")
                {
                    ApplicationArea = all;

                }
                field("Prochain Vidange"; Rec."Prochain Vidange")
                {
                    ApplicationArea = all;

                }
                field("Reste Pour Alerte"; Rec."Reste Pour Alerte")
                {
                    ApplicationArea = all;

                }
                field("Num Châssis"; REC."Num Châssis")
                {
                    ApplicationArea = all;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = all;

                }
                field("Code Immo"; Rec."Code Immo")
                {
                    ApplicationArea = all;

                }
                field("Type de Carburant"; Rec."Type de Carburant")
                {
                    ApplicationArea = all;

                }
                field("Date d'acquisition"; Rec."Date d'acquisition")
                {
                    ApplicationArea = all;
                }

                // field("Cout Location Journaliere1"; REC."Cout Location Journaliere")
                // {
                //     ApplicationArea = all;
                // }
                // field("Designation 2"; REC."Designation 2")
                // {
                //     ApplicationArea = all;
                // }
                // field("Nom Remorque"; REC."Nom Remorque")
                // {
                //     ApplicationArea = all;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }

                field("Consommation Max"; REC."Consommation Max")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Consommation Min"; REC."Consommation Min")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Consommation Moyen"; REC."Consommation Moyen")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Num Police Assurance"; REC."Num Police Assurance")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Synchronise; REC.Synchronise)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                // field("Designation Sous Affaire"; REC."Designation Sous Affaire")
                // {
                //     ApplicationArea = all;
                // }
                // field(Societe; REC.Societe)
                // {
                //     ApplicationArea = all;
                // }
                // field(Chauffeur; REC.Chauffeur)
                // {
                //     ApplicationArea = all;
                // }
                // field("Cout Location Journaliere"; REC."Cout Location Journaliere")
                // {
                //     ApplicationArea = all;
                // }
                // field(Marche; REC.Marche)
                // {
                //     ApplicationArea = all;
                // }
                field(Bloquer; REC.Bloquer)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Date Expiration Patente"; REC."Date Expiration Patente")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Compteur Actuel Vidange"; REC."Compteur Actuel Vidange")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Kms Parcourus"; REC."Kms Parcourus")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Date Exp Carte Exploitation"; REC."Date Exp Carte Exploitation")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Type Marque Location"; REC."Type Marque Location")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                // field(Remorque; REC.Remorque)
                // {
                //     ApplicationArea = all;
                // }


                // field("Gamme Debut"; REC."Gamme Debut")
                // {
                //     ApplicationArea = all;
                // }
                // field("Gamme Fin"; REC."Gamme Fin")
                // {
                //     ApplicationArea = all;
                // }
                // field("Gamme Actif"; REC."Gamme Actif")
                // {
                //     ApplicationArea = all;
                // }
                // field("BT Prev En cours"; REC."BT Prev En cours")
                // {
                //     ApplicationArea = all;
                // }
                // field(Organe; REC.Organe)
                // {
                //     ApplicationArea = all;
                // }
                // field("Date Acquisition"; REC."Date Acquisition")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cout Acquisition"; REC."Cout Acquisition")
                // {
                //     ApplicationArea = all;
                // }
                // field(Amortissement; REC.Amortissement)
                // {
                //     ApplicationArea = all;
                // }

            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("Véhicule1")
            {
                Caption = 'Véhicule';
                actionref(Fiche1; Fiche) { }
                actionref("Historique Vignette1"; "Historique Vignette") { }
                actionref("Historique Affectation1"; "Historique Affectation") { }

            }
        }
        area(Processing)
        {
            action(CreateResourceAction)
            {
                ApplicationArea = all;
                Image = Resource;
                Caption = 'Créer ressource';
                trigger OnAction()
                var
                    RecLVehicule: Record "Véhicule";
                    cpt: Integer;
                begin
                    if RecLVehicule.FindFirst() then
                        repeat
                            CreateResource(RecLVehicule);
                            cpt := cpt + 1;
                        until RecLVehicule.Next() = 0;
                    message('Création terminée %1', cpt);
                end;
            }
        }
        area(navigation)
        {
            group("Véhicule")
            {
                Caption = 'Véhicule';
                action(Fiche)
                {
                    ApplicationArea = all;
                    Caption = 'Fiche';
                    RunObject = Page "Fiche Véhicule";
                    RunPageLink = "N° Vehicule" = FIELD("N° Vehicule");
                }

                //GL3900 action("Carte Grise")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Carte Grise';
                //     //GL3900    RunObject = Page "Carte Grise";
                //     //GL3900   RunPageLink = "N° Veh" = FIELD("N° Vehicule");
                // }
                action("Historique Vignette")
                {
                    ApplicationArea = all;
                    Caption = 'Historique Vignette';
                    RunObject = Page "Liste Vignettes";
                    RunPageLink = "N° Veh" = FIELD("N° Vehicule");
                }
                //GL3900 action(Pneumatique)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Pneumatique';
                //     //GL3900    RunObject = Page Pneumatique;
                //     //GL3900   RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                // }

                action("Historique Affectation")
                {
                    ApplicationArea = all;
                    Caption = 'Historique Affectation';
                    RunObject = Page "Historique Affectation";
                    RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                }
            }
        }
    }
    procedure CreateResource(RecLVehicule: Record "Véhicule")
    var
        RecLResource: Record "Resource";
    begin
        RecLResource.init();
        RecLResource."No." := RecLVehicule."N° Vehicule";
        RecLResource.validate(Equipment, RecLVehicule."N° Vehicule");
        RecLResource.validate(Name, RecLVehicule."Désignation");

        RecLResource."Type" := RecLResource."Type"::Machine;
        RecLResource."Resource Group No." := 'MATERIEL';
        IF RecLResource.Insert(true) then;
        RecLResource.validate("Base Unit of Measure", 'HEURE');
        RecLResource.Modify(true);
    end;
}

