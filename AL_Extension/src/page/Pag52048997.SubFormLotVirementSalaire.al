// page 52048997 "SubForm Lot Virement Salaire"
// {
//     //GL2024  ID dans Nav 2009 : "39001525"
//     DelayedInsert = true;
//     InsertAllowed = false;
//     PageType = ListPart;
//     SourceTable = "Ligne Lot Paie";
//     Caption = 'SubForm Lot Virement Salaire';
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Code Banque"; Rec."Code Banque")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Matricule Salarié"; Rec."Matricule Salarié")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Nom Salarie"; Rec."Nom Salarie")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(RIB; Rec.RIB)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Banque Salarié"; Rec."Banque Salarié")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Montant Net"; Rec."Montant Net")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     trigger OnValidate()

//                     begin
//                         CurrPage.Update();
//                     end;
//                 }
//                 field("Num Paie"; Rec."Num Paie")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
//     trigger OnAfterGetRecord()
//     begin
//         CurrPage.Update(false);
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         Rec.Type := Rec.Type::Bordereau;
//         Rec.Modify;
//     end;
// }

