PageExtension 50016 "Customer Ledger Entries_PagEXT" extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Control1)
        {
            group(" ")
            {
                ShowCaption = false;
                field(DecMontantSelect; DecMontantSelect)
                {
                    // Caption = 'DecMontantSelect';
                    ApplicationArea = all;
                    ShowCaption = false;
                    Editable = FALSE;
                }
            }
        }

        modify("Document Date")
        {
            Visible = false;
        }
        addafter("Document No.")
        {
            field("External Document No.2"; Rec."External Document No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Folio No"; Rec."Folio No")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Global Dimension 1 Code")
        {
            field(Lettre; Rec.Lettre)
            {
                ApplicationArea = all;
            }
        }
        addafter("Salesperson Code")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }

        addafter(Open)
        {
            field("Retention Code"; Rec."Retention Code")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Retention %"; Rec."Retention %")
            {
                ApplicationArea = all;
                Editable = false;

            }

        }
        addafter("Entry No.")
        {
            field("Code Lettrage"; Rec."Code Lettrage")
            {
                ApplicationArea = all;

            }
        }


    }
    actions
    {
        addafter("Ent&ry")
        {
            action("Calculate the selection")
            {
                Caption = 'Calculate the selection';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    // RB SORO 15/04/2016
                    DecMontantSelect := 0;
                    CurrPage.SETSELECTIONFILTER(RecCustLedgerEntryCalc);
                    IF RecCustLedgerEntryCalc.FINDFIRST THEN
                        REPEAT
                            RecCustLedgerEntryCalc.CALCFIELDS("Remaining Amount");
                            DecMontantSelect += RecCustLedgerEntryCalc."Remaining Amount";
                        UNTIL RecCustLedgerEntryCalc.NEXT = 0;
                    // RB SORO 15/04/2016
                end;
            }
        }
        addafter(Category_Category5)
        {
            actionref("Calculate the selection1"; "Calculate the selection")
            {
            }
        }

    }

    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    BEGIN

        //MASK
        lMaskMgt.CustLedgEntry(Rec);
        //MASK//

    end;


    var
        DecMontantSelect: Decimal;
        RecCustLedgerEntryCalc: Record "Cust. Ledger Entry";
}



