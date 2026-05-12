PageExtension 50020 "Item Card_PagEXT" extends "Item Card"
{
    Editable = true;
    layout
    {
        modify("Description 2")
        {
            Visible = true;
        }

        modify("Purchasing Code")
        {
            Visible = false;
        }


        modify(GTIN)
        {
            Visible = false;
        }

        modify("Common Item No.")
        {
            Visible = false;
        }

        modify("Dampener Period")
        {
            Visible = false;
        }
        modify("Dampener Quantity")
        {
            Visible = false;

        }

        modify("Item Category Code")
        {
            Visible = false;
        }
        addafter("Description 2")
        {

            field("Code Etude"; Rec."Code Etude")
            {
                ApplicationArea = all;
                Caption = 'Code Etude';
                Style = Unfavorable;
            }
            field("Seuil Max"; Rec."Seuil Max")
            {
                ApplicationArea = all;

                Style = Unfavorable;
            }
            field("Seuil Min"; Rec."Seuil Min")
            {
                ApplicationArea = all;
                Style = Attention;
                StyleExpr = true;
            }
            field("Alerte Declenche"; Rec."Alerte Declenche")
            {
                ApplicationArea = all;
                Style = AttentionAccent;
                StyleExpr = true;
            }

        }
        modify(Blocked)
        {
            visible = false;
        }

        modify("VariantMandatoryDefaultYes")
        {
            visible = false;
        }
        addafter(VariantMandatoryDefaultNo)
        {
            field("No. Series"; Rec."No. Series")
            {
                ApplicationArea = all;
            }

            field("PV Reception Requis"; rec."PV Reception Requis")
            {
                ApplicationArea = all;
            }
            field(Blocked1; Rec.Blocked)
            {
                ApplicationArea = all;
            }



            field(Statut; Rec.Statut)
            {
                ApplicationArea = all;
            }

            field(Synchronise; Rec.Synchronise)
            {
                ApplicationArea = all;
            }

            field(Emplacement; Rec.Emplacement)
            {
                ApplicationArea = all;
                Style = Strong;
            }
            // field("Appliquer Fodec"; Rec."Appliquer Fodec")
            // {
            //     ApplicationArea = all;
            // }
            field("Relation Volume / Tonnage"; Rec."Relation Volume / Tonnage")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Rapport Journalier"; Rec."Rapport Journalier")
            {
                ApplicationArea = all;
            }

            field("Tree Code"; Rec."Tree Code")
            {
                ApplicationArea = all;

            }
            // field("Item Type"; Rec."Item Type")
            // {
            //     ApplicationArea = all;
            // }
            field("Purchasing Code1"; rec."Purchasing Code")
            {
                ApplicationArea = all;
            }

            /* field("Designation Code Nature"; Rec."Designation Code Nature")
             {
                 ApplicationArea = all;
             }*/

            field("Type Carte"; Rec."Type Carte")
            {
                ApplicationArea = all;
            }
            /* field("Ancien Code"; Rec."Ancien Code")
             {
                 ApplicationArea = all;
             }*/
            grid(Recap1)
            {
                Visible = false;
                group(BarcodeButton)
                {
                    Visible = false;
                    ShowCaption = false;
                    // field(barcodeprinter; barcodeprinter)
                    // {
                    //     ShowCaption = false;
                    //     ApplicationArea = all;
                    //     trigger OnAssistEdit()
                    //     begin
                    //         Item.SETRANGE("No.", rec."No.");
                    //         REPORT.RUNMODAL(REPORT::"Article Barcode (Code128)", TRUE, TRUE, Item);
                    //     end;
                    // }
                }
                group("Barcode")
                {
                    ShowCaption = false;
                    field("Code à Barre"; rTempPic.Picture)
                    {
                        ApplicationArea = all;
                        Caption = 'Barcode';
                        ShowCaption = false;
                        Visible = false;

                    }
                }
            }



            /*    field("Emplacement DEPOT Z4"; Rec."Emplacement DEPOT Z4")
                {
                    Enabled = "Emplacement DEPOT Z4ENABLED";
                    ApplicationArea = all;
                }
                field("Emplacement Bati Depot z4"; Rec."Emplacement Bati Depot z4")
                {
                    ApplicationArea = all;
                }
                field("Emplacement MGH 113"; Rec."Emplacement MGH 113")
                {
                    Enabled = "Emplacement MGH 113ENABLED";
                    ApplicationArea = all;
                }
                field("Emplacement MGH 51"; Rec."Emplacement MGH 51")
                {
                    Enabled = "Emplacement MGH 51ENABLED";
                    ApplicationArea = all;
                }
                field("Emplacement BEJA LOT2"; Rec."Emplacement BEJA LOT2")
                {
                    Enabled = "Emplacement BEJA LOT2ENABLED";
                    ApplicationArea = all;
                }
                field("Emplacement BEJA LOT3"; Rec."Emplacement BEJA LOT3")
                {
                    Enabled = "Emplacement BEJA LOT3ENABLED";
                    ApplicationArea = all;
                }*/





        }
        modify(Inventory)
        {
            style = Favorable;
        }

        addafter(Inventory)
        {
            field("Stock Dispo."; rec.Inventory - rec."Qty. on Sales Order" + rec."Qty. on Purch. Order" + rec."Qty. on Prod. Order")
            {
                Caption = 'Stock Prévu';
                ApplicationArea = Basic, Suite;
                style = Favorable;
            }

            field("Qty. on Purchase Quote"; Rec."Qty. on Purchase Quote")
            {
                ApplicationArea = Basic, Suite;

            }
        }








        modify("Service Item Group")
        {
            Visible = false;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }

        addafter("Manufacturer Code")
        {



            field("Public Price"; Rec."Public Price")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

























        modify("Net Weight")
        {
            Visible = false;
        }
        modify("Gross Weight")
        {
            Visible = false;
        }

        addafter("Country/Region of Origin Code")
        {


            field("Net Weight2"; Rec."Net Weight")
            {
                ApplicationArea = all;
            }
            field("Gross Weight2"; Rec."Gross Weight")
            {
                ApplicationArea = all;
            }
        }



        addafter("Lot Size")
        {

            /* field("Remblais/Deblais"; Rec."Remblais/Deblais")
             {
                 ApplicationArea = all;
             }*/
        }









        modify("Purch. Unit of Measure")
        {
            Visible = false;
        }
        addafter("Purch. Unit of Measure")
        {
            field("Tariff Article"; Rec."Tariff Article")
            {
                ApplicationArea = all;

            }
            field(Subcontracting; Rec.Subcontracting)
            {
                ApplicationArea = all;

            }
            field("Rolled-up Material Cost"; Rec."Rolled-up Material Cost")
            {
                ApplicationArea = all;

            }
            field("Rolled-up Capacity Cost"; Rec."Rolled-up Capacity Cost")
            { ApplicationArea = all; }
        }




















        addafter(ItemTracking)
        {
            group("E-Commerce")
            {
                Caption = 'E-Commerce';
                field("Common Item No.2"; Rec."Common Item No.")
                {
                    ApplicationArea = all;
                }
            }
        }
        addbefore("Base Unit of Measure")
        {
            field("Purch. Unit of Measure1"; rec."Purch. Unit of Measure")
            {

            }
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Code Nature';
            Style = Attention;
            StyleExpr = true;
            ShowMandatory = true;
        }
        modify("VAT Prod. Posting Group")
        {
            Style = Attention;
            StyleExpr = true;
            ShowMandatory = true;
        }
        modify("Inventory Posting Group")
        {
            Style = Attention;
            StyleExpr = true;
            ShowMandatory = true;
        }
        addafter("Base Unit of Measure")
        {
            field("Sales Unit of Measure1"; rec."Sales Unit of Measure")
            {

            }
        }
        modify("Base Unit of Measure")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                lItemUnitOfMeasure: Record 5404;
                lUnitOfMeasure: Record 204;
            begin
                //+REF+UNIT
                WITH lItemUnitOfMeasure DO BEGIN
                    SETRANGE("Item No.", rec."No.");
                    IF ISEMPTY THEN BEGIN
                        IF page.RUNMODAL(0, lUnitOfMeasure) = ACTION::LookupOK THEN BEGIN
                            rec."Base Unit of Measure" := lUnitOfMeasure.Code;
                            "Item No." := rec."No.";
                            Code := rec."Base Unit of Measure";
                            "Qty. per Unit of Measure" := 1;
                            INSERT;
                            Rec.VALIDATE("Base Unit of Measure");
                        END;
                    END ELSE
                        IF page.RUNMODAL(0, lItemUnitOfMeasure) = ACTION::LookupOK THEN BEGIN
                            TESTFIELD("Qty. per Unit of Measure", 1);
                            rec."Base Unit of Measure" := Code;
                            Rec.VALIDATE("Base Unit of Measure");
                        END;
                END;
                //+REF+UNIT//

            end;

        }







        addafter("Use Cross-Docking")
        {
            field("Appliquer Redevance"; Rec."Appliquer Redevance")
            {
                ApplicationArea = all;
            }
            field("Montant Redevance"; Rec."Montant Redevance")
            {
                ApplicationArea = all;
            }
            field("Appliquer FS"; Rec."Appliquer FS")
            {
                ApplicationArea = all;
            }
            field("Montant FS"; Rec."Montant FS") { ApplicationArea = all; }
            field("Type Operation"; Rec."Type Operation")
            {
                ApplicationArea = all;
            }
            field(Coeficient; Rec.Coeficient)
            {
                ApplicationArea = all;
            }
            field("Calculer Cout Transport"; Rec."Calculer Cout Transport")
            {
                ApplicationArea = all;
            }
            field("Calculer Cout Transport Soutre"; Rec."Calculer Cout Transport Soutre")
            {
                ApplicationArea = all;
            }
            /*   field(Nature; Rec.Nature)
               {
                   ApplicationArea = all;
               }*/

            field(Dosage; Rec.Dosage)
            {
                ApplicationArea = all;
            }
            field(Adjuvant; Rec.Adjuvant)
            {
                ApplicationArea = all;
            }
        }

        addbefore(ItemPicture)
        {
            part("Article Par Magasin"; "Article Par Magasin")
            {
                Caption = 'Article Par Magasin';
                ApplicationArea = All;
                SubPageLink = Article = FIELD("No.");
            }
        }

    }
    actions
    {


        addafter(Dimensions)
        {
            action(Folder)
            {
                Caption = 'Folder';
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                VAR
                    lFolderManagement: Codeunit "Folder management";
                BEGIN

                    //+REF+FOLDER
                    lFolderManagement.Item(Rec);
                    //+REF+FOLDER//

                end;

            }
            //DYS action(Characteristics)
            //DYS  {
            //DYS  Caption = 'Characteristics';
            //DYS  ApplicationArea = all;
            //DYS page addon non migrer
            // RunObject = Page 8001403;
            // RunPageLink = "Table Name" = CONST(Item),
            //                   "No." = FIELD("No.");
            //DYS  }
        }
        addafter(Dimensions_Promoted)
        {
            actionref(Folder1; Folder)
            {

            }
        }

        addafter("E&xtended Texts")
        {
            action(Description)
            {
                Caption = 'Descriptions';
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    lDescription: Record "Description Line";
                BEGIN

                    lDescription.ShowDescription(27, 0, rec."No.", 0);

                end;
            }
        }
        addafter("E&xtended Texts_Promoted")
        {
            actionref(Description1; Description)
            {

            }
        }
        addafter(Identifiers)
        {
            //DYS  action("Linked documents")
            //DYS  {
            //DYS   Caption = 'Linked documents';
            //DYS  ApplicationArea = all;
            //DYS page addon non migrer
            // RunObject = Page 8004228;
            // RunPageLink = "Link Type Filter" = CONST(30),
            //                   "Link No. Filter" = FIELD("No.");
            //DYS }
            action("Dernier Numéro De La Famille")
            {
                Caption = 'Dernier Numéro De La Famille';
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    INTVal: Decimal;
                    IntTempo: Decimal;
                    CdeLAstNum: Code[20];
                begin

                    // >> HJ DSFT 30/01/2013
                    INTVal := 0;
                    //   RecItem.SETFILTER("No.", COPYSTR(rec."No.", 1, 7) + '*');
                    RecItem.SETFILTER("No.", COPYSTR(rec."No.", 1, 6) + '*');
                    //    IF RecItem.FINDLAST THEN MESSAGE(Text001, RecItem."No.");
                    //   EXIT;
                    IF RecItem.FINDFIRST THEN
                        REPEAT
                            EVALUATE(IntTempo, RecItem."No.");
                            IF INTVal < IntTempo THEN BEGIN
                                INTVal := IntTempo;
                                CdeLAstNum := RecItem."No.";
                            END;
                        UNTIL RecItem.NEXT = 0;
                    MESSAGE(Text001, CdeLAstNum);
                    // >> HJ DSFT 30/01/2013
                end;
            }
        }
        addafter(Attachments_Promoted)
        {
            actionref("Dernier Numéro De La Famille1"; "Dernier Numéro De La Famille")
            {

            }

        }
        addafter(Location)
        {
            group(Traçabilité1)
            {
                Caption = 'Traçabilité';

                action(Lot2)
                {
                    Caption = 'Lot';
                    ApplicationArea = all;
                    RunObject = Page "Lot No. Information List";
                    RunPageLink = "Item No." = FIELD("No.");

                }
                action("Serial No.")
                {
                    Caption = 'Serial No.';
                    ApplicationArea = all;
                    RunObject = Page "Serial No. Information List";
                    RunPageLink = "Item No." = FIELD("No.");
                }
            }

        }
        addafter(Location_Promoted)
        {
            group(Traçabilité)
            {
                Caption = 'Traçabilité';
                actionref(Lot21; Lot2)
                {

                }
                actionref("Serial No.1"; "Serial No.")
                {

                }
            }
        }

        //   addafter("Prepa&yment Percentages")
        //  {
        //    action("Discounts Price List")
        //    {
        //    ShortCutKey = 'Shift+F6';
        //    Caption = 'Discounts Price List';
        //    ApplicationArea = all;
        //DYS page addon non migrer
        // RunObject = Page 8004097;
        // Runpageview = SORTING(Type, Code);
        // runpagelink = Code = FIELD("No."), "Cost Filter" = FIELD("Standard Cost");


        //   }

        //   action("Purch. Invoiced Lines List")
        //  {
        //   Caption = 'Purch. Invoiced Lines List';
        //   ApplicationArea = all;
        //DYS page addon non migrer
        // RunObject = Page 8004098;
        // RunPageView = SORTING("Item Ledger Entry Type", "Source Type", "Item No.", "Cost per Unit", "Posting Date", "Source No.") ORDER(Ascending);
        // RunPageLink = "Item No." = FIELD("No."),
        //                   "Item Ledger Entry Type" = FILTER(Purchase);
        //   }

        // action(Quotes)
        // {
        //     Caption = 'Quotes';
        //     ApplicationArea = all;
        //     RunObject = Page 56;
        //     RunPageView = SORTING("Document Type", Type, "No.")
        //                       WHERE("Document Type" = FILTER(Quote),
        //                             "Attached to Doc. No." = FILTER(''));
        //     RunPageLink = Type = CONST(Item),
        //                       "No." = FIELD("No.");
        // }
        //  }

        /*   addafter("Co&mments")
           {
               GL2024  action("Statistics Criteria")
                 {
                     Caption = 'Statistics Criteria';
                     ApplicationArea = all;
                     trigger OnAction()
                     VAR
                         lItem: Record Item;
                     //DYS page addon non migrer
                     // lFormStatItem: Page 8001325;
                     BEGIN

                         lItem := Rec;
                         // lFormStatItem.SETRECORD(lItem);
                         // lFormStatItem.RUNMODAL();
                         Rec := lItem;
                         CurrPage.UPDATE(TRUE);

                     end;
                 }
                 action("Additionnals Informations")
                 {
                     Caption = 'Additionnals Informations';
                     ApplicationArea = all;

                     trigger OnAction()
                     VAR
                         lItem: Record Item;
                     //DYS page addon non migrer
                     //  lFormAddInfoItem: Page 8005121;
                     BEGIN

                         lItem := Rec;
                         // lFormAddInfoItem.SETRECORD(lItem);
                         // lFormAddInfoItem.RUNMODAL();
                         Rec := lItem;
                         CurrPage.UPDATE(TRUE);

                     end;
                 }
           }
           addafter("Co&mments_Promoted")
           {
               actionref("Statistics Criteria1"; "Statistics Criteria")
               {

               }
               actionref("Additionnals Informations1"; "Additionnals Informations")
               {

               }
           }*/
        addafter(ApplyTemplate)
        {
            /*GL2024  action(Copy)
              {
                  Caption = 'Copy';
                  ApplicationArea = all;
                  trigger OnAction()
                  begin

                      //+REF+COPY
                      rec.TESTFIELD("No.");
                      //#5332
                      rec.TESTFIELD(Blocked, FALSE);
                      //#5332//
                      rec.SETRANGE("No.", rec."No.");
                      //DYS REPORT addon non migrer
                      //REPORT.RUNMODAL(REPORT::"Copy Item", TRUE, FALSE, Rec);
                      //+REF+COPY//
                  end;

              }*/
            action("Mode Modification")
            {
                Caption = 'Mode Modification';
                ApplicationArea = all;
                Visible = FALSE;
                trigger OnAction()
                begin


                    //<< HJ DSFT   24-03-2012
                    IF CduEventCdu.GetAutorisationArticleUser(UPPERCASE(USERID)) THEN BEGIN
                        IF rec.Statut = 1 THEN BEGIN
                            rec.Statut := 0;
                            rec.MODIFY;
                        END;
                        SetEditable := TRUE;
                        Currpage.EDITABLE := SetEditable;
                    END;
                    //<< HJ DSFT   24-03-2012
                end;
            }
            action("Validate Item")
            {
                ShortCutKey = F11;
                Caption = 'Validate Article';
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    TextL003: Label 'Do you want to validate the item?';
                begin
                    //>> HJ DSFT-24-03-2012
                    IF rec.Statut = rec.Statut::"En Attente" THEN BEGIN
                        IF CONFIRM(TextL003) THEN BEGIN
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
            /*GL2024  actionref(copy1; copy)
              {

              }*/
            actionref("Mode Modification1"; "Mode Modification")
            {

            }
            actionref("Validate Item1"; "Validate Item")
            {

            }
            actionref(Comment21; Comment2)
            {

            }
        }

        addafter(ItemActionGroup)
        {
            /*action(Report)
            {
                Caption = 'Barcode';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    Item.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"Article Barcode (Code128)", TRUE, TRUE, Item);
                end;
            }*/
            /*GL2024    action("&Workflow")
                {
                    Caption = '&Workflow';
                    ApplicationArea = all;
                    trigger OnAction()
                    VAR
                        lRecordRef: RecordRef;
                        lWorkflowConnector: Codeunit "Workflow Connector";
                    BEGIN

                        lRecordRef.GETTABLE(Rec);
                        lWorkflowConnector.OnPush(PAGE::"Item Card", lRecordRef);
                    END;


                }*/
            action("Article par Magasin (Cliquer Ici)")
            {
                ApplicationArea = all;
                Caption = 'Article par Magasin (Cliquer Ici)';
                Image = Inventory;

                trigger OnAction()
                VAR
                    LUserSetup: Record "User Setup";
                BEGIN

                    ArticleParMagasin.RESET;
                    Magasin.RESET;
                    ArticleParMagasin.SETRANGE(Article, rec."No.");
                    ArticleParMagasin.DELETEALL;
                    // >> HJ SORO 26-02-2015
                    IF LUserSetup.GET(UPPERCASE(USERID)) THEN
                        // IF LUserSetup."Filtre Magasin" <> '' THEN Magasin.SETRANGE(Code, LUserSetup."Filtre Magasin");
                        // >> HJ SORO 29-02-2015

                        IF Magasin.FINDFIRST THEN
                            REPEAT
                                RecItem.SETRANGE("No.", rec."No.");
                                RecItem.SETFILTER("Location Filter", Magasin.Code);
                                IF RecItem.FINDFIRST THEN BEGIN
                                    RecItem.CALCFIELDS(Inventory);

                                    IF RecItem.Inventory <> 0 THEN BEGIN
                                        ArticleParMagasin.RESET;
                                        ArticleParMagasin.Article := rec."No.";
                                        ArticleParMagasin.Magasin := Magasin.Code;
                                        ArticleParMagasin.Quantité := RecItem.Inventory;
                                        ArticleParMagasin.INSERT;

                                    END;

                                END;
                            UNTIL Magasin.NEXT = 0;
                    CurrPage.UPDATE;
                END;

            }
            action(Comment2)
            {
                ApplicationArea = all;
                Caption = 'Comment';
                RunObject = page "Comment Sheet";
                RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
            }
        }
        addafter(Category_Report)
        {
            // actionref("Report1"; "Report")
            // {

            // }
            actionref("Article par Magasin (Cliquer Ici)1"; "Article par Magasin (Cliquer Ici)")
            {

            }

            /*GL2024   actionref("&Workflow1"; "&Workflow")
           {

           }*/
        }
    }
    trigger OnOpenPage()
    VAR
        lWorkflowSetup: Record "Workflow Setup";
        lRTCEditable: Boolean;
        zeadez: Page 9000;
    BEGIN
        IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
        CurrPage.EDITABLE(RecUserSetup."Modif Article");
        //+WKF+CUSTOM
        lRTCEditable := TRUE;
        IF gAddOnLicencePermission.HasPermissionWKF() THEN
            IF lWorkflowSetup.GET AND lWorkflowSetup."Block New Item" THEN
                lRTCEditable := FALSE;
        //#8371
        //Currpage.Blocked.EDITABLE := lRTCEditable;


        BlockedENABLED := lRTCEditable;
        //  FiltreMagasin;

        //#8371//
        //+WKF+CUSTOM//
        // >> HJ DSFT 24-03-2012;
        SetEditable := FALSE;
        //GL2024  Currpage.EDITABLE(SetEditable);
        // HJ DSFT 24-03-2012
        ArticleParMagasin.DELETEALL;

    end;

    trigger OnAfterGetRecord()
    begin
        // >> HJ DSFT 03-06-2012
        IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
        CurrPage.EDITABLE(RecUserSetup."Modif Article");
        rTempPic.INIT();
        C128MakeBarcode(rec."No.", rTempPic, 5300, 423, 96, TRUE);

        // >> HJ DSFT 03-06-2012
        //  FiltreMagasin;
    end;



    PROCEDURE C128MakeBarcode(BarcodeText: Text[250]; VAR Pic: Record "Company Information"; C128PicWidth: Integer; C128PicHeight: Integer; C128PicDPI: Integer; C128PlacePicRight: Boolean);
    VAR
        OStrm: OutStream;
        cWhite: Char;
        cBlack: Char;
        CharCode: Integer;
        Line: Integer;
        i: Integer;
        j: Integer;
        Modules: Integer;
        BMPLines: Integer;
        BarcodeTextLen: Integer;
        WhiteSpaces: Integer;
        Standard128BEN: Label '" !""#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~"';
        Standard128BDE: Label '" !""#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZŽ™š^_`abcdefghijklmnopqrstuvwxyz„”á"';
        Standard128B: Label '" !""#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZŽ™š^_`abcdefghijklmnopqrstuvwxyz„”á"';
        C128Checksum: Integer;
    BEGIN

        IF C128Bars[1] = '' THEN
            C128BcodeTab();

        cWhite := 255;
        cBlack := 0;

        BarcodeTextLen := STRLEN(BarcodeText);
        Modules := (BarcodeTextLen + 3) * 11 + 2; // Code128
        BMPLines := ROUND(Modules * 0.15, 1, '>');
        IF (C128PicWidth <> 0) AND (C128PicDPI <> 0) THEN BEGIN
            WhiteSpaces := ROUND(C128PicWidth / 2540 * C128PicDPI, 1, '>') - Modules;
            // Whitespaces = (minimum number of modules) - nedded modules
            IF WhiteSpaces < 0 THEN
                WhiteSpaces := 0;
        END ELSE // no information about the BMP
            WhiteSpaces := 0;

        Pic.Picture.CREATEOUTSTREAM(OStrm);
        FOR i := 1 TO ROUND((WhiteSpaces + Modules) * BMPLines * 3 / 1024, 1, '>') DO
            OStrm.WRITETEXT(PADSTR('', 1023, ' ')); // 1023 plus a NUL = 1024

        Pic.Picture.CREATEOUTSTREAM(OStrm);

        C128WriteBMPHeader(OStrm, (Modules + WhiteSpaces), BMPLines, C128PicWidth, C128PicHeight, C128PicDPI);

        FOR Line := 1 TO BMPLines DO BEGIN
            IF (C128PlacePicRight = TRUE) AND (WhiteSpaces > 0) THEN
                FOR i := 1 TO (WhiteSpaces * 3) DO
                    OStrm.WRITE(cWhite, 1);

            C128WriteBarcode(OStrm, 105); // 105 = StartB = Start barcode with Code128B
            C128Checksum := (105 - 1); // Startcodevalue is 105-1 = 104
            FOR i := 1 TO BarcodeTextLen DO BEGIN // analyze barcodetext and generate bars
                CharCode := STRPOS(Standard128B, FORMAT(BarcodeText[i])); // which number has the actual charater
                IF CharCode = 0 THEN // invalid character
                    CharCode := 1;     // replace invalid with space
                C128Checksum += i * (CharCode - 1); // Value for checksum is 1 less than position at the constant string
                C128WriteBarcode(OStrm, CharCode);
            END; // all characters of the barcodetext convertet to bars

            // checksum-character
            C128Checksum := C128Checksum MOD 103;
            C128WriteBarcode(OStrm, C128Checksum + 1); // +1 because of 1-based-array

            // Stop-Character
            C128WriteBarcode(OStrm, 106 + 1); // 106 is code for stopcharacter; has 13 modules

            // if barcode is to small for PicWidth, fill with white space on the right (if not filled on the left)
            IF (C128PlacePicRight = FALSE) AND (WhiteSpaces > 0) THEN
                FOR i := 1 TO (WhiteSpaces * 3) DO
                    OStrm.WRITE(cWhite, 1);

            // check if number of bytes is a multiple of 4 (because of BMP);
            // * 3 because each pixel needs 3 colorbytes (24bpp)
            j := (Modules + WhiteSpaces) * 3;
            IF j <> ROUND(j, 4, '>') THEN
                FOR i := j + 1 TO ROUND(j, 4, '>') DO
                    OStrm.WRITE(cWhite, 1); // fill with white

        END; // next BMP-Line
    END;

    PROCEDURE C128WriteBarcode(Strm: OutStream; C128ID: Integer);
    VAR
        j: Integer;
        ch: Char;
        BarcodeString: Text[20];
    BEGIN
        BarcodeString := C128Bars[C128ID]; // in BarcodeString is now the coding in bars of the given value
        FOR j := 1 TO STRLEN(BarcodeString) DO BEGIN // STRLEN(BC) is not fixed, it is 11 or 13 (13 for stopchar)
            IF BarcodeString[j] = 'b' THEN
                ch := 0     // black
            ELSE
                ch := 255;  // white
            Strm.WRITE(ch, 1);
            Strm.WRITE(ch, 1);
            Strm.WRITE(ch, 1); // write module; 3 byte = 1 pixel (24bpp)
        END;
    END;

    LOCAL PROCEDURE C128WriteBMPHeader(Strm: OutStream; Cols: Integer; Rows: Integer; Width: Integer; Height: Integer; DPI: Integer);
    VAR
        ch: Char;
        ResX: Integer;
        ResY: Integer;
        BMPSize: Integer;
    BEGIN

        IF DPI > 0 THEN BEGIN
            ResX := ROUND(39.37 * DPI, 1);
            ResY := ResX;
            IF Width > 0 THEN
                ResX := ROUND(Cols / Width * 100000, 1);
            IF Height > 0 THEN
                ResY := ROUND(Rows / Height * 100000, 1);
        END ELSE
            IF (Width > 0) AND (Height > 0) THEN BEGIN
                ResX := ROUND(Cols / Width * 100000, 1);
                ResY := ROUND(Rows / Height * 100000, 1);
            END;
        ch := 'B';
        Strm.WRITE(ch, 1);
        ch := 'M';
        Strm.WRITE(ch, 1);
        BMPSize := 54 +           // Header
        ROUND((Rows * 3), 4, '>') // Pixel per Line, per pixel 3 byte, a multiple of 4
         * Cols;                  // Lines
        Strm.WRITE(BMPSize, 4);
        Strm.WRITE(0, 4);
        Strm.WRITE(54, 4);
        Strm.WRITE(40, 4);          // Bytes in Header (40) (4 byte)
        Strm.WRITE(Cols, 4);        // Weight in pixel (4 byte); If not divisible by four padding is required.
        Strm.WRITE(Rows, 4);        // Height in pixel (4 byte); positive = bottom-up, negative = top-down (in theory; doesn't work).
        Strm.WRITE(65536 * 24 + 1); // only this way works (24bpp, +1)
        Strm.WRITE(0, 4);           // Compression: no (4 byte)
        Strm.WRITE(0, 4);           // Raw bitmap size (4 byte) (0=default for uncompressed)
        Strm.WRITE(ResX, 4);        // Pixels/metre Horizontal, dpm = 39.370 * dpi, screen = 96dpi (3780)
        Strm.WRITE(ResY, 4);        // Pixels/metre Vertical
        Strm.WRITE(0, 4);           // Colours in palette (0=no palette)
        Strm.WRITE(0, 4);           // Important colours, ignored.




    END;

    LOCAL PROCEDURE C128BcodeTab();
    BEGIN
        C128Bars[1] := 'bbwbbwwbbww'; // 00 (blank)
        C128Bars[2] := 'bbwwbbwbbww'; // 01 !
        C128Bars[3] := 'bbwwbbwwbbw'; // 02 "
        C128Bars[4] := 'bwwbwwbbwww'; // 03 #
        C128Bars[5] := 'bwwbwwwbbww'; // 04 $
        C128Bars[6] := 'bwwwbwwbbww'; // 05 %
        C128Bars[7] := 'bwwbbwwbwww'; // 06 &
        C128Bars[8] := 'bwwbbwwwbww'; // 07 '
        C128Bars[9] := 'bwwwbbwwbww'; // 08 (
        C128Bars[10] := 'bbwwbwwbwww'; // 09 )
        C128Bars[11] := 'bbwwbwwwbww'; // 10 *
        C128Bars[12] := 'bbwwwbwwbww'; // 11 +
        C128Bars[13] := 'bwbbwwbbbww'; // 12 ,
        C128Bars[14] := 'bwwbbwbbbww'; // 13 -
        C128Bars[15] := 'bwwbbwwbbbw'; // 14 .
        C128Bars[16] := 'bwbbbwwbbww'; // 15 /
        C128Bars[17] := 'bwwbbbwbbww'; // 16 0
        C128Bars[18] := 'bwwbbbwwbbw'; // 17 1
        C128Bars[19] := 'bbwwbbbwwbw'; // 18 2
        C128Bars[20] := 'bbwwbwbbbww'; // 19 3
        C128Bars[21] := 'bbwwbwwbbbw'; // 20 4
        C128Bars[22] := 'bbwbbbwwbww'; // 21 5
        C128Bars[23] := 'bbwwbbbwbww'; // 22 6
        C128Bars[24] := 'bbbwbbwbbbw'; // 23 7
        C128Bars[25] := 'bbbwbwwbbww'; // 24 8
        C128Bars[26] := 'bbbwwbwbbww'; // 25 9
        C128Bars[27] := 'bbbwwbwwbbw'; // 26 :
        C128Bars[28] := 'bbbwbbwwbww'; // 27 ;
        C128Bars[29] := 'bbbwwbbwbww'; // 28 <
        C128Bars[30] := 'bbbwwbbwwbw'; // 29 =
        C128Bars[31] := 'bbwbbwbbwww'; // 30 >
        C128Bars[32] := 'bbwbbwwwbbw'; // 31 ?
        C128Bars[33] := 'bbwwwbbwbbw'; // 32 @
        C128Bars[34] := 'bwbwwwbbwww'; // 33 A
        C128Bars[35] := 'bwwwbwbbwww'; // 34 B
        C128Bars[36] := 'bwwwbwwwbbw'; // 35 C
        C128Bars[37] := 'bwbbwwwbwww'; // 36 D
        C128Bars[38] := 'bwwwbbwbwww'; // 37 E
        C128Bars[39] := 'bwwwbbwwwbw'; // 38 F
        C128Bars[40] := 'bbwbwwwbwww'; // 39 G
        C128Bars[41] := 'bbwwwbwbwww'; // 40 H
        C128Bars[42] := 'bbwwwbwwwbw'; // 41 I
        C128Bars[43] := 'bwbbwbbbwww'; // 42 J
        C128Bars[44] := 'bwbbwwwbbbw'; // 43 K
        C128Bars[45] := 'bwwwbbwbbbw'; // 44 L
        C128Bars[46] := 'bwbbbwbbwww'; // 45 M
        C128Bars[47] := 'bwbbbwwwbbw'; // 46 N
        C128Bars[48] := 'bwwwbbbwbbw'; // 47 O
        C128Bars[49] := 'bbbwbbbwbbw'; // 48 P
        C128Bars[50] := 'bbwbwwwbbbw'; // 49 Q
        C128Bars[51] := 'bbwwwbwbbbw'; // 50 R
        C128Bars[52] := 'bbwbbbwbwww'; // 51 S
        C128Bars[53] := 'bbwbbbwwwbw'; // 52 T
        C128Bars[54] := 'bbwbbbwbbbw'; // 53 U
        C128Bars[55] := 'bbbwbwbbwww'; // 54 V
        C128Bars[56] := 'bbbwbwwwbbw'; // 55 W
        C128Bars[57] := 'bbbwwwbwbbw'; // 56 X
        C128Bars[58] := 'bbbwbbwbwww'; // 57 Y
        C128Bars[59] := 'bbbwbbwwwbw'; // 58 Z
        C128Bars[60] := 'bbbwwwbbwbw'; // 59 [
        C128Bars[61] := 'bbbwbbbbwbw'; // 60 \
        C128Bars[62] := 'bbwwbwwwwbw'; // 61 ]
        C128Bars[63] := 'bbbbwwwbwbw'; // 62 ^
        C128Bars[64] := 'bwbwwbbwwww'; // 63 _
        C128Bars[65] := 'bwbwwwwbbww'; // 64 ` NUL
        C128Bars[66] := 'bwwbwbbwwww'; // 65 a SOH
        C128Bars[67] := 'bwwbwwwwbbw'; // 66 b STX
        C128Bars[68] := 'bwwwwbwbbww'; // 67 c ETX
        C128Bars[69] := 'bwwwwbwwbbw'; // 68 d EOT
        C128Bars[70] := 'bwbbwwbwwww'; // 69 e ENQ
        C128Bars[71] := 'bwbbwwwwbww'; // 70 f ACK
        C128Bars[72] := 'bwwbbwbwwww'; // 71 g BEL
        C128Bars[73] := 'bwwbbwwwwbw'; // 72 h BS
        C128Bars[74] := 'bwwwwbbwbww'; // 73 i HT
        C128Bars[75] := 'bwwwwbbwwbw'; // 74 j LF
        C128Bars[76] := 'bbwwwwbwwbw'; // 75 k VT
        C128Bars[77] := 'bbwwbwbwwww'; // 76 l FF
        C128Bars[78] := 'bbbbwbbbwbw'; // 77 m CR
        C128Bars[79] := 'bbwwwwbwbww'; // 78 n SO
        C128Bars[80] := 'bwwwbbbbwbw'; // 79 o SI
        C128Bars[81] := 'bwbwwbbbbww'; // 80 p DLE
        C128Bars[82] := 'bwwbwbbbbww'; // 81 q DC1
        C128Bars[83] := 'bwwbwwbbbbw'; // 82 r DC2
        C128Bars[84] := 'bwbbbbwwbww'; // 83 s DC3
        C128Bars[85] := 'bwwbbbbwbww'; // 84 t DC4
        C128Bars[86] := 'bwwbbbbwwbw'; // 85 u NAK
        C128Bars[87] := 'bbbbwbwwbww'; // 86 v SYN
        C128Bars[88] := 'bbbbwwbwbww'; // 87 w ETB
        C128Bars[89] := 'bbbbwwbwwbw'; // 88 x CAN
        C128Bars[90] := 'bbwbbwbbbbw'; // 89 y EM
        C128Bars[91] := 'bbwbbbbwbbw'; // 90 z SUB
        C128Bars[92] := 'bbbbwbbwbbw'; // 91 { ESC
        C128Bars[93] := 'bwbwbbbbwww'; // 92 | FS
        C128Bars[94] := 'bwbwwwbbbbw'; // 93 } GS
        C128Bars[95] := 'bwwwbwbbbbw'; // 94 ~ RS
        C128Bars[96] := 'bwbbbbwbwww'; // 95 del US
        C128Bars[97] := 'bwbbbbwwwbw'; // 96 func3
        C128Bars[98] := 'bbbbwbwbwww'; // 97 func2
        C128Bars[99] := 'bbbbwbwwwbw'; // 98 shift
        C128Bars[100] := 'bwbbbwbbbbw'; // 99 CodeC
        C128Bars[101] := 'bwbbbbwbbbw'; // CodeB func4 CodeB
        C128Bars[102] := 'bbbwbwbbbbw'; // CodeA CodeA
        C128Bars[103] := 'bbbbwbwbbbw'; // func1 func1
        C128Bars[104] := 'bbwbwwwwbww'; // StartA StartA
        C128Bars[105] := 'bbwbwwbwwww'; // StartB StartB
        C128Bars[106] := 'bbwbwwbbbww'; // StartC StartC
        C128Bars[107] := 'bbwwwbbbwbwbb'; // Stop Stop
    END;


    /* PROCEDURE FiltreMagasin();
     VAR
         LUserSetup: Record "User Setup";
     begin


         // >> HJ SORO 11-07-2014
         IF LUserSetup.GET(UPPERCASE(USERID)) THEN
             IF LUserSetup."Filtre Magasin" <> '' THEN
                 rec.SETFILTER("Location Filter", LUserSetup."Filtre Magasin")
             ELSE
                 rec.SETRANGE("Location Filter");
         // >> HJ SORO 11-07-2014
         IF LUserSetup."Filtre Magasin" <> '' THEN BEGIN
             IF LUserSetup."Filtre Magasin" = 'DEPOT Z4' THEN BEGIN
                 "Emplacement DEPOT Z4ENABLED" := TRUE;
                 // "Emplacement MGH 13ENABLED":=FALSE;
                 "Emplacement MGH 113ENABLED" := FALSE;
                 "Emplacement MGH 51ENABLED" := FALSE;
                 "Emplacement BEJA LOT2ENABLED" := FALSE;
                 "Emplacement BEJA LOT3ENABLED" := FALSE;
             END;
             IF LUserSetup."Filtre Magasin" = 'MGHLOT13' THEN BEGIN
                 "Emplacement DEPOT Z4ENABLED" := FALSE;
                 //  "Emplacement MGH 13ENABLED":=TRUE;
                 "Emplacement MGH 113ENABLED" := FALSE;
                 "Emplacement MGH 51ENABLED" := FALSE;
                 "Emplacement BEJA LOT2ENABLED" := FALSE;
                 "Emplacement BEJA LOT3ENABLED" := FALSE;

             END;

             IF LUserSetup."Filtre Magasin" = 'BATMGIRALO' THEN BEGIN
                 "Emplacement DEPOT Z4ENABLED" := FALSE;
                 //  "Emplacement MGH 13ENABLED":=FALSE;
                 "Emplacement MGH 113ENABLED" := TRUE;
                 "Emplacement MGH 51ENABLED" := FALSE;
                 "Emplacement BEJA LOT2ENABLED" := FALSE;
                 "Emplacement BEJA LOT3ENABLED" := FALSE;

             END;
             IF LUserSetup."Filtre Magasin" = 'MGHLOT51' THEN BEGIN
                 "Emplacement DEPOT Z4ENABLED" := FALSE;
                 // "Emplacement MGH 13ENABLED":=FALSE;
                 "Emplacement MGH 113ENABLED" := FALSE;
                 "Emplacement MGH 51ENABLED" := TRUE;
                 "Emplacement BEJA LOT2ENABLED" := FALSE;
                 "Emplacement BEJA LOT3ENABLED" := FALSE;

             END;
             IF LUserSetup."Filtre Magasin" = 'BEJALOT2' THEN BEGIN
                 "Emplacement DEPOT Z4ENABLED" := FALSE;
                 // "Emplacement MGH 13ENABLED":=FALSE;
                 "Emplacement MGH 113ENABLED" := FALSE;
                 "Emplacement MGH 51ENABLED" := FALSE;
                 "Emplacement BEJA LOT2ENABLED" := TRUE;
                 "Emplacement BEJA LOT3ENABLED" := FALSE;

             END;
             IF LUserSetup."Filtre Magasin" = 'BEJALOT3' THEN BEGIN
                 "Emplacement DEPOT Z4ENABLED" := FALSE;
                 //   "Emplacement MGH 13ENABLED":=FALSE;
                 "Emplacement MGH 113ENABLED" := FALSE;
                 "Emplacement MGH 51ENABLED" := FALSE;
                 "Emplacement BEJA LOT2ENABLED" := FALSE;
                 "Emplacement BEJA LOT3ENABLED" := TRUE;

             END;

         END;
     end;*/

    trigger OnNewRecord(BelowxRec: Boolean)
    VAR
        lRecordRef: RecordRef;
        lTemplateMgt: Codeunit "Config. Template Management";
        CduFunction: Codeunit SoroubatFucntion;
    begin

        //+REF+TEMPLATE
        lRecordRef.GETTABLE(Rec);
        IF NOT CduFunction.GetTemplate(lRecordRef) THEN
            Currpage.CLOSE;
        lRecordRef.SETTABLE(Rec);
        //+REF+TEMPLATE//
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    VAR
        lProcessusWKFIntegr: Codeunit "Processus workflow Integr.";
    begin

        //+WKF+CUSTOM
        IF gAddOnLicencePermission.HasPermissionWKF() THEN
            lProcessusWKFIntegr.OnInsertItem(Rec);
        //+WKF+CUSTOM//
    end;


    var
        wInvPostingGroup: Record "Inventory Posting Group";
        gAddOnLicencePermission: Codeunit IntegrManagement;
        "// HJ DSFT": Integer;
        RecUserSetup: Record "User Setup";
        SetEditable: Boolean;
        CduUserSetupManagement: Codeunit "User Setup Management";
        RecItem: Record Item;
        rTempPic: Record "Company Information" TEMPORARY;
        "*** ab hier fr Code128": Integer;
        C128Bars: ARRAY[107] OF Text[13];
        Item: Record Item;
        ArticleParMagasin: Record "Article Par Magasin";
        Magasin: Record Location;
        Text001: Label 'The last assigned number is %1';
        BlockedENABLED: Boolean;
        CduEventCdu: Codeunit Event_Codeunit;
        barcodeprinter: label 'Barcode';

        "Emplacement DEPOT Z4ENABLED": Boolean;
        // Emplacement MGH 13ENABLEDc
        "Emplacement MGH 113ENABLED": Boolean;
        "Emplacement MGH 51ENABLED": Boolean;
        "Emplacement BEJA LOT2ENABLED": Boolean;
        "Emplacement BEJA LOT3ENABLED": Boolean;

}


