Table 8004042 "NaviBat Sales Doc. Model"
{
    // //ETATS GESWAY 27/05/03 Table des options d'impression des devis
    //                17/06/03 Ajout champ "Totaling Field Identification"
    //                19/06/03 Ajout champs "Description Page Title","Interline","Include Title Page"
    //                14/08/03 Ajout champs "Send Quote To","Title Page Address 1","Title Page Address 2"
    //                12/09/03 Ajout champs "Free Field No. 1" à "Free Field No. 5"
    //                         Ajout champs "Free Field Caption 1" à "Free Field Caption 5"
    //                         Modif Date Type du champ "Totaling Field Reference" -> Option vers Integer
    //                         Ajout champs "Totaling Field Ref. Caption"
    //                10/10/03 Ajout champs "Free Field No. 1" à "Free Field No. 5"
    //                         Ajout champs "Free Field Caption 1" à "Free Field Caption 5"
    //                27/10/03 Ajout champ "Print Bill Of Quantities"
    //                05/02/04 Ajout champ "Print Job Address In Header"
    //                10/03/04 Ajout champ "Salutation Formula"
    //                26/07/04 Ajout Journal interaction, Archiver document
    //                06/01/06 Ajout "Print Appendix Page" utilisé dans les documents ventes enregistrés
    //                13/01/06 Ajout champ "Additionnal Page","Combine Previous Closing"
    // 
    // //+REF+ADDTEXT DL 04/10/05 Ajout champs "Print Header Text","Print Footer Text"
    // //TRANSLATION CW 11/10/05 OnDelete, OnRename

    Caption = 'NaviBat Sales Doc. Model';
    // DrillDownPageID = 8004041;
    //LookupPageID = 8004041;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "No. Of Copies"; Integer)
        {
            Caption = 'Nombre de copies';
        }
        field(3; "Print To Level"; Integer)
        {
            Caption = 'Print To Level';
        }
        field(4; "Print Prices"; Boolean)
        {
            Caption = 'Print Prices';
        }
        field(5; "Print Amount To Level"; Integer)
        {
            Caption = 'Print Amount To Level';
        }
        field(7; "Print BOM Detail"; Option)
        {
            Caption = 'Print BOM Detail';
            OptionCaption = 'None,Item,Resource,All,Printed';
            OptionMembers = "None",Item,Resource,All,Printed;
        }
        field(8; "Print Extended Text"; Boolean)
        {
            Caption = 'Print Extended Text';
        }
        field(9; "Print Line Comments"; Boolean)
        {
            Caption = 'Print Line Comments';
        }
        field(10; "Print Option Lines"; Boolean)
        {
            Caption = 'Print Option Lines';
        }
        field(11; "Print Job Cost Lines"; Boolean)
        {
            Caption = 'Print Job Cost Lines';
        }
        field(12; "Print Totaling Recapitulation"; Boolean)
        {
            Caption = 'Print Totaling Recapitulation';
        }
        field(13; "Reference Field No."; Integer)
        {
            Caption = 'Reference Field No.';
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Reference Field No.", FieldTable."No.");
            end;

            trigger OnValidate()
            begin
                GetFieldDescription("Reference Field No.", "Reference Field Caption");
            end;
        }
        field(15; Title; Text[50])
        {
            Caption = 'Title';
        }
        field(16; "Generate Line Space"; Boolean)
        {
            Caption = 'Generate Line Space';
        }
        field(17; "Include Description Page"; Boolean)
        {
            Caption = 'Include Description Page';
        }
        field(19; "Print Continued"; Boolean)
        {
            Caption = 'Print Continued';
        }
        field(20; "Using Pre-Printed"; Boolean)
        {
            Caption = 'Using Pre-Printed';
        }
        field(21; "Release Sales Document"; Boolean)
        {
            Caption = 'Release Document';

            trigger OnValidate()
            begin
                if "Release Sales Document" then
                    TestField("Status Control", "status control"::" ");
            end;
        }
        field(22; "Send Quote To"; Option)
        {
            Caption = 'Send Quote To';
            OptionCaption = 'Sell-to Customer No.,Project Manager,Job,Sell-to Contact No.';
            OptionMembers = "Sell-to Customer No.","Project Manager",Job,"Sell-to Contact No.";
        }
        field(23; "Title Page Address 1"; Option)
        {
            Caption = 'Title Page Address 1';
            OptionCaption = ' ,Sell-to Customer No.,Project Manager,Job';
            OptionMembers = " ","Sell-to Customer No.","Project Manager",Job;
        }
        field(24; "Title Page Address 2"; Option)
        {
            Caption = 'Title Page Address 2';
            OptionCaption = ' ,Sell-to Customer No.,Project Manager,Job';
            OptionMembers = " ","Sell-to Customer No.","Project Manager",Job;
        }
        field(25; "Free Field No. 1"; Integer)
        {
            Caption = 'Free Field No. 1';
            MinValue = 0;
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Free Field No. 1", FieldTable."No.");
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetFieldDescription("Free Field No. 1", "Free Field Caption 1");
                if "Same Than Line Presentation" then
                    Validate("BOM Detail Free Field No. 1", "Free Field No. 1");
            end;
        }
        field(26; "Free Field No. 2"; Integer)
        {
            Caption = 'Free Field No. 2';
            MinValue = 0;
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Free Field No. 2", FieldTable."No.");
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetFieldDescription("Free Field No. 2", "Free Field Caption 2");
                if "Same Than Line Presentation" then
                    Validate("BOM Detail Free Field No. 2", "Free Field No. 2");
            end;
        }
        field(27; "Free Field No. 3"; Integer)
        {
            Caption = 'Free Field No. 3';
            MinValue = 0;
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Free Field No. 3", FieldTable."No.");
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetFieldDescription("Free Field No. 3", "Free Field Caption 3");
                if "Same Than Line Presentation" then
                    Validate("BOM Detail Free Field No. 3", "Free Field No. 3");
            end;
        }
        field(28; "Free Field No. 4"; Integer)
        {
            Caption = 'Free Field No. 4';
            MinValue = 0;
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Free Field No. 4", FieldTable."No.");
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetFieldDescription("Free Field No. 4", "Free Field Caption 4");
                if "Same Than Line Presentation" then
                    Validate("BOM Detail Free Field No. 4", "Free Field No. 4");
            end;
        }
        field(29; "Free Field No. 5"; Integer)
        {
            Caption = 'Free Field No. 5';
            MinValue = 0;
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Free Field No. 5", FieldTable."No.");
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetFieldDescription("Free Field No. 5", "Free Field Caption 5");
                if "Same Than Line Presentation" then
                    Validate("BOM Detail Free Field No. 5", "Free Field No. 5");
            end;
        }
        field(30; "Free Field Caption 1"; Text[30])
        {
            Caption = 'Free Field Caption 1';
            FieldClass = Normal;
        }
        field(31; "Free Field Caption 2"; Text[30])
        {
            Caption = 'Free Field Caption 2';
            FieldClass = Normal;
        }
        field(32; "Free Field Caption 3"; Text[30])
        {
            Caption = 'Free Field Caption 3';
            FieldClass = Normal;
        }
        field(33; "Free Field Caption 4"; Text[30])
        {
            Caption = 'Free Field Caption 4';
            FieldClass = Normal;
        }
        field(34; "Free Field Caption 5"; Text[30])
        {
            Caption = 'Free Field Caption 5';
            FieldClass = Normal;
        }
        field(35; "Reference Field Caption"; Text[30])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = const(37),
                                                              "No." = field("Reference Field No.")));
            Caption = 'Ref. Field Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "BOM Detail Free Field No. 1"; Integer)
        {
            Caption = 'BOM Detail Free Field No. 1';
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("BOM Detail Free Field No. 1", FieldTable."No.");
            end;

            trigger OnValidate()
            begin
                GetFieldDescription("BOM Detail Free Field No. 1", "BOM Detail Free Field Capt. 1");
            end;
        }
        field(37; "BOM Detail Free Field No. 2"; Integer)
        {
            Caption = 'BOM Detail Free Field No. 2';
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("BOM Detail Free Field No. 2", FieldTable."No.");
            end;

            trigger OnValidate()
            begin
                GetFieldDescription("BOM Detail Free Field No. 2", "BOM Detail Free Field Capt. 2");
            end;
        }
        field(38; "BOM Detail Free Field No. 3"; Integer)
        {
            Caption = 'BOM Detail Free Field No. 3';
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("BOM Detail Free Field No. 3", FieldTable."No.");
            end;

            trigger OnValidate()
            begin
                GetFieldDescription("BOM Detail Free Field No. 3", "BOM Detail Free Field Capt. 3");
            end;
        }
        field(39; "BOM Detail Free Field No. 4"; Integer)
        {
            Caption = 'BOM Detail Free Field No. 4';
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("BOM Detail Free Field No. 4", FieldTable."No.");
            end;

            trigger OnValidate()
            begin
                GetFieldDescription("BOM Detail Free Field No. 4", "BOM Detail Free Field Capt. 4");
            end;
        }
        field(40; "BOM Detail Free Field No. 5"; Integer)
        {
            Caption = 'BOM Detail Free Field No. 5';
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("BOM Detail Free Field No. 5", FieldTable."No.");
            end;

            trigger OnValidate()
            begin
                GetFieldDescription("BOM Detail Free Field No. 5", "BOM Detail Free Field Capt. 5");
            end;
        }
        field(41; "BOM Detail Free Field Capt. 1"; Text[30])
        {
            Caption = 'BOM Detail Free Field Caption 1';
            Editable = false;
        }
        field(42; "BOM Detail Free Field Capt. 2"; Text[30])
        {
            Caption = 'BOM Detail Free Field Caption 2';
            Editable = false;
        }
        field(43; "BOM Detail Free Field Capt. 3"; Text[30])
        {
            Caption = 'BOM Detail Free Field Caption 3';
            Editable = false;
        }
        field(44; "BOM Detail Free Field Capt. 4"; Text[30])
        {
            Caption = 'BOM Detail Free Field Caption 4';
            Editable = false;
        }
        field(45; "BOM Detail Free Field Capt. 5"; Text[30])
        {
            Caption = 'BOM Detail Free Field Caption 5';
            Editable = false;
        }
        field(46; "Same Than Line Presentation"; Boolean)
        {
            Caption = 'Same Than Line Presentation';

            trigger OnValidate()
            begin
                if "Same Than Line Presentation" then begin
                    Validate("BOM Detail Free Field No. 1", "Free Field No. 1");
                    Validate("BOM Detail Free Field No. 2", "Free Field No. 2");
                    Validate("BOM Detail Free Field No. 3", "Free Field No. 3");
                    Validate("BOM Detail Free Field No. 4", "Free Field No. 4");
                end;
            end;
        }
        field(47; "Print Bill Of Quantities"; Boolean)
        {
            Caption = 'Print Bill Of Quantities';
        }
        field(48; "Print Sub-Total After Detail"; Boolean)
        {
            Caption = 'Print SubTotal After Detail';
        }
        field(49; "Header Free Field No. 1"; Text[30])
        {
            Caption = 'Header Free Field No. 1';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Header Free Field No. 1");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then begin
                //     Validate("Header Free Field No. 1", FieldSelection.GetResult);
                //     "Header Free Field Caption 1" := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen("Header Free Field Caption 1"));
                // end;
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 1", "Header Free Field Caption 1");
            end;
        }
        field(50; "Header Free Field No. 2"; Text[30])
        {
            Caption = 'Header Free Field No. 2';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Header Free Field No. 2");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then begin
                //     Validate("Header Free Field No. 2", FieldSelection.GetResult);
                //     "Header Free Field Caption 2" := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen("Header Free Field Caption 2"));
                // end;
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 2", "Header Free Field Caption 2");
            end;
        }
        field(51; "Header Free Field No. 3"; Text[30])
        {
            Caption = 'Header Free Field No. 3';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Header Free Field No. 3");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then begin
                //     Validate("Header Free Field No. 3", FieldSelection.GetResult);
                //     "Header Free Field Caption 3" := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen("Header Free Field Caption 3"));
                // end;
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 3", "Header Free Field Caption 3");
            end;
        }
        field(52; "Header Free Field No. 4"; Text[30])
        {
            Caption = 'Header Free Field No. 4';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Header Free Field No. 4");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then begin
                //     Validate("Header Free Field No. 4", FieldSelection.GetResult);
                //     "Header Free Field Caption 4" := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen("Header Free Field Caption 4"));
                // end;
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 4", "Header Free Field Caption 4");
            end;
        }
        field(53; "Header Free Field No. 5"; Text[30])
        {
            Caption = 'Header Free Field No. 5';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Header Free Field No. 5");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then begin
                //     Validate("Header Free Field No. 5", FieldSelection.GetResult);
                //     "Header Free Field Caption 5" := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen("Header Free Field Caption 5"));
                // end;
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 5", "Header Free Field Caption 5");
            end;
        }
        field(54; "Header Free Field Caption 1"; Text[30])
        {
            Caption = 'Header Free Field Caption 1';
        }
        field(55; "Header Free Field Caption 2"; Text[30])
        {
            Caption = 'Header Free Field Caption 2';
        }
        field(56; "Header Free Field Caption 3"; Text[30])
        {
            Caption = 'Header Free Field Caption 3';
        }
        field(57; "Header Free Field Caption 4"; Text[30])
        {
            Caption = 'Header Free Field Caption 4';
        }
        field(58; "Header Free Field Caption 5"; Text[30])
        {
            Caption = 'Header Free Field Caption 5';
        }
        field(59; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(60; "Job Address Text"; Text[30])
        {
            Caption = 'Job Address Text';
        }
        field(61; "Saluation Formula"; Option)
        {
            Caption = 'Use Saluation Formula';
            OptionCaption = ' ,Formal,Informal';
            OptionMembers = " ",Formal,Informal;
        }
        field(62; "Sub-Total Description"; Option)
        {
            Caption = 'Sub-Total Description';
            OptionCaption = 'No.,Description';
            OptionMembers = "No.",Description;
        }
        field(63; "Log Interaction"; Boolean)
        {
            Caption = 'Journal interaction';

            trigger OnValidate()
            begin
                if "Log Interaction" then
                    "Archive Document" := true;
            end;
        }
        field(64; "Archive Document"; Boolean)
        {
            Caption = 'Archiver document';

            trigger OnValidate()
            begin
                if not "Archive Document" then
                    "Log Interaction" := false;
            end;
        }
        field(65; "Unit Price Minus Discount"; Boolean)
        {
            Caption = 'Unit Price Minus Discount';
        }
        field(66; "Footer Free Field No. 1"; Text[30])
        {
            Caption = 'Footer Free Field No. 1';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Footer Free Field No. 1");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Footer Free Field No. 1", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Footer Free Field No. 1", "Footer Free Field Caption 1");
            end;
        }
        field(67; "Footer Free Field No. 2"; Text[30])
        {
            Caption = 'Footer Free Field No. 2';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Footer Free Field No. 2");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Footer Free Field No. 2", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Footer Free Field No. 2", "Footer Free Field Caption 2");
            end;
        }
        field(68; "Footer Free Field No. 3"; Text[30])
        {
            Caption = 'Footer Free Field No. 3';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Footer Free Field No. 3");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Footer Free Field No. 3", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Footer Free Field No. 3", "Footer Free Field Caption 3");
            end;
        }
        field(69; "Footer Free Field No. 4"; Text[30])
        {
            Caption = 'Footer Free Field No. 4';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Footer Free Field No. 4");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Footer Free Field No. 4", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Footer Free Field No. 4", "Footer Free Field Caption 4");
            end;
        }
        field(70; "Footer Free Field No. 5"; Text[30])
        {
            Caption = 'Footer Free Field No. 5';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Footer Free Field No. 5");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Footer Free Field No. 5", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Footer Free Field No. 1", "Footer Free Field Caption 1");
            end;
        }
        field(71; "Footer Free Field Caption 1"; Text[30])
        {
            Caption = 'Footer Free Field Caption 1';
        }
        field(72; "Footer Free Field Caption 2"; Text[30])
        {
            Caption = 'Footer Free Field Caption 2';
        }
        field(73; "Footer Free Field Caption 3"; Text[30])
        {
            Caption = 'Footer Free Field Caption 3';
        }
        field(74; "Footer Free Field Caption 4"; Text[30])
        {
            Caption = 'Footer Free Field Caption 4';
        }
        field(75; "Footer Free Field Caption 5"; Text[30])
        {
            Caption = 'Footer Free Field Caption 5';
        }
        field(78; "Print Appendix"; Option)
        {
            Caption = 'Print Appendix';
            OptionCaption = ' ,First copy,All copies';
            OptionMembers = " ","First copy","All copies";
        }
        field(79; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Sales Document,Posted Sales Document';
            OptionMembers = "Sales Document","Posted Sales Document";
        }
        field(80; "Print Cust. Address / Appendix"; Boolean)
        {
            Caption = 'Print Cust. Address / Appendix';
        }
        field(81; "First Odd Page"; Boolean)
        {
            Caption = 'First Odd Page';
        }
        field(82; "Conceal Line without Qty. to I"; Boolean)
        {
            Caption = 'Conceal Line without Qty. to Invoice';
        }
        field(83; "Print Scheduler"; Boolean)
        {
            Caption = 'Print Scheduler';
        }
        field(84; "Print Link Document"; Boolean)
        {
            Caption = 'Print Linked Document';
        }
        field(85; "Additionnal Page"; Option)
        {
            Caption = 'Additionnal Page';
            OptionCaption = 'Appendix Page,Recapitulation,Both,None';
            OptionMembers = "Appendix Page",Recapitulation,Both,"None";
        }
        field(86; "Hide Column Title"; Boolean)
        {
            Caption = 'Hide Title Line';
        }
        field(87; "Print Description 2"; Boolean)
        {
            Caption = 'Print Description 2';
        }
        field(88; "Print Header Comments"; Boolean)
        {
            Caption = 'Print Header Comments';
        }
        field(89; "Print Footer Comments"; Boolean)
        {
            Caption = 'Print Footer Comments';
        }
        field(90; "Combine Previous Closing"; Boolean)
        {
            Caption = 'Combine Previous Closing';
        }
        field(91; "Picture No."; Code[10])
        {
            Caption = 'Picture No.';
            TableRelation = "Header/Footer Logos"."No.";
        }
        field(92; "Print Completion"; Option)
        {
            Caption = 'Print Completion';
            OptionCaption = 'Pourcentage,Quantity';
            OptionMembers = Pourcentage,Quantity;
        }
        field(93; "Print Structure Amount"; Option)
        {
            Caption = 'Print Structure Amount';
            OptionCaption = 'First Line,Last Line';
            OptionMembers = "Première ligne","Dernière ligne";
        }
        field(94; City; Option)
        {
            Caption = 'City';
            OptionCaption = 'None,Company information,Responsibility centre"';
            OptionMembers = "None","Company information","Responsibility centre";
        }
        field(95; "Status Control"; Option)
        {
            Caption = 'Status Control';
            OptionCaption = ' ,Open,Released';
            OptionMembers = " ",Open,Released;

            trigger OnValidate()
            begin
                if "Status Control" > "status control"::" " then
                    TestField("Release Sales Document", false);
            end;
        }
        field(96; "Print Number of Version"; Boolean)
        {
            Caption = 'Print Number of Version';
        }
        field(100; "Header Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(8004042),
                                                                FieldID = const(100),
                                                                Code = field("No.")));
            Caption = 'Header Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(101; "Footer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(8004042),
                                                                FieldID = const(101),
                                                                Code = field("No.")));
            Caption = 'Footer Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "Appendix Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(8004042),
                                                                FieldID = const(102),
                                                                Code = field("No.")));
            Caption = 'Appendix Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(103; "Print Discount"; Option)
        {
            Caption = 'Print Discount';
            OptionCaption = 'Net Unit Price Line,Net Amount Line,Amount Footer,Amount and % Footer';
            OptionMembers = "Net Unit Price Line","Net Amount Line","Amount Footer","Amount and % Footer";
        }
    }

    keys
    {
        key(STG_Key1; "No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Document Type", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //TRANSLATION
        lRecordRef.GetTable(Rec);
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Free Field Caption 1"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Free Field Caption 2"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Free Field Caption 3"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Free Field Caption 4"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Free Field Caption 5"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Reference Field Caption"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 1"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 2"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 3"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 4"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 5"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 1"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 2"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 3"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 4"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("BOM Detail Free Field Capt. 1"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("BOM Detail Free Field Capt. 2"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("BOM Detail Free Field Capt. 3"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("BOM Detail Free Field Capt. 4"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("BOM Detail Free Field Capt. 5"), "No.");
        //TRANSLATION//
    end;

    trigger OnRename()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //TRANSLATION
        lRecordRef.GetTable(Rec);
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Free Field Caption 1"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Free Field Caption 2"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Free Field Caption 3"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Free Field Caption 4"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Free Field Caption 5"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Reference Field Caption"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 1"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 2"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 3"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 4"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 5"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 1"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 2"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 3"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 4"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("BOM Detail Free Field Capt. 1"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("BOM Detail Free Field Capt. 2"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("BOM Detail Free Field Capt. 3"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("BOM Detail Free Field Capt. 4"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("BOM Detail Free Field Capt. 5"), xRec."No.", "No.");
        //TRANSLATION
    end;

    var
        Text001: label 'You have entered an illegal value.';
        NavibatSetup: Record NavibatSetup;
        Criteria: Record "Code";
        /* //GL2024 License   "Table": Record "Object";
            HeaderTable: Record "Object";*///GL2024 License
                                           //GL2024 License
        "Table": Record AllObj;
        HeaderTable: Record AllObj;

        //GL2024 License

        FieldTable: Record "Field";
        RefFieldTable: Record "Field" temporary;
        TableNo: Integer;
        //DYS page addon non migrer
        //  FieldSelection: Page 8001437;
        TableFilter: Text[250];


    procedure InitTableList()
    begin
        TableFilter := '3|10|13|18|36|79|112|8004160|289|5050|5714';
        Table.SetRange("Object Type", Table."Object Type"::Table);
        HeaderTable.SetRange("Object Type", HeaderTable."Object Type"::Table);
        HeaderTable.SetFilter("Object id", TableFilter);
    end;


    procedure InitLineFieldList()
    var
        lFilter: Text[250];
    begin
        TableNo := Database::"Sales Line";
        RefFieldTable.DeleteAll;
        FieldTable.Reset;
        FieldTable.SetRange(TableNo, TableNo);
        FieldTable.SetFilter("No.", '%1|%2|%3|%4', 6, 47, 5705, 8004056);
        if FieldTable.Find('-') then
            repeat
                RefFieldTable := FieldTable;
                RefFieldTable.Insert;
            until FieldTable.Next = 0;

        FieldTable.Reset;
        FieldTable.SetRange(TableNo, TableNo);
        FieldTable.Find('-');
    end;


    procedure GetFieldDescription(pFieldNo: Integer; var pDescription: Text[30])
    begin
        InitLineFieldList;
        if pFieldNo > 0 then begin
            if not FieldTable.Get(TableNo, pFieldNo) then
                Error(Text001);
            pDescription := FieldTable."Field Caption";
        end else
            pDescription := '';
    end;


    procedure GetHeaderFieldCaption(var pText: Text[30]; var pCaption: Text[30])
    var
        i: Integer;
        lTableNo: Integer;
        lTableFieldNo: Integer;
        lRecordRef: RecordRef;
        lFieldRef: FieldRef;
        lSetupFieldNo: Integer;
    begin
        NavibatSetup.GET2;
        InitTableList;
        i := StrPos(pText, '.');
        if i > 0 then begin
            Evaluate(lTableNo, CopyStr(pText, 1, i - 1));
            Evaluate(lTableFieldNo, CopyStr(pText, i + 1));
        end else begin
            if not ((pText = '0') or (pText = '')) then
                Error(Text001);
            pText := '';
            pCaption := '';
            exit;
        end;

        if not isTableInFilter(lTableNo) then
            Error(Text001);
        if not FieldTable.Get(lTableNo, lTableFieldNo) then
            Error(Text001);
        if pCaption = '' then begin
            //DYS page addon non migrer
            // FieldSelection.InitRequest(pText);
            // pCaption := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen(pCaption));
        end;

        /*lRecordRef.GETTABLE(NavibatSetup);
        CASE lTableNo OF
          36: BEGIN
            CASE lTableFieldNo OF
              8003912:
                pCaption := NavibatSetup."Person Responsible Name 1";
              8003947..8004050: BEGIN
                lSetupFieldNo := lTableFieldNo - 31;
                lFieldRef := lRecordRef.FIELD(lSetupFieldNo);
                pCaption := lFieldRef.VALUE;
              END;
              8003956..8003965: BEGIN
                lSetupFieldNo := lTableFieldNo - 36;
                lFieldRef := lRecordRef.FIELD(lSetupFieldNo);
                pCaption := lFieldRef.VALUE;
              END;
            END;
          END;
        END; */
        HeaderTable.Reset;

    end;


    procedure isTableInFilter(pTableNo: Integer): Boolean
    begin
        if HeaderTable.Find('-') then
            repeat
                if HeaderTable."Object id" = pTableNo then
                    exit(true);
            until HeaderTable.Next = 0;
        exit(false);
    end;
}

