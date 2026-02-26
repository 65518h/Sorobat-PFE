page 52049002 "Entete Rendement Vehicule"
{//GL2024  ID dans Nav 2009 : "39004754"
    DelayedInsert = true;
    Editable = true;
    PageType = Card;
    SourceTable = "Entete rendement Vehicule";
    ApplicationArea = All;
    SourceTableView = SORTING(Ordre);
    UsageCategory = Administration;
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
                field(Marche1; REC.Marche)
                {
                    ApplicationArea = all;
                }
                field("Affectation Marche"; REC."Affectation Marche")
                {
                    ApplicationArea = all;
                    Caption = 'Affect. Marche';
                }
                field("Sous Affectation Marche"; REC."Sous Affectation Marche")
                {
                    ApplicationArea = all;
                    Caption = 'S. Affect. Marche';
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field(Journee; REC.Journee)
                {
                    ApplicationArea = all;
                }
                field(Vehicule; REC.Vehicule)
                {
                    ApplicationArea = all;
                    Editable = false;
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
                field("Distance Parcourus"; REC."Distance Parcourus")
                {
                    ApplicationArea = all;
                }
                field(Marche11; REC.Marche)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Provenance; REC.Provenance)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Destination; REC.Destination)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Produit; REC.Produit)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nom Produit"; REC."Nom Produit")
                {
                    ApplicationArea = all;
                }
                field("Nombre Voyage"; REC."Nombre Voyage")
                {
                    ApplicationArea = all;
                }
                field(IsOk; IsOk)
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Caption = 'Génerer';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF NOT CONFIRM(Text001) THEN EXIT;
                        FOR Compteur := 1 TO REC."Nombre Voyage" DO BEGIN
                            IF REC.Volume = 0 THEN REC.Volume := 20;
                            LigneRendVehicule.Journee := REC.Journee;
                            LigneRendVehicule.Heure := REC."Heure Depart" + REC."Durée Theorique (Minute)" * Compteur * 60000;
                            LigneRendVehicule."Heure Depart" := REC."Heure Depart";
                            LigneRendVehicule.Provenance := REC.Provenance;
                            LigneRendVehicule.Destination := REC.Destination;
                            LigneRendVehicule.Vehicule := REC.Vehicule;
                            LigneRendVehicule.Produit := REC.Produit;
                            LigneRendVehicule."Marche" := REC.Marche;
                            LigneRendVehicule.Chauffeur := REC.Chauffeur;
                            LigneRendVehicule."Distance Parcourus" := REC."Distance Parcourus";
                            LigneRendVehicule.Volume := REC.Volume;
                            LigneRendVehicule."Durée Theorique (Minute)" := REC."Durée Theorique (Minute)";
                            LigneRendVehicule."Duree Reel (Minute)" := ((LigneRendVehicule.Heure - LigneRendVehicule."Heure Depart") / 60000);
                            IF LigneRendVehicule."Duree Reel (Minute)" = 0 THEN
                                LigneRendVehicule."Ecart (Minute)" := 0 ELSE
                                LigneRendVehicule."Ecart (Minute)" := LigneRendVehicule."Duree Reel (Minute)" - LigneRendVehicule."Durée Theorique (Minute)";
                            LigneRendVehicule."Heure Depart" := REC."Heure Depart";
                            IF LigneRendVehicule.INSERT THEN;
                        END;
                    end;


                    trigger OnValidate()
                    begin
                        IsOkOnAfterValidate;
                    end;
                }
            }

            part(lign; "Ligne Rendement Vehicule")
            {
                ApplicationArea = all;
                SubPageLink = Journee = FIELD(Journee), "Provenance 2" = FIELD(Provenance), Destination = FIELD(Destination), Vehicule = FIELD(Vehicule), Produit = FIELD(Produit), Marche = FIELD(Marche);
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
                actionref(Valider1; Valider)
                {

                }

            }
            actionref("...1"; "...")
            {

            }
        }
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
                        IF LaJournee = 0D THEN ERROR(Text002);
                        EnteteRendemenentVehicule.SETRANGE(Journee, LaJournee);
                        // EnteteRendemenentVehicule.SETRANGE(Marche, REC.Marche);
                        // EnteteRendemenentVehicule.SETRANGE(Provenance, REC.Provenance);
                        // EnteteRendemenentVehicule.SETRANGE(Destination, REC.Destination);
                        // EnteteRendemenentVehicule.SETRANGE(Produit, REC.Produit);

                        IF EnteteRendemenentVehicule.FINDFIRST THEN
                            REPEAT
                                EnteteRendemenVehEnr.TRANSFERFIELDS(EnteteRendemenentVehicule);
                                EnteteRendemenVehEnr.INSERT;
                                EnteteRendemenentVehicule.DELETE;
                            UNTIL EnteteRendemenentVehicule.NEXT = 0;
                        LigneRendVehicule.RESET;
                        LigneRendVehicule.SETRANGE(Journee, LaJournee);
                        // LigneRendVehicule.SETRANGE("Code Affaire", REC.Marche);
                        // LigneRendVehicule.SETRANGE(Provenance, REC.Provenance);
                        // LigneRendVehicule.SETRANGE(Destination, REC.Destination);
                        // LigneRendVehicule.SETRANGE(Produit, REC.Produit);
                        IF LigneRendVehicule.FINDFIRST THEN
                            REPEAT
                                LigneRendVehiculeEnr2.TRANSFERFIELDS(LigneRendVehicule);
                                LigneRendVehiculeEnr2.INSERT;
                            UNTIL LigneRendVehicule.NEXT = 0;


                        LigneRendVehicule.RESET;
                        LigneRendVehicule.SETRANGE(Journee, LaJournee);
                        LigneRendVehicule.DELETEALL;
                    end;
                }
            }
        }
        area(processing)
        {
            action("...")
            {
                ApplicationArea = all;
                Caption = '...';


                trigger OnAction()
                begin
                    IF LaJournee = 0D THEN ERROR(Text005);
                    IF PtChargement = '' THEN ERROR(Text005);
                    IF PtDechargement = '' THEN ERROR(Text005);
                    IF LeProduit = '' THEN ERROR(Text005);
                    IF LaJournee = 0D THEN ERROR(Text005);
                    REC.TESTFIELD(Marche);
                    REC.TESTFIELD("Affectation Marche");
                    REC.TESTFIELD("Sous Affectation Marche");
                    CLEAR(FrmListeCamions);
                    FrmListeCamions.GetNum(REC."N° Document", LaJournee, PtChargement, PtDechargement, LeProduit, REC.Marche);
                    FrmListeCamions.RUNMODAL;
                    CurrPage.UPDATE;
                    REC.RESET;
                    IF LaJournee <> 0D THEN REC.SETRANGE(Journee, LaJournee);
                    IF LeProduit <> '' THEN REC.SETRANGE(Produit, LeProduit);
                    IF PtChargement <> '' THEN REC.SETRANGE(Provenance, PtChargement);
                    IF PtDechargement <> '' THEN REC.SETRANGE(Destination, PtDechargement);
                end;
            }
        }
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
        Text004: Label 'Journée Deja Saisie';
        LigneRendVehiculeEnr: Record "Ligne Rendement Vehicule Enr";
        LigneRendVehiculeEnr2: Record "Ligne Rendement Vehicule Enr";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParametreParc: Record "Paramétre Parc";
        // EntetePointageChauffeur: Record "Entete Pointage Chauffeur";
        // LignePointageChauffeur: Record "Ligne Pointage Chauffeur";
        FrmListeCamions: Page "Liste Camion";
        LaJournee: Date;
        PtChargement: Code[30];
        PtDechargement: Code[30];
        LeProduit: Code[20];
        Text005: Label 'Remplir Tous Les Champs';
        IsOk: Integer;
        Compteur: Integer;

    local procedure IsOkOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

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

