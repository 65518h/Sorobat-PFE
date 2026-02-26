//GL3900 
// page 72013 "Liste famille"
// {
//     //GL2024  ID dans Nav 2009 : "39002013"
//     Caption = 'Family list';
//     Editable = true;
//     PageType = List;
//     SourceTable = Famille;
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("code famille"; rec."code famille")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Désignation; rec.Désignation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_cost_center; rec.cd_cost_center)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(typ_criticality_level; rec.typ_criticality_level)
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
//             group(Family)
//             {
//                 Caption = 'Family';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = page "Fiche famille";
//                     RunPageLink = "code famille" = FIELD("code famille");
//                 }
//                 separator(separator100)
//                 {
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(famille),
//                                   "No." = FIELD("code famille");
//                 }
//                 action("Higher family")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Higher family';
//                     RunObject = page "Fiche famille";
//                     //GL2024 RunPageLink = "code famille" = FIELD(Field21);
//                 }
//                 /*GL2024   action("Tree view")
//                    {
//                        Caption = 'Tree view';
//                        RunObject = Page 50702;
//                    }*/
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
//                         //t.SETrange(typ_linksubtype,'1');
//                         t.SETRANGE(t."code famille", rec."code famille");
//                         IF t.FIND('-') THEN
//                             REPORT.RUNMODAL(39002013, TRUE, TRUE, t);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         t: Record Famille;
// }

