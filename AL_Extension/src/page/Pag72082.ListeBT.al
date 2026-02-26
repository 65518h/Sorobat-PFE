//GL3900
// page 72082 "Liste BT"
// {
//     //GL2024  ID dans Nav 2009 : "39002082"
//     Editable = false;
//     PageType = List;
//     SourceTable = BT;
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Liste BT';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(cd_OT; rec.cd_OT)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("code BT"; rec."code BT")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Titre; rec.Titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(status; rec.status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(nature; rec.nature)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_box; rec.cd_box)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_site; rec.cd_site)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_famille; rec.cd_famille)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_matricule; rec.cd_matricule)
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
//             group(WS)
//             {
//                 Caption = 'WS';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Fiche BT";
//                     RunPageLink = cd_OT = FIELD(cd_OT),
//                                   "code BT" = FIELD("code BT");
//                     ShortCutKey = 'Maj+F5';
//                 }

//                 action("Joined WS")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Joined WS';
//                     RunObject = Page "Liste BT";
//                     RunPageLink = cd_OT = FIELD(cd_OT);
//                 }
//                 action(WO)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WO';
//                     RunObject = Page "Fiche OT";
//                     RunPageLink = "code OT" = FIELD(cd_OT);
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
//                     RunPageLink = "code matricule" = FIELD(cd_matricule);
//                 }
//                 action(Model)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Model';
//                     RunObject = page "Fiche Modèle";
//                     RunPageLink = cd_pattern = FIELD(cd_modèle);
//                 }
//                 action(Site)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Site';
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD(cd_site);
//                 }
//             }
//         }
//     }
// }

