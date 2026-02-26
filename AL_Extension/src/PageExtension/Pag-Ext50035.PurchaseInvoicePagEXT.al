PageExtension 50035 "Purchase Invoice_PagEXT" extends "Purchase Invoice"
{
    ///test2
    layout
    {
        modify("No.")
        {
            Visible = true;
            Editable = false;
        }
        modify("Location Code")
        {
            Visible = true;

        }

        modify("Buy-from Vendor No.")
        {
            Caption = 'N° Preneur d''ordre';
            trigger OnAfterValidate()
            begin
                IF rec."Buy-from Vendor No." = 'FRL-0845' THEN rec."Apply Stamp fiscal" := FALSE;

                IF VendorMF.GET(rec."Buy-from Vendor No.") THEN MatriculeFiscale := VendorMF."VAT Registration No.";

            end;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        addafter("Buy-from Contact")
        {
            field("Matricule Fiscale "; MatriculeFiscale)
            {
                Caption = 'Tax registration number';
                ApplicationArea = all;
                Editable = FALSE;

            }
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
                Caption = 'N° affaire';
                ShowMandatory = true;
            }
            field("N° Dossier"; Rec."N° Dossier")
            {
                StyleExpr = true;
                Style = Attention;
            }



            field("DTA Coding Line"; Rec."DTA Coding Line")
            {
                ApplicationArea = all;
                Visible = false;
                trigger OnValidate()
                begin
                    RecLigneBureauOrdre.RESET;
                    RecLigneBureauOrdre.SETRANGE("Référence Ligne", rec."DTA Coding Line");
                    IF RecLigneBureauOrdre.FINDFIRST THEN BEGIN
                        RecLigneBureauOrdre."Numero Fature Achat Associé" := rec."No.";
                        RecLigneBureauOrdre."Date Jointure" := TODAY;
                        FactFournBO := RecLigneBureauOrdre."Numero Facture";
                        RecLigneBureauOrdre.MODIFY;
                    END;
                end;
            }

        }
        addafter("Due Date")
        {
            field("Date Bureau Ordre"; Rec."Date Bureau Ordre")
            {
                ApplicationArea = all;
            }
        }
        addafter(Status)
        {

            /*      field("Date Saisie"; Rec."Date Saisie")
                  {
                      ApplicationArea = all;
                  }*/
            field("Facture En Instance"; Rec."Facture En Instance")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Simulation; Rec.Simulation)
            {
                Editable = SimulationEDITABLE;
                Enabled = false;
                ApplicationArea = all;
                Visible = false;
            }

            field(FactFournBO; FactFournBO)
            {
                ApplicationArea = all;
                Visible = false;
                Editable = false;
            }
            field("Appliquer Fodec"; Rec."Appliquer Fodec")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Appliquer Redevance"; Rec."Appliquer Redevance")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Appliquer Fond Soutient"; Rec."Appliquer Fond Soutient")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Apply Stamp fiscal"; Rec."Apply Stamp fiscal")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Date Saisie"; Rec."Date Saisie")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Utilisateur"; Rec."Utilisateur")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

        addbefore(Status)
        {
            field("Statut Facture"; Rec."Statut Facture")
            {
                ApplicationArea = all;
                Caption = 'Statut Facture';
                Editable = false;
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("VAT Bus. Posting Group")
        {
            field("Subscription Starting Date"; Rec."Subscription Starting Date")
            {
                ApplicationArea = all;
            }
            field("Subscription End Date"; Rec."Subscription End Date")
            {
                ApplicationArea = all;
            }
            field("Next Invoice Calculation"; Rec."Next Invoice Calculation")
            {
                ApplicationArea = all;
            }

            field("Posting Description2"; wDescr)
            {
                ApplicationArea = all;
                Caption = 'Posting Description';
                trigger OnValidate()
                begin
                    //POSTING_DESC
                    //GL2024     rec."Posting Description" := wDescr;
                    //POSTING_DESC//
                end;
            }
            field("Vendor Posting Group2"; Rec."Vendor Posting Group")
            {
                ApplicationArea = all;
            }
        }

        addafter("Ship-to Contact")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = all;
            }
            field("Receiving No."; Rec."Receiving No.")
            {
                ApplicationArea = all;
            }
            field("Vendor Shipment No.2"; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
            }
            field("Date Vérification"; Rec."Date Vérification")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        modify(Statistics)
        {
            trigger OnBeforeAction()
            begin

                // >> HJ SORO 16-10-2014

                // Cdupurchpostevent.CalcTimbre(Rec);
                // Cdupurchpostevent.CalcFodec(Rec);
                // IF rec."Appliquer Redevance" = TRUE THEN Cdupurchpostevent.CalcRedevance(Rec);
                // IF rec."Appliquer Fond Soutient" = TRUE THEN Cdupurchpostevent.CalcFondSoutient(Rec);
                // >> HJ SORO 16-10-2014
            end;
        }
        modify("Re&lease")
        {
            trigger OnBeforeAction()
            var
                lNaviBatSetup: Record NavibatSetup;
            begin


                //>> MH SORO 03-06-2020


                //IF "DTA Coding Line"='' THEN ERROR(Text003);
                RecLigneBureauOrdre.RESET;
                RecLigneBureauOrdre.SETRANGE("Référence Ligne", rec."DTA Coding Line");
                IF RecLigneBureauOrdre.FINDFIRST THEN BEGIN
                    RecLigneBureauOrdre."Numero Fature Achat Associé" := rec."No.";
                    RecLigneBureauOrdre."Date Jointure" := TODAY;
                    RecLigneBureauOrdre.MODIFY;
                END;


                //<< MH SORO 03-06-2020
            end;

            trigger OnafterAction()
            var
                lNaviBatSetup: Record NavibatSetup;
            begin


                //
                lNaviBatSetup.GET();

                //GL2024  rec."Posting Description" := rec.wPostingDescription;
                rec."Posting Description" := Format(rec."Document Type") + ' ' + rec."Pay-to Name" + ' - Affaire ' + rec."Job No.";

            end;
        }
        addfirst(navigation)
        {
            action("AppliquerFTRS")
            {
                ApplicationArea = all;
                Caption = 'Appliquer F.T.R.S';
                Visible = false;
                // Promoted = true;
                // PromotedIsBig = true;
                // PromotedCategory = Process; 
                Ellipsis = true;
                Image = Apply;
                trigger OnAction()
                var
                begin
                    // Cdupurchpostevent.CalcTimbre(Rec);
                    // Cdupurchpostevent.CalcFodec(Rec);
                    // IF rec."Appliquer Redevance" = TRUE THEN Cdupurchpostevent.CalcRedevance(Rec);
                    // IF rec."Appliquer Fond Soutient" = TRUE THEN Cdupurchpostevent.CalcFondSoutient(Rec);
                end;
            }
        }
        addbefore(CalculateInvoiceDiscount)
        {
            /*GL  action("Suggest Interim Invoice")
              {
                  Caption = 'Suggest Interim Invoice';
                  ApplicationArea = all;
                  trigger OnAction()
                  VAR
                      //DYS REPORT addon non migrer
                      //  lSuggestInterimInvoice: Report 8004021;
                      lMissionInterim: Record "Interim Mission";
                  BEGIN

                      //INTERIM
                      rec.TESTFIELD("Buy-from Vendor No.");

                      lMissionInterim.RESET;
                      lMissionInterim.SETCURRENTKEY("Vendor No.");
                      lMissionInterim.SETRANGE("Vendor No.", rec."Buy-from Vendor No.");
                      //DYS
                      // CLEAR(lSuggestInterimInvoice);
                      // lSuggestInterimInvoice.InitRequest(rec."Document Type", rec."No.");
                      // lSuggestInterimInvoice.RUNMODAL;
                      //INTERIM//

                  end;
              }*/
            action("Get Subscriptions")
            {
                Caption = 'Get Subscriptions';
                Visible = false;
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    lPurchSubscrMgt: Codeunit "Purch. Subscription Integr.";
                BEGIN

                    //+ABO+
                    lPurchSubscrMgt.GetFromInvoice(Rec);
                    //+ABO+//

                end;
            }
        }
        addafter(Category_Category10)
        {
            actionref("AppliquerFTRSAction"; "AppliquerFTRS")
            {

            }
        }
        addafter(CalculateInvoiceDiscount_Promoted)
        {
            /*GL2024  actionref("Suggest Interim Invoice1"; "Suggest Interim Invoice")
              {

              }*/
            actionref("Get Subscriptions1"; "Get Subscriptions")
            {

            }
        }


        addafter("P&osting")
        {
            group("&Line")
            {
                Caption = '&Ligne';
                action(Description)
                {
                    Caption = 'Description';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //OUVRAGE
                        CurrPAGE.PurchLines.PAGE.wShowDescription;
                        //OUVRAGE//
                    end;
                }
            }

        }
        addafter(Category_Process)
        {
            group("Line")
            {
                Caption = 'Ligne';
                actionref(Description1; Description)
                {

                }
            }
            actionref("&Print1"; "&Print")
            {

            }
            actionref("Consultation Facture1"; "Consultation Facture")
            { }
        }
        modify(Post)
        {
            Visible = true;
            trigger OnBeforeAction()
            begin
                rec.TESTFIELD("Location Code");
                rec."Posting Description" := Format(rec."Document Type") + ' ' + rec."Pay-to Name" + ' - Affaire ' + rec."Job No.";
                rec.Modify();

            end;
        }

        addafter(Post)
        {
            action(Post2)
            {
                //GL2024 Action SP car impossible de lodifie dans action ST
                ApplicationArea = Basic, Suite;
                Visible = false;
                Caption = '&Valider';
                Image = PostOrder;

                trigger OnAction()

                VAR
                    SalesHeader: Record "Sales Header";
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                    RecPurchaseLineSim: Record "Purchase Line";
                    PurchasesPayablesSetup: Record "Purchases & Payables Setup";
                    lNaviBatSetup: Record NavibatSetup;
                begin



                    //>> MH SORO 03-06-2020

                    //>> MH soro 03-06-2020
                    // IF "DTA Coding Line"='' THEN ERROR(Text003);
                    //<< MH soro 03-06-2020

                    //>> MH SORO 05-06-2020
                    RecLigneBureauOrdre.RESET;
                    RecLigneBureauOrdre.SETRANGE("Numero Fature Achat Associé", rec."No.");
                    IF RecLigneBureauOrdre.FINDFIRST THEN
                        REPEAT
                            RecLigneBureauOrdre."Date Vérification Facture" := TODAY;
                            RecLigneBureauOrdre.MODIFY;
                        UNTIL RecLigneBureauOrdre.NEXT = 0;
                    //<< MH SORO 05-06-2020


                    // >> HJ 06-01-2015
                    IF UserSetup.GET(UPPERCASE(USERID)) THEN;
                    //  IF NOT UserSetup."Validation Commande Achat" THEN ERROR(Text002);
                    // >> HJ 06-01-2015

                    // >> HJ 29-09-2015
                    rec."Date Vérification" := TODAY;
                    rec.MODIFY;
                    // >> HJ 29-09-2015
                    RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                    RecPurchaseLine.SETFILTER("Qty. to Receive", '%1', 0);
                    IF RecPurchaseLine.FINDFIRST THEN
                        REPEAT
                            RecPurchaseLine.VALIDATE("Qty. to Receive", RecPurchaseLine.Quantity);
                            RecPurchaseLine.MODIFY;
                        UNTIL RecPurchaseLine.NEXT = 0;
                    // >> HJ DSFT 03-10-2012



                    IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN
                    //ORIGIN CODE : CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)",Rec);
                    //FACTURATION_ACHAT
                    BEGIN
                        PurchSetup.GET;
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            Currpage.PurchLines.page.ApproveCalcInvDisc;
                            COMMIT;
                            rec.GET(rec."Document Type", rec."No.");
                        END;
                        wPurchPost.InitRequest(FALSE, FALSE);
                        wPurchPost.RUN(Rec);
                        //FACTURATION_ACHAT//
                    END
                end;
            }
        }
        addafter(Post_Promoted)
        {
            actionref(Post21; Post2)
            {

            }
        }

        modify(PostAndPrint)
        {
            Visible = false;
        }
        addafter(PostAndPrint)
        {
            action("Post and &Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Valider et imprimer';
                Image = PostPrint;


                trigger OnAction()
                VAR
                    SalesHeader: Record "Sales Header";
                    ApprovalMgt: Codeunit "Approvals Mgmt.";

                BEGIN



                    IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN
                    //ORIGIN CODE : CODEUNIT.RUN(CODEUNIT::"Purch.-Post + Print",Rec);
                    //GL2024 Code standrd comment //  Post(CODEUNIT::"Purch.-Post + Print");
                    //FACTURATION_ACHAT
                    BEGIN
                        PurchSetup.GET;
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            //CurrPage.PurchLines.PAGE.CalcInvDisc;
                            CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
                            COMMIT;
                        END;
                        wPurchPost.InitRequest(TRUE, FALSE);
                        wPurchPost.RUN(Rec);
                        //FACTURATION_ACHAT//
                    END
                end;
            }
        }
        addafter(Preview_Promoted)
        {
            actionref("Post and &Print1"; "Post and &Print")
            {

            }
        }

        addafter("P&osting")
        {
            action("&Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Imprimer';
                Image = Print;
                trigger OnAction()
                begin

                    // >> HJ DSFT 10-10-2012
                    IF rec.Status <> rec.Status::Released THEN ERROR(Text001);
                    RecPurchaseOrder.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseOrder.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"BON COMMANDE SOUROUBAT", TRUE, TRUE, RecPurchaseOrder);
                    // >> HJ DSFT 10-10-2012
                    // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action("Consultation Facture")
            {
                Caption = 'Consultation Facture';
                Visible = false;
                ApplicationArea = all;
                Image = Print;
                trigger OnAction()

                BEGIN

                    RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                    REPORT.RUNMODAL(50085, TRUE, TRUE, RecPurchaseLine);

                end;
            }
        }

    }
    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    begin
        /* IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
             rec.FILTERGROUP(2);
             rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
             rec.FILTERGROUP(0);
         END;*/
        FactFournBO := '';

        IF VendorMF.GET(rec."Buy-from Vendor No.") THEN MatriculeFiscale := VendorMF."VAT Registration No.";

        RecLigneBureauOrdre2.RESET;
        RecLigneBureauOrdre2.SETRANGE("Référence Ligne", rec."DTA Coding Line");
        IF RecLigneBureauOrdre2.FINDFIRST THEN FactFournBO := RecLigneBureauOrdre2."Numero Facture";
    end;

    trigger OnAfterGetRecord()
    begin

        FactFournBO := '';
        rec.SETRANGE("Document Type");
        //POSTING_DESC
        wDescr := rec.wShowPostingDescription(rec."Posting Description");
        //POSTING_DESC//
        // RB SORO 23/03/2016 SIMULATION FACTURE ACHAT
        UserSetup.GET(UPPERCASE(USERID));
        /* IF UserSetup."Simulation Doc Achat" THEN
             SimulationEDITABLE := (TRUE)
         ELSE
             SimulationEDITABLE := (FALSE);*/
        // RB SORO 23/03/2016 SIMULATION FACTURE ACHAT
        IF VendorMF.GET(rec."Buy-from Vendor No.") THEN MatriculeFiscale := VendorMF."VAT Registration No.";
        RecLigneBureauOrdre2.RESET;
        RecLigneBureauOrdre2.SETRANGE("Référence Ligne", rec."DTA Coding Line");
        IF RecLigneBureauOrdre2.FINDFIRST THEN FactFournBO := RecLigneBureauOrdre2."Numero Facture";
    end;



    trigger OnModifyRecord(): Boolean
    begin
        MatriculeFiscale := '';
    end;

    var
        wPurchPost: Codeunit "Purch. Order - Post";
        wDescr: Text[100];

        RecPurchaseOrder: Record "Purchase Header";
        CduPurchasePost: Codeunit "Purch.-Post";
        Cdupurchpostevent: Codeunit PurchPostEvent;
        UserSetup: Record "User Setup";
        RecVendorFODEC: Record Vendor;
        RecVendorPostingGroup: Record "Vendor Posting Group";
        RecPurchaseLine: Record "Purchase Line";
        MatriculeFiscale: Text[50];
        VendorMF: Record Vendor;
        RecLigneBureauOrdre: Record "Bureau Ordre Diffusion";
        RecLigneBureauOrdre2: Record "Bureau Ordre Diffusion";
        FactFournBO: Code[20];
        Text001: Label 'Vous Devez Lancer La Facture ?';
        Text002: Label 'Vous n''Avez Le Droit De Valider Les Factures';
        Text003: Label 'Vous Devez Inserer Référence Bureau d''ordre';
        PurchSetup: Record "Purchases & Payables Setup";

        //GL2024
        SimulationEDITABLE: Boolean;

}
