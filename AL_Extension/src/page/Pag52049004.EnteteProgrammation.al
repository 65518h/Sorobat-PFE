page 52049004 "Entete Programmation"
{//GL2024  ID dans Nav 2009 : "39004756"
    Editable = true;
    PageType = Card;
    SourceTable = "Entete Progrmmation";
    SourceTableView = WHERE(Statut = CONST(Ouvert));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("N° Document"; REC."N° Document")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Journee; REC.Journee)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF REC.Journee = 0D THEN ERROR(Text002);
                        RecVehicule.SETRANGE(Bloquer, FALSE);
                        RecVehicule.SETFILTER("Statut", '>%1', 0);
                        //RecVehicule.SETRANGE(marche,Affectation);
                        RecVehicule.SETFILTER("Grande Famille", '%1', 'CAMION*');
                        IF RecVehicule.FINDFIRST THEN
                            REPEAT
                                LigneProgrammation.Vehicule := RecVehicule."N° Vehicule";
                                LigneProgrammation."N° Document" := REC."N° Document";
                                LigneProgrammation.Journee := REC.Journee;
                                LigneProgrammation.Chantier := RecVehicule.marche;
                                // LigneProgrammation."Sous Affectation":=RecVehicule."Compteur Actuel";
                                LigneProgrammation.Statut := RecVehicule.Statut;
                                LigneProgrammation.Volume := RecVehicule.Volume;
                                //  LigneProgrammation."Point Chargement" :=RecVehicule."Dernier Vidange";
                                //  LigneProgrammation."Point Dechargement" :=RecVehicule."Vidange A";
                                LigneProgrammation.Chauffeur := RecVehicule.Conducteur;
                                IF NOT LigneProgrammation.INSERT THEN LigneProgrammation.MODIFY;

                            UNTIL RecVehicule.NEXT = 0;
                        JourneeOnAfterValidate;
                    end;
                }
            }
            part(ligne; "Ligne Programmation")
            {
                ApplicationArea = all;
                SubPageLink = "N° Document" = FIELD("N° Document");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Fonction)
            {
                Caption = 'Fonction';
                action(Valider)
                {
                    ApplicationArea = all;
                    Caption = 'Valider';
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        IF NOT CONFIRM(Text001) THEN EXIT;
                        REC.Statut := REC.Statut::Validé;
                        REC.MODIFY;
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Confirmer Cette Action ?';
        Text002: Label 'Vous Devez Preciser La Journee';
        Text003: Label 'Vous Devez D''abords Valider La Journee %1';
        Text004: Label 'Journee Deja Saisie';
        DteJournee: Date;
        RecVehicule: Record "Véhicule";
        LigneSuiviVehiculeParStatut: Record "Linge Programmation";
        LigneSuiviVehiculeParStatut2: Record "Linge Programmation";
        EnteteRendementVehicule: Record "Entete rendement Vehicule";
        LigneRendementVehicule: Record "Ligne Rendement Vehicule";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParametreParc: Record "Paramétre Parc";
        DernierNumero: Integer;
        EnteteProgrammation: Record "Entete Progrmmation";
        LigneProgrammation: Record "Linge Programmation";
        LigneProgrammation2: Record "Linge Programmation";

    local procedure JourneeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

