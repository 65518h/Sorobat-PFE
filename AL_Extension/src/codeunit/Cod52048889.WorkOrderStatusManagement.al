//GL3900
// Codeunit 52048889 "Work  Order Status Management"
// {

//     //GL2024  ID dans Nav 2009 : "39002016"


//     Permissions = TableData "Source Code Setup" = r;
//     /*GL2024 TableData 90041 = rimd,
//  TableData 90048 = rimd;*/
//     TableNo = OT;

//     trigger OnRun()
//     var
//         ChangeStatusForm: Page "Change Status on Work. Order";
//     begin

//         ChangeStatusForm.Set(Rec);
//         if ChangeStatusform.RunModal() = Action::Yes then begin
//             ChangeStatusForm.ReturnPostingInfo(NewStatus, NewPostingDate, NewUpdateUnitCost);
//             ChangeStatusForm.ReturnValidationInfo(valItem, valress, PItem, PRes);
//             ChangeStatusOnProdOrder(Rec, NewStatus, NewPostingDate, NewUpdateUnitCost, valItem, valress, PItem, PRes);
//             Commit;
//             Message(Text000, rec.status, rec.TableCaption, rec."code OT", ToWorkOrder.status, ToWorkOrder.TableCaption, ToWorkOrder."code OT")
//         end;
//     end;

//     var
//         Text000: label '%1 %2 %3 has been changed to %4 %5 %6.';
//         Text002: label 'Posting Automatic consumption...\\';
//         Text003: label 'Posting lines         #1###### @2@@@@@@@@@@@@@';
//         Text004: label '%1 %2 has not been finished. Some output is still missing. Do you still want to finish the order?';
//         Text005: label 'The update has been interrupted to respect the warning.';
//         Text006: label '%1 %2 has not been finished. Some consumption is still missing. Do you still want to finish the order?';
//         Text007: label 'The status of order %1 cannot be changed as it is related to planning line %2 in worksheet %3 %4.';
//         ToWorkOrder: Record OT;
//         SourceCodeSetup: Record "Source Code Setup";
//         NewStatus: Option Quote,"Planifié","Planifié feme","Lancé","Terminé";
//         NewPostingDate: Date;
//         NewUpdateUnitCost: Boolean;
//         SourceCodeSetupRead: Boolean;
//         Text008: label '%1 %2 cannot be finished as the associated subcontract order %3 has not been fully delivered.';
//         Text009: label 'You cannot finish line %1 on %2 %3. It has consumption or capacity posted with no output.';
//         Text010: label 'You must specify a %1 in %2 %3 %4.';
//         XCode: Code[10];
//         NCode: Code[10];
//         Updatecost: Codeunit "Consumption treatment";
//         valItem: Boolean;
//         valress: Boolean;
//         PItem: Boolean;
//         PRes: Boolean;
//         workmgt: Record "Work Setup";
//         I: Integer;
//         g: Integer;


//     procedure ChangeStatusOnProdOrder(WorkOrder: Record OT; NewStatus: Option Quote,"Planifié","Planifié ferme","Lancé","Terminé"; NewPostingDate: Date; NewUpdateUnitCost: Boolean; vit: Boolean; vr: Boolean; prit: Boolean; prres: Boolean)
//     var
//         avis: Record "Failure Notice";
//     begin
//         XCode := WorkOrder."code OT";


//         SetPostingInfo(NewStatus, NewPostingDate, NewUpdateUnitCost, vit, vr, prit, prres);

//         MajCost(WorkOrder);
//         //ErrorIfInPlanningWksh(ProdOrder);
//         if NewStatus = Newstatus::Terminé then begin
//             CheckBeforeFinishProdOrder(WorkOrder);
//             ValidateConsumption(WorkOrder);
//             TransWorkOrder(WorkOrder);
//             TransfBT(XCode, NCode);
//             TransfDI(XCode, NCode);
//             if WorkOrder.Garde then begin
//                 avis.Reset;
//                 if avis.Get(WorkOrder."Avis de panne") then begin
//                     avis.OT := WorkOrder."code OT";
//                     avis.Validé := true;
//                     avis.Modify;
//                 end;
//             end;

//         end else begin
//             TransWorkOrder(WorkOrder);
//             WorkOrder.Get(NCode);
//             ValidateConsumption(WorkOrder);
//             TransfDI(XCode, NCode);
//             TransfBT(XCode, NCode);
//             TransfOtRisque(XCode, NCode);
//             TransfOtPrev(XCode, NCode);
//             TransfBtRisque(XCode, NCode);
//             TransfBtPrev(XCode, NCode);
//             TransfBtCost(XCode, NCode);
//             TransfBtArticle(XCode, NCode);
//             TransfBtRES(XCode, NCode);
//             TransfBtOutil(XCode, NCode);


//         end;
//         Commit;
//     end;

//     local procedure TransWorkOrder(var FromWorkOrder: Record OT)
//     var
//         ToWorkSheet: Record BT;
//     begin
//         with FromWorkOrder do begin


//             ToWorkOrder := FromWorkOrder;
//             ToWorkOrder.status := NewStatus;

//             case status of
//                 Status::Simulé:
//                     ToWorkOrder."Simulated Order No." := "code OT";
//                 Status::Planifié:
//                     ToWorkOrder."Planned order No." := "code OT";
//                 Status::"Planifié ferme":
//                     ToWorkOrder."Firm Planned order No." := "code OT";
//                 Status::Lancé:
//                     ToWorkOrder."Finished Date" := NewPostingDate;
//             end;

//             ToWorkOrder.TestNoSeries;
//             if (ToWorkOrder.GetNoSeriesCode <> souche) and
//                (ToWorkOrder.status <> ToWorkOrder.Status::Terminé)
//             then begin
//                 ToWorkOrder."code OT" := '';
//                 workmgt.Get;
//                 I := 0;
//                 g := 0;
//                 if (workmgt."Nbre de BT par Déf" > 0) or (workmgt."Nbre de BT de garde par Déf" > 0) then begin
//                     I := workmgt."Nbre de BT par Déf";
//                     g := workmgt."Nbre de BT de garde par Déf";
//                     workmgt."Nbre de BT de garde par Déf" := 0;
//                     workmgt."Nbre de BT par Déf" := 0;
//                     workmgt.Modify;
//                 end;
//                 ToWorkOrder.Insert(true);
//                 if (I > 0) or (g > 0) then begin
//                     workmgt."Nbre de BT par Déf" := I;
//                     workmgt."Nbre de BT de garde par Déf" := g;
//                     workmgt.Modify;
//                 end;
//                 ToWorkOrder.dt_debut := FromWorkOrder.dt_debut;
//                 ToWorkOrder.Modify;
//                 Delete;
//                 FromWorkOrder := ToWorkOrder;
//                 NCode := ToWorkOrder."code OT";
//             end else begin
//                 ToWorkOrder.status := NewStatus;
//                 ToWorkOrder.Modify;
//             end;
//         end;
//     end;


//     procedure CheckBeforeFinishProdOrder(WorkOrder: Record OT)
//     var
//         ProdOrderLine: Record "Prod. Order Line";
//         ProdOrderComp: Record "Prod. Order Component";
//         ProdOrderRtngLine: Record "Prod. Order Routing Line";
//         PurchLine: Record "Purchase Line";
//     begin
//     end;

//     local procedure GetSourceCodeSetup()
//     begin
//         if not SourceCodeSetupRead then
//             SourceCodeSetup.Get;
//         SourceCodeSetupRead := true;
//     end;


//     procedure ErrorIfInPlanningWksh(var ProdOrder: Record "Production Order")
//     var
//         ReqLine: Record "Requisition Line";
//     begin
//         ReqLine.SetCurrentkey("Ref. Order Type", "Ref. Order Status", "Ref. Order No.", "Ref. Line No.");
//         ReqLine.SetRange("Ref. Order Type", ReqLine."ref. order type"::"Prod. Order");
//         ReqLine.SetRange("Ref. Order Status", ProdOrder.Status);
//         ReqLine.SetRange("Ref. Order No.", ProdOrder."No.");
//         if ReqLine.Find('-') then
//             Error(Text007,
//                    ProdOrder."No.", ReqLine."Line No.", ReqLine."Worksheet Template Name", ReqLine."Journal Batch Name");
//     end;


//     procedure SetPostingInfo(Status: Option Quote,Planned,"Firm Planned",Released,Finished; PostingDate: Date; UpdateUnitCost: Boolean; Vitem: Boolean; Vress: Boolean; Iprint: Boolean; RPrint: Boolean)
//     begin
//         NewStatus := Status;
//         NewPostingDate := PostingDate;
//         NewUpdateUnitCost := UpdateUnitCost;
//         valItem := Vitem;
//         valress := Vress;
//         Iprint := PItem;
//         RPrint := PRes;
//     end;


//     procedure TransfDI(Xot: Code[10]; NewOt: Code[10])
//     var
//         "Ot-DI": Record "OT-DI";
//         di: Record DI;
//     begin

//         "Ot-DI".Reset;
//         if NewStatus = Newstatus::Terminé then begin
//             "Ot-DI".SetFilter("Ot-DI".cd_OT, Xot);
//             if "Ot-DI".Find('-') then
//                 repeat
//                     di.Reset;
//                     if di.Get("Ot-DI".cd_DI) then begin
//                         di.cd_OT := NewOt;
//                         di.Modify;
//                     end;
//                 until "Ot-DI".Next = 0;
//         end else begin
//             "Ot-DI".SetFilter("Ot-DI".cd_OT, Xot);
//             if "Ot-DI".Find('-') then
//                 repeat
//                     "Ot-DI".Rename(NewOt, "Ot-DI".cd_DI);
//                     di.Reset;
//                     if di.Get("Ot-DI".cd_DI) then begin
//                         di.cd_OT := NewOt;
//                         di.Modify;
//                     end;
//                 until "Ot-DI".Next = 0;
//         end;
//     end;


//     procedure TransfBT(Xot: Code[10]; NewOt: Code[10])
//     var
//         Bt: Record BT;
//     begin
//         Bt.Reset;
//         if NewStatus = Newstatus::Terminé then begin
//             Bt.SetFilter(Bt.cd_OT, Xot);
//             if Bt.Find('-') then
//                 repeat
//                     Bt.status := NewStatus;
//                     Bt.Modify(true);
//                 until Bt.Next = 0;
//         end else begin
//             Bt.SetFilter(Bt.cd_OT, Xot);
//             if Bt.Find('-') then
//                 repeat
//                     Bt.Rename(NewOt, Bt."code BT");
//                     Bt.status := NewStatus;
//                     Bt.Modify(true);

//                 until Bt.Next = 0;
//         end;
//     end;


//     procedure TransfOtRisque(Xot: Code[10]; NewOt: Code[10])
//     var
//         OTRisque: Record "Risque OT";
//     begin
//         OTRisque.Reset;
//         OTRisque.SetFilter(OTRisque.cd_OT, Xot);
//         if OTRisque.Find('-') then
//             repeat

//                 OTRisque.Rename(NewOt, OTRisque.cd_risque);
//             until OTRisque.Next = 0;
//     end;


//     procedure TransfOtPrev(Xot: Code[10]; NewOt: Code[10])
//     var
//         OTPrev: Record "Prevention OT";
//     begin
//         OTPrev.Reset;
//         OTPrev.SetFilter(OTPrev.cd_OT, Xot);
//         if OTPrev.Find('-') then
//             repeat

//                 OTPrev.Rename(NewOt, OTPrev.cd_prevention);
//             until OTPrev.Next = 0;
//     end;


//     procedure TransfBtRisque(Xot: Code[10]; NewOt: Code[10])
//     var
//         BTRisque: Record "Risque BT";
//     begin
//         BTRisque.Reset;
//         BTRisque.SetFilter(BTRisque.cd_OT, Xot);
//         if BTRisque.Find('-') then
//             repeat
//                 BTRisque.Rename(NewOt, BTRisque.cd_BT, BTRisque.cd_risque);
//             until BTRisque.Next = 0;
//     end;


//     procedure TransfBtPrev(Xot: Code[10]; NewOt: Code[10])
//     var
//         BTPrev: Record "Prevention BT";
//     begin
//         BTPrev.Reset;
//         BTPrev.SetFilter(BTPrev.cd_OT, Xot);
//         if BTPrev.Find('-') then
//             repeat
//                 BTPrev.Rename(NewOt, BTPrev.cd_BT, BTPrev.cd_prevention);
//             until BTPrev.Next = 0;
//     end;


//     procedure TransfBtCost(Xot: Code[10]; NewOt: Code[10])
//     var
//         BTcost: Record "Coûts divers BT";
//     begin
//         BTcost.Reset;
//         BTcost.SetFilter(BTcost."code ot", Xot);
//         if BTcost.Find('-') then
//             repeat
//                 BTcost.Rename(NewOt, BTcost."code bt", BTcost."No.");
//             until BTcost.Next = 0;
//     end;


//     procedure TransfBtArticle(Xot: Code[10]; NewOt: Code[10])
//     var
//         BTArticle: Record "ARTICLE/BT";
//     begin
//         BTArticle.Reset;
//         BTArticle.SetFilter(BTArticle."code ot", Xot);
//         if BTArticle.Find('-') then
//             repeat
//                 BTArticle.Rename(NewOt, BTArticle."code bt", BTArticle.article);
//             until BTArticle.Next = 0;
//     end;


//     procedure TransfBtRES(Xot: Code[10]; NewOt: Code[10])
//     var
//         BTRes: Record "Intervenant/bt";
//     begin
//         BTRes.Reset;
//         BTRes.SetFilter(BTRes.cd_ot, Xot);
//         if BTRes.Find('-') then
//             repeat
//                 BTRes.Rename(NewOt, BTRes.cd_bt, BTRes.cd_resource);
//             until BTRes.Next = 0;
//     end;


//     procedure TransfBtOutil(Xot: Code[10]; NewOt: Code[10])
//     var
//         BTTouls: Record Tools;
//     begin
//         BTTouls.Reset;
//         BTTouls.SetFilter(BTTouls.cd_ot, Xot);
//         if BTTouls.Find('-') then
//             repeat

//                 BTTouls.Rename(NewOt, BTTouls.cd_bt, BTTouls."Line No.");
//             until BTTouls.Next = 0;
//     end;


//     procedure MajCost(var tmpot: Record OT)
//     begin
//         if NewUpdateUnitCost then
//             tmpot."OT costs"();
//     end;


//     procedure ValidateConsumption(WorkOrder: Record OT)
//     var
//         bt: Record BT;
//         Treatment: Codeunit "Consumption treatment";
//     begin
//         bt.Reset;
//         bt.SetFilter(bt.cd_OT, WorkOrder."code OT");
//         if bt.Find('-') then
//             repeat
//                 //validation des consommations articles
//                 if valItem then begin
//                     //Test sur l'option impression
//                     if PItem then
//                         Treatment.ValidateConsumptionAndPrint(bt, true)
//                     else
//                         Treatment.ValidateConsumption(bt, true);
//                 end;
//                 //validation des consommations ressources
//                 if valress then begin
//                     //test sur l'option impression
//                     if PRes then
//                         Treatment.ValidateResConsumptionAndPrint(bt, true)
//                     else
//                         Treatment.ValidateResConsumption(bt, true);
//                 end;
//             until bt.Next = 0;
//     end;
// }

