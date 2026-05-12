page 50399 "Avance Fournisseur"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Vendor Ledger Entry";
    SourceTableView = SORTING("Entry No.") WHERE("Document No." = FILTER('AVANCE*|DTAV*|DECVIR*'));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Avance Fournisseur")
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; Rec."External Document No.") { ApplicationArea = all; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = all; }
                field("Document Type"; Rec."Document Type") { ApplicationArea = all; }
                field("Document No."; Rec."Document No.") { ApplicationArea = all; }
                field(Description; Rec.Description) { ApplicationArea = all; }
                field(Amount; Rec.Amount) { ApplicationArea = all; }
                field("Remaining Amount"; Rec."Remaining Amount") { ApplicationArea = all; }
                field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)") { ApplicationArea = all; }
                field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)") { ApplicationArea = all; }
                field("Amount (LCY)"; Rec."Amount (LCY)") { ApplicationArea = all; }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}