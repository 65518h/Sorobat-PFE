PageExtension 50021 "Item List_PagEXT" extends "Item List"
{
    Editable = true;
    layout
    {
        addafter(Description)
        {

            field("Dernier date achat"; Rec."Dernier date achats")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dernier Date d''achat field.', Comment = '%';
                style = unfavorable;
            }
            field("Dernier Prix achat"; Rec."Dernier Prix achats")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dernier Prix d''achat field.', Comment = '%';
                style = unfavorable;
            }
        }
        modify("Vendor Item No.")
        {
            Visible = false;
        }
        addbefore(Description)
        {
            field("Code Etude1"; Rec."Code Etude")
            {
                ApplicationArea = all;
                Caption = 'Code Etude';
            }
        }
        modify("Gen. Prod. Posting Group")
        {
            visible = true;
        }
        addafter("InventoryField")
        {
            field(Emplacement; Rec.Emplacement)
            {
                ApplicationArea = all;
            }
            /*  field("Bill of Materials"; Rec."Bill of Materials")
              {
                  ApplicationArea = all;
              }*/
            field("Public Price"; Rec."Public Price")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Best Discount"; Rec."Best Discount")
            {
                ApplicationArea = all;
                Visible = false;


            }
            field("Best Cost"; ROUND(rec."Public Price" * (1 - rec."Best Discount" / 100), 0.01))
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Best Register Cost"; Rec."Best Register Cost")
            {
                ApplicationArea = all;
                Visible = false;
                //GL2024 DrillDownPageId = "Value Entries Best Cost";
            }


        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        addafter("Replenishment System")
        {
            field("Characteristic 1"; Rec."Characteristic 1")
            {
                ApplicationArea = all;
                Visible = false;
            }

            field("Characteristic 2"; Rec."Characteristic 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Characteristic 3"; Rec."Characteristic 3")
            {
                ApplicationArea = all;
                Visible = false;
            }
            /* field("Manufacturing Policy"; Rec."Manufacturing Policy")
             {
                 ApplicationArea = all;      Visible = false;
             }*/
            field("Characteristic 4"; Rec."Characteristic 4")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Flushing Method2"; Rec."Flushing Method")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Characteristic 5"; Rec."Characteristic 5")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Item Tracking Code2"; Rec."Item Tracking Code")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Characteristic 6"; Rec."Characteristic 6")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Characteristic 7"; Rec."Characteristic 7")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Characteristic 8"; Rec."Characteristic 8")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Characteristic 9"; Rec."Characteristic 9")
            {
                ApplicationArea = all;
                Visible = false;
            }

        }
        modify("Base Unit of Measure")
        {
            visible = true;
        }
        modify("Unit Cost")
        {
            Editable = false;
        }
        modify("No.")
        {
            Editable = false;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Description 2")
        {
            Visible = false;
        }
        modify("Substitutes Exist")
        {
            Visible = false;
        }
        modify("Stockkeeping Unit Exists")
        {
            Visible = false;
        }
        modify("Assembly BOM")
        {
            Visible = false;
        }
        modify("Production BOM No.")
        {
            Visible = false;
        }
        modify("Routing No.")
        {
            Visible = false;
        }

        modify("Shelf No.")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Unit Price")
        {
            Visible = true;
        }
        modify("Vendor No.")
        {
            Visible = true;
        }


        modify(InventoryField)
        {
            Visible = true;
            Editable = false;
            Style = StrongAccent;
            StyleExpr = true;
        }
        modify("Last Direct Cost")
        {
            Visible = false;
            Editable = false;
        }

        /*  addafter("No.")
          {
              field("Base Unit of Measure2"; Rec."Base Unit of Measure")
              {
                  ApplicationArea = all;
                  Editable = true;
              }
          }*/

        addafter("Last Direct Cost")
        {
            /* field("Emplacement Bati Depot z4"; Rec."Emplacement Bati Depot z4")
             {
                 Editable = TRUE;
                 ApplicationArea = all;
             }*/
            field("Tree Code"; Rec."Tree Code")
            {
                Editable = TRUE;
                ApplicationArea = all;
                Visible = false;
                Caption = 'Tree Code';

            }

        }

        addafter("No.")
        {
            field("Code Etude"; Rec."Code Etude")
            {
                ApplicationArea = all;
                Editable = FALSE;
                Visible = false;

            }
        }
        addafter("Vendor Item No.")
        {
            field("Search Description1"; rec."Search Description")
            {

            }
        }
        addbefore(Control1)
        {


            /*   field("Search Description2"; wSearchFilter)
               {

                   ApplicationArea = all;
                   Caption = 'Désignation de recherche';
                   trigger OnValidate()
                   begin
                       //#5329
                       //RECHERCHE_ARTICLE
                       wSetFilters;
                       //RECHERCHE_ARTICLE//
                       //#5329//
                   end;

               }
               field("Search Option"; gSearchOption)
               {
                   ApplicationArea = all;
                   Caption = 'Option de recherche';
                   trigger OnValidate()
                   begin
                       //#8324
                       wSetFilters;
                       //#8324//
                   end;
               }
               field("Groupe compta. stock"; wInvPostingFilter)
               {
                   ApplicationArea = all;
                   Caption = 'Groupe compta. stock';
                   TableRelation = "Inventory Posting Group";
                   trigger OnValidate()
                   begin
                       //ITEM_CHARACT
                       wGetCharasteristicFilters;
                       //ITEM_CHARACT//
                       //RECHERCHE_ARTICLE
                       wSetFilters;
                       //RECHERCHE_ARTICLE//
                   end;

               }
               field("Location Filter"; Rec."Location Filter")
               {
                   ApplicationArea = all;
                   Caption = 'Filtre magasin';
               }
               field("Gen. Prod. Posting Group2"; wGenProdPostingFilter)
               {
                   ApplicationArea = all;
                   Caption = 'Code nature';
                   TableRelation = "Gen. Product Posting Group";
                   trigger OnValidate()
                   begin
                       //#8132
                       wSetFilters;
                       //#8132//
                   end;

               }


               field("Manufacturer Code"; wManufacturerFilter)
               {
                   ApplicationArea = all;
                   Caption = 'Code fabricant';

                   trigger OnValidate()
                   begin
                       //RECHERCHE_ARTICLE
                       wSetFilters;
                       //RECHERCHE_ARTICLE//
                   end;

                   trigger OnLookup(var Text: Text): Boolean
                   VAR
                       lManufacturer: Record Manufacturer;
                   BEGIN

                       //RECHERCHE_ARTICLE
                       lManufacturer.FIND('-');
                       IF PAGE.RUNMODAL(PAGE::Manufacturers, lManufacturer) = ACTION::LookupOK THEN BEGIN
                           IF wManufacturerFilter = '' THEN
                               wManufacturerFilter := lManufacturer.Code
                           ELSE
                               wManufacturerFilter := wManufacturerFilter + STRSUBSTNO('|%1', lManufacturer.Code);
                       END;
                       wSetFilters;
                       //RECHERCHE_ARTICLE//

                   end;
               }

               field("Item No."; wSearchNo)
               {
                   ApplicationArea = all;
                   Caption = 'N° article.';
                   trigger OnValidate()
                   begin
                       //RECHERCHE_ARTICLE
                       wSetFilters;
                       //RECHERCHE_ARTICLE//
                   end;
               }*/
            field("Nom Famille"; wFamille)
            {
                Caption = 'Famille';
                ApplicationArea = all;
                TableRelation = Tree.Code;
                trigger OnValidate()
                begin
                    //RECHERCHE_ARTICLE
                    wSetFilters;
                    //RECHERCHE_ARTICLE//
                end;

            }



        }
        addafter(Control1)
        {
            group(Caractéristiques)
            {
                Visible = false;
                Caption = 'Caractéristiques';
                //Visible = "wFilterCaract9VISIBLE" or "wFilterCaract8VISIBLE" or "wFilterCaract7VISIBLE" or "wFilterCaract6VISIBLE" or "wFilterCaract5VISIBLE" or "wFilterCaract4VISIBLE" or "wFilterCaract3VISIBLE" or "wFilterCaract2VISIBLE" or "wFilterCaract1VISIBLE" or wItemCaract9VISIBLE or wItemCaract8VISIBLE or wItemCaract7VISIBLE or wItemCaract6VISIBLE or wItemCaract5VISIBLE or wItemCaract4VISIBLE or wItemCaract3VISIBLE or wItemCaract2VISIBLE or wItemCaract1VISIBLE;

                field(wItemCaract1; wInvPostingGroup."Characteristic 1")
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wItemCaract1';
                    //  Visible = wItemCaract1VISIBLE; 
                    Visible = false;
                }
                field(wItemCaract2; wInvPostingGroup."Characteristic 2")
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wItemCaract2';
                    //Visible = wItemCaract2VISIBLE;
                    Visible = false;
                }
                field(wItemCaract3; wInvPostingGroup."Characteristic 3")
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wItemCaract3';
                    // Visible = wItemCaract3VISIBLE;
                    Visible = false;
                }
                field(wItemCaract4; wInvPostingGroup."Characteristic 4")
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wItemCaract4';
                    // Visible = wItemCaract4VISIBLE;
                    Visible = false;
                }
                field(wItemCaract5; wInvPostingGroup."Characteristic 5")
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wItemCaract5';
                    //Visible = wItemCaract5VISIBLE;
                    Visible = false;
                }
                field(wItemCaract6; wInvPostingGroup."Characteristic 6")
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wItemCaract6';
                    // Visible = wItemCaract6VISIBLE;
                    Visible = false;
                }
                field(wItemCaract7; wInvPostingGroup."Characteristic 7")
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wItemCaract7';
                    // Visible = wItemCaract7VISIBLE;
                    Visible = false;
                }
                field(wItemCaract8; wInvPostingGroup."Characteristic 8")
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wItemCaract8';
                    //  Visible = wItemCaract8VISIBLE;
                    Visible = false;
                }
                field(wItemCaract9; wInvPostingGroup."Characteristic 9")
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wItemCaract9';
                    //  Visible = wItemCaract9VISIBLE;
                    Visible = false;
                }

                field(wFilterCaract1; wItemCharact[1])
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wFilterCaract1';
                    // Visible = "wFilterCaract1VISIBLE";
                    Visible = false;
                    trigger OnValidate()
                    begin
                        rec.SETFILTER("Characteristic 1", wItemCharact[1]);
                    end;
                }
                field(wFilterCaract2; wItemCharact[2])
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wFilterCaract2';
                    // Visible = "wFilterCaract2VISIBLE";
                    Visible = false;
                    trigger OnValidate()
                    begin
                        rec.SETFILTER("Characteristic 2", wItemCharact[2]);
                    end;
                }
                field(wFilterCaract3; wItemCharact[3])
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wFilterCaract3';
                    //Visible = "wFilterCaract3VISIBLE";
                    Visible = false;
                    trigger OnValidate()
                    begin
                        rec.SETFILTER("Characteristic 3", wItemCharact[3]);
                    end;
                }
                field(wFilterCaract4; wItemCharact[4])
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wFilterCaract4';
                    //  Visible = "wFilterCaract4VISIBLE";
                    Visible = false;
                    trigger OnValidate()
                    begin
                        rec.SETFILTER("Characteristic 4", wItemCharact[4]);
                    end;
                }
                field(wFilterCaract5; wItemCharact[5])
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wFilterCaract5';
                    //  Visible = "wFilterCaract5VISIBLE";
                    Visible = false;
                    trigger OnValidate()
                    begin
                        rec.SETFILTER("Characteristic 5", wItemCharact[5]);
                    end;
                }
                field(wFilterCaract6; wItemCharact[6])
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wFilterCaract6';
                    //  Visible = "wFilterCaract6VISIBLE";
                    Visible = false;
                    trigger OnValidate()
                    begin
                        rec.SETFILTER("Characteristic 6", wItemCharact[6]);
                    end;
                }
                field(wFilterCaract7; wItemCharact[7])
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wFilterCaract7';
                    //  Visible = "wFilterCaract7VISIBLE";
                    Visible = false;
                    trigger OnValidate()
                    begin
                        rec.SETFILTER("Characteristic 7", wItemCharact[7]);
                    end;
                }
                field(wFilterCaract8; wItemCharact[8])
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wFilterCaract8';
                    ///  Visible = "wFilterCaract8VISIBLE";
                    Visible = false;
                    trigger OnValidate()
                    begin
                        rec.SETFILTER("Characteristic 8", wItemCharact[8]);
                    end;
                }
                field(wFilterCaract9; wItemCharact[9])
                {
                    Enabled = true;
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'wFilterCaract9';
                    //  Visible = "wFilterCaract9VISIBLE";
                    Visible = false;
                    trigger OnValidate()
                    begin
                        rec.SETFILTER("Characteristic 9", wItemCharact[9]);
                    end;
                }


            }

        }







        addafter(Control1)
        {
            //DYS page addon non migrer
            // part("PyramidSubform"; "Tree Subform")
            // {
            //     Visible = PyramidSubformVISIBLE;
            //     Enabled = PyramidSubformENABLED;
            //     Caption = 'Tree Subform';
            //     ApplicationArea = all;

            //     SubPageView = SORTING(Type, Code)
            //                 WHERE(Type = CONST(Item));
            // }
            //DYS page addon non migrer
            // part("ExtendedSubform"; "Item List Extended Text")
            // {
            //     Visible = ExtendedSubformVISIBLE;

            //     Caption = 'Item List Extended Text';
            //     ApplicationArea = all;
            //     SubPageLink = "Table Name" = CONST(Item), "No." = FIELD("No."), "Language Code" = CONST(), "Text No." = CONST(1);
            // }
            /*GL2024    group("Liste Normal")
                {

                    ShowCaption = true;
                    Caption = 'Liste Normal';
                    repeater(Control2)
                    {
                        Caption = 'Liste Normal';
                        field("No.1"; Rec."No.")
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                        field(Description1; Rec.Description)
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                        field("Inventory Posting Group1"; Rec."Inventory Posting Group")
                        {
                            Editable = true;
                            ApplicationArea = Basic, Suite;

                        }
                        field("Unit Cost1"; Rec."Unit Cost")
                        {
                            Editable = false;
                            ApplicationArea = Basic, Suite;
                        }
                        field("Purch. Unit of Measure1"; Rec."Purch. Unit of Measure")
                        {
                            Editable = true;
                            ApplicationArea = Suite;

                        }
                        field("Sales Unit of Measure1"; Rec."Sales Unit of Measure")
                        {
                            Editable = true;
                            ApplicationArea = Suite;

                        }
                        field("Base Unit of Measure1"; Rec."Base Unit of Measure")
                        {
                            Editable = true;
                            ApplicationArea = Invoicing, Basic, Suite;
                        }
                        field("Last Direct Cost1"; Rec."Last Direct Cost")
                        {
                            Editable = false;
                            ApplicationArea = Basic, Suite;

                        }
                        field(InventoryField1; Rec.Inventory)
                        {
                            Editable = false;
                            ApplicationArea = Invoicing, Basic, Suite;
                            HideValue = IsNonInventoriable;
                        }

                        field("Emplacement Bati Depot z4"; Rec."Emplacement Bati Depot z4")
                        {
                            Editable = TRUE;
                            ApplicationArea = all;
                        }
                        field("Tree Code"; Rec."Tree Code")
                        {
                            Editable = TRUE;
                            ApplicationArea = all;
                            Caption = 'Tree Code';

                        }



                    }
                }*/


        }



    }


    actions
    {
        addafter("E&xtended Texts")
        {
            action(Description2)
            {
                ApplicationArea = all;
                Caption = 'Description';
                trigger OnAction()
                VAR
                    lDescription: Record "Description Line";
                BEGIN
                    lDescription.ShowDescription(27, 0, rec."No.", 0);

                end;
            }
            // action(Export)
            // {
            //     ApplicationArea = all;
            //     Caption = 'Export Dernier Prix';
            //     trigger OnAction()
            //     VAR
            //         lDescription: XmlPort "Item Last Price";
            //     BEGIN
            //         lDescription.export;
            //     end;
            // }
            action(CopyFLW)
            {
                ApplicationArea = all;
                Caption = 'Update Dernier Prix';
                trigger OnAction()
                VAR
                    ReclItem: record item;
                BEGIN
                    ReclItem.FindFirst();
                    repeat
                        ReclItem.CalcFields("Dernier date achat", "Dernier Prix achat", "Dernier Entree", "Dernier Prix achat 2");
                        ReclItem."Dernier date achats" := ReclItem."Dernier date achat";
                        ReclItem."Dernier Prix achats" := ReclItem."Dernier Prix achat";
                        if ReclItem."Dernier Prix achats" = 0 then
                            ReclItem."Dernier Prix achats" := ReclItem."Dernier Prix achat 2";
                        ReclItem.Modify();
                    until ReclItem.Next() = 0;
                    Message('Dernier Prix d''achat à jour?');
                end;
            }
        }
        addafter(Identifiers)
        {
            action("Last number of the family")
            {
                Caption = 'Dernier Numéro De La Famille';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    // >> HJ DSFT 30/01/2013
                    RecItem.RESET;
                    RecItem.SETCURRENTKEY("No.");
                    RecItem.SETFILTER("No.", COPYSTR(rec."No.", 1, 6) + '*');
                    IF RecItem.FINDLAST THEN MESSAGE(Text001, RecItem."No.");
                    // >> HJ DSFT 30/01/2013
                end;
            }
        }
        addafter("Item Refe&rences_Promoted")
        {
            actionref("Last number of the family1"; "Last number of the family")
            {

            }
            actionref("Description21"; Description2)
            {

            }
        }

        //  addafter(Action125)
        // {
        //action("Discounts Price List")
        //{
        //Caption = 'Discounts Price List';
        //ApplicationArea = all;
        //DYS page addon non migrer
        // RunObject = Page 8004097;
        // RunPageLink = Code = FIELD("No."), "Cost Filter" = FIELD("Standard Cost");
        // RunPageView = SORTING(Type, Code, "Purchase Type", "Purchase Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity");


        //}
        //action("Purch. Invoiced Lines List")
        //{
        //Caption = 'Purch. Invoiced Lines List';
        //ApplicationArea = all;
        //DYS page addon non migrer
        // RunObject = Page 8004098;
        // RunPageView = SORTING("Item Ledger Entry Type", "Source Type", "Item No.", "Cost per Unit", "Posting Date", "Source No.")
        //                   ORDER(Ascending);
        // RunPageLink = "Item No." = FIELD("No.");
        // }
        // action(Quotes)
        // {
        //     Caption = 'Quotes';
        //     ApplicationArea = all;
        //     RunObject = Page 56;
        //     RunPageView = SORTING("Document Type", Type, "No.")
        //                       WHERE("Document Type" = CONST(Quote),
        //                             "Attached to Doc. No." = FILTER(''));
        //     RunPageLink = Type = CONST(Item),
        //                       "No." = FIELD("No.");
        // }
        //}

        addafter(Resources)
        {
            //DYS  action(B1)
            //DYS  {
            //DYS ApplicationArea = all;
            //DYS Caption = 'Expand/Collapse All';
            //DYS Visible = B1VISIBLE;
            //DYS Enabled = B1ENABLED;
            //DYS trigger OnAction()
            //DYSbegin
            //DYS page addon non migrer
            // CurrPAGE.PyramidSubform.PAGE.InitTempTable;
            //DYSend;
            //DYS }
            //DYS action(B2)
            //DYS {
            //DYS  ApplicationArea = all;
            //DYS  Caption = 'Expand/Collapse Branch';
            //DYS  Visible = B2VISIBLE;
            //DYS  Enabled = B2ENABLED;
            //DYS  trigger OnAction()
            //DYS begin
            //DYS page addon non migrer
            // CurrPAGE.PyramidSubform.page.ToggleExpandCollapse(TRUE);
            //DYSend;
            //DYS }
            action(btnExtended)
            {
                ApplicationArea = all;
                Caption = 'Extended Text';
                trigger OnAction()
                begin
                    wSwitchExtended;
                end;
            }
        }
        addlast(Item)
        {

            action(Card)

            {

                ApplicationArea = all;

                caption = 'Fiche';
                Image = Card;
                ShortcutKey = 'Maj+F5';
                RunObject = page "Item Card";
                RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter");
            }
        }


        addfirst(Category_Category4)
        {
            actionref(Card1; Card)
            {
            }
        }
    }

    trigger OnOpenPage()
    var

        lPyramid: Record Tree;
        lClassicVisible: Boolean;
    begin
        //GL2024 SourceTableView=WHERE(Blocked=CONST(No));

        // Rec.FilterGroup(0);
        // Rec.SetRange(Blocked, False);
        // Rec.SetFilter(Type, '%1|%2', Rec.Type::Inventory, Rec.Type::"Non-Inventory");
        // Rec.SetRange(Statut, Rec.Statut::"Validé");
        // Rec.FilterGroup(2); 


        CLEAR(rec."Location Filter");
        //#5705
        //DYS page addon non migrer
        //wPrevCode := CurrPage.PyramidSubform.page.GetPyramid;
        //#5705//

        //RECHERCHE_ARTICLE
        IF rec.GETFILTER("Inventory Posting Group") <> '' THEN
            wInvPostingFilter := rec.GETFILTER("Inventory Posting Group");
        IF rec.GETFILTER("Gen. Prod. Posting Group") <> '' THEN
            wGenProdPostingFilter := rec.GETFILTER("Gen. Prod. Posting Group");
        IF rec.GETFILTER("Search Description") <> '' THEN
            wSearchFilter := DELCHR(rec.GETFILTER("Search Description"), '=', '@*');
        //#8324
        gSearchOption := gSearchOption::"Part";
        //#8324//
        wKOPyramid := wSearchFilter <> '';
        //RECHERCHE_ARTICLE//
        //ITEM_CHARACT
        wNavibat.GET2;
        IF FORMAT(wNavibat."History Purchase Price") <> '' THEN BEGIN
            IF CALCDATE(wNavibat."History Purchase Price", WORKDATE) > WORKDATE THEN
                EVALUATE(wNavibat."History Purchase Price", '-' + FORMAT(wNavibat."History Purchase Price"));
            rec.SETRANGE("Date Filter", CALCDATE(wNavibat."History Purchase Price", WORKDATE), WORKDATE);
        END;
        wGetCharasteristicFilters;
        //ITEM_CHARACT//

        //TRS-2009
        //RECHERCHE_ARTICLE
        lPyramid.SETRANGE(Type, lPyramid.Type::Item);
        IF lPyramid.COUNT > 0 THEN BEGIN
            lClassicVisible := TRUE;
            IF (ISSERVICETIER) THEN BEGIN
                /*GL2024 CurrPage.B1.ENABLED(TRUE);
                 CurrPage.B2.ENABLED(TRUE);*/
                B1ENABLED := true;
                B2ENABLED := true;
                //GL2024  CurrPage.PyramidSubform.ENABLED(TRUE);
                PyramidSubformENABLED := true;
            END ELSE BEGIN
                /*GL2024   CurrPage.B1.VISIBLE(lClassicVisible);
                   CurrPage.B2.VISIBLE(lClassicVisible);*/
                B1VISIBLE := lClassicVisible;
                B2VISIBLE := lClassicVisible;
                //GL2024 CurrPage.PyramidSubform.VISIBLE(lClassicVisible);
                PyramidSubformVISIBLE := lClassicVisible
            END;
            //DYS page addon non migrer
            //CurrPage.PyramidSubform.Page.SETTABLEVIEW(lPyramid);
            //GL2024  CurrPage.ListItem.XPOS(6600);
        END ELSE BEGIN
            lClassicVisible := FALSE;
            //GL2024 CurrPage.PyramidSubform.VISIBLE(lClassicVisible);
            PyramidSubformVISIBLE := lClassicVisible;
            //GL2024  CurrPage.ListItem.XPOS(220);
            //GL2024   CurrPage.ListItem.WIDTH(CurrPage.ListItem.WIDTH + 6380);
            /* GL2024  CurrPage.B1.VISIBLE(lClassicVisible);
               CurrPage.B2.VISIBLE(lClassicVisible);*/
            B1VISIBLE := lClassicVisible;
            B2VISIBLE := lClassicVisible;
        END;

        //TRS-2009//

        wExtended := NOT wExtended;
        wSwitchExtended;

        IF NOT B1VISIBLE THEN BEGIN
            //GL2024  CurrPage.btnExtended.XPOS := 220;
            //GL2024   CurrPage.ExtendedSubform.XPOS := 220;
            //GL2024  CurrPage.ExtendedSubform.WIDTH := CurrPage.ListItem.WIDTH;
        END;

    end;

    trigger OnAfterGetRecord()
    begin
        // >> HJ SORO 11-07-20144
        rec.CALCFIELDS("Nom Famille");
        // FiltreMagasin;
        // >> HJ SORO 11-07-2014
    end;

    trigger OnAfterGetCurrRecord()
    begin

        //+REF+ITEM_CHARACT
        //GL2024   CurrPage.UPDATECONTROLS;
        //+REF+ITEM_CHARACT//
        //RECHERCHE_ARTICLE
        //DYS page addon non migrer
        // IF ((rec."Tree Code" <> CurrPage.PyramidSubform.page.GetPyramid) OR (rec."Tree Code" = '')) AND CurrPage.LOOKUPMODE THEN
        //     //RECHERCHE_ARTICLE//
        //     CurrPage.PyramidSubform.page.FindTree(rec."Tree Code", 3);
    end;





    PROCEDURE wGetCharasteristicFilters();
    BEGIN

        //ITEM_CHARACT
        IF wInvPostingFilter = '' THEN
            wInvPostingGroup.INIT
        ELSE
            IF NOT wInvPostingGroup.GET(wInvPostingFilter) THEN
                wInvPostingGroup.INIT;

        rec.SETRANGE("Characteristic 1");
        rec.SETRANGE("Characteristic 2");
        rec.SETRANGE("Characteristic 3");
        rec.SETRANGE("Characteristic 4");
        rec.SETRANGE("Characteristic 5");
        rec.SETRANGE("Characteristic 6");
        rec.SETRANGE("Characteristic 7");
        rec.SETRANGE("Characteristic 8");
        rec.SETRANGE("Characteristic 9");

        wItemCharact[1] := '';
        wItemCharact[2] := '';
        wItemCharact[3] := '';
        wItemCharact[4] := '';
        wItemCharact[5] := '';
        wItemCharact[6] := '';
        wItemCharact[7] := '';
        wItemCharact[8] := '';
        wItemCharact[9] := '';




        "wFilterCaract1VISIBLE" := (wInvPostingGroup."Characteristic 1" <> '');
        wFilterCaract2VISIBLE := (wInvPostingGroup."Characteristic 2" <> '');
        wFilterCaract3VISIBLE := (wInvPostingGroup."Characteristic 3" <> '');
        wFilterCaract4VISIBLE := (wInvPostingGroup."Characteristic 4" <> '');
        wFilterCaract5VISIBLE := (wInvPostingGroup."Characteristic 5" <> '');
        wFilterCaract6VISIBLE := (wInvPostingGroup."Characteristic 6" <> '');
        wFilterCaract7VISIBLE := (wInvPostingGroup."Characteristic 7" <> '');
        wFilterCaract8VISIBLE := (wInvPostingGroup."Characteristic 8" <> '');
        wFilterCaract9VISIBLE := (wInvPostingGroup."Characteristic 9" <> '');

        wItemCaract1VISIBLE := (wInvPostingGroup."Characteristic 1" <> '');
        wItemCaract2VISIBLE := (wInvPostingGroup."Characteristic 2" <> '');
        wItemCaract3VISIBLE := (wInvPostingGroup."Characteristic 3" <> '');
        wItemCaract4VISIBLE := (wInvPostingGroup."Characteristic 4" <> '');
        wItemCaract5VISIBLE := (wInvPostingGroup."Characteristic 5" <> '');
        wItemCaract6VISIBLE := (wInvPostingGroup."Characteristic 6" <> '');
        wItemCaract7VISIBLE := (wInvPostingGroup."Characteristic 7" <> '');
        wItemCaract8VISIBLE := (wInvPostingGroup."Characteristic 8" <> '');
        wItemCaract9VISIBLE := (wInvPostingGroup."Characteristic 9" <> '');
        //ITEM_CHARACT//
    END;

    PROCEDURE wSetFilters();
    BEGIN

        //RECHERCHE_ARTICLE
        rec.SETRANGE("Tree Code");
        IF wSearchFilter <> '' THEN
            rec.SETCURRENTKEY("Search Description")
        ELSE
            IF wInvPostingFilter <> '' THEN
                rec.SETCURRENTKEY("Inventory Posting Group")
            ELSE
                IF wGenProdPostingFilter <> '' THEN
                    rec.SETCURRENTKEY("Gen. Prod. Posting Group")
                //#612
                ELSE
                    IF wSearchNo <> '' THEN
                        rec.SETCURRENTKEY("No.")

                    else
                        if wFamille <> '' then
                            rec.SETCURRENTKEY("Tree Code");
        // rec.SETCURRENTKEY("Nom Famille");
        //#612

        IF wSearchFilter = '' THEN
            rec.SETRANGE("Search Description")
        ELSE
          //#8324
          //  SETFILTER("Search Description",wSearchFilter+'*');
          BEGIN
            CASE gSearchOption OF
                gSearchOption::"Begin":
                    rec.SETFILTER("Search Description", '@' + wSearchFilter + '*');
                gSearchOption::"End":
                    rec.SETFILTER("Search Description", '@*' + wSearchFilter);
                gSearchOption::Part:
                    rec.SETFILTER("Search Description", '@*' + wSearchFilter + '*');
            END;
        END;
        //#8324//

        IF wInvPostingFilter = '' THEN
            rec.SETRANGE("Inventory Posting Group")
        ELSE
            rec.SETFILTER("Inventory Posting Group", wInvPostingFilter);

        // IF wFamille = '' THEN
        //     rec.SETRANGE("Nom Famille")
        // ELSE
        //     rec.SETFILTER("Nom Famille", wFamille);
        IF wFamille = '' THEN
            rec.SETRANGE("Tree Code")
        ELSE
            rec.SETFILTER("Tree Code", wFamille);

        IF wGenProdPostingFilter = '' THEN
            rec.SETRANGE("Gen. Prod. Posting Group")
        ELSE
            rec.SETFILTER("Gen. Prod. Posting Group", wGenProdPostingFilter);

        IF wManufacturerFilter = '' THEN
            rec.SETRANGE("Manufacturer Code")
        ELSE
            rec.SETFILTER("Manufacturer Code", wManufacturerFilter);

        //#612
        IF wSearchNo = '' THEN
            rec.SETRANGE("No.")



        ELSE BEGIN   // Ajouter Par HJ DSFT
            CASE gSearchOption OF
                gSearchOption::"Begin":
                    rec.SETFILTER("No.", '@' + wSearchNo + '*');
                gSearchOption::"End":
                    rec.SETFILTER("No.", '@*' + wSearchNo);
                gSearchOption::Part:
                    rec.SETFILTER("No.", '@*' + wSearchNo + '*');
            END;
        END; // Ajouter Par HJ DSFT
             // Arrete Par HJ DSFT
             //  IF (STRPOS(wSearchNo,'*') > 0) THEN
             //    SETFILTER("No.",wSearchNo)
             //  ELSE
             //    IF NOT GET(wSearchNo) THEN
             //      MESSAGE(tNoNotFound);
             // Arrete Par HJ DSFT
             //#612//

        Currpage.UPDATE(FALSE);
    END;

    PROCEDURE wPyramidRefresh();
    VAR
        lPyramid: Text[20];
    BEGIN
        //DYS page addon non migrer
        // lPyramid := CurrPage.PyramidSubform.Page.GetPyramid;
        rec.SETCURRENTKEY("Tree Code");
        IF (lPyramid <> '') THEN BEGIN
            IF STRLEN(lPyramid) < 19 THEN
                rec.SETFILTER("Tree Code", '%1|%2', lPyramid, lPyramid + ' *')
            ELSE
                rec.SETFILTER("Tree Code", '%1', lPyramid);
        END ELSE
            rec.SETRANGE("Tree Code", '');
        IF wKOPyramid THEN BEGIN
            rec.SETRANGE("Tree Code");
            wKOPyramid := FALSE;
        END;
    END;


    PROCEDURE wSwitchExtended();
    BEGIN

        wExtended := NOT wExtended;
        //GL2024 CurrPage.ExtendedSubform.VISIBLE(wExtended);
        ExtendedSubformVISIBLE := wExtended;
        /*GL2024 IF wExtended THEN
            CurrPage.ListItem.HEIGHT(CurrPage.PyramidSubform.HEIGHT - CurrPage.ExtendedSubform.HEIGHT - 110)
        ELSE
            CurrPage.ListItem.HEIGHT(CurrPage.PyramidSubform.HEIGHT);*/

    END;


    PROCEDURE wSetSelectionFilter(VAR pItem: Record Item);
    VAR
        lItem: Record Item;
    BEGIN

        lItem.COPY(Rec);
        IF lItem.GETFILTER("Tree Code") <> '' THEN BEGIN
            lItem.SETCURRENTKEY("Tree Code");
            lItem.SETRANGE("Tree Code");
        END;

        pItem.COPY(Rec);
        IF pItem.GETFILTER("Tree Code") <> '' THEN BEGIN
            pItem.SETCURRENTKEY("Tree Code");
            pItem.SETRANGE("Tree Code");
        END;
        pItem.SETCURRENTKEY("No.");

        Currpage.SETSELECTIONFILTER(lItem);
        lItem.SETCURRENTKEY("No.");
        IF lItem.FIND('-') THEN
            REPEAT
                IF pItem.GET(lItem."No.") THEN
                    pItem.MARK(TRUE);
            UNTIL lItem.NEXT = 0;
        pItem.MARKEDONLY(TRUE);

    END;

    PROCEDURE FiltreMagasin();
    VAR
        LUserSetup: Record "User Setup";
    BEGIN

        // >> HJ SORO 11-07-2014
        /*  IF LUserSetup.GET(UPPERCASE(USERID)) THEN BEGIN
              IF LUserSetup."Filtre Magasin" <> '' THEN rec.SETFILTER("Location Filter", LUserSetup."Filtre Magasin");
              IF LUserSetup."Filtre Famille Article" <> '' THEN rec.SETFILTER("Tree Code", LUserSetup."Filtre Famille Article");
          END;*/
        // >> HJ SORO 11-07-2014

    END;

    var
        wInvPostingGroup: Record "Inventory Posting Group";
        wNavibat: Record NavibatSetup;
        wInvPostingFilter: Code[20];
        wCurrInvPosting: Code[20];
        wItemCharact: ARRAY[10] OF Code[20];
        wPrevCode: Code[20];
        wExtended: Boolean;
        wKOPyramid: Boolean;
        wAfterActivate: Boolean;
        wSearchFilter: Text[250];
        wGenProdPostingFilter: Text[250];
        wManufacturerFilter: Text[255];
        wSearchNo: Text[20];
        wFamille: Text[50];
        gSearchOption: Option "Begin","End","Part";
        "// DSFT": Integer;
        RecItem: Record Item;
        tNoNotFound: Label 'Item not found;FRA=Article non trouvé';
        Text001: Label 'The last number of this family is %1';

        "wFilterCaract1VISIBLE": Boolean;
        "wFilterCaract2VISIBLE": Boolean;
        "wFilterCaract3VISIBLE": Boolean;
        "wFilterCaract4VISIBLE": Boolean;
        "wFilterCaract5VISIBLE": Boolean;
        "wFilterCaract6VISIBLE": Boolean;
        "wFilterCaract7VISIBLE": Boolean;
        "wFilterCaract8VISIBLE": Boolean;
        "wFilterCaract9VISIBLE": Boolean;

        "wItemCaract1VISIBLE": Boolean;
        "wItemCaract2VISIBLE": Boolean;
        "wItemCaract3VISIBLE": Boolean;
        "wItemCaract4VISIBLE": Boolean;
        "wItemCaract5VISIBLE": Boolean;
        "wItemCaract6VISIBLE": Boolean;
        "wItemCaract7VISIBLE": Boolean;
        "wItemCaract8VISIBLE": Boolean;
        "wItemCaract9VISIBLE": Boolean;
        "B1VISIBLE": Boolean;
        "B2VISIBLE": Boolean;
        "PyramidSubformVISIBLE": Boolean;
        PyramidSubformENABLED: Boolean;
        "B1ENABLED": Boolean;
        "B2ENABLED": Boolean;
        "ExtendedSubformVISIBLE": Boolean;





}



