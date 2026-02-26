//GL3900 
// page 72014 "Fiche Site"
// {
//     //GL2024  ID dans Nav 2009 : "39002014"
//     Caption = 'Site card';
//     PageType = Card;
//     SourceTable = Site;
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("code site"; rec."code site")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Site';
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
//                 field(cd_pattern; rec.cd_pattern)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("code site parent"; rec."code site parent")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Caracteristics)
//             {
//                 Caption = 'Caracteristics';
//                 part("Caractéristiques site"; "Caractéristiques site")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "code site" = FIELD("code site");
//                 }
//             }
//             group(Preventive)
//             {
//                 Caption = 'Preventive';
//                 part("Liste OTP"; "Liste OTP")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_site = FIELD("code site");
//                 }
//             }
//             group(Measure)
//             {
//                 Caption = 'Measure';
//                 part("Liste mesure équipement"; "Liste mesure équipement")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group("Follow-up")
//             {
//                 Caption = 'Follow-up';
//                 part(LISTE_BT; "Liste bt_suivi")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                     SubPageLink = cd_site = FIELD("code site");
//                 }
//             }
//             group(Breakdown)
//             {
//                 Caption = 'Breakdown';
//                 part("Sympthômes site"; "Sympthômes site")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_site = FIELD("code site");
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
//                 separator(separator200)
//                 {
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(site), "No." = FIELD("code site");
//                 }
//                 action("Modèle")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Modèle';
//                     RunObject = Page "Fiche Modèle";
//                     RunPageLink = cd_pattern = FIELD(cd_pattern);
//                 }
//                 action(Site1)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Site';
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD("code site parent");
//                 }
//                 action("Tree View")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Tree View';

//                     trigger OnAction()
//                     begin
//                         COMPO.RESET;
//                         COMPO.SETFILTER(cd_site_link, rec."code site");
//                         IF COMPO.FIND('-') THEN BEGIN
//                             CLEAR(form1);
//                             form1.InitArb(COMPO);
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
//                         t.SETRANGE(t."code site", rec."code site");
//                         IF t.FIND('-') THEN
//                             REPORT.RUNMODAL(39002015, TRUE, TRUE, t);
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
//         car: Record "Caractéristiques équipement";
//         NoseriesMgt: Codeunit NoSeriesManagement;
//         gmaomgt: Record "Gmao Setup";
//         t: Record Site;
//         form1: Page "Lien site";
//         COMPO: Record Liens;
//         [InDataSet]

//         commentVisible: Boolean;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         IF rec.comment = TRUE THEN
//             commentVisible := FALSE;
//     end;
// }

