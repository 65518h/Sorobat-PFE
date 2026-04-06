Table 8003502 "Analytical Distribution Key"
{
    // //+REP+ GESWAY 19/09/01 Nouvelle table des clés de répartition analytique

    Caption = 'Analytical Distribution Key';
    //LookupPageID = 8003502;

    fields
    {
        field(1; "Analytical Distribution Code"; Code[10])
        {
            Caption = 'Analytical Distribution Code';
            TableRelation = "Analytical Distribution Rule";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(6; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(7; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(8; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(11; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(12; Quantity; Decimal)
        {
            //blankzero = true;
            Caption = 'Quantity';
        }
        field(13; "Allocation %"; Decimal)
        {
            Caption = 'Allocation %';
        }
        field(14; "Shortcut Dimension 3 Code"; Code[20])
        {
            //CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(15; "Shortcut Dimension 4 Code"; Code[20])
        {
            //CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(16; "Shortcut Dimension 5 Code"; Code[20])
        {
            //CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(17; "Shortcut Dimension 6 Code"; Code[20])
        {
            //CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(18; "Shortcut Dimension 7 Code"; Code[20])
        {
            //CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(19; "Shortcut Dimension 8 Code"; Code[20])
        {
            //CaptionClass = '1,2,8';
            Caption = 'Shortcutl Dimension 8 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(30; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(31; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(32; "Job Posting Group"; Code[20])
        {
            Caption = 'Job Posting Group';
            TableRelation = "Job Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(STG_Key1; "Analytical Distribution Code", "Line No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Analytical Distribution Code", "G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Job No.", "Reason Code", "Job Task No.", "Work Type Code", "Gen. Prod. Posting Group", "Gen. Bus. Posting Group", "Job Posting Group")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DistributionKey: Record "Analytical Distribution Key";
        DimMgt: Codeunit DimensionManagement;


    procedure UpdateAllocations()
    var
        DistributionKey2: Record "Analytical Distribution Key";
        DistributionKey3: Record "Analytical Distribution Key";
        TotalQty: Decimal;
        TotalPct: Decimal;
        TotalPctRnded: Decimal;
        UpdateDistributionKey: Boolean;
    begin
        DistributionKey2.SetRange("Analytical Distribution Code", "Analytical Distribution Code");
        if DistributionKey2.Find('-') then begin
            DistributionKey2.LockTable;
            repeat
                if DistributionKey2.Quantity <> 0 then begin
                    if TotalQty = 0 then begin
                        DistributionKey3.Copy(DistributionKey2);
                        DistributionKey3.SetFilter(Quantity, '<>0');
                        repeat
                            TotalQty := TotalQty + DistributionKey3.Quantity;
                        until DistributionKey3.Next = 0;
                        if TotalQty = 0 then
                            TotalQty := 1;
                    end;
                    TotalPct := TotalPct + DistributionKey2.Quantity / TotalQty * 100;
                    DistributionKey2."Allocation %" := ROUND(TotalPct, 0.01) - TotalPctRnded;
                    TotalPctRnded := TotalPctRnded + DistributionKey2."Allocation %";
                end;
                DistributionKey2.Modify;
            until DistributionKey2.Next = 0;
        end;
    end;
}

