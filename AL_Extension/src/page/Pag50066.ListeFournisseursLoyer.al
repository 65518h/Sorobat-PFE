// page 50066 "Liste Fournisseurs Loyer"
// {
//     // //ACHATS GESWAY 29/03/05 Ajout du filtre catégorie article
//     // //+OFF+OFFRE GESWAY 31/01/03 Adaptation du bouton Achats (Idem fiche fournisseur)
//     //              CW     11/03/05 Filtre Catégorie article
//     //              AC     11/05/05 Fonction wGetRecInstance
//     // //+REF+REPORT_LIST CW 05/11/09 Main MenuButton + ReportList
//     // //+REF+MISC CW 18/02/05 +"VAT Registration No." (visible=no), 2 lines title

//     Caption = 'Liste des fournisseurs Loyer';
//     PageType = List;
//     SourceTable = Vendor;
//     SourceTableView = WHERE(Blocked = FILTER(<> All), Loyer = CONST(true));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             group(general)
//             {
//                 ShowCaption = false;
//                 field("Item Category Filter"; rec."Item Category Filter")
//                 {
//                     ApplicationArea = all;
//                     Lookup = true;
//                     TableRelation = "Resources Setup";

//                     trigger OnValidate()
//                     begin
//                         ItemCategoryFilterOnAfterValid;
//                     end;
//                 }
//             }
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Name; rec.Name)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ancien Numero"; rec."Ancien Numero")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Balance (LCY)"; rec."Balance (LCY)")
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                     Visible = true;
//                 }
//                 field("Responsibility Center"; rec."Responsibility Center")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Location Code1"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Post Code"; rec."Post Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Country/Region Code"; rec."Country/Region Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Phone No."; rec."Phone No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Fax No."; rec."Fax No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("IC Partner Code"; rec."IC Partner Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field(Contact; rec.Contact)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Purchaser Code"; rec."Purchaser Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Vendor Posting Group"; rec."Vendor Posting Group")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("VAT Registration No.1"; rec."VAT Registration No.")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Payment Terms Code"; rec."Payment Terms Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Fin. Charge Terms Code"; rec."Fin. Charge Terms Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Language Code"; rec."Language Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Search Name"; rec."Search Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Blocked; rec.Blocked)
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Last Date Modified"; rec."Last Date Modified")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Application Method"; rec."Application Method")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Shipment Method Code"; rec."Shipment Method Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Lead Time Calculation"; rec."Lead Time Calculation")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Base Calendar Code"; rec."Base Calendar Code")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("VAT Registration No."; rec."VAT Registration No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Balance; rec.Balance)
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

//             group("Ven&dor1")
//             {
//                 Caption = 'Ven&dor';

//                 actionref(Card1; Card) { }
//                 actionref("Ledger E&ntries1"; "Ledger E&ntries") { }
//                 actionref("Co&mments1"; "Co&mments") { }
//                 group(Dimensions1)
//                 {
//                     Caption = 'Dimensions';
//                     actionref("Dimensions-Single1"; "Dimensions-Single") { }
//                     actionref("Dimensions-&Multiple1"; "Dimensions-&Multiple") { }
//                 }

//                 actionref("Bank Accounts1"; "Bank Accounts") { }
//                 actionref("Order &Addresses1"; "Order &Addresses") { }
//                 actionref("C&ontact1"; "C&ontact") { }
//                 actionref("Relate&d Contacts1"; "Relate&d Contacts") { }
//                 actionref(Statistics1; Statistics) { }
//                 actionref("Entry Statistics1"; "Entry Statistics") { }
//                 actionref(Purchases1; Purchases) { }
//                 actionref("Cross Re&ferences1"; "Cross Re&ferences") { }
//                 actionref(Reports1; Reports) { }
//             }

//             group("&Purchases1")
//             {
//                 Caption = '&Purchases';

//                 actionref(Items1; Items) { }

//                 actionref("Invoice &Discounts1"; "Invoice &Discounts") { }

//                 actionref(Prices1; Prices) { }

//                 actionref("Line Discounts1"; "Line Discounts") { }

//                 actionref("Prepa&yment Percentages1"; "Prepa&yment Percentages") { }

//                 actionref("S&td. Vend. Purchase Codes1"; "S&td. Vend. Purchase Codes") { }

//                 actionref(Quotes1; Quotes) { }

//                 actionref("Blanket Orders1"; "Blanket Orders") { }

//                 actionref(Orders1; Orders) { }

//                 actionref("Return Orders1"; "Return Orders") { }

//                 actionref("Item &Tracking Entries1"; "Item &Tracking Entries") { }


//             }
//         }
//         area(navigation)
//         {
//             group("Ven&dor")
//             {
//                 Caption = 'Ven&dor';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Vendor Card";
//                     RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//                     ShortCutKey = 'Maj+F7';
//                 }
//                 action("Ledger E&ntries")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Ledger E&ntries';
//                     RunObject = Page "Vendor Ledger Entries";
//                     RunPageLink = "Vendor No." = FIELD("No.");
//                     RunPageView = SORTING("Vendor No.");
//                     ShortCutKey = 'Ctrl+F7';
//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Comment Sheet";
//                     RunPageLink = "Table Name" = CONST(Vendor), "No." = FIELD("No.");
//                 }
//                 group(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     action("Dimensions-Single")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Dimensions-Single';
//                         RunObject = Page "Default Dimensions";
//                         RunPageLink = "Table ID" = CONST(23), "No." = FIELD("No.");
//                         ShortCutKey = 'Maj+Ctrl+D';
//                     }
//                     action("Dimensions-&Multiple")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Dimensions-&Multiple';

//                         trigger OnAction()
//                         var
//                             Vend: Record Vendor;
//                             DefaultDimMultiple: Page "Default Dimensions-Multiple";
//                         begin
//                             CurrPage.SETSELECTIONFILTER(Vend);
//                             DefaultDimMultiple.SetMultiRecord(Vend, 1);
//                             DefaultDimMultiple.RUNMODAL;
//                         end;
//                     }
//                 }
//                 action("Bank Accounts")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Bank Accounts';
//                     RunObject = Page "Vendor Bank Account List";
//                     RunPageLink = "Vendor No." = FIELD("No.");
//                 }
//                 action("Order &Addresses")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Order &Addresses';
//                     RunObject = Page "Order Address List";
//                     RunPageLink = "Vendor No." = FIELD("No.");
//                 }
//                 action("C&ontact")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'C&ontact';

//                     trigger OnAction()
//                     begin
//                         rec.ShowContact;
//                     end;
//                 }
//                 action("Relate&d Contacts")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Relate&d Contacts';

//                     trigger OnAction()
//                     begin
//                         rec.fShowContactList;
//                     end;
//                 }
//                 separator(separator1)
//                 {
//                 }
//                 action(Statistics)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Statistics';
//                     Image = Statistics;

//                     RunObject = Page "Vendor Statistics";
//                     RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//                     ShortCutKey = 'F7';
//                 }
//                 /* GL2024  action("Statistics by C&urrencies")
//                    {ApplicationArea = all;
//                        Caption = 'Statistics by C&urrencies';
//                        RunObject = Page 482;
//                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Date Filter" = FIELD("Date Filter");
//                    }*/
//                 action("Entry Statistics")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Entry Statistics';
//                     RunObject = Page "Vendor Entry Statistics";
//                     RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//                 }
//                 action(Purchases)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Purchases';
//                     RunObject = Page "Vendor Purchases";
//                     RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//                 }
//                 separator(separator2)
//                 {
//                 }
//                 action("Cross Re&ferences")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Cross Re&ferences';
//                     RunObject = Page "Item References";
//                     RunPageLink = "Reference Type" = CONST(Vendor), "Reference Type No." = FIELD("No.");
//                     RunPageView = SORTING("Reference Type", "Reference Type No.");
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
//                             lRecRef.SETVIEW(Rec.GETVIEW);
//                             SetRecordRef(lRecRef, FALSE);
//                             ShowList(lId);
//                         END;
//                     end;
//                 }
//             }

//             group("&Purchases")
//             {
//                 Caption = '&Purchases';
//                 action(Items)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Items';
//                     RunObject = Page "Vendor Item Catalog";
//                     RunPageLink = "Vendor No." = FIELD("No.");
//                     RunPageView = SORTING("Vendor No.");
//                 }
//                 action("Invoice &Discounts")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Invoice &Discounts';
//                     RunObject = Page "Vend. Invoice Discounts";
//                     RunPageLink = Code = FIELD("Invoice Disc. Code");
//                 }
//                 action(Prices)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prices';
//                     Image = ResourcePrice;
//                     RunObject = Page "Purchase Prices";
//                     RunPageLink = "Vendor No." = FIELD("No.");
//                     RunPageView = SORTING("Vendor No.");
//                 }
//                 action("Line Discounts")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Line Discounts';
//                     RunObject = Page "Purchase Line Discounts";
//                     RunPageLink = "Vendor No." = FIELD("No.");
//                     RunPageView = SORTING("Purchase Type", "Vendor No.", Type, "Item No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity");
//                 }
//                 action("Prepa&yment Percentages")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prepa&yment Percentages';
//                     RunObject = Page "Purchase Prepmt. Percentages";
//                     RunPageLink = "Vendor No." = FIELD("No.");
//                     RunPageView = SORTING("Vendor No.");
//                 }
//                 action("S&td. Vend. Purchase Codes")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'S&td. Vend. Purchase Codes';
//                     RunObject = Page "Standard Vendor Purchase Codes";
//                     RunPageLink = "Vendor No." = FIELD("No.");
//                 }
//                 separator(separato3)
//                 {
//                 }
//                 /*GL2024  action("Item Category Group")
//                   {ApplicationArea = all;
//                       Caption = 'Item Category Group';
//                       RunObject = Page 8004095;
//                                       RunPageLink = "Vendor No."=FIELD("No.");
//                       RunPageView = SORTING("Vendor No.","Item Category Code","Product Group Code");
//                   }*/
//                 separator(separato4)
//                 {
//                 }
//                 action(Quotes)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Quotes';
//                     Image = Quote;
//                     RunObject = Page "Purchase Quotes";
//                     RunPageLink = "Buy-from Vendor No." = FIELD("No.");
//                     RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
//                 }
//                 action("Blanket Orders")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Blanket Orders';
//                     Image = BlanketOrder;
//                     RunObject = Page "Blanket Purchase Orders";
//                     RunPageLink = "Buy-from Vendor No." = FIELD("No.");
//                     RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
//                 }
//                 action(Orders)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Orders';
//                     Image = Document;
//                     RunObject = Page "Purchase Order List";
//                     RunPageLink = "Buy-from Vendor No." = FIELD("No.");
//                     RunPageView = SORTING("Document Type", "Buy-from Vendor No.", "No.");
//                 }
//                 action("Return Orders")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Return Orders';
//                     Image = ReturnOrder;
//                     RunObject = Page "Purchase Return Order List";
//                     RunPageLink = "Buy-from Vendor No." = FIELD("No.");
//                     RunPageView = SORTING("Document Type", "Buy-from Vendor No.", "No.");
//                 }
//                 action("Item &Tracking Entries")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Item &Tracking Entries';
//                     Image = ItemTrackingLedger;

//                     trigger OnAction()
//                     var
//                         ItemTrackingMgt: Codeunit "Item Tracking Management";
//                         ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
//                     begin
//                         // ItemTrackingMgt.CallItemTrackingEntryForm(2, rec."No.", '', '', '', '', '');
//                         ItemTrackingDocMgt.ShowItemTrackingForEntity(2, '', Rec."No.", '', '');
//                     end;
//                 }
//             }
//         }
//     }


//     procedure GetSelectionFilter(): Code[80]
//     var
//         Vend: Record Vendor;
//         FirstVend: Code[30];
//         LastVend: Code[30];
//         SelectionFilter: Code[250];
//         VendCount: Integer;
//         More: Boolean;
//     begin
//         CurrPage.SETSELECTIONFILTER(Vend);
//         VendCount := Vend.COUNT;
//         IF VendCount > 0 THEN BEGIN
//             Vend.FIND('-');
//             WHILE VendCount > 0 DO BEGIN
//                 VendCount := VendCount - 1;
//                 Vend.MARKEDONLY(FALSE);
//                 FirstVend := Vend."No.";
//                 LastVend := FirstVend;
//                 More := (VendCount > 0);
//                 WHILE More DO
//                     IF Vend.NEXT = 0 THEN
//                         More := FALSE
//                     ELSE
//                         IF NOT Vend.MARK THEN
//                             More := FALSE
//                         ELSE BEGIN
//                             LastVend := Vend."No.";
//                             VendCount := VendCount - 1;
//                             IF VendCount = 0 THEN
//                                 More := FALSE;
//                         END;
//                 IF SelectionFilter <> '' THEN
//                     SelectionFilter := SelectionFilter + '|';
//                 IF FirstVend = LastVend THEN
//                     SelectionFilter := SelectionFilter + FirstVend
//                 ELSE
//                     SelectionFilter := SelectionFilter + FirstVend + '..' + LastVend;
//                 IF VendCount > 0 THEN BEGIN
//                     Vend.MARKEDONLY(TRUE);
//                     Vend.NEXT;
//                 END;
//             END;
//         END;
//         EXIT(SelectionFilter);
//     end;


//     procedure SetSelection(var Vend: Record Vendor)
//     begin
//         CurrPage.SETSELECTIONFILTER(Vend);
//     end;


//     procedure wGetRecInstance(var pRec: Record Vendor)
//     begin
//         Rec.MARKEDONLY(TRUE);
//         pRec.COPY(Rec);
//     end;

//     local procedure ItemCategoryFilterOnAfterValid()
//     begin
//         IF rec.GETFILTER("Item Category Filter") = '' THEN
//             rec.SETRANGE("Item Category")
//         ELSE
//             rec.SETRANGE("Item Category", TRUE);
//     end;
// }

