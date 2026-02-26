report 8003997 "Batch Post Product Sales"
{
    //Id navision 8003997
    // //PROJET_FACT GESWAY 19/05/03 Ajout fonction wInitializeRequest, wShowOption
    //                               SaveValues du RequestForm à non
    //                               Modification message final

    Caption = 'Valider avancement en production';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterHeading = 'Sales Order';

            trigger OnAfterGetRecord()
            var
            //  RecDetailAvancementProd: Record 50001;
            begin
                // >> HJ DSFT 27-06-2012
                IF 1 = 1 THEN BEGIN
                    IF RecJobsSetup.GET THEN;
                    RecJobJournalLine.SETRANGE("Journal Template Name", RecJobsSetup."JouranTemplate Consommation");
                    RecJobJournalLine.SETRANGE("Journal Batch Name", RecJobsSetup."Batch Template");
                    IF RecJobJournalLine.FINDLAST THEN IntCompteur := RecJobJournalLine."Line No.";
                    RecSalesLine.SETRANGE("Document Type", RecSalesLine."Document Type"::Order);
                    RecSalesLine.SETRANGE("Document No.", "No.");
                    RecSalesLine.SETRANGE("Line Type", RecSalesLine."Line Type"::Structure);
                    RecSalesLine.SETFILTER("Qty. to Ship", '<>%1', 0);
                    IF RecSalesLine.FINDFIRST THEN
                        REPEAT
                            RecSalesLineDetailOuv.SETRANGE("Document Type", RecSalesLine."Document Type"::Order);
                            RecSalesLineDetailOuv.SETRANGE("Document No.", "No.");
                            RecSalesLineDetailOuv.SETRANGE("Structure Line No.", RecSalesLine."Line No.");
                            IF RecSalesLineDetailOuv.FINDFIRST THEN
                                REPEAT
                                    IF BlnGegereConsomTheo THEN BEGIN
                                        IntCompteur += 10000;
                                        RecJobJournalLine.INIT;
                                        RecJobJournalLine."Journal Template Name" := RecJobsSetup."JouranTemplate Consommation";
                                        RecJobJournalLine."Journal Batch Name" := RecJobsSetup."Batch Template";
                                        RecJobJournalLine."Source Code" := RecJobsSetup."Code Journal";
                                        RecJobJournalLine.VALIDATE("Line No.", IntCompteur);
                                        RecJobJournalLine.VALIDATE("Job No.", "Sales Header"."Job No.");
                                        RecJobJournalLine.VALIDATE("Posting Date", PostingDateReq);
                                        IF RecSalesLineDetailOuv."Line Type" = RecSalesLineDetailOuv."Line Type"::Item THEN
                                            RecJobJournalLine.VALIDATE(Type, RecJobJournalLine.Type::Item)
                                        ELSE
                                            RecJobJournalLine.Type := RecJobJournalLine.Type::Resource;
                                        RecJobJournalLine.VALIDATE("No.", RecSalesLineDetailOuv."No.");
                                        RecJobJournalLine.VALIDATE("Quantité Theorique", RecSalesLine."Qty. to Ship" * RecSalesLineDetailOuv."Quantity per");
                                        RecJobJournalLine.INSERT(TRUE);
                                    END;
                                //  Insertion Detail Production
                                /*    RecDetailAvancementProd."Order N°" := RecSalesLine."Document No.";
                                    RecDetailAvancementProd.Job := "Sales Header"."Job No.";
                                    RecDetailAvancementProd."Job Task" := RecSalesLine."Job Task No.";
                                    RecDetailAvancementProd."Theorique Quantity" := RecSalesLine."Qty. to Ship" * RecSalesLineDetailOuv."Quantity per";

                                    IF RecSalesLineDetailOuv."Line Type" = RecSalesLineDetailOuv."Line Type"::Item THEN
                                        RecDetailAvancementProd."Line Type" := RecDetailAvancementProd."Line Type"::Item;

                                    IF RecSalesLineDetailOuv."Line Type" = RecSalesLineDetailOuv."Line Type"::Machine THEN
                                        RecDetailAvancementProd."Line Type" := RecDetailAvancementProd."Line Type"::Machine;

                                    IF RecSalesLineDetailOuv."Line Type" = RecSalesLineDetailOuv."Line Type"::Person THEN
                                        RecDetailAvancementProd."Line Type" := RecDetailAvancementProd."Line Type"::Person;

                                    RecDetailAvancementProd."Posting Date" := "Sales Header"."Posting Date";
                                    RecDetailAvancementProd."No." := RecSalesLineDetailOuv."No.";
                                    RecDetailAvancementProd."No. Structure" := RecSalesLine."No.";
                                    RecDetailAvancementProd."Structure Description" := RecSalesLine.Description;
                                    RecDetailAvancementProd.Description := RecSalesLineDetailOuv.Description;
                                    RecDetailAvancementProd."Initil Quantity" := RecSalesLineDetailOuv.Quantity;
                                    RecDetailAvancementProd."Order Line No." := RecSalesLine."Line No.";
                                    RecDetailAvancementProd."Line No." := RecSalesLineDetailOuv."Line No.";
                                    RecDetailAvancementProd."Input Date" := CURRENTDATETIME;
                                    RecDetailAvancementProd.INSERT;*/
                                // RecDetailAvancementProd.Description:=
                                //  Insertion Detail Production
                                UNTIL RecSalesLineDetailOuv.NEXT = 0;
                        UNTIL RecSalesLine.NEXT = 0;
                END;
                // >> HJ DSFT 27-06-2012

                //IF CalcInvDisc THEN
                //  CalculateInvoiceDiscount;

                Counter := Counter + 1;
                IF NOT wFromPosting THEN
                    Window.UPDATE(1, "No.");
                IF NOT wFromPosting THEN
                    Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                "Sales Header".Ship := ShipReq;
                "Sales Header".Invoice := InvReq;

                CLEAR(SalesPost);
                //hs     SalesPost.SetPostingDate(ReplacePostingDate, ReplaceDocumentDate, PostingDateReq);
                SalesPost.RUN("Sales Header");
                CounterOK := CounterOK + 1;
                IF MARKEDONLY THEN
                    MARK(FALSE);
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                //PROJET_FACT
                IF wThroughInit AND InvReq AND (CounterOK = CounterTotal) THEN
                    MESSAGE(Text8003980, CounterOK, CounterTotal)
                ELSE
                    IF (wThroughInit OR wFromPosting) AND ShipReq AND (CounterOK = CounterTotal) THEN
                        MESSAGE(Text8003981);
                IF NOT wThroughInit AND NOT wFromPosting THEN
                    //PROJET_FACT//
                    MESSAGE(Text002, CounterOK, CounterTotal);
            end;

            trigger OnPreDataItem()
            begin
                IF PostingDateReq = 0D THEN
                    ERROR(Text000);
                CounterTotal := COUNT;
                IF wFromPosting THEN
                    Window.OPEN(Text8003982)
                ELSE
                    Window.OPEN(Text001);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDateReq; PostingDateReq)
                    {
                        Caption = 'Date comptabilisation';

                        trigger OnValidate()
                        begin
                            PostingDateReqOnAfterValidate;
                        end;
                    }
                    field(ReplacePostingDate; ReplacePostingDate)
                    {
                        Caption = 'Remplacer date comptabilisation';

                        trigger OnValidate()
                        begin
                            IF ReplacePostingDate THEN
                                MESSAGE(Text003);
                        end;
                    }
                    field(ReplaceDocumentDate; ReplaceDocumentDate)
                    {
                        Caption = 'Remplacer date document';
                    }
                    field(BlnGegereConsomTheo; BlnGegereConsomTheo)
                    {
                        Caption = 'Génèrer Consommation Theorique';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            SalesSetup.GET;
            CalcInvDisc := SalesSetup."Calc. Inv. Discount";
            ReplacePostingDate := FALSE;
            ReplaceDocumentDate := FALSE;
        end;
    }

    labels
    {
    }

    var
        Text000: Label 'Veuillez saisir une date de comptabilisation.';
        Text001: Label 'Validation des commandes #1########## @2@@@@@@@@@@@@@';
        Text002: Label '%1 commande(s) sur %2 enregistrée(s).';
        Text003: Label 'Le taux de change associé à la nouvelle date de comptabilisation de l''en-tête vente ne s''appliquera pas aux lignes vente..';
        SalesLine: Record 37;
        SalesSetup: Record 311;
        SalesCalcDisc: Codeunit 60;
        SalesPost: Codeunit 80;
        SalesPosfeft: Codeunit "Sales-Post (Yes/No)";
        Window: Dialog;
        ShipReq: Boolean;
        InvReq: Boolean;
        PostingDateReq: Date;
        CounterTotal: Integer;
        Counter: Integer;
        CounterOK: Integer;
        ReplacePostingDate: Boolean;
        ReplaceDocumentDate: Boolean;
        CalcInvDisc: Boolean;
        SendShipNotif: Boolean;
        wThroughInit: Boolean;
        Text8003980: Label '%1 commande(s) sur %2 validée(s).';
        Text8003981: Label 'Les productions ont été validées avec succès.';
        wFromPosting: Boolean;
        Text8003982: Label 'Validation des productions #1########## @2@@@@@@@@@@@@@';
        "// HJ DSFT": Integer;
        RecJobJournalLine: Record 8004165;
        RecJobsSetup: Record 315;
        RecSalesLine: Record 37;
        RecSalesLineDetailOuv: Record 37;
        IntCompteur: Integer;
        BlnGegereConsomTheo: Boolean;

    procedure CalculateInvoiceDiscount()
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", "Sales Header"."Document Type");
        SalesLine.SETRANGE("Document No.", "Sales Header"."No.");
        IF SalesLine.FIND('-') THEN
            IF SalesCalcDisc.RUN(SalesLine) THEN BEGIN
                "Sales Header".GET("Sales Header"."Document Type", "Sales Header"."No.");
                COMMIT;
            END;
    end;


    procedure wInitializeRequest(pShip: Boolean; pInvoice: Boolean)
    begin
        ShipReq := pShip;
        InvReq := pInvoice;
        wThroughInit := TRUE;
    end;


    procedure InitializeFromPosting(pPostingDate: Date)
    begin
        ShipReq := TRUE;
        InvReq := FALSE;
        wThroughInit := FALSE;
        PostingDateReq := pPostingDate;
        //4582
        IF pPostingDate <> 0D THEN BEGIN
            ReplacePostingDate := TRUE;
            ReplaceDocumentDate := TRUE;
        END;
        //4582//
        wFromPosting := TRUE;
    end;

    local procedure PostingDateReqOnAfterValidate()
    begin
        IF wThroughInit THEN BEGIN
            ReplacePostingDate := TRUE;
            ReplaceDocumentDate := TRUE;
        END;
    end;
}

