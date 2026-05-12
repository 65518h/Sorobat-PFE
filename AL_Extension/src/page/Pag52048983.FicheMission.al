page 52048983 "Fiche Mission"
{//GL2024  ID dans Nav 2009 : "39004686"
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Missions;

    Caption = 'Fiche Mission';


    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("N° Mission"; REC."N° Mission")
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF REC.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Centre de Gestion"; REC."Centre de Gestion")
                {
                    ApplicationArea = all;
                }
                field("N° Affaire"; REC."N° Affaire")
                {
                    ApplicationArea = all;
                }
                field("Code Demandeur"; Rec."Code Demandeur")
                {
                    ApplicationArea = all;
                }
                field("Prix En Charge"; rec."Prix En Charge")
                {
                    ApplicationArea = all;
                }
                field("N° Tache Affaire"; REC."N° Tache Affaire")
                {
                    ApplicationArea = all;
                }
                field("Date document"; REC."Date document")
                {
                    ApplicationArea = all;
                }
                field("Date Mission"; REC."Date Mission")
                {
                    ApplicationArea = all;
                }
                field(Demandeur; REC."Nom Demandeur")
                {
                    ApplicationArea = all;
                }
                field("Nom Demandeur"; REC."Nom Demandeur")
                {
                    ApplicationArea = all;
                }
                field("Fonction Demandeur"; REC."Fonction Demandeur")
                {
                    ApplicationArea = all;
                }
                field("Code Convoyeur"; REC."Code Convoyeur")
                {
                    ApplicationArea = all;
                }
                field("Nom Convoyeur"; REC."Nom Convoyeur")
                {
                    ApplicationArea = all;
                }
                field("Objet mission"; REC."Objet mission")
                {
                    ApplicationArea = all;
                }
                field("Date Départ"; REC."Date Départ")
                {
                    ApplicationArea = all;
                }
                field("Date Arrivée"; REC."Date Arrivée")
                {
                    ApplicationArea = all;
                    Caption = 'Date Retour';
                }
                field("Lieu départ"; REC."Lieu départ")
                {
                    ApplicationArea = all;
                    Caption = 'Lieu Départ';

                    trigger OnValidate()
                    begin
                        ville1.RESET;
                        ville1.SETRANGE(Code, REC."Lieu départ");
                        IF ville1.FIND('-') THEN
                            VilDep := ville1.City
                        ELSE
                            VilDep := '';
                    end;
                }
                field(VilDep; VilDep)
                {
                    ShowCaption = false;
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Lieu Arrivé"; REC."Lieu Arrivé")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ville2.RESET;
                        ville2.SETRANGE(Code, REC."Lieu Arrivé");
                        IF ville2.FIND('-') THEN
                            VilArrive := ville2.City
                        ELSE
                            VilArrive := '';
                    end;
                }
                field(VilArrive; VilArrive)
                {
                    ShowCaption = false;
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Engin Transporté"; REC."Engin Transporté")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                field("Heure Départ"; REC."Heure Départ")
                {
                    ApplicationArea = all;
                }
                field("Heure Arrivée"; REC."Heure Arrivée")
                {
                    ApplicationArea = all;
                    Caption = 'Heure Retour';
                }


            }
            group("Véhicule2")
            {
                Caption = 'Véhicule';
                field("Type Vehicule Mission"; REC."Type Vehicule Mission")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //DYS ERREUR dans NAV
                        // IF REC."Type Vehicule Mission" = REC."Type Vehicule Mission"::"2" THEN BEGIN
                        //     "N° VéhiculeEditable" := FALSE;
                        //     //Currpage."Index Cpt. Depart".EDITABLE := FALSE;
                        //     //Currpage."Index Cpt. Retour".EDITABLE := FALSE;
                        // END ELSE BEGIN
                        //     "N° VéhiculeEditable" := TRUE;
                        //     //Currpage."Index Cpt. Depart".EDITABLE := TRUE;
                        //     //Currpage."Index Cpt. Retour".EDITABLE := TRUE;
                        // END;
                    end;
                }
                field("N° Véhicule"; REC."N° Véhicule")
                {
                    ApplicationArea = all;
                    Editable = "N° VéhiculeEditable";
                }
                field("No. Immatriculation"; REC."No. Immatriculation")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Type Véhicule"; REC."Type Véhicule")
                {
                    ApplicationArea = all;
                }
                field("Puissance Véhicule"; REC."Puissance Véhicule")
                {
                    ApplicationArea = all;
                }
                field("Index Cpt. Depart"; REC."Index Cpt. Depart")
                {
                    ApplicationArea = all;
                    Caption = 'Index Cpt. Départ';
                }
                field("Index Cpt. Retour"; REC."Index Cpt. Retour")
                {
                    ApplicationArea = all;
                }
                field("Km Parcourus1"; REC."Km Parcourus")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Coût de kilometrage"; Rec."Coût de kilometrage")
                {
                    ApplicationArea = all;
                }
                field("Alerte Vidange"; REC."Alerte Vidange")
                {
                    ApplicationArea = all;
                    Editable = false;
                    MultiLine = true;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Alerte Assurance"; REC."Alerte Assurance")
                {
                    ApplicationArea = all;
                    Editable = false;
                    MultiLine = true;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Alerte Vignette"; REC."Alerte Vignette")
                {
                    ApplicationArea = all;
                    Editable = false;
                    MultiLine = true;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Alerte Visite Technique"; REC."Alerte Visite Technique")
                {
                    ApplicationArea = all;
                    Editable = false;
                    MultiLine = true;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Index Rép Prévu"; REC."Index Rép Prévu")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Index Fréquence"; REC."Index Fréquence")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Index Cumul"; REC."Index Cumul")
                {
                    Editable = false;
                }
            }
            group("Prise de carburant")
            {
                Caption = 'Prise de carburant';
                part(ligne; "Prise carburant")
                {
                    ApplicationArea = all;
                    SubPageLink = "N° Mission" = FIELD("N° Mission");
                }
            }
            group("Frais du transporteur")
            {
                Caption = 'Frais du transporteur';
                field("Nbre Heure Prepara marchandise"; REC."Nbre Heure Prepara marchandise")
                {
                    ApplicationArea = all;
                }
                group("Km effectue")
                {
                    Caption = 'Km effectue';
                    field("Km Parcourus"; REC."Km Parcourus")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                }
                group("Durée de livraison")
                {
                    Caption = 'Durée de livraison';
                    field("Nbre heure"; REC."Nbre heure")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                }
                field("Coût  Marchandise"; REC."Coût  Marchandise")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Coût de livraison"; REC."Coût de livraison")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Total Frais deplacement"; REC."Total Frais deplacement")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref("&Valider1"; "&Valider") { }
            group("Véhicule1")
            {
                Caption = 'Véhicule';
                actionref(Fiche1; Fiche) { }
                /*GL2024    actionref("Disponibilité1"; "Disponibilité") { }*/
                actionref(Imprimer1; Imprimer) { }
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
                    RunPageLink = "N° Vehicule" = FIELD("N° Véhicule");
                }

                /*GL2024  action("Disponibilité")
                  {
                      ApplicationArea = all;
                      Caption = 'Disponibilité';

                      trigger OnAction()
                      var
                          Dispo: Page "Dispo. Véhicule";
                          Car: Record "Véhicule";
                      begin
                          CLEAR(Dispo);
                          IF Car.GET(REC."N° Véhicule") THEN;
                          Dispo.Set(Car, 0);
                          Dispo.RUNMODAL;
                          CurrPage.UPDATE(FALSE);
                      end;
                  }*/
                action(Imprimer)
                {
                    ApplicationArea = all;
                    Caption = 'Imprimer';

                    trigger OnAction()
                    begin
                        Miss.RESET;
                        Miss.SETRANGE("N° Mission", REC."N° Mission");
                        IF Miss.FIND('-') THEN
                            REPORT.RunModal(report::"Car Mission Order", TRUE, FALSE, Miss);
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Valider")
            {
                ApplicationArea = all;
                Caption = '&Valider';


                trigger OnAction()
                var
                    Text001: Label 'Souhaitez-Vous Valider la Mission.';
                    Text002: Label 'Rien a Valider, verifier le code client où l''objet de la Mission.';
                begin
                    //IBK
                    IF CONFIRM(Text001) THEN BEGIN
                        IF ((REC."N° Véhicule" <> '') AND (REC."Km Parcourus" <> 0))
                        THEN BEGIN
                            Pcar.RESET;
                            Pcar.SETRANGE("N° Mission", REC."N° Mission");
                            Pcar.SETRANGE("N° Véhicule", REC."N° Véhicule");
                            IF Pcar.FIND('-') THEN BEGIN
                                REPEAT
                                    PCarEnreg.TRANSFERFIELDS(Pcar);
                                    PCarEnreg.INSERT(TRUE);
                                    Pcar.DELETE;
                                UNTIL Pcar.NEXT = 0;
                            END;


                            MissionEnreg.TRANSFERFIELDS(Rec);
                            MissionEnreg.INSERT;

                            IF Veh.GET(REC."N° Véhicule") THEN BEGIN
                                Veh."Index Théorique Final" := Veh."Index Théorique Final" + REC."Km Parcourus";
                                Veh.MODIFY;
                            END;
                            REC.DELETE;
                        END ELSE
                            ERROR(Text002);
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //DYS erreur dans NAV
        // IF REC."Type Vehicule Mission" = REC."Type Vehicule Mission"::"2" THEN BEGIN
        //     "N° VéhiculeEditable" := FALSE;
        //     //Currpage."Index Cpt. Depart".EDITABLE := FALSE;
        //     //Currpage."Index Cpt. Retour".EDITABLE := FALSE;
        // END ELSE BEGIN
        //     "N° VéhiculeEditable" := TRUE;
        //     //Currpage."Index Cpt. Depart".EDITABLE := TRUE;
        //     //Currpage."Index Cpt. Retour".EDITABLE := TRUE;
        // END;

        ville1.RESET;
        ville1.SETRANGE(Code, REC."Lieu départ");
        IF ville1.FIND('-') THEN
            VilDep := ville1.City
        ELSE
            VilDep := '';

        ville2.RESET;
        ville2.SETRANGE(Code, REC."Lieu Arrivé");
        IF ville2.FIND('-') THEN
            VilArrive := ville2.City
        ELSE
            VilArrive := '';
        IF REC."Alerte Vidange" <> '' THEN
            REC.VALIDATE("N° Véhicule");
    end;

    trigger OnInit()
    begin
        "N° VéhiculeEditable" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //DYS ERREUR DANS NAV
        // IF REC."Type Vehicule Mission" = REC."Type Vehicule Mission"::"2" THEN BEGIN
        //     "N° VéhiculeEditable" := FALSE;
        //     //Currpage."Index Cpt. Depart".EDITABLE := FALSE;
        //     //Currpage."Index Cpt. Retour".EDITABLE := FALSE;
        // END ELSE BEGIN
        //     "N° VéhiculeEditable" := TRUE;
        //     //Currpage."Index Cpt. Depart".EDITABLE := TRUE;
        //     //Currpage."Index Cpt. Retour".EDITABLE := TRUE;
        // END;
        ville1.RESET;
        ville1.SETRANGE(Code, REC."Lieu départ");
        IF ville1.FIND('-') THEN
            VilDep := ville1.City
        ELSE
            VilDep := '';

        ville2.RESET;
        ville2.SETRANGE(Code, REC."Lieu Arrivé");
        IF ville2.FIND('-') THEN
            VilArrive := ville2.City
        ELSE
            VilArrive := '';
    end;

    var
        MissionEnreg: Record "Mission Enregistré";
        PCarEnreg: Record "Prise carburant Enregistré";
        Pcar: Record "Prise carburant";
        Veh: Record "Véhicule";
        Miss: Record Missions;
        LigFeuilleCpta: Record "Gen. Journal Line";
        //GL3900    LigFrais: Record "Frais de mission";
        Nligne: Integer;
        PGCPdt: Record "General Posting Setup";
        TmpLigFeuill: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post";
        TempJnlLineDim: Record "Dim. Value per Account";
        //GL3900    FraisMissEnreg: Record "Frais de mission Enregistrées";
        ville1: Record "Post Code";
        VilDep: Text[30];
        VilArrive: Text[30];
        ville2: Record "Post Code";
        // RecBonChargement: Record "Entete Pointage Chauffeur";
        //   RecBonChargementEnre: Record "Ligne Pointage Chauffeur";
        //GL3900   RecCarteAutoroute: Record "Carte Autoroute";
        //GL3900    RecCarteAutorouteEnre: Record "Carte Autoroute enregistrer";
        "N° VéhiculeEditable": Boolean;


    procedure ConsommationGasoil()
    var
        RecPriseCarburant: Record "Prise carburant";
        RecItemJournalLine: Record "Item Journal Line";
        CdeNomFeuille: Text[255];
        RecItemJournalTemplate: Record "Item Journal Template";
        RecInventorySetup: Record "Inventory Setup";
        RecUserSetup: Record "User Setup";
        RecItem: Record Item;
        CdeLocation: Code[20];
        CdeGasoil: Code[20];
        IntNumLigne: Integer;
        CdeNumDoc: Code[20];
        CduNoSeriesRespCentManagement: Codeunit NoSeriesRespCenterManagement;
        CduPurchPost: Codeunit "Purch.-Post";
    begin
        IF RecInventorySetup.GET() THEN;
        IF RecItemJournalTemplate.GET(RecInventorySetup."Model Feuille Article") THEN;

        CdeNumDoc := CduNoSeriesRespCentManagement.GetNextNo(RecItemJournalTemplate."No. Series",
                                     TODAY, FALSE, RecUserSetup."Inventory Resp. Ctr. Filter");
        RecItemJournalLine.SETRANGE("Journal Template Name", RecInventorySetup."Model Feuille Article");
        RecItemJournalLine.SETRANGE("Journal Batch Name", RecInventorySetup."Nom Model Par Defaut");
        RecItemJournalLine.SETRANGE(Utilisateur, USERID);
        RecItemJournalLine.DELETEALL;
        RecPriseCarburant.RESET;
        RecPriseCarburant.SETRANGE("N° Mission", REC."N° Mission");
        IF RecPriseCarburant.FINDFIRST THEN
            REPEAT
                IntNumLigne += 10000;
                RecItemJournalLine."Journal Template Name" := RecInventorySetup."Model Feuille Article";
                RecItemJournalLine."Journal Batch Name" := RecInventorySetup."Nom Model Par Defaut";
                RecItemJournalLine."Line No." := IntNumLigne;
                RecItemJournalLine.VALIDATE("Item No.", RecPriseCarburant."Article Associé");
                MESSAGE(RecPriseCarburant."Article Associé");
                RecItemJournalLine.VALIDATE("Posting Date", TODAY);
                RecItemJournalLine."Entry Type" := RecItemJournalLine."Entry Type"::"Negative Adjmt.";
                RecItemJournalLine."Document No." := CdeNumDoc;
                RecItemJournalLine.VALIDATE(Quantity, RecPriseCarburant."Gasoil Consommé");
                //RecItemJournalLine.VALIDATE("Location Code",Cuve);
                RecItemJournalLine.Materiel := RecPriseCarburant."N° Véhicule";
                //  RecItemJournalLine."Lieu De Livraison / Provenance" := REC."N° Affaire";
                RecItemJournalLine.Marche := rec."N° Affaire";
                RecItemJournalLine.Chauffeur := rec."Code Demandeur";
                RecItemJournalLine.Utilisateur := USERID;
                //  RecItemJournalLine.Chauffeur := REC."Code Demandeur";
                RecItemJournalLine.Destination := REC."Lieu Arrivé";
                RecItemJournalLine.Consommation := TRUE;
                IF RecItem.GET(RecPriseCarburant."Article Associé") THEN;
                RecItemJournalLine."Gen. Prod. Posting Group" := RecItem."Gen. Prod. Posting Group";
                RecItemJournalLine.INSERT;
            UNTIL RecPriseCarburant.NEXT = 0;
        RecItemJournalLine.SETRANGE("Journal Template Name", RecInventorySetup."Model Feuille Article");
        RecItemJournalLine.SETRANGE("Journal Batch Name", RecInventorySetup."Nom Model Par Defaut");
        RecItemJournalLine.SETRANGE(Utilisateur, USERID);
        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", RecItemJournalLine); // STD
    end;
}

