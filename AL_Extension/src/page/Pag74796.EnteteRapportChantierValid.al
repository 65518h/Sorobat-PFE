// page 74796 "Entete Rapport Chantier Validé"
// {//GL2024  ID dans Nav 2009 : "39004796"
//     SourceTable = "Entete Rapport Chantier";
//     SourceTableView = WHERE(Statut = CONST(Validé));
//     PageType = Card;
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 field("<N° Document>"; REC."N° Document")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<N° Document>';
//                 }
//                 field("<Exécution>"; REC.Exécution)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Exécution>';
//                 }
//                 field("<Journee>"; REC.Journee)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Journee>';
//                 }
//                 field("<Vent>"; REC.Vent)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Vent>';
//                 }
//                 field("<Pluie>"; REC.Pluie)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Pluie>';
//                 }
//                 field("<Nombre Heure Journée>"; REC."Nombre Heure Journée")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Nombre Heure Journée>';
//                 }
//                 field("<Temperature>"; REC.Temperature)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Temperature>';
//                 }
//                 field("<PK>"; REC.PK)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<PK>';
//                 }
//                 field("<Marche>"; REC.Marche)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Marche>';
//                 }
//                 field("<Article>"; REC.Article)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Article>';
//                 }
//                 field("<PU>"; REC.PU)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<PU>';
//                 }
//                 field("<Sous Article>"; REC."Sous Article")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Sous Article>';
//                 }
//                 field("<Produit>"; REC.Produit)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Produit>';
//                 }
//                 field("<Chapitre>"; REC.Chapitre)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Chapitre>';
//                 }
//                 field("<Quantité Exécutée>"; REC."Quantité Exécutée")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Quantité Exécutée>';
//                 }
//                 field("<Unité Excécution>"; REC."Unité Excécution")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Unité Excécution>';
//                 }
//                 field("<Statut>"; REC.Statut)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Statut>';
//                 }
//                 field("<Montant Article>"; REC."Montant Article")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Montant Article>';
//                 }
//                 field("<Observation>"; REC.Observation)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Observation>';
//                 }
//                 field("<PT Debut>"; REC."PT Debut")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<PT Debut>';
//                 }
//                 field("<PT Fin>"; REC."PT Fin")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<PT Fin>';
//                 }
//                 field("<Largeur Moyenne>"; REC."Largeur Moyenne")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Largeur Moyenne>';
//                 }
//                 field("<Surface>"; REC.Surface)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Surface>';
//                 }
//                 field("<Volume>"; REC.Volume)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Volume>';
//                 }
//                 group(COUT)
//                 {
//                     field("<Cout MO>"; REC."Cout MO")
//                     {
//                         ApplicationArea = All;
//                         Caption = '<Cout MO>';
//                     }
//                     field("<Cout Engins>"; REC."Cout Engins")
//                     {
//                         ApplicationArea = All;
//                         Caption = '<Cout Engins>';
//                     }
//                     field("<Cout Transport>"; REC."Cout Transport")
//                     {
//                         ApplicationArea = All;
//                         Caption = '<Cout Transport>';
//                     }
//                     field("<Cout Appro>"; REC."Cout Appro")
//                     {
//                         ApplicationArea = All;
//                         Caption = '<Cout Appro>';
//                     }
//                     field("<Cout Total>"; REC."Cout Total")
//                     {
//                         ApplicationArea = All;
//                         Caption = '<Cout Total>';
//                     }
//                     field("<Cout Unitaire Exécuté>"; REC."Cout Unitaire Exécuté")
//                     {
//                         ApplicationArea = All;
//                         Caption = '<Cout Unitaire Exécuté>';
//                     }
//                 }
//                 group(RATIOS)
//                 {

//                     field(Mo1; RatioMo)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field(Engins1; RatioEngin)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field(Transport; RatioTransport)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field(Appro1; RationAppro)
//                     {
//                         ApplicationArea = All;
//                     }
//                 }
//             }
//             part(MO; "Ligne rapport Chantier APPRO")
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "N° Document" = FIELD("N° Document");
//             }
//             part(ENGINS; "Ligne rapport Chantier Engins")
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "N° Document" = FIELD("N° Document");
//             }
//             group(APPRO)
//             {
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group(Fonction)
//             {
//                 action("Calcul Cout General")
//                 {
//                     ApplicationArea = All;
//                     ShortCutKey = 'F11';

//                     trigger OnAction()
//                     begin
//                         CoutMo;
//                     end;
//                 }
//                 action(Cloturer)
//                 {
//                     ApplicationArea = All;

//                     trigger OnAction()
//                     begin
//                         IF NOT CONFIRM(Text001) THEN EXIT;
//                         CoutMo;
//                         REC.Statut := REC.Statut::Validé;
//                         REC.MODIFY;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         IF REC."Cout Total" <> 0 THEN BEGIN
//             RatioMo := (REC."Cout MO" / REC."Cout Total") * 100;
//             RatioEngin := (REC."Cout Engins" / REC."Cout Total") * 100;
//             RatioTransport := (REC."Cout Transport" / REC."Cout Total") * 100;
//             RationAppro := (REC."Cout Appro" / REC."Cout Total") * 100;
//         END;
//         IF REC.Statut = REC.Statut::Validé THEN CurrPage.EDITABLE := FALSE
//     end;

//     trigger OnOpenPage()
//     begin
//         IF REC.Statut = REC.Statut::Validé THEN CurrPage.EDITABLE := FALSE
//     end;

//     var
//         LigneRapportChantier: Record "Ligne Rapport Chantier";
//         Mo: Decimal;
//         Engins: Decimal;
//         Transport: Decimal;
//         Appro: Decimal;
//         RatioMo: Decimal;
//         RatioEngin: Decimal;
//         RatioTransport: Decimal;
//         RationAppro: Decimal;
//         LigneRendementVehiculeEnr: Record "Ligne Rendement Vehicule Enr";
//         Text001: Label 'Confirmer Cette Action ?';


//     procedure CoutMo()
//     var
//         Resource: Record Resource;
//         Vehicule: Record "Véhicule";
//         Item: Record Item;
//         "ParamétreParc": Record "Paramétre Parc";
//     begin
//         IF REC.Statut = REC.Statut::Validé THEN EXIT;
//         IF NOT CONFIRM(Text001) THEN EXIT;
//         IF ParamétreParc.GET THEN;
//         LigneRapportChantier.SETRANGE("N° Document", REC."N° Document");
//         LigneRapportChantier.MODIFYALL(Journee, REC.Journee);
//         COMMIT;
//         Mo := 0;
//         Engins := 0;
//         Transport := 0;
//         Appro := 0;
//         LigneRapportChantier.SETRANGE("N° Document", REC."N° Document");
//         IF LigneRapportChantier.FINDFIRST THEN
//             REPEAT
//                 IF LigneRapportChantier.Ressource = LigneRapportChantier.Ressource::MO THEN BEGIN
//                     IF Resource.GET(LigneRapportChantier.MO) THEN BEGIN
//                         IF ParamétreParc."Heure Travail" = 0 THEN ParamétreParc."Heure Travail" := 9;
//                         LigneRapportChantier."Cout Journalier" := Resource."Unit Cost";
//                         LigneRapportChantier.Cout := (Resource."Unit Cost" * LigneRapportChantier."Tot Heure") / ParamétreParc."Heure Travail";
//                     END;
//                     Mo += LigneRapportChantier.Cout;
//                 END;
//                 IF LigneRapportChantier.Ressource = LigneRapportChantier.Ressource::Engins THEN BEGIN
//                     IF Vehicule.GET(LigneRapportChantier.Materiel) THEN;
//                     LigneRapportChantier.Cout := (Vehicule."Cout Location Journaliere" *
//                                                        LigneRapportChantier."Tot Heure") / ParamétreParc."Heure Travail";
//                     /*
//                     LigneRapportChantier.Cout:=Vehicule.CoutMaterielTransport(Journee-30,Journee,
//                                                LigneRapportChantier.Materiel,0,0,TRUE);
//                    IF ParamétreParc."Heure Travail"<>0 THEN
//                         LigneRapportChantier.Cout:=LigneRapportChantier.Cout *LigneRapportChantier."Tot Heure"/ParamétreParc."Heure Travail";
//                     */
//                     LigneRapportChantier."Cout Journalier" := Vehicule."Cout Location Journaliere";
//                     Engins += LigneRapportChantier.Cout;
//                 END;
//                 IF LigneRapportChantier.Ressource = LigneRapportChantier.Ressource::Appro THEN BEGIN
//                     IF Item.GET(LigneRapportChantier.Produit) THEN
//                         LigneRapportChantier.Cout := Item."Last Direct Cost" * LigneRapportChantier."Quantité Excutée";
//                     Appro += LigneRapportChantier.Cout;
//                 END;
//                 IF LigneRapportChantier.Ressource = LigneRapportChantier.Ressource::Transport THEN BEGIN
//                     IF Vehicule.GET(LigneRapportChantier.Materiel) THEN;
//                     LigneRapportChantier.Cout := (Vehicule."Cout Location Journaliere" *
//                                                        LigneRapportChantier."Tot Heure") / ParamétreParc."Heure Travail";

//                     //IF LigneRapportChantier.Volume=0 THEN  LigneRapportChantier.Volume:=1;
//                     // LigneRapportChantier.Cout:= LigneRapportChantier.Cout/LigneRapportChantier.Volume;
//                     Transport += LigneRapportChantier.Cout;

//                 END;

//                 LigneRapportChantier.MODIFY;
//             UNTIL LigneRapportChantier.NEXT = 0;
//         REC."Cout MO" := Mo;
//         REC."Cout Engins" := Engins;
//         REC."Cout Transport" := Transport;
//         REC."Cout Appro" := Appro;
//         REC."Cout Total" := REC."Cout MO" + REC."Cout Engins" + REC."Cout Transport" + REC."Cout Appro";
//         REC."Cout Unitaire Exécuté" := REC."Cout Total" / REC."Quantité Exécutée";
//         REC.MODIFY;
//         IF REC."Cout Total" <> 0 THEN BEGIN
//             RatioMo := (REC."Cout MO" / REC."Cout Total") * 100;
//             RatioEngin := (REC."Cout Engins" / REC."Cout Total") * 100;
//             RatioTransport := (REC."Cout Transport" / REC."Cout Total") * 100;
//             RationAppro := (REC."Cout Appro" / REC."Cout Total") * 100;
//         END;

//     end;


//     procedure CoutMateriel()
//     begin
//     end;


//     procedure CoutTransport()
//     begin
//     end;


//     procedure CoutAppro()
//     begin
//     end;
// }

