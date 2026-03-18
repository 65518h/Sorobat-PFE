Table 8003948 "Estimated invoicing"
{
    // //REPARTITON GESWAY 05/07/05 Prévision de facturation

    Caption = 'Estimated invoicing';
    // DrillDownPageID = 8003976;
    // LookupPageID = 8003976;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(3; "Doc. Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(4; "Doc. No."; Code[20])
        {
            Caption = 'Doc. No.';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Doc. Type"));
        }
        field(5; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(6; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(8; User; Code[20])
        {
            Caption = 'User';
        }
        field(9; "Date / Time modification"; DateTime)
        {
            Caption = 'Date / Time modification';
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Job No.", "Doc. Type", "Doc. No.", "Gen. Prod. Posting Group", "Posting Date")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lEst: Record "Estimated invoicing";
    begin
        if "Entry No." = 0 then begin
            if lEst.Find('+') then
                "Entry No." := lEst."Entry No." + 1
            else
                "Entry No." := 1;
        end;
        User := UserId;
        "Date / Time modification" := CurrentDatetime;
    end;
}

