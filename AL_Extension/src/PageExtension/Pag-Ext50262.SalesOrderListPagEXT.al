PageExtension 50262 "Sales Order List_PagEXT" extends "Sales Order List"
{
    //GL2024     SourceTableView=WHERE(Document Type=CONST(Order),Order Type=CONST(" "));


    layout
    {
        addbefore("No.")
        {
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = all;
            }
        }
        addafter("No.")
        {
            field("Rider to Order No."; Rec."Rider to Order No.")
            {
                Visible = false;
                ApplicationArea = all;
            }

            field(Finished; Rec.Finished)
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Quote No.2"; Rec."Quote No.")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }

        addafter("Sell-to Customer Name")
        {

            field(Subject; Rec.Subject)
            {
                ApplicationArea = all;
            }
            field("Sell-to Contact No."; Rec."Sell-to Contact No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("Bill-to Post Code")
        {
            field("Bill-to City"; Rec."Bill-to City")
            {
                Visible = false;

                ApplicationArea = all;
            }
        }

        addafter("Bill-to Contact")
        {
            field("Project Manager"; Rec."Project Manager")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
            field("Job Description"; Rec."Job Description")
            {
                ApplicationArea = all;
            }
        }
        addafter("Ship-to Post Code")
        {
            field("Ship-to City"; Rec."Ship-to City")
            {
                ApplicationArea = all;

            }
        }

        addafter("Ship-to Contact")
        {
            field("Document Date2"; Rec."Document Date")
            {
                ApplicationArea = all;

            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;

            }
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {

            Visible = TRUE;
        }


        addafter("Salesperson Code")
        {
            field("Amount Excl. VAT (LCY)"; rec."Amount Excl. VAT (LCY)")
            {
                ApplicationArea = all;
            }
            field("Deadline Date"; rec."Deadline Date")
            {
                ApplicationArea = all;
            }
            field("Person Responsible"; rec."Person Responsible")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Person Responsible 2"; rec."Person Responsible 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Person Responsible 3"; rec."Person Responsible 3")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Person Responsible 4"; rec."Person Responsible 4")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Person Responsible 5"; rec."Person Responsible 5")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Date 1"; rec."Free Date 1")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Date 2"; rec."Free Date 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Date 3"; rec."Free Date 3")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Date 4"; rec."Free Date 4")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Date 5"; rec."Free Date 5")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Date 6"; rec."Free Date 6")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Date 7"; rec."Free Date 7")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Date 8"; rec."Free Date 8")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Value 1"; rec."Free Value 1")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Value 2"; rec."Free Value 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Value 3"; rec."Free Value 3")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Value 4"; rec."Free Value 4")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Value 5"; rec."Free Value 5")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Boolean 1"; rec."Free Boolean 1")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Boolean 2"; rec."Free Boolean 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Boolean 3"; rec."Free Boolean 3")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Boolean 4"; rec."Free Boolean 4")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Free Boolean 5"; rec."Free Boolean 5")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Criteria 1"; rec."Criteria 1")
            {
                ApplicationArea = all;
            }
            field("Criteria 2"; rec."Criteria 2")
            {
                ApplicationArea = all;
            }
            field("Criteria 3"; rec."Criteria 3")
            {
                ApplicationArea = all;
            }
            field("Criteria 4"; rec."Criteria 4")
            {
                ApplicationArea = all;
            }
            field("Criteria 5"; rec."Criteria 5")
            {
                ApplicationArea = all;
            }
            field("Criteria 6"; rec."Criteria 6")
            {
                ApplicationArea = all;
            }
            field("Criteria 7"; rec."Criteria 7")
            {
                ApplicationArea = all;
            }
            field("Criteria 8"; rec."Criteria 8")
            {
                ApplicationArea = all;
            }
            field("Criteria 9"; rec."Criteria 9")
            {
                ApplicationArea = all;
            }
            field("Criteria 10"; rec."Criteria 10")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        modify(Statistics)
        {
            Visible = false;
        }
        addafter(Statistics)
        {
            action(Statistics2)
            {
                ApplicationArea = Suite;
                Caption = 'Statistiques';
                Image = Statistics;
                ShortCutKey = 'F7';
                ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                trigger OnAction()
                var

                    lGR: Record "Gen. Product Posting Group";
                    lInvScheduler: Record "Invoice Scheduler";
                //DYS page addon non migrer
                //lStat: Page 8004045;
                begin

                    rec.PrepareOpeningDocumentStatistics();


                    //FORM.RUNMODAL(FORM::"Sales Order Statistics",Rec);
                    //#8601
                    IF rec."Invoicing Method" = rec."Invoicing Method"::Scheduler THEN BEGIN
                        CLEAR(lInvScheduler);
                        lInvScheduler.SETRANGE("Sales Header Doc. Type", rec."Document Type");
                        lInvScheduler.SETRANGE("Sales Header Doc. No.", rec."No.");
                        lInvScheduler.SETFILTER("Document Percentage", '<>0');
                        IF NOT lInvScheduler.ISEMPTY THEN BEGIN
                            lInvScheduler.FINDFIRST;
                            lInvScheduler.UpdateLineAmount(lInvScheduler);
                            COMMIT;
                        END;
                    END;
                    //PROJET_FACT//
                    //DYS
                    //lStat.GetSalesHeader(rec."Document Type", rec."No.");
                    lGR.SETRANGE("Document Type Filter", rec."Document Type");
                    lGR.SETRANGE("Document No. Filter", rec."No.");
                    //lGR.SETRANGE("Job Filter","Job No.");
                    //DYS
                    //lStat.SETTABLEVIEW(lGR);
                    //Fenetre.CLOSE;
                    //DYS
                    //lStat.RUNMODAL;

                    //#8601//
                end;
            }
        }
        addafter(Statistics_Promoted)
        {
            actionref(Statistics21; Statistics2)
            {

            }
        }

    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(0);
        rec.SetRange("Document Type", rec."Document Type"::Order);
        rec.SetRange("Order Type", rec."Order Type"::" ");
        Rec.FilterGroup(2);
    end;
}