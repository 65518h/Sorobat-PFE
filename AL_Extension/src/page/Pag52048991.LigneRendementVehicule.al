Page 52048991 "Ligne Rendement Vehicule"
{//GL2024  ID dans Nav 2009 : "39004738"
    AutoSplitKey = false;
    DelayedInsert = true;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Ligne Rendement Vehicule";
    SourceTableView = sorting(Journee, "Numero Voyage", Provenance, Destination, Vehicule, Produit);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater("BonChargé")
            {
                field("Numero Voyage"; Rec."Numero Voyage")
                {
                    ApplicationArea = Basic;
                    //blankzero = true;
                }
                field(Heure; Rec.Heure)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Rec.TestField("Numero Voyage");
                        IF EnteterendementVehicule.GET(Journee, rec."Provenance 2", rec.Destination, rec.Vehicule, rec.Produit, rec.Marche) THEN;
                        Rec."Durée Theorique (Minute)" := EnteterendementVehicule."Durée Theorique (Minute)";
                        LignerendementVehicule.SETCURRENTKEY(Journee, "Numero Voyage", "Provenance 2", Destination, Vehicule, Produit);
                        LignerendementVehicule.SETRANGE(Journee, Rec.Journee);
                        LignerendementVehicule.SETRANGE(Vehicule, Rec.Vehicule);
                        LignerendementVehicule.SETRANGE("Provenance 2", Rec."Provenance 2");
                        LignerendementVehicule.SETRANGE(Destination, Rec.Destination);
                        LignerendementVehicule.SETRANGE(Produit, Rec.Produit);
                        EnteterendementVehicule.TestField("Heure Depart");
                        if LignerendementVehicule.FindLast then begin
                            if not LignerendementVehicule.Pause then
                                Rec."Heure Depart" := LignerendementVehicule.Heure
                            else
                                Rec."Heure Depart" := EnteterendementVehicule."Heure Depart";
                        end
                        else
                            Rec."Heure Depart" := EnteterendementVehicule."Heure Depart";
                        Rec."Duree Reel (Minute)" := ((Rec.Heure - Rec."Heure Depart") / 60000);
                        if Rec."Duree Reel (Minute)" < -1000 then Rec."Duree Reel (Minute)" := 1440 + Rec."Duree Reel (Minute)";
                        if Rec."Duree Reel (Minute)" = 0 then Rec."Ecart (Minute)" := 0 else Rec."Ecart (Minute)" := Rec."Duree Reel (Minute)" - Rec."Durée Theorique (Minute)";
                        Rec."Distance Parcourus" := EnteterendementVehicule."Distance Parcourus";
                        Rec.Chauffeur := EnteterendementVehicule.Chauffeur;
                        Rec.Volume := EnteterendementVehicule.Volume;
                        // Rec."Code Affaire" := EnteterendementVehicule.Marche;
                        // if RecVehicule.Get(Rec.Vehicule) then Rec.Societe := RecVehicule.Societe;
                    end;
                }
                field(Chauffeur; Rec.Chauffeur)
                {
                    ApplicationArea = Basic;
                }
                field("Heure Depart"; Rec."Heure Depart")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Pause; Rec.Pause)
                {
                    ApplicationArea = Basic;
                }
                field("Reprise Heure Pause"; Rec."Reprise Heure Pause")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        if Rec.Pause then
                            IF EnteterendementVehicule.GET(Journee, Rec."Provenance 2", Rec.Destination, Rec.Vehicule, Rec.Produit, Rec.Marche) THEN begin
                                EnteterendementVehicule."Heure Depart" := Rec."Reprise Heure Pause";
                                EnteterendementVehicule.Modify;
                            end;
                    end;
                }
                field("Durée Theorique (Minute)"; Rec."Durée Theorique (Minute)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Duree Reel (Minute)"; Rec."Duree Reel (Minute)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ecart (Minute)"; Rec."Ecart (Minute)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Distance Parcourus"; Rec."Distance Parcourus")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = Basic;
                }
                field("Code Affaire"; Rec.Marche)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        EnteterendementVehicule: Record "Entete rendement Vehicule";
        Text001: label 'Confirmer Cette Action ?';
        LignerendementVehicule: Record "Ligne Rendement Vehicule";
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
}

