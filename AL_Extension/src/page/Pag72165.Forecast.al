// Page 72165 Forecast
// {//GL2024  ID dans Nav 2009 : "39002165"
//     Caption = ' Forecast';
//     DataCaptionExpression = Rec."Production Forecast Name";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = Card;
//     SaveValues = true;
//     SourceTable = Item;
//     ApplicationArea = All;

//     layout
//     {
//     }

//     actions
//     {
//     }

//     var
//         Text000: label 'The Forecast On field must be Sales Items or Component.';
//         Text001: label 'A forecast was previously made on the %1. Do you want all forecasts of the period %2-%3 moved to the start of the period?';
//         Text003: label 'You must set a location filter.';
//         Text004: label 'You must change view to Sales Items or Component.';
//         //  PeriodFormMgt: Codeunit 359;
//         PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
//         ForecastQtyType: Option "Net Change","Balance at Date";
//         "Forecast Type": Option "Sales Item",Component,Both;
//         DateFilter: Text[30];

//     local procedure SetDateFilter()
//     begin
//     end;
// }

