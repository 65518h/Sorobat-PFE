page 50357 "Production Completion Entries"
{
    // //PROJET_FACT GESWAY 16/04/03 Nouveau formulaire d'avancement en production

    Caption = 'Production Completion Entries';
    PageType = List;
    SourceTable = "Production Completion Entry";

    layout
    {
        area(content)
        {
            repeater("Lines")
            {
                Editable = false;
                field("Job No."; Rec."Job No.")
                {
                }
                field("Previous Completion %"; Rec."Previous Completion %")
                {
                }
                field("New Completion %"; Rec."New Completion %")
                {
                }
                field("Completion Difference (%)"; Rec."Completion Difference (%)")
                {
                }
                field("Previous Quantity"; Rec."Previous Quantity")
                {
                }
                field("New Quantity"; Rec."New Quantity")
                {
                }
                field("Quantity Difference"; Rec."Quantity Difference")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Documents)
            {
                Caption = 'Documents';
                action("Sales Order Lines")
                {
                    Caption = 'Sales Order Lines';
                    RunObject = Page 516;
                    RunPageLink = "Document No." = FIELD("Order No."),
                                  "Line No." = FIELD("Order Line No.");
                    RunPageView = SORTING("Document Type", "Document No.", "Line No.")
                                  WHERE("Document Type" = CONST(Order));
                }
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    RunObject = Page 130;
                    RunPageLink = "No." = FIELD("Document No.");
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    lNavigateForm: Page 344;
                begin
                    lNavigateForm.SetDoc(Rec."Posting Date", Rec."Document No.");
                    lNavigateForm.RUN;
                end;
            }
        }
    }
}

