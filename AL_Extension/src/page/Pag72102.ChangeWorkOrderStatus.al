//GL3900 
// page 72102 "Change Work Order Status"
// {//GL2024  ID dans Nav 2009 : "39002102"
//     Caption = 'Change Work Order Status';
//     PageType = List;
//     SourceTable = OT;
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field(ProdOrderStatus; ProdOrderStatus)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Status Filter';
//                     OptionCaption = 'Simulated,Planned,Firm Planned,Released';

//                     trigger OnValidate()
//                     begin
//                         ProdOrderStatusOnAfterValidate;
//                     end;
//                 }
//                 field(StartingDate; StartingDate)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Must Start Before';

//                     trigger OnValidate()
//                     begin
//                         StartingDateOnAfterValidate;
//                     end;
//                 }
//                 field(EndingDate; EndingDate)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Ends Before';

//                     trigger OnValidate()
//                     begin
//                         EndingDateOnAfterValidate;
//                     end;
//                 }
//             }
//             repeater(CONTENT1)
//             {
//                 Editable = false;
//                 ShowCaption = false;
//                 field("code OT"; rec."code OT")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Titre; rec.Titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_debut; rec.dt_debut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_fin_ot; rec.dt_fin_ot)
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
//             group("Work Or&der")
//             {
//                 Caption = 'Work Or&der';

//                 action("Co&mment")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Co&mment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(ot), "No." = FIELD("code OT");
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

//                     trigger OnAction()
//                     var
//                         ItemLedgEntry: Record "Item Ledger Entry";
//                     begin
//                         IF rec.status <> rec.status::Lancé THEN
//                             EXIT;

//                         //ItemLedgEntry.RESET;
//                         //ItemLedgEntry.SETCURRENTKEY("Prod. Order No.");
//                         //ItemLedgEntry.SETRANGE("Prod. Order No.","No.");
//                         //page.RUNMODAL(0,ItemLedgEntry);
//                     end;
//                 }
//                 action(Site)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Site';
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD(cd_site);

//                     trigger OnAction()
//                     var
//                         CapLedgEntry: Record "Capacity Ledger Entry";
//                     begin
//                         IF rec.status <> rec.status::Lancé THEN
//                             EXIT;

//                         //CapLedgEntry.RESET;
//                         //CapLedgEntry.SETCURRENTKEY("Prod. Order No.");
//                         //CapLedgEntry.SETRANGE("Prod. Order No.","No.");
//                         //page.RUNMODAL(0,CapLedgEntry);
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 action("Change &Status")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Change &Status';
//                     Ellipsis = true;
//                     Image = ChangeStatus;

//                     trigger OnAction()
//                     var
//                         ChangeStatusForm: Page "Change Status on Work. Order";
//                         WorkOrderStatusMgt: Codeunit "Work  Order Status Management";
//                         Window: Dialog;
//                         NewStatus: Option "Simulé","Planifié","Planifié ferme","Lancé","Terminé";
//                         NewPostingDate: Date;
//                         NewUpdateUnitCost: Boolean;
//                         NoOfRecords: Integer;
//                         POCount: Integer;
//                         LocalText000: Label 'Simulated,Planned,Firm Planned,Released,Finished';
//                     begin
//                         ChangeStatusForm.Set(Rec);

//                         IF ChangeStatusForm.RUNMODAL() <> ACTION::Yes THEN
//                             EXIT;

//                         ChangeStatusForm.ReturnPostingInfo(NewStatus, NewPostingDate, NewUpdateUnitCost);
//                         ChangeStatusForm.ReturnValidationInfo(valItem, VALRESS, PItem, PRES);

//                         NoOfRecords := rec.COUNT;

//                         Window.OPEN(
//                           STRSUBSTNO(Text000, SELECTSTR(NewStatus + 1, LocalText000)) +
//                           Text001);

//                         POCount := 0;
//                         //WorkOrder.SETRANGE("code OT","code OT");
//                         IF Rec.FIND('-') THEN
//                             REPEAT
//                                 POCount := POCount + 1;
//                                 Window.UPDATE(1, rec."code OT");
//                                 Window.UPDATE(2, ROUND(POCount / NoOfRecords * 10000, 1));
//                                 WorkOrderStatusMgt.ChangeStatusOnProdOrder(
//                                  Rec, NewStatus, NewPostingDate, NewUpdateUnitCost, valItem, VALRESS, PItem, PRES);
//                                 COMMIT;
//                             //BuildForm;
//                             UNTIL Rec.NEXT = 0;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         BuildForm;
//     end;

//     var
//         Text000: Label 'Changing status to %1...\\';
//         Text001: Label 'Prod. Order #1###### @2@@@@@@@@@@@@@';
//         ProdOrderStatus: Option "Simulé","Planifié","Planifié ferme","Lancé";
//         StartingDate: Date;
//         EndingDate: Date;
//         WorkOrder: Record OT;
//         valItem: Boolean;
//         VALRESS: Boolean;
//         PRES: Boolean;
//         PItem: Boolean;

//     
//     procedure BuildForm()
//     begin
//         rec.SETRANGE(status, ProdOrderStatus);
//         IF ProdOrderStatus = ProdOrderStatus::Lancé THEN
//             rec.SETRANGE(Garde, FALSE);

//         IF StartingDate <> 0D THEN
//             rec.SETFILTER(dt_debut, '..%1', StartingDate)
//         ELSE
//             rec.SETRANGE(dt_debut);

//         IF EndingDate <> 0D THEN
//             rec.SETFILTER(dt_fin_ot, '..%1', EndingDate)
//         ELSE
//             rec.SETRANGE(dt_fin_ot);

//         CurrPage.UPDATE(FALSE);
//     end;

//     local procedure ProdOrderStatusOnAfterValidate()
//     begin
//         BuildForm;
//     end;

//     local procedure StartingDateOnAfterValidate()
//     begin
//         BuildForm;
//     end;

//     local procedure EndingDateOnAfterValidate()
//     begin
//         BuildForm;
//     end;
// }

