//GL3900 
// page 72016 "Fiche Modèle"
// {
//     //GL2024  ID dans Nav 2009 : "39002016"
//     Caption = 'Model card';
//     PageType = Card;
//     SourceTable = model;
//     ApplicationArea = all;
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field(cd_pattern; rec.cd_pattern)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(comment; rec.comment)
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field(Désignation; rec.Désignation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(typ_criticality_level; rec.typ_criticality_level)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_calender_constr; rec.cd_calender_constr)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("code famille"; rec."code famille")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_cancopy; rec.bo_cancopy)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         IF rec.bo_cancopy = TRUE THEN
//                             Btn_FctVisible := TRUE
//                         ELSE
//                             Btn_FctVisible := FALSE;
//                         bocancopyOnAfterValidate;
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Btn_Fct)
//             {
//                 Caption = 'Fonction&s';
//                 Visible = Btn_FctVisible;
//                 action("Copy model")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Copy model';

//                     trigger OnAction()
//                     begin
//                         rec.Copy;
//                     end;
//                 }
//             }
//             group(Model)
//             {
//                 Caption = 'Model';
//                 separator(separator100)
//                 {
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(modèle),
//                                   "No." = FIELD(cd_pattern);
//                 }
//                 separator(separator200)
//                 {
//                 }
//                 action("Print card")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Print card';

//                     trigger OnAction()
//                     begin
//                         t.RESET;
//                         t.SETFILTER(t.cd_pattern, rec.cd_pattern);
//                         IF t.FIND('-') THEN
//                             REPORT.RUNMODAL(39002019, TRUE, TRUE, t);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         IF rec.bo_cancopy = TRUE THEN
//             Btn_FctVisible := TRUE
//         ELSE
//             Btn_FctVisible := FALSE;
//     end;

//     trigger OnInit()
//     begin
//         Btn_FctVisible := TRUE;
//     end;

//     var
//         t: Record model;
//         [InDataSet]
//         Btn_FctVisible: Boolean;

//     local procedure bocancopyOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;
// }

