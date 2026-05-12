// page 50210 "DA Chantier Materiaux"
// {
//     // //CDE_INTERNE GESWAY 04/09/02 Gestion des commandes internes
//     // //MASK IMA 02/01/06 Le groupe de confidentialité

//     Caption = 'Demande Achat Materiaux Chantier';
//     DeleteAllowed = false;
//     PageType = Card;
//     RefreshOnActivate = true;
//     SourceTable = "Sales Header";
//     SourceTableView = SORTING("Order Type", "Document Type", "No.") WHERE("Document Type" = FILTER(Order), "Order Type" = CONST("Supply Order"), Statut = FILTER(<> Archiver), Chantier = FILTER(true), "Type Demande" = CONST(Materiaux));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = all;

//                     Editable = false;

//                 }
//                 field("Job No."; rec."Job No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Job No.Editable";
//                 }
//                 field("Requester ID"; rec."Requester ID")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Demandeur';
//                 }
//                 field("Type Demande"; rec."Type Demande")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }

//                 // field(Statut; rec.Statut)
//                 // {
//                 //     ApplicationArea = all;
//                 //     Caption = 'Etat DA';
//                 //     Editable = false;
//                 //     OptionCaption = 'Pending,accepted,refused';
//                 //     Style = Unfavorable;
//                 //     StyleExpr = TRUE;
//                 // }
//                 field(Approber2; rec.Approber)
//                 {
//                     ApplicationArea = all;
//                 }
//                 // field("Mode Notification"; rec."Mode Notification")
//                 // {
//                 //     ApplicationArea = all;
//                 // }
//                 field(Urgence; rec."Shipping Advice")
//                 {
//                     ApplicationArea = all;
//                     Editable = UrgenceEditable;
//                 }
//                 field(Approbateur; rec.Approbateur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date approbation"; rec."Date approbation")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document Date"; rec."Document Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = "Document DateEditable";
//                 }
//                 field("Requested Delivery Date"; rec."Requested Delivery Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("User ID"; rec."User ID")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Créer Par';
//                     Editable = false;
//                 }
//                 // field(Observation; rec.Observation)
//                 // {
//                 //     ApplicationArea = all;
//                 // }
//                 field("Shipping Agent Code"; rec."Shipping Agent Code")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Demarcheur';
//                 }
//                 field("Commande Achat Associé"; rec."Commande Achat Associé")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 // field(Chantier; rec.Chantier)
//                 // {
//                 //     ApplicationArea = all;
//                 //     Editable = false;
//                 // }
//                 field(Receptionné; rec.Receptionné)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 // field("Motif Refus"; rec."Motif Refus")
//                 // {
//                 //     ApplicationArea = all;

//                 //     trigger OnValidate()
//                 //     begin
//                 //         MotifRefusOnValidate;
//                 //         MotifRefusOnAfterValidate;
//                 //     end;
//                 // }
//             }
//             part("Liste Notifications"; "Liste Notifications")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "Document N°" = FIELD("No.");
//             }
//             part(SalesLines; "Reord. Requi. Subform Materiau")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "Document No." = FIELD("No.");
//             }
//             group("Follow up")
//             {
//                 Caption = 'Suivi';
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Urgence1; rec."Shipping Advice")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Your Reference"; rec."Your Reference")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group("Materiaux Marché")
//             {
//                 Caption = 'Materiaux Marché';
//                 part("Regroupement Rapport DG"; "Regroupement Rapport DG")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     SubPageLink = Chantier = FIELD("Job No.");
//                     SubPageView = WHERE(Type = CONST(Materiaux));
//                 }
//             }
//             group("Nouveau Materiaux")
//             {
//                 Caption = 'Nouveau Materiaux';
//                 field("Sell-to Address 2"; rec."Sell-to Address 2")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Designation ';
//                 }
//                 group("Inserer Article ")
//                 {
//                     Caption = 'Inserer Article ';
//                     field(QUantitéeEstimée; QUantitéeEstimée)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Quantité Estimé';
//                     }
//                 }
//                 field(CdeArticle; CdeArticle)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code';
//                     TableRelation = Item;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group(BORDER1)
//             {
//                 Caption = '&Demande appro.';
//                 actionref(Card1; Card) { }
//                 actionref("Co&mments1"; "Co&mments") { }
//                 actionref("S&hipments1"; "S&hipments") { }
//                 actionref(Reports1; Reports) { }
//                 actionref(Planning1; Planning) { }
//             }

//             actionref(BPRINT1; BPRINT) { }

//             group("Fonction&s1")
//             {
//                 Caption = 'F&unctions';

//                 actionref("Copy Document1"; "Copy Document") { }
//                 actionref("Archi&ve Document1"; "Archi&ve Document") { }
//                 actionref("Move Negative Lines1"; "Move Negative Lines") { }
//                 actionref("Generate Purchase Doc.1"; "Generate Purchase Doc.") { }
//                 actionref("Devis Associé1"; "Devis Associé") { }
//                 actionref("Order &Promising1"; "Order &Promising") { }

//                 group(Warehouse1)
//                 {
//                     Caption = 'Warehouse';
//                     actionref("Activity List1"; "Activity List") { }
//                     actionref("Create Assignment1"; "Create Assignment") { }

//                 }
//                 actionref("Re&lease1"; "Re&lease") { }
//                 actionref("Re&open1"; "Re&open") { }
//                 actionref(Notifier1; Notifier) { }
//                 actionref(Archiver1; Archiver) { }

//                 actionref(Approber1; Approber) { }

//                 actionref("Test Report1"; "Test Report") { }
//                 actionref("P&ost Shipment1"; "P&ost Shipment") { }
//                 actionref("Post Shipment and &Print1"; "Post Shipment and &Print") { }
//                 actionref("Post &Batch1"; "Post &Batch") { }
//             }
//             actionref(Print11; Print1) { }
//             actionref("Notifier @1"; "Notifier @") { }
//             actionref("...1"; "...") { }
//         }
//         area(navigation)
//         {
//             group(BORDER)
//             {
//                 Caption = '&Demande appro.';
//                 /* GL2024   action(Statistics)
//                {
//                    ApplicationArea = all;
//                    Caption = 'Statistics';
//                    Image = Statistics;
//                    Promoted = true;
//                    PromotedCategory = Process;
//                    ShortCutKey = 'F7';

//                    trigger OnAction()
//                    begin
//                     SalesSetup.GET;
//                          IF SalesSetup."Calc. Inv. Discount" THEN BEGIN
//                              CurrPage.SalesLines.FORM.CalcInvDisc;
//                              COMMIT
//                          END;
//                        PAGE.RUNMODAL(PAGE::"Reordering Req. Statistics", Rec);
//                    end;
//                }*/
//                 action(Card)
//                 {
//                     ApplicationArea = all;


//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Customer List";
//                     RunPageLink = "No." = FIELD("Sell-to Customer No.");
//                     ShortCutKey = 'Maj+F5';
//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = all;


//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Sales Comment Sheet";
//                     RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
//                 }
//                 action("S&hipments")
//                 {
//                     ApplicationArea = all;


//                     Caption = 'S&hipments';
//                     RunObject = Page "Posted Sales Shipments";
//                     RunPageLink = "Order No." = FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//                 /* GL2024   action(Dimensions)
//                    {ApplicationArea = all;
//                        Caption = 'Dimensions';
//                        Image = Dimensions;
//                        RunObject = Page 546;
//                                        RunPageLink = Table ID=CONST(36), Document Type=FIELD(Document Type), Document No.=FIELD(No.), Line No.=CONST(0);
//                    }*/
//                 separator(separator1)
//                 {
//                 }
//                 action(Reports)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Reports';

//                     trigger OnAction()
//                     var
//                         lReportList: Record ReportList;
//                         lId: Integer;
//                         lRecRef: RecordRef;
//                     begin
//                         WITH lReportList DO BEGIN
//                             EVALUATE(lId, COPYSTR(CurrPage.OBJECTID(FALSE), 6));
//                             lRecRef.GETTABLE(Rec);
//                             lRecRef.SETRECFILTER;
//                             SetRecordRef(lRecRef, TRUE);
//                             ShowList(lId);
//                         END;
//                     end;
//                 }
//                 action(Planning)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Planning';

//                     trigger OnAction()
//                     var
//                         SalesPlanForm: Page "Sales Order Planning";
//                     begin
//                         SalesPlanForm.SetSalesOrder(REC."No.");
//                         SalesPlanForm.RUNMODAL;
//                     end;
//                 }
//             }
//             /* GL2024 NAVIBAT  group(BLINE)
//                {
//                    Caption = '&Line';
//                    group("Item Availability by")
//                    {
//                        Caption = 'Item Availability by';
//                        action(Period)
//                        {ApplicationArea = all;
//                            Caption = 'Period';

//                            trigger OnAction()
//                            begin
//                                CurrPage.SalesLines.FORM.ItemAvailability(0);
//                            end;
//                        }
//                        action(Variant)
//                        {
//                            Caption = 'Variant';

//                            trigger OnAction()
//                            begin
//                                CurrPage.SalesLines.FORM.ItemAvailability(1);
//                            end;
//                        }
//                        action(Location)
//                        {
//                            Caption = 'Location';

//                            trigger OnAction()
//                            begin
//                                CurrPage.SalesLines.FORM.ItemAvailability(2);
//                            end;
//                        }
//                    }
//                    action("Reservation Entries")
//                    {
//                        Caption = 'Reservation Entries';
//                        Image = ReservationLedger;

//                        trigger OnAction()
//                        begin
//                            CurrPage.SalesLines.FORM.ShowReservationEntries;
//                        end;
//                    }
//                    action("Select Item Substitution")
//                    {
//                        Caption = 'Select Item Substitution';
//                        Image = SelectItemSubstitution;

//                        trigger OnAction()
//                        begin
//                            CurrPage.SalesLines.FORM.ShowItemSub;
//                        end;
//                    }
//                    action(Dimensions)
//                    {
//                        Caption = 'Dimensions';
//                        Image = Dimensions;
//                        ShortCutKey = 'Maj+Ctrl+D';

//                        trigger OnAction()
//                        begin
//                            CurrPage.SalesLines.FORM.ShowDimensions;
//                        end;
//                    }
//                    action("Item Charge &Assignment")
//                    {
//                        Caption = 'Item Charge &Assignment';

//                        trigger OnAction()
//                        begin
//                            CurrPage.SalesLines.FORM.ItemChargeAssgnt;
//                        end;
//                    }
//                    action("Item &Tracking Lines")
//                    {
//                        Caption = 'Item &Tracking Lines';
//                        Image = ItemTrackingLines;

//                        trigger OnAction()
//                        begin
//                            CurrPage.SalesLines.FORM.OpenItemTrackingLines;
//                        end;
//                    }
//                    separator()
//                    {
//                    }
//                    action("Explode Line")
//                    {
//                        Caption = 'Explode Line';

//                        trigger OnAction()
//                        begin
//                            CurrPage.SalesLines.FORM.wExplodeLine;
//                        end;
//                    }
//                }*/
//         }
//         area(processing)
//         {
//             /* GL2024 NAVIBAT action(BWKF)
//              {
//                  Caption = '&Workflow';
//                  Promoted = true;
//                  PromotedCategory = Process;
//                  RunObject = Page 8004213;
//                  RunPageLink = Type = CONST(8003966), No.=FIELD(No.);
//                  ToolTip = 'Workflow';
//              }*/
//             action(BPRINT)
//             {
//                 ApplicationArea = all;
//                 Caption = '&Imprimer Format A4';
//                 Ellipsis = true;
//                 Image = Print;

//                 trigger OnAction()
//                 begin
//                     // >> HJ DSFT 11-10-2012
//                     IF NOT REC.Approber THEN ERROR(Text021);
//                     //  IF REC.Statut = REC.Statut::Ouvert THEN ERROR(Text004);
//                     RecSalesOrder.SETRANGE("Document Type", REC."Document Type");
//                     RecSalesOrder.SETRANGE("No.", REC."No.");
//                     REPORT.RUNMODAL(REPORT::"Demande d'Appro Format A4", TRUE, TRUE, RecSalesOrder);
//                     // >> HJ DSFT 11-10-2012

//                     // STD HJ DSFT 11-10-2012 DocPrint.PrintSalesHeader(Rec);
//                 end;
//             }
//             group(BVALIDATION)
//             {
//                 Caption = 'P&osting';
//                 Visible = false;
//                 action("Test Report")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintSalesHeader(Rec);
//                     end;
//                 }
//                 action("P&ost Shipment")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'P&ost Shipment';
//                     Ellipsis = true;
//                     Image = Post;

//                     RunObject = Codeunit "Sales-Post (Yes/No)";
//                     ShortCutKey = 'F9';
//                     Visible = false;
//                 }
//                 action("Post Shipment and &Print")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Post Shipment and &Print';
//                     Ellipsis = true;
//                     RunObject = Codeunit "Sales-Post + Print";
//                     ShortCutKey = 'Maj+F11';
//                     Visible = false;
//                 }
//                 action("Post &Batch")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//             }
//             group(BFUNCTION)
//             {
//                 Caption = 'F&unctions';
//                 /* GL2024 NAVIBAT  action("Calculate &Invoice Discount")
//                    {ApplicationArea = all;
//                        Caption = 'Calculate &Invoice Discount';
//                        Image = CalculateInvoiceDiscount;
//                        Visible = false;

//                        trigger OnAction()
//                        begin
//                            CurrPage.SalesLines.FORM.ApproveCalcInvDisc;
//                        end;
//                    }*/
//                 action("Copy Document")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CopySalesDoc.SetSalesHeader(Rec);
//                         CopySalesDoc.RUNMODAL;
//                         CLEAR(CopySalesDoc);
//                     end;
//                 }
//                 action("Archi&ve Document")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Archi&ve Document';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         //#8211
//                         ArchiveManagement2.fSetQuoteToOrder(FALSE);
//                         ArchiveManagement.ArchiveSalesDocument(Rec);
//                         //#8211//
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Move Negative Lines")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Move Negative Lines';
//                     Ellipsis = true;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CLEAR(MoveNegSalesLines);
//                         MoveNegSalesLines.SetSalesHeader(Rec);
//                         MoveNegSalesLines.RUNMODAL;
//                         MoveNegSalesLines.ShowDocument;
//                     end;
//                 }
//                 /* GL2024      action("E&xplode BOM")
//                       {ApplicationArea = all;
//                           Caption = 'E&xplode BOM';
//                           Image = ExplodeBOM;
//                           Visible = false;

//                           trigger OnAction()
//                           begin
//                               CurrPage.SalesLines.FORM.ExplodeBOM;
//                           end;
//                       }
//                       action("Insert &Ext. Texts")
//                       {
//                           Caption = 'Insert &Ext. Texts';
//                           Visible = false;

//                           trigger OnAction()
//                           begin
//                               CurrPage.SalesLines.FORM.InsertExtendedText(TRUE);
//                           end;
//                       }
//                       action("Propose ""Qty to ship""")
//                       {
//                           Caption = 'Propose "Qty to ship"';
//                           Visible = false;

//                           trigger OnAction()
//                           begin
//                               CurrPage.SalesLines.FORM.wProposeQtyToShip;
//                           end;
//                       }*/
//                 action("Generate Purchase Doc.")
//                 {
//                     Caption = 'Generate Purchase Doc.';
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         IF NOT REC.Approber THEN ERROR(Text018);

//                         // IF REC.Statut = REC.Statut::Ouvert THEN ERROR(Text004);
//                         NbrLigne := 0;
//                         // RB SORO 21/04/2015
//                         RecPurchasesSetup.GET;
//                         IF RecPurchasesSetup."Autoriser Approbation DA" THEN BEGIN
//                             IF RecLocation.GET(REC."Location Code") THEN;
//                             // IF NOT RecLocation."Magasin Centrale" THEN BEGIN
//                             //     IF NOT REC."DA Approbé" THEN ERROR(Text012);
//                             // END;
//                         END;
//                         // RB SORO 21/04/2015
//                         //GL2024 CurrPage.SalesLines.FORM.wGeneratePurchaseOrder;
//                         PurchaseHeader.SETRANGE("N° Demande d'achat", REC."No.");
//                         IF PurchaseHeader.FINDFIRST THEN
//                             REPEAT
//                                 PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
//                                 PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
//                                 IF PurchaseLine.FINDFIRST THEN NbrLigne += PurchaseLine.COUNT;
//                             UNTIL PurchaseHeader.NEXT = 0;
//                         SalesLine.SETRANGE("Document Type", REC."Document Type");
//                         SalesLine.SETRANGE("Document No.", REC."No.");
//                         IF SalesLine.FINDFIRST THEN NbrLigneOrigine := SalesLine.COUNT;
//                         IF NbrLigne < NbrLigneOrigine THEN BEGIN
//                             //REC.Statut := REC.Statut::"Partiellement Pris En Charge";
//                             REC.MODIFY;
//                         END;
//                         // IF NbrLigne = NbrLigneOrigine THEN BEGIN
//                         //     REC.Statut := REC.Statut::"Totallement Pris En Charge";
//                         //     REC.MODIFY;
//                         // END;

//                         // IF RecJob.GET(REC."Job No.") THEN
//                         //     IF NOT RecJob."Activer Procedure DA" THEN EXIT;

//                         SalesContributor.SETRANGE("Job No.", REC."Job No.");
//                         //    SalesContributor.SETFILTER(Approbateur, '<>%1', '');
//                         /* GL2024 dans PROCEDURE SendMil il ya Automation non compatible dans version cloud   IF SalesContributor.FINDFIRST THEN
//                                REPEAT
//                                    IF REC."Mode Notification" = REC."Mode Notification"::Mail THEN
//                                        Mail.SendMail(SalesContributor.Approbateur, 'NAVISION : NOTIFICATION DA PRISE EN CHARGE N° ',
//                                        'DA N° ' + REC."No." + ' EST PRISE EN CHARGE');
//                                UNTIL SalesContributor.NEXT = 0;*/
//                         //   Mail.NotificationDa(REC."No.", 'NOTIFICATION DA PRISE EN CHARGE', REC."Job No.", REC."Document Date", REC."User ID");
//                     end;
//                 }
//                 /* GL2024  group("Drop Shipment")
//                   {
//                       Caption = 'Drop Shipment';
//                       Visible = false;
//                       action("Purchase &Order")
//                       {ApplicationArea = all;
//                           Caption = 'Purchase &Order';
//                           Image = Document;
//                           Visible = false;

//                           trigger OnAction()
//                           begin
//                               CurrPage.SalesLines.FORM.OpenPurchOrderForm;
//                           end;
//                       }
//                   }
//                   group("Special Order")
//                   {
//                       Caption = 'Special Order';
//                       Visible = false;
//                       action("Purchase &Order")
//                       {ApplicationArea = all;
//                           Caption = 'Purchase &Order';
//                           Image = Document;
//                           Visible = false;

//                           trigger OnAction()
//                           begin
//                               CurrPage.SalesLines.FORM.OpenSpecialPurchOrderForm;
//                           end;
//                       }
//                   }*/
//                 action("Devis Associé")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Devis Associé';
//                     RunObject = Page "Purchase Quotes";
//                     RunPageLink = "N° Demande d'achat" = FIELD("No.");
//                 }
//                 /* GL2024    action("Purchase &Order")
//                      {
//                          Caption = 'Purchase &Order';
//                          Image = Document;

//                          trigger OnAction()
//                          begin
//                              CurrPage.SalesLines.FORM.OpenPurchOrderForm;
//                          end;
//                      }
//                      action("&Reserve")
//                      {
//                          Caption = '&Reserve';
//                          Ellipsis = true;
//                          Visible = false;

//                          trigger OnAction()
//                          begin
//                              CurrPage.SalesLines.FORM.ShowReservation;
//                          end;
//                      }
//                      action("Nonstoc&k Items")
//                      {
//                          Caption = 'Nonstoc&k Items';
//                          Visible = false;

//                          trigger OnAction()
//                          begin
//                              IF NOT UpdateAllowed THEN
//                                  EXIT;

//                              CurrPage.SalesLines.FORM.ShowNonstockItems;
//                          end;
//                      }
//                 action("Order &Tracking")
//                 {
//                     Caption = 'Order &Tracking';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CurrPage.SalesLines.FORM.ShowTracking;
//                     end;
//                 }*/
//                 action("Order &Promising")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Order &Promising';
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         OrderPromisingLine: Record "Order Promising Line" temporary;
//                         OrderPromising: Page "Order Promising Lines";
//                     begin
//                         OrderPromisingLine.SETRANGE("Source Type", REC."Document Type");
//                         OrderPromisingLine.SETRANGE("Source ID", REC."No.");
//                         PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
//                     end;
//                 }
//                 group(Warehouse)
//                 {
//                     Caption = 'Warehouse';
//                     Visible = false;
//                     action("Activity List")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Activity List';
//                         RunObject = Page "Warehouse Activity List";
//                         RunPageLink = Type = FILTER(Movement | "Invt. Put-away" | "Invt. Pick"), "No. of Lines" = FILTER(> 0), "Source Type Filter" = CONST(37), "Source Subtype Filter" = FIELD("Document Type"), "Source No. Filter" = FIELD("No.");
//                         Visible = false;
//                     }
//                     action("Create Assignment")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Create Assignment';
//                         Visible = false;

//                         trigger OnAction()
//                         var
//                             RetrieveSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
//                         begin
//                             RetrieveSourceDocOutbound.CreateFromSalesOrder(Rec);
//                         end;
//                     }
//                 }
//                 action("Re&lease")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     RunObject = Codeunit "Release Sales Document";
//                     ShortCutKey = 'Ctrl+F9';
//                 }
//                 action("Re&open")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Re&open';
//                     Image = ReOpen;

//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit "Release Sales Document";
//                     begin
//                         PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
//                         PurchaseHeader.SETRANGE("N° Demande d'achat", rec."No.");
//                         IF PurchaseHeader.FINDFIRST THEN ERROR(Text009);
//                         // IF (rec.Statut > rec.Statut::Lancé) THEN ERROR(Text008);
//                         // rec.Statut := rec.Statut::Ouvert;

//                         ReleaseSalesDoc.Reopen(Rec);
//                         rec.MODIFY;
//                         SalesLine.RESET;
//                         SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
//                         SalesLine.SETRANGE("Document No.", rec."No.");
//                         IF SalesLine.FINDFIRST THEN
//                             REPEAT
//                                 SalesLine.Statut := SalesLine.Statut::Ouvert;
//                                 SalesLine.MODIFY;
//                             UNTIL SalesLine.NEXT = 0;
//                     end;
//                 }
//                 separator(separator2)
//                 {
//                 }
//                 /*GL2024 action("&Send BizTalk Sales Order Cnfmn.")
//                  {
//                      Caption = '&Send BizTalk Sales Order Cnfmn.';
//                      Visible = false;

//                      trigger OnAction()
//                      var
//                          BizTalkManagement: Codeunit 99008508;
//                      begin
//                          BizTalkManagement.SendSalesOrderConf(Rec);
//                      end;
//                  }*/
//                 action(Notifier)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Notifier';
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
//                         SalesLine.SETRANGE("Document No.", rec."No.");
//                         SalesLine.SETFILTER(Quantity, '<>%1', 0);
//                         IF NOT SalesLine.FINDFIRST THEN ERROR(Text007);
//                         IF NOT CONFIRM(Text001) THEN EXIT;
//                         //  IF rec.Statut >= 1 THEN EXIT;
//                         TMessagerieChat.SETRANGE(NumDoc, rec."No.");
//                         IF NOT TMessagerieChat.FINDFIRST THEN BEGIN
//                             LeMessage := STRSUBSTNO(Text002, REC."No.", UPPERCASE(USERID));
//                             IF UserSetup.GET(UPPERCASE(USERID)) THEN;
//                             // IF UserSetup."Service Achat 01" <> '' THEN
//                             //     FMessagerieChat.InsertMessageDA(FALSE, UPPERCASE(USERID), UserSetup."Service Achat 01", LeMessage, rec."No.");
//                             // IF UserSetup."Service Achat 02" <> '' THEN
//                             //     FMessagerieChat.InsertMessageDA(FALSE, UPPERCASE(USERID), UserSetup."Service Achat 02", LeMessage, rec."No.");
//                             // IF UserSetup."Service Achat 03" <> '' THEN
//                             //     FMessagerieChat.InsertMessageDA(FALSE, UPPERCASE(USERID), UserSetup."Service Achat 03", LeMessage, rec."No.");
//                         END;
//                         SalesLine.RESET;
//                         SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
//                         SalesLine.SETRANGE("Document No.", rec."No.");
//                         IF SalesLine.FINDFIRST THEN
//                             REPEAT
//                                 SalesLine.Statut := SalesLine.Statut::Lancé;
//                                 SalesLine.MODIFY;
//                             UNTIL SalesLine.NEXT = 0;
//                         //rec.Statut := rec.Statut::Lancé;
//                         rec.MODIFY;
//                     end;
//                 }
//                 action(Archiver)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Archiver';

//                     trigger OnAction()
//                     begin
//                         // IF (rec.Statut = rec.Statut::Ouvert) OR (rec.Statut = rec.Statut::Lancé) THEN ERROR(Text006);
//                         // IF NOT CONFIRM(Text005) THEN EXIT;
//                         // rec.Statut := rec.Statut::Archiver;
//                         // rec.MODIFY;
//                     end;
//                 }
//                 separator(separator3)
//                 {
//                 }
//                 action(Approber)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Approber';
//                     Visible = false;

//                     trigger OnAction()
//                     begin

//                         IF RecLocation.GET(rec."Location Code") THEN;
//                         // IF NOT RecLocation."Magasin Centrale" THEN BEGIN
//                         //     UserSetup.GET(USERID);
//                         //     IF NOT UserSetup."Approbateur DA" THEN
//                         //         //IF (USERID <> UserSetup."Approbateur DA 1") AND (USERID <> UserSetup."Approbateur DA 2") THEN
//                         //         ERROR(Text013, rec."No.")
//                         //     ELSE BEGIN
//                         //         // rec."DA Approbé" := TRUE;
//                         //         // rec."Approbateur DA" := USERID;
//                         //         rec.MODIFY;
//                         //         MESSAGE(Text014);
//                         //     END;
//                         // END;
//                     end;
//                 }
//             }
//             action(PRINT1)
//             {
//                 ApplicationArea = all;
//                 Caption = '&Print';
//                 Ellipsis = true;
//                 Image = Print;

//                 trigger OnAction()
//                 begin
//                     // >> HJ DSFT 11-10-2012
//                     IF NOT rec.Approber THEN ERROR(Text021);
//                     //  IF rec.Statut = rec.Statut::Ouvert THEN ERROR(Text004);
//                     RecSalesOrder.SETRANGE("Document Type", rec."Document Type");
//                     RecSalesOrder.SETRANGE("No.", rec."No.");
//                     REPORT.RUNMODAL(REPORT::"Demande d'Appro Matricielle", TRUE, TRUE, RecSalesOrder);
//                     // >> HJ DSFT 11-10-2012

//                     // STD HJ DSFT 11-10-2012 DocPrint.PrintSalesHeader(Rec);
//                 end;
//             }
//             action("Notifier @")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Notifier';


//                 trigger OnAction()
//                 begin
//                     // >> HJ 05-04-2018
//                     IF RecJob.GET(rec."Job No.") THEN
//                         //  IF NOT RecJob."Activer Procedure DA" THEN EXIT;

//                         IF rec."Sell-to Address 2" = '' THEN ERROR(Text017);
//                     SalesContributor.SETRANGE("Job No.", rec."Job No.");
//                     //   SalesContributor.SETRANGE(Notificateur, UPPERCASE(USERID));
//                     IF NOT SalesContributor.FINDFIRST THEN ERROR(Text016, UPPERCASE(USERID));

//                     IF NOT CONFIRM(Text015) THEN EXIT;
//                     //  UserSetup.SETRANGE("Notifier DA Par Mail", TRUE);

//                     SalesContributor.SETRANGE("Job No.", rec."Job No.");
//                     //  SalesContributor.SETFILTER(Approbateur, '<>%1', '');
//                     /* GL2024 dans PROCEDURE SendMil il ya Automation non compatible dans version cloud IF SalesContributor.FINDFIRST THEN
//                           REPEAT
//                               Mail.SendMail(SalesContributor.Approbateur,
//                               'NAVISION : NOTIFICATION CREATION MATERIAUX ', 'VEUILLEZ CREER ' + UPPERCASE(rec."Sell-to Address 2"));
//                           UNTIL SalesContributor.NEXT = 0;*/
//                     //  Mail.NotificationDa(rec."No.", 'CREATION NOUVEAU MATERIAUX : ' + UPPERCASE(rec."Sell-to Address 2"), rec."Job No.", rec."Document Date", rec."User ID");
//                     CurrPage.UPDATE;
//                     // >> HJ 05-04-2018
//                 end;
//             }
//             action("...")
//             {
//                 ApplicationArea = all;
//                 Caption = '...';


//                 trigger OnAction()
//                 begin
//                     IF CdeArticle = '' THEN EXIT;
//                     IF NOT CONFIRM(Text020) THEN EXIT;
//                     SalesContributor.SETRANGE("Job No.", rec."Job No.");
//                     //      SalesContributor.SETRANGE(Approbateur, UPPERCASE(USERID));
//                     IF NOT SalesContributor.FINDFIRST THEN ERROR(Text019, UPPERCASE(USERID));
//                     IF RecItem.GET(CdeArticle) THEN;
//                     RegroupementRapportDG.Code := CdeArticle;
//                     RegroupementRapportDG.Chantier := rec."Job No.";
//                     RegroupementRapportDG.Designation := RecItem.Description;
//                     RegroupementRapportDG.Type := RegroupementRapportDG.Type::Materiaux;
//                     IF RegroupementRapportDG.INSERT THEN;
//                 end;
//             }
//         }
//     }

//     trigger OnDeleteRecord(): Boolean
//     begin
//         CurrPage.UPDATE(TRUE);
//         EXIT(rec.ConfirmDeletion);
//     end;

//     trigger OnInit()
//     begin

//         UrgenceEditable := TRUE;
//         "Document DateEditable" := TRUE;
//         "Job No.Editable" := TRUE;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         //   IF rec.Statut <> rec.Statut::Ouvert THEN ERROR(Text010);
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin

//         rec."Responsibility Center" := UserMgt.GetSalesFilter();

//         rec."Order Type" := rec."Order Type"::"Supply Order";
//         // >> HJ SORO 19-09-2017
//         //   rec.Chantier := TRUE;
//         rec."Type Demande" := rec."Type Demande"::Materiaux;
//         // >> HJ SORO 19-09-2017
//     end;

//     var
//         Text000: Label 'Unable to execute this function while in view only mode.';
//         CopySalesDoc: Report "Copy Sales Document";
//         MoveNegSalesLines: Report "Move Negative Sales Lines";
//         ReportPrint: Codeunit "Test Report-Print";
//         DocPrint: Codeunit "Document-Print";
//         ArchiveManagement: Codeunit ArchiveManagement;
//         ArchiveManagement2: Codeunit ArchiveManagementEvent;
//         SalesSetup: Record "Sales & Receivables Setup";
//         ChangeExchangeRate: Page "Change Exchange Rate";
//         UserMgt: Codeunit "User Setup Management";
//         "// HJ DSFT": Integer;
//         RecSalesOrder: Record "Sales Header";
//         FMessagerieChat: Page Messagerie;
//         TMessagerieChat: Record "Messagerie Chat";
//         UserSetup: Record "User Setup";
//         Text001: Label 'Envoyer La Notification ?';
//         LeMessage: Text[200];
//         Text002: Label 'Nouvelle Demande Achat N° %1  Envoyé Par %2';
//         Text003: Label 'Notification Déja Envoyé';
//         Text004: Label 'Statut Doit Etre Lancé (Notification Non effectuée)';
//         Text005: Label 'Archiver Cette Demande Achat ?';
//         Text006: Label 'Statut Doit Etre Pris En Charge Pour Pouvoir Archiver ?';
//         PurchaseHeader: Record "Purchase Header";
//         PurchaseLine: Record "Purchase Line";
//         NbrLigne: Integer;
//         NbrLigneOrigine: Integer;
//         SalesLine: Record "Sales Line";
//         Text007: Label 'Aucune Ligne dans DA';
//         Text008: Label 'DA Déja Engagé';
//         Text009: Label 'DA Lié a Une Commande Achat';
//         Text010: Label 'Aucune Modification Permise Statut Non Ouvert';
//         Text011: Label 'Interdiction Total Au Module DA';
//         "// RB SORO": Integer;
//         RegroupementRapportDG: Record "Regroupement Rapport DG";
//         RecPurchasesSetup: Record "Purchases & Payables Setup";
//         RecLocation: Record Location;
//         Text012: Label 'Approber Doit Etre oui Dans le demande Achat N° %1 ';
//         Text013: Label 'Vous n etes pas Autoriser à Approber le DA n° %1';
//         Text014: Label 'Approbation Reussite';
//         Text015: Label 'Envoyer Notification ?';
//         Mail: Codeunit "Soroubat cdu";
//         Text016: Label 'Envoi Notification Interdite pour l''Utilisateur %1, Consulter votre administrateur';
//         SalesContributor: Record "Sales Contributor";
//         Text017: Label 'Veuillez Remplir Designation';
//         Text018: Label 'Vous devez approber cette DA avant creation de la commande';
//         RecJob: Record Job;
//         CdeArticle: Code[20];
//         Text019: Label 'Seul l''approbateur peut inserer un article';
//         "QUantitéeEstimée": Decimal;
//         RecItem: Record Item;
//         Text020: Label 'Confirmer Cette Action ?';
//         Text021: Label 'Vous devez approber cette DA avant d''imprimer';
//         [InDataSet]
//         "Job No.Editable": Boolean;
//         [InDataSet]
//         "Document DateEditable": Boolean;
//         [InDataSet]
//         UrgenceEditable: Boolean;


//     procedure UpdateAllowed(): Boolean
//     begin
//         IF CurrPage.EDITABLE = FALSE THEN
//             ERROR(Text000);
//         EXIT(TRUE);
//     end;


//     procedure "//HJ"()
//     begin
//     end;


//     procedure EnableControls()
//     begin
//         // >> HJ SORO 05-04-2018
//         IF rec.Approber THEN BEGIN
//             "Job No.Editable" := FALSE;
//             "Document DateEditable" := FALSE;
//             UrgenceEditable := FALSE;
//         END
//         ELSE BEGIN
//             "Job No.Editable" := TRUE;
//             "Document DateEditable" := TRUE;
//             UrgenceEditable := TRUE;
//         END;
//         // >> HJ SORO 05-04-2018
//     end;

//     local procedure MotifRefusOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure MotifRefusOnValidate()
//     begin
//         // >> HJ 05-04-2018
//         IF RecJob.GET(rec."Job No.") THEN
//             IF NOT RecJob."Activer Procedure DA" THEN EXIT;
//         //IF rec."Motif Refus" = 0 THEN EXIT;
//         IF UserSetup.GET(UPPERCASE(USERID)) THEN;
//         IF NOT UserSetup."Notification Service Appro" THEN ERROR(Text016);
//         IF NOT CONFIRM(Text015) THEN BEGIN
//             // rec."Motif Refus" := 0;
//             EXIT;
//         END;
//         // IF rec."Mode Notification" = rec."Mode Notification"::Mail THEN BEGIN
//         //     SalesContributor.SETRANGE("Job No.", rec."Job No.");
//         //     SalesContributor.SETFILTER(Approbateur, '<>%1', '');
//         //     /* GL2024 dans PROCEDURE SendMil il ya Automation non compatible dans version cloud      IF SalesContributor.FINDFIRST THEN
//         //               REPEAT
//         //                   Mail.SendMail(SalesContributor.Approbateur,
//         //                   'NAVISION : NOTIFICATION REFUS DA ', 'CAUSE : ' + UPPERCASE(FORMAT(rec."Motif Refus")));
//         //                   Mail.NotificationDa(rec."No.", 'REFUS DA MOTIF : ' + UPPERCASE(FORMAT(rec."Motif Refus")), rec."Job No.", rec."Document Date", rec."User ID");
//         //               UNTIL SalesContributor.NEXT = 0;*/
//         // END;
//         // >> HJ 05-04-2018
//     end;
// }

