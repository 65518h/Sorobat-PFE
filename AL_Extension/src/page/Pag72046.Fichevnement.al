//GL3900 
// page 72046 "Fiche évènement"
// { //GL2024  ID dans Nav 2009 : "39002046"
//     Caption = 'Event card';
//     PageType = Card;
//     SourceTable = Evenement;
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field(cd_event; rec.cd_event)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dttm_event; rec.dttm_event)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_box; rec.cd_box)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Lib_box; rec.Lib_box)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_register; rec.cd_register)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_site; rec.cd_site)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_sympthome; rec.cd_sympthome)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Lib_sympt; rec.Lib_sympt)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Fonction&s")
//             {
//                 Caption = 'Fonction&s';
//                 action("Launch WO")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Launch WO';

//                     trigger OnAction()
//                     begin
//                         OT.INIT;
//                         OT.INSERT(TRUE);
//                         OT.VALIDATE(OT.cd_box, rec.cd_box);

//                         //OT.cd_box:=cd_box;
//                         OT.cd_symptom := rec.cd_sympthome;
//                         OT.MODIFY;
//                         PAGE.RUN(39002070, OT);
//                     end;
//                 }
//             }
//             group("Event")
//             {
//                 Caption = 'Event';

//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(event),
//                                   "No." = FIELD(cd_event);
//                 }
//                 action(Equipment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Equipment';
//                     RunObject = page "Caisse Chantier";
//                     RunPageLink = "No." = FIELD(cd_box);
//                 }
//                 action(Register)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Register';
//                     Image = Confirm;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = page "Fiche Matricule";
//                     RunPageLink = "code matricule" = FIELD(cd_register);
//                 }
//                 action(Site)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Site';
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD(cd_site);
//                 }
//                 action(Symptom)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Symptom';
//                     RunObject = page "Fiche sympthome";
//                     RunPageLink = cd_sympt = FIELD(cd_sympthome);
//                 }
//             }
//         }
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         rec.dttm_event := TODAY;
//     end;

//     var
//         OT: Record OT;
// }

