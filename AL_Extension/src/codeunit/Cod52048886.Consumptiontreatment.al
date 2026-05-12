//GL3900
// Codeunit 52048886 "Consumption treatment"
// {
//     //GL2024  ID dans Nav 2009 : "39002013"
//     trigger OnRun()
//     begin
//     end;

//     var
//         WORKMGT: Record "Work Setup";
//         txt1: label 'There is n consumption to validate';
//         txt2: label 'Please set the Item Consumption Template in Maintenance Parameters';
//         txt3: label 'Please set the default item  journal name in Maintenance Parameters';
//         JnItem: Page "Consumption Journal GMAO";
//         JnRes: Page "Resource Journal GMAO";
//         txt4: label 'Please set the Resource Consumption Template in Maintenance Parameters';
//         txt5: label 'Please set the default Resource journal name in Maintenance Parameters';
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         ItemJnlBatch: Record "Item Journal Batch";
//         ARTtmp: Record "ARTICLE/BT";
//         INTtmp: Record "Intervenant/bt";


//     procedure ExportToJournal(bt: Record BT; Run: Boolean)
//     var
//         art: Record "ARTICLE/BT";
//         journal: Record "Item Journal Line";
//         INT: Integer;
//     begin
//         //WORKMGT.GET;
//         //ItemJnlBatch.RESET;
//         //ItemJnlBatch.GET(WORKMGT."Modèle de feuille article",WORKMGT."Feuille Déf con. Article");
//         art.Reset;
//         art.SetFilter(art."code ot", bt.cd_OT);
//         art.SetRange(art."code bt", bt."code BT");
//         if art.Find('-') then begin
//             WORKMGT.Get;
//             if WORKMGT."Modèle de feuille article" <> '' then begin
//                 if WORKMGT."Feuille Déf con. Article" <> '' then begin
//                     INT := 1;

//                     repeat
//                         if not art.Validé then begin
//                             journal."Journal Template Name" := WORKMGT."Modèle de feuille article";
//                             journal."Journal Batch Name" := WORKMGT."Feuille Déf con. Article";
//                             journal."Line No." := INT;
//                             WORKMGT.Get;
//                             if WORKMGT."N° doc. égal n° O.T." then
//                                 journal."Document No." := bt.cd_OT;
//                             journal.Insert(true);
//                             journal."Posting Date" := WorkDate;
//                             journal."Entry Type" := journal."entry type"::"Negative Adjmt.";
//                             /* GL2024  journal."Work order" := bt.cd_OT;
//                               journal."Work sheet" := bt."code BT";
//                               journal.MES := Run;*/
//                             journal.Validate(journal."Item No.", art.article);
//                             journal.Validate(journal."Location Code", art.magasin);
//                             journal.Validate(Quantity, art."Quantité réalisée");
//                             journal.Modify;
//                             INT += 1;
//                         end;

//                     until art.Next = 0;
//                     JnItem.SetRecord(journal);
//                     JnItem.Run;
//                 end
//                 else
//                     Message(txt3);
//             end
//             else
//                 Message(txt2);
//         end else
//             if not Run then
//                 Message(txt1);
//     end;


//     procedure ValidateConsumption(bt: Record BT; Run: Boolean)
//     var
//         art: Record "ARTICLE/BT";
//         journal: Record "Item Journal Line";
//         INT: Integer;
//     begin
//         art.Reset;
//         art.SetFilter(art."code ot", bt.cd_OT);
//         art.SetRange(art."code bt", bt."code BT");
//         if art.Find('-') then begin
//             WORKMGT.Get;
//             if WORKMGT."Modèle de feuille article" <> '' then begin
//                 if WORKMGT."Feuille Déf con. Article" <> '' then begin
//                     // MESSAGE(FORMAT(WORKMGT."Modèle de feuille article"));
//                     INT := 1;
//                     repeat
//                         if not art.Validé then begin

//                             journal."Journal Template Name" := WORKMGT."Modèle de feuille article";
//                             journal."Journal Batch Name" := WORKMGT."Feuille Déf con. Article";
//                             journal."Line No." := INT;
//                             journal.Insert(true);
//                             journal."Posting Date" := WorkDate;
//                             journal."Entry Type" := journal."entry type"::"Negative Adjmt.";
//                             /* GL2024  journal."Work order" := bt.cd_OT;
//                               journal."Work sheet" := bt."code BT";*/

//                             WORKMGT.Get;
//                             if WORKMGT."N° doc. égal n° O.T." then
//                                 journal."Document No." := bt.cd_OT;
//                             journal.Validate(journal."Item No.", art.article);
//                             journal.Validate(journal."Location Code", art.magasin);
//                             journal.Validate(Quantity, art."Quantité réalisée");
//                             /* GL2024 if Run = true then
//                                  journal.MES := true
//                              else
//                                  journal.MES := false;*/

//                             journal.Modify;
//                             INT += 1;
//                         end;

//                     until art.Next = 0;

//                     //IF journal.FIND('-') THEN
//                     ARTtmp.Reset;
//                     ARTtmp.SetFilter(ARTtmp."code ot", bt.cd_OT);
//                     ARTtmp.SetRange(ARTtmp."code bt", bt."code BT");
//                     ARTtmp.SetRange(ARTtmp.Validé, false);
//                     if ARTtmp.Find('-') then
//                         Codeunit.Run(Codeunit::"Item Jnl.-Post", journal);
//                 end
//                 else
//                     Message(txt3);
//             end
//             else
//                 Message(txt2);
//         end else
//             if not Run then
//                 Message(txt1);
//     end;


//     procedure ValidateConsumptionAndPrint(bt: Record BT; Run: Boolean)
//     var
//         art: Record "ARTICLE/BT";
//         journal: Record "Item Journal Line";
//         INT: Integer;
//     begin
//         art.Reset;
//         art.SetFilter(art."code ot", bt.cd_OT);
//         art.SetRange(art."code bt", bt."code BT");
//         if art.Find('-') then begin
//             WORKMGT.Get;
//             if WORKMGT."Modèle de feuille article" <> '' then begin
//                 if WORKMGT."Feuille Déf con. Article" <> '' then begin
//                     INT := 1;
//                     repeat
//                         if not art.Validé then begin
//                             journal."Journal Template Name" := WORKMGT."Modèle de feuille article";
//                             journal."Journal Batch Name" := WORKMGT."Feuille Déf con. Article";
//                             journal."Line No." := INT;
//                             journal.Insert(true);
//                             journal."Posting Date" := WorkDate;
//                             journal."Entry Type" := journal."entry type"::"Negative Adjmt.";
//                             /*  GL2024  journal."Work order" := bt.cd_OT;
//                                journal."Work sheet" := bt."code BT";*/
//                             WORKMGT.Get;
//                             if WORKMGT."N° doc. égal n° O.T." then
//                                 journal."Document No." := bt.cd_OT;
//                             journal.Validate(journal."Item No.", art.article);
//                             journal.Validate(journal."Location Code", art.magasin);
//                             journal.Validate(Quantity, art."Quantité réalisée");
//                             /*  GL2024 if Run then
//                                  journal.MES := true
//                              else
//                                  journal.MES := false;*/

//                             journal.Modify;
//                             INT += 1;
//                         end;
//                     until art.Next = 0;

//                     //IF journal.FIND('-') THEN
//                     ARTtmp.Reset;
//                     ARTtmp.SetFilter(ARTtmp."code ot", bt.cd_OT);
//                     ARTtmp.SetRange(ARTtmp."code bt", bt."code BT");
//                     ARTtmp.SetRange(ARTtmp.Validé, false);
//                     if ARTtmp.Find('-') then
//                         Codeunit.Run(Codeunit::"Item Jnl.-Post", journal);


//                 end
//                 else
//                     Message(txt3);
//             end
//             else
//                 Message(txt2);
//         end else
//             if not Run then
//                 Message(txt1);
//     end;


//     procedure "ExportToRes.Journal"(bt: Record BT; Run: Boolean)
//     var
//         interv: Record "Intervenant/bt";
//         journal: Record "Res. Journal Line";
//         INT: Integer;
//     begin
//         interv.Reset;
//         interv.SetFilter(interv.cd_ot, bt.cd_OT);
//         interv.SetRange(interv.cd_bt, bt."code BT");
//         if interv.Find('-') then begin
//             WORKMGT.Get;
//             if WORKMGT."Modèle de feuille ressource" <> '' then begin
//                 if WORKMGT."Feuille Déf RES" <> '' then begin
//                     INT := 1;
//                     repeat
//                         if not interv.Validé then begin
//                             journal."Journal Template Name" := WORKMGT."Modèle de feuille ressource";
//                             journal."Journal Batch Name" := WORKMGT."Feuille Déf RES";
//                             journal."Line No." := INT;
//                             journal.Insert(true);
//                             journal."Posting Date" := WorkDate;
//                             journal."Entry Type" := journal."entry type"::Usage;
//                             /* GL2024  journal."Work Order" := bt.cd_OT;
//                               journal."Work Sheet" := bt."code BT";*/
//                             WORKMGT.Get;
//                             if WORKMGT."N° doc. égal n° O.T." then
//                                 journal."Document No." := bt.cd_OT;
//                             journal.Validate(journal."Resource No.", interv.cd_resource);
//                             journal.Validate(journal.Quantity, interv.Qauntité_réalisée);
//                             /* GL2024  if Run then
//                                 journal.MES := true
//                             else
//                                 journal.MES := false;*/
//                             //  GL2024  journal.Chargeable := false;
//                             journal.Modify;
//                             INT += 1;
//                         end;

//                     until interv.Next = 0;
//                     JnRes.SetRecord(journal);
//                     JnRes.Run;
//                 end
//                 else
//                     Message(txt5);
//             end
//             else
//                 Message(txt4);
//         end else
//             if not Run then
//                 Message(txt1);
//     end;


//     procedure ValidateResConsumption(bt: Record BT; Run: Boolean)
//     var
//         interv: Record "Intervenant/bt";
//         journal: Record "Res. Journal Line";
//         INT: Integer;
//     begin
//         interv.Reset;
//         interv.SetFilter(interv.cd_ot, bt.cd_OT);
//         interv.SetRange(interv.cd_bt, bt."code BT");
//         if interv.Find('-') then begin
//             WORKMGT.Get;
//             if WORKMGT."Modèle de feuille ressource" <> '' then begin
//                 if WORKMGT."Feuille Déf RES" <> '' then begin
//                     INT := 1;
//                     repeat
//                         if not interv.Validé then begin
//                             journal."Journal Template Name" := WORKMGT."Modèle de feuille ressource";
//                             journal."Journal Batch Name" := WORKMGT."Feuille Déf RES";
//                             journal."Line No." := INT;
//                             journal.Insert(true);
//                             journal."Posting Date" := WorkDate;
//                             journal."Entry Type" := journal."entry type"::Usage;
//                             /* //  GL2024   journal."Work Order" := bt.cd_OT;
//                                journal."Work Sheet" := bt."code BT";*/
//                             WORKMGT.Get;
//                             if WORKMGT."N° doc. égal n° O.T." then
//                                 journal."Document No." := bt.cd_OT;
//                             journal.Validate(journal."Resource No.", interv.cd_resource);
//                             journal.Validate(journal.Quantity, interv.Qauntité_réalisée);
//                             /* //  GL2024   if Run then
//                                   journal.MES := true
//                               else
//                                   journal.MES := false;*/
//                             //  GL2024   journal.Chargeable := false;
//                             journal.Modify;
//                             INT += 1;
//                         end;
//                     until interv.Next = 0;

//                     //IF journal.FIND('-') THEN
//                     INTtmp.Reset;
//                     INTtmp.SetFilter(INTtmp.cd_ot, bt.cd_OT);
//                     INTtmp.SetRange(INTtmp.cd_bt, bt."code BT");
//                     INTtmp.SetRange(INTtmp.Validé, false);
//                     if INTtmp.Find('-') then
//                         Codeunit.Run(Codeunit::"Res. Jnl.-Post", journal);
//                 end
//                 else
//                     Message(txt5);
//             end
//             else
//                 Message(txt4);
//         end else
//             if not Run then
//                 Message(txt1);
//     end;


//     procedure ValidateResConsumptionAndPrint(bt: Record BT; Run: Boolean)
//     var
//         interv: Record "Intervenant/bt";
//         journal: Record "Res. Journal Line";
//         INT: Integer;
//     begin
//         interv.Reset;
//         interv.SetFilter(interv.cd_ot, bt.cd_OT);
//         interv.SetRange(interv.cd_bt, bt."code BT");
//         if interv.Find('-') then begin
//             WORKMGT.Get;
//             if WORKMGT."Modèle de feuille ressource" <> '' then begin
//                 if WORKMGT."Feuille Déf RES" <> '' then begin
//                     INT := 1;
//                     repeat
//                         if not interv.Validé then begin
//                             journal."Journal Template Name" := WORKMGT."Modèle de feuille ressource";
//                             journal."Journal Batch Name" := WORKMGT."Feuille Déf RES";
//                             journal."Line No." := INT;
//                             journal.Insert(true);
//                             journal."Posting Date" := WorkDate;
//                             journal."Entry Type" := journal."entry type"::Usage;
//                             WORKMGT.Get;
//                             /* GL2024 journal."Work Order" := bt.cd_OT;
//                             journal."Work Sheet" := bt."code BT";*/
//                             if WORKMGT."N° doc. égal n° O.T." then
//                                 journal."Document No." := bt.cd_OT;
//                             journal.Validate(journal."Resource No.", interv.cd_resource);
//                             journal.Validate(journal.Quantity, interv.Qauntité_réalisée);
//                             /*  GL2024 if Run then
//                                  journal.MES := true
//                              else
//                                  journal.MES := false;*/
//                             //GL2024   journal.Chargeable := false;
//                             journal.Modify;
//                             INT += 1;
//                         end;

//                     until interv.Next = 0;

//                     //IF journal.FIND('-') THEN
//                     INTtmp.Reset;
//                     INTtmp.SetFilter(INTtmp.cd_ot, bt.cd_OT);
//                     INTtmp.SetRange(INTtmp.cd_bt, bt."code BT");
//                     INTtmp.SetRange(INTtmp.Validé, false);
//                     if INTtmp.Find('-') then
//                         Codeunit.Run(Codeunit::"Res. Jnl.-Post", journal);

//                 end
//                 else
//                     Message(txt5);
//             end
//             else
//                 Message(txt4);
//         end else
//             if not Run then
//                 Message(txt1);
//     end;
// }

