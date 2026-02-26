// page 52048999 "Liste Lot Virement Salaire"
// {
//     //GL2024  ID dans Nav 2009 : "39001527"
//     PageType = List;
//     SourceTable = "Entete Lot Paie";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     //   SourceTableView = WHERE(Status = FILTER("En Cours"), Type = FILTER(Bordereau));
//     Caption = 'Liste Lot Virement Salaire';
//     CardPageId = "Lot Virement Salaire";
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field("Date Creation"; Rec."Date Creation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(User; Rec.User)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Code Banque"; Rec."Code Banque")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Nom Banque"; Rec."Nom Banque")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Mantant Net"; Rec."Mantant Net")
//                 {
//                     ApplicationArea = Basic;
//                     DecimalPlaces = 3 : 3;
//                     Editable = false;
//                 }
//                 field(Annee; Rec.Annee)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Mois; Rec.Mois)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Code Affectation"; Rec."Code Affectation")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Description Affectation"; Rec."Description Affectation")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Code Bordereau"; Rec."Code Bordereau")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Attention;
//                     StyleExpr = true;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

