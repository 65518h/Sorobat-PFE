// page 52048991 "FOR-Liste Virement Salaire"
// {
//     //GL2024  ID dans Nav 2009 : "39001519"
//     Editable = false;
//     PageType = List;
//     SourceTable = "Entete Virement Salaire";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'FOR-Liste Virement Salaire';
//     CardPageId = "FOR-Virement Salaire";
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field("N°"; rec."N°")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Mois; rec.Mois)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Lot; rec.Lot)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Annee; rec.Annee)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Montant; rec.Montant)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         /*GL2024 area(navigation)
//          {
//              group("Demande Formation")
//              {
//                  Caption = 'Demande Formation';
//                  action(Fiche)
//                  {
//                      ApplicationArea = all;
//                      Caption = 'Fiche';
//                      RunObject = page "FOR-Virement Salaire";
//                      //GL2024  RunPageLink = Field20 = FIELD(Field20);
//                      ShortCutKey = 'Maj+F5';
//                  }
//              }
//          }*/
//     }
// }

