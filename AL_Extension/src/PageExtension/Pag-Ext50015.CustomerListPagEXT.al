PageExtension 50015 "Customer List_PagEXT" extends "Customer List"
{
    layout
    {
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify("Search Name")
        {
            Visible = true;
        }

        addafter(Name)
        {
            /*  field("Matricule fiscal"; Rec."Matricule fiscal")
              {
                  ApplicationArea = all;
              }*/
            field("Balance (LCY)2"; Rec."Balance (LCY)")
            {
                ApplicationArea = all;
            }
        }
        addafter("Responsibility Center")
        {
            field("Currency Code2"; Rec."Currency Code")
            {
                ApplicationArea = all;

            }
            field("Ancien Code"; Rec."Ancien Code")
            {
                ApplicationArea = all;
            }
            field("Customer Price Group2"; Rec."Customer Price Group")
            {
                Caption = 'Type Client';
                ApplicationArea = all;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Base Calendar Code")
        {
            field(Balance; Rec.Balance)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        addafter("Sales_Prices")
        {
            action("Resource Price")
            {
                ApplicationArea = all;
                Caption = 'Resource Price';
                RunObject = page "Resource Prices";
                RUNPAGELINK = "Customer No." = FIELD("No.");
            }
        }
        addafter("Service &Items")

        {
            action("Reports2")
            {
                ApplicationArea = all;
                Caption = 'Reports';
                trigger OnAction()
                VAR
                    lReportList: Record ReportList;
                    lId: Integer;
                    lRecRef: RecordRef;
                BEGIN

                    WITH lReportList DO BEGIN
                        EVALUATE(lId, COPYSTR(CurrPage.OBJECTID(FALSE), 6));
                        lRecRef.GETTABLE(Rec);
                        lRecRef.SETVIEW(Rec.GETVIEW);
                        SetRecordRef(lRecRef, FALSE);
                        ShowList(lId);
                    END;

                end;
            }


        }
    }

}



