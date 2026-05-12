PageExtension 50063 "Posted Sales Credit Mem_PagEXT" extends "Posted Sales Credit Memo"
{
    layout
    {
        modify(General)
        {
            Editable = false;
        }
        addafter("No. Printed")
        {
            field("Job No."; Rec."Job No.")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Prepayment Rank No."; Rec."Prepayment Rank No.")
            {
                ApplicationArea = all;

            }
        }

        addafter("Payment Method Code")
        {
            field(Subject; Rec.Subject)
            {
                ApplicationArea = all;
                trigger OnAssistEdit()
                VAR
                    lDescription: Record "Description Line";
                begin

                    //#6918
                    lDescription.ShowDescription(114, 3, rec."No.", 0);

                end;
            }
            field("Financial Document"; Rec."Financial Document")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Subscription Starting Date"; Rec."Subscription Starting Date")
            {
                ApplicationArea = all;

            }
            field("Subscription End Date"; Rec."Subscription End Date")
            {
                ApplicationArea = all;

            }
            field("Part Payment"; Rec."Part Payment")
            {
                ApplicationArea = All;

            }
        }
        addafter("Ship-to Contact")
        {
            field("Project Manager"; Rec."Project Manager")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Project Manager Name"; wProjectManagerName)
            {
                Caption = 'Project Manager Name';
                Editable = false;
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        addafter(Statistics)
        {
            /*GL2024  action("Critères Statistiques")
              {
                  Caption = 'Statistics Criteria';
                  ApplicationArea = all;
                  trigger OnAction()
                  var
                      lSalesCrMemoHeader: Record "Sales Cr.Memo Header";
                  //DYS page addon non migrer
                  //lFormStatCrMemoSales: Page 8005128;
                  begin

                      lSalesCrMemoHeader := Rec;
                      // lFormStatCrMemoSales.SETRECORD(lSalesCrMemoHeader);
                      // lFormStatCrMemoSales.RUNMODAL();
                      Rec := lSalesCrMemoHeader;
                      CurrPage.UPDATE(TRUE);
                  end;
              }
              action("Informations Additionnelles")
              {
                  Caption = 'Additionnals Informations';
                  ApplicationArea = all;
                  trigger OnAction()
                  var
                      lSalesCrMemoHeader: Record "Sales Cr.Memo Header";
                  //DYS page addon non migrer
                  // lFormAddInfo: Page 8005129;
                  begin

                      lSalesCrMemoHeader := Rec;
                      // lFormAddInfo.SETRECORD(lSalesCrMemoHeader);
                      // lFormAddInfo.RUNMODAL;
                      Rec := lSalesCrMemoHeader;
                      CurrPage.UPDATE(TRUE);
                  end;
              }*/
        }

        modify("Print")
        {
            visible = false;
        }
        addafter(Print)
        {
            action("Print2")
            {
                Caption = 'Print';
                Ellipsis = true;
                Image = Print;
                //   Promoted = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    lSalesInvoiceHeader: Record "Sales Invoice Header";
                begin


                    //#8633
                    //+REF+DOCUMENT
                    //CurrForm.SETSELECTIONFILTER(SalesCrMemoHeader);
                    //SalesCrMemoHeader.PrintRecords(TRUE);
                    lSalesInvoiceHeader.SETRANGE("No.", rec."No.");
                    lSalesInvoiceHeader.SETRANGE("Print Document Type", lSalesInvoiceHeader."Print Document Type"::"Posted Credit Memo");
                    lSalesInvoiceHeader.PrintRecords(TRUE);
                    //+REF+DOCUMENT//
                    //#8633//

                end;
            }

        }
        addafter(Print_Promoted)
        {
            actionref("Print21"; "Print2")
            {

            }
        }
    }
    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    begin


        //MASK
        lMaskMgt.SalesCMHeader(Rec);
        //MASK//
        //CARACT
        NavibatSetup.GET2;
        //STATSEXPLORER
        IF wStat.READPERMISSION THEN
            IF NOT wStat.GET THEN
                wStat.INIT;
        //STATSEXPLORER//

        //CARACT//
    end;

    trigger OnAfterGetRecord()
    begin

        //DEVIS
        IF (rec."Project Manager" <> '') AND wContact.GET(rec."Project Manager") THEN
            wProjectManagerName := wContact.Name
        ELSE
            wProjectManagerName := '';
        //DEVIS//
    end;

    var
        wContact: Record Contact;
        wProjectManagerName: Text[30];
        NavibatSetup: Record NavibatSetup;
        wStat: Record "Statistics setup";
}

