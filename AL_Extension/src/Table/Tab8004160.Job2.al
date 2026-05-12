Table 8004160 Job2
{
    // //#6589 Ajout
    // //#5800 OnDelete,
    // //#4628 OnInsert +DimMgt.fSetShortcutDimCode
    // //+ONE+TRAVEL MB 17/10/07 + "Travel Post Code" en code 20 et relié à "Post Code"
    // //+ONE+JOB MB 22/09/07 +gGetDefaultJobTask()
    //                        Autorisation changement client facturé
    // //STATSEXPLORER STATSEXPLORER 22/05/02 10 new fields (8001301 to 8001310)
    // //+REF+TEMPLATE CW 21/11/07 OnInsert
    // //DEVIS_STATS GESWAY 05/04/05          Ajout de la fonction lGetCaptionsStatsExplorer
    // //PROJET GESWAY 27/05/02 Ajout des champs 8003947 à 8003989
    //                 14/06/04 Ajout champ Objet
    //                 02/11/04 Ajout champ "Contact chantier"
    //                          Ajout champ "Salesperson Code", "Initial Gross Total Cost"
    //                          Ajout champs adresse 8003910 à 8003915
    //                          Ajout champ "Global Dimension 1 Filter", "Global Dimension 2 Filter", "Analysis Filter",
    //                          "Gen. Prod Posting Group Filter"
    //                          OnValidate Status maj "Progress Degree"
    //                          Ajouts des fonctions wSynchroSales, wSynchro, wGetCaptionNaviBat, wNaviBatCaption
    //                 23/06/05 Ajout fonction wCheckBlockedJob
    //                 08/08/05 Ajout Flowfield 8003924 "Posted in Period"
    // //PROJET_NATURE CW 18/05/02 Ajout des champs "Purch. Engaged", "Initial Price Forecast"
    //                 GESWAY 04/07/05 Tenir compte dans le champ calculé "Invoiced Price" et "Budgeted Price"
    //                                 de "Gen. Prod Posting Group Filter"
    //                                 Ajout des champs "Estimated invoicing", "Document Type Filter"
    // //POINTAGE GESWAY 28/05/02 Ajout du champ "Intervention Zone Code" et sa mise à jour OnValidate "Bill-to Customer No."
    //                                           "Security Group Code","Working Time Res. Qty.","Work Type Filter",
    //                                           "Journal Template Name Filter","Journal Batch Name Filter"
    //            GESWAY 20/08/02 Ajout du champ "Intervention Zone Quantity"
    //            GESWAY 22/08/02 Ajout Type de projet, "Driver Area Code"
    //            GESWAY 10/03/03 Ajout champs "Resource Status Filter"
    // //PROJET_ACTION GESWAY 06/06/02 OnDelete : Suppression des actions
    // //PROJET_CESSION GESWAY 05/04/05 Modification du CalcFormula du champ "Usage (Cost)"
    //                                  + Bal. Created Entry=const(false)
    // //PROJET_DETAIL GESWAY 13/08/02 Ajout du champ "Default Phase"
    // //PROJET_BUDGET DL 24/06/02 Supprime les écritures budget avancé
    // //ETATS GESWAY 22/08/02 Ajout des clés Status,Global Dimension 1 Code,Global Dimension 2 Code,No.
    //                        Status,Person Responsible,No.
    //                        Global Dimension 1 Code,Global Dimension 2 Code,No.,Status
    //                        Person Responsible,No.,Status
    //                        Status,No.
    //                        champ "Person Responsible" :
    //                          Modification du TableRelation : Resource WHERE (Type=CONST(Person),Status=CONST(Internal))
    //                          CaptionClass : wGetCaptionNaviBat
    // //PLANNING CW 23/09/09 +"800413x" fields
    // //PROJET_REVISION GESWAY 30/10/02 Ajout des champs 8003992 à 8004003
    // //LETTRAGE_PROJET ETP 09/03/01 Ajout d'un flowfield "Apply entries"
    // //STOCK CLA 27/08/04 Ajout de l'option 'Stock' dans le champ 'Type chantier'
    // //PROJET_FACT CLA 27/01/05 Ajout 'Soldé'
    // //CAUTION AC 02/05/05 Ajout FlowField "Guarantees Amount LCY"
    // //CARACT GESWAY 05/04/05 appel wSynchroSales OnValidate "Person Responsible", "Ending Date", "Starting Date"
    // //RECEPTION CLA 14/06/05 Modif propiété Editable = Oui de "Recognition Date" + Modif OnValidate
    // //MASK IMA 02/01/06 +"Mask code"
    // //JOB_TOTALING CW 24/10/05 +"Level" (init / OnValidate(No.), +Summarize + wSetTotaling()
    //                MB 06/02/07 Ajout de Job."Totaling" mis à jour sur OnValidate de Summarize
    // //JOB_STATUS CW 24/10/05 Check JobStatus, Job Status change, Status.Editable(no)
    // //JOB_AUDIT CW 22/11/05 +"Last Audit Date"
    // //JOB_POSTING CW 13/12/05 OnModify : Avoid some updates if entries exists
    // //POINTAGE MB 10/04/06 Ajout du champ "Working Time Mode"
    // //IC ML 12/06/06 Ajout du champ "IC Partner Code"

    Caption = 'Job';
    DataCaptionFields = "No.", Description;
    //DrillDownPageID = 8004161;
    //LookupPageID = 8004161;
    Permissions = TableData "Cust. Ledger Entry" = rm,
                  TableData "Job Ledger Entry2" = rm;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    JobSetup.Get;
                    NoSeriesMgt.TestManual(JobSetup."Job Nos.");
                    "No. Series" := '';
                    //JOB_TOTALING
                    lSetJobTotalingField(Rec);
                    lSetJobTotalingLevel(Rec);
                    //JOB_TOTALING//
                end;
            end;
        }
        field(2; "Search Description"; Code[50])
        {
            Caption = 'Search Description';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := Description;
            end;
        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Job Name';
            Description = 'Modification Caption';
        }
        field(5; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                lCust: Record Customer;
            begin
                //POINTAGE
                //+ONE+TRAVEL
                /*DELETE
                IF xRec."Bill-to Customer No." <> "Bill-to Customer No." THEN BEGIN
                  IF lCust.GET("Bill-to Customer No.") THEN
                    "Travel Post Code" := lCust."Service Zone Code";
                END ;
                DELETE*/
                //+ONE+TRAVEL//
                //POINTAGE//
                //+ONE+JOB (#5370)
                /*DELETE Code d'origine supprimé
                IF ("Bill-to Customer No." = '') OR ("Bill-to Customer No." <> xRec."Bill-to Customer No.") THEN
                  IF JobLedgEntryExist OR JobPlanningLineExist THEN
                    ERROR(Text000,FIELDCAPTION("Bill-to Customer No."),TABLECAPTION);
                DELETE*/
                //+ONE+JOB//
                UpdateCust;

            end;
        }
        field(12; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(13; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                CheckDate;
            end;
        }
        field(14; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                CheckDate;
            end;
        }
        field(19; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            InitValue = "Order";
            OptionCaption = 'Planning,Quote,Order,Completed';
            OptionMembers = Planning,Quote,"Order",Completed;

            trigger OnValidate()
            var
                JobPlanningLine: Record "Job Planning Line2";
            begin
                if xRec.Status <> Status then begin
                    if Status = Status::Completed then
                        Validate(Complete, true);
                    if xRec.Status = xRec.Status::Completed then begin
                        if Dialog.Confirm(Text004) then
                            Validate(Complete, false)
                        else begin
                            Status := xRec.Status;
                            //PROJET
                            "Job Status" := xRec."Job Status";
                            Error(tUndo);
                            //PROJET//
                        end;
                    end;
                    JobPlanningLine.SetCurrentkey("Job No.");
                    JobPlanningLine.SetRange("Job No.", "No.");
                    JobPlanningLine.ModifyAll(Status, Status);
                    Modify;
                end;
            end;
        }
        field(20; "Person Responsible"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(20);
            Caption = 'Person Responsible';
            Description = 'Modif CaptionClass + TableRelation';
            TableRelation = Resource where(Type = const(Person));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#8356
                lResource.SetRange(Type, lResource.Type::Person);
                //#8356//
                //#7476
                lResource.SetRange(Status, lResource.Status::Internal);
                if PAGE.RunModal(0, lResource) = Action::LookupOK then
                    "Person Responsible" := lResource."No.";
                //"7476//
            end;
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
                Modify;
            end;
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
                Modify;
            end;
        }
        field(23; "Job Posting Group"; Code[10])
        {
            Caption = 'Job Posting Group';
            TableRelation = "Job Posting Group2";

            trigger OnValidate()
            begin
                //JOB_POSTING
                if "Job Posting Group" <> xRec."Job Posting Group" then
                    if wEntryExists then
                        FieldError("Job Posting Group", tNotEmpty);
                //JOB_POSTING//
            end;
        }
        field(24; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Posting,All';
            OptionMembers = " ",Posting,All;
        }
        field(29; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(Job),
                                                      "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(32; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(49; "Scheduled Res. Qty."; Decimal)
        {
            CalcFormula = sum("Job Planning Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                           "Schedule Line" = const(true),
                                                                           Type = const(Resource),
                                                                           "No." = field("Resource Filter"),
                                                                           "Planning Date" = field("Planning Date Filter")));
            Caption = 'Scheduled Res. Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(51; "Posting Date Filter"; Date)
        {
            Caption = 'Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(55; "Resource Gr. Filter"; Code[20])
        {
            Caption = 'Resource Gr. Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
        field(56; "Scheduled Res. Gr. Qty."; Decimal)
        {
            CalcFormula = sum("Job Planning Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                           "Schedule Line" = const(true),
                                                                           Type = const(Resource),
                                                                           "Resource Group No." = field("Resource Gr. Filter"),
                                                                           "Planning Date" = field("Planning Date Filter")));
            Caption = 'Scheduled Res. Gr. Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(58; "Bill-to Name"; Text[50])
        {
            Caption = 'Bill-to Name';
        }
        field(59; "Bill-to Address"; Text[50])
        {
            Caption = 'Bill-to Address';
        }
        field(60; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
        }
        field(61; "Bill-to City"; Text[50])
        {
            Caption = 'Bill-to City';

            trigger OnLookup()
            begin
                //GL2024 "Le procedure n'existe pas dans BC24." PostCode.LookUpCity("Bill-to City", "Bill-to Post Code", true);
            end;

            trigger OnValidate()
            begin
                //GL2024 PostCode.ValidateCity("Bill-to City", "Bill-to Post Code");
                PostCode.ValidateCity("Bill-to City", "Bill-to Post Code", County, "Bill-to Country/Region Code", true);
            end;
        }
        field(63; County; Text[30])
        {
            CalcFormula = lookup(Customer.County where("No." = field("Bill-to Customer No.")));
            Caption = 'County';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //GL2024   PostCode.LookUpPostCode("Bill-to City", true);
                PostCode.LookUpPostCode("Bill-to City", "Bill-to Post Code", County, "Bill-to Country/Region Code");
            end;

            trigger OnValidate()
            begin
                //GL2024   PostCode.ValidatePostCode("Bill-to City", "Bill-to Post Code");
                wPostCode.ValidatePostCode("Bill-to City", "Bill-to Post Code", County, "Bill-to Country/Region Code", true);
            end;
        }
        field(66; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(67; "Bill-to Country/Region Code"; Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            Editable = true;
            TableRelation = "Country/Region";
        }
        field(68; "Bill-to Name 2"; Text[50])
        {
            CalcFormula = lookup(Customer."Name 2" where("No." = field("Bill-to Customer No.")));
            Caption = 'Bill-to Name 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1000; "WIP Method"; Option)
        {
            Caption = 'WIP Method';
            OptionCaption = 'Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = "Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(1001; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "Currency Code" <> xRec."Currency Code" then
                    if not JobLedgEntryExist then
                        CurrencyUpdatePlanningLines
                    else
                        Error(Text000, FieldCaption("Currency Code"), TableCaption);
            end;
        }
        field(1002; "Bill-to Contact No."; Code[20])
        {
            Caption = 'Bill-to Contact No.';

            trigger OnLookup()
            begin
                if ("Bill-to Customer No." <> '') and Cont.Get("Bill-to Contact No.") then
                    Cont.SetRange("Company No.", Cont."Company No.")
                else
                    if Cust.Get("Bill-to Customer No.") then begin
                        ContBusinessRelation.Reset;
                        ContBusinessRelation.SetCurrentkey("Link to Table", "No.");
                        ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."link to table"::Customer);
                        ContBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                        if ContBusinessRelation.Find('-') then
                            Cont.SetRange("Company No.", ContBusinessRelation."Contact No.");
                    end else
                        Cont.SetFilter("Company No.", '<>''''');

                if "Bill-to Contact No." <> '' then
                    if Cont.Get("Bill-to Contact No.") then;
                if PAGE.RunModal(0, Cont) = Action::LookupOK then begin
                    xRec := Rec;
                    Validate("Bill-to Contact No.", Cont."No.");
                end;
            end;

            trigger OnValidate()
            begin
                if Blocked >= Blocked::Posting then
                    Error(Text000, FieldCaption("Bill-to Contact No."), TableCaption);

                //#6295
                /*
                IF ("Bill-to Contact No." <> xRec."Bill-to Contact No.") AND
                   (xRec."Bill-to Contact No." <> '')
                THEN BEGIN
                  IF ("Bill-to Contact No." = '') AND ("Bill-to Customer No." = '') THEN BEGIN
                    INIT;
                    "No. Series" := xRec."No. Series";
                    VALIDATE(Description,xRec.Description);
                  END;
                END;
                */
                //#6295//

                if ("Bill-to Customer No." <> '') and ("Bill-to Contact No." <> '') then begin
                    Cont.Get("Bill-to Contact No.");
                    ContBusinessRelation.Reset;
                    ContBusinessRelation.SetCurrentkey("Link to Table", "No.");
                    ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."link to table"::Customer);
                    ContBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                    if ContBusinessRelation.Find('-') then
                        if ContBusinessRelation."Contact No." <> Cont."Company No." then
                            Error(Text005, Cont."No.", Cont.Name, "Bill-to Customer No.");
                end;
                UpdateBillToCust("Bill-to Contact No.");

            end;
        }
        field(1003; "Bill-to Contact"; Text[50])
        {
            Caption = 'Bill-to Contact';
        }
        field(1004; "Planning Date Filter"; Date)
        {
            Caption = 'Planning Date Filter';
            FieldClass = FlowFilter;
        }
        field(1005; "Total WIP Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Job WIP Entry2"."WIP Entry Amount" where("Job No." = field("No."),
                                                                        "Job Complete" = const(false),
                                                                        Type = filter("Accrued Costs" | "WIP Costs" | "Recognized Costs")));
            Caption = 'Total WIP Cost Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1006; "Total WIP Cost G/L Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Job WIP G/L Entry2"."WIP Entry Amount" where("Job No." = field("No."),
                                                                            Reversed = const(false),
                                                                            "Job Complete" = const(false),
                                                                            Type = filter("Accrued Costs" | "WIP Costs" | "Recognized Costs")));
            Caption = 'Total WIP Cost G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1007; "WIP Posted To G/L"; Boolean)
        {
            Caption = 'WIP Posted To G/L';
            Editable = false;
        }
        field(1008; "WIP Posting Date"; Date)
        {
            Caption = 'WIP Posting Date';
            Editable = false;
        }
        field(1009; "WIP G/L Posting Date"; Date)
        {
            CalcFormula = min("Job WIP G/L Entry2"."WIP Posting Date" where(Reversed = const(false),
                                                                            "Job No." = field("No.")));
            Caption = 'WIP G/L Posting Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1010; "Posted WIP Method Used"; Option)
        {
            Caption = 'Posted WIP Method Used';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(1011; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';
            TableRelation = Currency;
        }
        field(1012; "Exch. Calculation (Cost)"; Option)
        {
            Caption = 'Exch. Calculation (Cost)';
            OptionCaption = 'Fixed LCY,Fixed FCY';
            OptionMembers = "Fixed LCY","Fixed FCY";
        }
        field(1013; "Exch. Calculation (Price)"; Option)
        {
            Caption = 'Exch. Calculation (Price)';
            OptionCaption = 'Fixed FCY,Fixed LCY';
            OptionMembers = "Fixed FCY","Fixed LCY";
        }
        field(1014; "Allow Schedule/Contract Lines"; Boolean)
        {
            Caption = 'Allow Schedule/Contract Lines';
        }
        field(1015; Complete; Boolean)
        {
            Caption = 'Complete';

            trigger OnValidate()
            var

            begin
                if Complete <> xRec.Complete then
                    ChangeJobCompletionStatus;
            end;
        }
        field(1016; "Calc. WIP Method Used"; Option)
        {
            Caption = 'Calc. WIP Method Used';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(1017; "Recog. Sales Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Job WIP Entry2"."WIP Entry Amount" where("Job No." = field("No."),
                                                                        Type = filter("Recognized Sales")));
            Caption = 'Recog. Sales Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1018; "Recog. Sales G/L Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Job WIP G/L Entry2"."WIP Entry Amount" where("Job No." = field("No."),
                                                                            Type = filter("Recognized Sales"),
                                                                            Reversed = const(false)));
            Caption = 'Recog. Sales G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1019; "Recog. Costs Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Job WIP Entry2"."WIP Entry Amount" where("Job No." = field("No."),
                                                                         Type = filter("Recognized Costs")));
            Caption = 'Recog. Costs Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1020; "Recog. Costs G/L Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Job WIP G/L Entry2"."WIP Entry Amount" where("Job No." = field("No."),
                                                                             Type = filter("Recognized Costs"),
                                                                             Reversed = const(false)));
            Caption = 'Recog. Costs G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1021; "Total WIP Sales Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Job WIP Entry2"."WIP Entry Amount" where("Job No." = field("No."),
                                                                        "Job Complete" = const(false),
                                                                        Type = filter("Accrued Sales" | "WIP Sales" | "Recognized Sales")));
            Caption = 'Total WIP Sales Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1022; "Total WIP Sales G/L Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Job WIP G/L Entry2"."WIP Entry Amount" where("Job No." = field("No."),
                                                                            Reversed = const(false),
                                                                            "Job Complete" = const(false),
                                                                            Type = filter("Accrued Sales" | "WIP Sales" | "Recognized Sales")));
            Caption = 'Total WIP Sales G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1023; "Completion Calculated"; Boolean)
        {
            CalcFormula = exist("Job WIP Entry2" where("Job No." = field("No."),
                                                       "Job Complete" = filter(= true)));
            Caption = 'Completion Calculated';
            FieldClass = FlowField;
        }
        field(1024; "Next Invoice Date"; Date)
        {
            CalcFormula = min("Job Planning Line2"."Planning Date" where("Job No." = field("No."),
                                                                         "Contract Line" = filter(= true),
                                                                         Invoiced = filter(= false)));
            Caption = 'Next Invoice Date';
            FieldClass = FlowField;
        }
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
        }
        field(50002; "Apply entries"; Integer)
        {
            CalcFormula = count("Job Ledger Entry2" where("Job No." = field("No."),
                                                          Balanced = const(false)));
            Caption = 'Open Entries Count';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Affaire Par Defaut"; Boolean)
        {
            Description = 'HJ DSFT 31-JANV-2012';
        }
        field(50005; "Affectation Magasin"; Code[20])
        {
            Description = 'RB SORO 19/06/2015';
            TableRelation = Location;
        }
        /*  field(50006; "Remplir Toutes Affectation"; Boolean)
          {
              Description = 'HJ SORO 22-10-2016';
          }
          field(50007; "Remblais Valoriser"; Boolean)
          {
              Description = 'HJ SORO 06-06-2017';
          }
          field(50008; "Deblais Valoriser"; Boolean)
          {
              Description = 'HJ SORO 06-06-2017';
          }
          field(50009; "Société"; Code[20])
          {
              TableRelation = "Entete rapport DG";
          }
          field(50010; "Correspandant Client"; Code[20])
          {
              Description = 'MH SORO 27-02-2018';
              TableRelation = Customer;
          }
          field(50011; "Activer Procedure DA"; Boolean)
          {
              Description = 'HJ SORO 06-03-2018';
          }*/

        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;

            trigger OnValidate()
            var
            // lMaskMgt: Codeunit "Mask Management";
            begin
                //MASK
                //GL2024     lMaskMgt.JobMaskValidate(xRec, Rec);
                //MASK//
            end;
        }
        field(8001301; "Criteria 1"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99090';
            Caption = 'Criteria 1';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001301));
        }
        field(8001302; "Criteria 2"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99091';
            Caption = 'Criteria 2';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001302));
        }
        field(8001303; "Criteria 3"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99092';
            Caption = 'Criteria 3';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001303));
        }
        field(8001304; "Criteria 4"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99093';
            Caption = 'Criteria 4';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001304));
        }
        field(8001305; "Criteria 5"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99094';
            Caption = 'Criteria 5';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001305));
        }
        field(8001306; "Criteria 6"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99095';
            Caption = 'Criteria 6';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001306));
        }
        field(8001307; "Criteria 7"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99096';
            Caption = 'Criteria 7';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001307));
        }
        field(8001308; "Criteria 8"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99097';
            Caption = 'Criteria 8';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001308));
        }
        field(8001309; "Criteria 9"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99098';
            Caption = 'Criteria 9';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001309));
        }
        field(8001310; "Criteria 10"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99099';
            Caption = 'Criteria 10';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001310));
        }
        field(8001400; "Gen. Prod Posting Group Filter"; Code[10])
        {
            Caption = 'Gen. Prod Posting Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Gen. Product Posting Group";
        }
        field(8001403; "Purch. Engaged"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Purchase Line"."Engaged Cost (LCY)" where("Document Type" = const(Order),
                                                                          "Job No." = field("No."),
                                                                          "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                          "Serial No." = field("Work Type Filter"),
                                                                          "Order Date" = field("Posting Date Filter")));
            Caption = 'Purchase Engaged';
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(8003900; Level; Integer)
        {
            Caption = 'Level';
        }
        field(8003901; "Last Audit Date"; Date)
        {
            Caption = 'Last Audit Date';
        }
        field(8003902; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
                // lSingleinstance: Codeunit "Import SingleInstance2";
                Text010: label 'Do you want to continue?';
                Text027: label 'Your identification is set up to process from %1 %2 only.';
                lUserMgt: Codeunit "User Setup Management";
                lRespCenter: Record "Responsibility Center";
                tRespCenter: label '%1 modification can change the numbering.';
            begin
                if not lUserMgt.CheckRespCenter(0, "Responsibility Center") then
                    Error(
                      Text027,
                      lRespCenter.TableCaption, lUserMgt.GetSalesFilter());
                //AGENCE
                if (xRec."Responsibility Center" <> "Responsibility Center") then
                    if not Confirm(tRespCenter + Text010, false, FieldCaption("Responsibility Center")) then
                        Error('');
                //AGENCE//
            end;
        }
        field(8003903; "Recognition Date"; Date)
        {
            Caption = 'Recognition Date';
            Description = 'Modif Editable Oui';
            Editable = true;

            trigger OnValidate()
            var
                lCustLedgEntry: Record "Cust. Ledger Entry";
                lGuarantee: Record "Guarantee Entry";
                lRetention: Record Retention;
            begin
                //RECEPTION
                TestField(Finished, true);
                if ("Recognition Date" <> xRec."Recognition Date") and ("Recognition Date" <> 0D) then begin
                    lCustLedgEntry.SetCurrentkey("Document Type", "Document No.", "Retention Code", "Job No.", Open);
                    lCustLedgEntry.SetFilter("Retention Code", '<>%1', '');
                    lCustLedgEntry.SetRange("Job No.", "No.");
                    lCustLedgEntry.SetRange(Open, true);
                    if lCustLedgEntry.Find('-') then
                        repeat
                            lRetention.Get(lCustLedgEntry."Retention Code");
                            lCustLedgEntry."Due Date" := CalcDate(lRetention."Due Date Calculation", "Recognition Date");
                            lCustLedgEntry."On Hold" := '';
                            lCustLedgEntry.Modify;
                        until lCustLedgEntry.Next = 0;
                    lGuarantee.SetCurrentkey("Job No.");
                    lGuarantee.SetRange("Job No.", "No.");
                    lGuarantee.SetRange(Open, true);
                    lGuarantee.ModifyAll("Closed Date", CalcDate('<+1Y>', "Recognition Date"));
                end;
                //RECEPTION//
            end;
        }
        field(8003908; "Initial Gross Total Cost"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Gross Total Cost" where("Job No." = field("No."),
                                                                            "Planning Date" = field("Posting Date Filter"),
                                                                            "Entry Type" = const(Initial),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter")));
            Caption = 'Initial Gross Total Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003909; "Job Totaling"; Code[50])
        {
            Caption = 'Job Totaling';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(8003910; "Job Address"; Text[50])
        {
            Caption = 'Job Address';
        }
        field(8003911; "Job Address 2"; Text[50])
        {
            Caption = 'Job Address 2';
        }
        field(8003912; "Job City"; Text[30])
        {
            Caption = 'Job City';

            trigger OnLookup()
            begin
                //GL2024 "Le procedure n'existe pas dans BC24     wPostCode.LookUpCity("Job City", "Job Post Code", true);

            end;

            trigger OnValidate()
            begin
                //GL2024 wPostCode.ValidateCity("Job City", "Job Post Code");
                PostCode.ValidateCity("Job City", "Job Post Code", "Job County", "Job Country Code", true);
            end;
        }
        field(8003913; "Job County"; Text[30])
        {
            Caption = 'Job County';
        }
        field(8003914; "Job Post Code"; Code[20])
        {
            Caption = 'Job Post Code';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //GL2024 wPostCode.LookUpPostCode("Job City", "Job Post Code", true);
                wPostCode.LookUpPostCode("Job City", "Job Post Code", "Job County", "Job Country Code");
            end;

            trigger OnValidate()
            begin
                //GL2024  wPostCode.ValidatePostCode("Job City", "Job Post Code");
                wPostCode.ValidatePostCode("Job City", "Job Post Code", "Job County", "Job Country Code", true);
            end;
        }
        field(8003915; "Job Country Code"; Code[10])
        {
            Caption = 'Job Country Code';
            TableRelation = "Country/Region";
        }
        field(8003916; Subject; Text[50])
        {
            Caption = 'Object';
        }
        field(8003917; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(8003918; "Distribution Type (Planning)"; Option)
        {
            Caption = 'Distribution Type (Planning)';
            OptionCaption = 'Manual,Prorata temporis,Normal Curve';
            OptionMembers = Manual,"Prorata temporis","Normal Curve";
        }
        field(8003919; "Estimated invoicing"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Estimated invoicing".Amount where("Job No." = field("No."),
                                                                  "Posting Date" = field("Posting Date Filter"),
                                                                  "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                  "Doc. Type" = field("Document Type Filter")));
            Caption = 'Estimated invoicing';
            FieldClass = FlowField;
        }
        field(8003920; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
            begin
            end;
        }
        field(8003924; "Posted In Period"; Boolean)
        {
            CalcFormula = exist("Job Ledger Entry2" where("Job No." = field("No."),
                                                          "Posting Date" = field("Posting Date Filter")));
            Caption = 'Posted In Period';
            FieldClass = FlowField;
        }
        field(8003925; Finished; Boolean)
        {
            Caption = 'Finished';

            trigger OnValidate()
            begin
                //#6583
                if Finished and not xRec.Finished and (Blocked = Blocked::" ") then
                    Blocked := Blocked::All;
                //#6583//
            end;
        }
        field(8003926; "Travel Code"; Code[10])
        {
            Caption = 'Travel Code';
            TableRelation = "Travel Code";
        }
        field(8003928; "Working Time Res. Qty."; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Journal Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                          Type = const(Resource),
                                                                          "No." = field("Resource Filter"),
                                                                          "Posting Date" = field("Posting Date Filter"),
                                                                          "Journal Template Name" = field("Journal Template Name Filter"),
                                                                          "Journal Batch Name" = field("Journal Batch Name Filter"),
                                                                          "Work Type Code" = field("Work Type Filter"),
                                                                          "Work Time Type" = filter("Producted Hours" | "Unproduced Hours" | "Absence Hours")));
            Caption = 'Budgeted Res. Qty.';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(8003929; "Work Type Filter"; Code[10])
        {
            Caption = 'Work Type Filter';
            FieldClass = FlowFilter;
            TableRelation = "Work Type";
        }
        field(8003930; "Journal Template Name Filter"; Code[10])
        {
            Caption = 'Journal Template Name';
            FieldClass = FlowFilter;
            TableRelation = "Job Journal Template2";
        }
        field(8003931; "Journal Batch Name Filter"; Code[10])
        {
            Caption = 'Journal Batch Name';
            FieldClass = FlowFilter;
            TableRelation = "Job Journal Batch2".Name where("Journal Template Name" = field("Journal Template Name Filter"));
        }
        field(8003932; "Document Type Filter"; Option)
        {
            Caption = 'Document Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8003933; Summarize; Boolean)
        {
            Caption = 'Total';

            trigger OnValidate()
            begin
                //+JOB+TOTALISATION
                lSetJobTotalingField(Rec);
                //+JOB+TOTALISATION//
            end;
        }
        field(8003940; "Job Type"; Option)
        {
            Caption = 'Job Type';
            OptionCaption = 'External,Internal,Stock';
            OptionMembers = External,Internal,Stock;
        }
        field(8003947; "Person Responsible 2"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003947);
            Caption = 'Person Responsible 2';
            TableRelation = Resource where(Type = const(Person));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#8356
                lResource.SetRange(Type, lResource.Type::Person);
                //#8356//
                //#7476
                lResource.SetRange(Status, lResource.Status::Internal);
                if PAGE.RunModal(0, lResource) = Action::LookupOK then
                    "Person Responsible 2" := lResource."No.";
                //"7476//
            end;
        }
        field(8003948; "Person Responsible 3"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003948);
            Caption = 'Person Responsible 3';
            TableRelation = Resource where(Type = const(Person));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#8356
                lResource.SetRange(Type, lResource.Type::Person);
                //#8356//
                //#7476
                lResource.SetRange(Status, lResource.Status::Internal);
                if PAGE.RunModal(0, lResource) = Action::LookupOK then
                    "Person Responsible 3" := lResource."No.";
                //"7476//
            end;
        }
        field(8003949; "Person Responsible 4"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003949);
            Caption = 'Person Responsible 4';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#8356
                lResource.SetRange(Type, lResource.Type::Person);
                //#8356//
                //#7476
                lResource.SetRange(Status, lResource.Status::Internal);
                if PAGE.RunModal(0, lResource) = Action::LookupOK then
                    "Person Responsible 4" := lResource."No.";
                //"7476//
            end;
        }
        field(8003950; "Person Responsible 5"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003950);
            Caption = 'Person Responsible 5';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#8356
                lResource.SetRange(Type, lResource.Type::Person);
                //#8356//
                //#7476
                lResource.SetRange(Status, lResource.Status::Internal);
                if PAGE.RunModal(0, lResource) = Action::LookupOK then
                    "Person Responsible 5" := lResource."No.";
                //"7476//
            end;
        }
        field(8003951; "Free Text 1"; Text[30])
        {
            //CaptionClass = wGetCaptionNaviBat(8003951);
            Caption = 'Free Text 1';
        }
        field(8003952; "Free Text 2"; Text[30])
        {
            //CaptionClass = wGetCaptionNaviBat(8003952);
            Caption = 'Free Text 2';
        }
        field(8003953; "Free Text 3"; Text[30])
        {
            //CaptionClass = wGetCaptionNaviBat(8003953);
            Caption = 'Free Text 3';
        }
        field(8003954; "Free Text 4"; Text[30])
        {
            //CaptionClass = wGetCaptionNaviBat(8003954);
            Caption = 'Free Text 4';
        }
        field(8003955; "Free Text 5"; Text[30])
        {
            //CaptionClass = wGetCaptionNaviBat(8003955);
            Caption = 'Free Text 5';
        }
        field(8003966; "Free Date 1"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003966);
            Caption = 'Free Date 1';
        }
        field(8003967; "Free Date 2"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003967);
            Caption = 'Free Date 2';
        }
        field(8003968; "Free Date 3"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003968);
            Caption = 'Free Date 3';
        }
        field(8003969; "Free Date 4"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003969);
            Caption = 'Free Date 4';
        }
        field(8003970; "Free Date 5"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003970);
            Caption = 'Free Date 5';
        }
        field(8003971; "Free Date 6"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003971);
            Caption = 'Free Date 6';
        }
        field(8003972; "Free Date 7"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003972);
            Caption = 'Free Date 7';
        }
        field(8003973; "Free Date 8"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003973);
            Caption = 'Free Date 8';
        }
        field(8003974; "Free Date 9"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003974);
            Caption = 'Free Date 9';
        }
        field(8003975; "Free Date 10"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003975);
            Caption = 'Free Date 10';
        }
        field(8003976; "Free Value 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003976);
            Caption = 'Free Value 1';
        }
        field(8003977; "Free Value 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003977);
            Caption = 'Free Value 2';
        }
        field(8003978; "Free Value 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003978);
            Caption = 'Free Value 3';
        }
        field(8003979; "Free Value 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003979);
            Caption = 'Free Value 4';
        }
        field(8003980; "Free Value 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003980);
            Caption = 'Free Value 5';
        }
        field(8003981; "Free Boolean 1"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003981);
            Caption = 'Free Boolean 1';
        }
        field(8003982; "Free Boolean 2"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003982);
            Caption = 'Free Boolean 2';
        }
        field(8003983; "Free Boolean 3"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003983);
            Caption = 'Free Boolean 3';
        }
        field(8003984; "Free Boolean 4"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003984);
            Caption = 'Free Boolean 4';
        }
        field(8003985; "Free Boolean 5"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003985);
            Caption = 'Free Boolean 5';
        }
        field(8003986; "Job Status"; Code[10])
        {
            Caption = 'Status Code';
            TableRelation = "Job Status";

            trigger OnValidate()
            var
            //lJobStatusMgt: Codeunit "Job Status Management";
            begin
                /* //GL2024      if ("Job Status" <> xRec."Job Status") or (CurrFieldNo = 0) then
                         lJobStatusMgt.JobStatusChange(xRec, Rec);*/
            end;
        }
        field(8003987; "No. of prov. Acceptance"; Integer)
        {
            CalcFormula = count("Guarantee,Penalty & Acceptance" where("Job No." = field("No."),
                                                                        Type = filter("Provisional Acceptance")));
            Caption = 'No. of prov. Acceptance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003989; "Penalties Amount"; Decimal)
        {
            CalcFormula = sum("Guarantee,Penalty & Acceptance"."Amount LCY" where("Job No." = field("No."),
                                                                                   Type = filter(Penalty)));
            Caption = 'Penalties Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003992; "Forecast Cost"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                            "Entry Type" = const(Initial),
                                                                            "Planning Date" = field("Posting Date Filter")));
            Caption = 'Forecast Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003993; "Guarantees Amount LCY"; Decimal)
        {
            CalcFormula = sum("Guarantee Entry"."Amount (LCY)" where("Job No." = field("No.")));
            Caption = 'Guarantees Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003994; "Person Forecast Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                           "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                           Type = const(Resource),
                                                                           "Resource Type" = const(Person),
                                                                           "Planning Date" = field("Posting Date Filter"),
                                                                           "Entry Type" = const(Initial)));
            Caption = 'Person Forecast Quantity';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003995; "Posted Quantity (Base)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry2"."Quantity (Base)" where("Job No." = field("No."),
                                                                          "Entry Type" = const(Usage),
                                                                          Type = const(Resource),
                                                                          "Resource Group No." = field("Resource Gr. Filter"),
                                                                          "Posting Date" = field("Posting Date Filter")));
            Caption = 'Posted Quantity (Base)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003996; "Quantity Planned"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                           Type = const(Resource),
                                                                           "Planning Date" = field("Posting Date Filter"),
                                                                           "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                           "Resource Type" = const(Person)));
            Caption = 'Quantity Planned';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003997; "Amount Planned"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Planning Date" = field("Posting Date Filter"),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter")));
            Caption = 'Amount Planned';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003998; "Forecast Cost Person"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Planning Date" = field("Posting Date Filter"),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                            "Entry Type" = const(Initial),
                                                                            Type = const(Resource),
                                                                            "Resource Type" = const(Person)));
            Caption = 'Forecast Cost Person';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003999; "Posted Cost Person"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                           "Entry Type" = const(Usage),
                                                                           "Gen. Bus. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                           "Posting Date" = field("Posting Date Filter"),
                                                                           Type = const(Resource),
                                                                           "Resource Type" = const(Person),
                                                                           "Work Type Code" = field("Work Type Filter"),
                                                                           "Work Time Type" = filter("Producted Hours" | "Unproduced Hours" | "Absence Hours"),
                                                                           "Bal. Created Entry" = const(false)));
            Caption = 'Posted Cost Person';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004000; "Planned Cost Person"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                            Type = const(Resource),
                                                                            "Resource Type" = const(Person),
                                                                            "Planning Date" = field("Posting Date Filter")));
            Caption = 'Planned Cost Person';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004001; "Person Planned Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                           "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                           "Planning Date" = field("Posting Date Filter"),
                                                                           Type = const(Resource),
                                                                           "Resource Type" = const(Person)));
            Caption = 'Person Planned Quantity';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004002; "Audit Forecast Cost Person"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                            "Entry Type" = filter(Initial .. Audit),
                                                                            Type = const(Resource),
                                                                            "Resource Type" = const(Person),
                                                                            "Planning Date" = field("Posting Date Filter")));
            Caption = 'Forecast Cost Person';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004003; "Audit Person Forecast Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                           "Planning Date" = field("Posting Date Filter"),
                                                                           "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                           Type = const(Resource),
                                                                           "Resource Type" = const(Person),
                                                                           "Entry Type" = filter(Initial .. Audit)));
            Caption = 'Person Forecast Quantity';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004004; "Global Dimension 1 Filter"; Code[20])
        {
            //CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(8004005; "Global Dimension 2 Filter"; Code[20])
        {
            //CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(8004008; "Analysis Filter"; Option)
        {
            Caption = 'Analysis Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Price,Cost,Quantity';
            OptionMembers = Price,Cost,Quantity;
        }
        field(8004009; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(8004010; "Schedule (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Schedule Line" = const(true),
                                                                            "Planning Date" = field("Planning Date Filter")));
            Caption = 'Schedule (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004011; "Schedule (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Line Amount (LCY)" where("Job No." = field("No."),
                                                                             "Schedule Line" = const(true),
                                                                             "Planning Date" = field("Planning Date Filter")));
            Caption = 'Schedule (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004012; "Usage (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                           "Entry Type" = const(Usage),
                                                                           "Posting Date" = field("Posting Date Filter")));
            Caption = 'Usage (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004013; "Usage (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry2"."Line Amount (LCY)" where("Job No." = field("No."),
                                                                            "Entry Type" = const(Usage),
                                                                            "Posting Date" = field("Posting Date Filter")));
            Caption = 'Usage (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004014; "Contract (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Contract Line" = const(true),
                                                                            "Planning Date" = field("Planning Date Filter")));
            Caption = 'Contract (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004015; "Contract (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Line Amount (LCY)" where("Job No." = field("No."),
                                                                             "Contract Line" = const(true),
                                                                             "Planning Date" = field("Planning Date Filter")));
            Caption = 'Contract (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004016; "Contract (Invoiced Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = - sum("Job Ledger Entry2"."Line Amount (LCY)" where("Job No." = field("No."),
                                                                             "Entry Type" = const(Sale),
                                                                             "Posting Date" = field("Posting Date Filter")));
            Caption = 'Contract (Invoiced Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004017; "Contract (Invoiced Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = - sum("Job Ledger Entry2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Entry Type" = const(Sale),
                                                                            "Posting Date" = field("Posting Date Filter")));
            Caption = 'Contract (Invoiced Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004074; "Initial Price Forecast"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Price (LCY)" where("Job No." = field("No."),
                                                                             "Planning Date" = field("Posting Date Filter"),
                                                                             "Entry Type" = const(Initial),
                                                                             "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter")));
            Caption = 'Initial Price Forecast';
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(8004130; "Period Planning Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where("Job No." = field("No."),
                                                               Date = field("Planning Date Filter"),
                                                               "Resource Group No." = field("Resource Gr. Filter"),
                                                               "No." = field("Resource Filter"),
                                                               Status = filter(<> Deleted)));
            Caption = 'Planning Quantity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                lPlaningEntryTmp: Record "Planning Entry" temporary;
                //DYS page addon non migrer
                // lForm: Page 8004130;
                lPlaFilter: Record "Planning Filter Header";
            begin
                lPlaningEntryTmp.SetFilter("Job No.", "No.");

                if GetFilter("Resource Gr. Filter") <> '' then
                    lPlaningEntryTmp.SetFilter("Resource Group No.", GetFilter("Resource Gr. Filter"));
                if GetFilter("Planning Date Filter") <> '' then
                    lPlaningEntryTmp.SetFilter(Date, GetFilter("Planning Date Filter"));
                if GetFilter("Resource Filter") <> '' then
                    lPlaningEntryTmp.SetFilter("No.", GetFilter("Resource Filter"));

                lPlaningEntryTmp.SetFilter(Status, '<>%1', lPlaningEntryTmp.Status::Deleted);
                // lForm.GetRecord(lPlaningEntryTmp);
                // lForm.SetTableview(lPlaningEntryTmp);
                // lForm.SetOnOpenForm();
                // lForm.SetShowHistory(false);

                // if lFORM.RunModal = Action::LookupOK then;
            end;
        }
        field(8004132; "Working Time Mode"; Option)
        {
            Caption = 'Working Time Mode';
            OptionCaption = ' ,Order Line';
            OptionMembers = " ","Order Line";
        }
        field(8004133; "Planning Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where("Job No." = field("No."),
                                                               "Resource Group No." = field("Resource Gr. Filter"),
                                                               "No." = field("Resource Filter"),
                                                               Status = filter(<> Deleted)));
            Caption = 'Planning Quantity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                lPlaningEntryTmp: Record "Planning Entry" temporary;
                //DYS page addon non migrer
                // lForm: Page 8004130;
                lPlaFilter: Record "Planning Filter Header";
            begin
                lPlaningEntryTmp.SetFilter("Job No.", "No.");

                if GetFilter("Resource Gr. Filter") <> '' then
                    lPlaningEntryTmp.SetFilter("Resource Group No.", GetFilter("Resource Gr. Filter"));
                if GetFilter("Resource Filter") <> '' then
                    lPlaningEntryTmp.SetFilter("No.", GetFilter("Resource Filter"));

                lPlaningEntryTmp.SetFilter(Status, '<>%1', lPlaningEntryTmp.Status::Deleted);
                // lForm.GetRecord(lPlaningEntryTmp);
                // lForm.SetTableview(lPlaningEntryTmp);
                // lForm.SetOnOpenForm();
                // lForm.SetShowHistory(false);

                // if lFORM.RunModal = Action::LookupOK then;
            end;
        }
    }

    keys
    {
        key(STG_Key1; "No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Search Description")
        {
        }
        key(STG_Key3; "Bill-to Customer No.")
        {
        }
        key(STG_Key4; Description)
        {
        }
        key(STG_Key5; Status, "Person Responsible", "No.")
        {
        }
        key(STG_Key6; "Person Responsible", "No.", Status)
        {
        }
        key(STG_Key7; Status, "Global Dimension 1 Code", "Global Dimension 2 Code", "No.")
        {
        }
        key(STG_Key8; "Global Dimension 1 Code", "Global Dimension 2 Code", "No.", Status)
        {
        }
        key(STG_Key9; Status, "No.")
        {
        }
        key(STG_Key10; Synchronise)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "Bill-to Customer No.", "Starting Date", Status)
        {
        }
    }

    trigger OnDelete()
    var
        CommentLine: Record "Comment Line";
        JobTask: Record "Job Task2";
        JobResPrice: Record "Job Resource Price2";
        JobItemPrice: Record "Job Item Price2";
        JobGLAccPrice: Record "Job G/L Account Price2";
        lPlanningEntry: Record "Planning Entry";
        lAdvJobBudgetEntry: Record "Advanced Job Budget Entry";
        lJobIndicator: Record "Job Indicator";
        lSalesContributor: Record "Sales Contributor";
    begin


        //#6245
        IF Status = Status::Order THEN
            ERROR(tStatusIsOrder, TABLECAPTION, "No.");
        gJobLedgEntry.SETCURRENTKEY("Job No.");
        gJobLedgEntry.SETRANGE("Job No.", "No.");
        IF NOT gJobLedgEntry.ISEMPTY THEN
            ERROR(tExistEntry, TABLECAPTION, "No.", gJobLedgEntry.TABLECAPTION);
        //#6245//


        //GL2024  MoveEntries.MoveJobEntries(Rec);

        JobTask.SETCURRENTKEY("Job No.");
        JobTask.SETRANGE("Job No.", "No.");
        JobTask.DELETEALL(TRUE);

        JobResPrice.SETRANGE("Job No.", "No.");
        JobResPrice.DELETEALL;

        JobItemPrice.SETRANGE("Job No.", "No.");
        JobItemPrice.DELETEALL;

        //PROJET_BUDGET
        lAdvJobBudgetEntry.SETCURRENTKEY("Job No.");
        //#5599
        lAdvJobBudgetEntry.SETRANGE("Job No.", "No.");
        //#5599//
        lAdvJobBudgetEntry.DELETEALL;
        //PROJET_BUDGET//

        JobGLAccPrice.SETRANGE("Job No.", "No.");
        JobGLAccPrice.DELETEALL;

        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Job);
        CommentLine.SETRANGE("No.", "No.");
        CommentLine.DELETEALL;

        DimMgt.DeleteDefaultDim(DATABASE::Job, "No.");
        //PLANNING
        lPlanningEntry.SETCURRENTKEY("Job No.");
        lPlanningEntry.SETRANGE("Job No.", "No.");
        lPlanningEntry.DELETEALL(TRUE);
        //PLANNING//

        //JOB_INDICATOR
        lJobIndicator.SETRANGE("Job No.", "No.");
        lJobIndicator.DELETEALL(TRUE);
        //JOB_INDICATOR//
        //#5800
        lSalesContributor.SETCURRENTKEY("Job No.");
        lSalesContributor.SETRANGE("Job No.", "No.");
        lSalesContributor.DELETEALL(TRUE);
        //#5800//


    end;

    trigger OnInsert()
    var
        lMaskMgt: Codeunit "Mask Management";
        lRespCenter: Record "Responsibility Center";
        Cdufunction: Codeunit SoroubatFucntion;
    begin
        //AGENCE
        if (gUserMgt.GetSalesFilter() = '') and lRespCenter.ReadPermission and lRespCenter.Find('-') and
           ("Responsibility Center" = '') then begin
            Commit;
            if PAGE.RunModal(0, lRespCenter) = Action::LookupOK then
                "Responsibility Center" := lRespCenter.Code;
        end;
        //AGENCE//
        if "No." = '' then begin
            JobSetup.Get;
            JobSetup.TestField("Job Nos.");
            //AGENCE
            Cdufunction.fSetRespCenter("Responsibility Center");
            //AGENCE//
            NoSeriesMgt.InitSeries(JobSetup."Job Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        //#6884
        //+REF+TEMPLATE
        if ("No." = '') and ("No. Series" <> '') then
            NoSeriesMgt.InitSeries("No. Series", "No. Series", 0D, "No.", "No. Series");
        //#6884//
        Dimmgmevent.fSetDefaultDim(Database::Job2, "No.", 1, "Global Dimension 1 Code");
        Dimmgmevent.fSetDefaultDim(Database::Job2, "No.", 2, "Global Dimension 2 Code");
        //+REF+TEMPLATE//
        //+ONE+JOB_TASK
        gInsertDefaultJobTask();
        //+ONE+JOB_TASK//

        if GetFilter("Bill-to Customer No.") <> '' then
            if GetRangeMin("Bill-to Customer No.") = GetRangemax("Bill-to Customer No.") then
                Validate("Bill-to Customer No.", GetRangeMin("Bill-to Customer No."));

        DimMgt.UpdateDefaultDim(
          Database::Job2, "No.",
          "Global Dimension 1 Code", "Global Dimension 2 Code");
        InitWIPFields;

        "Creation Date" := Today;
        "Last Date Modified" := "Creation Date";
        //MASK
        if "Mask Code" = '' then
            "Mask Code" := lMaskMgt.UserMask;
        //MASK//

        //+JOB+TOTALISATION
        lSetJobTotalingField(Rec);
        //+JOB+TOTALISATION//
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    var
        Text000: label 'You cannot change %1 because one or more entries are associated with this %2.';
        JobSetup: Record "Jobs Setup";
        PostCode: Record "Post Code";
        Job: Record Job2;
        Cust: Record Customer;
        Cont: Record Contact;
        ContBusinessRelation: Record "Contact Business Relation";
        NoSeriesMgt: Codeunit 396;
        DimMgt: Codeunit DimensionManagement;
        Dimmgmevent: Codeunit DimensionManagementEvent;
        Text003: label 'You must run the %1 and %2 functions to create and post the completion entries for this job.';
        Text004: label 'This will delete any unposted WIP entries for this job and allow you to reverse the completion postings for this job.\\Do you wish to continue?';
        Text005: label 'Contact %1 %2 is related to a different company than customer %3.';
        Text006: label 'Contact %1 %2 is not related to customer %3.';
        Text007: label 'Contact %1 %2 is not related to a customer.';
        Text008: label '%1 %2 must not be blocked with type %3.';
        Text009: label 'You must run the %1 function to reverse the completion entries that have already been posted for this job.';
        MoveEntries: Codeunit MoveEntries;
        Text010: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text011: label '%1 must be equal to or earlier than %2.';
        wPostCode: Record "Post Code";
        wJobProgress: Record "Document Progress Degree";
        Text1100280003: label 'If you modify %1, you will modify %1 on %2.\Do ypu want to continue ?';
        Text1100280004: label '%1 must be less than previous value.';
        Text1100280006: label '%1 must not be %2 in %3 %4.';
        Text1100280008: label 'You must get through step %1.';
        Text8003917: label 'Change the %1 %2?';
        Text8003918: label '%1 %';
        wNavibatSetup: Record NavibatSetup;
        TextSynchro: label 'Do you want to replace %1 %2 by %3 in %4 %5?';
        wStatSetup: Record "Statistics setup";
        tNotEmpty: label 'not editable when entries exists';
        tUndo: label 'Status not updated.';
        tAllDoc: label 'all documents of Job No. ';
        gUserMgt: Codeunit "User Setup Management";
        //  gNoRespCenterSeriesMgt: Codeunit NoSeriesRespCenterManagement;
        tDimWarning: label 'Warning : existing entries will not be modified.\Do-you want to modify dimension code?';
        gJobLedgEntry: Record "Job Ledger Entry2";
        tExistEntry: label 'You cannot delete %1 %2 because there is at least one %3 that includes this job.';
        tStatusIsOrder: label 'You cannot delete %1 %2 because status is Order.';
        wCaptionClassTrans: Record "CaptionClass Translation";


    procedure AssistEdit(OldJob: Record Job2): Boolean
    begin
        with Job do begin
            Job := Rec;
            JobSetup.Get;
            JobSetup.TestField("Job Nos.");
            if NoSeriesMgt.SelectSeries(JobSetup."Job Nos.", OldJob."No. Series", "No. Series") then begin
                JobSetup.Get;
                JobSetup.TestField("Job Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := Job;
                exit(true);
            end;
        end;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Job2, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;


    procedure UpdateBillToCont(CustomerNo: Code[20])
    var
        ContBusRel: Record "Contact Business Relation";
        Cust: Record Customer;
    begin
        if Cust.Get(CustomerNo) then begin
            if Cust."Primary Contact No." <> '' then
                "Bill-to Contact No." := Cust."Primary Contact No."
            else begin
                ContBusRel.Reset;
                ContBusRel.SetCurrentkey("Link to Table", "No.");
                ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
                ContBusRel.SetRange("No.", "Bill-to Customer No.");
                if ContBusRel.Find('-') then
                    "Bill-to Contact No." := ContBusRel."Contact No.";
            end;
            "Bill-to Contact" := Cust.Contact;
        end;
    end;

    local procedure JobLedgEntryExist(): Boolean
    var
        JobLedgEntry: Record "Job Ledger Entry2";
    begin
        Clear(JobLedgEntry);
        JobLedgEntry.SetCurrentkey("Job No.");
        JobLedgEntry.SetRange("Job No.", "No.");
        exit(JobLedgEntry.Find('-'));
    end;

    local procedure JobPlanningLineExist(): Boolean
    var
        JobPlanningLine: Record "Job Planning Line2";
    begin
        JobPlanningLine.Init;
        JobPlanningLine.SetRange("Job No.", "No.");
        exit(JobPlanningLine.Find('-'));
    end;


    procedure UpdateBillToCust(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Cust: Record Customer;
        Cont: Record Contact;
    begin
        if Cont.Get(ContactNo) then begin
            "Bill-to Contact No." := Cont."No.";
            if Cont.Type = Cont.Type::Person then
                "Bill-to Contact" := Cont.Name
            else
                if Cust.Get("Bill-to Customer No.") then
                    "Bill-to Contact" := Cust.Contact
                else
                    "Bill-to Contact" := '';
        end else begin
            "Bill-to Contact" := '';
            exit;
        end;

        ContBusinessRelation.Reset;
        ContBusinessRelation.SetCurrentkey("Link to Table", "Contact No.");
        ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."link to table"::Customer);
        ContBusinessRelation.SetRange("Contact No.", Cont."Company No.");
        if ContBusinessRelation.Find('-') then begin
            if "Bill-to Customer No." = '' then
                Validate("Bill-to Customer No.", ContBusinessRelation."No.")
            else
                if "Bill-to Customer No." <> ContBusinessRelation."No." then
                    Error(Text006, Cont."No.", Cont.Name, "Bill-to Customer No.");
        end else
            Error(Text007, Cont."No.", Cont.Name);
    end;


    procedure UpdateCust()
    begin
        if "Bill-to Customer No." <> '' then begin
            Cust.Get("Bill-to Customer No.");
            Cust.TestField("Customer Posting Group");
            Cust.TestField("Bill-to Customer No.", '');
            "Bill-to Name" := Cust.Name;
            "Bill-to Name 2" := Cust."Name 2";
            "Bill-to Address" := Cust.Address;
            "Bill-to Address 2" := Cust."Address 2";
            "Bill-to City" := Cust.City;
            "Bill-to Post Code" := Cust."Post Code";
            "Bill-to Country/Region Code" := Cust."Country/Region Code";
            "Currency Code" := Cust."Currency Code";
            "Customer Disc. Group" := Cust."Customer Disc. Group";
            "Customer Price Group" := Cust."Customer Price Group";
            "Language Code" := Cust."Language Code";
            County := Cust.County;
            UpdateBillToCont("Bill-to Customer No.");
            //#6602
            if "Description 2" = '' then
                "Description 2" := Cust.Name;
            if ("Job Address" = '') and ("Job Address 2" = '') and ("Job City" = '') and ("Job Post Code" = '') then begin
                "Job Address" := Cust.Address;
                "Job Address 2" := Cust."Address 2";
                "Job City" := Cust.City;
                "Job Post Code" := Cust."Post Code";
            end;
            //#6602
        end else begin
            "Bill-to Name" := '';
            "Bill-to Name 2" := '';
            "Bill-to Address" := '';
            "Bill-to Address 2" := '';
            "Bill-to City" := '';
            "Bill-to Post Code" := '';
            "Bill-to Country/Region Code" := '';
            "Currency Code" := '';
            "Customer Disc. Group" := '';
            "Customer Price Group" := '';
            "Language Code" := '';
            County := '';
            Validate("Bill-to Contact No.", '');
        end;
    end;


    procedure InitWIPFields()
    begin
        "WIP Posted To G/L" := false;
        "WIP Posting Date" := 0D;
        "WIP G/L Posting Date" := 0D;
        "Posted WIP Method Used" := 0;
    end;


    procedure TestBlocked()
    begin
        if Blocked = Blocked::" " then
            exit;
        Error(Text008, TableCaption, "No.", Blocked);
    end;


    procedure CurrencyUpdatePlanningLines()
    var
        PlaningLine: Record "Job Planning Line2";
    begin
        PlaningLine.SetRange("Job No.", "No.");
        if PlaningLine.Find('-') then
            repeat
                if PlaningLine.Transferred then
                    Error(Text000, FieldCaption("Currency Code"), TableCaption);
                PlaningLine.Validate("Currency Code", "Currency Code");
                PlaningLine.Validate("Currency Date");
                PlaningLine.Modify;
            until PlaningLine.Next = 0;
    end;


    procedure ChangeJobCompletionStatus()
    var
        AllObjwithCaption: Record AllObjWithCaption;
        JobWIPGLEntry: Record "Job WIP G/L Entry2";
        JobCalcWIP: Codeunit "Job Calculate WIP2";
        ReportCaption1: Text[250];
        ReportCaption2: Text[250];
        lJobWIPEntry: Record "Job WIP Entry2";
    begin
        AllObjwithCaption.Get(AllObjwithCaption."object type"::Report, Report::"Job Calculate WIP");
        ReportCaption1 := AllObjwithCaption."Object Caption";
        AllObjwithCaption.Get(AllObjwithCaption."object type"::Report, Report::"Job Post WIP to G/L");
        ReportCaption2 := AllObjwithCaption."Object Caption";

        if Complete = true then begin
            //#6930
            JobWIPGLEntry.SetCurrentkey("Job No.", Reversed, "Job Complete");
            JobWIPGLEntry.SetRange("Job No.", "No.");
            lJobWIPEntry.SetCurrentkey("Job No.", "Job Posting Group", "WIP Posting Date", Type, "Job Complete");
            lJobWIPEntry.SetRange("Job No.", "No.");
            if not lJobWIPEntry.IsEmpty and not JobWIPGLEntry.IsEmpty then
                //#6930//
                Message(Text003, ReportCaption1, ReportCaption2);

        end else begin
            JobCalcWIP.ReOpenJob("No.");
            "WIP Posting Date" := 0D;
            "Calc. WIP Method Used" := 0;
            Message(Text009, ReportCaption2);
        end;
    end;


    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.Find('-') then
            MapMgt.MakeSelection(Database::Job2, GetPosition)
        else
            Message(Text010);
    end;


    procedure GetQuantityAvailable(ItemNo: Code[20]; LocationCode: Code[10]; VariantCode: Code[10]; InEntryType: Option Usage,Sale,Both; Direction: Option Possitive,Negative,Both) QtyBase: Decimal
    var
        JobLedgEntry: Record "Job Ledger Entry2";
    begin
        Clear(JobLedgEntry);
        with JobLedgEntry do begin
            SetCurrentkey("Job No.", "Entry Type", Type, "No.");
            SetRange("Job No.", Rec."No.");
            if not (InEntryType = Inentrytype::Both) then
                SetRange("Entry Type", InEntryType);
            SetRange(Type, Type::Item);
            SetRange("No.", ItemNo);
            if FindSet then
                repeat
                    if ("Location Code" = LocationCode) and
                       ("Variant Code" = VariantCode) and
                       ((Direction = Direction::Both) or
                        ((Direction = Direction::Possitive) and ("Quantity (Base)" > 0)) or
                        ((Direction = Direction::Negative) and ("Quantity (Base)" < 0)))
                    then
                        QtyBase := QtyBase + "Quantity (Base)";
                until Next = 0;
        end;
    end;

    local procedure CheckDate()
    begin
        if ("Starting Date" > "Ending Date") and ("Ending Date" <> 0D) then
            Error(Text011, FieldCaption("Starting Date"), FieldCaption("Ending Date"));
    end;


    procedure wGetCaptionNaviBat(pFieldNumber: Integer): Text[250]
    var
        lNaviBatSetup: Record NavibatSetup;
        lReturnText: Text[250];
    begin
        with lNaviBatSetup do begin
            GET2;
            case pFieldNumber of
                20:
                    exit(wNaviBatCaption("Person Responsible Name 1", Rec.FieldCaption("Person Responsible")));
                8003947:
                    exit(wNaviBatCaption("Person Responsible Name 2", Rec.FieldCaption("Person Responsible 2")));
                8003948:
                    exit(wNaviBatCaption("Person Responsible Name 3", Rec.FieldCaption("Person Responsible 3")));
                8003949:
                    exit(wNaviBatCaption("Person Responsible Name 4", Rec.FieldCaption("Person Responsible 4")));
                8003950:
                    exit(wNaviBatCaption("Person Responsible Name 5", Rec.FieldCaption("Person Responsible 5")));
                8003951:
                    exit(wNaviBatCaption("Free Text Name 1", Rec.FieldCaption("Free Text 1")));
                8003952:
                    exit(wNaviBatCaption("Free Text Name 2", Rec.FieldCaption("Free Text 2")));
                8003953:
                    exit(wNaviBatCaption("Free Text Name 3", Rec.FieldCaption("Free Text 3")));
                8003954:
                    exit(wNaviBatCaption("Free Text Name 4", Rec.FieldCaption("Free Text 4")));
                8003955:
                    exit(wNaviBatCaption("Free Text Name 5", Rec.FieldCaption("Free Text 5")));
                8003966:
                    exit(wNaviBatCaption("Free Date Name 1", Rec.FieldCaption("Free Date 1")));
                8003967:
                    exit(wNaviBatCaption("Free Date Name 2", Rec.FieldCaption("Free Date 2")));
                8003968:
                    exit(wNaviBatCaption("Free Date Name 3", Rec.FieldCaption("Free Date 3")));
                8003969:
                    exit(wNaviBatCaption("Free Date Name 4", Rec.FieldCaption("Free Date 4")));
                8003970:
                    exit(wNaviBatCaption("Free Date Name 5", Rec.FieldCaption("Free Date 5")));
                8003971:
                    exit(wNaviBatCaption("Free Date Name 6", Rec.FieldCaption("Free Date 6")));
                8003972:
                    exit(wNaviBatCaption("Free Date Name 7", Rec.FieldCaption("Free Date 7")));
                8003973:
                    exit(wNaviBatCaption("Free Date Name 8", Rec.FieldCaption("Free Date 8")));
                8003974:
                    exit(wNaviBatCaption("Free Date Name 9", Rec.FieldCaption("Free Date 9")));
                8003975:
                    exit(wNaviBatCaption("Free Date Name 10", Rec.FieldCaption("Free Date 10")));
                8003976:
                    exit(wNaviBatCaption("Free Value Name 1", Rec.FieldCaption("Free Value 1")));
                8003977:
                    exit(wNaviBatCaption("Free Value Name 2", Rec.FieldCaption("Free Value 2")));
                8003978:
                    exit(wNaviBatCaption("Free Value Name 3", Rec.FieldCaption("Free Value 3")));
                8003979:
                    exit(wNaviBatCaption("Free Value Name 4", Rec.FieldCaption("Free Value 4")));
                8003980:
                    exit(wNaviBatCaption("Free Value Name 5", Rec.FieldCaption("Free Value 5")));
                8003981:
                    exit(wNaviBatCaption("Free Boolean Name 1", Rec.FieldCaption("Free Boolean 1")));
                8003982:
                    exit(wNaviBatCaption("Free Boolean Name 2", Rec.FieldCaption("Free Boolean 2")));
                8003983:
                    exit(wNaviBatCaption("Free Boolean Name 3", Rec.FieldCaption("Free Boolean 3")));
                8003984:
                    exit(wNaviBatCaption("Free Boolean Name 4", Rec.FieldCaption("Free Boolean 4")));
                8003985:
                    exit(wNaviBatCaption("Free Boolean Name 5", Rec.FieldCaption("Free Boolean 5")));
            end;
        end;
    end;


    procedure wNaviBatCaption(pNaviBat: Text[30]; pCaption: Text[30]): Text[50]
    begin
        if pNaviBat <> '' then
            exit('1,5,,' + pNaviBat)
        else
            exit('1,5,,' + pCaption);
    end;


    procedure wSynchro(pCurrFieldNo: Integer; pName: Text[50])
    var
        lSalesDoc: Record "Sales Header";
        lRecRefSales: RecordRef;
        lFieldRefSales: FieldRef;
        lFieldRefSalesNo: FieldRef;
        lRecRefJob: RecordRef;
        lFieldRefJob: FieldRef;
        lFieldRefJobNo: FieldRef;
        lCurrFieldNoSales: Integer;
        lValue: Text[50];
        lOKAllSalesDoc: Boolean;
    begin
        case pCurrFieldNo of
            20:
                lCurrFieldNoSales := 8003912;
            13:
                lCurrFieldNoSales := 8003988;
            14:
                lCurrFieldNoSales := 8003989;
            FieldNo("Salesperson Code"):
                lCurrFieldNoSales := 43;
            else
                lCurrFieldNoSales := pCurrFieldNo;
        end;
        lRecRefJob.GetTable(Rec);
        lFieldRefJob := lRecRefJob.Field(pCurrFieldNo);
        lSalesDoc.SetCurrentkey("Job No.");
        lSalesDoc.SetRange("Job No.", "No.");
        if not lSalesDoc.IsEmpty then begin
            lSalesDoc.Find('-');
            lRecRefSales.GetTable(lSalesDoc);
            lFieldRefSales := lRecRefSales.Field(lCurrFieldNoSales);

            if not (StrSubstNo('%1', lFieldRefJob.Value) in ['', '0']) and
               (lFieldRefSales.Value <> lFieldRefJob.Value) then
                if lSalesDoc.Count > 1 then
                    lOKAllSalesDoc := Confirm(TextSynchro, true, pName,
                           lFieldRefSales.Value, lFieldRefJob.Value, tAllDoc, lSalesDoc."Job No.");
            repeat
                lRecRefSales.GetTable(lSalesDoc);
                lFieldRefSales := lRecRefSales.Field(lCurrFieldNoSales);
                lFieldRefSalesNo := lRecRefSales.Field(3);
                if (StrSubstNo('%1', lFieldRefSales.Value) in ['', '0']) then
                    //#5216
                    //      IF (lFieldRefSales.VALUE <> lFieldRefJob.VALUE) THEN BEGIN
                    if (lFieldRefSales.Value <> lFieldRefJob.Value) and (Format(lFieldRefJob) <> '') then begin
                        //#5216//
                        if not lOKAllSalesDoc then begin
                            if Confirm(TextSynchro, true, pName, lFieldRefSales.Value, lFieldRefJob.Value,
                                       lSalesDoc."Document Type", lSalesDoc."No.") then begin
                                lFieldRefSales.Value(lFieldRefJob.Value);
                                lRecRefSales.Modify;
                            end;
                        end else begin
                            lFieldRefSales.Value := lFieldRefJob.Value;
                            lRecRefSales.Modify;
                        end;
                    end;
            until lSalesDoc.Next = 0;
        end;
    end;


    procedure wCheckBlockedJob(var pJobNo: Code[20])
    var
        lJob: Record Job2;



    begin
        //PROJET
        if pJobNo = '' then
            exit;
        lJob.Get(pJobNo);
        with lJob do begin
            //#5458  TESTFIELD(Status,Status::Order);
            //  TESTFIELD(Blocked,FALSE);
            TestField(Blocked, Blocked::" ");
            TestField(Finished, false);
        end;
        //PROJET//
    end;


    procedure wEntryExists(): Boolean
    var
        lJobLedgerEntry: Record "Job Ledger Entry2";
        lSalesLine: Record "Sales Line";
        lPurchaseLine: Record "Purchase Line";
    begin
        lJobLedgerEntry.SetCurrentkey("Job No.");
        lJobLedgerEntry.SetRange("Job No.", "No.");
        if not lJobLedgerEntry.IsEmpty then
            exit(true);
        lSalesLine.SetCurrentkey("Job No.", "Document Type", "Document No.");
        lSalesLine.SetRange("Job No.", "No.");
        if not lSalesLine.IsEmpty then
            exit(true);
        lPurchaseLine.SetCurrentkey("Job No.");
        lPurchaseLine.SetRange("Job No.", "No.");
        if not lPurchaseLine.IsEmpty then
            exit(true);
    end;


    procedure wGetTotalingChar(): Code[1]
    var
        lNavibatSetup: Record NavibatSetup;
    begin
        if lNavibatSetup.GET2 then
            exit(lNavibatSetup."Totalisation Character");
    end;


    procedure gGetDefaultJobTask(): Code[20]
    var
        lJobTask: Record "Job Task2";
        ltNoOpenTask: label 'No open task for job %1.';
    begin
        lJobTask.SetRange("Job No.", "No.");
        lJobTask.SetRange("Job Task Type", lJobTask."job task type"::Posting);
        //#5330
        //IF ISEMPTY THEN
        //   EXIT('');
        lJobTask.SetRange(Blocked, false);
        if lJobTask.IsEmpty then
            Error(ltNoOpenTask, "No.");
        //#5330//
        if lJobTask.Count = 1 then begin
            lJobTask.FindFirst;
            exit(lJobTask."Job Task No.")
        end;
        //#5330
        /*
        lJobTask.SETRANGE("Default Job Task",TRUE);
        IF lJobTask.FINDFIRST THEN
          EXIT(lJobTask."Job Task No.")
        ELSE
          EXIT('');
        */
        //#5330//

    end;


    procedure gInsertDefaultJobTask()
    var
        lNaviBatSetup: Record NavibatSetup;
        lRecordRef: RecordRef;
        lTemplateMgt: Codeunit "Config. Template Management";
        CduFunction: Codeunit SoroubatFucntion;
        lJobTask: Record "Job Task2";
    begin
        //+ONE+JOB_TASK
        if lNaviBatSetup.Get and (lNaviBatSetup."Job Task Creation Model" <> '') then begin
            lRecordRef.Open(Database::"Job Task2");
            CduFunction.SetValue(lRecordRef, lNaviBatSetup."Job Task Creation Model");
            lRecordRef.SetTable(lJobTask);
            lJobTask."Job No." := "No.";
            lJobTask.Insert;
        end;
        //+ONE+JOB_TASK//
    end;


    procedure lSetJobTotalingLevel(var pRec: Record Job2)
    var
        t8003900: label 'You can''t use the ''.'' character on the last opsition of Field "%1"';
        i: Integer;
        AA: record "Value Entry";
    begin
        ///Summary
        // @Input@ : Job Table
        // @OUtput@ : Void
        // @Description@ = This function update the Field "level" depending on the Job "No."
        ///Summary//

        pRec.Level := 0;
        for i := 1 to StrLen(pRec."No.") do
            if pRec."No."[i] in ['.', ' '] then begin
                if (pRec."No."[i] = '.') and (i = StrLen(pRec."No.")) then
                    Error(t8003900, pRec.FieldCaption("No."));
                pRec.Level += 1;
            end;
    end;


    procedure lSetJobTotalingField(var pRec: Record Job2)
    begin
        ///Summary
        // @Input@ : Job Table
        // @OUtput@ : Void
        // @Description@ = This function update the Field "Job Totaling" with the Job "No."
        ///Summary//

        if not pRec.Summarize then
            pRec."Job Totaling" := pRec."No."
        else
            pRec."Job Totaling" := pRec."No." + '..' + pRec."No." + '.' + wGetTotalingChar;
    end;
}

