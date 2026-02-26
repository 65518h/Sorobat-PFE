Table 8004161 "Job Ledger Entry2"
{
    // //PLANNING CW 26/08/09 +SIF "Job No.,Project Header No.,Entry Type,Resource Group No.,Type,No.,Planning Task No.,Posting Date" / "Qu
    // //ABSENCE CW 28/09/09 +"Employee Absence Entry No."
    // //JOB_TRANSFER CW 20/12/05 +"Amt. Transfered to G/L", "Add.-Curr. Amt. Transf to G/L"
    // //#6104 "Total
    // //#5951 Ajout
    // //#5613 "Unit of measure" if Producted Hours|Unproduced Hours|Absence Hours
    // //#5508 MaintainSIFTIndex sur sql Résultat faux
    // //STATSEXPLORER STATSEXPLORER 01/01/00 New key :
    // Entry Type,Type,No.,Gen. Prod. Posting Group,Resource Group No.,Global Dimension 1 Code,Global Dimension 2 Code,
    // Job No.,Phase Code,Task Code,Step Code,Work Type Code,Reason Code,Posting Date
    // Sumindexfields = Quantity,Total Cost,Total Price
    // //+NDF+ GESWAY 15/07/02 Ajout de clé pour rCeport "Notes de frais définitives"
    //                                  - Type,No.,Posting Date,Job No.,Work Type Code
    //                                  - Type,No.,Global Dimension 1 Code,Global Dimension 2 Code,Unit of Measure Code,Location Code
    // //+REP+ GESWAY 30/10/01 Ajout 8003500 Analytical Distribution
    //                         Ajout clé Analytical Distribution,Entry type,Type,No.,....
    //                        !!! Non reprise pour le moment
    // //PREPAIE GESWAY 01/12/01 Ajout clé Type,No.,Work Type Code,Phase Code,Task Code,Step Code,Job No.,Posting Date
    //                                     Type,No.,Work Type Code,Phase Code,Task Code,Step Code,Posting Date,Job No.
    // //PROJET_PHASE GESWAY 01/11/01 TableRelation de code phase, ajout de where Job No.
    //                                OnValidate "Job No." Contrôle de la phase si changement du projet
    //                                Ajout SIF Quantity à la clé Related to Budget,Job No.,.....
    // //PROJET_NATURE GESWAY 18/05/02 Ajout clé Entry Type,Job No.,Phase Code,Gen. Prod. Post. Group,Task Code,
    //                                      Step Code,Work Type Code,Type,Resource type,No.,Posting Date,Work Time Type
    // //POINTAGE GESWAY 27/05/02 Ajout des champs "Vendor No.","Resource Type","Security Group Code"
    //                            Ajout de la clé Vendor No.,Job No.,Type,No.,Posting Date
    //            GESWAY 14/08/02 Ajout du champ "Attached to Ledger Entry No."
    //                   22/08/02 Ajout du champ N° mission, "Work Time Type"
    //                            Modification de la clé de StatsExplorer + Work Time Type
    //                            Ajout de la clé
    //                       Job No.,Gen. Prod. Posting Group,Entry Type,Work Type Code,Type,Resource Type,No.,Posting Date,Work Time Type,
    //                       Bal. Created Entry,Job Posting Group
    //                   17/06/04 Ajout de la clé Type,No.,Job No.,Posting Date,Work Time Type
    // //INTERIM GESWAY 20/08/02 Ajout des champs N° affaire contrepartie, N° pré-attribué, N° ligne, "Bal. Created Entry"
    //                           Ajout clé Entry Type,Type,Vendor No.,Mission No.,No.,Work Type Code,Bal. Job No.,Posting Date
    //                           Ajout clé Pre-Assigned No.,Line No.
    // //DESCRIPTION GESWAY 08/12/04 Ajout du champ Descriptions
    //                               Gestion sur le OnDelete de la suppression des commentaires
    // //LETTRAGE_PROJET GESWAY 10/06/03 Ajout de deux champs : ID pointage et soldé
    //                                   Ajout d'une clé sur "soldé" et "ID pointage"
    // //PROJET_FG CW 13/04/04 Ajout colonne "Overhead Amount" et SIF
    // //REVERSE CLA 10/05/05 Ajout champ 8003912 pour contrepasser écriture
    // //MASK CW 16/02/06 +"Mask Code"
    // //IC ML 12/06/06 Ajout des champs "To Company" et "IC Job Ledg. Entry No."
    //                  Ajout de la clé To Company,IC Job Ledg. Entry No.
    // //NAVISON ML 22/11/066 champ 29 "Job Posting Group" TestTableRelation à NO

    Caption = 'Job Ledger Entry';
    //  DrillDownPageID = 8004162;
    // LookupPageID = 8004162;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job2;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account';
            OptionMembers = Resource,Item,"G/L Account";
        }
        field(7; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Resource)) Resource
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("G/L Account")) "G/L Account";
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(11; "Direct Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost (LCY)';
        }
        field(12; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            Editable = true;
        }
        field(13; "Total Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Cost (LCY)';
            Editable = true;
        }
        field(14; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
            Editable = true;
        }
        field(15; "Total Price (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price (LCY)';
            Editable = true;
        }
        field(16; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            Editable = false;
            TableRelation = "Resource Group";
        }
        field(17; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."));
        }
        field(20; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(29; "Job Posting Group"; Code[20])
        {
            Caption = 'Job Posting Group';
            TableRelation = if (Type = const(Item)) "Inventory Posting Group"
            else
            if (Type = const("G/L Account")) "G/L Account"
            else
            "Job Posting Group2";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(31; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(32; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(33; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(37; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = "User Setup";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //  LoginMgt.LookupUserID("User ID");
            end;
        }
        field(38; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(60; "Amt. to Post to G/L"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. to Post to G/L';
        }
        field(61; "Amt. Posted to G/L"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. Posted to G/L';
        }
        field(62; "Amt. to Recognize"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. to Recognize';
        }
        field(63; "Amt. Recognized"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. Recognized';
        }
        field(64; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Description = 'Editable=Yes';
            OptionCaption = 'Usage,Sale';
            OptionMembers = Usage,Sale;
        }
        field(75; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(76; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(77; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(78; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(79; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(80; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(81; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(82; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(83; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(84; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(85; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(86; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(87; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(88; "Additional-Currency Total Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Additional-Currency Total Cost';
        }
        field(89; "Add.-Currency Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Add.-Currency Total Price';
        }
        field(94; "Add.-Currency Line Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Add.-Currency Line Amount';
        }
        field(1000; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task2"."Job Task No." where("Job No." = field("Job No."));
        }
        field(1001; "Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount (LCY)';
            Editable = false;
        }
        field(1002; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
        }
        field(1003; "Total Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Cost';
        }
        field(1004; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(1005; "Total Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Price';
        }
        field(1006; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';
        }
        field(1007; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(1008; "Line Discount Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount (LCY)';
            Editable = false;
        }
        field(1009; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(1010; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
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
        field(1019; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
        }
        field(1020; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }
        field(1021; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
        }
        field(1022; "Line Type"; Option)
        {
            Caption = 'Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(1023; "Original Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Original Unit Cost (LCY)';
            Editable = false;
        }
        field(1024; "Original Total Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Original Total Cost (LCY)';
            Editable = false;
        }
        field(1025; "Original Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Original Unit Cost';
        }
        field(1026; "Original Total Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Total Cost';
        }
        field(1027; "Original Total Cost (ACY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Total Cost (ACY)';
        }
        field(1028; Adjusted; Boolean)
        {
            Caption = 'Adjusted';
        }
        field(1029; "DateTime Adjusted"; DateTime)
        {
            Caption = 'DateTime Adjusted';
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5405; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
        }
        field(5900; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
        }
        field(5901; "Posted Service Shipment No."; Code[20])
        {
            Caption = 'Posted Service Shipment No.';
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(99001; "ID pointage"; Code[10])
        {
        }
        field(99002; Balanced; Boolean)
        {
            Caption = 'Balanced';
        }
        field(8003500; "Analytical Distribution"; Boolean)
        {
            Caption = 'Analytical Distribution';
        }
        field(8003900; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(8003901; "Resource Type"; Option)
        {
            Caption = 'Resource Type';
            OptionCaption = 'Person,Machine';
            OptionMembers = Person,Machine,Structure;
        }
        field(8003903; "Attached to Ledger Entry No."; Integer)
        {
            Caption = 'Attached to Ledger Entry No.';
        }
        field(8003904; "Bal. Job No."; Code[20])
        {
            Caption = 'Bal. Job No.';
            TableRelation = Job2;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8003905; "Pre-Assigned No."; Code[20])
        {
            Caption = 'Pre-Assigned No.';
        }
        field(8003906; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(8003907; "Mission No."; Code[20])
        {
            Caption = 'Mission No.';
        }
        field(8003910; "Overhead Amount"; Decimal)
        {
            Caption = 'Overhead Amount';
        }
        field(8003911; "Work Time Type"; Option)
        {
            Caption = 'Work Time Type';
            OptionCaption = ' ,Producted Hours,Unproduced Hours,Absence Hours,Premium,Transport,Meal';
            OptionMembers = " ","Producted Hours","Unproduced Hours","Absence Hours",Premium,Transport,Meal;
        }
        field(8003912; "G/L Entry No."; Integer)
        {
            //blankzero = true;
            Caption = 'G/L Entry No.';
            TableRelation = "G/L Entry";
        }
        field(8003931; "To Company"; Text[30])
        {
            Caption = 'To Company';
            TableRelation = Company;
        }
        field(8003932; "IC Job Ledg. Entry No."; Integer)
        {
            Caption = 'IC Job Ledg. Entry No.';
        }
        field(8004009; "Bal. Created Entry"; Boolean)
        {
            Caption = 'Bal. Created Entry';
        }
        field(8004010; "Amt. Transfered to G/L"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. Transfered to G/L';
        }
        field(8004011; "Add.-Curr. Amt. Transf to G/L"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Add.-Curr. Amt. Posted to G/L';
        }
        field(8004134; "Sales Document No."; Code[20])
        {
            Caption = 'Sales Document No.';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnValidate()
            begin
                if "Sales Document No." <> xRec."Sales Document No." then
                    "Sales Line No." := 0;
            end;
        }
        field(8004135; "Sales Line No."; Integer)
        {
            Caption = 'Sales Line No.';
            TableRelation = "Sales Line"."Line No." where("Document No." = field("Sales Document No."));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8004140; Descriptions; Boolean)
        {
            CalcFormula = exist("Description Line" where("Table ID" = const(8004161),
                                                          "Document Line No." = field("Entry No.")));
            Caption = 'Descriptions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004141; "Employee Absence Entry No."; Integer)
        {
            Caption = 'Employee Absence Entry No.';
        }
        field(8035001; "Project Header No."; Code[20])
        {
            Caption = 'Project Header No.';
            TableRelation = "Planning Header Archive"."No.";
        }
        field(8035003; "Planning Task No."; Text[20])
        {
            Caption = 'Planning Task No.';
            TableRelation = "Planning Line Archive"."Task No.";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Job No.", "Job Task No.", "Entry Type", "Posting Date")
        {
            SumIndexFields = "Total Cost (LCY)", "Line Amount (LCY)";
        }
        key(Key3; "Document No.", "Posting Date")
        {
        }
        key(Key4; "Job No.", "Posting Date")
        {
        }
        key(Key5; "Entry Type", Type, "No.", "Posting Date")
        {
        }
        key(Key6; "Service Order No.", "Posting Date")
        {
        }
        key(Key7; "Job No.", "Entry Type", Type, "No.")
        {
        }
        key(Key8; Type, "Entry Type", "Country/Region Code", "Source Code", "Posting Date")
        {
        }
        key(Key9; "Entry Type", Type, "No.", "Gen. Prod. Posting Group", "Resource Group No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Job No.", "Work Type Code", "Reason Code", "Posting Date")
        {
            SumIndexFields = "Total Cost";
        }
        key(Key10; "Entry Type", Type, "Job No.", "Job Task No.", "Gen. Prod. Posting Group", "Work Time Type", "Work Type Code", "Resource Group No.", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Reason Code", "Posting Date")
        {
            SumIndexFields = Quantity, "Total Cost (LCY)", "Line Amount (LCY)", "Total Cost";
        }
        key(Key11; Type, "No.", "Work Type Code", "Job No.", "Job Task No.", "Posting Date")
        {
            SumIndexFields = "Total Cost (LCY)", "Line Amount (LCY)", Quantity;
        }
        key(Key12; Type, "No.", "Posting Date", "Job No.", "Work Type Code")
        {
        }
        key(Key13; Type, "No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Unit of Measure Code", "Location Code")
        {
        }
        key(Key14; "Vendor No.", "Job No.", Type, "No.", "Posting Date")
        {
        }
        key(Key15; "Analytical Distribution", "Entry Type", Type, "No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Reason Code", "Gen. Prod. Posting Group", "Gen. Bus. Posting Group", "Source Code", "Job No.", "Resource Group No.", "Work Type Code", "Job Task No.", "Posting Date")
        {
            SumIndexFields = "Total Cost";
        }
        key(Key16; "Entry Type", "Bal. Created Entry", "Job Posting Group", "Job No.", "Gen. Prod. Posting Group", "Job Task No.", Type, "Resource Type", "Work Type Code", "Work Time Type", "No.", "Posting Date", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
            SumIndexFields = "Total Cost (LCY)", "Line Amount (LCY)", Quantity, "Overhead Amount";
        }
        key(Key17; "Entry Type", Type, "Vendor No.", "Mission No.", "No.", "Work Type Code", "Bal. Job No.", "Posting Date")
        {
        }
        key(Key18; "Pre-Assigned No.", "Line No.")
        {
        }
        key(Key19; Balanced, "ID pointage")
        {
        }
        key(Key20; "Job No.", "Gen. Prod. Posting Group", "Entry Type", "Work Type Code", Type, "Resource Type", "No.", "Posting Date", "Work Time Type", "Bal. Created Entry", "Job Posting Group", "Gen. Bus. Posting Group", "Sales Document No.")
        {
            SumIndexFields = "Total Cost (LCY)", "Line Amount (LCY)", Quantity, "Quantity (Base)";
        }
        key(Key21; Type, "No.", "Job No.", "Work Type Code", "Posting Date")
        {
        }
        key(Key22; "To Company", "IC Job Ledg. Entry No.")
        {
        }
        key(Key23; Type, "No.", "Work Type Code", "Job Task No.", "Posting Date", "Job No.")
        {
        }
        key(Key24; "Job No.", "Gen. Prod. Posting Group", "Entry Type", "Resource Type", "Work Type Code", "Posting Date", "Work Time Type", "Bal. Created Entry", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
            SumIndexFields = "Total Cost (LCY)", "Line Amount (LCY)", Quantity;
        }
        key(Key25; "Posting Date", "Mission No.", "No.", "Work Type Code", Type)
        {
            SumIndexFields = Quantity;
        }
        key(Key26; "Job No.", "Project Header No.", "Entry Type", "Resource Group No.", Type, "No.", "Planning Task No.", "Posting Date")
        {
            MaintainSQLIndex = false;
            SumIndexFields = "Quantity (Base)";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Job No.", "Posting Date", "Document No.")
        {
        }
    }

    trigger OnDelete()
    var
        lDescriptionLine: Record "Description Line";
    begin
        //DESCRIPTION
        lDescriptionLine.DeleteLines(Database::"Job Ledger Entry2", 0, '', "Entry No.");
        //DESCRIPTION//
    end;
}

