//GL3900 
// page 72015 "Liste site"
// {
//     //GL2024  ID dans Nav 2009 : "39002015"
//     Editable = true;
//     PageType = List;
//     SourceTable = Site;
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Liste site';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("code site"; rec."code site")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Désignation; rec.Désignation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_can_shelt_reg; rec.bo_can_shelt_reg)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_server; rec.bo_server)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_pt_interv; rec.bo_pt_interv)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(typ_criticality_level; rec.typ_criticality_level)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(val_state; rec.val_state)
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
//             group(Site)
//             {
//                 Caption = 'Site';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD("code site");
//                 }
//                 separator(separator200)
//                 {
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(site),
//                                   "No." = FIELD("code site");
//                 }
//                 action("Modèle")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Modèle';
//                     RunObject = page "Fiche Modèle";
//                     RunPageLink = cd_pattern = FIELD(cd_pattern);
//                 }
//                 action(Site1)
//                 {
//                     Caption = 'Site';
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD("code site parent");
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
//                         t.SETRANGE(t."code site", rec."code site");
//                         IF t.FIND('-') THEN
//                             REPORT.RUNMODAL(39002011, TRUE, TRUE, t);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         t: Record Site;
// }

