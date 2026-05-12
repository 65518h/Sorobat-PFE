//GL3900 
// page 72040 "Fiche point de mesure"
// { //GL2024  ID dans Nav 2009 : "39002040"
//     Caption = 'Measure point card';
//     PageType = Card;
//     SourceTable = "Point mesure";
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field(cd_measure_point; rec.cd_measure_point)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_box; rec.cd_box)
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
//                 field(bo_real_cmpt; rec.bo_real_cmpt)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_measure_type; rec.cd_measure_type)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Libellé type de mesure"; rec."Libellé type de mesure")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(val_last_read; rec.val_last_read)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(measure_unit; rec.measure_unit)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("val_period-read"; rec."val_period-read")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Période de relevé (Jours)';
//                 }
//                 field(dttm_last_read; rec.dttm_last_read)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                 }
//             }
//             group(Link)
//             {
//                 Caption = 'Link';
//                 part(parent; Parent_pt_mesure)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                     SubPageLink = cd_mesure_point = FIELD(cd_measure_point);
//                 }
//                 part(fils; Fils_pt_mesure)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     SubPageLink = cd_mesure_point_parent = FIELD(cd_measure_point);
//                 }
//             }
//             group(Historic)
//             {
//                 Caption = 'Historic';
//                 part(Hist_pt_mesure; Hist_pt_mesure)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     SubPageLink = cd_mesure_point = FIELD(cd_measure_point);
//                     SubPageView = SORTING(cd_releve)
//                                   ORDER(Ascending);
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Reading)
//             {
//                 Caption = 'Reading';
//                 action(New)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'New';
//                     RunPageOnRec = false;

//                     trigger OnAction()
//                     begin

//                         rel.RESET;
//                         rel.SETRANGE(cd_mesure_point, rec.cd_measure_point);
//                         rel.SETRANGE(rel.cd_releve, '');
//                         PAGE.RUNMODAL(90034, rel);
//                     end;
//                 }
//                 action("Modify last")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Modify last';
//                     RunObject = Page "relevé mesure";
//                     RunPageLink = cd_mesure_point = FIELD(cd_measure_point),
//                                   Last = CONST(true);
//                 }
//                 action("Delete last")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Delete last';

//                     trigger OnAction()
//                     begin
//                         rel.RESET;
//                         rel.SETCURRENTKEY(rel.cd_mesure_point, rel.cd_releve);
//                         rel.SETFILTER(rel.cd_mesure_point, rec.cd_measure_point);
//                         rel.SETFILTER(rel.Last, 'oui');
//                         IF rel.FIND('-') THEN BEGIN
//                             IF CONFIRM('Etes vous sûr de vouloir supprimer la dernière relève?', FALSE, 'oui', 'non') THEN
//                                 rel.DELETE(TRUE);


//                         END;
//                     end;
//                 }
//             }
//             group("Measure point")
//             {
//                 Caption = 'Measure point';

//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(pt_mesure),
//                                   "No." = FIELD(cd_measure_point);
//                 }
//                 action(Equipment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Equipment';
//                     RunObject = Page "Caisse Chantier";
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
//                     RunObject = Page "Fiche Site";
//                     RunPageLink = "code site" = FIELD(cd_site);
//                 }
//                 action("Measure type")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Measure type';
//                     RunObject = Page "Fiche Type de mesure";
//                     RunPageLink = cd_mesure_type = FIELD(cd_measure_type);
//                 }
//             }
//         }
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         IF rec.cd_measure_point = '' THEN BEGIN
//             gmaomgt.GET;
//             gmaomgt.TESTFIELD(pt_measure_No);
//             Noseriesmgt.InitSeries(gmaomgt.pt_measure_No, xRec.souche, 0D, rec.cd_measure_point, rec.souche);

//         END;
//     end;

//     var
//         gmaomgt: Record "Gmao Setup";
//         Noseriesmgt: Codeunit NoSeriesManagement;
//         rel: Record "Relevé mesure";
// }

