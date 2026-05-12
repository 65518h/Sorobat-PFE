//GL3900 
// page 72012 "Fiche famille"
// {
//     //GL2024  ID dans Nav 2009 : "39002012"
//     Caption = 'Family card';
//     PageType = Card;
//     SourceTable = Famille;
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("code famille"; rec."code famille")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Family';
//                 }
//                 field(Désignation; rec.Désignation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(typ_criticality_level; rec.typ_criticality_level)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("code famille mère"; rec."code famille mère")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(comment; rec.comment)
//                 {
//                     Visible = commentVisible;
//                 }
//             }
//             group(Caracteristics)
//             {
//                 Caption = 'Caracteristics';
//                 part("Caractéristiques famille"; "Caractéristiques famille")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "code famille" = FIELD("code famille");
//                 }
//             }
//             group(Preventive)
//             {
//                 Caption = 'Preventive';
//                 part("Liste OTP"; "Liste OTP")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "cd_famille" = FIELD("code famille");
//                 }
//             }
//             group("Follow-up")
//             {
//                 Caption = 'Follow-up';
//                 part("Liste bt_suivi"; "Liste bt_suivi")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                     SubPageLink = "cd_famille" = FIELD("code famille");
//                 }
//             }
//             group(equip)
//             {
//                 Caption = 'Breakdown';
//                 part("Sympthômes famille"; "Sympthômes famille")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "cd_famille" = FIELD("code famille");
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Family)
//             {
//                 Caption = 'Family';
//                 separator(separator200)
//                 {
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(famille), "No." = FIELD("code famille");
//                 }
//                 action("Higher family")
//                 {
//                     Caption = 'Higher family';
//                     RunObject = page "Fiche famille";
//                     //GL2024  RunPageLink = "code famille" = FIELD(Field21);
//                 }
//                 action("Tree view")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Tree view';

//                     trigger OnAction()
//                     begin
//                         compo.RESET;
//                         compo.SETFILTER(family, rec."code famille");
//                         IF compo.FIND('-') THEN BEGIN
//                             CLEAR(form1);
//                             // IMS form1.InitArb(compo);
//                             form1.RUNMODAL;


//                         END;
//                     end;
//                 }
//                 separator(separator100)
//                 {
//                 }
//                 action("Print card")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Print card';

//                     trigger OnAction()
//                     begin
//                         t.RESET;
//                         //t.SETrange(typ_linksubtype,'1');
//                         t.SETRANGE(t."code famille", rec."code famille");
//                         IF t.FIND('-') THEN
//                             REPORT.RUNMODAL(39002013, TRUE, TRUE, t);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     trigger OnInit()
//     begin
//         commentVisible := TRUE;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     var
//         tem: Record Organe;
//         NoseriesMgt: Codeunit NoSeriesManagement;
//         gmaomgt: Record "Gmao Setup";
//         t: Record Famille;
//         compo: Record Liens;
//         form1: Page "Lien famille";
//         [InDataSet]
//         commentVisible: Boolean;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         IF rec.comment = TRUE THEN
//             commentVisible := FALSE;
//     end;
// }

