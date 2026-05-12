Page 50161 "Liste Camion"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Véhicule";
    SourceTableView = where(Famille = filter('CAMION BENNE' | 'CAMION TRACTEUR' | 'CAMION CITERNE'));
    ApplicationArea = all;
    Caption = 'Liste Camion';
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
                    Editable = false;
                }
                field(TransporT; REC.TransporT)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        // RecVehicule2.SETCURRENTKEY(Rec.Ordre);
                        IF RecVehicule2.FINDLAST THEN LOrdre := RecVehicule2.Ordre;
                        Rec.Ordre := LOrdre + 1;
                        Rec.MODIFY;
                    end;
                }
                field("Désignation"; REC.Désignation)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Statut; REC.Statut)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Immatriculation; REC.Immatriculation)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Num Châssis"; REC."Num Châssis")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Valider)
            {
                ApplicationArea = all;
                Caption = 'Valider';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    Clear(EnteterendementVehicule);
                    Clear(LignerendementVehicule2);
                    RecVehicule.Copy(Rec);
                    RecVehicule.SetRange(TransporT, true);
                    if RecVehicule.FindFirst then
                        repeat
                            EnteterendementVehicule.Init;
                            EnteterendementVehicule.Vehicule := RecVehicule."N° Vehicule";
                            EnteterendementVehicule.Provenance := PtChargement;
                            EnteterendementVehicule.Destination := PtDechargement;
                            // EnteterendementVehicule."Distance Parcourus" :=EnteterendementVehicule."Distance Parcourus";
                            EnteterendementVehicule.Journee := LaJournee;
                            // LignerendementVehicule."Durée Theorique (Minute)":=EnteterendementVehicule."Duree Rotation";
                            EnteterendementVehicule.Produit := LeProduit;
                            EnteterendementVehicule.Chauffeur := RecVehicule.Conducteur;
                            // if RecVehicule.Volume = 0 then RecVehicule.Volume := 20;
                            EnteterendementVehicule.Volume := RecVehicule.Volume;
                            EnteterendementVehicule.Marche := LeMarche;
                            EnteterendementVehicule.Ordre := RecVehicule.Ordre;
                            IF RecVehicule."N° Vehicule" <> '' THEN
                                if EnteterendementVehicule.Insert(true) then;
                            RecVehicule.TransporT := false;
                            RecVehicule.Ordre := 0;
                            RecVehicule.Modify;
                        until RecVehicule.Next = 0;
                    CurrPage.Close;
                end;
            }
        }
    }

    var
        EnteterendementVehicule: Record "Entete rendement Vehicule";
        LignerendementVehicule: Record "Ligne Rendement Vehicule";
        LignerendementVehicule2: Record "Ligne Rendement Vehicule";
        NumDoc: Code[20];
        RecVehicule2: Record Véhicule;
        LOrdre: Integer;
        Text001: label 'Integrer Les Lignes ?';
        RecVehicule: Record "Véhicule";
        Compteur: Integer;
        PtChargement: Code[50];
        PtDechargement: Code[50];
        LaJournee: Date;
        LeProduit: Code[20];
        LeMarche: Code[20];


    procedure GetNum(ParaNumDoc: Code[20]; ParaJournee: Date; ParaPtChargement: Code[50]; ParaPointDechargement: Code[50]; ParaProduit: Code[20]; ParaMarche: Code[20])
    begin
        NumDoc := ParaNumDoc;
        LaJournee := ParaJournee;
        PtChargement := ParaPtChargement;
        PtDechargement := ParaPointDechargement;
        LeProduit := ParaProduit;
        LeMarche := ParaMarche;
    end;
}

