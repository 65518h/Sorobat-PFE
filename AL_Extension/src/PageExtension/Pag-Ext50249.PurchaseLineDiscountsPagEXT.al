PageExtension 50249 "Purchase Line Discounts_PagEXT" extends "Purchase Line Discounts"
{
    DataCaptionExpression = GetCaption2();
    layout
    {

        modify(VendNoFilterCtrl)
        {
            Visible = false;
        }

        modify(ItemNoFilterCtrl)
        {
            Visible = false;
        }

        modify("Vendor No.")
        {
            Editable = "Vendor No.EDITABLE";
        }
        modify(StartingDateFilter)
        {
            Visible = false;
        }


        addbefore(StartingDateFilter)
        {
            field("Filtre type achat"; wPurchTypeFilter)
            {
                ApplicationArea = all;
                Caption = 'Purchases Type Filter';
                OptionCaption = 'Vendor,Vendor Discount Group,All Vendors,None';

                trigger OnValidate()
                begin

                    //+OFF+REMISE
                    CurrPage.SaveRecord;
                    wPurchCodeFilter := '';
                    SetRecFilters2;
                    //+OFF+REMISE//
                end;
            }
            field("Filtre type"; wItemTypeFilter)
            {
                ApplicationArea = all;
                Caption = 'Type Filter';
                OptionCaption = 'Item,Item Discount Group,None';

                trigger OnValidate()
                begin

                    //+OFF+REMISE
                    CurrPage.SaveRecord;
                    wCodeFilter := '';
                    SetRecFilters2;
                    //+OFF+REMISE//
                end;
            }



            field("Filtre code achat"; wPurchCodeFilter)
            {
                Enabled = PurchCodeFilterCtrlENABLED;
                ApplicationArea = all;
                Caption = 'Purchases Code Filter';

                trigger OnValidate()
                begin
                    VendNoFilterOnAfterValidate2();
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                //DYS Page Addon non migrer
                // lVendDiscGrList: Page 8004094;
                //VendList: Page 27;
                begin


                    //+OFF+REMISE
                    /*{*** Original Code
                    VendList.LOOKUPMODE := TRUE;
                                        IF VendList.RUNMODAL = ACTION::LookupOK THEN
                                            Text := VendList.GetSelectionFilter
                                        ELSE
                                            EXIT(FALSE);

                                        EXIT(TRUE);
                    }*/
                    //DYS
                    // IF wPurchTypeFilter = wPurchTypeFilter::"All Vendors" THEN EXIT;
                    //DYS
                    // CASE wPurchTypeFilter OF
                    //     wPurchTypeFilter::Vendor:
                    //         BEGIN
                    //             VendList.LOOKUPMODE := TRUE;
                    //             IF VendList.RUNMODAL = ACTION::LookupOK THEN
                    //                 Text := VendList.GetSelectionFilter
                    //             ELSE
                    //                 EXIT(FALSE);
                    //         END;
                    //DYS
                    // wPurchTypeFilter::"Vendor Discount Group":
                    //     BEGIN
                    //         lVendDiscGrList.LOOKUPMODE := TRUE;
                    //         IF lVendDiscGrList.RUNMODAL = ACTION::LookupOK THEN
                    //             Text := lVendDiscGrList.GetSelectionFilter
                    //         ELSE
                    //             EXIT(FALSE);
                    //     END;
                    //END;

                    EXIT(TRUE);
                    //+OFF+REMISE//
                end;
            }

            field("Filtre code"; wCodeFilter)
            {
                ApplicationArea = all;
                Caption = 'Code Filter';
                Enabled = CodeFilterCtrlENABLED;

                trigger OnValidate()
                begin
                    ItemNoFilterOnAfterValidate2();
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    lItemDiscGrList: Page "Item Disc. Groups";
                    ItemList: Page "Item List";
                begin

                    CASE rec.Type OF
                        rec.Type::Item:
                            BEGIN
                                ItemList.LOOKUPMODE := TRUE;
                                IF ItemList.RUNMODAL = ACTION::LookupOK THEN
                                    Text := ItemList.GetSelectionFilter
                                ELSE
                                    EXIT(FALSE);
                            END;
                        rec.Type::"Item Disc. Group":
                            BEGIN
                                lItemDiscGrList.LOOKUPMODE := TRUE;
                                IF lItemDiscGrList.RUNMODAL = ACTION::LookupOK THEN
                                    Text := lItemDiscGrList.GetSelectionFilter
                                ELSE
                                    EXIT(FALSE);
                            END;
                    END;
                    EXIT(TRUE);
                end;



            }

            field(StartingDateFilter2; StartingDateFilter)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Starting Date Filter';
                ToolTip = 'Specifies a filter for which purchase line discounts to display.';

                trigger OnValidate()
                var
                    FilterTokens: Codeunit "Filter Tokens";
                begin
                    FilterTokens.MakeDateFilter(StartingDateFilter);
                    StartingDateFilterOnAfterValid2();
                end;
            }

            group(Options)
            {
                Caption = 'Options';
                field("Filtre code devise"; wCurrencyCodeFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Currency Code Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CurrencyList: Page Currencies;
                    begin

                        //+OFF+REMISE
                        CurrencyList.LookupMode := true;
                        if CurrencyList.RunModal = Action::LookupOK then
                            Text := CurrencyList.GetSelectionFilter
                        else
                            exit(false);

                        exit(true);
                        //+OFF+REMISE//
                    end;

                    trigger OnValidate()
                    begin

                        //+OFF+REMISE
                        CurrPage.SaveRecord;
                        SetRecFilters2;
                        //+OFF+REMISE//
                    end;
                }
            }
        }














        addafter("Vendor No.")
        {
            field("Purchase Type"; rec."Purchase Type")
            {
                ApplicationArea = all;
            }
        }
        addafter("Currency Code")
        {
            field(Type; rec.Type)
            {
                ApplicationArea = all;
            }
        }
        addafter("Minimum Quantity")
        {
            field("Discount 1 %"; rec."Discount 1 %")
            {
                ApplicationArea = all;
            }
            field("Discount 2 %"; rec."Discount 2 %")
            {
                ApplicationArea = all;
            }
            field("Discount 3 %"; rec."Discount 3 %")
            {
                ApplicationArea = all;
            }
        }
    }

    trigger OnOpenPage()
    begin

        //+OFF+REMISE
        GetRecFilters2;
        SetRecFilters2;
        //+OFF+REMISE//
    end;

    trigger OnAfterGetRecord()
    begin

        //+OFF+REMISE
        "Vendor No.EDITABLE" := (rec."Purchase Type" <> rec."Purchase Type"::"All Vendors");
        //+OFF+REMISE//
    end;



    local procedure GetRecFilters2()
    begin

        wPurchTypeFilter := wPurchTypeFilter::None;
        wItemTypeFilter := wItemTypeFilter::None;
        wPurchCodeFilter := '';
        wCodeFilter := '';
        StartingDateFilter := '';

        IF rec.GETFILTERS <> '' THEN BEGIN
            IF rec.GETFILTER("Purchase Type") <> '' THEN BEGIN
                IF rec.FIND('-') THEN;
                wPurchTypeFilter := rec."Purchase Type";
            END
            ELSE
                wPurchTypeFilter := wPurchTypeFilter::None;

            IF rec.GETFILTER(Type) <> '' THEN BEGIN
                IF rec.FIND('-') THEN;
                wItemTypeFilter := rec.Type;
            END
            ELSE
                wItemTypeFilter := wItemTypeFilter::None;

            wPurchCodeFilter := rec.GETFILTER("Vendor No.");
            wCodeFilter := rec.GETFILTER("Item No.");
            wCurrencyCodeFilter := rec.GETFILTER("Currency Code");
            EVALUATE(StartingDateFilter, rec.GETFILTER("Starting Date"));
        END;

        //+OFF+REMISE//
    end;



    procedure SetRecFilters2()
    begin

        PurchCodeFilterCtrlENABLED := (TRUE);
        CodeFilterCtrlENABLED := (TRUE);

        IF wPurchTypeFilter <> wPurchTypeFilter::None THEN
            rec.SETRANGE("Purchase Type", wPurchTypeFilter)
        ELSE
            rec.SETRANGE("Purchase Type");

        IF wPurchTypeFilter IN [wPurchTypeFilter::"All Vendors", wPurchTypeFilter::None] THEN BEGIN
            PurchCodeFilterCtrlENABLED := (FALSE);
            wPurchCodeFilter := '';
        END;

        IF wPurchCodeFilter <> '' THEN
            rec.SETFILTER("Vendor No.", wPurchCodeFilter)
        ELSE
            rec.SETRANGE("Vendor No.");

        IF wItemTypeFilter <> wItemTypeFilter::None THEN
            rec.SETRANGE(Type, wItemTypeFilter)
        ELSE
            rec.SETRANGE(Type);

        IF wItemTypeFilter = wItemTypeFilter::None THEN BEGIN
            CodeFilterCtrlENABLED := (FALSE);
            wCodeFilter := '';
        END;

        IF wCodeFilter <> '' THEN BEGIN
            rec.SETFILTER("Item No.", wCodeFilter);
        END ELSE
            rec.SETRANGE("Item No.");

        IF wCurrencyCodeFilter <> '' THEN BEGIN
            rec.SETFILTER("Currency Code", wCurrencyCodeFilter);
        END ELSE
            rec.SETRANGE("Currency Code");

        IF StartingDateFilter <> '' THEN
            rec.SETFILTER("Starting Date", StartingDateFilter)
        ELSE
            rec.SETRANGE("Starting Date");
        //+OFF+REMISE//

        CurrPage.UPDATE(FALSE);
    end;


    procedure GetCaption2(): Text[250]
    var
        Vendor: Record Vendor;
        ObjTransl: Record "Object Translation";
        SourceTableName: Text[250];
        Description: Text[250];
        lPurchSrcTableName: Text[100];
    begin

        //GetRecFilters;
        /* GL2024 CurrPage.PurchCodeFilterCtrl.UPDATE;
          CurrPage.CodeFilterCtrl.UPDATE;*/

        IF rec."Purchase Type" = rec."Purchase Type"::"All Vendors" THEN
            "Vendor No.EDITABLE" := FALSE
        ELSE
            "Vendor No.EDITABLE" := TRUE;

        SourceTableName := '';
        CASE wItemTypeFilter OF
            wItemTypeFilter::Item:
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);
                    wItem."No." := wCodeFilter;
                END;
            wItemTypeFilter::"Item Discount Group":
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 341);
                    wItemDiscGr.Code := wCodeFilter;
                END;
        END;

        lPurchSrcTableName := '';
        CASE wPurchTypeFilter OF
            wPurchTypeFilter::Vendor:
                BEGIN
                    lPurchSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 23);
                    Vend."No." := wPurchCodeFilter;
                    IF Vend.FIND THEN
                        Description := Vend.Name;
                END;
            wPurchTypeFilter::"Vendor Discount Group":
                BEGIN
                    lPurchSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 8004091);
                    wVendDiscGroup.Code := wPurchCodeFilter;
                    IF wVendDiscGroup.FIND THEN
                        Description := wVendDiscGroup.Description;
                END;
            wPurchTypeFilter::"All Vendors":
                BEGIN
                    lPurchSrcTableName := Text8004090;
                    Description := '';
                END;
        END;

        IF lPurchSrcTableName = Text8004090 THEN
            EXIT(STRSUBSTNO('%1 %2 %3 %4 %5', lPurchSrcTableName, wPurchCodeFilter, Description, SourceTableName, wPurchCodeFilter));
        EXIT(STRSUBSTNO('%1 %2 %3 %4 %5', lPurchSrcTableName, wPurchCodeFilter, Description, SourceTableName, wPurchCodeFilter));
        //+OFF+REMISE//

    end;





    local procedure ItemNoFilterOnAfterValidate2()
    begin
        CurrPage.SaveRecord();
        SetRecFilters2();
    end;

    local procedure VendNoFilterOnAfterValidate2()
    begin
        CurrPage.SaveRecord();
        SetRecFilters2();
    end;

    local procedure StartingDateFilterOnAfterValid2()
    begin
        CurrPage.SaveRecord();
        SetRecFilters2();
    end;



    var
        wVendDiscGroup: Record "Vendor Discount Group";
        wItem: Record Item;
        wItemDiscGr: Record "Item Discount Group";
        wPurchTypeFilter: Option Vendor,"Vendor Discount Group","All Vendors","None";
        wPurchCodeFilter: Text[250];
        wItemTypeFilter: Option Item,"Item Discount Group","None";
        wCodeFilter: Text[250];
        wCurrencyCodeFilter: Text[250];
        Text8004090: label 'All Vendors';
        Vend: Record Vendor;
        StartingDateFilter: Text[30];
        "Vendor No.EDITABLE": Boolean;
        PurchCodeFilterCtrlENABLED: Boolean;
        CodeFilterCtrlENABLED: Boolean;

}

