page 50389 "Item Ledger Entry History"
{
    Caption = 'Historique Écritures Comptables Article';
    DataCaptionExpression = GetCaption;
    DataCaptionFields = "Item No.";
    Editable = false;
    PageType = List;
    SourceTable = "Item Ledger Entry History";
    SourceTableView = SORTING("Entry No.");
    ModifyAllowed = false;
    InsertAllowed = false;
    DelayedInsert = false;
    DeleteAllowed = false;
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                    caption = 'N° séquence';
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    caption = 'Date comptabilisation';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date document';
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                    caption = 'Type écriture';
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                    caption = 'Type document';
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                    caption = 'N° document';
                }
                field("Document Line No."; rec."Document Line No.")
                {
                    ApplicationArea = all;
                    caption = 'N° ligne document';
                    Visible = false;
                }
                field("Numero Commande"; rec."Numero Commande")
                {
                    ApplicationArea = all;
                    caption = 'Numero Commande';
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    caption = 'N° article';
                }
                field("Designation Article"; rec."Designation Article")
                {
                    ApplicationArea = all;
                    caption = 'Designation Article';
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                    caption = 'Code unité';
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                    caption = 'Code variante';
                    Visible = false;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                    caption = 'N° doc. externe';
                }
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = all;
                    caption = 'Type origine';
                }
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = all;
                    caption = 'N° origine';
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    ApplicationArea = all;
                    caption = 'Code motif retour';
                    Visible = false;
                }
                field("Sous Affectation Marche"; rec."Sous Affectation Marche")
                {
                    ApplicationArea = all;
                    caption = 'Sous Affectation Marche';
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    caption = 'Code axe principal 1';
                    Visible = false;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    caption = 'Code axe principal 2';
                    Visible = false;
                }
                field("Expiration Date"; rec."Expiration Date")
                {
                    ApplicationArea = all;
                    caption = 'Date d''expiration';
                    Visible = false;
                }
                field("Serial No."; rec."Serial No.")
                {
                    ApplicationArea = all;
                    caption = 'N° de série';
                    Visible = false;
                }
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = all;
                    caption = 'N° lot';
                    Visible = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    caption = 'Code magasin';
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    caption = 'Quantité';
                }
                field("Invoiced Quantity"; rec."Invoiced Quantity")
                {
                    ApplicationArea = all;
                    caption = 'Quantité facturée';
                    Visible = true;
                }
                field("Remaining Quantity"; rec."Remaining Quantity")
                {
                    ApplicationArea = all;
                    caption = 'Quantité non affectée';
                    Visible = true;
                }
                field("Shipped Qty. Not Returned"; rec."Shipped Qty. Not Returned")
                {
                    ApplicationArea = all;
                    caption = 'Qté livrée non renvoyée';
                    Visible = false;
                }
                field("Reserved Quantity"; rec."Reserved Quantity")
                {
                    ApplicationArea = all;
                    caption = 'Quantité réservée';
                    Visible = false;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                    caption = 'Quantité par unité';
                    Visible = false;
                }
                field("Sales Amount (Expected)"; rec."Sales Amount (Expected)")
                {
                    ApplicationArea = all;
                    caption = 'Montant vente (prévu)';
                    Visible = false;
                }
                field("Sales Amount (Actual)"; rec."Sales Amount (Actual)")
                {
                    ApplicationArea = all;
                    caption = 'Montant vente (réel)';
                }
                field("Cost Amount (Expected)"; rec."Cost Amount (Expected)")
                {
                    ApplicationArea = all;
                    caption = 'Coût total (prévu)';
                    Visible = false;
                }

                field("Cost Amount (Actual)"; rec."Cost Amount (Actual)")
                {
                    ApplicationArea = all;
                    caption = 'Coût total (réel)';
                }
                field("Cost Amount (Non-Invtbl.)"; rec."Cost Amount (Non-Invtbl.)")
                {
                    ApplicationArea = all;
                    caption = 'Coût total (non incorp.)';
                }
                field("Cost Amount (Expected) (ACY)"; rec."Cost Amount (Expected) (ACY)")
                {
                    ApplicationArea = all;
                    caption = 'Montant coût (prévu) DR';
                    Visible = false;
                }
                field("Cost Amount (Actual) (ACY)"; rec."Cost Amount (Actual) (ACY)")
                {
                    ApplicationArea = all;
                    caption = 'Coût total (réel) DR';
                    Visible = false;
                }
                field("Cost Amount (Non-Invtbl.)(ACY)"; rec."Cost Amount (Non-Invtbl.)(ACY)")
                {
                    ApplicationArea = all;
                    caption = 'Coût total non incorp. DR';
                    Visible = false;
                }
                field("Completely Invoiced"; rec."Completely Invoiced")
                {
                    ApplicationArea = all;
                    caption = 'Entièrement facturé';
                    Visible = false;
                }
                field(Open; rec.Open)
                {
                    ApplicationArea = all;
                    caption = 'Ouvert';
                }
                field("Drop Shipment"; rec."Drop Shipment")
                {
                    ApplicationArea = all;
                    caption = 'Livraison directe';
                    Visible = false;
                }
                field("Applied Entry to Adjust"; rec."Applied Entry to Adjust")
                {
                    ApplicationArea = all;
                    caption = 'Ecriture lettrée à ajuster';
                    Visible = false;
                }
                field("Prod. Order No."; rec."Prod. Order No.")
                {
                    ApplicationArea = all;
                    caption = 'N° ordre de fabrication';
                    Visible = false;
                }
                field("Prod. Order Line No."; rec."Prod. Order Line No.")
                {
                    ApplicationArea = all;
                    caption = 'N° ligne O.F.';
                    Visible = false;
                }
                field("Prod. Order Comp. Line No."; rec."Prod. Order Comp. Line No.")
                {
                    ApplicationArea = all;
                    caption = 'N° ligne composant O.F.';
                    Visible = false;
                }

                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                    caption = 'N° affaire';
                    Visible = false;
                }
                field("Job Task No."; rec."Job Task No.")
                {
                    ApplicationArea = all;
                    caption = 'N° tâche affaire';
                    Visible = false;
                }
            }
        }

    }

    actions
    {
        // area(navigation)
        // {
        // group("Ent&ry")
        // {
        //     Caption = 'Ent&ry';
        // action(Dimensions)
        // {
        //     Caption = 'Dimensions';
        //     Image = Dimensions;
        //     RunpageLink = "Table ID"=CONST(32),"Entry No."=FIELD("Entry No.");
        //     RunObject = Page 544;
        //                     ShortCutKey = 'Maj+Ctrl+D';
        // }
        // action("&Value Entries")
        // {
        //     Caption = '&Value Entries';
        //     Image = ValueLedger;
        //     RunpageLink = "Item Ledger Entry No."=FIELD("Entry No.");
        //     RunpageView = SORTING("Item Ledger Entry No.");
        //     RunObject = Page 5802;
        //                     ShortCutKey = 'Ctrl+F7';
        // }
        // }
        // group("&Application")
        // {
        //     Caption = '&Application';
        // action("Applied E&ntries")
        // {
        //     Caption = 'Applied E&ntries';

        //     trigger OnAction()
        //     begin
        //         CODEUNIT.RUN(CODEUNIT::"Show Applied Entries",Rec);
        //     end;
        // }
        // action("Reservation Entries")
        // {
        //     Caption = 'Reservation Entries';
        //     Image = ReservationLedger;

        //     trigger OnAction()
        //     begin
        //         rec.ShowReservationEntries(TRUE);
        //     end;
        // }
        // action("Application Worksheet")
        // {
        //     Caption = 'Application Worksheet';

        //     trigger OnAction()
        //     var
        //         Worksheet: page 521;
        //     begin
        //         CLEAR(Worksheet);
        //         Worksheet.SetRecordToShow(Rec);
        //         Worksheet.RUN();
        //     end;
        // }
        //     }
        // }
        // area(processing)
        // {
        //     group("F&unctions")
        //     {
        //         Caption = 'F&unctions';
        // action("Order &Tracking")
        // {
        //     Caption = 'Order &Tracking';

        //     trigger OnAction()
        //     var
        //         TrackingForm: page 99000822;
        //     begin
        //         TrackingForm.SetItemLedgEntry(Rec);
        //         TrackingForm.RUNMODAL;
        //     end;
        // }
        // }
        // action("&Navigate")
        // {
        //     Caption = '&Navigate';
        //     Image = Navigate;
        //     Promoted = true;
        //     PromotedCategory = Process;

        //     trigger OnAction()
        //     begin
        //         Navigate.SetDoc(rec."Posting Date",rec."Document No.");
        //         Navigate.RUN;
        //     end;
        // }
        // }
    }

    var
        Navigate: page 344;


    procedure GetCaption(): Text[250]
    var
        GLSetup: Record 98;
        ObjTransl: Record 377;
        Item: Record 27;
        ProdOrder: Record 5405;
        Cust: Record 18;
        Vend: Record 23;
        Dimension: Record 348;
        DimValue: Record 349;
        SourceTableName: Text[100];
        SourceFilter: Text[200];
        Description: Text[100];
    begin
        Description := '';

        CASE TRUE OF
            rec.GETFILTER("Item No.") <> '':
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);
                    SourceFilter := rec.GETFILTER("Item No.");
                    IF MAXSTRLEN(Item."No.") >= STRLEN(SourceFilter) THEN
                        IF Item.GET(SourceFilter) THEN
                            Description := Item.Description;
                END;
            // rec.GETFILTER("Prod. Order No.") <> '':
            //     BEGIN
            //         SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 5405);
            //         SourceFilter := rec.GETFILTER("Prod. Order No.");
            //         IF MAXSTRLEN(ProdOrder."No.") >= STRLEN(SourceFilter) THEN
            //             IF ProdOrder.GET(ProdOrder.Status::Released, SourceFilter) OR
            //                ProdOrder.GET(ProdOrder.Status::Finished, SourceFilter)
            //             THEN BEGIN
            //                 SourceTableName := STRSUBSTNO('%1 %2', ProdOrder.Status, SourceTableName);
            //                 Description := ProdOrder.Description;
            //             END;
            //     END;
            rec.GETFILTER("Source No.") <> '':
                BEGIN
                    CASE rec."Source Type" OF
                        rec."Source Type"::Customer:
                            BEGIN
                                SourceTableName :=
                                  ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 18);
                                SourceFilter := rec.GETFILTER("Source No.");
                                IF MAXSTRLEN(Cust."No.") >= STRLEN(SourceFilter) THEN
                                    IF Cust.GET(SourceFilter) THEN
                                        Description := Cust.Name;
                            END;
                        rec."Source Type"::Vendor:
                            BEGIN
                                SourceTableName :=
                                  ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 23);
                                SourceFilter := rec.GETFILTER("Source No.");
                                IF MAXSTRLEN(Vend."No.") >= STRLEN(SourceFilter) THEN
                                    IF Vend.GET(SourceFilter) THEN
                                        Description := Vend.Name;
                            END;
                    END;
                END;
            rec.GETFILTER("Global Dimension 1 Code") <> '':
                BEGIN
                    GLSetup.GET;
                    Dimension.Code := GLSetup."Global Dimension 1 Code";
                    SourceFilter := rec.GETFILTER("Global Dimension 1 Code");
                    SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
                    IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                        IF DimValue.GET(GLSetup."Global Dimension 1 Code", SourceFilter) THEN
                            Description := DimValue.Name;
                END;
            rec.GETFILTER("Global Dimension 2 Code") <> '':
                BEGIN
                    GLSetup.GET;
                    Dimension.Code := GLSetup."Global Dimension 2 Code";
                    SourceFilter := rec.GETFILTER("Global Dimension 2 Code");
                    SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
                    IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                        IF DimValue.GET(GLSetup."Global Dimension 2 Code", SourceFilter) THEN
                            Description := DimValue.Name;
                END;
            rec.GETFILTER("Document Type") <> '':
                BEGIN
                    SourceTableName := rec.GETFILTER("Document Type");
                    SourceFilter := rec.GETFILTER("Document No.");
                    Description := rec.GETFILTER("Document Line No.");
                END;
        END;
        EXIT(STRSUBSTNO('%1 %2 %3', SourceTableName, SourceFilter, Description));
    end;
}

