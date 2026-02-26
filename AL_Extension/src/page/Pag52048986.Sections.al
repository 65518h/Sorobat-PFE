// page 52048986 Sections
// {//GL2024  ID dans Nav 2009 : "39001513"
//     Editable = true;
//     PageType = List;
//     SourceTable = Section;
//     SourceTableView = sorting(Section);
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Sections';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1120000)
//             {
//                 ShowCaption = false;
//                 field(Section; Rec.Section)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Affectation';
//                 }
//                 field(Decription; Rec.Decription)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Chantier; Rec.Chantier)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Service; Rec.Service)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Type Affectation';
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         CurrPage.Editable(not CurrPage.LookupMode);
//         if UserSetup.Get(UpperCase(UserId)) then
//             if UserSetup."Affaire Par Defaut" <> '' then Rec.SetFilter(Chantier, UserSetup."Affaire Par Defaut" + '*');
//     end;

//     var
//         UserSetup: Record "User Setup";
// }

