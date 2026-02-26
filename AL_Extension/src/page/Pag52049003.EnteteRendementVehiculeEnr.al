page 52049003 "Entete Rendement Vehicule Enr"
{//GL2024  ID dans Nav 2009 : "39004755"
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Entete rendement Vehicule Enr";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(LaJournee; LaJournee)
                {
                    ApplicationArea = all;
                    Caption = 'Journee';

                    trigger OnValidate()
                    begin
                        REC.RESET;
                        IF LaJournee = 0D THEN ERROR(Text005);
                        REC.SETRANGE(Journee, LaJournee);
                        LaJourneeOnAfterValidate;
                    end;
                }
                repeater(Control1)
                {
                    Editable = false;
                    field(Journee; REC.Journee)
                    {
                        ApplicationArea = all;
                    }
                    field(Vehicule; REC.Vehicule)
                    {
                        ApplicationArea = all;
                    }
                    field(Chauffeur; REC.Chauffeur)
                    {
                        ApplicationArea = all;
                    }
                    field(Volume; REC.Volume)
                    {
                        ApplicationArea = all;
                    }
                    field("Heure Depart"; REC."Heure Depart")
                    {
                        ApplicationArea = all;
                    }
                    field("Durée Theorique (Minute)"; REC."Durée Theorique (Minute)")
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                    }
                    field(Provenance; REC.Provenance)
                    {
                        ApplicationArea = all;
                    }
                    field(Destination; REC.Destination)
                    {
                        ApplicationArea = all;
                    }
                    field(Produit; REC.Produit)
                    {
                        ApplicationArea = all;
                    }
                    field("Nom Produit"; REC."Nom Produit")
                    {
                        ApplicationArea = all;
                    }
                }
                field(PtChargement; PtChargement)
                {
                    ApplicationArea = all;
                    Caption = 'Provenance';
                    TableRelation = "Chargement - Dechargement";

                    trigger OnValidate()
                    begin
                        REC.RESET;
                        IF LaJournee = 0D THEN ERROR(Text005);
                        REC.SETRANGE(Journee, LaJournee);
                        IF PtChargement <> '' THEN REC.SETRANGE(Provenance, PtChargement);
                        PtChargementOnAfterValidate;
                    end;
                }
                field(PtDechargement; PtDechargement)
                {
                    ApplicationArea = all;
                    Caption = 'Destination';
                    TableRelation = "Chargement - Dechargement";

                    trigger OnValidate()
                    begin
                        REC.RESET;
                        IF LaJournee <> 0D THEN REC.SETRANGE(Journee, LaJournee);
                        IF PtChargement <> '' THEN REC.SETRANGE(Provenance, PtChargement);
                        IF PtDechargement <> '' THEN REC.SETRANGE(Destination, PtDechargement);
                        PtDechargementOnAfterValidate;
                    end;
                }
                field(LeProduit; LeProduit)
                {
                    ApplicationArea = all;
                    Caption = 'Produit';
                    TableRelation = Item."No." WHERE("Tree Code" = FILTER('A-300*' | 'A-PC*' | 'A-200*'));

                    trigger OnValidate()
                    begin
                        REC.RESET;
                        IF LeProduit <> '' THEN REC.SETRANGE(Produit, LeProduit);
                        IF LaJournee <> 0D THEN REC.SETRANGE(Journee, LaJournee);
                        IF PtChargement <> '' THEN REC.SETRANGE(Provenance, PtChargement);
                        IF PtDechargement <> '' THEN REC.SETRANGE(Destination, PtDechargement);
                        LeProduitOnAfterValidate;
                    end;
                }
                part(ligne; "Ligne Rendement Vehicule Enreg")
                {
                    ApplicationArea = all;
                    Editable = false;
                    SubPageLink = Journee = FIELD(Journee),
                                  Provenance = FIELD(Provenance),
                                  Destination = FIELD(Destination),
                                  Vehicule = FIELD(Vehicule),
                                  Produit = FIELD(Produit);
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        REC.SETRANGE(Journee, 0D);
    end;

    var
        EnteteRendemenentVehicule: Record "Entete rendement Vehicule";
        EnteteRendemenentVehicule2: Record "Entete rendement Vehicule";
        EnteteRendemenentVehicule3: Record "Entete rendement Vehicule";
        EnteteRendemenentVehicule4: Record "Entete rendement Vehicule";
        RecVehicule: Record "Véhicule";
        EnteteRendemenVehEnr: Record "Entete rendement Vehicule Enr";
        LigneRendVehicule: Record "Ligne Rendement Vehicule";
        Text001: Label 'Confirmer Cette Action ?';
        Text002: Label 'Vous Devez Preciser La Journee';
        Text003: Label 'Vous Devez D''abords Valider La Journee %1';
        Text004: Label 'Journee Deja Saisie';
        LigneRendVehiculeEnr: Record "Ligne Rendement Vehicule Enr";
        LigneRendVehiculeEnr2: Record "Ligne Rendement Vehicule Enr";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParametreParc: Record "Paramétre Parc";
        // EntetePointageChauffeur: Record "Entete Pointage Chauffeur";
        // LignePointageChauffeur: Record "Ligne Pointage Chauffeur";
        // FrmListeCamions: Page "Detail Contrat Leasing";
        LaJournee: Date;
        PtChargement: Code[30];
        PtDechargement: Code[30];
        LeProduit: Code[20];
        Text005: Label 'Remplir Tous Les Champs';

    local procedure LaJourneeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PtChargementOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PtDechargementOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure LeProduitOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

