Table 8004165 "Job Journal Line2"
{
    // //RES_GROUP CW 28/09/09
    // //RES_USAGE CW 25/09/09
    // //PLANNING\\
    // //ABSENCE\\
    // //+ONE+TRAVEL MB 17/10/07 Modification du champ "Intervention Zone Code" par "Travel Post Code" en code 20 et relié à "Post Code"
    // //+JOB+ MB 11/07/07 MAJ Job task No. avec Default job task sur validate job No.
    // //POINTAGE MB 06/02/07 ajout clef Type,No.,Work Type Code,Posting Date
    // //PROJET GESWAY 21/06/02 Champs "Entry Type" Editable OUI
    //                 30/11/04 MAJ du champ "Location Code" à partir JobJnlBatch."Default Location Code"
    // //STOCK GESWAY 01/09/03 Ajout champs "Calculated Quantity","Date Filter","Phys. Inventory"
    // //PROJET_PHASE GESWAY 01/11/01 Phase code : TableRelation, ajout de Where Job No.  + blocked à NO
    //                                Contrôle de la phase si changement du projet
    // //PROJET_CESSION GESWAY 20/08/02 Recherche du N° projet contrepartie dans OnValidate de "No."
    //                         30/03/04 (835) Ajout "Bal. Created Entry"
    // //POINTAGE GESWAY 27/05/02 Modification des TableRelation des champs :
    //                              - N° en filtre : "N° groupe ressources" + "N° fournisseur"
    //                              - Job No. :  que les projets commandés (status = Order) + blocked à NO
    //                            "Resource Group No." : Editable OUI
    //                            Ajout champs "Vendor No.","Machine No .","Purch. Order No.","Job Description","Phase Description"
    //                            Mise à jour champs Vendor No., Job Description, Phase Description, Purch. Order No.
    //                            Ajout champs "Quantity 1" à "Quantity 10"
    //                            Mise à jour du projet d'absence et phase associée OnValidate "Work Type Code"
    //                            Validate de "No." dans OnInsert
    //                            Ajout fonction wMajDescription
    //                            Gestion du % majoration du coût dans OnValidate de "Work Type Code"
    //            GESWAY 14/08/02 Ajout des champs "Attached to Line No.","Attached to Ledger Entry No."
    //                            Ajout de la clé Journal Template Name,Journal Batch Name,Attached to Line No.
    //            GESWAY 20/08/02 Ajout champs Intervention Zone Code,Intervention Zone Qty,Driver,Driver Code,Driver Quantity
    //                              alimentés dans OnValidate de "No."
    //                   06/03/03 Ajout Filtre sur "Resource Type" <> Generic (OnLookup de No.)
    //                   03/04/03 Ajout filtre sur Res."WT Allowed" = Oui (OnLookup de No.) + contrôle (OnValidate de No.)
    //                   06/10/03 Ajout du champ "Description Setup"
    //                   10/03/04 Ajout fonctions wDistribution, wCheckAnalyticalDistribution
    //                   28/09/04 Ajout clé Type,No.,Job No.,Work Type Code,Posting Date
    //            CW     08/12/04 Eviter contrôle unité ressource sur Transport,Prime,Panier (OnValidate de "Unit of Measure Code")
    //                   27/12/05 OnValidate(WorkTypeCode) => "Gen. Prod. Posting Group"
    // //INTERIM  GESWAY 11/07/02 Ajout fonction wReachVendor pour renseigner fns, mission dans OnValidate "Posting Date","No."
    //            GESWAY 20/08/02 Ajout "Bal. Job No.", "Mission No.", "Mission Code"
    // //SECURITE GESWAY 30/05/02 Ajout "Security Group Code"
    //                            Gestion de la sécurité dans OnValidate de "Job No."
    // //PREPAIE GESWAY 01/12/01 Ajout clé Type,No.,Work Type Code,Posting Date,Job No.
    // //+REP+ GESWAY 01/12/01 Suppression des Tables Tampon sur OnDelete (nvelle fonction wDeleteAnalyticalDistribution)
    //                         Ajout permision en modification sur table 169
    // //MULTIPLE GESWAY 05/12/03 Gestion de la sélection multiple OnLookup de "No."
    //                            Ajout fonctions wLookUpNo, wLookupResource, wLookupInterim
    // //DESCRIPTION GESWAY 08/12/04 Gestion sur le OnDelete de la suppression des commentaires
    // //PLANNING GESWAY 04/04/05 Ajout Planning Entry No.
    //                            Affichage et choix du groupe de ress. dans OnValidate de "No."
    // //REVERSE GESWAY 13/05/05 Ajout champ "G/L Entry No."
    // //JOB_STATUS CW 24/10/05 lJobStatus.CheckJobJnlLine
    // //ANA_ACTIVITE GESWAY 12/12/05 Init du champ "Task Code" -> Onvalidate("No.","Resource Group"),
    // //POINTAGE MB 10/04/06 Ajout des champs "Sales Document No." et "Sales Line No."
    //            MB 22/05/06 Gestion du LookUp de "Document No." par programmation
    // //IC ML 12/06/06 Modification du tablerelation de "Job No." pour y contrôler "IC Partner" vide
    //                  Ajout des champs "From Company" et "IC Job Ledg. Entry No."
    //                  Mise à jour du champ "From Company" sur le validate de "Job No."

    Caption = 'Job Journal Line';
    Permissions = TableData "G/L Entry" = rim,
                  TableData "Job Ledger Entry2" = rm;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Job Journal Template2";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'Modification TableRelation';
            TableRelation = if (Type = filter(Resource),
                                "Entry Type" = const(Usage)) Job2 where(Status = const(Order),
                                                                      Blocked = const(" "))
            else
            if (Type = filter(<> Resource)) Job2 where(Status = const(Order),
                                                                                                                   Blocked = const(" "),
                                                                                                                   "IC Partner Code" = const(''))
            else
            if (Type = filter(Resource),
                                                                                                                            "Entry Type" = const(Sale)) Job2 where(Status = const(Order),
                                                                                                                                                                 Blocked = const(" "),
                                                                                                                                                                 "IC Partner Code" = const(''));

            trigger OnValidate()
            var
                //  lJobStatusMgt: Codeunit "Job Status Management";
                lIC: Record "IC Partner";
                lJobJnlLine: Record "Job Journal Line2";
            begin
                if "Job No." = '' then begin
                    //POINTAGE
                    "Purch. Order No." := '';
                    //POINTAGE//
                    Validate("Currency Code", '');
                    Validate("Job Task No.", '');
                    CreateDim(
                      Database::Job2, "Job No.",
                      DimMgt.TypeToTableID2(Type), "No.",
                      Database::"Resource Group", "Resource Group No.");
                    exit;
                end;

                GetJob;
                Job.TestBlocked;
                //#4718
                //#5472
                //IF (Job."Job Type" <> Job."Job Type"::Internal) AND (Job."IC Partner Code" = '') THEN BEGIN
                if (Job."Job Type" = Job."job type"::External) and (Job."IC Partner Code" = '') then begin
                    //#5472//
                    Job.TestField("Bill-to Customer No.");
                    Cust.Get(Job."Bill-to Customer No.");
                end;
                //#4718//
                //+JOB+
                //VALIDATE("Job Task No.",'');
                //#5118
                //VALIDATE("Job Task No.",Job.gGetDefaultJobTask);
                "Job Task No." := Job.gGetDefaultJobTask;
                //#5118//
                //+JOB+//
                "Customer Price Group" := Job."Customer Price Group";
                Validate("Currency Code", Job."Currency Code");
                //JOB_STATUS
                //#4418
                if Quantity <> 0 then
                    //#4418//
                    //GL2024   lJobStatusMgt.CheckJobJnlLine(Rec);
                    //JOB_STATUS//
                    //#4876
                    if lJobJnlLine.Get("Journal Template Name", "Journal Batch Name", "Line No.") then
                        //#4876//
                        CreateDim(
                  Database::Job2, "Job No.",
                  DimMgt.TypeToTableID2(Type), "No.",
                  Database::"Resource Group", "Resource Group No.");
                Validate("Country/Region Code", Cust."Country/Region Code");
                //POINTAGE
                CalcFields("Job Description");
                //POINTAGE//

                //POINTAGE
                wMajDescription;
                //POINTAGE//
                //IC
                if Job."IC Partner Code" <> '' then begin
                    lIC.Get(Job."IC Partner Code");
                    "From Company" := lIC."Inbox Details";
                end
                else
                    "From Company" := '';
                //IC//

                //+ONE+TRAVEL
                if (Job."Travel Code" <> '') and ("No." <> '') then
                    if Res.Get("No.") then
                        fTravel(Res, Job);
                //+ONE+TRAVEL//
                //#8108
                if xRec."Job No." <> "Job No." then begin
                    Clear("Source Record ID");
                    Clear("Source Line No.");
                end;
                //#8108//
            end;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                Validate("Document Date", "Posting Date");
                //INTERIM
                wReachVendor;
                //INTERIM//
                if "Currency Code" <> '' then begin
                    UpdateCurrencyFactor;
                    UpdateAllAmounts;
                end
            end;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account';
            OptionMembers = Resource,Item,"G/L Account";

            trigger OnValidate()
            begin
                Validate("No.", '');
                if Type = Type::Item then begin
                    GetLocation("Location Code");
                    Location.TestField("Directed Put-away and Pick", false);
                end;
            end;
        }
        field(8; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'Modification TableRelation';
            TableRelation = if (Type = const(Resource)) Resource
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("G/L Account")) "G/L Account";

            trigger OnLookup()
            var
                lMultiple: Boolean;
            begin
                //MULTIPLE
                wLookUpNo(Rec, lMultiple);
                //MULTIPLE//
            end;

            trigger OnValidate()
            var
                //   lBalJob: Codeunit "Create Bal. Job Journal Line";
                lResGr: Record "Resource / Resource Group";
                lTravel: Record "Travel Relation";
                lBalJobGenerate: Boolean;
                lGrRes: Record "Resource Group";
            begin
                //#5588
                lBalJobGenerate := true;
                //#5588//
                if ("No." = '') or ("No." <> xRec."No.") then begin
                    //POINTAGE
                    "Vendor No." := '';
                    Description := '';
                    "Mission Code" := '';
                    "Mission No." := '';
                    "Bal. Job No." := '';
                    //POINTAGE//
                    Description := '';
                    "Unit of Measure Code" := '';
                    "Qty. per Unit of Measure" := 1;
                    "Variant Code" := '';
                    //POINTAGE  "Work Type Code" := '';
                    DeleteAmounts;
                    //POINTAGE
                    Quantity := xRec.Quantity;
                    "Quantity (Base)" := xRec."Quantity (Base)";
                    //POINTAGE//
                    "Cost Factor" := 0;
                    "Applies-to Entry" := 0;
                    "Applies-from Entry" := 0;
                    CheckedAvailability := false;
                    if "No." = '' then begin
                        CreateDim(
                          DimMgt.TypeToTableID2(Type), "No.",
                          Database::Job2, "Job No.",
                          Database::"Resource Group", "Resource Group No.");
                        exit;
                    end else begin
                        // Preserve quantities after resetting all amounts:
                        Quantity := xRec.Quantity;
                        "Quantity (Base)" := xRec."Quantity (Base)";
                    end;
                end;

                case Type of
                    Type::Resource:
                        begin
                            Res.Get("No.");
                            Res.TestField(Blocked, false);
                            //POINTAGE
                            if not JobJnlTemplate.Get("Journal Template Name") then
                                JobJnlTemplate.Init;
                            //#6138
                            //       IF JobJnlTemplate.Type = JobJnlTemplate.Type::"1" THEN
                            //#6138//
                            //#6350
                            if Res.Type in [Res.Type::Person, Res.Type::Machine] then
                                //#6350//
                                Res.TestField("WT Allowed", true);
                            //POINTAGE//
                            Description := Res.Name;
                            "Description 2" := Res."Name 2";
                            //PLANNING
                            if ("Resource Group No." = '') and (CurrFieldNo <> 0) then begin
                                Commit;
                                lResGr.SetRange("Resource No.", "No.");
                                if lResGr.Count <= 1 then begin
                                    if lResGr.Find('-') then
                                        "Resource Group No." := lResGr."Resource Group No.";
                                end else
                                    //DYS PAGE ADDON NON MIGRER
                                    // if PAGE.RunModal(page::"Resources / Resource Groups", lResGr) = Action::LookupOK then
                                    "Resource Group No." := lResGr."Resource Group No.";
                            end;
                            if "Resource Group No." = '' then
                                //PLANNING//
                                "Resource Group No." := Res."Resource Group No.";
                            //#7634
                            //  if ("Resource Group No." <> '') and (CurrFieldNo <> 0) then
                            //Res.gCheckResGrp("No.", "Resource Group No.", true);
                            //#7634//
                            //#7248
                            //#7403     "Resource Group No." := Res."Resource Group No.";
                            "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
                            //#7248//
                            //#5839//
                            if lGrRes.Get("Resource Group No.") then begin
                                if lGrRes."Gen. Prod. Posting Group" <> '' then
                                    "Gen. Prod. Posting Group" := lGrRes."Gen. Prod. Posting Group";
                            end;
                            //#5839//
                            //#5059
                            if "Gen. Prod. Posting Group" = '' then
                                //#5059//
                                "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
                            Validate("Unit of Measure Code", Res."Base Unit of Measure");
                            //POINTAGE
                            Validate("Resource Group No.");
                            //POINTAGE//
                            //INTERIM
                            wReachVendor;
                            //INTERIM//
                            //POINTAGE
                            if "Work Type Code" = '' then
                                "Work Type Code" := Res."Work Type Code";
                            //+ONE+TRAVEL
                            if (Res."Travel Code" <> '') and ("Job No." <> '') then
                                if Job.Get("Job No.") then
                                    fTravel(Res, Job);
                            //+ONE+TRAVEL//
                            //POINTAGE//
                        end;
                    Type::Item:
                        begin
                            GetItem;
                            Item.TestField(Blocked, false);
                            Description := Item.Description;
                            "Description 2" := Item."Description 2";
                            //POINTAGE
                            "Resource Group No." := '';
                            //POINTAGE//
                            if Job."Language Code" <> '' then
                                GetItemTranslation;
                            "Posting Group" := Item."Inventory Posting Group";
                            "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                            Validate("Unit of Measure Code", Item."Base Unit of Measure");
                        end;
                    Type::"G/L Account":
                        begin
                            GLAcc.Get("No.");
                            GLAcc.CheckGLAcc;
                            GLAcc.TestField("Direct Posting", true);
                            Description := GLAcc.Name;
                            //POINTAGE
                            "Resource Group No." := '';
                            //POINTAGE//
                            "Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
                            "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                            "Unit of Measure Code" := '';
                            "Direct Unit Cost (LCY)" := 0;
                            "Unit Cost (LCY)" := 0;
                            "Unit Price" := 0;
                            //#5588
                            lBalJobGenerate := GLAcc."Post Job Entry";
                            //#5588//
                        end;
                end;

                //POINTAGE
                if Type = Type::Resource then
                    Validate("Work Type Code");
                //POINTAGE//

                Validate(Quantity);

                CreateDim(
                  DimMgt.TypeToTableID2(Type), "No.",
                  Database::Job2, "Job No.",
                  Database::"Resource Group", "Resource Group No.");
                //POINTAGE
                wMajDescription;
                if (Description = '') and ("Work Type Code" <> '') then
                    Validate("Work Type Code");
                //POINTAGE//
                //PROJET_CESSION
                //#5588
                //IF ("Bal. Job No." = '') THEN BEGIN
                //#6628
                //IF ("Bal. Job No." = '') AND lBalJobGenerate THEN BEGIN
                if ("Bal. Job No." = '') and lBalJobGenerate and ("Journal Template Name" <> '') then begin
                    //#6628//
                    //#5588//
                    //GL2024    "Bal. Job No." := lBalJob.SearchBalJobNoFromType(Rec);
                    TestField("Bal. Job No.");
                end;
                //PROJET_CESSION//
            end;
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                //POINTAGE
                if Description <> '' then
                    "Description setup" := Description
                else
                    wMajDescription;

                //POINTAGE//
            end;
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                CheckItemAvailable;

                /*  //GL2024      if Item."Item Tracking Code" <> '' then
                         ReserveJobJnlLine.VerifyQuantity(Rec, xRec);*/
                "Quantity (Base)" := CalcBaseQty(Quantity);
                UpdateAllAmounts;
                // >> HJ DSFT 27-06-2012
                Ecart := "Quantité Theorique" - Quantity;
                if "Quantité Theorique" <> 0 then "% Ecart" := Quantity / "Quantité Theorique";
                // >> HJ DSFT 27-06-2012
            end;
        }
        field(12; "Direct Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost (LCY)';
            MinValue = 0;
        }
        field(13; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if (Type = Type::Item) and
                   Item.Get("No.") and
                   (Item."Costing Method" = Item."costing method"::Standard) then
                    UpdateAllAmounts
                else begin
                    GetJob;
                    "Unit Cost" := ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          "Posting Date", "Currency Code",
                          "Unit Cost (LCY)", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                    UpdateAllAmounts;
                end;
            end;
        }
        field(14; "Total Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Cost (LCY)';
            Editable = false;
        }
        field(15; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                GetJob;
                "Unit Price" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Posting Date", "Currency Code",
                      "Unit Price (LCY)", "Currency Factor"),
                    UnitAmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(16; "Total Price (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Quantity);
                GetCurrency;
                Validate("Unit Price (LCY)", ROUND("Total Price (LCY)" / Quantity, Currency."Unit-Amount Rounding Precision"))
            end;
        }
        field(17; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            Description = '+PLA+Editable=Yes';
            Editable = true;
            TableRelation = "Resource Group";

            trigger OnValidate()
            var
                lResourceGroup: Record "Resource Group";
                lResResGroup: Record "Resource / Resource Group";
            begin
                //RES_GROUP
                TestField(Type, Type::Resource);
                TestField("Entry Type", "entry type"::Usage);
                if ("No." <> '') and ("Resource Group No." <> '') and (Rec."No." = xRec."No.") then
                    lResResGroup.Get("No.", "Resource Group No.");
                if lResourceGroup.Get("Resource Group No.") and ("Gen. Prod. Posting Group" <> '') then
                    "Gen. Prod. Posting Group" := lResourceGroup."Gen. Prod. Posting Group";
                //RES_GROUP//
                CreateDim(
                  Database::"Resource Group", "Resource Group No.",
                  Database::Job, "Job No.",
                  DimMgt.TypeToTableID2(Type), "No.");
            end;
        }
        field(18; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            "Unit of Measure";

            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
                GetGLSetup;
                case Type of
                    Type::Item:
                        begin
                            Item.Get("No.");
                            "Qty. per Unit of Measure" :=
                              UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code");
                        end;
                    Type::Resource:
                        begin
                            //POINTAGE
                            //      IF CurrFieldNo <> FIELDNO("Work Type Code") THEN
                            if (CurrFieldNo <> FieldNo("Work Type Code")) and ("Entry Type" = "entry type"::Sale) then
                                //POINTAGE//
                                if "Work Type Code" <> '' then begin
                                    WorkType.Get("Work Type Code");
                                    if WorkType."Unit of Measure Code" <> '' then
                                        TestField("Unit of Measure Code", WorkType."Unit of Measure Code");
                                    //RES_USAGE
                                    WorkType.TestField(WorkType."Quantity (Base) in Hours", true);
                                    //RES_USAGE//
                                end else
                                    TestField("Work Type Code", '');
                            if "Unit of Measure Code" = '' then begin
                                Resource.Get("No.");
                                "Unit of Measure Code" := Resource."Base Unit of Measure";
                            end;
                            ResUnitofMeasure.Get("No.", "Unit of Measure Code");
                            "Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
                            "Quantity (Base)" := Quantity * "Qty. per Unit of Measure";
                        end;
                    Type::"G/L Account":
                        begin
                            "Qty. per Unit of Measure" := 1;
                        end;
                end;
                Validate(Quantity);
            end;
        }
        field(21; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));

            trigger OnValidate()
            begin
                "Bin Code" := '';
                if Type = Type::Item then begin
                    GetLocation("Location Code");
                    Location.TestField("Directed Put-away and Pick", false);
                    Validate(Quantity);
                end;
            end;
        }
        field(22; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
            InitValue = true;

            trigger OnValidate()
            begin
                if Chargeable <> xRec.Chargeable then
                    if Chargeable = false then
                        Validate("Unit Price", 0)
                    else
                        Validate("No.");
            end;
        }
        field(30; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = if (Type = const(Item)) "Inventory Posting Group"
            else
            if (Type = const("G/L Account")) "G/L Account";
        }
        field(31; "Shortcut Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(32; "Shortcut Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(33; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";

            trigger OnValidate()
            begin
                TestField(Type, Type::Resource);
                //#9085
                xRec."Work Type Code" := '';
                //#9085//
                Validate("Line Discount %", 0);
                if ("Work Type Code" = '') and (xRec."Work Type Code" <> '') then begin
                    Res.Get("No.");
                    "Unit of Measure Code" := Res."Base Unit of Measure";
                    Validate("Unit of Measure Code");
                end;

                //POINTAGE
                if WorkType.Get("Work Type Code") then begin
                    //#8272 IF WorkType.GET("Work Type Code") AND ("No." <> '') THEN BEGIN
                    if ("No." <> '') then begin
                        wMajDescription;
                        if WorkType."Job Absence No." <> '' then begin
                            Validate("Job No.", WorkType."Job Absence No.");
                        end;
                        "Work Time Type" := WorkType."Work Time Type";
                        if WorkType."Gen. Prod. Posting Group" <> '' then
                            "Gen. Prod. Posting Group" := WorkType."Gen. Prod. Posting Group";
                        //POINTAGE//
                        if WorkType."Unit of Measure Code" <> '' then begin
                            "Unit of Measure Code" := WorkType."Unit of Measure Code";
                            if ResUnitofMeasure.Get("No.", "Unit of Measure Code") then
                                "Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
                            //RES_USAGE
                        end else
                            if not WorkType."Quantity (Base) in Hours" then begin
                                "Unit of Measure Code" := '';
                                "Qty. per Unit of Measure" := 0;
                                //RES_USAGE//
                            end else begin
                                Res.Get("No.");
                                "Unit of Measure Code" := Res."Base Unit of Measure";
                                Validate("Unit of Measure Code");
                                //   FindResCost;
                                //POINTAGE
                                //  PurchPriceCalcMgt.FindJobJnlLinePrice(Rec,FIELDNO("No."));
                                //POINTAGE//
                                //DYS A VERIFIER
                                //  SalesPriceCalcMgt.FindJobJnlLinePrice(Rec, CurrFieldNo);
                            end;
                        //POINTAGE
                        if WorkType."Increase %" <> 0 then begin
                            //#9085
                            xRec."Work Type Code" := Rec."Work Type Code";
                            //#9085
                            Validate("Unit Cost", "Unit Cost" * (1 + (WorkType."Increase %" / 100)));
                            Validate("Direct Unit Cost (LCY)", "Direct Unit Cost (LCY)" * (1 + (WorkType."Increase %" / 100)));
                        end;
                        //POINTAGE//
                        //#8272
                    end else begin
                        "Work Time Type" := WorkType."Work Time Type";
                        wMajDescription;
                        if WorkType."Job Absence No." <> '' then begin
                            Validate("Job No.", WorkType."Job Absence No.");
                        end;
                        if WorkType."Gen. Prod. Posting Group" <> '' then
                            "Gen. Prod. Posting Group" := WorkType."Gen. Prod. Posting Group";
                        if WorkType."Unit of Measure Code" <> '' then begin
                            "Unit of Measure Code" := WorkType."Unit of Measure Code";
                            if ResUnitofMeasure.Get("No.", "Unit of Measure Code") then
                                "Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
                        end;
                    end;
                    //#8272//
                end;
                Validate(Quantity);

                //POINTAGE
                if Description = '' then begin
                    if WorkType.Get("Work Type Code") then;
                    if Res.Get("No.") then;
                    Description := CopyStr(Res.Name + ' ' + WorkType.Description, 1, MaxStrLen(Description));
                end;
                //POINTAGE//
            end;
        }
        field(34; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";

            trigger OnValidate()
            begin
                if (Type = Type::Item) and ("No." <> '') then begin
                    UpdateAllAmounts;
                end;
            end;
        }
        field(37; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';

            trigger OnLookup()
            begin
                SelectItemEntry(FieldNo("Applies-to Entry"));
            end;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                GetJob;
                TestField(Type, Type::Item);
                if "Applies-to Entry" <> 0 then begin
                    ItemLedgEntry.Get("Applies-to Entry");
                    TestField(Quantity);
                    if Quantity < 0 then
                        FieldError(Quantity, Text002);
                    ItemLedgEntry.TestField(Open, true);
                    ItemLedgEntry.TestField(Positive, true);
                    "Location Code" := ItemLedgEntry."Location Code";
                    "Variant Code" := ItemLedgEntry."Variant Code";
                    GetItem;
                    if Item."Costing Method" <> Item."costing method"::Standard then begin
                        "Unit Cost" := ROUND(
                            CurrExchRate.ExchangeAmtLCYToFCY(
                              "Posting Date", "Currency Code",
                              CalcUnitCost(ItemLedgEntry), "Currency Factor"),
                            UnitAmountRoundingPrecision);
                        UpdateAllAmounts;
                    end;
                end;
            end;
        }
        field(61; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Editable = true;
            OptionCaption = 'Usage,Sale';
            OptionMembers = Usage,Sale;
        }
        field(62; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(73; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Job Journal Batch2".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(74; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(75; "Recurring Method"; Option)
        {
            //blankzero = true;
            Caption = 'Recurring Method';
            OptionCaption = ',Fixed,Variable';
            OptionMembers = ,"Fixed",Variable;
        }
        field(76; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(77; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency';
        }
        field(79; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(80; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            var
                lGenProdPostingGrp: Record "Gen. Product Posting Group";
            begin
                //POINTAGE
                if lGenProdPostingGrp.Get("Gen. Prod. Posting Group") then
                    lGenProdPostingGrp.TestField(Summarize, false);
                //POINTAGE//
            end;
        }
        field(81; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(82; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(83; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(86; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(87; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(88; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(89; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(90; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(91; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';

            trigger OnLookup()
            begin
                TestField(Type, Type::Item);
                SelectItemEntry(FieldNo("Serial No."));
            end;
        }
        field(92; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(93; "Source Currency Code"; Code[10])
        {
            Caption = 'Source Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(94; "Source Currency Total Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Currency Total Cost';
            Editable = false;
        }
        field(95; "Source Currency Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Currency Total Price';
            Editable = false;
        }
        field(96; "Source Currency Line Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Currency Line Amount';
            Editable = false;
        }
        field(1000; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task2"."Job Task No." where("Job No." = field("Job No."),
                                                             Blocked = const(false));

            trigger OnValidate()
            var
                JobTask: Record "Job Task2";
            begin
                if ("Job Task No." = '') or (("Job Task No." <> xRec."Job Task No.") and (xRec."Job Task No." <> '')) then begin
                    Validate("No.", '');
                    exit;
                end;

                //RES_USAGE
                if (Type <> Type::Resource) or ("Entry Type" <> "entry type"::Usage) then
                    //RES_USAGE//
                    TestField("Job No.");
                JobTask.Get("Job No.", "Job Task No.");
                JobTask.TestField("Job Task Type", JobTask."job task type"::Posting);
            end;
        }
        field(1001; "Total Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Cost';
            Editable = false;
        }
        field(1002; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1003; "Line Type"; Option)
        {
            Caption = 'Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(1004; "Applies-from Entry"; Integer)
        {
            Caption = 'Applies-from Entry';
            MinValue = 0;

            trigger OnLookup()
            begin
                SelectItemEntry(FieldNo("Applies-from Entry"));
            end;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                GetJob;
                TestField(Type, Type::Item);
                if "Applies-from Entry" <> 0 then begin
                    TestField(Quantity);
                    if Quantity > 0 then
                        FieldError(Quantity, Text003);
                    ItemLedgEntry.Get("Applies-from Entry");
                    ItemLedgEntry.TestField(Positive, false);
                    if Item."Costing Method" <> Item."costing method"::Standard then begin
                        "Unit Cost" := ROUND(
                            CurrExchRate.ExchangeAmtLCYToFCY(
                              "Posting Date", "Currency Code",
                              CalcUnitCostFrom(ItemLedgEntry."Entry No."), "Currency Factor"),
                            UnitAmountRoundingPrecision);
                        UpdateAllAmounts;
                    end;
                end;
            end;
        }
        field(1005; "Job Posting Only"; Boolean)
        {
            Caption = 'Job Posting Only';
        }
        field(1006; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1007; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1008; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                UpdateCurrencyFactor;
            end;
        }
        field(1009; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1010; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                    FieldError("Currency Factor", StrSubstNo(Text001, FieldCaption("Currency Code")));
                UpdateAllAmounts;
            end;
        }
        field(1011; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1012; "Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                GetJob;
                "Line Amount" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Posting Date", "Currency Code",
                      "Line Amount (LCY)", "Currency Factor"),
                    AmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(1013; "Line Discount Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                GetJob;
                "Line Discount Amount" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Posting Date", "Currency Code",
                      "Line Discount Amount (LCY)", "Currency Factor"),
                    AmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(1014; "Total Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Price';
            Editable = false;
        }
        field(1015; "Cost Factor"; Decimal)
        {
            Caption = 'Cost Factor';
            Editable = false;
        }
        field(1016; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(1017; "Ledger Entry Type"; Option)
        {
            Caption = 'Ledger Entry Type';
            OptionCaption = ' ,Resource,Item,G/L Account';
            OptionMembers = " ",Resource,Item,"G/L Account";
        }
        field(1018; "Ledger Entry No."; Integer)
        {
            //blankzero = true;
            Caption = 'Ledger Entry No.';
            TableRelation = if ("Ledger Entry Type" = const(Resource)) "Res. Ledger Entry"
            else
            if ("Ledger Entry Type" = const(Item)) "Item Ledger Entry"
            else
            if ("Ledger Entry Type" = const("G/L Account")) "G/L Entry";
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));

            trigger OnValidate()
            begin
                if "Variant Code" = '' then begin
                    if Type = Type::Item then begin
                        Item.Get("No.");
                        Description := Item.Description;
                        "Description 2" := Item."Description 2";
                        GetItemTranslation;
                    end;
                    exit;
                end;

                TestField(Type, Type::Item);

                ItemVariant.Get("No.", "Variant Code");
                Description := ItemVariant.Description;
                "Description 2" := ItemVariant."Description 2";

                Validate(Quantity);
            end;
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));

            trigger OnValidate()
            begin
                TestField("Location Code");
                CheckItemAvailable;
            end;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5410; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Measure", 1);
                Validate(Quantity, "Quantity (Base)");
            end;
        }
        field(5468; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = sum("Reservation Entry"."Quantity (Base)" where("Source ID" = field("Journal Template Name"),
                                                                           "Source Ref. No." = field("Line No."),
                                                                           "Source Type" = const(1011),
                                                                           "Source Subtype" = field("Entry Type"),
                                                                           "Source Batch Name" = field("Journal Batch Name"),
                                                                           "Source Prod. Order Line" = const(0),
                                                                           "Reservation Status" = const(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5900; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
        }
        field(5901; "Posted Service Shipment No."; Code[20])
        {
            Caption = 'Posted Service Shipment No.';
        }
        field(6501; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            Editable = false;
        }
        field(50000; "Quantité Theorique"; Decimal)
        {
            Description = 'HJ DSFT 27-06-2012';
            Editable = false;
        }
        field(50001; Ecart; Decimal)
        {
            Description = 'HJ DSFT 27-06-2012';
            Editable = false;
        }
        field(50002; "% Ecart"; Decimal)
        {
            Description = 'HJ DSFT 27-06-2012';
        }
        field(8003900; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor where("External Work Force" = const(true));

            trigger OnValidate()
            begin
                //POINTAGE
                wMajDescription;
                //POINTAGE//
            end;
        }
        field(8003901; "Machine No."; Code[20])
        {
            Caption = 'Machine No.';
            TableRelation = Resource."No." where(Type = const(Machine));

            trigger OnValidate()
            begin
                //POINTAGE
                wMajDescription;
                //POINTAGE//
            end;
        }
        field(8003902; "Purch. Order No."; Code[20])
        {
            Caption = 'Purch. Order No.';
            TableRelation = "Purchase Line"."Document No." where("Document Type" = const(Order),
                                                                  "Buy-from Vendor No." = field("Vendor No."),
                                                                  "Job No." = field("Job No."),
                                                                  "Outstanding Quantity" = filter(> 0));
        }
        field(8003903; "Job Description"; Text[50])
        {
            CalcFormula = lookup(Job.Description where("No." = field("Job No.")));
            Caption = 'Job Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003906; "Quantity 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(1);
            Caption = 'Quantiy 1';
        }
        field(8003907; "Quantity 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(2);
            Caption = 'Quantiy 2';
        }
        field(8003908; "Quantity 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(3);
            Caption = 'Quantiy 3';
        }
        field(8003909; "Quantity 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(4);
            Caption = 'Quantiy 4';
        }
        field(8003910; "Quantity 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(5);
            Caption = 'Quantiy 5';
        }
        field(8003911; "Quantity 6"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(6);
            Caption = 'Quantiy 6';
        }
        field(8003912; "Quantity 7"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(7);
            Caption = 'Quantiy 7';
        }
        field(8003913; "Quantity 8"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(8);
            Caption = 'Quantiy 8';
        }
        field(8003914; "Quantity 9"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(9);
            Caption = 'Quantiy 9';
        }
        field(8003915; "Quantity 10"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(10);
            Caption = 'Quantiy 10';
        }
        field(8003916; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
        }
        field(8003917; "Attached to Ledger Entry No."; Integer)
        {
            Caption = 'Attached to Ledger Entry No.';
        }
        field(8003918; "Bal. Job No."; Code[20])
        {
            Caption = 'Bal. Job No.';
            TableRelation = Job2;
        }
        field(8003919; "Intervention Zone Code"; Code[10])
        {
            Caption = 'Intervention Zone Code';
            TableRelation = "Work Type".Code where("Work Time Type" = const(Transport));
        }
        field(8003920; "Intervention Zone Qty"; Decimal)
        {
            //blankzero = true;
            Caption = 'Intervention Zone Qty';
        }
        field(8003921; "Driver Code"; Code[10])
        {
            Caption = 'Driver Code';
            TableRelation = "Work Type".Code where("Work Time Type" = const(Transport));
        }
        field(8003922; "Driver Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Driver Quantity';
        }
        field(8003923; "Mission No."; Code[20])
        {
            Caption = 'Mission No.';
        }
        field(8003924; "Work Time Type"; Option)
        {
            Caption = 'Work Time Type';
            OptionCaption = ' ,Producted Hours,Unproduced Hours,Absence Hours,Premium,Transport,Meal';
            OptionMembers = " ","Producted Hours","Unproduced Hours","Absence Hours",Premium,Transport,Meal;
        }
        field(8003925; "Mission Code"; Code[10])
        {
            Caption = 'Mission Code';
            TableRelation = Mission;
        }
        field(8003926; "Calculated Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry2".Quantity where("Job No." = field("Job No."),
                                                                 Type = filter(Item),
                                                                 "No." = field("No."),
                                                                 "Entry Type" = filter(Usage),
                                                                 "Posting Date" = field("Date Filter")));
            Caption = 'Calculated Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003927; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(8003928; "Phys. Inventory"; Boolean)
        {
            Caption = 'Phys. Inventory';
            Editable = false;
        }
        field(8003929; "Description setup"; Text[50])
        {
            Caption = 'Description Setup';
            InitValue = '***';
        }
        field(8003930; "G/L Entry No."; Integer)
        {
            //blankzero = true;
            Caption = 'G/L Entry No.';
            TableRelation = "G/L Entry";
        }
        field(8003931; "From Company"; Text[30])
        {
            Caption = 'From Company';
            TableRelation = Company;
        }
        field(8003932; "IC Job Ledg. Entry No."; Integer)
        {
            Caption = 'IC Job Ledg. Entry No.';
        }
        field(8003933; "Receipt not Invoiced Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced" where("Job No." = field("Job No."),
                                                                                  Type = const(Item),
                                                                                  "No." = field("No."),
                                                                                  "Posting Date" = field("Date Filter")));
            Caption = 'Calculated Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004009; "Bal. Created Entry"; Boolean)
        {
            Caption = 'Bal. Created Entry';
        }
        field(8004030; "Planning Entry No."; Integer)
        {
            //blankzero = true;
            Caption = 'Planning Entry No.';
        }
        field(8004141; "Employee Absence Entry No."; Integer)
        {
            Caption = 'Employee Absence Entry No.';
        }
        field(8035001; "Project Header No."; Code[20])
        {
            Caption = 'Project Header No.';
            TableRelation = if ("Job No." = filter(<> '')) "Planning Header Archive"."No." where("Job No." = field("Job No."))
            else
            if ("Job No." = const('')) "Planning Header Archive"."No.";
        }
        field(8035003; "Planning Task No."; Text[20])
        {
            Caption = 'Planning Task No.';
            TableRelation = if ("Project Header No." = filter(<> '')) "Planning Line Archive"."Task No." where("Project Header No." = field("Project Header No."))
            else
            if ("Job No." = filter(<> '')) "Planning Line Archive"."Task No." where("Job No." = field("Job No."),
                                                                                                       "Project Header No." = field("Project Header No."));

            trigger OnValidate()
            var
            //  lPlanningLineMgt: Codeunit "Planning Task Management";
            begin
                //GL2024   lPlanningLineMgt.gOnValidateJobJnlLine(Rec, CurrFieldNo);
            end;
        }
        field(8035100; "Source Record ID"; RecordID)
        {
            Caption = 'Source Record ID';

            trigger OnLookup()
            var
                lRecID: RecordID;
            //   lPlanningRecIDMgt: Codeunit "Planning RecordID Mgt";
            begin
                /*  //GL2024    if ("Planning Task No." = '') then begin
                       lPlanningRecIDMgt.gJournalRecIDLookUp(Rec);
                   end;*/
            end;
        }
        field(8035101; "Source Line No."; Integer)
        {
            Caption = 'N° ligne document origine';

            trigger OnLookup()
            var
            //   lPlanningRecIDMgt: Codeunit "Planning RecordID Mgt";
            begin
                //GL2024   lPlanningRecIDMgt.gJournalSourceLineLookUp(Rec);
            end;
        }
    }

    keys
    {
        key(STG_Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Journal Template Name", "Journal Batch Name", Type, "No.", "Unit of Measure Code", "Work Type Code")
        {
            MaintainSQLIndex = false;
        }
        key(STG_Key3; "Journal Template Name", "Journal Batch Name", "Attached to Line No.")
        {
        }
        key(STG_Key4; Type, "No.", "Job No.", "Work Type Code", "Posting Date")
        {
        }
        key(STG_Key5; Type, "No.", "Work Type Code", "Posting Date", "Work Time Type", "Job No.")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(STG_Key6; "Journal Template Name", "Journal Batch Name", "Entry Type", "Job No.", "Posting Date", Type, "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lDescriptionLine: Record "Description Line";
    //  lAnaDistribIntegr: Codeunit "Analytical Distrib.Integr.";
    begin
        /*  //GL2024  if Type = Type::Item then
             ReserveJobJnlLine.DeleteLine(Rec);*/
        //DYS fonction obsolet
        // DimMgt.DeleteJnlLineDim(
        //   Database::"Job Journal Line2",
        //   "Journal Template Name", "Journal Batch Name", "Line No.", 0);
        //+REP+
        /*  //GL2024   if gAddOnLicencePermission.HasPermissionREP then
              lAnaDistribIntegr.DeleteAnaDistribFromJob(Rec, false);*/
        //+REP+//
        //DESCRIPTION
        lDescriptionLine.DeleteLines(Database::"Job Journal Line2", 0, "Journal Template Name" + "Journal Batch Name", "Line No.");
        //DESCRIPTION//
    end;

    trigger OnInsert()
    var
        lIC: Record "IC Partner";
    begin
        LockTable;
        JobJnlTemplate.Get("Journal Template Name");
        JobJnlBatch.Get("Journal Template Name", "Journal Batch Name");

        //POINTAGE
        if ("No." <> '') and not wAnalyticalDistribution then begin
            Validate("No.");
        end;
        //#8272
        if ("Work Type Code" <> '') then
            Validate("Work Type Code");
        //#8272//
        //POINTAGE//
        //IC
        if ("Job No." <> '') and ("From Company" = '') then begin
            Job.Get("Job No.");
            if Job."IC Partner Code" <> '' then begin
                lIC.Get(Job."IC Partner Code");
                "From Company" := lIC."Inbox Details";
            end;
        end;
        //IC//

        ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
        ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
        //DYS FONCTION OBSOLET
        // DimMgt.InsertJnlLineDim(
        //   Database::"Job Journal Line2",
        //   "Journal Template Name", "Journal Batch Name", "Line No.", 0,
        //   "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        //IC
        TestField("IC Job Ledg. Entry No.", 0);
        //IC//
        /*  //GL2024    if (Rec.Type = Type::Item) and (xRec.Type = Type::Item) then
               ReserveJobJnlLine.VerifyChange(Rec, xRec)
           else
               if (Rec.Type <> Type::Item) and (xRec.Type = Type::Item) then
                   ReserveJobJnlLine.DeleteLine(xRec);*/
    end;

    trigger OnRename()
    begin
        //GL2024    ReserveJobJnlLine.RenameLine(Rec, xRec);
    end;

    var
        Text000: label 'You cannot change %1 when %2 is %3.';
        Location: Record Location;
        Item: Record Item;
        Res: Record Resource;
        Cust: Record Customer;
        ItemJnlLine: Record "Item Journal Line";
        GLAcc: Record "G/L Account";
        Job: Record Job2;
        WorkType: Record "Work Type";
        JobJnlTemplate: Record "Job Journal Template2";
        JobJnlBatch: Record "Job Journal Batch2";
        JobJnlLine: Record "Job Journal Line2";
        ItemVariant: Record "Item Variant";
        ResUnitofMeasure: Record "Resource Unit of Measure";
        ResCost: Record "Resource Cost2";
        ItemTranslation: Record "Item Translation";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        SKU: Record "Stockkeeping Unit";
        GLSetup: Record "General Ledger Setup";
        /*   SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
           PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
           ResFindUnitCost: Codeunit "Resource-Find Cost";*/
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        NoSeriesMgt: Codeunit 396;
        UOMMgt: Codeunit "Unit of Measure Management";
        DimMgt: Codeunit DimensionManagement;
        //   ReserveJobJnlLine: Codeunit "Job Jnl. Line-Reserve2";
        DontCheckStandardCost: Boolean;
        Text001: label 'cannot be specified without %1';
        Text002: label 'must be positive';
        Text003: label 'must be negative';
        HasGotGLSetup: Boolean;
        CurrencyDate: Date;
        UnitAmountRoundingPrecision: Decimal;
        AmountRoundingPrecision: Decimal;
        CheckedAvailability: Boolean;
        wResGroup: Record "Resource Group";
        wVendor: Record Vendor;
        wInterim: Record "Interim Mission";
        Text8004031: label 'Le Groupe de Ressource %1 n''est pas lié à la ressource %2';
        Text1100280008: label 'You must define one an only one mission for %1 on %2.';
        Text1100280007: label 'You must define one mission for %1 on %2.';
        wUserMgt: Codeunit "User Setup Management";
        wRecordRef: RecordRef;
        // wBasic: Codeunit Basic;
        wNavibatSetup: Record NavibatSetup;
        TextMultiple: label 'Insert in progress.';
        TextToMuch: label 'Do you want to insert the %1 %2s?';
        wAnalyticalDistribution: Boolean;
        TextPointage: label 'You have to select line type Totaling, Structure,Person or Machine.';
    //  gPlanEntryMgt: Codeunit "Planning Management";
    //  gAddOnLicencePermission: Codeunit IntegrManagement;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        //RES_USAGE
        //TESTFIELD("Qty. per Unit of Measure");
        if (Type <> Type::Resource) or ("Entry Type" <> "entry type"::Usage) then;
        //  TestField("Qty. per Unit of Measure");
        //RES_USAGE//
        exit(ROUND(Qty * "Qty. per Unit of Measure", 0.00001));
    end;

    local procedure CheckItemAvailable()
    begin
        if (CurrFieldNo <> 0) and (Type = Type::Item) and (Quantity > 0) and not CheckedAvailability then begin
            ItemJnlLine."Item No." := "No.";
            ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::"Negative Adjmt.";
            ItemJnlLine."Location Code" := "Location Code";
            ItemJnlLine."Variant Code" := "Variant Code";
            ItemJnlLine."Bin Code" := "Bin Code";
            ItemJnlLine."Unit of Measure Code" := "Unit of Measure Code";
            ItemJnlLine."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
            ItemJnlLine.Quantity := Quantity;
            ItemCheckAvail.ItemJnlCheckLine(ItemJnlLine);
            CheckedAvailability := true;
        end;
    end;


    procedure EmptyLine(): Boolean
    begin
        exit(("Job No." = '') and ("No." = '') and (Quantity = 0));
    end;


    procedure SetUpNewLine(LastJobJnlLine: Record "Job Journal Line2"; BelowxRec: Boolean)
    var
        lRec: Record "Job Journal Line2";
    begin
        JobJnlTemplate.Get("Journal Template Name");
        JobJnlBatch.Get("Journal Template Name", "Journal Batch Name");
        JobJnlLine.SetRange("Journal Template Name", "Journal Template Name");
        JobJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
        if JobJnlLine.Find('-') then begin
            "Posting Date" := LastJobJnlLine."Posting Date";
            "Document Date" := LastJobJnlLine."Posting Date";
            "Document No." := LastJobJnlLine."Document No.";
            Type := LastJobJnlLine.Type;
            Validate("Line Type", LastJobJnlLine."Line Type");
        end else begin
            "Posting Date" := WorkDate;
            "Document Date" := WorkDate;
            if JobJnlBatch."No. Series" <> '' then begin
                Clear(NoSeriesMgt);
                "Document No." := NoSeriesMgt.TryGetNextNo(JobJnlBatch."No. Series", "Posting Date");
            end;
        end;
        "Recurring Method" := LastJobJnlLine."Recurring Method";
        "Entry Type" := "entry type"::Usage;
        "Source Code" := JobJnlTemplate."Source Code";
        "Reason Code" := JobJnlBatch."Reason Code";
        "Posting No. Series" := JobJnlBatch."Posting No. Series";
        //PROJET
        "Location Code" := JobJnlBatch."Default Location Code";
        //PROJET//
        //POINTAGE
        CalcFields("Job Description");
        //POINTAGE//
        //MULTIPLE
        //#6949
        //lRec.COPY(Rec);
        lRec.Copy(JobJnlLine);
        //#6949//
        //#6785
        //IF lRec.FINDLAST THEN
        if lRec.FindLast then begin
            //#6785//
            //#6949
            if BelowxRec then
                "Line No." := lRec."Line No." + 10000
            else begin
                //#6949//
                if LastJobJnlLine."Line No." = lRec."Line No." then
                    lRec.SetFilter("Line No.", '<=%1', LastJobJnlLine."Line No.")
                else
                    lRec.SetFilter("Line No.", '<%1', LastJobJnlLine."Line No.");
                if not lRec.FindLast then
                    "Line No." := LastJobJnlLine."Line No." + 10000
                else begin
                    LastJobJnlLine."Line No." := lRec."Line No.";
                    lRec.SetRange("Line No.");
                    if not lRec.Find('>') then
                        "Line No." := LastJobJnlLine."Line No." + 10000
                    else
                        "Line No." := LastJobJnlLine."Line No." + ROUND((lRec."Line No." - LastJobJnlLine."Line No.") / 2, 1);
                end;
                //#6949
            end;
            //#6949//
            //#6785
        end;
        //#6785//
        //MULTIPLE//
    end;


    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        //DYS A VERIFIER
        // DimMgt.GetDefaultDim(
        //   TableID, No, "Source Code",
        //   "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //DYS FONCTION OBSOLET
        // if "Line No." <> 0 then
        //     DimMgt.UpdateJnlLineDefaultDim(
        //       Database::"Job Journal Line2",
        //       "Journal Template Name", "Journal Batch Name", "Line No.", 0,
        //       "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DYS FONCTION OBSOLET
        // if "Line No." <> 0 then
        //     DimMgt.SaveJnlLineDim(
        //       Database::"Job Journal Line2", "Journal Template Name",
        //       "Journal Batch Name", "Line No.", 0, FieldNumber, ShortcutDimCode)
        // else
        //     DimMgt.SaveTempDim(FieldNumber, ShortcutDimCode);
    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        //DYS FONCTION OBSOLET
        // if "Line No." <> 0 then
        //     DimMgt.SaveJnlLineDim(
        //       Database::"Job Journal Line2", "Journal Template Name",
        //       "Journal Batch Name", "Line No.", 0, FieldNumber, ShortcutDimCode)
        // else
        //     DimMgt.SaveTempDim(FieldNumber, ShortcutDimCode);
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        //DYS FONCTION OBSOLET
        // if "Line No." <> 0 then
        //     DimMgt.ShowJnlLineDim(
        //       Database::"Job Journal Line2", "Journal Template Name",
        //       "Journal Batch Name", "Line No.", 0, ShortcutDimCode)
        // else
        //     DimMgt.ShowTempDim(ShortcutDimCode);
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Clear(Location)
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;


    procedure GetJob()
    begin
        //RES_USAGE
        if "Job No." = '' then begin
            GetGLSetup;
            Currency.InitRoundingPrecision;
            AmountRoundingPrecision := GLSetup."Amount Rounding Precision";
            UnitAmountRoundingPrecision := GLSetup."Unit-Amount Rounding Precision";
            exit;
        end;
        //RES_USAGE//
        TestField("Job No.");
        //#7676 IF "Job No." <> Job."No." THEN BEGIN
        if ("Job No." <> Job."No.") or (UnitAmountRoundingPrecision = 0) then begin
            //#7676//
            Job.Get("Job No.");

            if Job."Currency Code" = '' then begin
                GetGLSetup;
                Currency.InitRoundingPrecision;
                AmountRoundingPrecision := GLSetup."Amount Rounding Precision";
                UnitAmountRoundingPrecision := GLSetup."Unit-Amount Rounding Precision";
            end else begin
                GetCurrency;
                Currency.Get(Job."Currency Code");
                Currency.TestField("Amount Rounding Precision");
                AmountRoundingPrecision := Currency."Amount Rounding Precision";
                UnitAmountRoundingPrecision := Currency."Unit-Amount Rounding Precision";
            end;
        end;
    end;

    local procedure UpdateCurrencyFactor()
    begin
        if "Currency Code" <> '' then begin
            if "Posting Date" = 0D then
                CurrencyDate := WorkDate
            else
                CurrencyDate := "Posting Date";
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;

    local procedure GetItem()
    begin
        TestField("No.");
        if "No." <> Item."No." then
            Item.Get("No.");
    end;

    local procedure GetSKU(): Boolean
    begin
        if (SKU."Location Code" = "Location Code") and
           (SKU."Item No." = "No.") and
           (SKU."Variant Code" = "Variant Code")
        then
            exit(true);

        if SKU.Get("Location Code", "No.", "Variant Code") then
            exit(true);

        exit(false);
    end;


    procedure OpenItemTrackingLines(IsReclass: Boolean)
    begin
        TestField(Type, Type::Item);
        TestField("No.");
        //GL2024   ReserveJobJnlLine.CallItemTracking(Rec, IsReclass);
    end;

    local procedure GetCurrency()
    begin
        if "Currency Code" = '' then begin
            Clear(Currency);
            Currency.InitRoundingPrecision
        end else begin
            Currency.Get("Currency Code");
            Currency.TestField("Amount Rounding Precision");
            Currency.TestField("Unit-Amount Rounding Precision");
        end;
    end;


    procedure DontCheckStdCost()
    begin
        DontCheckStandardCost := true;
    end;

    local procedure CalcUnitCost(ItemLedgEntry: Record "Item Ledger Entry"): Decimal
    var
        ValueEntry: Record "Value Entry";
        UnitCost: Decimal;
    begin
        ValueEntry.SetCurrentkey("Item Ledger Entry No.");
        ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
        ValueEntry.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
        UnitCost :=
          (ValueEntry."Cost Amount (Expected)" + ValueEntry."Cost Amount (Actual)") / ItemLedgEntry.Quantity;

        exit(Abs(UnitCost * "Qty. per Unit of Measure"));
    end;

    local procedure CalcUnitCostFrom(ItemLedgEntryNo: Integer): Decimal
    var
        ValueEntry: Record "Value Entry";
        InvoicedQty: Decimal;
        CostAmount: Decimal;
    begin
        InvoicedQty := 0;
        CostAmount := 0;
        ValueEntry.Reset;
        ValueEntry.SetCurrentkey("Item Ledger Entry No.");
        ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgEntryNo);
        ValueEntry.SetRange("Expected Cost", false);
        if ValueEntry.Find('-') then
            repeat
                InvoicedQty += ValueEntry."Invoiced Quantity";
                CostAmount += ValueEntry."Cost Amount (Actual)";
            until ValueEntry.Next = 0;
        exit(CostAmount / InvoicedQty * "Qty. per Unit of Measure");
    end;

    local procedure SelectItemEntry(CurrentFieldNo: Integer)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        JobJnlLine2: Record "Job Journal Line2";
    begin
        ItemLedgEntry.SetCurrentkey("Item No.", Open, "Variant Code");
        ItemLedgEntry.SetRange("Item No.", "No.");
        ItemLedgEntry.SetRange(Correction, false);

        if "Location Code" <> '' then
            ItemLedgEntry.SetRange("Location Code", "Location Code");

        if CurrentFieldNo = FieldNo("Applies-to Entry") then begin
            ItemLedgEntry.SetRange(Positive, true);
            ItemLedgEntry.SetRange(Open, true);
        end else
            ItemLedgEntry.SetRange(Positive, false);

        if PAGE.RunModal(page::"Item Ledger Entries", ItemLedgEntry) = Action::LookupOK then begin
            JobJnlLine2 := Rec;
            if CurrentFieldNo = FieldNo("Applies-to Entry") then
                JobJnlLine2.Validate("Applies-to Entry", ItemLedgEntry."Entry No.")
            else
                JobJnlLine2.Validate("Applies-from Entry", ItemLedgEntry."Entry No.");
            Rec := JobJnlLine2;
        end;
    end;


    procedure DeleteAmounts()
    begin
        Quantity := 0;
        "Quantity (Base)" := 0;

        "Direct Unit Cost (LCY)" := 0;
        "Unit Cost (LCY)" := 0;
        "Unit Cost" := 0;

        "Total Cost (LCY)" := 0;
        "Total Cost" := 0;

        "Unit Price (LCY)" := 0;
        "Unit Price" := 0;

        "Total Price (LCY)" := 0;
        "Total Price" := 0;

        "Line Amount (LCY)" := 0;
        "Line Amount" := 0;

        "Line Discount %" := 0;

        "Line Discount Amount (LCY)" := 0;
        "Line Discount Amount" := 0;
    end;


    procedure SetCurrencyFactor(Factor: Decimal)
    begin
        "Currency Factor" := Factor;
    end;


    procedure GetItemTranslation()
    begin
        GetJob;
        if ItemTranslation.Get("No.", "Variant Code", Job."Language Code") then begin
            Description := ItemTranslation.Description;
            "Description 2" := ItemTranslation."Description 2";
        end;
    end;

    local procedure GetGLSetup()
    begin
        if HasGotGLSetup then
            exit;
        GLSetup.Get;
        HasGotGLSetup := true;
    end;


    procedure UpdateAllAmounts()
    begin
        GetJob;

        UpdateUnitCost;
        UpdateTotalCost;
        FindPriceAndDiscount(Rec, CurrFieldNo);
        HandleCostFactor;
        UpdateUnitPrice;
        UpdateTotalPrice;
        UpdateAmountsAndDiscounts;
    end;

    local procedure UpdateUnitCost()
    var
        RetrievedCost: Decimal;
    begin
        if (Type = Type::Item) and Item.Get("No.") then begin
            if Item."Costing Method" = Item."costing method"::Standard then begin
                if not DontCheckStandardCost then begin
                    // Prevent manual change of unit cost on items with standard cost
                    if (("Unit Cost" <> xRec."Unit Cost") or ("Unit Cost (LCY)" <> xRec."Unit Cost (LCY)")) and
                       (("No." = xRec."No.") and ("Location Code" = xRec."Location Code") and
                        ("Variant Code" = xRec."Variant Code") and ("Unit of Measure Code" = xRec."Unit of Measure Code")) then
                        Error(
                          Text000,
                          FieldCaption("Unit Cost"), Item.FieldCaption("Costing Method"), Item."Costing Method");
                end;
                if RetrieveCostPrice then begin
                    if GetSKU then
                        "Unit Cost (LCY)" := SKU."Unit Cost" * "Qty. per Unit of Measure"
                    else
                        "Unit Cost (LCY)" := Item."Unit Cost" * "Qty. per Unit of Measure";
                    "Unit Cost" := ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          "Posting Date", "Currency Code",
                          "Unit Cost (LCY)", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                end else begin
                    if "Unit Cost" <> xRec."Unit Cost" then
                        "Unit Cost (LCY)" := ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                              "Posting Date", "Currency Code",
                              "Unit Cost", "Currency Factor"),
                            UnitAmountRoundingPrecision)
                    else
                        "Unit Cost" := ROUND(
                            CurrExchRate.ExchangeAmtLCYToFCY(
                              "Posting Date", "Currency Code",
                              "Unit Cost (LCY)", "Currency Factor"),
                            UnitAmountRoundingPrecision);
                end;
            end else begin
                if RetrieveCostPrice then begin
                    if GetSKU then
                        RetrievedCost := SKU."Unit Cost" * "Qty. per Unit of Measure"
                    else
                        RetrievedCost := Item."Unit Cost" * "Qty. per Unit of Measure";
                    "Unit Cost" := ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          "Posting Date", "Currency Code",
                          RetrievedCost, "Currency Factor"),
                        UnitAmountRoundingPrecision);
                    "Unit Cost (LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Posting Date", "Currency Code",
                          "Unit Cost", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                end else begin
                    "Unit Cost (LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Posting Date", "Currency Code",
                          "Unit Cost", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                end;
            end;
        end else
            if (Type = Type::Resource) and Res.Get("No.") then begin
                if RetrieveCostPrice then begin
                    ResCost.Init;
                    ResCost.Code := "No.";
                    ResCost."Work Type Code" := "Work Type Code";
                    //#9123
                    ResCost."Vendor No." := "Vendor No.";
                    ResCost."Mission Code" := "Mission Code";
                    //#9123//
                    //DYS A VERIFIER
                    //  ResFindUnitCost.Run(ResCost);
                    "Direct Unit Cost (LCY)" := ResCost."Direct Unit Cost" * "Qty. per Unit of Measure";
                    //RES_USAGE
                    if "Qty. per Unit of Measure" = 0 then
                        RetrievedCost := ROUND(ResCost."Unit Cost", UnitAmountRoundingPrecision)
                    else
                        //RES_USAGE//
                        RetrievedCost := ROUND(ResCost."Unit Cost" * "Qty. per Unit of Measure", UnitAmountRoundingPrecision);
                    "Unit Cost" := ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          "Posting Date", "Currency Code",
                          RetrievedCost, "Currency Factor"),
                        UnitAmountRoundingPrecision);
                    "Unit Cost (LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Posting Date", "Currency Code",
                          "Unit Cost", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                end else begin
                    "Unit Cost (LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Posting Date", "Currency Code",
                          "Unit Cost", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                end;
            end else begin
                "Unit Cost (LCY)" := ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                      "Posting Date", "Currency Code",
                      "Unit Cost", "Currency Factor"),
                    UnitAmountRoundingPrecision);
            end;
    end;

    local procedure RetrieveCostPrice(): Boolean
    begin
        case Type of
            Type::Item:
                if ("No." <> xRec."No.") or
                   ("Location Code" <> xRec."Location Code") or
                   ("Variant Code" <> xRec."Variant Code") or
                   ("Unit of Measure Code" <> xRec."Unit of Measure Code") and
                   (("Applies-to Entry" = 0) and ("Applies-from Entry" = 0)) then
                    exit(true);
            Type::Resource:
                if ("No." <> xRec."No.") or
                   ("Work Type Code" <> xRec."Work Type Code") or
                   ("Unit of Measure Code" <> xRec."Unit of Measure Code") then
                    exit(true);
            Type::"G/L Account":
                if "No." <> xRec."No." then
                    exit(true);
            else
                exit(false);
        end;
        exit(false);
    end;

    local procedure UpdateTotalCost()
    begin
        "Total Cost" := ROUND("Unit Cost" * Quantity, 1);
        "Total Cost (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Posting Date", "Currency Code",
              "Total Cost", "Currency Factor"),
            1);
    end;

    local procedure FindPriceAndDiscount(var JobJnlLine: Record "Job Journal Line2"; CalledByFieldNo: Integer)
    begin
        if RetrieveCostPrice and ("No." <> '') then begin
            //DYS A VERIFIER
            // SalesPriceCalcMgt.FindJobJnlLinePrice(JobJnlLine, CalledByFieldNo);

            // if Type <> Type::"G/L Account" then
            //    PurchPriceCalcMgt.FindJobJnlLinePrice(JobJnlLine, CalledByFieldNo)
            // else
            begin
                // Because the SalesPriceCalcMgt.FindJobJnlLinePrice function also retrieves costs for G/L Account,
                // cost and total cost need to get updated again.
                UpdateUnitCost;
                UpdateTotalCost;
            end;
        end;
    end;

    local procedure HandleCostFactor()
    begin
        if ("Unit Cost" <> xRec."Unit Cost") or ("Cost Factor" <> xRec."Cost Factor") then begin
            if "Cost Factor" <> 0 then
                "Unit Price" := ROUND("Unit Cost" * "Cost Factor", UnitAmountRoundingPrecision)
            else
                if xRec."Cost Factor" <> 0 then
                    "Unit Price" := 0;
        end;
    end;

    local procedure UpdateUnitPrice()
    begin
        "Unit Price (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Posting Date", "Currency Code",
              "Unit Price", "Currency Factor"),
            UnitAmountRoundingPrecision);
    end;

    local procedure UpdateTotalPrice()
    begin
        "Total Price" := ROUND(Quantity * "Unit Price", 1);
        "Total Price (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Posting Date", "Currency Code",
              "Total Price", "Currency Factor"),
            1);
    end;

    local procedure UpdateAmountsAndDiscounts()
    begin
        if "Total Price" <> 0 then begin
            if ("Line Amount" <> xRec."Line Amount") and ("Line Discount Amount" = xRec."Line Discount Amount") then begin
                "Line Amount" := ROUND("Line Amount", AmountRoundingPrecision);
                "Line Discount Amount" := "Total Price" - "Line Amount";
                "Line Discount %" :=
                  ROUND("Line Discount Amount" / "Total Price" * 100);
            end else
                if ("Line Discount Amount" <> xRec."Line Discount Amount") and ("Line Amount" = xRec."Line Amount") then begin
                    "Line Discount Amount" := ROUND("Line Discount Amount", AmountRoundingPrecision);
                    "Line Amount" := "Total Price" - "Line Discount Amount";
                    "Line Discount %" :=
                      ROUND("Line Discount Amount" / "Total Price" * 100);
                end else begin
                    "Line Discount Amount" :=
                      ROUND("Total Price" * "Line Discount %" / 100, AmountRoundingPrecision);
                    "Line Amount" := "Total Price" - "Line Discount Amount";
                end;
        end else begin
            "Line Amount" := 0;
            "Line Discount Amount" := 0;
        end;

        "Line Amount (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Posting Date", "Currency Code",
              "Line Amount", "Currency Factor"),
            AmountRoundingPrecision);

        "Line Discount Amount (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Posting Date", "Currency Code",
              "Line Discount Amount", "Currency Factor"),
            AmountRoundingPrecision);
    end;


    procedure wMajDescription()
    // var
    //     lDescription: Text[1000];
    begin
        //     //#6670 : Remplace description par ldescription ds appel fonction

        //     //POINTAGE
        //     wNavibatSetup.GET2;
        //     if ("Description setup" <> Description) or (Description = '') then begin
        //         case Type of
        //             Type::Resource:
        //                 "Description setup" := wNavibatSetup."Job Journal Line Res. Descr.";
        //             Type::Item:
        //                 "Description setup" := wNavibatSetup."Job Journal Line Item Descr.";
        //             Type::"G/L Account":
        //                 "Description setup" := wNavibatSetup."Job Journal Line G/L Descr.";
        //             else
        //                 ;
        //         end;

        //         //#6670
        //         //  Description := "Description setup";
        //         lDescription := "Description setup";
        //         //#6670//
        //         if Type = Type::"G/L Account" then
        //             if StrPos(lDescription, '%' + Format(Database::"G/L Account") + '.') > 0 then begin
        //                 if GLAcc.Get("No.") then;
        //                 wRecordRef.GetTable(GLAcc);
        //                 wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::"G/L Account") + '.', GlobalLanguage);
        //             end;
        //         if Type = Type::Item then
        //             if StrPos(lDescription, '%' + Format(Database::Item) + '.') > 0 then begin
        //                 if Item.Get("No.") then;
        //                 wRecordRef.GetTable(Item);
        //                 wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::Item) + '.', GlobalLanguage);
        //             end;
        //         if StrPos(lDescription, '%' + Format(Database::Vendor) + '.') > 0 then begin
        //             if wVendor.Get("Vendor No.") then;
        //             wRecordRef.GetTable(wVendor);
        //             wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::Vendor) + '.', GlobalLanguage);
        //         end;
        //         if StrPos(lDescription, '%' + Format(Database::Job2) + '.') > 0 then begin
        //             if Job.Get("Job No.") then;
        //             wRecordRef.GetTable(Job);
        //             wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::Job) + '.', GlobalLanguage);
        //         end;
        //         if Type = Type::Resource then
        //             if StrPos(lDescription, '%' + Format(Database::Resource) + '.') > 0 then begin
        //                 if Res.Get("No.") then;
        //                 wRecordRef.GetTable(Res);
        //                 wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::Resource) + '.', GlobalLanguage);
        //             end;
        //         if StrPos(lDescription, '%' + Format(Database::"Work Type") + '.') > 0 then begin
        //             if WorkType.Get("Work Type Code") then;
        //             wRecordRef.GetTable(WorkType);
        //             wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::"Work Type") + '.', GlobalLanguage);
        //         end;
        //         if StrPos(lDescription, '%' + Format(Database::"Resource Group") + '.') > 0 then begin
        //             if wResGroup.Get("Resource Group No.") then;
        //             wRecordRef.GetTable(wResGroup);
        //             wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::"Resource Group") + '.', GlobalLanguage);
        //         end;
        //         if StrPos(lDescription, '%' + Format(Database::"Job Journal Line2") + '.') > 0 then
        //             wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::"Job Journal Line2") + '.', GlobalLanguage);
        //     end;
        //     //POINTAGE//

        //     //#6670
        //     Description := CopyStr(lDescription, 1, 50);
        //     //#6670//

        //     //#5957
        //     DeleteTruncVariable(Description);
        //     //#5957//
    end;


    procedure wReachVendor()
    var
        lMission: Record Mission;
    begin
        //INTERIM
        if Res.Get("No.") then begin
            if (Res.Status = Res.Status::External) and (Res.Type = Res.Type::Person) and ("Posting Date" <> 0D) then begin
                wInterim.Reset;
                wInterim.SetRange("Resource No.", "No.");
                wInterim.SetRange("Starting Date", 0D, "Posting Date");
                wInterim.SetFilter("Ending Date", '>=%1', "Posting Date");
                if wInterim.Count > 1 then begin
                    Error(Text1100280008, "No.", "Posting Date")
                end else begin
                    if not wInterim.Find('-') then
                        Error(Text1100280007, "No.", "Posting Date")
                    else begin
                        "Vendor No." := wInterim."Vendor No.";
                        "Mission No." := wInterim."Mission No.";
                        "Mission Code" := wInterim."Mission Code";
                        if lMission.Get(wInterim."Mission Code") and (lMission."Bal. Job No." <> '') then
                            "Bal. Job No." := lMission."Bal. Job No.";
                    end;
                end;
            end;
        end;
        //INTERIM//
    end;


    procedure wGetCaptionClass(pInt: Integer): Text[80]
    begin
        exit(CopyStr('8004000,' + Format(pInt) + ',' + "Journal Template Name" + ',' + "Journal Batch Name", 1, 80));
    end;


    procedure wLookUpNo(var rec: Record "Job Journal Line2"; var pMultiple: Boolean): Boolean
    var
        lGLAccount: Record "G/L Account";
        lItem: Record Item;
        lRes: Record Resource;
        lInterim: Record "Interim Mission";
        lOK: Boolean;
        lFormRes: Page "Resource List";
        lFormItem: Page "Item List";
        lFormGL: Page "G/L Account List";
        //   lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
        lNbre: Integer;
    begin
        //MULTIPLE
        lOK := false;
        case Type of
            Type::"G/L Account":
                begin
                    Commit;
                    if "No." <> '' then begin
                        lGLAccount.Get("No.");
                        lFormGL.SetRecord(lGLAccount);
                    end;
                    lFormGL.SetTableview(lGLAccount);
                    lFormGL.LookupMode(true);
                    if lFormGL.RunModal = Action::LookupOK then begin
                        lFormGL.GetRecord(lGLAccount);
                        lOK := true;
                        Validate("No.", lGLAccount."No.");
                    end;
                end;
            Type::Item:
                begin
                    Commit;
                    if "No." <> '' then begin
                        lItem.Get("No.");
                        lFormItem.SetRecord(lItem);
                    end;
                    lFormItem.SetTableview(lItem);
                    lFormItem.LookupMode(true);
                    if lFormItem.RunModal = Action::LookupOK then begin
                        //   lFormItem.wSetSelectionFilter(lItem);
                        lNbre := lItem.Count;
                        if lNbre = 1 then begin
                            lFormItem.GetRecord(lItem);
                            Validate("No.", lItem."No.");
                        end else begin
                            if lNbre > 100 then
                                if not Confirm(TextToMuch, false, lNbre, lItem.TableCaption) then
                                    exit(false);
                            lFenetre.Open(TextMultiple);
                            //GL2024     lGetRecord.SetJobJnlLine(rec);
                            //   lGetRecord.CreateJobJnlLineFromItem(lItem);
                            pMultiple := true;
                            lFenetre.Close;
                        end;
                        lOK := true;
                    end;
                end;
            Type::Resource:
                begin
                    if ("Vendor No." <> '') or ("Mission No." <> '') then begin
                        if ("Vendor No." <> '') then
                            lInterim.SetRange("Vendor No.", "Vendor No.");
                        if ("Mission No." <> '') then
                            lInterim.SetRange("Mission No.", "Mission No.");
                        lInterim.SetRange("Starting Date", 0D, "Posting Date");
                        lInterim.SetFilter("Ending Date", '>=%1', "Posting Date");
                        wLookupInterim(rec, pMultiple, lOK, lInterim);
                    end else begin
                        if ("Resource Group No." <> '') then
                            lRes.SetRange("Res. Group Filter", "Resource Group No.");
                        lRes.SetFilter(Status, '%1..%2', lRes.Status::Internal, lRes.Status::External);
                        lRes.SetFilter(Type, '%1..%2', lRes.Type::Person, lRes.Type::Machine);
                        if not JobJnlTemplate.Get("Journal Template Name") then
                            JobJnlTemplate.Init;
                        //#6138
                        //        IF JobJnlTemplate.Type = JobJnlTemplate.Type::"1" THEN
                        //#6138//
                        lRes.SetRange("WT Allowed", true);
                        wLookupResource(rec, pMultiple, lOK, lRes);
                    end
                end;
        end;
        exit(lOK);
        //MULTIPLE//
    end;


    procedure wLookupResource(var rec: Record "Job Journal Line2"; var pMultiple: Boolean; var pOK: Boolean; var pRes: Record Resource)
    var
        //DYS PAGE ADDON NON MIGRER
        //  lFormRes: Page 8004036;
        //   lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
        lNbre: Integer;
    begin
        //MULTIPLE
        if not pRes.Find('-') then
            if "No." <> '' then begin
                pRes.Get("No.");
                //lFormRes.SetRecord(pRes);
            end;
        //DYS PAGE ADDON NON MIGRER
        // lFormRes.SetTableview(pRes);
        // lFormRes.LookupMode(true);
        // //#5457
        // lFormRes.wSetSelectionNo("No.");
        // //#5457//
        // if lFormRes.RunModal = Action::LookupOK then begin
        //     lFormRes.wSetSelectionFilter(pRes);
        //     lNbre := pRes.Count;
        //     if lNbre = 1 then begin
        //         lFormRes.GetRecord(pRes);
        //         Validate("No.", pRes."No.");
        //     end
        //     else begin
        //         if lNbre > 100 then
        //             if not Confirm(TextToMuch, false, lNbre, pRes.TableCaption) then
        //                 exit;
        //         lFenetre.Open(TextMultiple);
        //         lGetRecord.SetJobJnlLine(rec);
        //         lGetRecord.CreateJobJnlLineFromRes(pRes);
        //         pMultiple := true;
        //         lFenetre.Close;
        //     end;
        pOK := true;
        //  end;
        //MULTIPLE//
    end;


    procedure wLookupInterim(var rec: Record "Job Journal Line2"; var pMultiple: Boolean; var pOK: Boolean; var pInterim: Record "Interim Mission")
    var
        //DYS PAGE ADDON NON MIGRER
        //lFormInterim: Page 8004020;
        //    lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
        lRes: Record Resource;
        lNbre: Integer;
    begin
        //MULTIPLE
        if not pInterim.Find('-') then
            if "No." <> '' then begin
                pInterim.Get("No.", "Mission No.");
                // lFormInterim.SetRecord(pInterim);
            end;
        //#5457
        pInterim.Get("No.", "Mission No.");
        //#5457//
        //DYS PAGE ADDON NON MIGRER
        // lFormInterim.SetTableview(pInterim);
        // lFormInterim.LookupMode(true);
        // if lFormInterim.RunModal = Action::LookupOK then begin
        //     lFormInterim.wSetSelectionFilter(pInterim);
        //     lNbre := pInterim.Count;
        //     if lNbre = 1 then begin
        //         lFormInterim.GetRecord(pInterim);
        //         Validate("No.", pInterim."Resource No.");
        //     end
        //     else begin
        //         if lNbre > 100 then
        //             if not Confirm(TextToMuch, false, lNbre, lRes.Type) then
        //                 exit;
        //         lFenetre.Open(TextMultiple);
        //         lGetRecord.SetJobJnlLine(rec);
        //         lGetRecord.CreateJobJnlLineFromInterim(pInterim);
        //         pMultiple := true;
        //         lFenetre.Close;
        //     end;
        //     pOK := true;
        // end;
        //MULTIPLE//
    end;


    procedure wDistribution(pAnalyticalDistribution: Boolean)
    begin
        wAnalyticalDistribution := pAnalyticalDistribution;
    end;


    procedure wCheckAnalyticalDistribution(): Boolean
    var
        lDistributionBuffer: Record "Distributed Entries Buffer";
    begin
        lDistributionBuffer.SetCurrentkey(Type);
        lDistributionBuffer.SetRange(Type, lDistributionBuffer.Type::"Job Journal");
        lDistributionBuffer.SetRange("Entry no.", "Line No.");
        lDistributionBuffer.SetRange("Journal Template Name", "Journal Template Name");
        lDistributionBuffer.SetRange("Journal Batch Name", "Journal Batch Name");
        exit(lDistributionBuffer.Find('-'));
    end;


    procedure fTravel(pResource: Record Resource; pJob: Record Job2)
    var
        lTravelRelation: Record "Travel Relation";
    begin
        //+ONE+TRAVEL
        if (pResource."Travel Code" <> '') and (pJob."Travel Code" <> '') then begin
            lTravelRelation.Get(Res."Travel Code", Job."Travel Code");
            "Intervention Zone Qty" := lTravelRelation."Travel Quantity";
            "Intervention Zone Code" := lTravelRelation."Travel Work Type Code";
            "Driver Code" := lTravelRelation."Driver Work Type Code";
            "Driver Quantity" := lTravelRelation."Driver Quantity";
        end;
        //+ONE+TRAVEL//
    end;


    procedure DeleteTruncVariable(var pDescription: Text[50])
    var
        i: Integer;
        lModif: Boolean;
    begin
        //#5957
        if StrPos(pDescription, '%') = 0 then
            exit;

        lModif := false;
        i := MaxStrLen(pDescription);
        repeat
            if CopyStr(pDescription, i, 1) = '%' then begin
                pDescription := CopyStr(pDescription, 1, i - 3);
                lModif := true;
            end;
            i -= 1;
        until (i = 1) or lModif;
        //#5957//
    end;
}

