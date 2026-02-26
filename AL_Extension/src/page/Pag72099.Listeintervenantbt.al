//GL3900 
// Page 72099 "Liste intervenant/bt"
// {
//     //GL2024  ID dans Nav 2009 : "39002099"
//     Caption = 'Resource Card';
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = "Intervenant/bt";
//     ApplicationArea = all;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;

//                 field("Type Intervenant"; Rec."Type Intervenant")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(cd_resource; Rec.cd_resource)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Nom; Rec.Nom)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Base Unit of Measure"; Rec."Base Unit of Measure")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Unit cost"; Rec."Unit cost")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Quantité_prévue"; Rec.Quantité_prévue)
//                 {
//                     Editable = "Quantité_prévueEDITABLE";
//                     ApplicationArea = Basic;
//                 }
//                 field("Qauntité_réalisée"; Rec.Qauntité_réalisée)
//                 {
//                     Editable = "Qauntité_réaliséeEDITABLE";
//                     ApplicationArea = Basic;
//                 }
//                 field("N° doc"; Rec."N° doc")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Date comptabilisation"; Rec."Date comptabilisation")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {

//         area(processing)
//         {
//             group("&Validation")
//             {
//                 Caption = '&Validation';
//                 action("Export to Res. journal")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Export to Res. journal';

//                     trigger OnAction()
//                     var
//                         jnitem: Page "Consumption Journal GMAO";
//                     begin

//                         BT.Reset;
//                         if BT.Get(Rec.cd_ot, Rec.cd_bt) then
//                             ConsTreatment."ExportToRes.Journal"(BT, false);
//                     end;
//                 }
//                 action("&Validate")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = '&Validate';
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         INTER.Reset;
//                         INTER.SetFilter(INTER.cd_ot, Rec.cd_ot);
//                         INTER.SetRange(INTER.cd_bt, Rec.cd_bt);
//                         INTER.SetRange(INTER.Validé, false);
//                         if INTER.Find('-') then begin
//                             BT.Reset;
//                             if BT.Get(Rec.cd_ot, Rec.cd_bt) then
//                                 ConsTreatment.ValidateResConsumption(BT, false);
//                         end else
//                             Message(txt);
//                     end;
//                 }
//                 action("Validate and print")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Validate and print';
//                     ShortCutKey = 'Maj+F11';

//                     trigger OnAction()
//                     begin

//                         INTER.Reset;
//                         INTER.SetFilter(INTER.cd_ot, Rec.cd_ot);
//                         INTER.SetRange(INTER.cd_bt, Rec.cd_bt);
//                         INTER.SetRange(INTER.Validé, false);
//                         if INTER.Find('-') then begin
//                             BT.Reset;
//                             if BT.Get(Rec.cd_ot, Rec.cd_bt) then
//                                 ConsTreatment.ValidateResConsumptionAndPrint(BT, false);
//                         end else
//                             Message(txt);
//                     end;
//                 }
//             }
//             action(Navigate)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Navigate';
//                 Image = Navigate;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     nav: Page Navigate;
//                 begin

//                     if Rec."N° doc" <> '' then begin
//                         nav.SetDoc(Rec."Date comptabilisation", Rec."N° doc");
//                         nav.Run;
//                     end;
//                 end;
//             }
//             action("S&kills")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'S&kills';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     ItemPanel.ShowSkillRes(Rec);
//                 end;
//             }
//             action("Availa&bility")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Availa&bility';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     ItemPanel.ResAvailability(Rec);
//                 end;
//             }
//             action("&Resource Card")
//             {
//                 ApplicationArea = Basic;
//                 Caption = '&Resource Card';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if RES.Get(Rec.cd_resource) then
//                         Page.Run(Page::"Resource Card", RES);
//                 end;
//             }
//         }
//     }

//     var
//         RES: Record Resource;
//         ItemPanel: Codeunit BtInfoPanel;
//         BT: Record BT;
//         ConsTreatment: Codeunit "Consumption treatment";
//         INTER: Record "Intervenant/bt";
//         txt: label 'All consumption are validated';
//         Quantité_prévueEDITABLE: Boolean;
//         Qauntité_réaliséeEDITABLE: Boolean;

//     procedure planned()
//     begin

//         Quantité_prévueEDITABLE := TRUE;
//         Qauntité_réaliséeEDITABLE := FALSE;
//     end;


//     procedure lanced()
//     begin
//         Quantité_prévueEDITABLE := FALSE;
//         Qauntité_réaliséeEDITABLE := TRUE;
//     end;
// }

