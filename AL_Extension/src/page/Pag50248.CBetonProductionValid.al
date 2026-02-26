// page 50248 "C.Beton-Production Validé"
// {
//     DelayedInsert = true;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "BL Carriere";
//     SourceTableView = SORTING(Date)
//                       WHERE("N° Societe" = FILTER('BZ4'),
//                             "Production Créer" = CONST(true));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'C.Beton-Production Validé';
//     layout
//     {
//         area(content)
//         {
//             group(Production)
//             {
//                 Caption = 'Production';
//                 repeater(content1)
//                 {
//                     ShowCaption = false;
//                     field(Date; rec.Date)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                         Enabled = true;
//                     }
//                     field(Heure; rec.Heure)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("N° Sequence"; rec."N° Sequence")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'BL N°';
//                         Editable = false;
//                     }
//                     field("Code Produit"; rec."Code Produit")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Produit';
//                     }
//                     field("Produit Production"; rec."Produit Production")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(Nature; rec.Nature)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(Dosage; rec.Dosage)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(Adjuvant; rec.Adjuvant)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Code Client"; rec."Code Client")
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("Client Nav"; rec."Client Nav")
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field("Nom Client"; rec."Nom Client")
//                     {
//                         ApplicationArea = all;
//                         Style = Unfavorable;
//                         StyleExpr = TRUE;
//                     }
//                     field("Chantier Client"; rec."Chantier Client")
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field(Quantité; rec.Quantité)
//                     {
//                         ApplicationArea = all;
//                         DecimalPlaces = 0 : 3;
//                         Editable = false;
//                         Style = Strong;
//                         StyleExpr = TRUE;
//                     }
//                     field("Selection Production"; rec."Selection Production")
//                     {
//                         ApplicationArea = all;
//                     }
//                 }
//             }
//             group("Detail Consommation Automate")
//             {
//                 Caption = 'Detail Consommation Automate';
//                 part("Detail-Consom-Automate"; "Detail-Consom-Automate")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Num_BL" = FIELD("N° Sequence");
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         BLCarriere: Record "BL Carriere";
//         ItemJournalLine: Record "Item Journal Line";
//         ItemJrlLine2: Record "Item Journal Line";
//         ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
//         DetailConsommationCentral: Record "Details Consommation BL Beton";
//         DetailConsommationCentral2: Record "Details Consommation BL Beton";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         Text001: Label 'Aucun Article Production n''est Paramétré Comme Nomenclature pour Le BL N° %1';
//         Text002: Label 'Vous devez vérifier la correspondance de base article pour l''article %1';
//         Text003: Label 'Aucun Detail Consommation n''est Lié au Bon N° %1 ?';
//         Text004: Label 'Taches Achever Avec Succée';
//         Text005: Label 'Lancer La Creation Des Ordre de Fabrications ?';
//         Text006: Label 'Action Achever Avec Succé';
//         ProductionOrder: Record "Production Order";
//         ProductionBOMHeader: Record "Production BOM Header";
//         ItemJnlPost: Codeunit "Item Jnl.-Post Line";
//         i: Integer;
//         NumProdInitial: Code[20];
//         NumProdFinal: Code[20];
//         CopyProdOrderDoc: Report "Copy Production Order Document";
//         ManuPrintReport: Codeunit "Manu. Print Report";
//         "Production Order": Record "Production Order";
//         "Production Order Line": Record "Prod. Order Line";
//         ProdOrderStatusManagement: Codeunit "Prod. Order Status Management";
//         DateEcheance: Date;
//         ProductionOrder2: Record "Production Order";
//         Item: Record Item;
//         CalcMethod: Option "One Level","All Levels";
//         UpdateReservations: Boolean;
//         UpdateProdOrderCost: Codeunit "Update Prod. Order Cost";
//         ProdOrderLine: Record "Prod. Order Line";
//         MateriauxBLBeton: Record "Materiaux BL Beton";
//         Ligne: Integer;
//         CodeTempo: Code[20];


//     procedure CreerProd()
//     begin
//         IF NOT CONFIRM(Text003) THEN EXIT;
//         BLCarriere.COPY(Rec);
//         BLCarriere.SETRANGE("Selection Production", TRUE);
//         IF BLCarriere.FINDFIRST THEN
//             REPEAT
//                 i += 1;
//                 BLCarriere.CALCFIELDS("Produit Production", "Nom Client", "Chantier Client");
//                 IF BLCarriere."Produit Production" = '' THEN ERROR(Text001, BLCarriere."N° Sequence");
//                 CLEAR(ProductionOrder);
//                 ProductionOrder.INIT;
//                 ProductionOrder.Status := ProductionOrder.Status::Released;
//                 ProductionOrder.INSERT(TRUE);
//                 ProductionOrder."Source Type" := ProductionOrder."Source Type"::Item;
//                 ProductionOrder.VALIDATE("Source No.", BLCarriere."Produit Production");
//                 ProductionOrder.VALIDATE("Due Date", BLCarriere.Date);
//                 ProductionOrder.VALIDATE(Quantity, BLCarriere.Quantité);
//                 IF BLCarriere."N° Societe" = 'BZ4' THEN BEGIN
//                     ProductionOrder.Centrale := 'CENTRALZ4';
//                     ProductionOrder."Location Code" := ProductionOrder.Centrale;
//                 END;
//                 ProductionOrder."N° BL" := BLCarriere."N° Sequence";
//                 ProductionOrder.Destination := BLCarriere."Chantier Client";
//                 ProductionOrder.Camion := BLCarriere.Camion;
//                 ProductionOrder.Client := COPYSTR(BLCarriere."Nom Client", 1, 20);
//                 ProductionOrder.Observation := 'Adjuvant : ' + BLCarriere.Adjuvant + ' ---- POMPEE :' + BLCarriere.Pompe +
//                                              ' --- Code Operation : ' + BLCarriere."Code Produit";
//                 ProductionOrder.Automate := TRUE;
//                 ProductionOrder.MODIFY;
//                 BLCarriere."Selection Production" := FALSE;
//                 BLCarriere."N° Production" := ProductionOrder."No.";
//                 IF i = 1 THEN NumProdInitial := ProductionOrder."No.";
//                 IF i > 1 THEN NumProdFinal := ProductionOrder."No.";
//                 BLCarriere.MODIFY;

//             UNTIL BLCarriere.NEXT = 0;
//         CurrPage.UPDATE;
//         MESSAGE(Text004, NumProdInitial, NumProdFinal);
//     end;
// }

