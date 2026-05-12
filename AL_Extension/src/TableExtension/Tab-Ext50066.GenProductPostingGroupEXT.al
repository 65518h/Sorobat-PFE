TableExtension 50066 "Gen. Product Posting GroupEXT" extends "Gen. Product Posting Group"
{
    Caption = 'Gen. Product Posting Group';
    fields
    {
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {

        }
        field(50002; "Compte Vente"; Code[20])
        {
            Description = 'HJ SORO 26-09-2014';
            TableRelation = "G/L Account";
        }
        field(50003; "Compte Achat Paramétré"; Code[20])
        {
            CalcFormula = lookup("General Posting Setup"."Purch. Account" where("Gen. Prod. Posting Group" = field(Code)));
            Description = 'HJ SORO 26-09-2014';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Compte Vente Paramétré"; Code[20])
        {
            CalcFormula = lookup("General Posting Setup"."Sales Account" where("Gen. Prod. Posting Group" = field(Code)));
            Description = 'HJ SORO 26-09-2014';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; Eport; Boolean)
        {
            Description = 'RB SORO 12/03/2015';
        }
        field(50008; "Frequence Rotation"; DateFormula)
        {
            Description = 'RB SORO 16/04/2015';

            trigger OnValidate()
            begin
                //IF FORMAT("Frequence Rotation") <>'' THEN
            end;
        }
        field(50009; "Nbr Article Affecte"; Integer)
        {
            CalcFormula = count(item where("Gen. Prod. Posting Group" = field(Code)));
            caption = 'Nbr Article';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Global Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Global Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));
            ValidateTableRelation = false;
        }


        field(8001400; "Job Filter"; Code[20])
        {
            Caption = 'Job Filter';
            FieldClass = FlowFilter;
            TableRelation = Job;
        }
        field(8001401; Forecast; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Total Cost (LCY)" where("Job No." = field(filter("Job Totaling")),
                                                                            "Job Task No." = field("Job Task Filter"),
                                                                            "Gen. Prod. Posting Group" = field(Code),
                                                                            "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                            "Planning Date" = field(upperlimit("Date Filter")),
                                                                            "Entry Type" = const(Initial),
                                                                            "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                            "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Forecast';
            DecimalPlaces = 3 : 3;
            FieldClass = FlowField;
        }
        field(8001402; "Posted Net Change"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("Job No." = field(filter("Job Totaling")),
                                                                           "Job Task No." = field("Job Task Filter"),
                                                                           "Gen. Prod. Posting Group" = field(Code),
                                                                           "Entry Type" = const(Usage),
                                                                           "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                           "Work Type Code" = field("Work Type Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Bal. Created Entry" = const(false),
                                                                           "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                           "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Posted net change';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8001403; Engaged; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Purchase Line"."Engaged Cost (LCY)" where("Document Type" = const(Order),
                                                                          "Job No." = field(filter("Job Totaling")),
                                                                          "Job Task No." = field("Job Task Filter"),
                                                                          "Gen. Prod. Posting Group" = field(Code),
                                                                          "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                          "Work Type Code" = field("Work Type Filter"),
                                                                          "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter"),
                                                                          "Order Date" = field("Date Filter")));
            Caption = 'Engaged';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8001404; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Purchase Line"."Amt. Rcd. Not Invoiced (LCY)" where("Document Type" = const(Order),
                                                                                    "Job No." = field(filter("Job Totaling")),
                                                                                    "Job Task No." = field("Job Task Filter"),
                                                                                    "Gen. Prod. Posting Group" = field(Code),
                                                                                    "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                                    "Work Type Code" = field("Work Type Filter"),
                                                                                    "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                                    "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter"),
                                                                                    "Order Date" = field("Date Filter")));
            Caption = 'Amt. Rcd. Not Invoiced (LCY)';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8001405; "Default Type"; Option)
        {
            Caption = 'Default Type';
            OptionCaption = 'Resource,Item,G/L Account,Group (Resource)';
            OptionMembers = Resource,Item,"Account (G/L)","Group (Resource)";
        }
        field(8001406; "Person Forecast (Qty)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Quantity (Base)" where("Job No." = field(filter("Job Totaling")),
                                                                           "Job Task No." = field("Job Task Filter"),
                                                                           "Gen. Prod. Posting Group" = field(Code),
                                                                           Type = const(Resource),
                                                                           "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                           "Resource Type" = const(Person),
                                                                           "Planning Date" = field(upperlimit("Date Filter")),
                                                                           "Entry Type" = const(Initial),
                                                                           "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                           "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Person Forecast (Qty)';
            FieldClass = FlowField;
        }
        field(8001407; "Person Posted (Qty)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry".Quantity where("Job No." = field(filter("Job Totaling")),
                                                                 "Job Task No." = field("Job Task Filter"),
                                                                 "Gen. Prod. Posting Group" = field(Code),
                                                                 "Entry Type" = const(Usage),
                                                                 Type = const(Resource),
                                                                 "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                 "Resource Type" = const(Person),
                                                                 "Work Type Code" = field("Work Type Filter"),
                                                                 "Posting Date" = field("Date Filter"),
                                                                 "Work Time Type" = filter("Producted Hours" | "Unproduced Hours" | "Absence Hours"),
                                                                 "Bal. Created Entry" = const(false),
                                                                 "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                 "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Person Posted (Qty)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8001408; "Audit Forecast"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Total Cost (LCY)" where("Job No." = field(filter("Job Totaling")),
                                                                            "Job Task No." = field("Job Task Filter"),
                                                                            "Gen. Prod. Posting Group" = field(Code),
                                                                            "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                            "Planning Date" = field(upperlimit("Date Filter")),
                                                                            "Entry Type" = filter(Initial .. Audit),
                                                                            "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                            "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Audit Forecast';
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(8001409; "Audit Person Forecast (Qty)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Quantity (Base)" where("Job No." = field(filter("Job Totaling")),
                                                                           "Job Task No." = field("Job Task Filter"),
                                                                           "Gen. Prod. Posting Group" = field(Code),
                                                                           Type = const(Resource),
                                                                           "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                           "Resource Type" = const(Person),
                                                                           "Planning Date" = field(upperlimit("Date Filter")),
                                                                           "Entry Type" = filter(Initial .. Audit),
                                                                           "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                           "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Audit Person Forecast (Qty)';
            FieldClass = FlowField;
        }
        field(8001410; "Bal. Amount"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("Job No." = field(filter("Job Totaling")),
                                                                           "Job Task No." = field("Job Task Filter"),
                                                                           "Gen. Prod. Posting Group" = field(Code),
                                                                           "Entry Type" = const(Usage),
                                                                           "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                           "Work Type Code" = field("Work Type Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Bal. Created Entry" = const(true),
                                                                           "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                           "Global Dimension 2 Code" = field("Global Dim. 2 Filter"),
                                                                           "Sales Document No." = field("Document No. Filter")));
            Caption = 'Posted';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8001412; "Posted at Date"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("Job No." = field(filter("Job Totaling")),
                                                                           "Job Task No." = field("Job Task Filter"),
                                                                           "Gen. Prod. Posting Group" = field(Code),
                                                                           "Entry Type" = const(Usage),
                                                                           "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                           "Work Type Code" = field("Work Type Filter"),
                                                                           "Posting Date" = field(upperlimit("Date Filter")),
                                                                           "Bal. Created Entry" = const(false),
                                                                           "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                           "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Posted at Date';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003900; "Bal. Job No."; Code[20])
        {
            Caption = 'Bal. Job No.';
            TableRelation = Job where("Search Description" = filter('*'));

            trigger OnValidate()
            var
                lJob: Record Job;
            begin
                //PROJET_CESSION
                if "Bal. Job No." <> '' then begin
                    lJob.Get("Bal. Job No.");
                    lJob.TestField(Status, lJob.Status::Open);
                end;
                //PROJET_CESSION//
            end;
        }
        field(8003901; Summarize; Boolean)
        {
            Caption = 'Total';

            trigger OnValidate()
            begin
                if not Summarize then
                    Totaling := ''
                else
                    if (Code = wGetTotalingCode) or (Code = '') then
                        Validate(Totaling, '..' + wGetTotalingChar)
                    else
                        Validate(Totaling, Code + ' ..' + Code + wGetTotalingChar);
            end;
        }
        field(8003902; Totaling; Text[100])
        {
            Caption = 'Totaling';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Summarize, true);
            end;
        }
        field(8003903; Indentation; Integer)
        {
            Caption = 'Indentation';
        }
        field(8003904; "Job Task Filter"; Code[20])
        {
            Caption = 'Job Task Filter';
            FieldClass = FlowFilter;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job Filter"));
        }
        field(8003906; "Work Type Filter"; Code[10])
        {
            Caption = 'Work Type Filter';
            FieldClass = FlowFilter;
            TableRelation = "Work Type";
        }
        field(8003907; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(8003908; "Initial Gross Total Cost"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Gross Total Cost" where("Job No." = field(filter("Job Totaling")),
                                                                            "Job Task No." = field("Job Task Filter"),
                                                                            "Planning Date" = field(upperlimit("Date Filter")),
                                                                            "Gen. Prod. Posting Group" = field(Code),
                                                                            "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                            "Entry Type" = filter(Initial),
                                                                            "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                            "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Initial Gross Total Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003909; "Posted Overhead Amount"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry"."Overhead Amount" where("Job No." = field(filter("Job Totaling")),
                                                                          "Job Task No." = field("Job Task Filter"),
                                                                          "Work Type Code" = field("Work Type Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Gen. Prod. Posting Group" = field(Code),
                                                                          "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                          "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                          "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Forecast Overhead Amount';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003910; "Job Totaling"; Code[50])
        {
            Caption = 'Job Totaling';
            FieldClass = FlowFilter;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Summarize, true);
            end;
        }
        field(8003911; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = ' ,Usage,Sale';
            OptionMembers = " ",Usage,Sale;
        }
        field(8003913; "Person Planned (Qty)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Quantity (Base)" where("Job No." = field(filter("Job Totaling")),
                                                                           "Job Task No." = field("Job Task Filter"),
                                                                           "Gen. Prod. Posting Group" = field(Code),
                                                                           Type = const(Resource),
                                                                           "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                           "Resource Type" = const(Person),
                                                                           "Planning Date" = field("Date Filter"),
                                                                           "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                           "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Person Planned (Qty)';
            FieldClass = FlowField;
        }
        field(8003914; "Audit Gross Total Cost"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Gross Total Cost" where("Job No." = field(filter("Job Totaling")),
                                                                            "Job Task No." = field("Job Task Filter"),
                                                                            "Planning Date" = field(upperlimit("Date Filter")),
                                                                            "Gen. Prod. Posting Group" = field(Code),
                                                                            "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                            "Entry Type" = filter(Initial .. Audit),
                                                                            "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                            "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Audit Gross Total Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003915; "Posted Amount"; Decimal)
        {
            BlankZero = true;
            CalcFormula = - sum("Job Ledger Entry"."Line Amount (LCY)" where("Job No." = field(filter("Job Totaling")),
                                                                             "Job Task No." = field("Job Task Filter"),
                                                                             "Gen. Prod. Posting Group" = field(Code),
                                                                             "Entry Type" = const(Sale),
                                                                             "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                             "Work Type Code" = field("Work Type Filter"),
                                                                             "Posting Date" = field("Date Filter"),
                                                                             "Bal. Created Entry" = const(false),
                                                                             "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                             "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Posted Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003916; "Ordered Invoiced (LCY)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Purch. Inv. Line"."Amount Ordered (LCY)" where("Job No." = field(filter("Job Totaling")),
                                                                               "Job Task No." = field("Job Task Filter"),
                                                                               "Gen. Prod. Posting Group" = field(Code),
                                                                               "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                               "Work Type Code" = field("Work Type Filter"),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Ordered Invoiced (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003917; "Ordered Not Invoiced (LCY)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Purchase Line"."Ordered Not Invoiced (LCY)" where("Job No." = field(filter("Job Totaling")),
                                                                                  "Job Task No." = field("Job Task Filter"),
                                                                                  "Gen. Prod. Posting Group" = field(Code),
                                                                                  "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                                  "Work Type Code" = field("Work Type Filter"),
                                                                                  "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                                  "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Ordered Not Invoiced (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003918; "Global Dim. 1 Filter"; Code[10])
        {
            //CaptionClass = '1,2,1';
            Caption = 'Filtre axe 1';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(8003919; "Global Dim. 2 Filter"; Code[10])
        {
            //CaptionClass = '1,2,2';
            Caption = 'Filtre axe 2';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(8004048; "Prepayment Amount"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Prepmt. Line Amount" where("Gen. Prod. Posting Group" = field(Code),
                                                                        "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                        "Job No." = field(filter("Job Totaling")),
                                                                        "Job Task No." = field("Job Task Filter"),
                                                                        "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                        "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Prepmt. Line Amount';
            FieldClass = FlowField;
        }
        field(8004049; "Prepmt. Amt. Inv."; Decimal)
        {
            CalcFormula = sum("Sales Line"."Prepmt. Amt. Inv." where("Gen. Prod. Posting Group" = field(Code),
                                                                      "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                      "Job No." = field(filter("Job Totaling")),
                                                                      "Job Task No." = field("Job Task Filter"),
                                                                      "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                      "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Prepmt. Amt. Inv.';
            FieldClass = FlowField;
        }
        field(8004050; "Document Type Filter"; Option)
        {
            Caption = 'Document Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8004051; "Document No. Filter"; Code[20])
        {
            Caption = 'Document No. Filter';
            FieldClass = FlowFilter;
            TableRelation = "Sales Line"."Document No." where("Document Type" = field("Document Type Filter"));
        }
        field(8004052; "Document Line No. Filter"; Integer)
        {
            Caption = 'Document Line No. Filter';
            FieldClass = FlowFilter;
            TableRelation = "Sales Line"."Document No." where("Document Type" = field("Document Type Filter"),
                                                               "Document No." = field("Document No. Filter"));
        }
        field(8004053; "Direct Cost"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Sales Line"."Total Cost (LCY)" where("Document Type" = field("Document Type Filter"),
                                                                     "Document No." = field("Document No. Filter"),
                                                                     "Structure Line No." = field("Document Line No. Filter"),
                                                                     "Gen. Prod. Posting Group" = field(Code),
                                                                     "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                     "Line Type" = filter(<> Structure & > Totaling),
                                                                     "Assignment Basis" = field("Assgnt Basis Filter"),
                                                                     "Presentation Code" = field("Presentation Code Filter"),
                                                                     Disable = const(false),
                                                                     Option = const(false),
                                                                     "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                     "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Direct Cost';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004054; Overhead; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Sales Line"."Overhead Amount (LCY)" where("Document Type" = field("Document Type Filter"),
                                                                          "Document No." = field("Document No. Filter"),
                                                                          "Structure Line No." = field("Document Line No. Filter"),
                                                                          "Gen. Prod. Posting Group" = field(Code),
                                                                          "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                          "Line Type" = filter(<> Structure & > Totaling),
                                                                          "Presentation Code" = field("Presentation Code Filter"),
                                                                          Disable = const(false),
                                                                          Option = const(false),
                                                                          "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Overhead';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004055; "Total Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Sales Line"."Amount Excl. VAT (LCY)" where("Document Type" = field("Document Type Filter"),
                                                                           "Document No." = field("Document No. Filter"),
                                                                           "Structure Line No." = const(0),
                                                                           "Gen. Prod. Posting Group" = field(Code),
                                                                           "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                           "Line Type" = filter(> Totaling),
                                                                           Disable = const(false),
                                                                           Option = const(false),
                                                                           "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                           "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter"),
                                                                           "Assignment Basis" = const(" ")));
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004056; "Job Costs"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Sales Line"."Job Costs (LCY)" where("Document Type" = field("Document Type Filter"),
                                                                    "Document No." = field("Document No. Filter"),
                                                                    "Structure Line No." = field("Document Line No. Filter"),
                                                                    "Gen. Prod. Posting Group" = field(Code),
                                                                    "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                    "Line Type" = filter(> Totaling),
                                                                    "Assignment Basis" = const(" "),
                                                                    Disable = const(false),
                                                                    Option = const(false),
                                                                    "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                    "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Job Costs';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004057; "Overhead Rate"; Decimal)
        {
            BlankZero = true;
            //CaptionClass = fGetCaption(8004057, true);
            Caption = 'Overhead Rate';
            DecimalPlaces = 0 : 3;
            Description = 'Pour saisie';
        }
        field(8004058; "Margin Rate"; Decimal)
        {
            BlankZero = true;
            //CaptionClass = fGetCaption(8004058, true);
            Caption = 'Margin Rate';
            DecimalPlaces = 0 : 3;
            Description = 'Pour saisie';
        }
        field(8004059; "Person Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            BlankZero = true;
            Caption = 'Person Unit Cost';
            Description = 'Pour saisie';
        }
        field(8004060; "Person Qty"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Sales Line"."Quantity (Base)" where("Document Type" = field("Document Type Filter"),
                                                                    "Document No." = field("Document No. Filter"),
                                                                    "Line Type" = const(Person),
                                                                    "Gen. Prod. Posting Group" = field(Code),
                                                                    "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                    "Structure Line No." = field("Document Line No. Filter"),
                                                                    "Presentation Code" = field("Presentation Code Filter"),
                                                                    Disable = const(false),
                                                                    Option = const(false),
                                                                    "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                    "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Person Qty';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004061; "Direct Cost Archive"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Sales Line Archive"."Total Cost (LCY)" where("Document Type" = field("Document Type Filter"),
                                                                             "Document No." = field("Document No. Filter"),
                                                                             "Structure Line No." = field("Document Line No. Filter"),
                                                                             "Version No." = field("Document Version No. Filter"),
                                                                             "Doc. No. Occurrence" = field("Document Occ. No. Filter"),
                                                                             "Gen. Prod. Posting Group" = field(Code),
                                                                             "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                             Quantity = filter(<> 0),
                                                                             "Line Type" = filter(<> Structure),
                                                                             "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Direct Cost Archive';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004062; "Overhead Archive"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Sales Line Archive"."Overhead Amount (LCY)" where("Document Type" = field("Document Type Filter"),
                                                                                  "Document No." = field("Document No. Filter"),
                                                                                  "Structure Line No." = field("Document Line No. Filter"),
                                                                                  "Version No." = field("Document Version No. Filter"),
                                                                                  "Doc. No. Occurrence" = field("Document Occ. No. Filter"),
                                                                                  "Gen. Prod. Posting Group" = field(Code),
                                                                                  "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                                  Quantity = filter(<> 0),
                                                                                  "Line Type" = filter(<> Structure),
                                                                                  "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                                  "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Overhead Archive';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004063; "Total Amount Archive"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Sales Line Archive"."Amount Excl. VAT (LCY)" where("Document Type" = field("Document Type Filter"),
                                                                                   "Document No." = field("Document No. Filter"),
                                                                                   "Version No." = field("Document Version No. Filter"),
                                                                                   "Doc. No. Occurrence" = field("Document Occ. No. Filter"),
                                                                                   "Structure Line No." = const(0),
                                                                                   "Gen. Prod. Posting Group" = field(Code),
                                                                                   "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                                   Quantity = filter(<> 0),
                                                                                   "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                                   "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Total Amount Archive';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004064; "Job Costs Archive"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Sales Line Archive"."Job Costs (LCY)" where("Document Type" = field("Document Type Filter"),
                                                                            "Document No." = field("Document No. Filter"),
                                                                            "Version No." = field("Document Version No. Filter"),
                                                                            "Doc. No. Occurrence" = field("Document Occ. No. Filter"),
                                                                            "Line No." = field("Document Line No. Filter"),
                                                                            "Structure Line No." = const(0),
                                                                            "Gen. Prod. Posting Group" = field(Code),
                                                                            "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                            Quantity = filter(<> 0),
                                                                            "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                            "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Job Costs Archive';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004065; "Person Qty Archive"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Sales Line Archive"."Quantity (Base)" where("Document Type" = field("Document Type Filter"),
                                                                            "Document No." = field("Document No. Filter"),
                                                                            "Version No." = field("Document Version No. Filter"),
                                                                            "Doc. No. Occurrence" = field("Document Occ. No. Filter"),
                                                                            "Line Type" = const(Person),
                                                                            "Gen. Prod. Posting Group" = field(Code),
                                                                            "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                            "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                            "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Person Qty Archive';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004066; "Document Version No. Filter"; Integer)
        {
            Caption = 'Document Version No. Filter';
            FieldClass = FlowFilter;
        }
        field(8004067; "Document Occ. No. Filter"; Integer)
        {
            Caption = 'Document Occ. No. Filter';
            FieldClass = FlowFilter;
        }
        field(8004068; "New Cost Forecast"; Decimal)
        {
            BlankZero = true;
            Caption = 'Rest To Be Engaged';
            DecimalPlaces = 0 : 0;
            Description = 'Pour saisie';
        }
        field(8004069; "New Rest To Be Engaged"; Decimal)
        {
            BlankZero = true;
            Caption = 'New Rest To Be Engaged %';
            DecimalPlaces = 0 : 0;
            Description = 'Pour saisie';
        }
        field(8004070; "Cost Forecast"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Total Cost (LCY)" where("Job No." = field(filter("Job Totaling")),
                                                                            "Job Task No." = field("Job Task Filter"),
                                                                            "Gen. Prod. Posting Group" = field(Code),
                                                                            "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                            "Planning Date" = field(upperlimit("Date Filter")),
                                                                            "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                            "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Cost Forecast';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004071; "Theoretical Profit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Sales Line"."Theoretical Profit Amount(LCY)" where("Document Type" = field("Document Type Filter"),
                                                                                   "Document No." = field("Document No. Filter"),
                                                                                   "Structure Line No." = field("Document Line No. Filter"),
                                                                                   "Gen. Prod. Posting Group" = field(Code),
                                                                                   "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                                   "Line Type" = field("Filter Line Type"),
                                                                                   "Presentation Code" = field("Presentation Code Filter"),
                                                                                   Disable = const(false),
                                                                                   Option = const(false),
                                                                                   "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                                   "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Theoretical Profit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004072; "Filter Line Type"; Option)
        {
            Caption = 'Filter Line Type';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Totaling,Item,Person,Machine,Structure,G/L Account';
            OptionMembers = " ",Totaling,Item,Person,Machine,Structure,"G/L Account";
        }
        field(8004073; "New Budget Difference"; Decimal)
        {
            BlankZero = true;
            Caption = 'New Budget Difference';
            DecimalPlaces = 0 : 0;
            Description = 'Pour saisie';
        }
        field(8004074; "Initial Price Forecast"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Line Amount (LCY)" where("Job No." = field(filter("Job Totaling")),
                                                                             "Job Task No." = field("Job Task Filter"),
                                                                             "Gen. Prod. Posting Group" = field(Code),
                                                                             "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                             "Planning Date" = field(upperlimit("Date Filter")),
                                                                             "Entry Type" = filter(Initial),
                                                                             "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                             "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Initial Price Forecast';
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(8004075; "Audit Price Forecast"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Line Amount (LCY)" where("Job No." = field(filter("Job Totaling")),
                                                                             "Job Task No." = field("Job Task Filter"),
                                                                             "Gen. Prod. Posting Group" = field(Code),
                                                                             "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                             "Planning Date" = field(upperlimit("Date Filter")),
                                                                             "Entry Type" = filter(Initial .. Audit),
                                                                             "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                             "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Audit Price Forecast';
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(8004083; "Rule Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rule Rate';
            Description = 'Pour affichage';
        }
        field(8004084; "Rule Margin Rate"; Decimal)
        {
            Caption = 'Margin Rule Rate';
            Description = 'Pour affichage';
        }
        field(8004085; "Overhead Calculation Method"; Option)
        {
            Caption = 'Overhead Calculation Method';
            Description = 'Pour affichage';
            OptionCaption = 'Amount %,Person Quantity';
            OptionMembers = "Amount %","Person Quantity";
        }
        field(8004086; "Margin Calculation Method"; Option)
        {
            Caption = 'Margin Calculation Method';
            Description = 'Pour affichage';
            OptionCaption = 'Amount %,Quantity';
            OptionMembers = "Amount %",Quantity;
        }
        field(8004087; "Advanced Budget Cost"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Advanced Job Budget Entry".Cost where("Job No." = field(filter("Job Totaling")),
                                                                      "Job Task No." = field("Job Task Filter"),
                                                                      "Gen. Prod. Posting Group" = field(Code),
                                                                      "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                      Date = field(upperlimit("Date Filter")),
                                                                      "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                      "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Advanced Forecast Cost';
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(8004088; "Advanced Person Budget (Qty)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Advanced Job Budget Entry".Quantity where("Job No." = field(filter("Job Totaling")),
                                                                          "Job Task No." = field("Job Task Filter"),
                                                                          "Gen. Prod. Posting Group" = field(Code),
                                                                          "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                          Date = field("Date Filter"),
                                                                          "Line Type" = const(Person),
                                                                          "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                          "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Advanced Person Forecast (Qty)';
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(8004089; "Posted Cost"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("Entry Type" = const(Usage),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Work Type Code" = field("Work Type Filter"),
                                                                           "Gen. Prod. Posting Group" = field(Code),
                                                                           "Bal. Created Entry" = const(false),
                                                                           "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                           "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                           "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Posted Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004090; "Posted Cost Person"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("Entry Type" = const(Usage),
                                                                           "Gen. Prod. Posting Group" = field(Code),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Gen. Bus. Posting Group" = field(filter(Totaling)),
                                                                           Type = const(Resource),
                                                                           "Resource Type" = const(Person),
                                                                           "Work Type Code" = field("Work Type Filter"),
                                                                           "Work Time Type" = filter("Producted Hours" | "Unproduced Hours" | "Absence Hours"),
                                                                           "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                           "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Posted Cost Person';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004091; "Planned Cost Person"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Total Cost (LCY)" where("Gen. Prod. Posting Group" = field(Code),
                                                                            "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                            Type = const(Resource),
                                                                            "Resource Type" = const(Person),
                                                                            "Planning Date" = field("Date Filter"),
                                                                            "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                            "Global Dimension 2 Code" = field("Global Dim. 2 Filter")));
            Caption = 'Planned Cost Person';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004092; "Forecast Price"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Line Amount (LCY)" where("Gen. Prod. Posting Group" = field(Code),
                                                                             "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                             "Planning Date" = field(upperlimit("Date Filter")),
                                                                             "Global Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                             "Global Dimension 2 Code" = field("Global Dim. 2 Filter"),
                                                                             "Job No." = field("Job Filter"),
                                                                             "Job Task No." = field("Job Task Filter")));
            Caption = 'Budgeted Price';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004131; "Resource Type"; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Person,Machine';
            OptionMembers = " ",Person,Machine;
        }
        field(8004132; "Work Type Default"; Code[10])
        {
            Caption = 'Work Type Filter';
            FieldClass = Normal;
            TableRelation = "Work Type";
        }
        field(8004133; "Assgnt Basis Filter"; Option)
        {
            Caption = 'Assignment Basis Filter';
            FieldClass = FlowFilter;
            OptionMembers = " ","Person Quantity","Direct Cost","Cost Price","Estimated Price",Specific;
        }
        field(8004134; "Presentation Code Filter"; Text[80])
        {
            Caption = 'Presentation Code Filter';
            FieldClass = FlowFilter;
        }
        field(8004135; "Plan Quantity (unrealized)"; Decimal)
        {
            CalcFormula = sum("Planning Entry".Quantity where(Status = filter(<> Deleted),
                                                               "Prod. Posting Group" = field(Code),
                                                               "Prod. Posting Group" = field(filter(Totaling)),
                                                               Date = field(upperlimit("Date Filter")),
                                                               "Job No." = field(filter("Job Totaling")),
                                                               "Job Task No." = field("Job Task Filter")));
            Caption = 'Plan Quantity (unrealized)';
            Description = '+PLA+';
            FieldClass = FlowField;
        }
        field(8004136; "Amt.Rcd. Not Inv.Excl. VAT LCY"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Amt.Rcd. Not Inv.Excl. VAT LCY" where("Document Type" = const(Order),
                                                                                      "Job No." = field(filter("Job Totaling")),
                                                                                      "Job Task No." = field("Job Task Filter"),
                                                                                      "Gen. Prod. Posting Group" = field(Code),
                                                                                      "Gen. Prod. Posting Group" = field(filter(Totaling)),
                                                                                      "Work Type Code" = field("Work Type Filter"),
                                                                                      "Shortcut Dimension 1 Code" = field("Global Dim. 1 Filter"),
                                                                                      "Shortcut Dimension 2 Code" = field("Global Dim. 2 Filter"),
                                                                                      "Order Date" = field("Date Filter")));
            Caption = 'Amt. Rcd. Not Invoiced Excl. VAT (LCY)';
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(STG_Key2; Synchronise)
        {
        }
    }

    procedure wCheckBalJob(pGenProduct: Code[10])
    var
        lGenProductPostGr: Record "Gen. Product Posting Group";
    begin
        lGenProductPostGr.Get(pGenProduct);
        lGenProductPostGr.TestField("Bal. Job No.");
    end;

    procedure wGetTotalingCode(): Code[10]
    var
        lNavibatSetup: Record NavibatSetup;
    begin
        if lNavibatSetup.GET2 then
            exit(lNavibatSetup."Tot. Gen. Prod. Posting Group");
    end;

    procedure wGetTotalingChar(): Code[1]
    var
        lNavibatSetup: Record NavibatSetup;
    begin
        if lNavibatSetup.GET2 then
            exit(lNavibatSetup."Totalisation Character");
    end;

    procedure wMarginCalculation(pCost: Decimal; pPrice: Decimal): Decimal
    begin
        exit(pPrice - pCost)
    end;

    procedure fGetCaption(pFieldNumber: Integer; pAutomate: Boolean) return: Text[250]
    var
        lNavibatsetup: Record NavibatSetup;
        lTextOverheadRate: label 'Overhead Rate';
        lTextMarginRate: label 'Margin Rate';
        lTextOverheadCoef: label 'Overhead Coefficient';
        lTextMarginCoef: label 'Margin Coefficient';
    begin
        //#6691
        lNavibatsetup.Get();
        case (pFieldNumber) of
            FieldNo("Overhead Rate"):
                begin
                    if (lNavibatsetup."Overhead Value Option" = lNavibatsetup."overhead value option"::Coefficient) then begin
                        return := lTextOverheadCoef;
                    end else begin
                        return := lTextOverheadRate;
                    end;
                end;
            FieldNo("Margin Rate"):
                begin
                    if (lNavibatsetup."Margin Value Option" = lNavibatsetup."margin value option"::Coefficient) then begin
                        return := lTextMarginCoef;
                    end else begin
                        return := lTextMarginRate;
                    end;
                end;
        end;
        if (pAutomate) then
            return := '1,5,,' + return;
        //#6691//
    end;
}

