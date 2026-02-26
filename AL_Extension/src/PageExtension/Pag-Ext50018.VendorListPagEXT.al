PageExtension 50018 "Vendor List_PagEXT" extends "Vendor List"
{
    Editable = true;
    /*GL2024
 SourceTableView=WHERE(Blocked=FILTER(<>All),
                          Statut=CONST(Validé));*/
    layout
    {
        addbefore(Control1)
        {

            field("Item Category Filter"; Rec."Item Category Filter")
            {
                ApplicationArea = all;
                Editable = true;
                //GL2024  TableRelation = "Resources Setup";
                trigger OnValidate()
                begin
                    IF rec.GETFILTER("Item Category Filter") = '' THEN
                        rec.SETRANGE("Item Category")
                    ELSE
                        rec.SETRANGE("Item Category", TRUE);
                END;


            }

        }
        modify(Control1)
        {
            Editable = false;
        }
        modify("Balance (LCY)")
        {
            visible = false;
        }


        modify("Balance Due (LCY)")
        {
            visible = false;
        }
        modify("Payments (LCY)")
        {
            visible = false;
        }

        addafter(Name)
        {
            field("Code Retenue à la Source"; Rec."Code Retenue à la Source")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Ancien Numero"; Rec."Ancien Numero")
            {
                ApplicationArea = all;
            }
            field("Autoriser Avance"; Rec."Autoriser Avance")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Balance (LCY)2"; Rec."Balance (LCY)")
            {
                ApplicationArea = all;
                Style = Attention;
                StyleExpr = true;
                trigger OnDrillDown()
                begin
                    Rec.OpenVendorLedgerEntries(false);
                end;
            }
            field("Réglement en Préparation"; Rec."Réglement en Préparation")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Réglement Préparé"; Rec."Réglement Préparé")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("En Cours De Signature"; Rec."En Cours De Signature")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Signé"; Rec."Signé")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Traite Non Echu"; Rec."Traite Non Echu")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Regime D'imposition"; Rec."Regime D'imposition")
            {
                ApplicationArea = all;
                Visible = false;
            }
            /* field("Type identifiant"; Rec."Type identifiant")
             {
                 ApplicationArea = all;
             }*/
            field("Activité"; Rec."Activité")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Address; Rec.Address)
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Responsibility Center")
        {
            field(Statut; Rec.Statut)
            {
                ApplicationArea = all;
            }
        }

        addafter("VAT Bus. Posting Group")
        {
            field("VAT Registration No.2"; Rec."VAT Registration No.")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }
        addafter("Lead Time Calculation")
        {
            /*field(Loyer2; Rec.Loyer)
            {
                ApplicationArea = all;
            }*/
            field(Transporteur; Rec.Transporteur)
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        addafter("Base Calendar Code")
        {
            field(Balance; Rec.Balance)
            {
                Visible = false;
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("C&ontact")
        {
            action("Con&tacts liés")
            {
                ApplicationArea = all;
                Caption = 'Contacts liés';
                trigger OnAction()
                begin
                    rec.fShowContactList;
                end;
            }

        }
        addafter("C&ontact_Promoted")
        {
            actionref("Con&tacts liés1"; "Con&tacts liés")
            {

            }
        }
        addafter("Item Refe&rences")
        {
            action(Reports)
            {
                ApplicationArea = all;
                Caption = 'Etats';

                trigger OnAction()
                VAR
                    lReportList: Record ReportList;
                    lId: Integer;
                    lRecRef: RecordRef;
                begin
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
        addafter("Item Refe&rences_Promoted")
        {
            actionref("Reports1"; Reports)
            {

            }
        }
        modify("Return Orders")
        {
            Visible = false;
        }
        addafter("Return Orders")
        {
            action("Return Orders2")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Return Orders';
                Image = ReturnOrder;
                RunObject = Page "Purchase Return Order";
                RunPageView = SORTING("Document Type", "Buy-from Vendor No.", "No.");
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                ToolTip = 'Open the list of ongoing return orders.';
            }
        }
        addafter("Return Orders_Promoted")
        {
            actionref("Return Orders21"; "Return Orders2")
            {

            }
        }

        //DYS addafter("Prepa&yment Percentages")
        // {
        //action("Item Category Group")
        // {
        //ApplicationArea = all;
        //Caption = 'Item Category Group';
        //DYS page addon non migrer
        // RunObject = Page 8004095;
        // RunPageView = SORTING("Vendor No.", "Item Category Code", "Product Group Code");
        // RunPageLink = "Vendor No." = FIELD("No.");
        // }


        // }
        /*GL2024 modify("Line Discounts")
         {
           runpageview=SORTING(Purchase Type,Purchase Code,Type,Code,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity)
           runpagelink=Purchase Code=FIELD(No.);

         }*/
    }
    PROCEDURE wGetRecInstance(VAR pRec: Record Vendor);
    BEGIN

        Rec.MARKEDONLY(TRUE);
        pRec.COPY(Rec);
    END;

    trigger OnOpenPage()
    var
    begin
        /*HS    Rec.FilterGroup(0);
            Rec.SetFilter(Blocked, '<>%1', rec.Blocked::All);
            Rec.SetRange(Statut, Rec.Statut::"Validé");
            Rec.FilterGroup(2);*/
    end;

}

