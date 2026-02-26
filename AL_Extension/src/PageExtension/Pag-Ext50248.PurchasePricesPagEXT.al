PageExtension 50248 "Purchase Prices_PagEXT" extends "Purchase Prices"
{
    layout
    {
        modify("Vendor No.")
        {
            Editable = true;
        }

        modify(VendNoFilterCtrl)
        {
            trigger OnBeforeValidate()
            var
                lVendor: Record Vendor;
                VendList: Page "Vendor List";
            begin
                //SUBCONTRACTOR
                IF wSubcontracting THEN BEGIN
                    lVendor.SETRANGE(Subcontractor, TRUE);
                    VendList.SETTABLEVIEW(lVendor);
                END;
                //SUBCONTRACTOR//
            end;
        }
        modify(ItemNoFIlterCtrl)
        {
            trigger OnBeforeValidate()
            var
                ItemList: Page "Item List";

            begin

                //SUBCONTRACTOR
                IF wSubcontracting THEN BEGIN
                    lItem.SETFILTER(Subcontracting, '<>0');
                    ItemList.SETTABLEVIEW(lItem);
                END;
                //SUBCONTRACTOR//
            end;
        }


        addafter(StartingDateFilter)
        {
            field("Filtre n° ouvrage"; wResNoFilter)
            {
                ApplicationArea = all;
                Caption = 'Structure No. Filter';

                trigger OnLookup(var Text: Text): Boolean
                var
                    lResList: Page "Resource List";
                begin

                    //SUBCONTRACTOR
                    wRes.SetRange(Type, wRes.Type::Structure);
                    lResList.SetTableview(wRes);
                    lResList.LookupMode(true);
                    if lResList.RunModal = Action::LookupOK then begin
                        lResList.wSetSelectionFilter(wRes);
                        Text := wRes."No.";
                        exit(true);
                    end else
                        exit(false);
                    //SUBCONTRACTOR//
                end;

                trigger OnValidate()
                begin

                    //SUBCONTRACTOR
                    CurrPage.SaveRecord;
                    SetRecFilters;
                    //SUBCONTRACTOR//
                end;
            }
        }


        addafter("Vendor No.")
        {
            field("Nom fournisseur"; wVendorName)
            {
                ApplicationArea = all;
                Caption = 'Vendor Name';
                Editable = false;
            }
        }
        addafter("Item No.")
        {
            field("Référence fournisseur"; wVendorItemNo)
            {
                ApplicationArea = all;
                Caption = 'Vendor Item No.';

                trigger OnValidate()
                var
                    lxItemVendor: Record "Item Vendor";
                    lDistIntegration: Codeunit "Dist. Integration";
                    CduFunction: Codeunit SoroubatFucntion;
                begin

                    if not wItemVendor.Get(rec."Vendor No.", rec."Item No.", rec."Variant Code") then begin
                        wItemVendor."Vendor No." := rec."Vendor No.";
                        wItemVendor."Item No." := rec."Item No.";
                        wItemVendor."Variant Code" := rec."Variant Code";
                        wItemVendor."Vendor Item No." := wVendorItemNo;
                        wItemVendor.Insert(true);
                    end else
                        if (wVendorItemNo <> wItemVendor."Vendor Item No.") then begin
                            if wVendorItemNo <> '' then begin
                                if Confirm(tReplaceItemVendorNo, false, wItemVendor."Vendor Item No.") then begin
                                    lxItemVendor := wItemVendor;
                                    wItemVendor."Vendor Item No." := wVendorItemNo;
                                    wItemVendor.Modify(true);
                                    //DYS table Item cross reference obsolet
                                    // if CduFunction.CheckItemCrossRefLicense then
                                    //   lDistIntegration.UpdateItemCrossReference(wItemVendor, lxItemVendor);
                                end;
                            end else
                                if Confirm(tDeleteItemVendorNo, false, wItemVendor."Vendor Item No.") then
                                    wItemVendor.Delete(true);
                        end;
                end;
            }
            field("Nom article"; wItemName)
            {
                ApplicationArea = all;
                Caption = 'Item Name';
                Editable = false;
            }
            field("Resource No."; rec."Resource No.")
            {
                ApplicationArea = all;
                Visible = false;
            }

            // field("Job No."; rec."Job No.")
            // {
            //     ApplicationArea = all;
            //     Visible = false;
            // }
        }
        addafter("Ending Date")
        {
            field(Description; rec.Description)
            {
                ApplicationArea = all;
            }
        }
    }



    actions
    {




    }
    var
        lVendor: Record Vendor;
        lItem: Record Item;
        wRes: Record Resource;
        wResNoFilter: Code[30];
        wSubcontracting: Boolean;
        wVendorName: Text[50];
        wItemName: Text[110];
        wItem: Record Item;
        wItemVendor: Record "Item Vendor";
        wVendorItemNo: Text[20];
        tReplaceItemVendorNo: label 'Do you want to replace current Vendor Item No. %1?';
        tDeleteItemVendorNo: label 'Do you want to delete current Vendor Item No. %1?';
        Vend: Record Vendor;


    trigger OnAfterGetRecord()
    begin
        wVendorName := '';
        wItemName := '';
        wVendorItemNo := '';
        IF rec."Vendor No." <> '' THEN
            IF Vend.GET(rec."Vendor No.") THEN
                wVendorName := Vend.Name;
        IF rec."Item No." <> '' THEN
            IF wItem.GET(rec."Item No.") THEN
                wItemName := wItem.Description + ' ' + wItem."Description 2";
        IF (rec."Vendor No." <> '') AND (rec."Item No." <> '') THEN
            IF wItemVendor.GET(rec."Vendor No.", rec."Item No.", rec."Variant Code") THEN
                wVendorItemNo := wItemVendor."Vendor Item No.";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CLEAR(wVendorName);
        CLEAR(wItemName);
        CLEAR(wVendorItemNo);
    end;


    procedure wInitForm(pSubcontracting: Boolean)
    begin
        wSubcontracting := pSubcontracting;
    end;
}

