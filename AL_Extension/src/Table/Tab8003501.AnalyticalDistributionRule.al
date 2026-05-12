Table 8003501 "Analytical Distribution Rule"
{
    // //+REP+ GESWAY 19/09/01 Nouvelle des lois de répartition analytique
    //                19/12/05 Nouveau mode : Coût additionnel
    //                20/11/06 nouveau "prorata type" : Budbet avancé (spécifique 1 et 2)

    Caption = 'Analytical Distribution Rule';
    // LookupPageID = 8003502;

    fields
    {
        field(1; "Rule Code"; Code[10])
        {
            Caption = 'Rule Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Distribution Mode"; Option)
        {
            Caption = 'Distribution Mode';
            OptionCaption = 'Prorata,Percentage,Number,Additionnal Cost';
            OptionMembers = Prorata,Percentage,Number,"Additionnal Cost";

            trigger OnValidate()
            begin
                if (xRec."Distribution Mode" <> "Distribution Mode") then begin
                    DistributionKey.SetRange("Analytical Distribution Code", "Rule Code");
                    if DistributionKey.Find('-') then
                        if "Distribution Mode" <> "distribution mode"::Prorata then begin
                            if Confirm(TextKeyExist, false, "Rule Code") then
                                DistributionKey.DeleteAll;
                        end else
                            DistributionKey.DeleteAll;
                end;
            end;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(5; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(10; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Account,Job';
            OptionMembers = Account,Job;
        }
        field(11; "Global Dimension 1 Filter"; Code[70])
        {
            //CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12; "Global Dimension 2 Filter"; Code[70])
        {
            //CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(13; "Source Filter"; Text[50])
        {
            Caption = 'Source Filter';
            TableRelation = "Source Code".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(14; "Job Filter"; Text[70])
        {
            Caption = 'Job Filter';
            TableRelation = Job;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(15; "Reason Code Filter"; Text[70])
        {
            Caption = 'Reason Code Filter';
            TableRelation = "Reason Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(16; "Business Unit Code Filter"; Text[70])
        {
            Caption = 'Business Unit Filter';
            TableRelation = "Business Unit";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(17; "Gen. Prod. Post. Group Filter"; Text[70])
        {
            Caption = 'Gen. Prod. Posting Group Filter';
            TableRelation = "Gen. Product Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(18; "Gen. Bus. Posting Group Filter"; Text[70])
        {
            Caption = 'Gen. Bus. Posting Group Filter';
            TableRelation = "Gen. Business Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(19; "Type Filter"; Option)
        {
            Caption = 'Type Filter';
            OptionCaption = ' ,Resource,Item,Account (G/L)';
            OptionMembers = " ",Resource,Item,"Account (G/L)";

            trigger OnValidate()
            begin
                if ("Type Filter" = "type filter"::" ") or ("Type Filter" <> xRec."Type Filter") then
                    "No. Filter" := '';
            end;
        }
        field(20; "No. Filter"; Text[70])
        {
            Caption = 'No. Filter';
            TableRelation = if ("Type Filter" = const("Account (G/L)")) "G/L Account"."No."
            else
            if ("Type Filter" = const(Item)) Item."No."
            else
            if ("Type Filter" = const(Resource)) Resource."No.";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField("Type Filter");
            end;
        }
        field(21; "Job Posting Group Filter"; Text[70])
        {
            Caption = 'Job Posting Group Filter';
            TableRelation = "Job Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if "Job Posting Group Filter" <> '' then
                    TestField("Entry Type", "entry type"::Job);
            end;
        }
        field(22; "Resource Group No. Filter"; Text[70])
        {
            Caption = 'Resource Group No. Filter';
            TableRelation = "Resource Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if "Resource Group No. Filter" <> '' then
                    TestField("Entry Type", "entry type"::Job);
            end;
        }
        field(23; "Location Code Filter"; Text[70])
        {
            Caption = 'Location Filter';
            TableRelation = Location;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if "Location Code Filter" <> '' then
                    TestField("Entry Type", "entry type"::Job);
            end;
        }
        field(24; "Work Type Code Filter"; Text[70])
        {
            Caption = 'Work Type Code Filter';
            TableRelation = "Work Type";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if "Work Type Code Filter" <> '' then
                    TestField("Entry Type", "entry type"::Job);
            end;
        }
        field(26; "Job Task No. Filter"; Text[70])
        {
            Caption = 'Job Task No. Filter';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job Task No. Filter"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(28; "Job Entry Type Filtre"; Option)
        {
            Caption = 'Job Entry Type Filtre';
            OptionCaption = ' ,Usage,Sale';
            OptionMembers = " ",Usage,Sale;

            trigger OnValidate()
            begin
                if "Job Entry Type Filtre" <> "job entry type filtre"::" " then
                    TestField("Entry Type", "entry type"::Job);
            end;
        }
        field(29; "Starting Date Calc. Formula"; DateFormula)
        {
            Caption = 'Starting Date Calculation Formula';
        }
        field(40; "Prorata Type"; Option)
        {
            Caption = 'Prorata Type';
            OptionCaption = 'General Ledger Amount,General Ledger Quantity,Job Total Cost,Job Total Price,Job Quantity,Specific 1 (Qty),Specific 2 (Amount)';
            OptionMembers = "General Ledger Amount","General Ledger Quantity","Job Total Cost","Job Total Price","Job Quantity","Specific 1 (Qty)","Specific 2 (Amount)";
        }
        field(41; "Old Resource Group Control"; Option)
        {
            Caption = 'Old Resource Group Control';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";
        }
        field(42; "Old Global Dim. 1 Control"; Option)
        {
            //CaptionClass = '1,1,1,' + TextControl;
            Caption = 'Old Global Dim. 1 Control';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";
        }
        field(43; "Old Global Dim. 2 Control"; Option)
        {
            //CaptionClass = '1,1,2,' + TextControl;
            Caption = 'Old Global Dim. 2 Control';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";
        }
        field(44; "Old Gen. Prod. Group Control"; Option)
        {
            Caption = 'Old Gen. Prod. Group Control';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";
        }
        field(45; "Old Gen. Bus. Group Control"; Option)
        {
            Caption = 'Old Gen. Bus. Group Control';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";
        }
        field(46; "Old Job Posting Group Control"; Option)
        {
            Caption = 'Old Job Posting Group Control';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";
        }
        field(47; "Old Gen. Prod. Post. Group"; Code[10])
        {
            Caption = 'Old Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(48; "Old Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Old Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(49; "Old Job Posting Group"; Code[10])
        {
            Caption = 'Old Job Posting Group';
            TableRelation = "Job Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50; "Journal Batch Type"; Option)
        {
            Caption = 'Journal Batch Type';
            OptionCaption = 'General Ledger,Job';
            OptionMembers = "General Ledger",Job;
        }
        field(51; "Old G/L Account No."; Code[20])
        {
            Caption = 'Old G/L Account No.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if GLAccount.Get("Old G/L Account No.") then
                    GLAccount.TestField("Direct Posting", true);
            end;
        }
        field(52; "Old Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1,' + TextOrigin;
            Caption = 'Old Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(53; "Old Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2,' + TextOrigin;
            Caption = 'Old Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(54; "Old Job No."; Code[20])
        {
            Caption = 'Old Job No.';
            TableRelation = Job;

            trigger OnValidate()
            begin
                if "Old Job No." <> '' then begin
                    Job.Get("Old Job No.");
                    Job.TestField(Status, Job.Status::Open);
                end;
            end;
        }
        field(55; "Old Reason Code"; Code[10])
        {
            Caption = 'Old Reason Code';
            TableRelation = "Reason Code";
        }
        field(56; "Old Work Type Code"; Code[10])
        {
            Caption = 'Old Work Type Code';
            TableRelation = "Work Type";

            trigger OnValidate()
            begin
                if "Old Work Type Code" <> '' then
                    TestField("Entry Type", "entry type"::Job);
            end;
        }
        field(58; "Old Job Task No."; Code[10])
        {
            Caption = 'Old job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Old Job No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(60; "Old Job No. Control"; Option)
        {
            Caption = 'Old Job No. Control';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";
        }
        field(61; "Old Reason Code Control"; Option)
        {
            Caption = 'Old Reason Code Control';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";
        }
        field(62; "Old Work Type Code Control"; Option)
        {
            Caption = 'Old Work Type Code Control';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";
        }
        field(64; "Old Job Task No. Control"; Option)
        {
            Caption = 'Old Job Task No. Control';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";
        }
        field(66; "Old Resource Group No."; Code[20])
        {
            Caption = 'Old Resource Group No.';
            TableRelation = "Resource Group";
        }
        field(67; "New Gen. Prod. Post. Group"; Code[10])
        {
            Caption = 'New Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(68; "New Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'New Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(69; "New Job Posting Group"; Code[10])
        {
            Caption = 'New Job Posting Group';
            TableRelation = "Job Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(70; "New G/L Account No."; Code[20])
        {
            Caption = 'New G/L Account No.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if GLAccount.Get("New G/L Account No.") then
                    GLAccount.TestField("Direct Posting", true);
            end;
        }
        field(71; "New Global Dim. 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1,' + TextDest;
            Caption = 'New Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(72; "New Global Dim. 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2,' + TextDest;
            Caption = 'New Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(73; "New Job No."; Code[20])
        {
            Caption = 'New Job No.';
            TableRelation = Job;

            trigger OnValidate()
            begin
                if "New Job No." <> '' then begin
                    Job.Get("New Job No.");
                    Job.TestField(Status, Job.Status::Open);
                end;
            end;
        }
        field(74; "New Reason Code"; Code[10])
        {
            Caption = 'New Reason Code';
            TableRelation = "Reason Code";
        }
        field(75; "New Work Type Code"; Code[10])
        {
            Caption = 'New Work Type Code';
            TableRelation = "Work Type";

            trigger OnValidate()
            begin
                if "New Work Type Code" <> '' then
                    TestField("Entry Type", "entry type"::Job);
            end;
        }
        field(77; "New Job Task No."; Code[10])
        {
            Caption = 'New Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("New Job No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //IF "New Job Task No." <> '' THEN
                //  TESTFIELD("Entry Type","Entry Type"::Job);
            end;
        }
        field(80; "Prorata Global Dim. 1 Filter"; Code[70])
        {
            //CaptionClass = '1,3,1,' + TextProrata;
            Caption = 'Prorata Global Dimension 1 Filter';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(81; "Prorata Global Dim. 2 Filter"; Code[70])
        {
            //CaptionClass = '1,3,2,' + TextProrata;
            Caption = 'Prorata Global Dimension 2 Filter';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(82; "Prorata Source Code Filter"; Text[70])
        {
            Caption = 'Prorata Source Code Filter';
            TableRelation = "Source Code".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(83; "Prorata Job No. Filter"; Text[70])
        {
            Caption = 'Prorata Job No. Filter';
            TableRelation = Job;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(84; "Prorata Reason Code Filter"; Text[70])
        {
            Caption = 'Prorata Reason Code Filter';
            TableRelation = "Reason Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(85; "Prorata Business Unit Filter"; Text[70])
        {
            Caption = 'Prorata Business Unit Code Filter';
            TableRelation = "Business Unit";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(86; "Prorata Gen Prod Posting Group"; Text[70])
        {
            Caption = 'Prorata Gen. Prod. Posting Group Filter';
            TableRelation = "Gen. Product Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(87; "Prorata Gen Bus Posting Group"; Text[70])
        {
            Caption = 'Prorata Gen. Bus. Posting Group Filter';
            TableRelation = "Gen. Business Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(88; "Prorata Type Filter"; Option)
        {
            Caption = 'Prorata Type Filter';
            OptionCaption = ' ,Resource,Item,Account (G/L)';
            OptionMembers = " ",Resource,Item,"Account (G/L)";

            trigger OnValidate()
            begin
                if ("Prorata Type Filter" = "prorata type filter"::" ") or ("Prorata Type Filter" <> xRec."Prorata Type Filter") then
                    "Prorata No. Filter" := '';
            end;
        }
        field(89; "Prorata No. Filter"; Text[70])
        {
            Caption = 'Prorata No. Filter';
            TableRelation = if ("Prorata Type Filter" = const("Account (G/L)")) "G/L Account"."No."
            else
            if ("Prorata Type Filter" = const(Item)) Item."No."
            else
            if ("Prorata Type Filter" = const(Resource)) Resource."No.";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if "Prorata No. Filter" <> '' then
                    TestField("Prorata Type Filter");
            end;
        }
        field(90; "Prorata Job Posting Gp Filter"; Text[70])
        {
            Caption = 'Prorata Job Posting Group Filter';
            TableRelation = "Job Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if ("Prorata Type" < "prorata type"::"Job Total Cost") /*AND ("Prorata Posting Group Filter" <> '')*/ then
                    Error(TextInterdiction, FieldCaption("Prorata Type"), "Prorata Type", FieldCaption("Rule Code"), "Rule Code");

            end;
        }
        field(91; "Prorata Resource Gp No. Filter"; Text[70])
        {
            Caption = 'Prorata Resource Group No. Filter';
            TableRelation = "Resource Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if ("Prorata Type" < "prorata type"::"Job Total Cost") and ("Prorata Resource Gp No. Filter" <> '') then
                    Error(TextInterdiction, FieldCaption("Prorata Type"), "Prorata Type", FieldCaption("Rule Code"), "Rule Code");
            end;
        }
        field(92; "Prorata Location Code Filter"; Text[70])
        {
            Caption = 'Prorata Location Code Filter';
            TableRelation = Location;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if ("Prorata Type" < "prorata type"::"Job Total Cost") and ("Prorata Location Code Filter" <> '') then
                    Error(TextInterdiction, FieldCaption("Prorata Type"), "Prorata Type", FieldCaption("Rule Code"), "Rule Code");
            end;
        }
        field(93; "Prorata Work Type Code Filter"; Text[70])
        {
            Caption = 'Prorata Work Type Code Filter';
            TableRelation = "Work Type";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(95; "Prorata Job Task No. Filter"; Text[70])
        {
            Caption = 'Prorata Job Task No. Filter';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Prorata Job No. Filter"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if ("Prorata Type" < "prorata type"::"Job Total Cost") and ("Prorata Job Task No. Filter" <> '') then
                    Error(TextInterdiction, FieldCaption("Prorata Type"), "Prorata Type", FieldCaption("Rule Code"), "Rule Code");
            end;
        }
        field(97; "Prorata Job Entry Type Filter"; Option)
        {
            Caption = 'Prorata Job Entry Type Filter';
            OptionCaption = ' ,Usage,Sale';
            OptionMembers = " ",Usage,Sale;

            trigger OnValidate()
            begin
                if "Prorata Type" < "prorata type"::"Job Total Cost" then
                    Error(TextInterdiction, FieldCaption("Prorata Type"), "Prorata Type", FieldCaption("Rule Code"), "Rule Code");
            end;
        }
        field(98; "By G/L Account No."; Boolean)
        {
            Caption = 'G/L Account No.';
        }
        field(99; "By Global Dimension 1"; Boolean)
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1';
        }
        field(100; "By Global Dimension 2"; Boolean)
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2';
        }
        field(101; "By Job No."; Boolean)
        {
            Caption = 'Job No.';
        }
        field(102; "By Reason Code"; Boolean)
        {
            Caption = 'Reason Code';
        }
        field(103; "By Work Type Code"; Boolean)
        {
            Caption = 'Work Type';
        }
        field(105; "By Job Task No."; Boolean)
        {
            Caption = 'By Job Task No.';
        }
        field(107; "By Shortcut Dimension 3"; Boolean)
        {
            //CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3';
        }
        field(108; "By Shortcut Dimension 4"; Boolean)
        {
            //CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4';
        }
        field(109; "By Shortcut Dimension 5"; Boolean)
        {
            //CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5';
        }
        field(110; "By Shortcut Dimension 6"; Boolean)
        {
            //CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6';
        }
        field(111; "By Shortcut Dimension 7"; Boolean)
        {
            //CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7';
        }
        field(112; "By Shortcut Dimension 8"; Boolean)
        {
            //CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8';
        }
        field(113; "By Gen Prod Posting Group"; Boolean)
        {
            Caption = 'Gen Prod Posting Group';
        }
        field(114; "By Gen Bus. Posting Group"; Boolean)
        {
            Caption = 'Gen Bus. Posting Group';
        }
        field(115; "By Job Posting Group"; Boolean)
        {
            Caption = 'Job Posting Group';
        }
        field(119; "Prorata Shortcut Dim 3 Filter"; Code[70])
        {
            //CaptionClass = '1,4,3,' + TextProrata;
            Caption = 'Prorata Shortcut Dim 3 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(3, "Prorata Shortcut Dim 3 Filter");
            end;
        }
        field(120; "Prorata Shortcut Dim 4 Filter"; Code[70])
        {
            //CaptionClass = '1,4,4,' + TextProrata;
            Caption = 'Prorata Shortcut Dim 4 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(4, "Prorata Shortcut Dim 4 Filter");
            end;
        }
        field(121; "Prorata Shortcut Dim 5 Filter"; Code[70])
        {
            //CaptionClass = '1,4,5,' + TextProrata;
            Caption = 'Prorata Shortcut Dim 5 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(5, "Prorata Shortcut Dim 5 Filter");
            end;
        }
        field(122; "Prorata Shortcut Dim 6 Filter"; Code[70])
        {
            //CaptionClass = '1,4,6,' + TextProrata;
            Caption = 'Prorata Shortcut Dim 6 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(6, "Prorata Shortcut Dim 6 Filter");
            end;
        }
        field(123; "Prorata Shortcut Dim 7 Filter"; Code[70])
        {
            //CaptionClass = '1,4,7,' + TextProrata;
            Caption = 'Prorata Shortcut Dim 7 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(7, "Prorata Shortcut Dim 7 Filter");
            end;
        }
        field(124; "Prorata Shortcut Dim 8 Filter"; Code[70])
        {
            //CaptionClass = '1,4,8,' + TextProrata;
            Caption = 'Prorata Shortcut Dim 8 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(8, "Prorata Shortcut Dim 8 Filter");
            end;
        }
        field(125; "Prorata Starting Date Calc."; DateFormula)
        {
            Caption = 'Prorata Starting Date Calculation Formula';
        }
        field(126; "Shortcut Dimension 3 Filter"; Code[70])
        {
            //CaptionClass = '1,4,3';
            Caption = 'Shortcut Dimension 3 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(3, "Shortcut Dimension 3 Filter");
            end;
        }
        field(127; "Shortcut Dimension 4 Filter"; Code[70])
        {
            //CaptionClass = '1,4,4';
            Caption = 'Shortcut Dimension 4 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(4, "Shortcut Dimension 4 Filter");
            end;
        }
        field(128; "Shortcut Dimension 5 Filter"; Code[70])
        {
            //CaptionClass = '1,4,5';
            Caption = 'Shortcut Dimension 5 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(5, "Shortcut Dimension 5 Filter");
            end;
        }
        field(129; "Shortcut Dimension 6 Filter"; Code[70])
        {
            //CaptionClass = '1,4,6';
            Caption = 'Shortcut Dimension 6 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(6, "Shortcut Dimension 6 Filter");
            end;
        }
        field(130; "Shortcut Dimension 7 Filter"; Code[70])
        {
            //CaptionClass = '1,4,7';
            Caption = 'Shortcut Dimension 7 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(7, "Shortcut Dimension 7 Filter");
            end;
        }
        field(131; "Shortcut Dimension 8 Filter"; Code[70])
        {
            //CaptionClass = '1,4,8';
            Caption = 'Shortcut Dimension 8 Filter';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(8, "Shortcut Dimension 8 Filter");
            end;
        }
        field(132; "Prorata Ending Date Calc."; DateFormula)
        {
            Caption = 'Prorata Ending Date Calc.';
        }
        field(140; "Additionnal Cost %"; Decimal)
        {
            Caption = 'Additionnal Cost %';
        }
    }

    keys
    {
        key(STG_Key1; "Rule Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DistributionKey.SetRange("Analytical Distribution Code", "Rule Code");
        if DistributionKey.Find('-') then
            DistributionKey.DeleteAll;
    end;

    trigger OnInsert()
    begin
        "Starting Date" := CalcDate('<-CY>', WorkDate);
        "Ending Date" := CalcDate('<+CY>', WorkDate);
    end;

    var
        GLAccount: Record "G/L Account";
        Job: Record Job;
        DistributionKey: Record "Analytical Distribution Key";
        TextKeyExist: label 'An analytical distribution key exists for rule %1. It will be deleted if you continue.';
        TextInterdiction: label '%1 must not be %2 in %3 %4.';
        DimMgt: Codeunit DimensionManagement;
        TextControl: label 'Old ,Control';
        TextOrigin: label 'Old ';
        TextDest: label 'New ';
        TextProrata: label 'Prorata ';


    procedure LookupShortcutDimCode(FieldNo: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNo, ShortcutDimCode);
    end;
}

