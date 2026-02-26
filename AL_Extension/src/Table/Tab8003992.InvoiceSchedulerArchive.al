Table 8003992 "Invoice Scheduler Archive"
{
    // //PROJET_FACT GESWAY 03/07/02 Nouvelle table (créée à partir table 37)

    Caption = 'Invoice Scheduler Archive';
    DataCaptionFields = "Sales Header Doc. No.";
    //DrillDownPageID = 8003981;
    //LookupPageID = 8003981;
    PasteIsValid = false;

    fields
    {
        field(11; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(91; "Sales Header Cur. Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(8003980; "Forecast Date"; Date)
        {
            Caption = 'Expected Date';
        }
        field(8003981; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(8003982; "Amount to Emit"; Decimal)
        {
            //blankzero = true;
            Caption = 'Amount to Emit';

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
            begin
            end;
        }
        field(8003983; "Amount Emitted"; Decimal)
        {
            //blankzero = true;
            Caption = 'Amount Emitted';
            Editable = false;
        }
        field(8003985; "Sales Header Doc. Type"; Option)
        {
            Caption = 'Document Type';
            InitValue = Invoice;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo";
        }
        field(8003986; "Sales Header Doc. No."; Code[20])
        {
            Caption = 'Scheduler Document No.';
        }
        field(8003988; "Progress Degree"; Code[10])
        {
            Caption = 'Progress Degree';
            TableRelation = "Document Progress Degree" where("Document Type" = const(Order));
        }
        field(8003990; "Document Percentage"; Decimal)
        {
            //blankzero = true;
            Caption = 'Document Percentage';
            MaxValue = 100;
            MinValue = 0;
        }
        field(8003992; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(8003993; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(8003994; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(8003995; Invoice; Boolean)
        {
            Caption = 'Chargeable';
        }
        field(8003996; "Amount to Emit (LCY)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Amount to Emit (LCY)';
            Editable = false;

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
            begin
            end;
        }
        field(8003997; "Amount Emitted (LCY)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Amount Emitted (DS)';
            Editable = false;
        }
        field(8003998; "Posted Doc. type"; Option)
        {
            Caption = 'Posted Document type';
            Editable = false;
            OptionCaption = 'Posted Sales Invoice,Posted Sales Cr. Memo';
            OptionMembers = Invoice,"Cr. Memo";
        }
        field(8003999; "Posted Doc. No."; Code[20])
        {
            Caption = 'Posted document No.';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Sales Header Doc. Type", "Sales Header Doc. No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        //GL2024    DocDim: Record 357;
        CapableToPromise: Codeunit "Capable to Promise";
    begin
    end;

    var
        Text1100280004: label 'You cannot modify %1 because a %2  exists.\You must delete %2  first.';
        Text1100282001: label 'The addition of the pourcentage must not be over 100.';
}

