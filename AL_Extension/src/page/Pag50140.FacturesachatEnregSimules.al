// page 50140 "Factures achat Enreg Simulées"
// {
//     // //POSTING_DESCR CW 22/04/04 +"Posting description","Order No."
//     // //MISC CW 17/06/06 +"OnHold", +"UserID", "Vendor Shipment No."

//     Caption = 'Factures achat Enreg Simulées';
//     Editable = false;
//     PageType = List;
//     SourceTable = "Purch. Inv. Header";
//     SourceTableView = WHERE(Simulation = FILTER(true));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Order Date"; rec."Order Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Order Address Code"; rec."Order Address Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vendor Invoice No."; rec."Vendor Invoice No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Statut Facture"; rec."Statut Facture")
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field("Posting Description"; rec."Posting Description")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Order No.1"; rec."Order No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("User ID"; rec."User ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("On Hold"; rec."On Hold")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Job No."; rec."Job No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Order No."; rec."Order No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Vendor Shipment No."; rec."Vendor Shipment No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Amount; rec.Amount)
//                 {
//                     ApplicationArea = all;

//                     trigger OnDrillDown()
//                     begin
//                         rec.SETRANGE("No.");
//                         page.RUNMODAL(page::"Posted Purchase Invoice", Rec)
//                     end;
//                 }
//                 field("Amount Including VAT"; rec."Amount Including VAT")
//                 {
//                     ApplicationArea = all;

//                     trigger OnDrillDown()
//                     begin
//                         rec.SETRANGE("No.");
//                         page.RUNMODAL(page::"Posted Purchase Invoice", Rec)
//                     end;
//                 }
//                 field("Buy-from Post Code"; rec."Buy-from Post Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Buy-from Country/Region Code"; rec."Buy-from Country/Region Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Buy-from Contact"; rec."Buy-from Contact")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Pay-to Name"; rec."Pay-to Name")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Pay-to Post Code"; rec."Pay-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Pay-to Country/Region Code"; rec."Pay-to Country/Region Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Pay-to Contact"; rec."Pay-to Contact")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Ship-to Code"; rec."Ship-to Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Ship-to Name"; rec."Ship-to Name")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Ship-to Post Code"; rec."Ship-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Ship-to Country/Region Code"; rec."Ship-to Country/Region Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Ship-to Contact"; rec."Ship-to Contact")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Posting Date1"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Document Date"; rec."Document Date")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Purchaser Code"; rec."Purchaser Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Payment Terms Code"; rec."Payment Terms Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Payment Discount %"; rec."Payment Discount %")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = true;
//                 }
//                 field("Payment Method Code"; rec."Payment Method Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("No. Printed"; rec."No. Printed")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Shipment Method Code"; rec."Shipment Method Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group("&Invoice1")
//             {
//                 Caption = '&Invoice';
//                 actionref(Card1; Card) { }
//                 actionref(Statistics1; Statistics) { }
//                 actionref("Co&mments1"; "Co&mments") { }
//                 actionref("Valider La Facture1"; "Valider La Facture") { }
//                 actionref("Supprimer La Facture1"; "Supprimer La Facture") { }
//                 actionref("Annuler Simulation1"; "Annuler Simulation") { }

//             }
//             actionref("&Print1"; "&Print") { }
//             actionref("&Navigate1"; "&Navigate") { }
//         }
//         area(navigation)
//         {
//             group("&Invoice")
//             {
//                 Caption = '&Invoice';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Posted Purchase Invoices";
//                     RunPageLink = "No." = FIELD("No.");
//                     ShortCutKey = 'Maj+F5';
//                 }
//                 action(Statistics)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Statistics';
//                     Image = Statistics;

//                     RunObject = Page "Purchase Invoice Statistics";
//                     RunPageLink = "No." = FIELD("No.");
//                     ShortCutKey = 'F7';
//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Purch. Comment Sheet";
//                     RunPageLink = "Document Type" = CONST("Posted Invoice"), "No." = FIELD("No.");
//                 }
//                 /*  GL2024 action(Dimensions)
//                    {
//                        ApplicationArea = all;
//                        Caption = 'Dimensions';
//                        Image = Dimensions;
//                        RunObject = Page 547;
//                        RunPageLink = "Table ID" = CONST(122), "Document No." = FIELD("No."), "Line No." = CONST(0);
//                    }*/
//                 action("Valider La Facture")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Validate the Invoice';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         // RB SORO 23/03/2016 SIMULATION FACTURE ACHAT
//                         RecUserSetup.GET(UPPERCASE(USERID));
//                         // IF NOT RecUserSetup."Validation Doc Achat Simuler" THEN
//                         //     ERROR(Text001);
//                         CurrPage.SETSELECTIONFILTER(RecPurchInvHeaderFilt);
//                         IF RecPurchInvHeaderFilt.COUNT = 1 THEN BEGIN
//                             IF RecPurchInvHeaderFilt.FINDFIRST THEN
//                                 CUPurch.ValiderFactSimulee(RecPurchInvHeaderFilt."No.")
//                         END
//                         ELSE
//                             ERROR(Text003);
//                         // RB SORO 23/03/2016 SIMULATION FACTURE ACHAT
//                     end;
//                 }
//                 action("Supprimer La Facture")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Delete the Invoice';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         // RB SORO 23/03/2016 SIMULATION FACTURE ACHAT
//                         IF NOT CONFIRM(Text007) THEN EXIT;
//                         NumFactSupp := '';
//                         RecUserSetup.GET(UPPERCASE(USERID));
//                         // IF NOT RecUserSetup."Simulation Doc Achat" THEN
//                         //     ERROR(Text002);
//                         IF (rec."Posting Date" < RecUserSetup."Allow Posting From") OR (rec."Posting Date" > RecUserSetup."Allow Posting To") THEN ERROR(Text006);
//                         CurrPage.SETSELECTIONFILTER(RecPurchInvHeaderSupp);
//                         IF RecPurchInvHeaderSupp.COUNT = 1 THEN BEGIN
//                             IF RecPurchInvHeaderSupp.FINDFIRST THEN BEGIN

//                                 //MH SORO 17-02-2021
//                                 RecGLEntry.RESET;
//                                 RecGLEntry.SETRANGE("Document No.", RecPurchInvHeaderSupp."No.");
//                                 IF RecGLEntry.FINDFIRST THEN
//                                     REPEAT
//                                         RecTempGLEntry.INIT;
//                                         RecTempGLEntry.TRANSFERFIELDS(RecGLEntry);
//                                         RecTempGLEntry.INSERT;
//                                     UNTIL RecGLEntry.NEXT = 0;
//                                 //MH SORO 17-02-2021

//                                 CUPurch.CreateFactAchat(RecPurchInvHeaderSupp."No.");
//                                 NumFactSupp := RecPurchInvHeaderSupp."No.";
//                             END;
//                             CUPurch.DeleteFactAchat(NumFactSupp);
//                         END
//                         ELSE
//                             ERROR(Text004);
//                         // RB SORO 23/03/2016 SIMULATION FACTURE ACHAT
//                     end;
//                 }
//                 action("Annuler Simulation")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Cancel Simulation';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         IF NOT CONFIRM(Text005) THEN EXIT;
//                         CUPurch.AnnulerSimulation(rec."No.", FALSE);
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             action("&Print")
//             {
//                 ApplicationArea = all;
//                 Caption = '&Print';
//                 Ellipsis = true;
//                 Image = Print;


//                 trigger OnAction()
//                 begin
//                     CurrPage.SETSELECTIONFILTER(PurchInvHeader);
//                     PurchInvHeader.PrintRecords(TRUE);
//                 end;
//             }
//             action("&Navigate")
//             {
//                 ApplicationArea = all;
//                 Caption = '&Navigate';
//                 Image = Navigate;

//                 trigger OnAction()
//                 begin
//                     rec.Navigate;
//                 end;
//             }
//         }
//     }

//     var
//         PurchInvHeader: Record "Purch. Inv. Header";
//         "// RB SORO": Integer;
//         RecUserSetup: Record "User Setup";

//         CUPurch: Codeunit PurchPostEvent;
//         RecPurchInvHeaderFilt: Record "Purch. Inv. Header";

//         RecPurchInvHeaderSupp: Record "Purch. Inv. Header";
//         NumFactSupp: Code[20];

//         RecGLEntry: Record "G/L Entry";
//        // RecTempGLEntry: Record "Temp G/L Entry";
//         Text001: Label 'You are not authorized to validate a simulated invoice. Contact your administrator !!!';
//         Text002: Label 'You are not authorized to delete a simulated invoice. Contact your administrator !!!';
//         Text003: Label 'You must select only one invoice to validate';
//         Text004: Label 'You must select only one invoice to delete';
//         Text005: Label 'Do you want to cancel the simulation ?';
//         Text006: Label 'Your date range is not authorized.';
//         Text007: Label 'Do you want to delete the simulation?';
// }

