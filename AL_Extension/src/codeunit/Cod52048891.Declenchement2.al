//GL3900
// Codeunit 52048891 Declenchement2
// {

//     //GL2024  ID dans Nav 2009 : "39002018"

//     Permissions = TableData "Source Code Setup" = r;
//     /* GL2024 TableData 90069 = rimd,
//       TableData 90052 = rimd;*/

//     trigger OnRun()
//     var
//         ChangeStatusForm: Page "Change Status on Work. Order";
//     begin

//         //DeclenchementCalendaire;
//         //DeclenchementMesure;
//         DeclenchementSymptome;
//     end;

//     var
//         Text000: label '%1 %2 %3 has been changed to %4 %5 %6.';
//         Declencheur: Record "Déclencheur";
//         SourceCodeSetup: Record "Source Code Setup";
//         RecGSyptomeEquipement: Record "symptôme equipement";
//         RecGSyptomeEquipement2: Record "symptôme equipement";
//         RecGOTP: Record OTP;
//         RecGBTP: Record BTP;
//         Noseriesmgt: Codeunit NoSeriesManagement;
//         CdeGNumOTP: Code[20];
//         valItem: Boolean;
//         workmgt: Record "Work Setup";
//         i: Integer;
//         g: Integer;
//         ReleveMesure: Record "Relevé mesure";
//         TypeMesure: Record "Type mesure";
//         PointMesure: Record "Point mesure";


//     procedure DeclenchementCalendaire()
//     begin

//         /*Declencheur.SETRANGE(Code,Actif);
//         IF Declencheur.FINDFIRST  THEN ;
//         CASE Declencheur.Type OF
//          Declencheur.Type::Sur Déclenchement Calendaire:
//            BEGIN

//          IF "Date Fixe" THEN
//            BEGIN
//              IF CALCDATE('+'+FORMAT(Declencheur.Durée)+'M',Declencheur.ProchainLancementd ) = WORKDATE THEN
//              BEGIN
//              INIT;
//              MESSAGE(Text000 +' ' + FORMAT(WORKDATE) );
//              dt_create:= WORKDATE;
//              MODIFY;
//              END;
//            END;

//           ELSE

//          CASE Declencheur.Période OF
//           ************************************************
//            Declencheur.Période::Jours:
//            BEGIN
//               IF CALCDATE('+'+FORMAT(Declencheur.Durée)+'J',Declencheur.Prévue ) = WORKDATE THEN
//               BEGIN
//               INIT;
//               MESSAGE(Text000 +' ' + FORMAT(WORKDATE) );
//               dt_create:= WORKDATE;
//               Declencheur.Prévue := WORKDATE;
//               MODIFY;
//               END;
//            END;
//            ***********************************************
//             Declencheur.Période::Semaines:
//            BEGIN
//              IF CALCDATE('+'+FORMAT(Declencheur.Durée)+'S',Declencheur.Prévue ) = WORKDATE THEN
//              BEGIN
//              INIT;
//              MESSAGE(Text000 +' ' + FORMAT(WORKDATE) );
//              dt_create:= WORKDATE;
//              MODIFY;
//              END;
//            END;
//            ***********************************************
//             GDeclanch.Période::Mois:
//            BEGIN
//              IF CALCDATE('+'+FORMAT(Declencheur.Durée)+'M',Declencheur.Prévue ) = WORKDATE THEN
//              BEGIN
//              INIT;
//              MESSAGE(Text000 +' ' + FORMAT(WORKDATE) );
//              dt_create:= WORKDATE;
//              MODIFY;
//              END;
//            END;
//            ************************************************
//             GDeclanch.Période:: Années:
//            BEGIN
//              IF CALCDATE('+'+FORMAT(Declencheur.Durée)+'M',Declencheur.Prévue ) = WORKDATE THEN
//              BEGIN
//              INIT;
//              MESSAGE(Text000 +' ' + FORMAT(WORKDATE) );
//              dt_create:= WORKDATE;
//              MODIFY;
//              END;
//            END;
//         END;    */

//     end;

//     local procedure DeclenchementSymptome()
//     begin
//         //>> HJ 18-07-2008  Declencheur Symptome
//         Declencheur.Reset;
//         Declencheur.SetRange(Type, Declencheur.Type::"Sur Symptôme");
//         Declencheur.SetRange(Actif, true);
//         if Declencheur.FindFirst then
//             repeat
//                 RecGSyptomeEquipement.SetRange(Traité, false);
//                 RecGSyptomeEquipement.SetRange(cd_box, Declencheur.Equipement);
//                 RecGSyptomeEquipement.SetRange(cd_sympt, Declencheur.Symptôme);
//                 RecGSyptomeEquipement.SetRange(Date, WorkDate);
//                 if RecGSyptomeEquipement.FindFirst then CréerOTP(Declencheur.Equipement, Declencheur.Symptôme, 1);
//             until Declencheur.Next = 0;
//         //<< HJ 18-07-2008  Declencheur Symptome
//     end;

//     local procedure DeclenchementMesure()
//     begin
//     end;


//     procedure "CréerOTP"(CdeLEquipement: Code[20]; CdeLSyptome: Code[20]; CdeLTypeDeclencheur: Integer)
//     begin
//         //>> HJ 18-07-2008  Creation OTP & BTP
//         // Création OTP
//         RecGOTP.Init;
//         RecGOTP.cd_box := CdeLEquipement;
//         RecGOTP.Validate(cd_box);
//         RecGOTP.dt_create := WorkDate;
//         RecGOTP."Type Declencheur" := CdeLTypeDeclencheur;
//         RecGOTP.status := RecGOTP.Status::Planifié;
//         RecGOTP.Insert(true);
//         // Fin Création OTP
//         // MAJ TABLE SYPTOME EQUIP FLAG TRAITE
//         RecGSyptomeEquipement2.SetRange(Traité, false);
//         RecGSyptomeEquipement2.SetRange(cd_box, CdeLEquipement);
//         RecGSyptomeEquipement2.SetRange(cd_sympt, CdeLSyptome);
//         RecGSyptomeEquipement2.SetRange(Date, WorkDate);
//         if RecGSyptomeEquipement2.FindFirst then begin
//             RecGSyptomeEquipement2.Traité := true;
//             RecGSyptomeEquipement2.Modify;
//         end;
//         // FIN MAJ TABLE SYPTOME EQUIP FLAG TRAITE
//         //<< HJ 18-07-2008  Creation OTP & BTP
//     end;
// }

