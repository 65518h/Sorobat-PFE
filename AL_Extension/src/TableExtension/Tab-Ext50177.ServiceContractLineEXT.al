TableExtension 50177 "Service Contract LineEXT" extends "Service Contract Line"
{
    fields
    {

        modify(Description)
        {
            Description = 'Navibat';
        }

        modify("Serial No.")
        {
            trigger OnAfterValidate()
            begin
                TESTFIELD("Service Item No.");
            end;
        }

        modify("Line Value")
        {
            //GL2024  currency.get(champs rec) impossible
            trigger OnAfterValidate()
            begin
                //SERVICE
                //VALIDATE("Line Discount %");
                TESTFIELD(Quantity);
                Currency.InitRoundingPrecision;
                VALIDATE("Unit Price", ROUND("Line Value" / Quantity, Currency."Unit-Amount Rounding Precision"));
                //SERVICE//
            end;
        }
        modify("Line Cost")
        {
            trigger OnAfterValidate()
            begin
                //SERVICE
                TESTFIELD(Quantity);
                VALIDATE("Unit Cost", ROUND("Line Cost" / Quantity, Currency."Unit-Amount Rounding Precision"));
                //SERVICE//
            end;
        }

        field(8003900; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'Modification TableRelation';
            TableRelation = Job where("Job Type" = const(External),
                                       "IC Partner Code" = const());

            trigger OnValidate()
            var
                lJob: Record Job;
                lJobStatus: Record "Job Status";
            begin
                //SERVICE//
                if "Job No." <> '' then begin
                    lJob.Get("Job No.");
                    lJob.wCheckBlockedJob("Job No.");
                    lJobStatus.Check("Job No.", lJobStatus.FieldNo("Sales Posting"));
                    Validate("Job Task No.", lJob.gGetDefaultJobTask());
                end;
                //SERVICE//
            end;
        }
        field(8003901; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(8003902; Quantity; Decimal)
        {
            //blankzero = true;
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                //SERVICE
                if Quantity < 0 then
                    FieldError(Quantity, TextPositif);

                "Line Value" := "Unit Price" * Quantity;
                Validate("Line Discount %");
                //SERVICE//
            end;
        }
        field(8003903; "Unit Price"; Decimal)
        {
            //blankzero = true;
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                //SERVICE
                Currency.InitRoundingPrecision;
                "Line Value" := ROUND("Unit Price" * Quantity, Currency."Amount Rounding Precision");
                Validate("Line Discount %");
                //SERVICE//
            end;
        }
        field(8003904; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            //blankzero = true;
            Caption = 'Unit Cost';

            trigger OnValidate()
            begin
                //SERVICE
                Currency.InitRoundingPrecision;
                "Line Cost" := ROUND("Unit Cost" * Quantity, Currency."Amount Rounding Precision");
                Profit := ROUND("Line Amount" - "Line Cost", Currency."Amount Rounding Precision");
                //SERVICE//
            end;
        }
    }


    var
        Text014: label '%1 exists for the %2 %3.\\You may need to create a credit memo.';
        TextPositif: label 'must be positive';
        Currency: Record Currency;
}

