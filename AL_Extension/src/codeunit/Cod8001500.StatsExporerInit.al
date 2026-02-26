Codeunit 8001500 "StatsExporer Init"
{
    //GL2024  ID dans Nav 2009 : "8001300"
    // #8450 SD 14/12/10
    // #8127 ML 29/06/10
    // //STATSEXPLORER STATSEXPLORER 01/03/00 Create statistic setup
    // //NAVIBAT-STATS STATSEXPLORER 04/07/05 Nouveaux flux 23, 24 et 26 sur les budgets affaires


    trigger OnRun()
    begin
        if not StatisticsSetup.Get then
            StatisticsSetup.Insert;
        CreateGroup(Groupe, LireStatistiques, 0, 1, 0, 8001300, 8001310);
        CreateGroup(Groupe, LireStatistiques, 0, 1, 0, 8001319, 8001321);
        CreateGroup(Groupe, LireStatistiques, 0, 1, 1, 8001311, 8001318);
        CreateGroup(Groupe, LireStatistiques, 0, 1, 0, 8001400, 8001400);
        CreateGroup(Groupe, LireStatistiques, 0, 1, 0, 8001408, 8001408);
        CreateGroup(Groupe, LireStatistiques, 0, 1, 0, 2000000001, 2000000001);
        CreateGroup(Groupe, LireStatistiques, 0, 1, 0, 2000000003, 2000000003);
        CreateGroup(Groupe, LireStatistiques, 10, 1, 0, 1570, 1570);
        CreateIndirectSecurity;

        // Sort criteria
        SearchValue(1, 4, 4, 4, true, '', false, false);
        SearchValue(1, 5, 5, 4, true, '', false, false);
        SearchValue(1, 6, 6, 20, true, '', false, false);
        SearchValue(1, 8, 8, 4, false, '', false, false);
        SearchValue(1, 9, 9, 20, true, '', false, false);
        SearchValue(1, 11, 11, 10, true, '', false, false);
        SearchValue(1, 12, 12, 10, true, '', false, false);
        SearchValue(1, 13, 13, 10, true, '', false, false);
        SearchValue(1, 14, 14, 10, true, '', false, false);
        SearchValue(1, 15, 15, 10, true, '', false, false);
        SearchValue(1, 16, 16, 10, true, '', false, false);
        SearchValue(1, 17, 17, 20, true, '', false, false);
        SearchValue(1, 18, 18, 20, true, '', false, false);
        SearchValue(1, 19, 19, 10, false, '', false, false);
        SearchValue(1, 30, 30, 10, false, '', false, false);
        SearchValue(1, 31, 31, 10, false, '', false, false);
        SearchValue(1, 32, 32, 10, false, '', false, false);
        SearchValue(1, 33, 33, 10, false, '', false, false);
        SearchValue(1, 34, 34, 10, false, '', false, false);
        SearchValue(1, 35, 35, 10, false, '', false, false);
        SearchValue(1, 36, 36, 1, false, '', false, false);
        SearchValue(1, 37, 37, 10, false, '', false, false);
        SearchValue(1, 38, 38, 10, false, '', false, false);
        SearchValue(1, 39, 39, 10, false, '', false, false);
        SearchValue(1, 40, 40, 20, true, '', false, false);
        SearchValue(1, 41, 41, 10, false, '', false, false);
        //SearchValue(1,42,42,10,FALSE,'',FALSE,FALSE);
        //SearchValue(1,43,43,10,FALSE,'',FALSE,FALSE);
        SearchValue(1, 44, 44, 10, false, '', false, false);
        SearchValue(1, 45, 45, 10, false, '', false, false);
        SearchValue(1, 46, 46, 10, true, '', false, false);
        SearchValue(1, 47, 47, 20, true, '', false, false);
        SearchValue(1, 48, 48, 20, true, '', false, false);
        SearchValue(1, 57, 57, 20, true, '', false, false);
        SearchValue(1, 2000, 49, 22, false, '', false, false);
        SearchValue(1, 300, 50, 20, false, '', false, false);
        SearchValue(1, 301, 51, 10, false, '', false, false);
        SearchValue(1, 303, 52, 10, false, '', false, false);
        SearchValue(1, 310, 53, 10, false, '', false, false);
        SearchValue(1, 311, 54, 10, false, '', false, false);
        SearchValue(1, 312, 55, 10, false, '', false, false);
        SearchValue(1, 313, 56, 10, false, '', false, false);
        SearchValue(1, 110, 59, 20, false, '', false, false);
        SearchValue(1, 60, 60, 20, false, '', false, false);
        SearchValue(1, 61, 61, 20, false, '', false, false);
        SearchValue(1, 62, 62, 20, false, '', false, false);
        SearchValue(1, 63, 63, 20, false, '', false, false);
        SearchValue(1, 64, 64, 20, false, '', false, false);
        SearchValue(1, 65, 65, 20, false, '', false, false);
        SearchValue(1, 66, 66, 20, false, '', false, false);
        SearchValue(1, 67, 67, 20, false, '', false, false);
        SearchValue(1, 68, 68, 20, false, '', false, false);
        SearchValue(1, 69, 69, 20, false, '', false, false);
        SearchValue(1, 70, 70, 20, false, '', false, false);
        SearchValue(1, 71, 71, 20, false, '', false, false);
        SearchValue(1, 72, 72, 20, false, '', false, false);
        SearchValue(1, 73, 73, 20, false, '', false, false);
        SearchValue(1, 74, 74, 20, false, '', false, false);
        SearchValue(1, 75, 75, 20, false, '', false, false);
        SearchValue(1, 76, 76, 20, false, '', false, false);
        SearchValue(1, 77, 77, 20, false, '', false, false);
        SearchValue(1, 78, 78, 20, false, '', false, false);
        SearchValue(1, 79, 79, 20, false, '', false, false);
        SearchValue(1, 1001, 80, 20, false, '', false, false);
        SearchValue(1, 1002, 81, 20, false, '', false, false);
        SearchValue(1, 1003, 82, 20, false, '', false, false);
        SearchValue(1, 1004, 83, 20, false, '', false, false);
        SearchValue(1, 1005, 84, 20, false, '', false, false);
        SearchValue(1, 1006, 85, 20, false, '', false, false);
        SearchValue(1, 1007, 86, 20, false, '', false, false);
        SearchValue(1, 1008, 87, 20, false, '', false, false);
        SearchValue(1, 1009, 88, 20, false, '', false, false);
        SearchValue(1, 1010, 89, 20, false, '', false, false);
        SearchValue(1, 1011, 90, 10, false, '', false, false);
        SearchValue(1, 1012, 91, 10, false, '', false, false);
        SearchValue(1, 1013, 92, 10, false, '', false, false);
        SearchValue(1, 1014, 93, 10, false, '', false, false);
        SearchValue(1, 1015, 94, 10, false, '', false, false);
        SearchValue(1, 1021, 95, 3, false, '', false, false);
        SearchValue(1, 1022, 96, 3, false, '', false, false);
        SearchValue(1, 1023, 97, 3, false, '', false, false);
        SearchValue(1, 1024, 98, 3, false, '', false, false);
        SearchValue(1, 1025, 99, 3, false, '', false, false);
        SearchValue(1, 30001, 201, 20, false, StatisticsSetup."Dimension 1 Code", false, false);
        SearchValue(1, 30002, 202, 20, false, StatisticsSetup."Dimension 2 Code", false, false);
        SearchValue(1, 30003, 203, 20, false, StatisticsSetup."Dimension 3 Code", false, false);
        SearchValue(1, 30004, 204, 20, false, StatisticsSetup."Dimension 4 Code", false, false);
        SearchValue(1, 30005, 205, 20, false, StatisticsSetup."Dimension 5 Code", false, false);
        SearchValue(1, 30006, 206, 20, false, StatisticsSetup."Dimension 6 Code", false, false);
        SearchValue(1, 30007, 207, 20, false, StatisticsSetup."Dimension 7 Code", false, false);
        SearchValue(1, 30008, 208, 20, false, StatisticsSetup."Dimension 8 Code", false, false);
        SearchValue(1, 30009, 209, 20, false, StatisticsSetup."Dimension 9 Code", false, false);
        SearchValue(1, 30010, 210, 20, false, StatisticsSetup."Dimension 10 Code", false, false);
        SearchValue(1, 30011, 211, 20, false, StatisticsSetup."Dimension 11 Code", false, false);
        SearchValue(1, 30012, 212, 20, false, StatisticsSetup."Dimension 12 Code", false, false);
        SearchValue(1, 30013, 213, 20, false, StatisticsSetup."Dimension 13 Code", false, false);
        SearchValue(1, 30014, 214, 20, false, StatisticsSetup."Dimension 14 Code", false, false);
        SearchValue(1, 30015, 215, 20, false, StatisticsSetup."Dimension 15 Code", false, false);
        SearchValue(1, 30016, 216, 20, false, StatisticsSetup."Dimension 16 Code", false, false);
        SearchValue(1, 30017, 217, 20, false, StatisticsSetup."Dimension 17 Code", false, false);
        SearchValue(1, 30018, 218, 20, false, StatisticsSetup."Dimension 18 Code", false, false);
        SearchValue(1, 30019, 219, 20, false, StatisticsSetup."Dimension 19 Code", false, false);
        SearchValue(1, 30020, 220, 20, false, StatisticsSetup."Dimension 20 Code", false, false);
        SearchValue(1, 90, 300, 20, false, '', false, false);
        SearchValue(1, 91, 301, 20, false, '', false, false);
        SearchValue(1, 92, 302, 20, false, '', false, false);
        SearchValue(1, 93, 303, 20, false, '', false, false);
        SearchValue(1, 94, 304, 20, false, '', false, false);
        SearchValue(1, 95, 305, 20, false, '', false, false);
        SearchValue(1, 96, 306, 20, false, '', false, false);
        SearchValue(1, 97, 307, 20, false, '', false, false);
        SearchValue(1, 98, 308, 20, false, '', false, false);
        SearchValue(1, 99, 309, 20, false, '', false, false);

        // Flows
        SearchValue(2, 99999, 5, 0, true, TextSales, true, true);
        SearchValue(2, 99999, 10, 0, true, TextPurch, true, true);
        SearchValue(2, 99999, 15, 0, false, TextSalesJob, true, true);
        SearchValue(2, 99999, 20, 0, false, TextActJob, true, true);
        SearchValue(2, 99999, 25, 0, false, TextBudJob, false, false);
        SearchValue(2, 99999, 27, 0, false, TextCapacity, false, false);
        SearchValue(2, 99999, 28, 0, false, TextSalesResource, true, true);
        SearchValue(2, 99999, 29, 0, false, TextActResource, true, true);
        SearchValue(2, 99999, 30, 0, false, TextRFA, true, true);
        SearchValue(2, 99999, 32, 0, false, TextCommission, true, true);
        SearchValue(2, 99999, 39, 0, false, TextItemAvail, false, false);
        SearchValue(2, 99999, 40, 0, false, TextPosEntry, true, true);
        SearchValue(2, 99999, 45, 0, false, TextNegEntry, true, true);
        SearchValue(2, 99999, 50, 0, false, TextTransf, true, true);
        SearchValue(2, 99999, 52, 0, false, TextEmployeeAbs, false, false);
        SearchValue(2, 99999, 60, 0, false, TextCust1, true, true);
        SearchValue(2, 99999, 61, 0, false, TextCust2, true, true);
        SearchValue(2, 99999, 64, 0, false, TextVendor1, true, true);
        SearchValue(2, 99999, 65, 0, false, TextVendor2, true, true);
        SearchValue(2, 99999, 66, 0, false, TextGLBudget, false, false);
        SearchValue(2, 99999, 67, 0, false, TextGLEntry, true, true);
        SearchValue(2, 99999, 68, 0, false, TextQuotes, false, false);
        SearchValue(2, 99999, 69, 0, false, TextOrderPrev, false, false);
        SearchValue(2, 99999, 70, 0, false, TextOrder, false, false);
        SearchValue(2, 99999, 71, 0, false, TextShip, false, false);
        SearchValue(2, 99999, 73, 0, false, TextPurchQuote, false, false);
        SearchValue(2, 99999, 74, 0, false, TextPurchOrderPrev, false, false);
        SearchValue(2, 99999, 75, 0, false, TextPurchOrder, false, false);
        SearchValue(2, 99999, 76, 0, false, TextPurchShip, false, false);
        SearchValue(2, 99999, 80, 0, false, TextConsumption, false, false);
        SearchValue(2, 99999, 81, 0, false, TextOutput, false, false);
        SearchValue(2, 99999, 82, 0, false, TextSalesForecast, false, false);
        SearchValue(2, 99999, 83, 0, false, TextComponentForecast, false, false);
        //NAVIBAT_STATS
        SearchValue(2, 99999, 23, 0, false, TextBudJobInitial, false, false);
        SearchValue(2, 99999, 24, 0, false, TextBudJobRevision, false, false);
        SearchValue(2, 99999, 26, 0, false, TextBudJobAdvanced, false, false);
        StatisticsSetup.Validate("Free value name 1", PrixRevient);
        StatisticsSetup.Modify;
        //NAVIBAT_STATS

        // Values
        SearchValue(3, 20, 10, 0, true, '', false, false);
        SearchValue(3, 21, 15, 0, false, '', false, false);
        SearchValue(3, 23, 20, 0, true, '', false, false);
        SearchValue(3, 24, 25, 0, true, '', false, false);
        SearchValue(3, 99999, 30, 0, true, Formule, false, false);
        SearchValue(3, 99999, 35, 0, true, PourcentageSousTotal, false, false);
        SearchValue(3, 99999, 38, 0, true, PourcentageTotal, false, false);
        SearchValue(3, 99999, 40, 0, false, RemiseLigne, false, false);
        SearchValue(3, 99999, 42, 0, false, RemisePied, false, false);
        SearchValue(3, 99999, 44, 0, false, RFA, false, false);
        SearchValue(3, 99999, 46, 0, false, Commission, false, false);
        SearchValue(3, 99999, 70, 0, true, Moyenne, false, false);
        SearchValue(3, 99999, 71, 0, true, Minimum, false, false);
        SearchValue(3, 99999, 72, 0, true, Maximum, false, false);
        SearchValue(3, 99999, 73, 0, true, NbVal, false, false);
        //NAVIBAT_STATS
        //SearchValue(3,80,51,0,FALSE,'',FALSE,FALSE);
        SearchValue(3, 99999, 51, 0, true, PrixRevient, false, false);
        //NAVIBAT_STATS//
        SearchValue(3, 81, 52, 0, false, '', false, false);
        SearchValue(3, 82, 53, 0, false, '', false, false);
        SearchValue(3, 83, 54, 0, false, '', false, false);
        SearchValue(3, 84, 55, 0, false, '', false, false);
        SearchValue(3, 85, 56, 0, false, '', false, false);
        SearchValue(3, 86, 57, 0, false, '', false, false);
        SearchValue(3, 87, 58, 0, false, '', false, false);
        SearchValue(3, 88, 59, 0, false, '', false, false);
        SearchValue(3, 89, 60, 0, false, '', false, false);

        InitFields;
    end;

    var
        StatisticAggregate: Record "Statistic aggregate";
        StatisticCriteria: Record "Statistic criteria";
        StatisticCriteria2: Record "Statistic criteria";
        StatisticsSetup: Record "Statistics setup";
        TableField: Record "Field";
        Dimension: Record Dimension;
        StatsExplorerFields: Record "StatsExplorer fields";
        TypeCriteria1: Integer;
        Groupe: label 'STATS';
        LireStatistiques: label 'Read statistic';
        Formule: label 'Formula';
        PourcentageSousTotal: label 'Subtotal %';
        PourcentageTotal: label 'GrandTotal %';
        RemiseLigne: label 'Line discount';
        RemisePied: label 'Document discount';
        RFA: label 'Back discount';
        Commission: label 'Commission';
        Moyenne: label 'Average';
        Minimum: label 'Minimum';
        Maximum: label 'Maximum';
        NbVal: label 'Number of values';
        TextSales: label 'Sale';
        TextPurch: label 'Purchase';
        TextSalesJob: label 'Job sale';
        TextActJob: label 'Job Usage';
        TextBudJob: label 'Planned Job Budget';
        TextCapacity: label 'Resource Capacity';
        TextSalesResource: label 'Resource sale';
        TextActResource: label 'Resource Usage';
        TextRFA: label 'Back discount entries';
        TextCommission: label 'Commission ledger entries';
        TextItemAvail: label 'Item Availability by Location';
        TextPosEntry: label 'Positive Adjustment';
        TextNegEntry: label 'Negative Adjustment';
        TextTransf: label 'Transfer';
        TextEmployeeAbs: label 'Employee Absence';
        TextCust1: label 'Customer ledger entries by due date';
        TextCust2: label 'Customer ledger entries by date';
        TextVendor1: label 'Vendor ledger entries by due date';
        TextVendor2: label 'Vendor ledger entries by date';
        TextGLBudget: label 'G/L Budget Entry';
        TextGLEntry: label 'General ledger entries';
        TextQuotes: label 'Sale, quotes';
        TextOrderPrev: label 'Sale, blanket order';
        TextOrder: label 'Sale, ordered not shipped';
        TextShip: label 'Sale, shipped';
        TextPurchQuote: label 'Purchase, Quote';
        TextPurchOrderPrev: label 'Purchase, Blanket Orders';
        TextPurchOrder: label 'Purchase, Sales Back Orders';
        TextPurchShip: label 'Purchase, Shipped Not Invoiced';
        //GL2024 Le code unité 1 n'existe pas dans BC 24.  ApplicationManagement: Codeunit ApplicationManagement;
        TextConsumption: label 'Prod. Order, consumption';
        TextOutput: label 'Prod. Order, output';
        TextSalesForecast: label 'Prod. Forecast, Sales';
        TextComponentForecast: label 'Prod. Forecast, Component';
        TextBudJobInitial: label 'Initial Job Budget';
        TextBudJobRevision: label 'Revision Job Budget';
        TextBudJobAdvanced: label 'Advanced Job Budget';
        PrixRevient: label 'Gross Total Cost';


    procedure InitFields()
    begin
        StatsExplorerFields.InitStatsExplorerFields(TextSales, 6, 8, 9, 11, 12, 13, 14, 15, 16, 17);
        StatsExplorerFields.InitStatsExplorerFields(TextSales, 18, 45, 50, 51, 52, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextSales, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextSales, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextSales, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextSales, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextPurch, 6, 8, 9, 11, 12, 13, 14, 15, 16, 17);
        StatsExplorerFields.InitStatsExplorerFields(TextPurch, 18, 45, 50, 51, 52, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextPurch, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextPurch, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextPurch, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextPurch, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        //StatsExplorerFields.InitStatsExplorerFields(TextSalesJob,5,6,15,17,18,40,41,42,43,44);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesJob, 5, 6, 15, 17, 18, 40, 41, 44, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesJob, 45, 46, 47, 0, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesJob, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesJob, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesJob, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesJob, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        //StatsExplorerFields.InitStatsExplorerFields(TextActJob,5,6,15,17,18,40,41,42,43,44);
        StatsExplorerFields.InitStatsExplorerFields(TextActJob, 5, 6, 15, 17, 18, 40, 41, 44, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextActJob, 45, 46, 47, 0, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextActJob, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextActJob, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextActJob, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextActJob, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        //StatsExplorerFields.InitStatsExplorerFields(TextBudJob,5,6,15,17,18,40,41,42,43,44);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJob, 5, 6, 15, 17, 18, 40, 41, 44, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJob, 45, 46, 47, 0, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJob, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJob, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        //StatsExplorerFields.InitStatsExplorerFields(TextBudJob,5,6,40,41,42,43,0,0,0,0);
        //StatsExplorerFields.InitStatsExplorerFields(TextBudJob,201,202,203,204,205,206,207,208,209,210);
        //StatsExplorerFields.InitStatsExplorerFields(TextBudJob,211,212,213,214,215,216,217,218,219,220);
        //NAVIBAT_STATS
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobInitial, 5, 6, 15, 17, 18, 40, 41, 42, 43, 44);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobInitial, 45, 46, 47, 0, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobInitial, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobInitial, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobRevision, 5, 6, 15, 17, 18, 40, 41, 42, 43, 44);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobRevision, 45, 46, 47, 0, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobRevision, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobRevision, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobAdvanced, 5, 6, 15, 17, 18, 40, 41, 42, 43, 44);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobAdvanced, 45, 46, 47, 0, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobAdvanced, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobAdvanced, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        //#8127
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobInitial, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobInitial, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobRevision, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobRevision, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobAdvanced, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJobAdvanced, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJob, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextBudJob, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        //#8127//
        //NAVIBAT_STATS//

        StatsExplorerFields.InitStatsExplorerFields(TextCapacity, 6, 47, 0, 0, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextCapacity, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextCapacity, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        //StatsExplorerFields.InitStatsExplorerFields(TextCapacity,201,202,203,204,205,206,207,208,209,210);
        //StatsExplorerFields.InitStatsExplorerFields(TextCapacity,211,212,213,214,215,216,217,218,219,220);

        StatsExplorerFields.InitStatsExplorerFields(TextSalesResource, 6, 14, 15, 17, 18, 40, 44, 45, 47, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesResource, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesResource, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesResource, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesResource, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextActResource, 6, 14, 15, 17, 18, 40, 44, 45, 47, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextActResource, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextActResource, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextActResource, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextActResource, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextRFA, 6, 8, 9, 11, 12, 13, 14, 15, 16, 17);
        StatsExplorerFields.InitStatsExplorerFields(TextRFA, 18, 45, 50, 51, 52, 59, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextRFA, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextRFA, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextRFA, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextRFA, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextCommission, 6, 8, 9, 11, 12, 13, 14, 15, 16, 17);
        StatsExplorerFields.InitStatsExplorerFields(TextCommission, 18, 45, 50, 51, 52, 59, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextCommission, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextCommission, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextCommission, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextCommission, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextItemAvail, 6, 11, 0, 0, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextItemAvail, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextItemAvail, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextItemAvail, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextItemAvail, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextPosEntry, 6, 8, 9, 11, 12, 13, 14, 15, 16, 17);
        StatsExplorerFields.InitStatsExplorerFields(TextPosEntry, 18, 45, 50, 51, 52, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextPosEntry, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextPosEntry, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextPosEntry, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextPosEntry, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextNegEntry, 6, 8, 9, 11, 12, 13, 14, 15, 16, 17);
        StatsExplorerFields.InitStatsExplorerFields(TextNegEntry, 18, 45, 50, 51, 52, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextNegEntry, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextNegEntry, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextNegEntry, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextNegEntry, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextTransf, 6, 8, 9, 11, 12, 13, 14, 15, 16, 17);
        StatsExplorerFields.InitStatsExplorerFields(TextTransf, 18, 45, 50, 51, 52, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextTransf, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextTransf, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextTransf, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextTransf, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextEmployeeAbs, 6, 45, 0, 0, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextEmployeeAbs, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextEmployeeAbs, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        //StatsExplorerFields.InitStatsExplorerFields(TextEmployeeAbs,201,202,203,204,205,206,207,208,209,210);
        //StatsExplorerFields.InitStatsExplorerFields(TextEmployeeAbs,211,212,213,214,215,216,217,218,219,220);

        StatsExplorerFields.InitStatsExplorerFields(TextCust1, 9, 13, 17, 18, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextCust1, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextCust1, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextCust1, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextCust1, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextCust2, 9, 13, 17, 18, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextCust2, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextCust2, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextCust2, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextCust2, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextVendor1, 9, 13, 17, 18, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextVendor1, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextVendor1, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextVendor1, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextVendor1, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextVendor2, 9, 13, 17, 18, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextVendor2, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextVendor2, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextVendor2, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextVendor2, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextGLBudget, 6, 9, 17, 18, 37, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextGLBudget, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextGLBudget, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextGLBudget, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextGLBudget, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextGLEntry, 6, 9, 17, 18, 37, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextGLEntry, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextGLEntry, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextGLEntry, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextGLEntry, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextQuotes, 5, 6, 9, 11, 12, 13, 14, 15, 16, 17);
        //StatsExplorerFields.InitStatsExplorerFields(TextQuotes,18,40,41,42,43,44,45,0,0,0);
        StatsExplorerFields.InitStatsExplorerFields(TextQuotes, 18, 40, 41, 44, 45, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextQuotes, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextQuotes, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextQuotes, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextQuotes, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextOrderPrev, 5, 6, 9, 11, 12, 13, 14, 15, 16, 17);
        //StatsExplorerFields.InitStatsExplorerFields(TextOrderPrev,18,40,41,42,43,44,45,0,0,0);
        StatsExplorerFields.InitStatsExplorerFields(TextOrderPrev, 18, 40, 41, 44, 45, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextOrderPrev, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextOrderPrev, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextOrderPrev, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextOrderPrev, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextOrder, 5, 6, 9, 11, 12, 13, 14, 15, 16, 17);
        //StatsExplorerFields.InitStatsExplorerFields(TextOrder,18,40,41,42,43,44,45,0,0,0);
        StatsExplorerFields.InitStatsExplorerFields(TextOrder, 18, 40, 41, 44, 45, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextOrder, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextOrder, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextOrder, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextOrder, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextShip, 5, 6, 9, 11, 12, 13, 14, 15, 16, 17);
        //StatsExplorerFields.InitStatsExplorerFields(TextShip,18,40,41,42,43,44,45,0,0,0);
        StatsExplorerFields.InitStatsExplorerFields(TextShip, 18, 40, 41, 44, 45, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextShip, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextShip, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextShip, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextShip, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatsExplorerFields.InitStatsExplorerFields(TextPurchQuote, 5, 6, 9, 11, 12, 13, 14, 15, 16, 17);
        //StatsExplorerFields.InitStatsExplorerFields(TextPurchQuote,18,40,41,42,43,44,45,0,0,0);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchQuote, 18, 40, 41, 44, 45, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchQuote, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchQuote, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchQuote, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchQuote, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrderPrev, 5, 6, 9, 11, 12, 13, 14, 15, 16, 17);
        //StatsExplorerFields.InitStatsExplorerFields(TextPurchOrderPrev,18,40,41,42,43,44,45,0,0,0);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrderPrev, 18, 40, 41, 44, 45, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrderPrev, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrderPrev, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrderPrev, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrderPrev, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrder, 5, 6, 9, 11, 12, 13, 14, 15, 16, 17);
        //StatsExplorerFields.InitStatsExplorerFields(TextPurchOrder,18,40,41,42,43,44,45,0,0,0);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrder, 18, 40, 41, 44, 45, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrder, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrder, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrder, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchOrder, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchShip, 5, 6, 9, 11, 12, 13, 14, 15, 16, 17);
        //StatsExplorerFields.InitStatsExplorerFields(TextPurchShip,18,40,41,42,43,44,45,0,0,0);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchShip, 18, 40, 41, 44, 45, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchShip, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchShip, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchShip, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextPurchShip, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        //#8450
        StatsExplorerFields.InitStatsExplorerFields(TextConsumption, 6, 8, 9, 11, 12, 13, 14, 15, 16, 17);
        StatsExplorerFields.InitStatsExplorerFields(TextConsumption, 18, 45, 50, 51, 52, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextConsumption, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextConsumption, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextConsumption, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextConsumption, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextOutput, 6, 8, 9, 11, 12, 13, 14, 15, 16, 17);
        StatsExplorerFields.InitStatsExplorerFields(TextOutput, 18, 45, 50, 51, 52, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextOutput, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextOutput, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextOutput, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextOutput, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        //#8450//

        StatsExplorerFields.InitStatsExplorerFields(TextSalesForecast, 5, 6, 8, 9, 11, 12, 15, 16, 17, 18);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesForecast, 53, 54, 55, 56, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesForecast, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesForecast, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesForecast, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesForecast, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextSalesForecast, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
        StatsExplorerFields.InitStatsExplorerFields(TextComponentForecast, 5, 6, 8, 9, 11, 12, 15, 16, 17, 18);
        StatsExplorerFields.InitStatsExplorerFields(TextComponentForecast, 53, 54, 55, 56, 0, 0, 0, 0, 0, 0);
        StatsExplorerFields.InitStatsExplorerFields(TextComponentForecast, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69);
        StatsExplorerFields.InitStatsExplorerFields(TextComponentForecast, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
        StatsExplorerFields.InitStatsExplorerFields(TextComponentForecast, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
        StatsExplorerFields.InitStatsExplorerFields(TextComponentForecast, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
        StatsExplorerFields.InitStatsExplorerFields(TextComponentForecast, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);

        StatisticCriteria.SetRange(Type, StatisticCriteria.Type::Flow);
        StatisticCriteria.SetRange("Field No.", 90, 99);
        if not StatisticCriteria.IsEmpty then begin
            StatisticCriteria.FindSet;
            repeat
                StatsExplorerFields.InitStatsExplorerFields(StatisticCriteria."Field name", 6, 8, 9, 11, 12, 13, 14, 15, 16, 17);
                StatsExplorerFields.InitStatsExplorerFields(StatisticCriteria."Field name", 18, 45, 50, 51, 52, 0, 0, 0, 0, 0);
                StatsExplorerFields.InitStatsExplorerFields(StatisticCriteria."Field name", 80, 81, 82, 83, 84, 85, 86, 87, 88, 89);
                StatsExplorerFields.InitStatsExplorerFields(StatisticCriteria."Field name", 90, 91, 92, 93, 94, 95, 96, 97, 98, 99);
                StatsExplorerFields.InitStatsExplorerFields(StatisticCriteria."Field name", 201, 202, 203, 204, 205, 206, 207, 208, 209, 210);
                StatsExplorerFields.InitStatsExplorerFields(StatisticCriteria."Field name", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
            until StatisticCriteria.Next = 0;
        end;
    end;


    procedure SearchValue(TypeCritere2: Integer; NoField: Integer; NumeroChamp: Integer; LongueurChamp: Integer; ChampActif: Boolean; NomChamp: Text[250]; RealTimeUpdate: Boolean; RealTimeUpdateAvailable: Boolean) Trouve: Boolean
    begin
        with StatisticCriteria do begin
            case TypeCritere2 of
                1:
                    SetRange(Type, Type::"Sort criteria");
                2:
                    SetRange(Type, Type::Flow);
                3:
                    SetRange(Type, Type::Value);
            end;
            SetRange("Field No.", NumeroChamp);
            if IsEmpty then begin
                Init;
                case TypeCritere2 of
                    1:
                        begin
                            Type := Type::"Sort criteria";
                            if NomChamp <> '' then begin
                                "Field name" := CopyStr(NomChamp, 1, 30);
                                "Source name" := CopyStr(NomChamp, 1, 30);
                            end;
                            if (NoField <> 99999) and (TableField.Get(8001300, NoField)) then begin
                                "Field name" := CopyStr(TableField."Field Caption", 1, 30);
                                "Source name" := CopyStr(TableField."Field Caption", 1, 30);
                            end;
                            /* Le code unité 1 n'existe pas dans BC 24
                             if NoField = 17 then begin
                                  "Field name" := CopyStr(ApplicationManagement.CaptionClassTranslate(0, '1,1,1'), 1, 30);
                                  "Source name" := CopyStr(ApplicationManagement.CaptionClassTranslate(0, '1,1,1'), 1, 30);
                              end;
                              if NoField = 18 then begin
                                  "Field name" := CopyStr(ApplicationManagement.CaptionClassTranslate(0, '1,1,2'), 1, 30);
                                  "Source name" := CopyStr(ApplicationManagement.CaptionClassTranslate(0, '1,1,2'), 1, 30);
                              end;*/
                            if ((NoField > 30000) and (NoField <= 30020)) then begin
                                if Dimension.Get(NomChamp) then begin
                                    "Field name" := CopyStr(Dimension."Code Caption", 1, 30);
                                    ChampActif := true;
                                end;
                            end;
                        end;
                    2:
                        begin
                            Type := Type::Flow;
                            if NomChamp <> '' then begin
                                "Field name" := CopyStr(NomChamp, 1, 30);
                                "Source name" := CopyStr(NomChamp, 1, 30);
                            end;
                        end;
                    3:
                        begin
                            Type := Type::Value;
                            if NomChamp <> '' then begin
                                "Field name" := CopyStr(NomChamp, 1, 30);
                                "Source name" := CopyStr(NomChamp, 1, 30);
                            end;
                            if (NoField <> 99999) and (TableField.Get(8001300, NoField)) then begin
                                "Field name" := CopyStr(TableField."Field Caption", 1, 30);
                                "Source name" := CopyStr(TableField."Field Caption", 1, 30);
                            end;
                        end;
                end;
                "Field No." := NumeroChamp;

                if (NoField = 2000) and (TableField.Get(2000000003, 5)) then begin
                    "Field name" := CopyStr(TableField."Field Caption", 1, 30);
                    "Source name" := CopyStr(TableField."Field Caption", 1, 30);
                end;
                Length := LongueurChamp;
                "Real-Time Update" := RealTimeUpdate;
                "Real-Time Update available" := RealTimeUpdateAvailable;
                if (StrPos(COMPANYNAME, 'CRONUS') = 1) and (TypeCritere2 = 2) then
                    Enabled := true
                else
                    Enabled := ChampActif;
                if not StatisticCriteria2.Get(Type, "Field name") then
                    Insert(true);
            end;
        end;
    end;


    procedure CreateIndirectSecurity()
    begin
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 9, 9);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 11, 15);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 18, 18);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 23, 23);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 27, 27);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 92, 94);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 152, 152);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 156, 156);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 161, 163);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 167, 167);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 200, 200);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 208, 208);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 231, 231);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 250, 251);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 5200, 5200);
        CreateGroup(Groupe, LireStatistiques, 0, 2, 0, 5206, 5206);
    end;


    procedure CreateGroup(Groupe: Code[20]; NomGroupe: Text[30]; TypeObjet: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System; Lecture: Option " ",Oui,Indirect; Ecriture: Option " ",Oui,Indirect; NumeroTableDebut: Integer; NumeroTableFin: Integer)
    var
        //GL2024 MembreDe: Record 2000000003;
        GroupeSecurite: Record "Permission Set";
        //GL2024 License "Object": Record "Objet";
        //GL2024 License
        "Objet": Record AllObj;
        //GL2024 License

        NewTypeObjet: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System;
    begin
        if/*GL2024 (MembreDe.WritePermission) or*/ (StrPos(COMPANYNAME, 'CRONUS') = 1) then begin
            if not GroupeSecurite.Get(Groupe) then begin
                GroupeSecurite.Init;
                GroupeSecurite."Role ID" := Groupe;
                GroupeSecurite.Name := NomGroupe;
                GroupeSecurite.Insert;
            end;
            NewTypeObjet := TypeObjet;
            if NewTypeObjet = 0 then
                NewTypeObjet := 1;
            repeat
                if (NumeroTableDebut = 2000000001) or (TypeObjet = Typeobjet::System) or (Objet.Get(NewTypeObjet, '', NumeroTableDebut)) then
                    CreatePermission(Groupe, NumeroTableDebut, TypeObjet, Lecture, Ecriture);
                NumeroTableDebut := NumeroTableDebut + 1;
            until NumeroTableDebut > NumeroTableFin;
        end;
    end;


    procedure CreatePermission(Groupe: Code[20]; NumeroTable: Integer; TypeObjet: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System; Lecture: Option " ",Oui,Indirect; Ecriture: Option " ",Oui,Indirect)
    var
        Autorisation: Record Permission;
    begin
        if not Autorisation.Get(Groupe, TypeObjet, NumeroTable) then
            with Autorisation do begin
                Init;
                "Role ID" := Groupe;
                "Object Type" := TypeObjet;
                "Object ID" := NumeroTable;
                "Read Permission" := "Read Permission";
                "Insert Permission" := Ecriture;
                "Modify Permission" := Ecriture;
                "Delete Permission" := Ecriture;
                Insert;
            end;
    end;
}

