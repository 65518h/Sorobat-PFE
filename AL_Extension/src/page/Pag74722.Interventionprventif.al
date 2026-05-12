//GL3900 
// Page 74722 "Intervention préventif"
// {//GL2024  ID dans Nav 2009 : "39004722"
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = "Veh. Reparation Préventive";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             field("N° Veh"; "N° Veh")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'N° Véhicule :';
//                 LookupPageID = "List Véhicules";
//                 TableRelation = Véhicule;

//                 trigger OnValidate()
//                 begin
//                     Rec.Reset;
//                     Rec.SetRange("N° Véhicule", "N° Veh");
//                     N176VehOnAfterValidate;
//                 end;
//             }
//             repeater(Control1)
//             {
//                 Editable = false;
//                 field("N° Véhicule"; Rec."N° Véhicule")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code Reparation"; Rec."Code Reparation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Désignation réparation"; Rec."Désignation réparation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Fréquence (Index)"; Rec."Fréquence (Index)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Fréquence (Jour)"; Rec."Fréquence (Jour)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(DateDerInterven; DateDerInterven)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Date derniére intervention';

//                     trigger OnAssistEdit()
//                     begin
//                         if DateDerInterven <> 0D then
//                             PAGE.Run(70041, Repa);
//                     end;
//                 }
//                 field(DernierIndex; DernierIndex)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Dernier Index - intervention';
//                     DecimalPlaces = 0 : 0;
//                 }
//                 field("Veh.""Index Théorique Final"""; Veh."Index Théorique Final")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Dernier Index théorique';
//                     DecimalPlaces = 0 : 0;
//                 }
//                 field(Intervenir; Intervenir)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Intervenir';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Réparation")
//             {
//                 Caption = 'Réparation';
//                 action("Traiter Réparation")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Traiter Réparation';

//                     trigger OnAction()
//                     begin
//                         if Intervenir then begin
//                             if Confirm('Voulez Vous Créer une fiche réparation !') then begin
//                                 ParcSetup.Get;
//                                 RepVeh.Reset;
//                                 RepVeh.Init;
//                                 NoSeriesMgt.InitSeries(ParcSetup."N° Réparation", ParcSetup."N° Réparation", 0D, RepVeh."N° Reparation", RepVeh."No. Series");
//                                 RepVeh.Validate("N° Véhicule", Rec."N° Véhicule");
//                                 RepVeh.Validate("Date Acceptation", Today);
//                                 RepVeh.Validate("Date Début Réparation", Today);
//                                 RepVeh.Type := RepVeh.Type::Préventive;
//                                 RepVeh."Degré d'Urgence" := RepVeh."degré d'urgence"::Urgent;
//                                 RepVeh.Insert;
//                                 LigneRep.Reset;
//                                 LigneRep.Init;
//                                 LigneRep."N° Reparation" := RepVeh."N° Reparation";
//                                 LigneRep."N° Ligne" := 10000;
//                                 LigneRep."Type Réparation" := LigneRep."type réparation"::Reparer;
//                                 LigneRep.Validate("Code Réparation", Rec."Code Reparation");
//                                 LigneRep.Insert;
//                                 PAGE.Run(70030, RepVeh);
//                             end;
//                         end else
//                             Error('La Réparation n''est pas encore prévue');
//                     end;
//                 }
//             }
//             group("Véhicule")
//             {
//                 Caption = 'Véhicule';
//                 action(Fiche)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Fiche';

//                     trigger OnAction()
//                     begin

//                         Veh.Reset;
//                         Veh.SetRange("N° Vehicule", "N° Veh");
//                         if Veh.Find('-') then
//                             PAGE.Run(39004670, Veh);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         Intervenir := false;
//         if "N° Veh" <> '' then begin
//             Veh.SetRange("N° Vehicule", "N° Veh");
//             if Veh.Find('-') then
//                 Veh.CalcFields("Kms Parcourus");

//             DetailRep.SetRange("N° Véhicule", "N° Veh");
//             DetailRep.SetRange("Code Réparation", Rec."Code Reparation");
//             if DetailRep.Find('+') then begin
//                 Repa.SetRange("N° Reparation", DetailRep."N° Reparation");
//                 if Repa.Find('-') then begin
//                     DateDerInterven := Repa."Date Début Réparation";
//                     DernierIndex := Repa.Index;
//                 end else begin
//                     DateDerInterven := 0D;
//                     DernierIndex := 0;
//                 end;
//             end else begin
//                 DateDerInterven := 0D;
//                 DernierIndex := 0;
//             end;

//             if Rec."Fréquence (Index)" <> 0 then begin
//                 if Veh."Index Théorique Final" - DernierIndex > Rec."Fréquence (Index)" then
//                     Intervenir := true
//                 else
//                     Intervenir := false;
//             end else begin
//                 if Rec."Fréquence (Jour)" <> 0 then
//                     if (Today - DateDerInterven) > Rec."Fréquence (Jour)" then
//                         Intervenir := true
//                     else
//                         Intervenir := false;
//             end;
//         end;
//         //CurrForm.UPDATE;
//     end;

//     trigger OnOpenPage()
//     begin
//         Rec.Reset;
//         "N° Veh" := '';
//     end;

//     var
//         "N° Veh": Code[10];
//         DateDerInterven: Date;
//         Intervenir: Boolean;
//         Repa: Record "Réparation Véhicule Enreg.";
//         DetailRep: Record "Détail Reparation Enreg.";
//         DernierIndex: Decimal;
//         Veh: Record "Véhicule";
//         RepVeh: Record "Réparation Véhicule";
//         LigneRep: Record "Détail Reparation";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         ParcSetup: Record "Paramétre Parc";
//         RecVehRepPrev: Record "Veh. Reparation Préventive";

//     local procedure N176VehOnAfterValidate()
//     begin
//         CurrPage.Update(false);
//     end;
// }

