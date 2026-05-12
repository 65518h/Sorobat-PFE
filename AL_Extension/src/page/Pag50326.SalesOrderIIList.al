page 50326 "Sales Order II List"
{
    //GL2024 NEW PAGE

    Caption = 'Sales Order II List';
    PageType = list;
    ApplicationArea = all;
    UsageCategory = Lists;
    RefreshOnActivate = true;
    SaveValues = true;
    Editable = false;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Order Type", "Document Type", "No.", "Invoicing Method", Finished) WHERE("Document Type" = CONST(Order), "Order Type" = FILTER(' '));
    //CardPageId = "Sales Order II";
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Caption = 'Général';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° Client';



                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                    AssistEdit = true;



                }
                field("Job No.1"; rec."Job No.")
                {
                    ApplicationArea = all;
                    Caption = 'Affaire BT';

                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° BL';
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Code1"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    Caption = 'Code Destination';

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Ship-to Name1"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Caption = 'Destination';

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Engin; rec.Engin)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Description Engin"; rec."Description Engin")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("N° Serie"; rec."N° Serie")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;


                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;


                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Commande Interne"; rec."Commande Interne")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field("Last Shipping No."; rec."Last Shipping No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° Expédition';
                }
                // field(Production; rec.Production)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Formule Beton"; rec."Formule Beton")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Matricule Pompe"; rec."Matricule Pompe")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }



                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    AssistEdit = true;


                }

                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                }
                field("Job Starting Date"; rec."Job Starting Date")
                {
                    ApplicationArea = all;

                }
                field("Job Ending Date"; rec."Job Ending Date")
                {
                    ApplicationArea = all;

                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = all;
                }

                field(Subject; rec.Subject)
                {
                    ApplicationArea = all;


                }



                field("Contract Type"; rec."Contract Type")
                {
                    ApplicationArea = all;

                }
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    ApplicationArea = all;

                }
                field("Bill-to Contact No."; rec."Bill-to Contact No.")
                {
                    ApplicationArea = all;
                }
                field("Bill-to Name"; rec."Bill-to Name")
                {
                    ApplicationArea = all;
                    AssistEdit = true;



                }

                field("Prices Including VAT"; rec."Prices Including VAT")
                {
                    ApplicationArea = all;



                }
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = all;

                }
                field("Payment Method Code"; rec."Payment Method Code")
                {
                    ApplicationArea = all;

                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;



                }
                field("Part Payment"; rec."Part Payment")
                {
                    ApplicationArea = all;
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;

                }


                field("Subscription Starting Date"; rec."Subscription Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Subscription End Date"; rec."Subscription End Date")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;


                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;


                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = all;

                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Review Formula Code"; rec."Review Formula Code")
                {
                    ApplicationArea = all;

                }
                field("Review Base Date"; rec."Review Base Date")
                {
                    ApplicationArea = all;

                }
                field("Sell-to Contact No."; rec."Sell-to Contact No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }


                field("Progress Degree"; rec."Progress Degree")
                {
                    ApplicationArea = all;
                }
                field("No. of Archived Versions"; rec."No. of Archived Versions")
                {
                    ApplicationArea = all;


                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Finished; rec.Finished)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Your Reference"; rec."Your Reference")
                {
                    ApplicationArea = all;
                }


                field("Prepayment %"; rec."Prepayment %")
                {
                    ApplicationArea = all;


                }
                field("Compress Prepayment"; rec."Compress Prepayment")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Payment Terms Code"; rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = all;
                }
                field("Prepayment Due Date"; rec."Prepayment Due Date")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Payment Discount %"; rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Pmt. Discount Date"; rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = all;
                }
            }



        }




    }
}

