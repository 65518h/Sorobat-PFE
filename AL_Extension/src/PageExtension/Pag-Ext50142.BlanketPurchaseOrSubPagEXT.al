PageExtension 50142 "Blanket Purchase Or Sub_PagEXT" extends "Blanket Purchase Order Subform"
{

    layout
    {
        modify("No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            VAR
                lLookup: Codeunit Lookup;
                lRecordRef: RecordRef;
                lMultiple: Boolean;
            begin

                //MULTIPLE
                IF rec.Type = rec.Type::Item THEN BEGIN
                    lRecordRef.OPEN(DATABASE::Item);
                    IF rec.wLookUpNo(Rec, lRecordRef, lMultiple, xRec) THEN
                        IF NOT lMultiple THEN
                            InsertExtendedText(FALSE)
                        ELSE
                            IF rec."Line No." = 0 THEN
                                wMult := TRUE;
                    lRecordRef.CLOSE;
                END ELSE
                    lLookup.PurchLineNo(Rec);
                //MULTIPLE//
            end;
        }

        modify(Description)
        {
            trigger OnAfterValidate()
            begin
                IF rec.Type = rec.Type::Item THEN ERROR(Text001);
            end;
        }

        modify("Direct Unit Cost")
        {
            Visible = false;
        }
        modify("Unit Cost (LCY)")
        {
            Visible = true;
        }

        addafter("Line Amount")
        {
            field("Discount 1 %"; Rec."Discount 1 %")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Discount 2 %"; Rec."Discount 2 %")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Discount 3 %"; Rec."Discount 3 %")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Quantité Sur Commande"; Rec."Quantité Sur Commande")
            {
                ApplicationArea = all;
            }
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = all;
            }
        }

        addafter("ShortcutDimCode[7]")
        {
            field("Work Type Code"; Rec."Work Type Code")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }
    }

    actions
    {

    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        //ACHATS
        rec.wInitLocationCode;
        //ACHATS//
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //MULTIPLE
        IF wMult THEN BEGIN
            wMult := FALSE;
            EXIT(FALSE);
        END;
        //MULTIPLE//
    end;

    PROCEDURE wShowDescription();
    VAR
        lDescription: Record "Description Line";
    BEGIN
        rec.TESTFIELD("Line No.");
        lDescription.ShowDescription(39, rec."Document Type", rec."Document No.", rec."Line No.");
    END;

    var
        wMult: Boolean;
        Text001: Label 'You cannot modify the designation';

}