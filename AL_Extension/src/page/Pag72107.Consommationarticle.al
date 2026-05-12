//GL3900 
// Page 72107 "Consommation article"
// {//GL2024  ID dans Nav 2009 : "39002107"
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = "ARTICLE/BT";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Consommation article';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field(article; Rec.article)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Désigation"; Rec.Désigation)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("unité"; Rec.unité)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("coût unitaire"; Rec."coût unitaire")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(magasin; Rec.magasin)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Quantité prévue"; Rec."Quantité prévue")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "Quantité prévueEditable";
//                 }
//                 field("Quantité réalisée"; Rec."Quantité réalisée")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "Quantité réaliséeEditable";
//                 }
//                 field("Bon de sortie"; Rec."Bon de sortie")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("date comptabilistaion"; Rec."date comptabilistaion")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//             group(ItemPanel)
//             {
//                 Caption = 'Item Information';
//                 field("STRSUBSTNO('(%1)',ItemPanel.CalcAvailability(Rec))"; StrSubstNo('(%1)', ItemPanel.CalcAvailability(Rec)))
//                 {
//                     ApplicationArea = Basic;
//                     Description = 'SourceExpr=STRSUBSTNO(''(%1)'',ItemPanel.CalcAvailability(Rec))';
//                     Editable = false;
//                 }
//                 field("STRSUBSTNO('(%1)',ItemPanel.CalcNoOfSubstitutions(Rec))"; StrSubstNo('(%1)', ItemPanel.CalcNoOfSubstitutions(Rec)))
//                 {
//                     ApplicationArea = Basic;
//                     Description = 'SourceExpr=STRSUBSTNO(''(%1)'',ItemPanel.CalcNoOfSubstitutions(Rec))';
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
//                 action("Export to consumption journal")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Export to consumption journal';

//                     trigger OnAction()
//                     var
//                         jnitem: Page "Consumption Journal GMAO";
//                     begin
//                         bt.Reset;
//                         if bt.Get(Rec."code ot", Rec."code bt") then
//                             ConsTreatment.ExportToJournal(bt, false);
//                     end;
//                 }
//                 action("&Validate")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = '&Validate';
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         ARTi.Reset;
//                         ARTi.SetFilter(ARTi."code ot", Rec."code ot");
//                         ARTi.SetRange(ARTi."code bt", Rec."code bt");
//                         ARTi.SetRange(ARTi.Validé, false);
//                         if ARTi.Find('-') then begin
//                             bt.Reset;
//                             if bt.Get(Rec."code ot", Rec."code bt") then
//                                 ConsTreatment.ValidateConsumption(bt, false);
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

//                         ARTi.Reset;
//                         ARTi.SetFilter(ARTi."code ot", Rec."code ot");
//                         ARTi.SetRange(ARTi."code bt", Rec."code bt");
//                         ARTi.SetRange(ARTi.Validé, false);
//                         if ARTi.Find('-') then begin
//                             bt.Reset;
//                             if bt.Get(Rec."code ot", Rec."code bt") then
//                                 ConsTreatment.ValidateConsumptionAndPrint(bt, false);

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
//                     if Rec."Bon de sortie" <> '' then begin

//                         nav.SetDoc(Rec."date comptabilistaion", Rec."Bon de sortie");
//                         nav.Run;
//                     end;
//                 end;
//             }
//             action("Substitutio&ns")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Substitutio&ns';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     ItemPanel.ItemSubstGet(Rec);//ShowItemSub;
//                     CurrPage.Update;
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
//                     vail := Vail::date;
//                     ItemPanel.ItemAvailability(vail, Rec);
//                 end;
//             }
//             action("Ite&m Card")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Ite&m Card';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if art.Get(Rec.article) then
//                         page.Run(Page::"Item Card", art);
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         art.Reset;

//         if art.Get(Rec.article) then begin
//             art.CalcFields(art.Comment);
//             if art.Comment then
//                 com := true
//             else
//                 com := false;
//         end;
//     end;

//     trigger OnInit()
//     begin
//         "Quantité réaliséeEditable" := true;
//         "Quantité prévueEditable" := true;
//     end;

//     var
//         com: Boolean;
//         SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
//         art: Record Item;
//         commentline: Record "Comment Line";
//         ItemPanel: Codeunit BtInfoPanel;
//         vail: Option date,loc;
//         ConsTreatment: Codeunit "Consumption treatment";
//         bt: Record BT;
//         txt: label 'All consumption are validated';
//         ARTi: Record "ARTICLE/BT";
//         [InDataSet]
//         "Quantité prévueEditable": Boolean;
//         [InDataSet]
//         "Quantité réaliséeEditable": Boolean;


//     procedure planned()
//     begin
//         "Quantité prévueEditable" := true;
//         "Quantité réaliséeEditable" := false;
//     end;


//     procedure lanced()
//     begin
//         "Quantité prévueEditable" := false;
//         "Quantité réaliséeEditable" := true;
//     end;
// }

