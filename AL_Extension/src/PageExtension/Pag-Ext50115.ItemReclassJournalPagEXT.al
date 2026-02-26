PageExtension 50115 "Item Reclass. Journal_PagEXT" extends "Item Reclass. Journal"
{
    layout
    {
        modify("Item No.")
        {
            trigger OnBeforeValidate()
            begin
                //   VerifStock();
            end;


        }

        addafter("Location Code")
        {
            field("Phys. Inv. Quantity"; Rec."Phys. Inv. Quantity")
            {
                ApplicationArea = all;
            }
        }
        modify("New Location Code")
        {
            Visible = true;
        }

        addafter("New Location Code")
        {
            field("Serial No."; Rec."Serial No.")
            {
                Visible = FALSE;
                ApplicationArea = all;
            }

            field("Lot No."; Rec."Lot No.")
            {
                Visible = FALSE;
                ApplicationArea = all;

                trigger OnValidate()
                begin

                    //+REF+LOT
                    IF NOT gLookUp THEN BEGIN
                        CurrPage.SAVERECORD;
                        COMMIT;
                        IF rec."Lot No." = '' THEN BEGIN
                            CLEAR(gReserveItem);
                            rec.TESTFIELD("No.");
                            rec.TESTFIELD("Quantity (Base)");

                            CduFonction.fCallItemTracking(Rec, FALSE, 1, 1, rec."Expiration Date");
                        END
                        ELSE BEGIN
                            CLEAR(gReserveItem);
                            rec.TESTFIELD("No.");
                            rec.TESTFIELD("Quantity (Base)");

                            CduFonction.fCallItemTracking(Rec, FALSE, 2, 1, rec."Expiration Date");
                        END;
                        rec.FIND('=');
                    END;
                    //+REF+LOT//

                    //+REF+LOT
                    CurrPage.UPDATE(FALSE);
                    //+REF+LOT//
                end;

                trigger OnAssistEdit()
                begin

                    //+REF+LOT
                    CurrPage.SAVERECORD;
                    COMMIT;
                    gLookUp := TRUE;
                    CLEAR(gReserveItem);
                    rec.TESTFIELD("No.");
                    rec.TESTFIELD("Quantity (Base)");

                    CduFonction.fCallItemTracking(Rec, FALSE, 0, 1, rec."Expiration Date");

                    CurrPage.UPDATE;
                    //+REF+LOT//
                end;
            }
            field("New Lot No."; Rec."New Lot No.")
            {
                Visible = FALSE;
                ApplicationArea = all;
            }
            field("New Serial No."; Rec."New Serial No.")
            {
                Visible = FALSE;
                ApplicationArea = all;
            }

        }

        addafter("Unit of Measure Code")
        {
            field("External Document No."; Rec."External Document No.")
            {

                ApplicationArea = all;
            }
            field("N° Materiel"; Rec."N° Materiel")
            {
                ApplicationArea = all;
            }
        }

        addafter("Applies-to Entry")
        {
            field("Phys. Inv. Quantity2"; Rec."Phys. Inv. Quantity")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        modify("&Print")
        {
            Visible = false;

        }

        addafter("&Print")
        {
            action("&Print2")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    ItemJnlLine: Record "Item Journal Line";
                begin
                    ItemJnlLine.Copy(Rec);
                    ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    //REPORT.RUNMODAL(REPORT::"Bon De TRansfert", TRUE, TRUE, ItemJnlLine);
                    REPORT.RUNMODAL(REPORT::"Inventory Movement", TRUE, TRUE, ItemJnlLine);
                end;
            }
        }
        addafter("&Print_Promoted")
        {
            actionref("&Print21"; "&Print2")
            { }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //+REF+LOT
        gLookUp := FALSE;
        //+REF+LOT//
    end;

    PROCEDURE VerifStock();
    VAR
        Text001: Label 'Item not available in stock';
        Text002: Label 'The quantity in stock does not meet your request';
    BEGIN
        IF rec."Entry Type" = rec."Entry Type"::Purchase THEN EXIT;
        IF rec."Entry Type" = rec."Entry Type"::"Positive Adjmt." THEN EXIT;
        IF (rec."Item No." = '') OR (rec."Location Code" = '') THEN EXIT;
        RecItem.SETFILTER("No.", rec."Item No.");
        RecItem.SETFILTER("Location Filter", rec."Location Code");
        IF RecItem.FINDFIRST THEN BEGIN
            RecItem.CALCFIELDS(Inventory);
            rec."Phys. Inv. Quantity" := RecItem.Inventory;
            IF RecItem.Inventory = 0 THEN ERROR(Text001);
            IF RecItem.Inventory < rec.Quantity THEN ERROR(Text002);
        END;
    END;

    var
        gLookUp: Boolean;
        gReserveItem: Codeunit "Item Jnl. Line-Reserve";
        RecItem: Record Item;
        CduFonction: Codeunit SoroubatFucntion;
}
