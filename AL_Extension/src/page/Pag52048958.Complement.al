// page 52048958 Complement
// {//GL2024  ID dans Nav 2009 : "39001479"
//     DelayedInsert = true;
//     DeleteAllowed = true;
//     Editable = true;
//     InsertAllowed = true;
//     PageType = List;
//     SourceTable = Complement;
//     UsageCategory = Lists;
//     ApplicationArea = all;
//     Caption = 'Complement';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Matricule; rec.Matricule)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         MatriculeOnAfterValidate;
//                     end;
//                 }
//                 field("Nom Et Prenom"; rec."Nom Et Prenom")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Début Complement"; rec."Date Début Complement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Fin Complement"; rec."Date Fin Complement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Montant Complement"; rec."Montant Complement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Observation; rec.Observation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Actif; rec.Actif)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             part("Detail Complement"; "Detail Complement")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 SubPageLink = Matricule = FIELD(Matricule);
//             }
//         }
//     }

//     actions
//     {
//     }

//     local procedure MatriculeOnAfterValidate()
//     begin
//         rec.CALCFIELDS("Nom Et Prenom");
//     end;
// }

