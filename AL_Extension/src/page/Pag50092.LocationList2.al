// page 50092 "Location List 2"
// {
//     Caption = 'Location List 2';
//     Editable = false;
//     PageType = List;
//     SourceTable = Location;

//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Code; rec.Code)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Name; rec.Name)
//                 {
//                     ApplicationArea = all;
//                 }
//                 // field(Affectation; rec.Affectation)
//                 // {
//                 //     ApplicationArea = all;
//                 // }
//             }
//         }
//     }

//     actions
//     {

//         area(Promoted)
//         {
//             group("&Location1")
//             {
//                 Caption = '&Location';

//                 actionref(Card1; Card) { }
//                 actionref("&Resource Locations1"; "&Resource Locations") { }
//                 actionref("&Zones1"; "&Zones") { }


//                 actionref("&Bins1"; "&Bins") { }
//             }

//         }

//         area(Processing)
//         {
//             group("&Location")
//             {
//                 Caption = '&Location';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Location Card";
//                     RunPageLink = Code = FIELD(Code);
//                     ShortCutKey = 'Maj+F7';
//                 }
//                 action("&Resource Locations")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Resource Locations';
//                     RunObject = Page "Resource Locations";
//                     RunPageLink = "Location Code" = FIELD(Code);
//                 }
//                 separator(separator1)
//                 {
//                 }
//                 action("&Zones")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Zones';
//                     Image = Zones;
//                     RunObject = Page Zones;
//                     RunPageLink = "Location Code" = FIELD(Code);
//                 }
//                 action("&Bins")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Bins';
//                     Image = Bins;
//                     RunObject = Page Bins;
//                     RunPageLink = "Location Code" = FIELD(Code);
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         //FiltreMagasin;
//         CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
//     end;

//     var
//         "// RB SORO": Integer;
//         RecLocation: Record Location;
//         RecAutorisationMagasin: Record "Autorisation Magasin";


//     procedure GetSelectionFilter() SelectionFilter: Code[80]
//     var
//         Loc: Record Location;
//     begin
//         CurrPage.SETSELECTIONFILTER(Loc);
//         Loc.SETCURRENTKEY(Code);
//         IF Loc.COUNT > 0 THEN BEGIN
//             Loc.FIND('-');
//             SelectionFilter := Loc.Code;
//         END;

//         EXIT(SelectionFilter);
//     end;




//     procedure FiltreMagasin()
//     var
//         LUserSetup: Record "User Setup";
//     begin
//         // >> HJ SORO 11-07-2014
//         IF LUserSetup.GET(UPPERCASE(USERID)) THEN BEGIN
//             IF LUserSetup."Filtre Magasin" <> '' THEN rec.SETFILTER(Code, '=%1', LUserSetup."Filtre Magasin");
//         END;
//         // >> HJ SORO 11-07-2014
//     end;
// }

