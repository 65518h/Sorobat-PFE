//GL3900 
// Page 72167 "Intervention préventive Equi"
// {//GL2024  ID dans Nav 2009 : "39002167"
//     Editable = true;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "Equip. Reparation Préventive";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             field("N° Equip"; "N° Equip")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'N° Equipement';
//                 TableRelation = Equipement;

//                 trigger OnValidate()
//                 begin
//                     Rec.Reset;
//                     Rec.SetRange("N° Equipement", "N° Equip");
//                     N176EquipOnAfterValidate;
//                 end;
//             }
//             repeater(Control1000000000)
//             {
//                 Editable = false;
//                 field("N° Equipement"; Rec."N° Equipement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code intervention"; Rec."Code intervention")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Désignation intervention"; Rec."Désignation intervention")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Fréquence (Nb Jours)"; Rec."Fréquence (Nb Jours)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Fréquence (Nb Heures)"; Rec."Fréquence (Nb Heures)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Intervention)
//             {
//                 Caption = 'Intervention';
//                 action("Traiter intervention")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Traiter intervention';

//                     trigger OnAction()
//                     begin
//                         //>> SDK : CREATION OTP/BTP

//                         CurrPage.SetSelectionFilter(Rec);
//                         if Rec.FindFirst then
//                             repeat
//                                 RecBTP.Reset;
//                                 RecBTP.SetRange(cd_box, Rec."N° Equipement");
//                                 RecBTP.SetRange("code intervention", Rec."Code intervention");
//                                 if RecBTP.FindFirst then
//                                     repeat
//                                         if RecBTP.dt_fin = 0D then
//                                             Error(error001, Rec."Code intervention", Rec."N° Equipement", RecBTP.cd_OTP)
//                                         else
//                                             if (CalcDate(Rec."Fréquence (Nb Jours)", RecBTP.dt_fin) < WorkDate) then
//                                                 Error(error002, Rec."N° Equipement", Rec."Code intervention");
//                                     until RecBTP.Next = 0;
//                             until Rec.Next = 0;


//                         NumBTP := 1;
//                         RecOTP.Init;
//                         Workmgt.Get;
//                         Workmgt.TestField(Workmgt."Preventive work order");
//                         RecOTP."code OTP" := Noseriesmgt.GetNextNo(Workmgt."Preventive work order", WorkDate, true);
//                         RecOTP.dt_create := WorkDate;
//                         RecOTP.Validate(cd_box, Rec."N° Equipement");
//                         RecOTP."Type Declencheur" := RecOTP."type declencheur"::Calendaire;
//                         RecOTP.Titre := 'Preventive' + '  ' + Format("N° Equip");
//                         RecOTP.user_create := UserId;
//                         RecOTP.priorité := RecOTP.Priorité::Secondaire;
//                         RecOTP.nature := 'PREV';
//                         RecOTP.status := RecOTP.Status::Planifié;
//                         if RecOTP.Insert then begin
//                             CurrPage.SetSelectionFilter(Rec);
//                             if Rec.FindFirst then
//                                 repeat
//                                     RecBTP.Init;
//                                     RecBTP.cd_OTP := RecOTP."code OTP";
//                                     RecBTP."code BTP" := NumBTP;
//                                     RecBTP.priorité := RecOTP.priorité;
//                                     RecBTP.dt_debut := WorkDate;
//                                     RecBTP.Titre := Rec."Désignation intervention";
//                                     RecBTP."code intervention" := Rec."Code intervention";
//                                     RecBTP.status := RecOTP.status;
//                                     RecBTP.nature := RecOTP.nature;
//                                     RecBTP.Validate(cd_box, RecOTP.cd_box);
//                                     if RecBTP.Insert then
//                                         NumBTP := NumBTP + 1;
//                                 until Rec.Next = 0;
//                             Message(text001, RecOTP."code OTP");
//                         end;

//                         //<< SDK : CREATION OTP/BTP
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         Rec.Reset;
//         "N° Equip" := '';
//     end;

//     var
//         "N° Equip": Code[10];
//         RecOTP: Record OTP;
//         RecBTP: Record BTP;
//         RecListePannes: Record "Pannes Préventif Equipement";
//         RecPanneParEquipement: Record "Equip. Reparation Préventive";
//         Workmgt: Record "Work Setup";
//         Noseriesmgt: Codeunit NoSeriesManagement;
//         gmaomgt: Record "Gmao Setup";
//         NumBTP: Integer;
//         text001: label 'Votre intervention a été rattachée à l''OPT : %1';
//         error001: label 'Code intervention %1 pour l''''equipement %2 existe déja dans OTP %3';
//         OTPexite: Code[10];
//         error002: label 'Date préventive est non encore atteint pour l''''equipement %1 et code intervention %2';

//     local procedure N176EquipOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;
// }

