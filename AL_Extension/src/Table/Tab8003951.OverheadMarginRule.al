Table 8003951 "Overhead-Margin Rule"
{
    // //PROJET_FG GESWAY 25/07/02 Nouvelle table des lois Frais généraux et marge

    Caption = 'Overhead - Margin Rule Card';
    // LookupPageID = 8003965;

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Overhead,Margin';
            OptionMembers = Overhead,Margin;
        }
        field(2; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Product Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(6; Value; Decimal)
        {
            Caption = 'Value';
            DecimalPlaces = 2 : 3;
        }
        field(7; "Application Order"; Integer)
        {
            Caption = 'Application Order';
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(9; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(10; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(11; "Calculation Method"; Option)
        {
            Caption = 'Calculation Method';
            OptionCaption = 'Amount %,Person Quantity';
            OptionMembers = "Amount %","Person Quantity";
        }
    }

    keys
    {
        key(Key1; Type, "Responsibility Center", "Gen. Prod. Posting Group", "Customer Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
            Clustered = true;
        }
        key(Key2; Type, "Application Order")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        MakeOrder;
    end;

    trigger OnRename()
    begin
        MakeOrder;
    end;


    procedure MakeOrder()
    begin
        /*
        IF "Responsibility Center" <> '' THEN BEGIN
          IF "Gen. Prod. Posting Group" <> '' THEN
            "Application Order" := 1
          ELSE
            "Application Order" := 2;
        END ELSE BEGIN
        //  IF "Job Posting Group" <> '' THEN BEGIN
        //    IF "Gen. Prod. Posting Group" <> '' THEN
        //      "Application Order" := 3
        //    ELSE
        //      "Application Order" := 4;
        //  END ELSE BEGIN
          IF "Global Dimension 1 Code" <> '' THEN BEGIN
            IF "Gen. Prod. Posting Group" <> '' THEN
              "Application Order" := 5
            ELSE
              "Application Order" := 6;
          END ELSE BEGIN
            IF "Global Dimension 2 Code" <> '' THEN BEGIN
              IF "Gen. Prod. Posting Group" <> '' THEN
                "Application Order" := 7
              ELSE
                "Application Order" := 8;
            END ELSE BEGIN
              IF "Customer Posting Group" <> '' THEN BEGIN
                IF "Gen. Prod. Posting Group" <> '' THEN
                  "Application Order" := 9
                ELSE
                  "Application Order" := 10;
              END ELSE BEGIN
                IF "Gen. Prod. Posting Group" <> '' THEN
                  "Application Order" := 11
                ELSE
                  "Application Order" := 12;
              END;
            END;
          END;
        END;
        */
        "Application Order" := 0;
        if "Responsibility Center" <> '' then
            "Application Order" += 10000;
        if "Customer Posting Group" <> '' then
            "Application Order" += 1000;
        if "Global Dimension 2 Code" <> '' then
            "Application Order" += 100;
        if "Global Dimension 1 Code" <> '' then begin
            "Application Order" += 10;
            if "Global Dimension 2 Code" <> '' then
                "Application Order" -= 105;
        end;
        if "Gen. Prod. Posting Group" <> '' then
            "Application Order" += 1;

    end;
}

