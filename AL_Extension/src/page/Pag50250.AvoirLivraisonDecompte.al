page 50250 "Avoir Livraison Decompte"
{
    // //PROJET GESWAY 01/11/01 Ajout Job No.
    // //MASK IMA 02/01/06 Le groupe de confidentialité

    Caption = 'Avoir Livraison Decompte';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Sales Shipment Header";
    SourceTableView = WHERE("Commande Affaire" = CONST(true));
    ApplicationArea = all;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sell-to Contact No."; rec."Sell-to Contact No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sell-to Address"; rec."Sell-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sell-to Address 2"; rec."Sell-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sell-to Post Code"; rec."Sell-to Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Sell-to Post Code/City';
                    Editable = false;
                }
                field("Sell-to City"; rec."Sell-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sell-to Contact"; rec."Sell-to Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Requested Delivery Date"; rec."Requested Delivery Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Promised Delivery Date"; rec."Promised Delivery Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Quote No."; rec."Quote No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Order No."; rec."Order No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date Debut Decompte"; rec."Date Debut Decompte")
                {
                    ApplicationArea = all;
                }
                field("Date Fin Decompte"; rec."Date Fin Decompte")
                {
                    ApplicationArea = all;
                }
            }
            part(SalesShipmLines; "Ligne Avoir Decompte")
            {
                ApplicationArea = all;
                Editable = true;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Bill-to Contact No."; rec."Bill-to Contact No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Bill-to Name"; rec."Bill-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Bill-to Address"; rec."Bill-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Bill-to Address 2"; rec."Bill-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Bill-to Post Code"; rec."Bill-to Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Bill-to Post Code/City';
                    Editable = false;
                }
                field("Bill-to City"; rec."Bill-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Bill-to Contact"; rec."Bill-to Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No. Printed"; rec."No. Printed")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Total Decompte"; rec."Total Decompte")
                {
                    ApplicationArea = all;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Address"; rec."Ship-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Address 2"; rec."Ship-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Ship-to Post Code/City';
                    Editable = false;
                }
                field("Ship-to City"; rec."Ship-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Outbound Whse. Handling Time"; rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shipping Time"; rec."Shipping Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                {
                    ApplicationArea = all;
                }
                field("Package Tracking No."; rec."Package Tracking No.")
                {
                    ApplicationArea = all;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            /*GL2024   group(BizTalk)
               {
                   Caption = 'BizTalk';
                   field("BizTalk Shipment Notification"; rec."BizTalk Shipment Notification")
                   {    ApplicationArea = all;
                       Editable = false;
                   }
                   field("Date Sent"; rec."Date Sent")
                   {    ApplicationArea = all;
                       Editable = false;
                   }
                   field("Time Sent"; rec."Time Sent")
                   {    ApplicationArea = all;
                       Editable = false;
                   }
                   field("Customer Order No."; rec."Customer Order No.")
                   {    ApplicationArea = all;
                       Editable = false;
                   }
               }*/
        }
    }

    actions
    {
        area(Promoted)
        {
            group("&Shipment1")
            {
                Caption = '&Shipment';
                actionref(Statistics1; Statistics) { }
                actionref("Co&mments1"; "Co&mments") { }
                actionref(Approvals1; Approvals) { }
            }
            actionref("&Print11"; "&Print1") { }

            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("&Track Package1"; "&Track Package") { }

            }
            actionref("&Print12"; "&Print") { }
            actionref("&Navigate1"; "&Navigate") { }
        }
        area(navigation)
        {
            group("&Shipment")
            {
                Caption = '&Shipment';
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    Image = Statistics;

                    RunObject = Page "Sales Shipment Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = CONST(Shipment), "No." = FIELD("No."), "Document Line No." = CONST(0);
                }
                /* GL2024  action(Dimensions)
                   {    ApplicationArea = all;
                       Caption = 'Dimensions';
                       Image = Dimensions;
                       RunObject = Page "Posted Document Dimensions";
                                       RunPageLink = "Table ID"=CONST(110), "Document No."=FIELD("No."), "Line No."=CONST(0);
                   }*/
                action(Approvals)
                {
                    ApplicationArea = all;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        PostedApprovalEntries: Page "Posted Approval Entries";
                    begin
                        PostedApprovalEntries.Setfilters(DATABASE::"Sales Shipment Header", rec."No.");
                        PostedApprovalEntries.RUN;
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print1")
            {
                ApplicationArea = all;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;

                ToolTip = 'Print';

                trigger OnAction()
                begin
                    // >> HJ DSFT 10-10-2012

                    SalesShptHeader.SETRANGE("No.", REC."No.");
                    REPORT.RUNMODAL(REPORT::"BL enregistré A4", TRUE, TRUE, SalesShptHeader);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Track Package")
                {
                    ApplicationArea = all;
                    Caption = '&Track Package';

                    trigger OnAction()
                    begin
                        REC.StartTrackingSite;
                    end;
                }
                /* L2024  action("&Send BizTalk Shipment Notification")
                   {
                       ApplicationArea = all;
                       Caption = '&Send BizTalk Shipment Notification';

                       trigger OnAction()
                       var
                           BizTalkManagement: Codeunit 99008508;
                       begin
                           BizTalkManagement.SendShipmentNotification(Rec);
                       end;
                   }*/
            }
            action("&Print")
            {
                ApplicationArea = all;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;


                trigger OnAction()
                begin
                    SalesShptHeader.SETRANGE("No.", REC."No.");
                    REPORT.RUNMODAL(REPORT::"Monadat Minute", TRUE, TRUE, SalesShptHeader);
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = all;
                Caption = '&Navigate';
                Image = Navigate;


                trigger OnAction()
                begin
                    REC.Navigate;
                end;
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.RUN(CODEUNIT::"Shipment Header - Edit", Rec);
        EXIT(FALSE);
    end;

    trigger OnOpenPage()
    var
        lMaskMgt: Codeunit "Mask Management";
    begin
        //MASK
        lMaskMgt.SalesShipHeader(Rec);
        //MASK//
    end;

    var
        SalesShptHeader: Record "Sales Shipment Header";
}

