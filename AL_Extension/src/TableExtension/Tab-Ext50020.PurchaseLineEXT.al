TableExtension 50020 "Purchase LineEXT" extends "Purchase Line"
{

    //DYS propriete not allowed
    //Permissions = TableData 8004161 = rm; 



    fields
    {

        /*GL2024 modify("Buy-from Vendor No.")   
        {
            Editable=true;
        }*/


        modify("No.")
        {
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item
            else
            if (Type = const(Resource)) Resource where(Type = const(Service))
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge" where("Achat/Vente" = const(Achat))
            else
            if (Type = const("Note of Expenses")) Resource where(Type = const("Note of Expenses"));

            /*GL2024  trigger OnLookup
             var
                  lMultiple : Boolean;
                                                               lLookup : Codeunit 8001427;
             begin
                 //MULTIPLE
                 IF Type = Type::Item THEN BEGIN
                     wRecordref.OPEN(DATABASE::Item);
                     wLookUpNo(Rec, wRecordref, lMultiple, xRec);
                 END ELSE
                     //MULTIPLE//
                     //+REF+SUGG_ACC
                     lLookup.PurchLineNo(Rec);
                 //+REF+SUGG_ACC//
             end;*/

            //HS
            // trigger OnAfterValidate()
            // var
            //     RecItem: Record Item;
            // begin
            //     if rec."No." <> '' then begin
            //         if RecItem.Get("No.") then begin
            //             if RecItem.Type <> Rec."Type article" then
            //                 Error('Le Type d''article ne correspond pas avec l''article sélectionné');
            //             rec."DYS Description" := RecItem.Description;
            //         end;
            //     end;
            //     //+NDF+//
            // end;
        }





        /*GL2024 License  modify("Unit Cost (LCY)")
          {
              //blankzero = true;
          }*/


        /*GL2024 License  modify("Unit Price (LCY)")
          {
              //blankzero = true;
          }*/
        modify("Job No.")
        {
            TableRelation = if ("Document Type" = filter(<> "Note of Expenses")) Job."No." where("IC Partner Code" = const())
            else
            if ("Document Type" = const("Note of Expenses")) Job."No.";

            Caption = 'Job No.';
            Description = 'Modification TableRelation';

            trigger OnAfterValidate()
            var
                Job: Record Job;
            begin
                //#6565
                IF (Type = Type::Item) AND ("Qty. Rcd. Not Invoiced" <> 0) AND ("Job No." <> xRec."Job No.") THEN;
                //  lCheckJob(Rec, xRec."Job No.");
                //#6565#//
                // HJ SORO 20-02-2017
                // RB SORO 14/05/2015 LOCATION CODE WITH JOB Nø
                Location.RESET;
                Location.SETRANGE(Affaire, "Job No.");

                QteRecevoir := "Qty. to Receive";

                IF Job."Affectation Magasin" <> '' THEN BEGIN
                    VALIDATE("Location Code", Job."Affectation Magasin");
                    VALIDATE("Qty. to Receive", QteRecevoir);
                END
                ELSE
                    MESSAGE(Text046, "Job No.");
                // HJ SORO 20-02-2017

            end;



        }




        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }



        modify("Job Line Type")
        {
            Caption = 'Job Line Type';
        }
        modify("Job Unit Price")
        {
            Caption = 'Job Unit Price';
        }
        modify("Job Total Price")
        {
            Caption = 'Job Total Price';
        }
        modify("Job Line Amount")
        {
            Caption = 'Job Line Amount';
        }
        modify("Job Line Discount Amount")
        {
            Caption = 'Job Line Discount Amount';
        }
        modify("Job Line Discount %")
        {
            Caption = 'Job Line Discount %';
        }
        modify("Job Unit Price (LCY)")
        {
            Caption = 'Job Unit Price (LCY)';
        }
        modify("Job Total Price (LCY)")
        {
            Caption = 'Job Total Price (LCY)';
        }
        modify("Job Line Amount (LCY)")
        {
            Caption = 'Job Line Amount (LCY)';
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            Caption = 'Job Line Disc. Amount (LCY)';
        }
        modify("Job Currency Factor")
        {
            Caption = 'Job Currency Factor';
        }
        modify("Job Currency Code")
        {
            Caption = 'Job Currency Code';
        }



        /* GL2024  modify("Qty. Rcd. Not Invoiced")
           {
               Editable = true;
           }
           modify("VAT %")
           {
               Editable = true;
           }
           modify("Outstanding Quantity")
           {
               Editable = true;
           }

           modify("Quantity Received")
           {
               Editable = true;
           }
           modify("Quantity Invoiced")
           {
               Editable = true;
           }
           modify("Receipt No.")
           {
               Editable = true;
           }
           modify("Profit %")
           {
               Editable = true;
           }
           modify("Inv. Discount Amount")
           {
               Editable = true;
           }
           modify("Inv. Disc. Amount to Invoice")
           {
               Editable = true;
           }
            modify("Qty. per Unit of Measure")
           {
               Editable = true;
           }
           
             modify("Outstanding Qty. (Base)")
           {
               Editable = true;
           }
              modify("Qty. Rcd. Not Invoiced (Base)")
           {
               Editable = true;
           }

                  modify("Qty. Received (Base)")
           {
               Editable = true;
           }
                     modify("Qty. Invoiced (Base)")
           {
               Editable = true;
           }

            modify("Return Qty. Shipped Not Invd.")
           {
               Editable = true;
           }

            modify("Ret. Qty. Shpd Not Invd.(Base)")
           {
               Editable = true;
           }

            modify("Return Shpd. Not Invd.")
           {
               Editable = true;
           }
              modify("Return Shpd. Not Invd. (LCY)")
           {
               Editable = true;
           }
               modify("Return Qty. Shipped")
           {
               Editable = true;
           }
                 modify("Return Qty. Shipped (Base)")
           {
               Editable = true;
           }
                   modify("Return Shipment No.")
           {
               Editable = true;
           }
                      modify("Return Shipment Line No.")
           {
               Editable = true;
           }
           
           */





        modify(Type)
        {

            trigger OnAfterValidate()
            var

                lNoteOfExpensesIntegr: Codeunit "Note of Expenses integr.";
            begin
                //ACHATS
                "Location Code" := TempPurchLine."Location Code";
                //ACHATS//
                //+NDF+
                lNoteOfExpensesIntegr.SetPurchLineExpectReceiptDate(Rec, xRec);
                //+NDF+//
            end;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin



                //QUANTITE
                IF (CurrFieldNo = FIELDNO(Quantity)) THEN
                    IF ("Value 1" <> 0) OR ("Value 2" <> 0) OR ("Value 3" <> 0) OR ("Value 4" <> 0) OR ("Value 5" <> 0) OR
                       ("Value 6" <> 0) OR ("Value 7" <> 0) OR ("Value 8" <> 0) OR ("Value 9" <> 0) OR ("Value 10" <> 0) THEN BEGIN
                        "Value 1" := 0;
                        "Value 2" := 0;
                        "Value 3" := 0;
                        "Value 4" := 0;
                        "Value 5" := 0;
                        "Value 6" := 0;
                        "Value 7" := 0;
                        "Value 8" := 0;
                        "Value 9" := 0;
                        "Value 10" := 0;
                    END;

                IF "Invoicing Unit" = '' THEN BEGIN
                    "Invoicing Unit" := "Unit of Measure Code";
                    "Qty. Per Invoicing Unit" := "Qty. per Unit of Measure";
                END ELSE
                    IF "Invoicing Unit" <> "Unit of Measure Code" THEN
                        InitQtyPerInvoicingUnit
                    ELSE BEGIN
                        //#5482    "Qty. Per Invoicing Unit" := "Qty. Per Invoicing Unit" / "Qty. per Unit of Measure";
                        "Qty. Per Invoicing Unit" := 1;
                    END;
                //QUANTITE//






                // >> HJ SORO 11-02-2015
                IF "Document Type" <> "Document Type"::Invoice THEN "Qty. to Receive" := 0;
                // >> HJ SORO 11-02-2015
                // RB SORO 07/04/2015
                IF ("Quantités Initaile" = 0) AND (Quantity <> xRec.Quantity) THEN
                    "Quantités Initaile" := xRec.Quantity;
                // RB SORO 07/04/2015
            end;
        }


        modify("Qty. to Receive")
        {
            trigger OnBeforeValidate()
            begin
                // >> HJ SORO 12-02-2015
                "Outstanding Quantity" := Quantity - "Quantity Received";
                "Outstanding Qty. (Base)" := "Outstanding Quantity" * "Qty. per Unit of Measure";
                "Qty. to Invoice (Base)" := "Quantity (Base)";
                "Qty. Received (Base)" := "Quantity Received" * "Qty. per Unit of Measure";
                // >> HJ SORO 12-02-2015
            end;
        }

        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                //+ABO+
                IF "Document Type" = "Document Type"::Subscription THEN
                    fSubscrIntegration(FIELDNO("Direct Unit Cost"));
                //+ABO+//
                //REMISE_FOURN
                IF (CurrFieldNo = FIELDNO("Direct Unit Cost")) AND ("Line Discount %" <> 0) THEN BEGIN
                    "Discount 1 %" := 0;
                    "Discount 2 %" := 0;
                    "Discount 3 %" := 0;
                    "Line Discount %" := wPurchLineDisc.wTotalDiscount("Discount 1 %", "Discount 2 %", "Discount 3 %");
                END;
                //REMISE_FOURN//

                VALIDATE("Line Discount %");
                // >> HJ DSFT 30 JANV 2013
                IF Type = Type::Item THEN BEGIN
                    RecPurchasePrice.SETRANGE("Item No.", "No.");
                    RecPurchasePrice.SETRANGE("Vendor No.", "Buy-from Vendor No.");
                    RecPurchasePrice.SETRANGE("Starting Date", "Order Date");
                    RecPurchasePrice.DELETEALL;
                    RecPurchasePrice.RESET;
                    RecPurchasePrice.SETRANGE("Item No.", "No.");
                    RecPurchasePrice.SETRANGE("Vendor No.", "Buy-from Vendor No.");
                    RecPurchasePrice.SETRANGE("Direct Unit Cost", "Direct Unit Cost" / "Qty. per Unit of Measure");
                    IF NOT RecPurchasePrice.FINDFIRST THEN BEGIN
                        RecPurchasePrice2."Item No." := "No.";
                        RecPurchasePrice2."Vendor No." := "Buy-from Vendor No.";
                        RecPurchasePrice2."Direct Unit Cost" := "Direct Unit Cost" / "Qty. per Unit of Measure";
                        RecPurchasePrice2."Starting Date" := "Order Date";
                        RecPurchasePrice2."Unit of Measure Code" := "Unit of Measure Code";
                        RecPurchasePrice4.SETRANGE("Item No.", "No.");
                        RecPurchasePrice4.SETRANGE("Vendor No.", "Buy-from Vendor No.");
                        IF RecPurchasePrice4.FINDLAST THEN
                            IF RecPurchasePrice4."Starting Date" > "Order Date" THEN
                                RecPurchasePrice2."Ending Date" := "Order Date";
                        IF RecPurchasePrice2.INSERT THEN BEGIN
                            RecPurchasePrice3.SETRANGE("Item No.", "No.");
                            RecPurchasePrice3.SETRANGE("Vendor No.", "Buy-from Vendor No.");
                            RecPurchasePrice3.SETFILTER("Starting Date", '<%1', "Order Date");
                            RecPurchasePrice3.SETFILTER("Ending Date", '=%1', 0D);
                            IF "Order Date" <> 0D THEN
                                RecPurchasePrice3.MODIFYALL("Ending Date", "Order Date" - 1);
                        END;
                    END;

                END;
                // >> HJ DSFT 30 JANV 2013
            end;
        }

        modify("Line Discount Amount")
        {
            Description = 'Remise_fourn Editable = NO';
            //GL2024 Editable =true;
        }

        modify("Job Task No.")
        {
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."),
                                                             Blocked = filter(False));
            Caption = 'Job Task No.';


        }

        modify("VAT Prod. Posting Group")
        {
            trigger OnAfterValidate()
            begin
                //#7814
                "Prepayment VAT %" := "VAT %";
                "Prepmt. VAT Calc. Type" := "VAT Calculation Type";
                "Prepayment VAT Identifier" := "VAT Identifier";
                //#7814//
            end;
        }

        modify("Line Amount")
        {


            trigger OnAfterValidate()
            begin
                //+OFF+REMISE
                IF CurrFieldNo = FIELDNO("Line Amount") THEN BEGIN
                    "Discount 1 %" := 0;
                    "Discount 2 %" := 0;
                    "Discount 3 %" := 0;
                    "Line Discount %" := 0;
                    wPurchLineDisc.wTotalDiscount("Discount 1 %", "Discount 2 %", "Discount 3 %");
                    IF Quantity <> 0 THEN
                        "Direct Unit Cost" :=
                          ROUND("Line Amount" / Quantity, Currency."Unit-Amount Rounding Precision")
                    ELSE
                        "Direct Unit Cost" := 0;
                END;
                //+OFF+REMISE/

            end;
        }

        modify("Prepayment %")
        {
            trigger OnAfterValidate()
            begin

                //#7814
                "Prepayment VAT %" := "VAT %";
                "Prepmt. VAT Calc. Type" := "VAT Calculation Type";
                "Prepayment VAT Identifier" := "VAT Identifier";
                "Prepayment Tax Group Code" := "Tax Group Code";

            end;
        }


        modify("Completely Received")
        {
            Description = 'Modif : Editable OUI + Validate';
            //GL2024  Editable =true.
            trigger OnBeforeValidate()
            begin
                //+REF+SOLDE_CDE
                IF "Completely Received" <> xRec."Completely Received" THEN BEGIN
                    TESTFIELD("Drop Shipment", FALSE);
                    TESTFIELD("Special Order", FALSE);
                    TESTFIELD(Type, Type::Item);
                    TESTFIELD(Quantity);
                    IF "Completely Received" THEN BEGIN
                        "Outstanding Quantity" := 0;
                        "Outstanding Qty. (Base)" := 0;
                        InitQtyToReceive;
                        InitOutstandingAmount;
                    END ELSE BEGIN
                        InitOutstanding;
                        UpdateWithWarehouseReceive;
                    END;
                END;
                //+REF+SOLDE_CDE//

            end;
        }

        modify("Promised Receipt Date")
        {
            trigger OnBeforeValidate()
            begin
                //+NDF+
                IF "Document Type" = "Document Type"::"Note of Expenses" THEN
                    EXIT;
                //+NDF+//
            end;
        }


        field(50000; "Request No."; Code[20])
        {
            Caption = 'Request No.';
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50001; "Request Line No."; Integer)
        {
            Caption = 'Line No.';
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50002; "N° Dossier"; Code[20])
        {
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50003; "Fournisseur Offre DE Prix"; Code[20])
        {
            Description = 'HJ DSFT 03-05-2012';
            TableRelation = Vendor;

            trigger OnValidate()
            var
                RecLPurchasePrice: Record "Purchase Price";
                TextL001: label 'Vouler Vous Ajouter Cette Fournisseur a la Liste Des Prix de Cet Article';
            begin
                // >> HJ DSFT 03-05-2012
                IF NOT CONFIRM(TextL001, FALSE) THEN EXIT;
                IF Type <> Type::Item THEN EXIT;
                RecLPurchasePrice.INIT;
                RecLPurchasePrice.VALIDATE("Item No.", "No.");
                RecLPurchasePrice.VALIDATE("Vendor No.", "Fournisseur Offre DE Prix");
                RecLPurchasePrice."Starting Date" := TODAY;
                IF RecLPurchasePrice.INSERT THEN;
                // >> HJ DSFT 03-05-2012
            end;
        }
        field(50004; Rechercher; Code[20])
        {
            Description = 'HJ DSFT 03-05-2012';

            trigger OnValidate()
            begin
                // >> HJ DSFT 05-05-2012
                RecItem.Reset;
                RecItem.SetFilter(Description, Rechercher);
                if page.RunModal(page::"Item List", RecItem) = Action::OK then;
                Validate("No.", RecItem."No.");
                Rechercher := '';
                // >> HJ DSFT 05-05-2012
            end;
        }
        field(50005; "PV Generer"; Boolean)
        {
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50006; "Sequence PV"; Integer)
        {
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50007; Synchronise; Boolean)
        {
        }
        field(50008; "Num Sequence Syncro"; Integer)
        {
            Caption = 'Appliquer Fodec';
            Editable = true;
        }
        field(50011; "Purchase Request No."; Code[20])
        {
            Caption = 'Purchase Request No.';
            DataClassification = ToBeClassified;
        }
        field(50016; "Sous Affectation Marche"; Code[20])
        {
            Description = 'HJ SORO 24-11-2015';
            TableRelation = "Sous Affectation Marche" where(Marche = field("dysJob No."));
        }
        field(50017; "Affectation Marche"; Code[20])
        {
            Description = 'HJ SORO 11-10-2016';
            TableRelation = "Affectation Marche" where(Marche = field("dysJob No."));
        }
        field(50018; Provenance; Text[20])
        {
            TableRelation = "Chargement - Dechargement";
        }
        field(50019; Destination; Text[20])
        {
            TableRelation = "Chargement - Dechargement";
        }
        field(50020; "Distance Parcourus"; Decimal)
        {
        }
        field(50021; Volume; Integer)
        {
        }
        field(50024; "Durée Theorique (Minute)"; Decimal)
        {
        }
        field(50025; Heure; Time)
        {

            trigger OnValidate()
            begin
                "Date Saisie" := CurrentDatetime;
            end;
        }
        field(50026; "Date Saisie"; DateTime)
        {
        }
        field(50050; "affectation Frais annexe"; Boolean)
        {
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50051; "Filtre Article"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';

            trigger OnValidate()
            begin
                // >> HJ DST 02-02-2013
                "Filtre Article" := RecItem.GetItemFilter("Filtre Article");
                Validate("No.", "Filtre Article");
                "Filtre Article" := '';
                // >> HJ DST 02-02-2013
            end;
        }
        field(50052; "Ancien Groupe Cpt Marche TVA"; Code[10])
        {
            Description = 'HJ DSFT 06-02-2014';
        }
        field(50053; "Materiel"; Code[20])
        {
            TableRelation = Véhicule;
        }
        field(50054; "Quantité Sur Commande"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Quantity" WHERE("Blanket Order No." = FIELD("Document No."),
                                                                                                                 "Blanket Order Line No." = FIELD("Line No.")));
        }
        field(50055; Status; Option)
        {
            Caption = 'Status';
            Description = 'HJ SORO 09-01-2015';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Archived';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Archived,"En Cours De Verification",Reclamation;
        }
        field(50056; "Ligne Fodec"; Boolean)
        {
            Description = 'HJ SORO 20-01-2015';
        }
        field(50057; Vehicule; Code[20])
        {
            Description = 'HJ SORO 20-01-2015';
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                if RecVehicule.Get(Vehicule) then Volume := RecVehicule.Volume;
            end;
        }
        field(50058; "N° BL Fournisseur"; Code[20])
        {
            CalcFormula = lookup("Purch. Rcpt. Header"."Vendor Shipment No." where("No." = field("Receipt No.")));
            Description = 'HJ SORO 01-07-2017';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50059; Chauffeur; Code[20])
        {
            Description = 'HJ SORO 01-07-2017';
            TableRelation = "Shipping Agent";
        }
        field(50060; "Article Lié Au Frais Annexe"; Code[20])
        {
            Description = 'HJ SORO 01-07-2017';
            TableRelation = Item;
        }
        field(50061; "Quantités Initaile"; Decimal)
        {
            Description = 'RB SORO 07/04/2015';
        }
        field(50062; "Date Reception"; Date)
        {
            CalcFormula = lookup("Purch. Rcpt. Header"."Posting Date" where("No." = field("Receipt No.")));
            Description = 'HJ SORO 01-07-2017';
            FieldClass = FlowField;
        }
        field(50063; "Date Comptabilisation"; Date)
        {
            CalcFormula = lookup("Purchase Header"."Posting Date" where("Document Type" = field("Document Type"),
                                                                         "No." = field("Document No.")));
            Description = 'RB SORO 28/04/2015';
            FieldClass = FlowField;
        }
        field(50067; "Nom Fournisseur"; Text[50])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Buy-from Vendor No.")));
            Description = 'HJ SORO 01-07-2017';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                PurchRcptLine: Record "Purch. Rcpt. Line";
            begin
            end;
        }
        field(51000; "Description 2 soroubat"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Disponibilité Article"; Option)
        {
            Description = 'MH SORO 25/10/2019';
            OptionMembers = " ",Disponible,"Non Disponible";
        }
        field(50069; "Délai Livraison"; Date)
        {
            Description = 'MH SORO 25/10/2019';
        }
        field(50070; Cocher_Ligne; Boolean)
        {
            Description = 'MH SORO 06/02/2021';
        }
        field(50071; Observation_Ligne; Text[250])
        {
            Description = 'MH SORO 06/02/2021';
        }
        field(50072; "Code Utilisateur"; Code[20])
        {
            CalcFormula = lookup("Purchase Header"."User ID" where("No." = field("Document No.")));
            Description = 'MH SORO 19/03/2021';
            FieldClass = FlowField;
        }
        /*  field(50090; Emplacement; Text[30])
          {
              CalcFormula = lookup(Item."Emplacement DEPOT Z4" where("No." = field("No.")));
              Description = 'MH SORO 01/07/2021';
              FieldClass = FlowField;
          }
          field(50999; "Num Sequence Syncro"; Integer)
          {
              Description = 'RB SORO 06/03/2015';
              //This property is currently not supported
              //TestTableRelation = false;
              //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
              //ValidateTableRelation = false;
          }*/

        /*   field(51002; "Compte achat"; Text[100])
           {
               Editable = false;
               Caption = 'Compte achat';
               FieldClass = FlowField;
               CalcFormula = lookup("Gen. Product Posting Group"."Compte Achat" where("code" = field("Gen. Prod. Posting Group")));
           }*/
        field(50170; "Type article"; Enum "Item Type")
        {
            //HS
            trigger OnValidate()
            var
                RecItem: Record Item;
            begin
                // if rec."No." <> '' then begin
                //     if RecItem.Get("No.") then
                //         if RecItem.Type <> "Type article" then
                //             Error('Le Type d''article ne correspond pas avec l''article sélectionné');
                // end;
            end;
            //HS
        }
        field(85000; "DYSJob No."; code[20])
        {
            Caption = 'Marche';
            TableRelation = Job;
            Editable = true;
            trigger OnValidate()
            var
                Job: Record Job;
                RecLocation: Record Location;
                item: page "Item Lookup";
            begin
                //  "Job No." := "DYSJob No.";
                // TestStatusOpen();
                // TestField("Drop Shipment", false);
                // TestField("Special Order", false);
                // TestField("Receipt No.", '');
                // if "Document Type" = "Document Type"::Order then
                //     TestField("Quantity Received", 0);
                PlanPriceCalcByField(FieldNo("Job No."));

                if "DysJob No." = '' then begin
                    CreateDimFromDefaultDim(Rec.FieldNo("Job No."));
                    exit;
                end;
                /*GL2024 if Rec."DYSJob No." = '' then
                     Rec.DescriptionProject := '';*/


                Job.Get("dysJob No.");
                //  GL2024     Rec.DescriptionProject := Job.Description;
                Job.TestBlocked();
                "Job Currency Code" := Job."Currency Code";
                CreateDimFromDefaultDim(Rec.FieldNo("Job No."));
                // if RecItem.Get(Rec."No.") then begin
                //     if (Rec.Type = rec.Type::Item) and (RecItem.Type = RecItem.Type::Inventory) then
                //         "Job No." := '';
                // end;
                if Job.Get("DYSJob No.") then
                    Rec."Location Code" := Job."Affectation Magasin";
                if rec.Type = rec.Type::Item then begin
                    RecItem.get(rec."No.");
                    if recitem.Type <> RecItem.Type::Inventory then
                        rec.Validate("Job No.", "DYSJob No.");
                end;


            end;
        }
        field(85001; "DYSJob Task No."; code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("DYSjob No."));
            trigger OnValidate()
            var
                TempJobJnlLine: Record "Job Journal Line" temporary;
            begin
                "Job Task No." := "DYSJob Task No.";
                TestField("Receipt No.", '');
                if "DYSJob Task No." <> xRec."DYSJob Task No." then begin
                    Validate("DYSJob Planning Line No.", 0);
                    if "Document Type" = "Document Type"::Order then
                        TestField("Quantity Received", 0);

                    PlanPriceCalcByField(FieldNo("Job Task No."));

                end;

                if "Job Task No." = '' then begin
                    Clear(TempJobJnlLine);
                    "Job Line Type" := "Job Line Type"::" ";
                    UpdateJobPrices();
                    CreateDimFromDefaultDim(0);
                    exit;
                end;

                //JobSetCurrencyFactor();
                //UpdateDirectUnitCostByField(FieldNo("Job Task No."));
                if JobTaskIsSet() then begin
                    CreateTempJobJnlLine(true);
                    UpdateJobPrices();
                end;
                UpdateDimensionsFromJobTask();
                if RecItem.Get(Rec."No.") then begin
                    if (Rec.Type = rec.Type::Item) and (RecItem.Type = RecItem.Type::Inventory) then
                        "Job Task No." := '';
                end;


            end;
        }
        field(85002; "DYSJob Planning Line No."; Integer)
        {
            Caption = 'Job Planning Line No.';
            TableRelation = "Job Planning Line"."Line No." where("Job No." = field("DYSJob No."), "Job Task No." = field("DYSJob Task No."));
            trigger OnLookup()
            var
                JobPlanningLine: Record "Job Planning Line";
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //OnBeforeValidateJobPlanningLineNo(Rec, xRec, CurrFieldNo, IsHandled);
                if IsHandled then
                    exit;

                JobPlanningLine.SetRange("Job No.", "DYSJob No.");
                JobPlanningLine.SetRange("Job Task No.", "DYSJob Task No.");
                case Type of
                    Type::"G/L Account":
                        JobPlanningLine.SetRange(Type, JobPlanningLine.Type::"G/L Account");
                    Type::Item:
                        JobPlanningLine.SetRange(Type, JobPlanningLine.Type::Item);
                end;
                JobPlanningLine.SetRange("No.", "No.");
                JobPlanningLine.SetRange("Usage Link", true);
                JobPlanningLine.SetRange("System-Created Entry", false);

                if PAGE.RunModal(0, JobPlanningLine) = ACTION::LookupOK then
                    Validate("DYSJob Planning Line No.", JobPlanningLine."Line No.");
            end;

            trigger OnValidate()
            var
                JobPlanningLine: Record "Job Planning Line";
                IsHandled: Boolean;
                UOMMgt: Codeunit "Unit of Measure Management";
            begin
                if "Job Planning Line No." <> 0 then begin
                    JobPlanningLine.Get("DYSJob No.", "DYSJob Task No.", "DYSJob Planning Line No.");
                    JobPlanningLine.TestField("Job No.", "DYSJob No.");
                    JobPlanningLine.TestField("Job Task No.", "DYSJob Task No.");
                    case Type of
                        Type::"G/L Account":
                            begin
                                IsHandled := false;
                                //OnValidateJobPlanningLineNoOnBeforeGLAccountTest(Rec, JobPlanningLine, IsHandled);
                                if not IsHandled then
                                    JobPlanningLine.TestField(Type, JobPlanningLine.Type::"G/L Account");
                            end;
                        Type::Item:
                            JobPlanningLine.TestField(Type, JobPlanningLine.Type::Item);
                    end;

                    IsHandled := false;
                    //OnValidateJobPlanningLineNoOnBeforeTestFields(Rec, JobPlanningLine, IsHandled);
                    if not IsHandled then begin
                        JobPlanningLine.TestField("No.", "No.");
                        JobPlanningLine.TestField("Usage Link", true);
                        JobPlanningLine.TestField("System-Created Entry", false);
                    end;
                    "Job Line Type" := JobPlanningLine.ConvertToJobLineType();
                    Validate(
                        "Job Remaining Qty.",
                        JobPlanningLine."Remaining Qty." - UOMMgt.CalcQtyFromBase("Qty. to Invoice (Base)", JobPlanningLine."Qty. per Unit of Measure"))
                end else
                    Validate("Job Remaining Qty.", 0);
            end;
        }
        field(85003; "DYS Description"; Text[100])
        {
            Caption = 'Description';
            trigger OnValidate()
            begin
                if (rec.Type = Rec.Type::Item) AND (rec."No." <> 'IMM') then begin
                    Error('Modification de la description d''un article autre que IMM ou article de service non autorisée');
                end;
            end;
        }

        field(8001400; Separator; Integer)
        {
        }
        field(8001401; "Qty. Not In Conformity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Include Qty. Not In Conformity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                //+REF+COTFRN
                TestField(Type, Type::Item);
                if ("Qty. Not In Conformity" < 0) or
                   ("Qty. Not In Conformity" > "Qty. to Receive")
                then
                    Error(Text8001400, "Qty. to Receive");
                //+REF+COTFRN//
            end;
        }
        field(8001402; "Not In Conformity Code"; Code[10])
        {
            Caption = 'Not In Conformity Code';
            TableRelation = Code.Code where("Table No" = const(39),
                                             "Field No" = const(8001402));

            trigger OnValidate()
            begin
                //+REF+COTFRN
                TestField(Type, Type::Item);
                //+REF+COTFRN//
            end;
        }
        field(8001403; "Remainder Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Remainder Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(8001405; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }
        field(8001406; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(8001407; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';

            trigger OnValidate()
            begin
                //+REF+LOT
                fCheckSerialNoQty;
                //+REF+LOT//
            end;
        }
        field(8001408; "Order Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Order Line Amount"));
            Caption = 'Order Line Amount';
            Enabled = false;
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FieldNo("Subscription Starting Date"));
                //+ABO+//
            end;
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FieldNo("Subscription End Date"));
                //+ABO+//
            end;
        }
        field(8001902; "Subscription Posting Date"; Date)
        {
            Caption = 'Subscription Posting Date';
            Editable = false;
        }
        field(8001903; "Contract Base Unit Price"; Decimal)
        {
            Caption = 'Contract Base Unit Price';
        }
        field(8001904; "Contract Budget Date"; Date)
        {
            Caption = 'Contract Budget Date';
            Editable = false;
        }
        field(8003900; "Work Type Code"; Code[10])
        {
            Caption = 'Code type de travail';
            TableRelation = "Work Type";
        }
        field(8003902; "Charge To Order No."; Code[20])
        {
            Caption = 'Charge To Order No.';
            TableRelation = "Purchase Header Archive"."No." where("Document Type" = const(Order));
        }
        field(8003903; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(8003904; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(8003910; "Outst. Amount Excl. VAT (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount Excl. VAT (LCY)';
            Editable = false;

            trigger OnValidate()
            var
                lCurrency2: Record Currency;
            begin
                //PROJET_NATURE
                GetPurchHeader;
                lCurrency2.InitRoundingPrecision;
                if PurchHeader."Currency Code" <> '' then
                    "Outst. Amount Excl. VAT (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GetDate, "Currency Code",
                          "Outst. Amount Excl. VAT (LCY)", PurchHeader."Currency Factor"),
                        lCurrency2."Amount Rounding Precision")
                else
                    "Outst. Amount Excl. VAT (LCY)" :=
                      ROUND("Outst. Amount Excl. VAT (LCY)", lCurrency2."Amount Rounding Precision");
                Validate("Engaged Cost (LCY)");
                //PROJET_NATURE//
            end;
        }
        field(8003911; "Amt.Rcd. Not Inv.Excl. VAT LCY"; Decimal)
        {
            Caption = 'Amt. Rcd. Not Invoiced Excl. VAT (LCY)';

            trigger OnValidate()
            var
                lCurrency2: Record Currency;
            begin
                //PROJET_NATURE
                GetPurchHeader;
                lCurrency2.InitRoundingPrecision;
                if PurchHeader."Currency Code" <> '' then
                    "Amt.Rcd. Not Inv.Excl. VAT LCY" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GetDate, "Currency Code",
                          "Amt.Rcd. Not Inv.Excl. VAT LCY", PurchHeader."Currency Factor"),
                        lCurrency2."Amount Rounding Precision")
                else
                    "Amt.Rcd. Not Inv.Excl. VAT LCY" :=
                      ROUND("Amt.Rcd. Not Inv.Excl. VAT LCY", lCurrency2."Amount Rounding Precision");
                Validate("Engaged Cost (LCY)");
                //PROJET_NATURE//
            end;
        }
        field(8003912; "Engaged Cost (LCY)"; Decimal)
        {
            Caption = 'Engaged Cost (LCY)';

            trigger OnValidate()
            begin
                //PROJET_NATURE
                "Engaged Cost (LCY)" := "Outst. Amount Excl. VAT (LCY)" + "Amt.Rcd. Not Inv.Excl. VAT LCY";
                //PROJET_NATURE//
            end;
        }
        field(8003913; "Original Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Original Unit Cost (LCY)';

            trigger OnValidate()
            begin
                //LANCE
                //TestStatusOpen;
                //LANCE//
                TestField("No.");
                TestField(Quantity);

                if "Prod. Order No." <> '' then
                    Error(
                      Text99000000,
                      FieldCaption("Unit Cost (LCY)"));

                if (Type = Type::Item) then begin
                    GetItem;
                    if Item."Costing Method" = Item."costing method"::Standard then
                        Error(
                          Text010,
                          FieldCaption("Unit Cost (LCY)"), Item.FieldCaption("Costing Method"), Item."Costing Method");
                end;

                UnitCostCurrency := "Unit Cost (LCY)";
                GetPurchHeader;
                if PurchHeader."Currency Code" <> '' then begin
                    PurchHeader.TestField("Currency Factor");
                    GetGLSetup2;
                    UnitCostCurrency :=
                      ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          GetDate, "Currency Code",
                          "Unit Cost (LCY)", PurchHeader."Currency Factor"),
                          GLSetup."Unit-Amount Rounding Precision");
                end;

                if ("Direct Unit Cost" <> 0) and
                   ("Direct Unit Cost" <> ("Line Discount Amount" / Quantity))
                then
                    "Indirect Cost %" :=
                      ROUND(
                        (UnitCostCurrency - "Direct Unit Cost" + "Line Discount Amount" / Quantity) /
                        ("Direct Unit Cost" - "Line Discount Amount" / Quantity) * 100, 0.00001)
                else
                    "Indirect Cost %" := 0;

                UpdateSalesCost;
            end;
        }


        field(8003914; "Original Quantity"; Decimal)
        {
            Caption = 'Original Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestStatusOpen;

                if "Drop Shipment" then
                    Error(
                      Text001,
                      FieldCaption(Quantity), "Sales Order No.");
                "Quantity (Base)" := CalcBaseQty2(Quantity, '', '');
                if "Document Type" in ["document type"::"Return Order", "document type"::"Credit Memo"] then begin
                    if (Quantity * "Return Qty. Shipped" < 0) or
                       ((Abs(Quantity) < Abs("Return Qty. Shipped")) and ("Return Shipment No." = '')) then
                        FieldError(Quantity, StrSubstNo(Text004, FieldCaption("Return Qty. Shipped")));
                    if ("Quantity (Base)" * "Return Qty. Shipped (Base)" < 0) or
                       ((Abs("Quantity (Base)") < Abs("Return Qty. Shipped (Base)")) and ("Return Shipment No." = ''))
                    then
                        FieldError("Quantity (Base)", StrSubstNo(Text004, FieldCaption("Return Qty. Shipped (Base)")));
                end else begin
                    if (Quantity * "Quantity Received" < 0) or
                       ((Abs(Quantity) < Abs("Quantity Received")) and ("Receipt No." = ''))
                    then
                        FieldError(Quantity, StrSubstNo(Text004, FieldCaption("Quantity Received")));
                    if ("Quantity (Base)" * "Qty. Received (Base)" < 0) or
                       ((Abs("Quantity (Base)") < Abs("Qty. Received (Base)")) and ("Receipt No." = ''))
                    then
                        FieldError("Quantity (Base)", StrSubstNo(Text004, FieldCaption("Qty. Received (Base)")));
                end;

                if (Type = Type::"Charge (Item)") and (CurrFieldNo <> 0) then begin
                    if (Quantity * "Qty. Assigned" < 0) or (Abs(Quantity) < Abs("Qty. Assigned")) then
                        FieldError(Quantity, StrSubstNo(Text004, FieldCaption("Qty. Assigned")));
                    UpdateItemChargeAssgnt;
                end;

                InitOutstanding;
                if "Document Type" in ["document type"::"Return Order", "document type"::"Credit Memo"] then
                    InitQtyToShip
                else
                    InitQtyToReceive;
                if (Quantity * xRec.Quantity < 0) or (Quantity = 0) then
                    InitItemAppl2;

                if Type = Type::Item then
                    UpdateDirectUnitCost(FieldNo(Quantity))
                else
                    Validate("Line Discount %");
                ReservePurchLine.VerifyQuantity(Rec, xRec);
                UpdateWithWarehouseReceive;
                WhseValidateSourceLine.PurchaseLineVerifyChange(Rec, xRec);
            end;
        }
        field(8003915; "Ordered Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Ordered Not Invoiced (LCY)';
            Editable = false;
        }
        field(8003921; "Order No.2"; Code[20])
        {
            Caption = 'Order No.';
        }
        field(8003950; "Invoicing Unit"; Code[10])
        {
            Caption = 'Invoicing Unit';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            "Unit of Measure";

            trigger OnValidate()
            var
                ItemUnitOfMeasure: Record "Item Unit of Measure";
            begin
                //ACHATS
                if "Invoicing Unit" = '' then begin
                    "Invoicing Unit" := "Unit of Measure Code";
                    "Qty. Per Invoicing Unit" := 1;
                end else
                    if "Invoicing Unit" <> "Unit of Measure Code" then
                        InitQtyPerInvoicingUnit
                    else
                        "Qty. Per Invoicing Unit" := 1;
                //ACHATS//
            end;
        }
        field(8003951; "Qty. Per Invoicing Unit"; Decimal)
        {
            //blankzero = true;
            Caption = 'Qty. Per Invoicing Unit';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                //ACHATS
                if "Invoicing Unit" <> "Unit of Measure Code" then
                    InitQtyPerInvoicingUnit
                else
                    "Qty. Per Invoicing Unit" := 1;
                //ACHATS//
            end;
        }
        field(8004066; "Value 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(1);
            Caption = 'Value 1';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcPurchQty(Rec);
            end;
        }
        field(8004067; "Value 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(2);
            Caption = 'Value 2';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcPurchQty(Rec);
            end;
        }
        field(8004068; "Value 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(3);
            Caption = 'Value 3';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcPurchQty(Rec);
            end;
        }
        field(8004069; "Value 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(4);
            Caption = 'Value 4';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcPurchQty(Rec);
            end;
        }
        field(8004070; "Value 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(5);
            Caption = 'Value 5';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcPurchQty(Rec);
            end;
        }
        field(8004071; "Value 6"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(6);
            Caption = 'Value 6';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcPurchQty(Rec);
            end;
        }
        field(8004072; "Value 7"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(7);
            Caption = 'Value 7';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcPurchQty(Rec);
            end;
        }
        field(8004073; "Value 8"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(8);
            Caption = 'Value 8';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcPurchQty(Rec);
            end;
        }
        field(8004074; "Value 9"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(9);
            Caption = 'Value 9';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcPurchQty(Rec);
            end;
        }
        field(8004075; "Value 10"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(10);
            Caption = 'Value 10';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcPurchQty(Rec);
            end;
        }
        field(8004090; "Attached to Doc. No."; Code[20])
        {
            Caption = 'Attached to Doc. No.';
        }
        field(8004091; "Attached to Doc. Type"; Option)
        {
            Caption = 'Attached to Doc. Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8004092; "Selected Doc. No."; Code[20])
        {
            Caption = 'Selected Doc. No.';
            TableRelation = "Purchase Line"."Document No.";
        }
        field(8004093; "Selected Doc. Line No."; Integer)
        {
            Caption = 'Selected Doc. Line No.';

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
                lPurchLine: Record "Purchase Line";
                lSubcontractingMgt: Codeunit "Subcontracting Management";
                lTotalNeedParameter: Record "Sales Document Cost";
                lPriceOfferSetup: Record "Price Offer Setup";
            begin
                //SUBCONTRACTOR
                lPriceOfferSetup.Get;
                if (("Sales Order Line No." <> 0) or ("Special Order Sales Line No." <> 0)) and
                    ((SalesOrderLine."Vendor No." <> '') and (SalesOrderLine."Vendor No." <> lPriceOfferSetup."Default Quote Vendor"))
                then begin
                    if "Selected Doc. Line No." <> 0 then
                        lPurchLine.Get("Document Type", "Selected Doc. No.", "Selected Doc. Line No.")
                    else
                        lPurchLine := Rec;
                    if lPurchLine."Sales Document Type" = 0 then
                        lPurchLine."Sales Document Type" := lPurchLine."sales document type"::Order;
                    //ML  IF lPurchLine."Sales Order Line No." = 0 THEN
                    //    lPurchLine."Sales Order Line No." := lPurchLine."Special Order Sales Line No.";
                    //  IF lPurchLine."Sales Order No." = '' THEN
                    //    lPurchLine."Sales Order No." := lPurchLine."Special Order Sales No.";
                    if lPurchLine."Sales Order No." <> '' then
                        SalesOrderLine.Get("Sales Document Type" - 1, lPurchLine."Sales Order No.", lPurchLine."Sales Order Line No.")
                    else
                        if lPurchLine."Special Order Sales No." <> '' then
                            SalesOrderLine.Get("Sales Document Type" - 1, lPurchLine."Special Order Sales No.", lPurchLine."Special Order Sales Line No.");

                    if SalesOrderLine."Drop Shipment" then begin
                        SalesOrderLine."Purchase Order No." := lPurchLine."Document No.";
                        SalesOrderLine."Purch. Order Line No." := lPurchLine."Line No.";
                    end;
                    if SalesOrderLine."Special Order" then begin
                        SalesOrderLine."Special Order Purchase No." := lPurchLine."Document No.";
                        SalesOrderLine."Special Order Purch. Line No." := lPurchLine."Line No.";
                    end;

                    lSalesLine.SetRange("Document Type", SalesOrderLine."Document Type");
                    lSalesLine.SetRange("Document No.", SalesOrderLine."Document No.");
                    lSalesLine.SetRange("Purchasing Order No.", SalesOrderLine."Purchasing Order No.");
                    lSalesLine.SetRange(Type, lSalesLine.Type::" ");
                    if lSalesLine.Find('-') then
                        repeat
                            lSalesLine."Vendor No." := lPurchLine."Buy-from Vendor No.";
                            lSalesLine."Purchasing Document Type" := lPurchLine."Document Type";
                            lSalesLine."Purchasing Order No." := lPurchLine."Document No.";
                            lSalesLine.Modify;
                        until lSalesLine.Next = 0;

                    SalesOrderLine."Purchasing Order No." := lPurchLine."Document No.";
                    SalesOrderLine."Purchasing Order Line No." := lPurchLine."Line No.";
                    SalesOrderLine."Vendor No." := lPurchLine."Buy-from Vendor No.";
                    SalesOrderLine.Modify;

                    //2425 : Mise à jour à la demande  lSubcontractingMgt.UpdateFromPurchases(lPurchLine,FALSE);

                    lPurchLine."dysJob No." := SalesOrderLine."Job No.";
                    lPurchLine.Modify;
                end
                //SUBCONTRACTOR//
                //CONSULT
                else
                    if ("Document Type" = "document type"::Quote) and (("Sales Order No." <> '') or ("Special Order Sales No." <> '')) then begin
                        if "Selected Doc. Line No." <> 0 then
                            lPurchLine.Get("Document Type", "Selected Doc. No.", "Selected Doc. Line No.")
                        else
                            lPurchLine := Rec;
                        GetPurchHeader;
                        if lPurchLine."Sales Document Type" = 0 then
                            lPurchLine."Sales Document Type" := lPurchLine."sales document type"::Order;
                        if lPurchLine."Sales Order No." = '' then
                            lPurchLine."Sales Order No." := lPurchLine."Special Order Sales No.";
                        if lPurchLine."Sales Order Line No." = 0 then
                            lPurchLine."Sales Order Line No." := lPurchLine."Special Order Sales Line No.";
                        if lPurchLine."Sales Order Line No." <> 0 then begin
                            lSalesLine.Get(lPurchLine."Sales Document Type" - 1, lPurchLine."Sales Order No.", lPurchLine."Sales Order Line No.");
                            if (lSalesLine."Item Type" = 0) or (lSalesLine.Subcontracting = lSalesLine.Subcontracting::" ") then
                                lPurchLine."Sales Order Line No." := 0;
                        end;
                        if Type = Type::Item then begin
                            if lTotalNeedParameter.Get(
                               lPurchLine."Sales Document Type" - 1, lPurchLine."Sales Order No.", lTotalNeedParameter.Type::Item,
                               lPurchLine."No.", lPurchLine."Sales Order Line No.", lPurchLine."Purchasing Code")
                            then begin
                                lTotalNeedParameter."Purchasing Order No." := lPurchLine."Document No.";
                                lTotalNeedParameter."Purchasing Order Line No." := lPurchLine."Line No.";
                                lTotalNeedParameter."Vendor No." := lPurchLine."Buy-from Vendor No.";
                                lTotalNeedParameter."Reference Purchase Quote" := PurchHeader."Your Reference";
                                //Pas de mise à jour à ce moment là    lTotalNeedParameter.VALIDATE(Value,lPurchLine."Unit Cost (LCY)");
                                lTotalNeedParameter.Modify;
                            end;
                        end;
                    end;
                //CONSULT//
            end;
        }
        field(8004094; "Ordered Line"; Boolean)
        {
            Caption = 'Ordered Line';
        }
        field(8004095; "Price Offer No."; Code[20])
        {
            Caption = 'Price Offer No.';
        }
        field(8004096; "Offer Comments"; Text[30])
        {
            Caption = 'Offer Comments';
        }
        field(8004097; "Discount 1 %"; Decimal)
        {
            Caption = 'Discount 1 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                //+OFF+REMISE
                //#7765
                if wPurchLineDisc.ReadPermission then
                    //#7765//
                    Validate("Line Discount %", wPurchLineDisc.wTotalDiscount("Discount 1 %", "Discount 2 %", "Discount 3 %"));
                //+OFF+REMISE//
            end;
        }
        field(8004098; "Discount 2 %"; Decimal)
        {
            Caption = 'Discount 2 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                //+OFF+REMISE
                //#7765
                if wPurchLineDisc.ReadPermission then
                    //#7765//
                    Validate("Line Discount %", wPurchLineDisc.wTotalDiscount("Discount 1 %", "Discount 2 %", "Discount 3 %"));
                //+OFF+REMISE//
            end;
        }
        field(8004099; "Discount 3 %"; Decimal)
        {
            Caption = 'Discount 3 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                //+OFF+REMISE
                //#7765
                if wPurchLineDisc.ReadPermission then
                    //#7765//
                    Validate("Line Discount %", wPurchLineDisc.wTotalDiscount("Discount 1 %", "Discount 2 %", "Discount 3 %"));
                //+OFF+REMISE//
            end;
        }
        field(8004150; "Sales Document Type"; Option)
        {
            Caption = 'Sales Document Type';
            OptionCaption = ' ,Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
    }
    keys
    {

        /* //GL2024    key(Key25;"Document Type","Gen. Prod. Posting Group","Job No.","Job Task No.","Work Type Code","Order Date","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code")
            {
            SumIndexFields = "Engaged Cost (LCY)","Outst. Amount Excl. VAT (LCY)","Ordered Not Invoiced (LCY)","Amt. Rcd. Not Invoiced (LCY)","Amt.Rcd. Not Inv.Excl. VAT LCY";
            }*/
        key(Key26; "Attached to Doc. Type", "Attached to Doc. No.")
        {
            //GL2024   SumIndexFields = "Line Amount";
        }
        key(Key27; "Job No.")
        {
        }
        /* GL2024  key(Key28; "Attached to Doc. Type", "Attached to Doc. No.", Type, "No.")
          {
              SumIndexFields = "Quantity (Base)";
          }

          key(Key28;"N° Dossier","Document Type","Document No.","Line No.",Type)
          {
          }*/
        key(Key29; Synchronise)
        {
        }

        key(Key30; "VAT %")
        {
        }

        key(Key31; "Document No.", Description, "Posting Group")
        {
        }

        key(Key32; Description, "Job No.")
        {
        }

        key(Key33; "VAT Prod. Posting Group")
        {
        }

        key(Key34; "No.", "Quantity Received", "Outstanding Quantity", "Job No.")
        {
            SumIndexFields = "Qty. Received (Base)", "Outstanding Qty. (Base)", "Outstanding Quantity";
        }
    }

    trigger OnAfterModify()
    begin
        //#4974
        IF ("Special Order Sales No." = '') AND ("Special Order Sales Line No." <> 0) THEN
            "Special Order Sales Line No." := 0;
        //#4974//
        //+ABO+
        fSubscrIntegration(0);
        //+ABO+//
    end;

    trigger OnBeforeDelete()
    var

        lOfferLine: Record "Purchase Line";
        lSourceDocNo: Code[20];
        lSalesDocNo: Code[20];
        lSalesDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        lSalesDocLineNo: Integer;
        lSalesLine: Record "Sales Line";

    begin
        TestStatusOpen;
        //CONSULT
        IF "Sales Document Type" > "Sales Document Type"::" " THEN
            lSalesDocType := "Sales Document Type" - 1;
        lSalesDocNo := "Sales Order No." + "Special Order Sales No.";
        lSalesDocLineNo := "Sales Order Line No." + "Special Order Sales Line No.";
        lSourceDocNo := '';
        //CONSULT//
        //+OFF+OFFRE
        IF "Document Type" = "Document Type"::Quote THEN BEGIN
            lSourceDocNo := "Attached to Doc. No.";
            IF lSourceDocNo = '' THEN BEGIN
                lOfferLine.SETCURRENTKEY("Attached to Doc. Type", "Attached to Doc. No.");
                lOfferLine.SETRANGE("Attached to Doc. Type", "Document Type");
                lOfferLine.SETRANGE("Attached to Doc. No.", "Document No.");
                lOfferLine.SETRANGE("Line No.", "Line No.");
                IF lOfferLine.FIND('-') THEN
                    IF CONFIRM(STRSUBSTNO(Text8004090, "Line No."), FALSE) THEN
                        lOfferLine.DELETEALL
                    ELSE
                        ERROR(Text8004090);
            END ELSE BEGIN
                IF lOfferLine.GET("Attached to Doc. Type", "Attached to Doc. No.", "Line No.") THEN
                    IF (lOfferLine."Selected Doc. No." = "Document No.") AND
                       (lOfferLine."Selected Doc. Line No." = "Line No.") THEN BEGIN
                        lOfferLine."Selected Doc. No." := '';
                        lOfferLine."Selected Doc. Line No." := 0;
                        lOfferLine.MODIFY;
                    END;
            END;
            //CONSULT
            lSalesLine.SETRANGE("Document Type", lSalesDocType);
            lSalesLine.SETRANGE("Document No.", lSalesDocNo);
            //#4554
            lSalesLine.SETRANGE(Type, Type::Item);
            lSalesLine.SETRANGE("Purchasing Order No.", "Document No.");
            lSalesLine.SETRANGE("Purchasing Order Line No.", "Line No.");
            lSalesLine.SETRANGE("Purchasing Document Type", "Document Type");
            IF NOT lSalesLine.ISEMPTY THEN BEGIN
                lSalesLine.FINDSET(TRUE, FALSE);
                REPEAT
                    lSalesLine."Purchasing Order No." := '';
                    lSalesLine."Purchasing Order Line No." := 0;
                    lSalesLine."Purchasing Document Type" := 0;
                    lSalesLine.MODIFY;
                UNTIL lSalesLine.NEXT = 0;
            END;
            //#4554//
            //CONSULT//
        END;
        IF ("Document Type" = "Document Type"::Order) AND
           ("Price Offer No." <> '') THEN BEGIN
            lOfferLine.SETRANGE("Document Type", "Document Type"::Quote);
            lOfferLine.SETRANGE("Document No.", "Price Offer No.");
            lOfferLine.SETRANGE("Line No.", "Line No.");
            lOfferLine.SETRANGE(Type, Type);
            lOfferLine.SETRANGE("No.", "No.");
            lOfferLine.SETRANGE("Ordered Line", TRUE);
            IF lOfferLine.FIND('-') THEN BEGIN
                lOfferLine."Ordered Line" := FALSE;
                lOfferLine.MODIFY;
                lSourceDocNo := "Attached to Doc. No.";
            END;
        END;
        //+OFF+OFFRE//<
    end;

    trigger OnAfterDelete()
    var
        lVendor: Record Vendor;
        lJobLedgerEntry: Record "Job Ledger Entry";
        lJobLedgerEntry2: Record "Job Ledger Entry" TEMPORARY;
        lTotalNeedParameter: Record "Sales Document Cost";

    begin

        //+ABO+
        fSubscrIntegration(-1);
        //+ABO+//
        //INTERIM
        IF (Type = Type::"G/L Account") AND
           ("No." <> '') AND
           ("Document Type" = "Document Type"::Invoice)
        THEN BEGIN
            lVendor.GET("Buy-from Vendor No.");
            IF lVendor."External Work Force" THEN BEGIN
                lJobLedgerEntry2.DELETEALL;
                lJobLedgerEntry.SETCURRENTKEY("Pre-Assigned No.");
                lJobLedgerEntry.SETRANGE("Pre-Assigned No.", "Document No.");
                lJobLedgerEntry.SETRANGE("Line No.", "Line No.");
                IF lJobLedgerEntry.FIND('-') THEN
                    REPEAT
                        lJobLedgerEntry2 := lJobLedgerEntry;
                        lJobLedgerEntry2.INSERT;
                    UNTIL lJobLedgerEntry.NEXT = 0;

                IF lJobLedgerEntry2.FIND('-') THEN
                    REPEAT
                        lJobLedgerEntry.GET(lJobLedgerEntry2."Entry No.");
                        lJobLedgerEntry."Pre-Assigned No." := '';
                        lJobLedgerEntry."Line No." := 0;
                        lJobLedgerEntry.MODIFY;
                    UNTIL lJobLedgerEntry2.NEXT = 0;
                COMMIT;
            END;
        END;
        //INTERIM//
        //CONSULT
        IF (Type = Type::Item) AND
           (("Sales Order No." <> '') OR ("Special Order Sales No." <> ''))
        THEN BEGIN
            IF NOT SalesOrderLine.GET("Sales Document Type" - 1, "Sales Order No.", "Sales Order Line No.") THEN
                IF NOT SalesOrderLine.GET(
                   "Sales Document Type" - 1, "Special Order Sales No.", "Special Order Sales Line No.") THEN
                    SalesOrderLine.INIT;

            lTotalNeedParameter.RESET;
            lTotalNeedParameter.SETRANGE("Purchasing Document Type", "Document Type");
            lTotalNeedParameter.SETRANGE("Purchasing Order No.", "Document No.");
            lTotalNeedParameter.SETRANGE(Type, lTotalNeedParameter.Type::Item);
            lTotalNeedParameter.SETRANGE("Purchasing Code", "Purchasing Code");
            lTotalNeedParameter.SETRANGE("No.", "No.");
            IF (SalesOrderLine."Item Type" <> 0) OR (SalesOrderLine.Subcontracting <> 0) THEN
                lTotalNeedParameter.SETRANGE("Purchasing Order Line No.", "Line No.");
            IF lTotalNeedParameter.FIND('-') THEN BEGIN
                REPEAT
                    lTotalNeedParameter."Purchasing Document Type" := lTotalNeedParameter."Purchasing Document Type"::Quote;
                    lTotalNeedParameter."Purchasing Order No." := '';
                    lTotalNeedParameter."Purchasing Order Line No." := 0;
                    lTotalNeedParameter."Vendor No." := '';
                    lTotalNeedParameter.MODIFY;
                UNTIL lTotalNeedParameter.NEXT = 0;
            END;
        END;
        //CONSULT//
        //#8250
        //END;
        //#8250
    end;

    procedure fSubscrIntegration(pFieldNo: Integer)
    begin
        //+ABO+
        if (gLicensePermission."Object Type" <> gLicensePermission."object type"::Codeunit) or
           (gLicensePermission."Object Number" <> Codeunit::"Purch. Subscription Integr.") then
            gLicensePermission.Get(gLicensePermission."object type"::Codeunit, Codeunit::"Purch. Subscription Integr.");
        if gLicensePermission."Execute Permission" <> 0 then
            case pFieldNo of
                0:
                    gSubscrIntegration.LineOnModify(xRec, Rec);
                -1:
                    gSubscrIntegration.LineOnDelete(Rec);
                else
                    gSubscrIntegration.LineOnValidate(xRec, Rec, pFieldNo);
            end;
        //+ABO+//
    end;

    procedure fMemoPad(): Boolean
    var
        lRec: Record "Purchase Line";
        lRecordRef: RecordRef;
        lMemoPad: Codeunit "MemoPad Management";
    begin
        if "Attached to Line No." = 0 then
            lRec := Rec
        else
            lRec.Get("Document Type", "Document No.", "Attached to Line No.");
        //#5464
        with lRec do begin
            SetRange("Document Type", "Document Type");
            SetRange("Document No.", "Document No.");
            SetRange("Attached to Line No.", "Line No.");
        end;
        lRecordRef.GetTable(lRec);
        exit(lMemoPad.Edit(lRecordRef, ''));
        //#5464//
    end;

    procedure fCheckSerialNoQty()
    begin
        //+REF+LOT
        if "Serial No." <> '' then
            if not ("Quantity (Base)" in [-1, 0, 1]) then
                Error(Text8001400, FieldCaption("Quantity (Base)"), FieldCaption("Serial No."));
        //+REF+LOT//
    end;

    procedure wInitLocationCode()
    var
        lSalesLine: Record "Sales Line";
    begin
        if "Document No." = '' then
            exit;
        GetPurchHeader;
        "Location Code" := PurchHeader."Location Code";
    end;

    procedure wGetStandardText()
    var
        lCodeTranslation: Record Translation2;
        lLanguageCode: Code[20];
        lLanguage: Record Language;
    begin
        /*
        GetPurchHeader;
        IF StdTxt.GET("No.") THEN
          Description := StdTxt.Description;
        IF lCodeTranslation.GET(7,1,"No.",PurchHeader."Language Code") THEN
          Description := lCodeTranslation.Description;
        */
        //TRAD
        GetPurchHeader;
        Description := StdTxt.Description;
        //#8421
        //IF PurchHeader."Language Code" <> '' THEN
        //  IF lCodeTranslation.GET(DATABASE::"Standard Text",1,"No.",PurchHeader."Language Code") THEN
        //    Description := lCodeTranslation.Description;
        if PurchHeader."Language Code" = '' then
            /* GL2024 Procedure standard dans nav2009 n'existe dans bc24
                lLanguageCode := lLanguage.GetUserLanguage
            else*/
            lLanguageCode := PurchHeader."Language Code";
        if lCodeTranslation.Get(Database::"Standard Text", 2, "No.", lLanguageCode) then
            Description := lCodeTranslation.Description;
        //#8421//
        //TRAD//

    end;

    procedure wLookUpNo(var rec: Record "Purchase Line"; var pRecordRef: RecordRef; var pMultiple: Boolean; pxRec: Record "Purchase Line"): Boolean
    var
        lStdText: Record "Standard Text";
        lGLAccount: Record "G/L Account";
        lItem: Record Item;
        lFixedAsset: Record "Fixed Asset";
        lItemCharge: Record "Item Charge";
        lRes: Record Resource;
        lOK: Boolean;
        lFormRes: page "Resource List";
        lFormItem: page "Item List";
        lFormGL: Page "G/L Account List";
        lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
        lNbre: Integer;
    begin
        //#7750
        case Type of
            Type::Item:
                begin
                    //MULTIPLE
                    if "No." <> '' then begin
                        lItem.Get("No.");
                        lFormItem.SetRecord(lItem);
                    end;
                    if pRecordRef.Number = Database::Item then
                        lItem.SetFilter("Search Description", CopyStr(pRecordRef.GetFilters, StrPos(pRecordRef.GetFilters, ':') + 1));
                    if "Location Code" <> '' then
                        lItem.SetRange("Location Filter", "Location Code");
                    lItem.SetRange(Subcontracting, 0);
                    lFormItem.SetTableview(lItem);
                    lFormItem.LookupMode(true);
                    if lFormItem.RunModal = Action::LookupOK then begin
                        lFormItem.wSetSelectionFilter(lItem);
                        lNbre := lItem.Count;
                        if lNbre = 1 then begin
                            lFormItem.GetRecord(lItem);
                            CurrFieldNo := FieldNo("No.");
                            Validate("No.", lItem."No.");
                        end else begin
                            if lNbre > 100 then
                                if not Confirm(TextToMuch, false, lNbre, lItem.TableCaption) then
                                    exit(false);
                            GetPurchHeader;
                            lFenetre.Open(TextMultiple);
                            lGetRecord.SetPurchHeader(PurchHeader);
                            lGetRecord.SetPurchLine(rec, pxRec);
                            lGetRecord.CreatePurchLinesFromItem(lItem);
                            pMultiple := true;
                            lFenetre.Close;
                        end;
                        lOK := true;
                    end;
                    //MULTIPLE//
                end;
            Type::"G/L Account":
                begin
                    if "No." <> '' then begin
                        lGLAccount.Get("No.");
                        lFormGL.SetRecord(lGLAccount);
                    end;
                    //SUGG_ACCT
                    lGLAccount.SetRange("Sugg. for Purch. Doc.", true);
                    //SUGG_ACCT//
                    lFormGL.SetTableview(lGLAccount);
                    lFormGL.LookupMode(true);
                    if lFormGL.RunModal = Action::LookupOK then begin
                        //#7203
                        lFormGL.fSetSelectionFilter(lGLAccount);
                        lNbre := lGLAccount.COUNTAPPROX;
                        if lNbre = 1 then begin
                            //#7203//
                            lFormGL.GetRecord(lGLAccount);
                            lOK := true;
                            Validate("No.", lGLAccount."No.");
                            //#7203
                        end else begin
                            if lNbre > 100 then
                                if not Confirm(TextToMuch, false, lNbre, lGLAccount.TableCaption) then
                                    exit(false);
                            GetPurchHeader;
                            lFenetre.Open(TextMultiple);
                            lGetRecord.SetPurchHeader(PurchHeader);
                            lGetRecord.SetPurchLine(rec, pxRec);
                            lGetRecord.CreatePurchLinesFromAccount(lGLAccount);
                            pMultiple := true;
                            lFenetre.Close;
                            lOK := true;
                        end;
                        //#7203//
                    end;



                end;

        end;
        //#7750//
        //ACHAT
        if (Type <> Type::" ") and ("No." <> '') and lOK then
            Validate(Quantity, 0);
        //ACHAT//
        exit(lOK);
    end;

    local procedure wQtyGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lQtySetup: Record "Quantity Setup";
    begin
        if not lQtySetup.Get then
            lQtySetup.Init;
        if lQtySetup."Value 1 Name" = '' then
            lQtySetup."Value 1 Name" := FieldCaption("Value 1");
        if lQtySetup."Value 2 Name" = '' then
            lQtySetup."Value 2 Name" := FieldCaption("Value 2");
        if lQtySetup."Value 3 Name" = '' then
            lQtySetup."Value 3 Name" := FieldCaption("Value 3");
        if lQtySetup."Value 4 Name" = '' then
            lQtySetup."Value 4 Name" := FieldCaption("Value 4");
        if lQtySetup."Value 5 Name" = '' then
            lQtySetup."Value 5 Name" := FieldCaption("Value 5");
        if lQtySetup."Value 6 Name" = '' then
            lQtySetup."Value 6 Name" := FieldCaption("Value 6");
        if lQtySetup."Value 7 Name" = '' then
            lQtySetup."Value 7 Name" := FieldCaption("Value 7");
        if lQtySetup."Value 8 Name" = '' then
            lQtySetup."Value 8 Name" := FieldCaption("Value 8");
        if lQtySetup."Value 9 Name" = '' then
            lQtySetup."Value 9 Name" := FieldCaption("Value 9");
        if lQtySetup."Value 10 Name" = '' then
            lQtySetup."Value 10 Name" := FieldCaption("Value 10");

        case FieldNumber of
            1:
                exit('8004050,' + lQtySetup."Value 1 Name");
            2:
                exit('8004050,' + lQtySetup."Value 2 Name");
            3:
                exit('8004050,' + lQtySetup."Value 3 Name");
            4:
                exit('8004050,' + lQtySetup."Value 4 Name");
            5:
                exit('8004050,' + lQtySetup."Value 5 Name");
            6:
                exit('8004050,' + lQtySetup."Value 6 Name");
            7:
                exit('8004050,' + lQtySetup."Value 7 Name");
            8:
                exit('8004050,' + lQtySetup."Value 8 Name");
            9:
                exit('8004050,' + lQtySetup."Value 9 Name");
            10:
                exit('8004050,' + lQtySetup."Value 10 Name");
        end;
    end;

    procedure InitQtyPerInvoicingUnit()
    var
        lQtyPerInvoiceUnitOfMeasure: Decimal;
        lQtyPerUnitOfMeasure: Decimal;
    begin
        if Type = Type::Item then begin
            //GL2024  GetItem;
            Item.Get("No.");
            lQtyPerUnitOfMeasure := UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code");
            lQtyPerInvoiceUnitOfMeasure := UOMMgt.GetQtyPerUnitOfMeasure(Item, "Invoicing Unit");
        end else begin
            lQtyPerUnitOfMeasure := 1;
            lQtyPerInvoiceUnitOfMeasure := 1;
        end;

        "Qty. Per Invoicing Unit" := lQtyPerUnitOfMeasure / lQtyPerInvoiceUnitOfMeasure;
    end;




    local procedure lCheckJob(var pPurchLine: Record "Purchase Line"; var pJobNo: Code[20])
    var
        lJob1: Record Job;
        lJob2: Record Job;
        ltFrom: label 'can''t be replaced from an Inventory job.';
        ltTo: label 'can''t be replaced to an Inventory job.';
        ltCancel: label 'You must cancel this receipt (ou return) first';
    begin
        //#6565
        if (pPurchLine."dysJob No." = pJobNo) or (pJobNo = '') then
            exit;
        if lJob1.Get(pJobNo) and lJob2.Get(pPurchLine."dysJob No.") and (lJob1."Job Type" = lJob2."Job Type") then
            pJobNo := pPurchLine."dysJob No."
        ELSE IF lJob1."Job Type" = lJob1."Job Type"::Stock THEN
            pPurchLine.FIELDERROR("Job No.", ltFrom + ' ' + ltCancel)
        ELSE
            pPurchLine.FIELDERROR("Job No.", ltTo + ' ' + ltCancel);
    end;


    //GL2024 crée procedure spécifque pour utilise dans event or tableEXT, car le méme procedure est local dans le code standard 
    procedure OverReceiptProcessing2() Result: Boolean
    var
        OverReceiptMgt: Codeunit "Over-Receipt Mgt.";
        IsHandled: Boolean;
    begin

        if not OverReceiptMgt.IsOverReceiptAllowed() or (Abs("Qty. to Receive") <= Abs("Outstanding Quantity")) then
            exit(false);

        Validate("Over-Receipt Quantity", "Qty. to Receive" - Quantity + "Quantity Received" + "Over-Receipt Quantity");
        exit(true);
    end;

    trigger OnAfterInsert()
    var
        RecPurchaseheader: Record "Purchase Header";
    begin
        if RecPurchaseheader.Get(Rec."Document Type", Rec."Document No.") then begin
            if RecPurchaseheader."Document Type" <> RecPurchaseheader."Document Type"::Order then
                Rec."Job No." := RecPurchaseheader."Job No.";
            Rec."DysJob No." := RecPurchaseheader."Job No.";
            Rec.Modify();
        end;
    end;




    procedure GetGLSetup2()
    begin
        if not GLSetupRead then
            GLSetup.Get();
        GLSetupRead := true;
    end;

    procedure CalcBaseQty2(Qty: Decimal; FromFieldName: Text; ToFieldName: Text): Decimal
    begin

        exit(UOMMgt.CalcBaseQty(
            "No.", "Variant Code", "Unit of Measure Code", Qty, "Qty. per Unit of Measure", "Qty. Rounding Precision (Base)", FieldCaption("Qty. Rounding Precision"), FromFieldName, ToFieldName));
    end;

    local procedure InitItemAppl2()
    begin
        "Appl.-to Item Entry" := 0;
    end;

    //Fin GL2024 crée procedure spécifque pour utilise dans event or tableEXT, car le méme procedure est local dans le code standard 
    local procedure UpdateDimensionsFromJobTask()
    var
        SourceCodeSetup: Record "Source Code Setup";
        DimSetArrID: array[10] of Integer;
        DimValue1: Code[20];
        DimValue2: Code[20];
        IsHandled: Boolean;
        DimMgt: Codeunit DimensionManagement;
    begin
        IsHandled := false;
        //OnBeforeUpdateDimensionsFromJobTask(Rec, CurrFieldNo, IsHandled);
        if not IsHandled then begin
            SourceCodeSetup.Get();
            DimSetArrID[1] := "Dimension Set ID";
            DimSetArrID[2] :=
                DimMgt.CreateDimSetFromJobTaskDim("dysJob No.",
                "Job Task No.", DimValue1, DimValue2);
            DimMgt.CreateDimForPurchLineWithHigherPriorities(
                Rec, CurrFieldNo, DimSetArrID[3], DimValue1, DimValue2, SourceCodeSetup.Purchases, Database::Job);

            "Dimension Set ID" :=
                DimMgt.GetCombinedDimensionSetID(
                DimSetArrID, DimValue1, DimValue2);

            "Shortcut Dimension 1 Code" := DimValue1;
            "Shortcut Dimension 2 Code" := DimValue2;
        end;
    end;


    var
        UnitCostCurrency: Decimal;
        UOMMgt: Codeunit "Unit of Measure Management";
        Text001: label 'You cannot change %1 because the order line is associated with sales order %2.';
        Text004: label 'must not be less than %1';
        GLSetupRead: Boolean;
        Text040: label 'Impossible De Changer Le Magasin, Demande Achat Lié';
        Text8001400: label 'Must not be larger than %1.';
        //JobJnlLine: Record 210 TEMPORARY;
        JobJnlLine: Record "Job Journal Line" TEMPORARY;
        gLicensePermission: Record "License Permission";
        gSubscrIntegration: Codeunit "Purch. Subscription Integr.";
        wPurchLineDisc: Record "Purchase Line Discount";
        wSalesOrderHeader: Record "Sales Header";
        wRecordref: RecordRef;
        wCalcQty: Codeunit "Calculate Quantity";
        TextMultiple: label 'Insert in progress.';
        TextToMuch: label 'Do you want to insert the %1 %2s?';
        Text8004091: label 'The delete has been interrupted to respect the warning.';
        Text8003917: label 'Must not be larger than %1.';
        Text8004090: label 'One or more related offers that include item no. %1.\\Do you confirm ?';
        "// HJ": Integer;
        RecItem: Record Item;
        RecPurchasePrice: Record "Purchase Price";
        RecPurchasePrice2: Record "Purchase Price";
        RecPurchasePrice3: Record "Purchase Price";
        RecPurchasePrice4: Record "Purchase Price";

        Text045: label 'Article Deja Existant Dans Cette Commande, Vous n''avez Le droit D''untilser Un Article Qu''une Seule Fois';
        RecPurchaseHeader: Record "Purchase Header";
        "// RB SORO": Integer;
        "CUPurch.-Post": Codeunit "Purch.-Post";
        Text046: label 'Affaire %1 Non Lié A Aucun Magasin';
        QteRecevoir: Decimal;
        RecVehicule: Record "Véhicule";
        RecPrixBeton: Record "Temp beton Prix";
        SalesOrderLine: Record "Sales Line";
        TempPurchLine: Record "Purchase Line";
        Currency: Record Currency;
        PurchHeader: Record "Purchase Header";
        CurrExchRate: Record "Currency Exchange Rate";
        Item: Record Item;
        Text99000000: label 'You cannot change %1 when the purchase order is associated to a production order.';
        Text010: label 'You cannot change %1 when %2 is %3.';
        GLSetup: Record "General Ledger Setup";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        StdTxt: Record "Standard Text";
        Location: Record 14;

}

