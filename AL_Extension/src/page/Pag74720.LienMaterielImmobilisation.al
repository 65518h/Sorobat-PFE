// Page 74720 "Lien Materiel - Immobilisation"
// {//GL2024  ID dans Nav 2009 : "39004720"
//     PageType = List;
//     SourceTable = "Lien Materiel Immobilisation";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 field("N° Immobilisation"; Rec."N° Immobilisation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         if LienMaterielImmobilisation.FindFirst then
//             repeat
//                 if FixedAsset.Get(LienMaterielImmobilisation."N° Immobilisation") then begin
//                     FixedAsset."Attaché Materiel" := true;
//                     FixedAsset.Modify;
//                 end;
//             until LienMaterielImmobilisation.Next = 0;
//     end;

//     var
//         FixedAsset: Record "Fixed Asset";
//         LienMaterielImmobilisation: Record "Lien Materiel Immobilisation";
// }

