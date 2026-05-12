PageExtension 50031 "Sales Order Subform_PagEXT" extends "Sales Order Subform"
{
    /* GL2024 SourceTableView=SORTING(Document Type,Document No.,Line No.) 
                        WHERE(Document Type=FILTER(Order));*/


    layout
    {
        // modify("No.")
        // {
        //     trigger OnLookup(var Text: Text): Boolean
        //     var
        //         PageItelLookup: Page "Item Lookup";
        //         RecStandardText: Record "Standard Text";
        //         RecGLAccount: Record "G/L Account";
        //         RecResource: Record Resource;
        //         RecFixedAsset: Record "Fixed Asset";
        //         RecItemCharge: Record "Item Charge";
        //         RecAllocationAccount: Record "Allocation Account";
        //         RecItem: Record Item;
        //     begin
        //         if Rec.Type = Rec.Type::"Allocation Account" then begin
        //             if RecAllocationAccount.FindSet() then begin
        //                 if PAGE.RunModal(PAGE::"Allocation Account List", RecAllocationAccount) = ACTION::LookupOK then begin
        //                     Rec.Validate("No.", RecAllocationAccount."No.");
        //                 end;
        //             end;
        //         end;
        //         if Rec.Type = Rec.Type::"Charge (Item)" then begin
        //             if RecItemCharge.FindSet() then begin
        //                 if PAGE.RunModal(PAGE::"Item Charges", RecItemCharge) = ACTION::LookupOK then begin
        //                     Rec.Validate("No.", RecItemCharge."No.");
        //                 end;
        //             end;
        //         end;
        //         if Rec.Type = Rec.Type::"Fixed Asset" then begin
        //             if RecFixedAsset.FindSet() then begin
        //                 if PAGE.RunModal(PAGE::"Resource List", RecFixedAsset) = ACTION::LookupOK then begin
        //                     Rec.Validate("No.", RecFixedAsset."No.");
        //                 end;
        //             end;
        //         end;
        //         if Rec.Type = Rec.Type::Resource then begin
        //             if RecResource.FindSet() then begin
        //                 if PAGE.RunModal(PAGE::"Resource List", RecResource) = ACTION::LookupOK then begin
        //                     Rec.Validate("No.", RecResource."No.");
        //                 end;
        //             end;
        //         end;
        //         if Rec.Type = Rec.Type::Item then begin
        //             RecItem.Reset();
        //             RecItem.SetRange(Type, Rec."Type article");
        //             if RecItem.FindSet() then begin
        //                 if PAGE.RunModal(PAGE::"Item Lookup", RecItem) = ACTION::LookupOK then begin
        //                     Rec.Validate("No.", RecItem."No.");
        //                 end;
        //             end;
        //         end;
        //         if Rec.Type = Rec.Type::" " then begin
        //             if PAGE.RunModal(PAGE::"Standard Text Codes", RecStandardText) = ACTION::LookupOK then begin
        //                 Rec.Validate("No.", RecStandardText."code");
        //             end;
        //         end;
        //         if Rec.Type = Rec.Type::"G/L Account" then begin
        //             RecGLAccount.Reset();
        //             RecGLAccount.SetRange("Account Type", RecGLAccount."Account Type"::Posting);
        //             RecGLAccount.SetRange(Blocked, false);
        //             RecGLAccount.SetRange("Direct Posting", true);
        //             if RecGLAccount.FindSet() then begin
        //                 if PAGE.RunModal(PAGE::"G/L Account List", RecGLAccount) = ACTION::LookupOK then begin
        //                     Rec.Validate("No.", RecGLAccount."No.");
        //                 end;
        //             end;
        //         end;
        //     end;
        // }
        addbefore("No.")
        {
            field("Type article"; Rec."Type article") { ApplicationArea = all; Visible = false; }

        }
        addafter("No.")
        {
            field("Appliquer BIC"; Rec."Appliquer BIC") { ApplicationArea = all; }

        }


        addafter("Item Reference No.")
        {
            field("Job No."; rec."Job No.")
            {
                ApplicationArea = all;
                visible = false;

            }
            field("User ID"; rec."User ID")
            {
                ApplicationArea = all;
                visible = false;
            }
            field("Date Comptabilisation"; rec."Date Comptabilisation")
            {
                ApplicationArea = all;
                visible = false;
            }
        }
        addafter("Substitution Available")
        {
            field("Vendor No."; rec."Vendor No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        modify(Description)
        {
            trigger OnAssistEdit()
            begin


                //+REF+MEMOPAD
                Currpage.SAVERECORD;
                IF rec.fMemoPad THEN
                    Currpage.UPDATE;
                //+REF+MEMOPAD//
            end;

            // trigger OnAfterValidate()
            // begin

            // //     IF RecUserSetup.GET(UPPERCASE(USERID)) THEN
            // //         //  IF RecUserSetup."Chang Descrip Interdit" THEN ERROR(Text005);

            // //         //IF (Type=Type::"Charge (Item)")  THEN
            // //         //  BEGIN
            // //         //    IF RecUserSetup.GET(UPPERCASE(USERID)) THEN
            // //         //      IF RecUserSetup."Chang Descrip Interdit" THEN ERROR(Text005);
            // //         //  END;
            // //         IF (rec.Type = rec.Type::Item) THEN BEGIN
            // //             IF (rec."No." <> '3000010000001') AND (rec."No." <> 'IMM') AND (rec."Type article" <> rec."Type article"::Service) THEN
            // //                 ERROR(Text005);
            // //         END;
            // // end;
        }
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        addafter("Bin Code")
        {
            field("Need Qty"; rec."Need Qty")
            {
                Visible = false;
                ApplicationArea = all;

                trigger OnDrillDown()
                var
                    lSalesLine: Record "Sales Line";
                begin

                    lSalesLine.SetCurrentkey("Document Type", "Supply Order No.", "Supply Order Line No.");
                    lSalesLine.SetRange("Document Type", rec."document type"::Order);
                    lSalesLine.SetRange("Supply Order No.", rec."Document No.");
                    lSalesLine.SetRange("Supply Order Line No.", rec."Line No.");
                    Page.RunModal(0, lSalesLine, lSalesLine."Need Qty");
                    CurrPage.Update;
                end;
            }
        }
        addafter("Unit Cost (LCY)")
        {
            field("Lot No."; rec."Lot No.")
            {
                ApplicationArea = all;
                Visible = false;

                trigger OnAssistEdit()
                begin

                    //+REF+LOT
                    CurrPage.Update(true);
                    Commit;
                    gLookUp := true;
                    Clear(gReserveSalesLine);
                    rec.TestField(Type, rec.Type::Item);
                    rec.TestField("No.");
                    rec.TestField("Quantity (Base)");

                    CduFunction.fCallItemTracking(Rec, 0, 1, rec."Expiration Date");

                    CurrPage.Update;
                    //+REF+LOT//
                end;

                trigger OnValidate()
                begin

                    //+REF+LOT
                    if not gLookUp then begin
                        CurrPage.Update(true);
                        Commit;
                        if rec."Lot No." = '' then begin
                            Clear(gReserveSalesLine);
                            rec.TestField(Type, rec.Type::Item);
                            rec.TestField("No.");
                            rec.TestField("Quantity (Base)");
                            CduFunction.fCallItemTracking(Rec, 1, 1, rec."Expiration Date");
                        end
                        else begin
                            Clear(gReserveSalesLine);
                            rec.TestField(Type, rec.Type::Item);
                            rec.TestField("No.");
                            rec.TestField("Quantity (Base)");

                            CduFunction.fCallItemTracking(Rec, 2, 1, rec."Expiration Date");
                        end;
                        rec.Find('=');
                    end;
                    //+REF+LOT//

                    //+REF+LOT
                    CurrPage.Update(false);
                    //+REF+LOT//
                end;
            }
        }
        addafter(SalesPriceExist)
        {
            field("Expiration Date"; rec."Expiration Date")
            {
                ApplicationArea = all;
                Visible = false;

                trigger OnValidate()
                begin

                    //+REF+LOT
                    rec.TestField("Lot No.");
                    Clear(gReserveSalesLine);
                    rec.TestField(Type, rec.Type::Item);
                    rec.TestField("No.");
                    rec.TestField("Quantity (Base)");

                    CduFunction.fCallItemTracking(Rec, 3, 1, rec."Expiration Date");
                    rec.Find('=');
                    //+REF+LOT//
                end;
            }
        }
        addafter("Unit Price")
        {
            field("Serial No."; rec."Serial No.")
            {
                ApplicationArea = all;
                Visible = false;

                trigger OnAssistEdit()
                begin

                    //+REF+LOT
                    gLookUp := true;
                    Clear(gReserveSalesLine);
                    rec.TestField(Type, rec.Type::Item);
                    rec.TestField("No.");
                    rec.TestField("Quantity (Base)");

                    CduFunction.fCallItemTracking(Rec, 0, 0, rec."Expiration Date");

                    CurrPage.Update;
                    //+REF+LOT//
                end;

                trigger OnValidate()
                begin

                    //+REF+LOT
                    if not gLookUp then begin
                        if rec."Serial No." = '' then begin
                            Clear(gReserveSalesLine);
                            rec.TestField(Type, rec.Type::Item);
                            rec.TestField("No.");
                            rec.TestField("Quantity (Base)");

                            CduFunction.fCallItemTracking(Rec, 1, 0, rec."Expiration Date");
                        end
                        else begin
                            Clear(gReserveSalesLine);
                            rec.TestField(Type, rec.Type::Item);
                            rec.TestField("No.");
                            rec.TestField("Quantity (Base)");

                            CduFunction.fCallItemTracking(Rec, 2, 0, rec."Expiration Date");
                        end;
                        rec.Find('=');
                    end;
                    //+REF+LOT//

                    //+REF+LOT
                    CurrPage.Update(false);
                    //+REF+LOT//
                end;
            }
        }
        addafter("Shipping Time")
        {
            field("Purch. Order Qty (Base)"; rec."Purch. Order Qty (Base)")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Purch. Order Receipt Date"; rec."Purch. Order Receipt Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Purch. Order Rcpt. Qty (Base)"; rec."Purch. Order Rcpt. Qty (Base)")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter(ShortcutDimCode7)
        {
            field("Subscription Starting Date"; rec."Subscription Starting Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Subscription End Date"; rec."Subscription End Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Document No.")
        {
            field(Provenance; rec.Provenance)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Destination; rec.Destination)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Heure; rec.Heure)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Vehicule; rec.Vehicule)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Chauffeur; rec.Chauffeur)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Unit Cost (LCY)1"; rec."Unit Cost (LCY)")
            {

            }
            field("Total Cost (LCY)"; rec."Total Cost (LCY)")
            {
                ApplicationArea = all;
            }
            field("Fixed Price"; Rec."Fixed Price")
            {
                ApplicationArea = all;
            }

        }
    }

    var
        gReserveSalesLine: Codeunit "Sales Line-Reserve";
        gLookUp: Boolean;
        CduFunction: Codeunit SoroubatFucntion;
        RecUserSetup: Record "User Setup";
        Text005: Label 'Impossible de modifier la description.';

    trigger OnAfterGetCurrRecord()
    begin
        //+REF+LOT
        gLookUp := FALSE;
        //+REF+LOT//
    end;

    procedure wExplodeLine()
    var
        lSalesLine: Record "Sales Line";
    //DYS REPORT addon non migrer
    //lExplodeLine: Report 8003959;
    begin
        lSalesLine.SetRange("Document Type", rec."Document Type");
        lSalesLine.SetRange("Document No.", rec."Document No.");
        lSalesLine.SetRange("Line No.", rec."Line No.");
        // lExplodeLine.PasseLigne(Rec);
        // lExplodeLine.SetTableview(lSalesLine);
        // lExplodeLine.RunModal;
    end;

    procedure wShowDescription()
    var
        lDescription: Record "Description Line";
    begin
        //OUVRAGE
        rec.TestField("Line No.");
        lDescription.ShowDescription(37, rec."Document Type", rec."Document No.", rec."Line No.");
        //OUVRAGE//
    end;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(0);
        rec.SetCurrentKey("Document Type", "Document No.", "Line No.");
        Rec.FilterGroup(2);

    end;
}

