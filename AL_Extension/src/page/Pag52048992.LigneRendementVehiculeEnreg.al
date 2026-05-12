Page 52048992 "Ligne Rendement Vehicule Enreg"
{//GL2024  ID dans Nav 2009 : "39004739"
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Ligne Rendement Vehicule Enr";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater("BonChargé")
            {
                Editable = false;
                field(Vehicule; Rec.Vehicule)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        VehiculeOnAfterValidate;
                    end;
                }
                field(Heure; Rec.Heure)
                {
                    ApplicationArea = Basic;
                }
                field(Chauffeur; Rec.Chauffeur)
                {
                    ApplicationArea = Basic;
                    //
                }
                // field("Code Affaire"; Rec."Code Affaire")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }
                field(Provenance; Rec.Provenance)
                {
                    ApplicationArea = Basic;
                }
                field(Marche; Rec.Marche)
                {
                    ApplicationArea = Basic;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = Basic;
                }
                field(Produit; Rec.Produit)
                {
                    ApplicationArea = Basic;
                }
                field("Nom Produit"; Rec."Nom Produit")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000010; Rec.Provenance)
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000012; Rec.Destination)
                {
                    ApplicationArea = Basic;
                }
                field("Durée Theorique (Minute)"; Rec."Durée Theorique (Minute)")
                {
                    ApplicationArea = Basic;
                }
                field("Duree Reel (Minute)"; Rec."Duree Reel (Minute)")
                {
                    ApplicationArea = Basic;
                }
                field("Distance Parcourus"; Rec."Distance Parcourus")
                {
                    ApplicationArea = Basic;
                }
                field("Quantité"; Rec.Quantité)
                {
                    ApplicationArea = Basic;
                }
                field("Durée Intervention (Minute)"; Rec."Durée Intervention (Minute)")
                {
                    ApplicationArea = Basic;
                }
                field(Observation; Rec.Observation)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if EnteterendementVehicule.Get(Rec."N° Document") then;
        Rec.Provenance := EnteterendementVehicule.Provenance;
        Rec.Destination := EnteterendementVehicule.Destination;
        Rec."Distance Parcourus" := EnteterendementVehicule."Distance Parcourus";
        Rec.Journee := EnteterendementVehicule.Journee;
        Rec."Durée Theorique (Minute)" := EnteterendementVehicule."Duree Rotation";
        Rec.Produit := EnteterendementVehicule.Produit;
    end;

    var
        EnteterendementVehicule: Record "Entete rendement Vehicule";
        Text001: label 'Confirmer Cette Action ?';
        Journee: Date;
        Text002: label 'Preciser Journee';
        Affectation: Code[20];
        LigneRendVehicule: Record "Ligne Rendement Vehicule";
        RecVehicule: Record "Véhicule";


    procedure UpdateForm()
    begin
    end;


    procedure Imprimer()
    begin
    end;

    local procedure VehiculeOnAfterValidate()
    begin
        CurrPage.SaveRecord;
    end;
}

