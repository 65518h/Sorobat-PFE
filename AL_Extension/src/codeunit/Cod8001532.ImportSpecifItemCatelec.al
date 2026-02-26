Codeunit 8001532 "Import Specif Item Catelec"
{
    //GL2024  ID dans Nav 2009 : "8003900"
    // //IMPORT_CUSTOM CW 21/07/03 Import CATELEC

    TableNo = "Nonstock Item";

    trigger OnRun()
    var
        lRec: Record "Nonstock Item";
        lItemCategory: Record "Item Category";
        lItemDiscountGroup: Record "Item Discount Group";
    begin
        lRec.SetCurrentkey("Item No.");
        lRec.SetRange("Item No.", rec."Item No.");
        if lRec.Find('-') then
            rec."Entry No." := lRec."Entry No.";

        if not lItemCategory.Get(rec."Item Templ. Code") then
            rec."Item Templ. Code" := rec."Manufacturer Code" + rec."Item Templ. Code";
        /* Champ à ajouter préalablement
        IF NOT lItemDiscountGroup.GET("Item Discount Group") THEN
          "Item Discount Group" := "Manufacturer Code" + "Item Discount Group";
        */

    end;
}

