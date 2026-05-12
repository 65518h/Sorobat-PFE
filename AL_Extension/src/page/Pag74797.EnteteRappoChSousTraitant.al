// page 74797 "Entete Rappo Ch Sous Traitant"
// {//GL2024  ID dans Nav 2009 : "39004797"
//     SourceTable = "Entete Rapport Chantier";
//     SourceTableView = WHERE(Statut = CONST(Ouvert),
//                             "Sous Traitant" = FILTER(true));
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
//                 field("<Sous Traitant>"; REC."Sous Traitant")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Sous Traitant>';
//                 }
//                 field("<Agent Saisie>"; REC."Agent Saisie")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Agent Saisie>';
//                 }
//                 field("<Journee>"; REC.Journee)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Journee>';
//                 }
//                 field("<Date Saisie>"; REC."Date Saisie")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Date Saisie>';
//                 }
//                 field(Chantier; REC.Marche)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Nom Sous Traitant"; REC."Nom Responsable")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Nom Sous Traitant';
//                 }
//                 field("<Lot Marché>"; REC."Lot Marché")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Lot Marché>';
//                 }
//                 field("<Article Marché>"; REC."Article Marché")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Article Marché>';
//                 }
//                 field("<Emplacement>"; REC.Emplacement)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Emplacement>';
//                 }
//                 field("<Observation>"; REC.Observation)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Observation>';
//                 }
//                 field("<Statut>"; REC.Statut)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Statut>';
//                 }
//                 field("<Article>"; REC.Article)
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Article>';
//                 }
//                 field("<Description Article>"; REC."Description Article")
//                 {
//                     ApplicationArea = All;
//                     Caption = '<Description Article>';
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
//                     field("Cout Gasoil"; REC."Cout Gasoil")
//                     {
//                         ApplicationArea = All;
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

//                     field(Mo; RatioMo)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field(Engins; RatioEngin)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field(Transport; RatioTransport)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field(Appro; RationAppro)
//                     {
//                         ApplicationArea = All;
//                     }
//                 }
//             }
//             part("QUANTITE EXECUTE"; "Ligne rapport Chantier S Trait")
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "N° Document" = FIELD("N° Document");
//             }
//             part(APPROVISIONNEMENT; "Ligne rapport Chantier APPRO")
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "N° Document" = FIELD("N° Document");
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
//                         //CoutMo;
//                         REC.Statut := REC.Statut::Validé;
//                         REC.MODIFY;
//                     end;
//                 }
//                 action("Calcul Cout En Lot")
//                 {
//                     ApplicationArea = All;
//                     RunObject = Report "Calculer Cout Rpt Ch En Lot";
//                 }
//                 action(Verification)
//                 {
//                     ApplicationArea = All;
//                     RunObject = Report "Verifier Rapport Chantier";
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

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         REC."Sous Traitant" := TRUE;
//     end;

//     trigger OnOpenPage()
//     begin
//         IF REC.Statut = REC.Statut::Validé THEN CurrPage.EDITABLE := FALSE
//     end;

//     var
//         EnteteRapportChantier: Record "Entete Rapport Chantier";
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
//         ConsomGasoil: Decimal;
//         LigneFicheGasoil: Record "Ligne Fiche Gasoil";
//         "ParamétreParc": Record "Paramétre Parc";
//         Item: Record Item;
//         Employee: Record Employee;
//         NbrEmployee: Integer;
//         SommeSbrut: Decimal;
//         SalaireBrut: Decimal;
//         MoyenneSalaire: Decimal;
//         Job: Record Job;
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
//         REC."Cout Gasoil" := 0;
//         REC."Cout MO" := 0;
//         REC."Cout Engins" := 0;
//         REC."Cout Transport" := 0;
//         REC."Cout Appro" := 0;
//         REC."Cout Total" := 0;
//         REC."Cout Unitaire Exécuté" := 0;
//         RatioMo := 0;
//         RatioEngin := 0;
//         RatioTransport := 0;
//         RationAppro := 0;
//         Mo := 0;
//         Engins := 0;
//         Transport := 0;
//         Appro := 0;
//         NbrEmployee := 0;
//         SommeSbrut := 0;
//         SalaireBrut := 0;
//         ConsomGasoil := 0;
//         LigneRapportChantier.SETRANGE("N° Document", REC."N° Document");
//         IF LigneRapportChantier.FINDFIRST THEN
//             REPEAT
//                 IF LigneRapportChantier.Ressource = LigneRapportChantier.Ressource::MO THEN BEGIN
//                     IF Resource.GET(LigneRapportChantier.MO) THEN BEGIN
//                         IF NOT Resource."MO Conducteur Engin" THEN BEGIN
//                             Employee.SETRANGE(Qualification, Resource.Qualification);
//                             Employee.SETRANGE(Blocked, FALSE);
//                             IF Employee.FINDFIRST THEN
//                                 REPEAT
//                                     Employee.CALCFIELDS("Total Indemnité Par Defaut");
//                                     IF Employee."Salaire De Base Horaire" = 0 THEN
//                                         SalaireBrut := Employee."Total Indemnité Par Defaut" + Employee."Basis salary"
//                                     ELSE
//                                         SalaireBrut := Employee."Total Indemnité Par Defaut" + Employee."Salaire De Base Horaire";
//                                     SalaireBrut := SalaireBrut * 1.237;
//                                     NbrEmployee += 1;
//                                     SommeSbrut += SalaireBrut;
//                                 UNTIL Employee.NEXT = 0;
//                             IF NbrEmployee <> 0 THEN BEGIN
//                                 MoyenneSalaire := (SommeSbrut / NbrEmployee) / 26;
//                                 IF ParamétreParc."Heure Travail" = 0 THEN ParamétreParc."Heure Travail" := 9;
//                                 LigneRapportChantier."Cout Journalier" := MoyenneSalaire;
//                                 LigneRapportChantier.Cout := ((MoyenneSalaire * LigneRapportChantier."Tot Heure") / ParamétreParc."Heure Travail")
//                                                           * LigneRapportChantier."Nombre Ressource";
//                             END;
//                         END;
//                     END;
//                     Mo += LigneRapportChantier.Cout;
//                 END;

//                 IF LigneRapportChantier.Ressource = LigneRapportChantier.Ressource::Engins THEN BEGIN
//                     IF Vehicule.GET(LigneRapportChantier.Materiel) THEN;
//                     LigneRapportChantier.Cout := (Vehicule."Cout Location Journaliere" *
//                                                        LigneRapportChantier."Tot Heure") / ParamétreParc."Heure Travail";

//                     ConsomGasoil += LigneRapportChantier."Tot Heure" * Vehicule."Consommation Moyen";
//                     //   LigneFicheGasoil.SETRANGE(Journee,Journee);
//                     //   LigneFicheGasoil.SETRANGE(Materiel,LigneRapportChantier.Materiel);
//                     //   IF LigneFicheGasoil.FINDFIRST THEN
//                     //     REPEAT
//                     //       ConsomGasoil+=LigneFicheGasoil."Quantité Gasoil";
//                     //     UNTIL LigneFicheGasoil.NEXT=0;
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
//                         IF Job.GET(REC.Marche) THEN BEGIN
//                             IF Item."Remblais/Deblais" = Item."Remblais/Deblais"::Remblais THEN
//                                 IF Job."Remblais Valoriser" THEN BEGIN
//                                     LigneRapportChantier.Cout := Item."Last Direct Cost" * LigneRapportChantier."Quantité Excutée";
//                                     Appro += LigneRapportChantier.Cout;
//                                 END;
//                             IF Item."Remblais/Deblais" = Item."Remblais/Deblais"::Deblais THEN
//                                 IF Job."Deblais Valoriser" THEN BEGIN
//                                     LigneRapportChantier.Cout := Item."Last Direct Cost" * LigneRapportChantier."Quantité Excutée";
//                                     Appro += LigneRapportChantier.Cout;
//                                 END;
//                             IF Item."Remblais/Deblais" = 0 THEN BEGIN

//                                 LigneRapportChantier.Cout := Item."Last Direct Cost" * LigneRapportChantier."Quantité Excutée";
//                                 Appro += LigneRapportChantier.Cout;
//                             END;

//                         END;
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
//         IF ParamétreParc.GET THEN;
//         IF Item.GET(ParamétreParc."Article Gasoil") THEN;
//         REC."Cout Gasoil" := ConsomGasoil * Item."Last Direct Cost";
//         REC."Cout MO" := Mo;
//         REC."Cout Engins" := Engins;
//         REC."Cout Transport" := Transport;
//         REC."Cout Appro" := Appro;
//         REC."Cout Total" := REC."Cout MO" + REC."Cout Engins" + REC."Cout Transport" + REC."Cout Appro" + REC."Cout Gasoil";
//         IF REC."Quantité Exécutée" <> 0 THEN
//             REC."Cout Unitaire Exécuté" := REC."Cout Total" / REC."Quantité Exécutée";
//         REC.MODIFY;
//         IF REC."Cout Total" <> 0 THEN BEGIN
//             RatioMo := (REC."Cout MO" / REC."Cout Total") * 100;
//             RatioEngin := (REC."Cout Engins" / REC."Cout Total") * 100;
//             RatioTransport := (REC."Cout Transport" / REC."Cout Total") * 100;
//             RationAppro := ((REC."Cout Appro" + REC."Cout Gasoil") / REC."Cout Total") * 100;
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

