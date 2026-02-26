//GL3900 
// Page 72139 "Consommation article Prev"
// {//GL2024  ID dans Nav 2009 : "39002139"
//     PageType = ListPart;
//     SourceTable = "ARTICLE/BTP";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group(ItemPanel)
//             {
//                 Caption = 'Item Information';
//                 field("STRSUBSTNO('(%1)',ItemPanel.CalcAvailabilityprev(Rec))"; StrSubstNo('(%1)', ItemPanel.CalcAvailabilityprev(Rec)))
//                 {
//                     ApplicationArea = Basic;
//                     Description = 'SourceExpr=STRSUBSTNO(''(%1)'',ItemPanel.CalcAvailabilityprev(Rec))';
//                     Editable = false;
//                 }
//                 field("STRSUBSTNO('(%1)',ItemPanel.CalcNoOfSubstitutionsPrev(Rec))"; StrSubstNo('(%1)', ItemPanel.CalcNoOfSubstitutionsPrev(Rec)))
//                 {
//                     ApplicationArea = Basic;
//                     Description = 'SourceExpr=STRSUBSTNO(''(%1)'',ItemPanel.CalcNoOfSubstitutionsPrev(Rec))';
//                     Editable = false;
//                 }
//             }
//             repeater(Control1000000000)
//             {
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
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Substitutio&ns")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Substitutio&ns';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     ItemPanel.ItemSubstGetprev(Rec);//ShowItemSub;
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
//                     ItemPanel.ItemAvailabilityPrev(vail, Rec);
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
//                         PAGE.Run(Page::"Item Card", art);
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


//     procedure planned()
//     begin
//         "Quantité prévueEditable" := true;
//     end;


//     procedure lanced()
//     begin
//         "Quantité prévueEditable" := false;
//     end;
// }

