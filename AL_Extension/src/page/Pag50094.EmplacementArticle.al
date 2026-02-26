// Page 50094 "Emplacement Article"
// {
//     InsertAllowed = false;
//     PageType = list;
//     SourceTable = Item;
//     ApplicationArea = all;
//     UsageCategory = lists;
//     Caption = 'Emplacement Article';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Ancien Code"; rec."Ancien Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Emplacement DEPOT Z4"; rec."Emplacement DEPOT Z4")
//                 {
//                     ApplicationArea = all;
//                     Enabled = "Emplacement DEPOT Z4Enable";
//                 }
//                 field("Emplacement Bati Depot z4"; rec."Emplacement Bati Depot z4")
//                 {
//                     ApplicationArea = all;
//                     Enabled = EmplacementBatiDepotz4Enable;
//                 }
//                 field("Emplacement MGH 113"; rec."Emplacement MGH 113")
//                 {
//                     ApplicationArea = all;
//                     Enabled = "Emplacement MGH 113Enable";
//                 }
//                 field("Emplacement MGH 51"; rec."Emplacement MGH 51")
//                 {
//                     ApplicationArea = all;
//                     Enabled = "Emplacement MGH 51Enable";
//                 }
//                 field("Emplacement BEJA LOT2"; rec."Emplacement BEJA LOT2")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Emplacement BEJA LOT3"; rec."Emplacement BEJA LOT3")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord()
//     begin
//         FiltreMagasin;
//     end;

//     trigger OnInit()
//     begin
//         "Emplacement MGH 51Enable" := true;
//         "Emplacement MGH 113Enable" := true;
//         EmplacementBatiDepotz4Enable := true;
//         "Emplacement DEPOT Z4Enable" := true;
//     end;

//     var
//         [InDataSet]
//         "Emplacement DEPOT Z4Enable": Boolean;
//         [InDataSet]
//         EmplacementBatiDepotz4Enable: Boolean;
//         [InDataSet]
//         "Emplacement MGH 113Enable": Boolean;
//         [InDataSet]
//         "Emplacement MGH 51Enable": Boolean;


//     procedure "// HJ SORO"()
//     begin
//     end;


//     procedure FiltreMagasin()
//     var
//         LUserSetup: Record "User Setup";
//     begin
//         // >> HJ SORO 11-07-2014
//         if LUserSetup.Get(UpperCase(UserId)) then
//             if LUserSetup."Filtre Magasin" <> '' then
//                 rec.SetFilter("Location Filter", LUserSetup."Filtre Magasin")
//             else
//                 rec.SetRange("Location Filter");
//         // >> HJ SORO 11-07-2014
//         if LUserSetup."Filtre Magasin" <> '' then begin
//             if LUserSetup."Filtre Magasin" = 'DEPOT Z4' then begin
//                 "Emplacement DEPOT Z4Enable" := true;
//                 EmplacementBatiDepotz4Enable := false;
//                 "Emplacement MGH 113Enable" := false;
//                 "Emplacement MGH 51Enable" := false;
//             end;
//             if LUserSetup."Filtre Magasin" = 'MGHLOT13' then begin
//                 "Emplacement DEPOT Z4Enable" := false;
//                 EmplacementBatiDepotz4Enable := true;
//                 "Emplacement MGH 113Enable" := false;
//                 "Emplacement MGH 51Enable" := false;
//             end;

//             if LUserSetup."Filtre Magasin" = 'MGHLOT113' then begin
//                 "Emplacement DEPOT Z4Enable" := false;
//                 EmplacementBatiDepotz4Enable := false;
//                 "Emplacement MGH 113Enable" := true;
//                 "Emplacement MGH 51Enable" := false;
//             end;
//             if LUserSetup."Filtre Magasin" = 'MGHLOT51' then begin
//                 "Emplacement DEPOT Z4Enable" := false;
//                 EmplacementBatiDepotz4Enable := false;
//                 "Emplacement MGH 113Enable" := false;
//                 "Emplacement MGH 51Enable" := true;
//             end;

//         end;
//     end;
// }

