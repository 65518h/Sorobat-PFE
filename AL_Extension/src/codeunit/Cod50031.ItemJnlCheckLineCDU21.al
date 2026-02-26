codeunit 50031 "Item Jnl.-Check Line_CDU21"
{
    //GL2024 Procédure spécifique de la codeunit standard "Item Jnl.-Check Line" 21

    PROCEDURE fCheckJob(pJobNo: Code[20]): Boolean;
    VAR
        lJob: Record Job;
    BEGIN
        IF lJob.GET(pJobNo) AND (lJob."Job Type" <> lJob."Job Type"::Stock) THEN
            EXIT(TRUE);
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeCheckEmptyQuantity', '', true, true)]
    local procedure OnBeforeCheckEmptyQuantity(ItemJnlLine: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Output then begin
            if (ItemJnlLine."Output Quantity (Base)" = 0) and (ItemJnlLine."Scrap Quantity (Base)" = 0) and
               ItemJnlLine.TimeIsEmpty() and (ItemJnlLine."Invoiced Qty. (Base)" = 0)
            then
                Error(ErrorInfo.Create(Text007, true))
        end else
            //      //#5020      IF ("Quantity (Base)" = 0) AND ("Invoiced Qty. (Base)" = 0) THEN
            //         IF ("Quantity (Base)" = 0) AND ("Invoiced Qty. (Base)" = 0) AND (ItemJnlLine."Job No." = '') THEN
            //   //#5020//
            if (ItemJnlLine."Quantity (Base)" = 0) and (ItemJnlLine."Invoiced Qty. (Base)" = 0) AND (ItemJnlLine."Job No." = '') then
                Error(ErrorInfo.Create(Text007, true));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnAfterCheckItemJnlLine', '', true, true)]
    local procedure OnAfterCheckItemJnlLine(var ItemJnlLine: Record "Item Journal Line"; CalledFromInvtPutawayPick: Boolean; CalledFromAdjustment: Boolean)
    var
        CDUItemJnlCheckLine_CDU21: Codeunit "Item Jnl.-Check Line_CDU21";
        lItem: Record Item;
        Text800: label 'article %1 est Générique, et ne peut donc être utilisé dans une Feuille de saisie';
    begin

        //#7110
        IF ItemJnlLine."Entry Type" IN [ItemJnlLine."Entry Type"::"Positive Adjmt.",
                                        ItemJnlLine."Entry Type"::"Negative Adjmt."] THEN
            IF lItem.GET(ItemJnlLine."Item No.") THEN
                IF lItem."Item Type" = lItem."Item Type"::Generic THEN
                    //#8391
                    IF NOT CDUItemJnlCheckLine_CDU21.fCheckJob(ItemJnlLine."Job No.") THEN
                        //#8391//
                        ERROR(Text800, FORMAT(ItemJnlLine."Item No."));
        //#7110//
    end;

    var
        Text007: Label 'You cannot post these lines because you have not entered a quantity on one or more of the lines. ';
}