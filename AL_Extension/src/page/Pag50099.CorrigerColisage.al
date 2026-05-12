page 50099 "Corriger Colisage"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            field(Article; Article)
            {
                Caption = 'Article';
                TableRelation = Item;
            }
            field(Colisage; Colisage)
            {
                Caption = 'Colisage';
            }
            field(Unite; Unite)
            {
                Caption = 'UNITE ACHAT';
                TableRelation = "Unit of Measure";
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Ok)
            {
                Caption = 'Ok';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF Article = '' THEN ERROR(Text001);
                    IF Unite = '' THEN ERROR(Text001);
                    IF Colisage = 0 THEN ERROR(Text001);
                    IF NOT CONFIRM(Text002) THEN EXIT;
                    ItemLedegerEntry.SETRANGE("Item No.", Article);
                    IF ItemLedegerEntry.FINDFIRST THEN
                        REPEAT
                            ItemLedegerEntry.Quantity := ItemLedegerEntry.Quantity * Colisage;
                            ItemLedegerEntry."Remaining Quantity" := ItemLedegerEntry."Remaining Quantity" * Colisage;
                            ItemLedegerEntry."Invoiced Quantity" := ItemLedegerEntry."Invoiced Quantity" * Colisage;
                            ItemLedegerEntry."Qty. per Unit of Measure" := Colisage;
                            ItemLedegerEntry."Unit of Measure Code" := Unite;
                            ItemLedegerEntry.MODIFY;

                        UNTIL ItemLedegerEntry.NEXT = 0;

                    ValueEntry.SETRANGE("Item No.", Article);
                    IF ValueEntry.FINDFIRST THEN
                        REPEAT
                            ValueEntry."Item Ledger Entry Quantity" := ValueEntry."Item Ledger Entry Quantity" * Colisage;
                            ValueEntry."Valued Quantity" := ValueEntry."Valued Quantity" * Colisage;
                            ValueEntry."Invoiced Quantity" := ValueEntry."Invoiced Quantity" * Colisage;
                            ValueEntry."Cost per Unit" := ValueEntry."Cost per Unit" / Colisage;
                            IF Item.GET(ValueEntry."Item No.") THEN BEGIN
                                IF ValueEntry."Cost per Unit" <> 0 THEN BEGIN
                                    Item."Unit Cost" := ValueEntry."Cost per Unit";
                                    Item."Last Direct Cost" := ValueEntry."Cost per Unit";
                                    Item.MODIFY;
                                END;
                            END;
                            ValueEntry.MODIFY;

                        UNTIL ValueEntry.NEXT = 0;
                    MESSAGE(Text003);
                end;
            }
        }
    }

    var
        Article: Code[20];
        Colisage: Decimal;
        ItemLedegerEntry: Record 32;
        ValueEntry: Record 5802;
        Unite: Code[20];
        Text001: Label 'Attention Remplir Tous Les Champs';
        Item: Record 27;
        Text002: Label 'Lancer Cette Action ?';
        Text003: Label 'Action Achevée Avec Succée';
}

