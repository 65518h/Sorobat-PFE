PageExtension 50017 "Vendor Card_PagEXT" extends "Vendor Card"
{
    layout
    {
        addafter("No.")
        {
            field("Ancien Numero"; Rec."Ancien Numero")
            {
                ApplicationArea = all;
            }

        }
        modify("VAT Registration No.")
        {
            Style = Strong;
            StyleExpr = true;
        }
        addafter("Disable Search by Name")
        {
            field("Appliquer Fodec"; Rec."Appliquer Fodec") { ApplicationArea = all; Visible = false; }
        }
        modify(BalanceAsCustomer)
        {
            Visible = false;
        }
        modify("company Size Code")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        addafter("Last Date Modified")
        {



            field("Compte Contribuable"; Rec."Compte Contribuable")
            {
                ApplicationArea = all;
            }
            field("Cente D'imposition"; Rec."Cente D'imposition")
            {
                ApplicationArea = all;
                Visible = false;
            }



            /*  field(Loyer2; Rec.Loyer)
              {
                  ApplicationArea = all;
                  trigger OnValidate()
                  begin
                      IF COPYSTR(rec."No.", 1, 3) <> 'LOY' THEN ERROR(Text004);
                  END;
              }*/
            field(Transporteur; Rec.Transporteur)
            {
                ApplicationArea = all;
                Visible = false;
            }









            field("Type Fournisseur"; Rec."Type Fournisseur")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Regime D'imposition"; Rec."Regime D'imposition")
            {
                ApplicationArea = all;
            }

            /*    field("Type identifiant"; Rec."Type identifiant")
                {
                    ApplicationArea = all;
                }*/
            field("Date de Naissance"; Rec."Date de Naissance")
            {
                ApplicationArea = all;
            }
            field("Activité"; Rec."Activité")
            {
                ApplicationArea = all;
            }
            field(Synchronise; Rec.Synchronise)
            {
                ApplicationArea = all;
            }


            field(Statut; Rec.Statut)
            {
                ApplicationArea = all;
                Editable = false;
            }













        }
        addafter("Responsibility Center")
        {
            field("External Work Force"; rec."External Work Force")
            {
                Caption = 'M.O. externe';
            }
            field(Subcontractor; Rec.Subcontractor)
            {
                ApplicationArea = all;

                Caption = 'Sous-traitant';
            }
        }
        addafter("Balance (LCY)")
        {
            field("Total Paiement"; Rec."Total Paiement")
            {
                ApplicationArea = all;
            }
            field(Balance2; Rec.Balance)
            {
                ApplicationArea = all;
            }
        }

        addafter("Company Size Code")
        {
            group("Tableau De Bords")
            {
                field("Cheque En Circulation"; Rec."Cheque En Circulation")
                {
                    ApplicationArea = all;
                    Editable = false;

                }

                field("Effet En Circulation"; Rec."Effet En Circulation")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Inv. Amounts (LCY)"; Rec."Inv. Amounts (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Balance3; Rec.Balance)
                {
                    ApplicationArea = all;
                    Visible = false;
                }


                field("Traite Non Echu"; Rec."Traite Non Echu")
                {
                    ApplicationArea = all;
                    Visible = false;
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


                field("Controle Financier en Cours"; Rec."Controle Financier en Cours")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("En Cours De Signature2"; Rec."En Cours De Signature")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Signé"; Rec."Signé")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Avance Non Lettré"; Rec."Avance Non Lettré")
                {
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        VendoredgerEntry.SetRange("Vendor No.", rec."No.");
                        //VendoredgerEntry.SETFILTER("Document No.",'AVFACT*');
                        VendoredgerEntry.SetFilter("Document No.", 'AV*');
                        VendoredgerEntry.SetRange(Open, true);
                        if page.RunModal(page::"Vendor Ledger Entries", VendoredgerEntry) = Action::LookupOK then;
                    end;
                }
                field("Factures En Cours"; Rec."Factures En Cours")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Invoice Amounts"; Rec."Invoice Amounts")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cr. Memo Amounts"; Rec."Cr. Memo Amounts")
                {
                    ApplicationArea = all;
                    Visible = false;
                }



            }
        }


        modify("Disable Search by Name")
        {
            Visible = false;
        }
        addafter("IC Partner Code")
        {
            field("Import Priority"; Rec."Import Priority")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Prices Including VAT")
        {
            field("Vendor Disc. Group"; Rec."Vendor Disc. Group")
            {
                ApplicationArea = all;
            }
        }




        addafter(Priority)
        {
            field("Code Retenue à la Source"; Rec."Code Retenue à la Source")
            {
                ApplicationArea = all;
            }
            field(Banque; Rec.Banque)
            {
                ApplicationArea = all;
            }
            field(RIB; Rec.RIB)
            {
                ApplicationArea = all;
            }
        }

        addafter("Block Payment Tolerance")
        {
            field("En Cours De Signature"; Rec."En Cours De Signature")
            {
                ApplicationArea = all;
            }

            field("Reglement Valide"; Rec."Reglement Valide")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Total Avance"; Rec."Total Avance")
            {
                ApplicationArea = all;
            }
            field("Balance (LCY)2"; Rec."Balance (LCY)")
            {
                ApplicationArea = all;
                trigger OnDrillDown()
                VAR
                    VendLedgEntry: Record "Vendor Ledger Entry";
                    DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                BEGIN
                    DtldVendLedgEntry.SETRANGE("Vendor No.", rec."No.");
                    rec.COPYFILTER("Global Dimension 1 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 1");
                    rec.COPYFILTER("Global Dimension 2 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 2");
                    rec.COPYFILTER("Currency Filter", DtldVendLedgEntry."Currency Code");
                    VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
                END;
            }
            field("Suggest Payments"; Rec."Suggest Payments")
            {
                ApplicationArea = all;
            }
            field("Autoriser Avance"; Rec."Autoriser Avance")
            {
                ApplicationArea = all;
            }


        }


        addafter("Customized Calendar")
        {
            field(Cotation; Rec.Cotation)
            {
                ApplicationArea = all;
            }
        }

        //GL2024 Declaration Employeur
        addafter("Creditor No.")
        {
            // field(Activite; Rec.Activite)
            // {
            //     ApplicationArea = all;
            // }

        }
    }
    actions
    {
        //DYS addafter("Ven&dor")
        //DYS {
        //DYS action("&Workflow")
        //DYS {
        //DYSCaption = '&Workflow';
        //DYS ApplicationArea = all;
        //DYS page addon non migrer
        // RunObject = Page 8004213;
        // RunPageLink = Type = CONST(26),
        //                   "No." = FIELD("No.");
        //DYS }
        //DYS }

        addafter(ContactBtn)
        {
            action("Relate&d Contacts")
            {
                ApplicationArea = all;
                Caption = 'Relate&d Contacts';
                trigger OnAction()
                begin
                    //+REF+CONTACT
                    rec.fShowContactList;
                    //+REF+CONTACT//
                end;
            }
            action("Folder")
            {
                ApplicationArea = all;
                Caption = 'Folder';
                trigger OnAction()
                VAR
                    lFolderManagement: Codeunit "Folder management";
                begin
                    //+REF+FOLDER
                    lFolderManagement.Vendor(Rec);
                    //+REF+FOLDER//
                end;
            }
            //DYS  action("Characteristics")
            //DYS  {
            //DYS ApplicationArea = all;
            //DYS Caption = 'Characteristics';
            //DYS page addon non migrer
            // RunObject = Page 8001403;
            // RunPageLink = "Table Name" = CONST(Vendor),
            //                   "No." = FIELD("No.");
            //DYS }

            action("Description")
            {
                ApplicationArea = all;
                Caption = 'Description';
                trigger OnAction()
                VAR
                    lDescriptionLine: Record "Description Line";
                BEGIN
                    lDescriptionLine.ShowDescription(23, 0, rec."No.", 0);
                end;
            }
        }
        addafter(ContactBtn_Promoted)
        {
            actionref("Relate&d Contacts1"; "Relate&d Contacts")
            {
            }
            actionref("Folder1"; "Folder")
            {
            }
            /*GL2024  actionref("Description1"; "Description")
              {
              }*/
        }
        //DYS  addafter("Item References")
        //DYS {
        //DYS   action("Interim Missions")
        //DYS  {
        //DYS    ApplicationArea = all;
        //DYS   Caption = 'Interim Missions';
        //DYS     trigger OnAction()
        //DYS   VAR
        //DYS       lInterim: Record "Interim Mission";
        //DYS page addon non migrer
        //lMission: Page 8004020;
        //DYS  BEGIN

        //INTERIM
        //DYS      rec.TESTFIELD("External Work Force", TRUE);
        //DYS    lInterim.SETCURRENTKEY("Vendor No.");
        //DYS   lInterim.SETRANGE("Vendor No.", rec."No.");
        // lMission.TypePres(TRUE);
        // lMission.SETTABLEVIEW(lInterim);
        // lMission.RUNMODAL;

        //DYS   end;
        //DYS }
        //DYS }
        addafter(Items)
        {
            action("&Missions")
            {
                ApplicationArea = all;
                Caption = '&Missions';
                trigger OnAction()
                VAR
                    lResCost: Record "Resource Cost";
                BEGIN

                    //INTERIM
                    lResCost.SETCURRENTKEY("Vendor No.");
                    IF rec."External Work Force" THEN
                        lResCost.SETRANGE("Vendor No.", rec."No.")
                    ELSE
                        lResCost.SETRANGE("Vendor No.", '');
                    PAGE.RUN(PAGE::"Resource Costs", lResCost);
                END;


            }

        }
        /*GL2024
       modify("Line Discounts")
       {

Runpageview=SORTING(Purchase Type,Purchase Code,Type,Code,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity)  
runpgelink=Purchase Code=FIELD(No.);


    }*/
        //DYS addafter("Prepa&yment Percentages")
        //DYS  {
        //DYS   action("Item Category Group")
        //DYS  {
        //DYS   ApplicationArea = all;
        //DYS  Caption = 'Item Category Group';
        //DYS page addon non migrer
        // RunObject = Page 8004095;
        // RunPageView = SORTING("Vendor No.", "Item Category Code", "Product Group Code");
        // RunPageLink = "Vendor No." = FIELD("No.");
        //DYS }

        //DYS }
        //DYS addafter("Return Orders")
        //DYS {
        //DYS     action("Subscription Contracts")
        //DYS    {
        //DYS ApplicationArea = all;
        //DYS Caption = 'Subscription Contracts';
        //DYS page addon non migrer
        // RunObject = Page 8001915;
        // RunPageView = SORTING("Document Type", "Buy-from Vendor No.", "No.");
        // RunPageLink = "Buy-from Vendor No." = FIELD("No.");
        //DYS }
        //DYS  }
        addafter(ApplyTemplate)
        {
            action(Valider)
            {
                ApplicationArea = all;
                Caption = 'Validate';
                trigger OnAction()
                begin
                    //>> HJ DSFT-24-03-2012
                    IF rec.Statut = rec.Statut::"En Attente" THEN BEGIN
                        IF CONFIRM(Text005) THEN BEGIN
                            rec.VALIDATE(Statut, rec.Statut::Validé);
                            rec.MODIFY;
                        END
                        ELSE
                            EXIT;
                    END
                    //>> HJ DSFT-24-03-2012
                end;
            }
        }
        addafter(ApplyTemplate_Promoted)
        {
            actionref(Valider1; Valider)
            {
            }
        }

    }

    trigger OnOpenPage()
    begin
        // >> HJ DSFT 03-06-2012
        IF RecUserSetup.GET(USERID) THEN;
        CurrPage.EDITABLE(RecUserSetup."Modif Fournisseur");
        // >> HJ DSFT 03-06-2012
    end;

    trigger OnAfterGetRecord()
    begin
        // >> HJ SORO 13-04-2015
        rec."Avance Non Lettré" := 0;
        rec.SETFILTER("Filtre Date Ech", '>= %1', TODAY);
        rec.SETRANGE("No.");
        rec.CALCFIELDS("Traite Non Echu");
        VendoredgerEntry.SETRANGE("Vendor No.", rec."No.");
        VendoredgerEntry.SETFILTER("Document No.", 'AV*');
        //VendoredgerEntry.SETFILTER("Document No.",'%1|%2','AVANCE*','AVFACT*');
        VendoredgerEntry.SETRANGE(Open, TRUE);
        VendoredgerEntry.SETCURRENTKEY("Vendor No.", "Document No.", Open);
        IF VendoredgerEntry.FINDFIRST THEN
            REPEAT
                VendoredgerEntry.CALCFIELDS("Remaining Amount");
                rec."Avance Non Lettré" += VendoredgerEntry."Remaining Amount";
            UNTIL VendoredgerEntry.NEXT = 0;
        // >> HJ SORO 13-04-2015
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    VAR
        lRecordRef: RecordRef;
        lTemplateMgt: Codeunit "Config. Template Management";
        CduFunction: Codeunit SoroubatFucntion;
    BEGIN

        //+REF+TEMPLATE

        lRecordRef.GETTABLE(Rec);
        IF NOT CduFunction.GetTemplate(lRecordRef) THEN
            Currpage.CLOSE;
        lRecordRef.SETTABLE(Rec);
        //+REF+TEMPLATE//

    end;

    trigger OnAfterGetCurrRecord()
    begin
        // >> HJ DSFT 03-06-2012
        IF RecUserSetup.GET(USERID) THEN;
        CurrPage.EDITABLE(RecUserSetup."Modif Article");
        // >> HJ DSFT 03-06-2012
    end;

    var
        RecUserSetup: Record "User Setup";
        VendoredgerEntry: Record "Vendor Ledger Entry";
        Text003: Label 'The vendor %1 does not exist.';
        Text004: Label 'Fournisseur loyer son code doit commencer par LOY et pas par FRL" into English is';
        Text005: Label 'Confirm this action ?';
}



