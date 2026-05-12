//GL3900 
// page 72019 "Liste matricule"
// {
//     //GL2024  ID dans Nav 2009 : "39002019"
//     Caption = 'Registers list';
//     Editable = false;
//     PageType = List;
//     SourceTable = Matricule;
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("code matricule"; rec."code matricule")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(designation; rec.designation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_pattern; rec.cd_pattern)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(txt_userinfo; rec.txt_userinfo)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_calender_constr; rec.cd_calender_constr)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(typ_criticality; rec.typ_criticality)
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
//             group(Register)
//             {
//                 Caption = 'Register';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = page "Fiche Matricule";
//                     RunPageLink = "code matricule" = FIELD("code matricule");
//                     ShortCutKey = 'Maj+F5';
//                 }
//                 separator(separator300)
//                 {
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment List gmao";
//                     RunPageLink = "Table Name" = CONST(matricule),
//                                   "No." = FIELD("code matricule");
//                 }
//                 action(Model)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Model';
//                     RunObject = page "Fiche Modèle";
//                     RunPageLink = cd_pattern = FIELD(cd_pattern);
//                 }
//                 action("Fixed Asset")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Fixed Asset';
//                     RunObject = Page "Fixed Asset List";
//                     RunPageLink = "No." = FIELD("Immo No.");
//                 }
//                 separator(separator100)
//                 {
//                 }
//                 action(Picture)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Picture';
//                     RunObject = Page "Matricule Picture";
//                     RunPageLink = "code matricule" = FIELD("code matricule");
//                 }
//             }
//         }
//     }
// }

