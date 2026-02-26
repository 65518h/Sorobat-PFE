PageExtension 50114 "Phys. Inventory Journal_PagEXT" extends "Phys. Inventory Journal"
{
    layout
    {
        addbefore("Posting Date")
        {
            field("Traité"; Rec."Traité")
            {
                ApplicationArea = all;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
            field("Phys. Inventory"; Rec."Phys. Inventory")
            {
                ApplicationArea = all;
            }


        }
        addafter("Document Date")
        {

        }
        addafter("Location Code")
        {
            field("Lot No."; Rec."Lot No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        addafter("Qty. (Phys. Inventory)")
        {
            field("Phys. Inv. Quantity"; Rec."Phys. Inv. Quantity")
            {
                ApplicationArea = all;
            }
        }
        modify("Unit Amount")
        {
            Visible = false;
        }

        addafter("Reason Code")
        {
            field("Shelf No."; Rec."Shelf No.")
            {
                Visible = true;
                Editable = false;
                ApplicationArea = all;
            }

        }
    }
    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        //GL2024 addafter(Print_Promoted)
        // {
        //     actionref(Print21; Print2)
        //     {

        //     }
        // }
        addafter(Print)
        {
            /*GL2024 action(Print2)
             {
                 ApplicationArea = Basic, Suite;
                 Caption = '&Print';
                 Ellipsis = true;
                 Image = Print;
                 ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                 trigger OnAction()
                 var
                     ItemJournalBatch: Record "Item Journal Batch";
                     lItemJournalLine: Record "Item Journal Line";
                 begin
                     /*  ItemJournalBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
                       ItemJournalBatch.SetRange(Name, Rec."Journal Batch Name");
                       REPORT.RunModal(REPORT::"Phys. Inventory List", true, false, ItemJournalBatch);
   */

            // GL2024        lItemJournalLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
            //         lItemJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
            //         //DYS REPORT addon non migrer
            //         //REPORT.RUNMODAL(REPORT::"Phys. Inv. Control List", TRUE, TRUE, lItemJournalLine);
            //         //+REF+PHYS_INV//

            //     end;
            // }*/
        }
        addafter(CalculateCountingPeriod_Promoted)
        {
            actionref("Remize à zero1"; "Remize à zero")
            {

            }
            actionref("Importer Inventaire1"; "Importer Inventaire")
            {

            }
            actionref("Proposer feuille de comptage1"; "Proposer feuille de comptage")
            {

            }
        }
        addafter("CalculateCountingPeriod")
        {
            action("Remize à zero")
            {
                Caption = 'Remize à zero';
                ApplicationArea = all;

                trigger OnAction()
                begin


                    // >> HJ DELTA 14-03-2014
                    IF NOT CONFIRM(Text001) THEN EXIT;
                    ItemJournalLine.COPY(Rec);
                    IF ItemJournalLine.FINDFIRST THEN
                        REPEAT
                            ItemJournalLine.VALIDATE("Qty. (Phys. Inventory)", 0);
                            ItemJournalLine.MODIFY;
                        UNTIL ItemJournalLine.NEXT = 0;
                    // >> HJ DELTA 14-03-2014

                end;
            }
            action("Importer Inventaire")
            {
                Caption = 'Importer Inventaire';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lImport: Record Import;
                begin

                    // >> HJ DELTA 15-03-2014
                    IF NOT CONFIRM(Text002) THEN EXIT;
                    CLEAR(RptImporterInventaire);
                    ItemJournalLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    ItemJournalLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    RptImporterInventaire.GetBatch(rec."Journal Template Name", rec."Journal Batch Name");
                    if ItemJournalLine.FindFirst() then
                        RptImporterInventaire.SETTABLEVIEW(ItemJournalLine);
                    RptImporterInventaire.run();
                    // >> HJ DELTA 15-03-2014


                end;
            }
            action("Proposer feuille de comptage")
            {
                Caption = 'Proposer feuille de comptage';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    CalcQtyOnHand.SetItemJnlLine(Rec);
                    CalcQtyOnHand.SetPhysInv();
                    CalcQtyOnHand.RUNMODAL;
                    CLEAR(CalcQtyOnHand);

                end;
            }
        }


    }
    var
        Text001: Label 'Reset... to zero ?';
        Text002: Label 'Import inventory ?';
        CalcQtyOnHand: Report "Calculate Inventory";
        ItemJournalLine: Record "Item Journal Line";
        RptImporterInventaire: xmlport "Import Inventaire";
}