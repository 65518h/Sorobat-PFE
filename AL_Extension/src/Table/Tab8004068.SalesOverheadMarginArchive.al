Table 8004068 "Sales Overhead-Margin Archive"
{
    // //PROJET_FG GESWAY 25/04/03 Nouvelle table des Frais généraux et marge d'un document
    // //PERF AC 03/04/06

    Caption = 'Sales Overhead-Margin Archive';

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Overhead,Margin,Item,Resource,Cross-reference';
            OptionMembers = Overhead,Margin,Item,Resource,"Cross-Reference";
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            TableRelation = if (Type = filter(Overhead | Margin)) "Gen. Product Posting Group"
            else
            if (Type = filter(Item)) Item
            else
            if (Type = filter(Resource)) Resource;
        }
        field(5; Value; Decimal)
        {
            Caption = 'Value';

            trigger OnValidate()
            begin
                UpdateSalesLines;
            end;
        }
        field(6; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                UpdateSalesLines;
            end;
        }
        field(7; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(8; "Purchasing Document Type"; Option)
        {
            Caption = 'Purchasing Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(9; "Purchasing Order No."; Code[20])
        {
            Caption = 'Purchasing Order No.';
            TableRelation = "Purchase Line Archive"."Document No." where("Document Type" = field("Purchasing Document Type"),
                                                                          "Document No." = field("Document No."),
                                                                          "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                          "Version No." = field("Version No."));
        }
        field(10; "Purchasing Order Line No."; Integer)
        {
            Caption = 'Purchasing Order Line No.';
        }
        field(11; "Reference Purchase Quote"; Text[30])
        {
            Caption = 'Reference Purchase Quote';
        }
        field(12; Rate; Decimal)
        {
            Caption = 'Rate';
        }
        field(13; "Rule Value"; Decimal)
        {
        }
        field(14; "Calculation Method"; Option)
        {
            Caption = 'Calculation Méthod';
            OptionCaption = 'Amount %,Quantity';
            OptionMembers = "Amount %",Quantity;
        }
        field(15; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
    }

    keys
    {
        key(STG_Key1; "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", Type, "No.", "Line No.", "Purchasing Code")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
        }
    }

    fieldgroups
    {
    }


    procedure UpdateSalesLines()
    var
        lSalesLine: Record "Sales Line";
        lStructureLine: Record "Sales Line";
        StructureMgt: Codeunit "Structure Management";
        lxRec: Record "Sales Line";
    begin
        lSalesLine.SetRange("Document Type", "Document Type");
        lSalesLine.SetRange("Document No.", "Document No.");
        if Type in [Type::Item, Type::Resource] then
            lSalesLine.SetRange("No.", "No.");
        if lSalesLine.Find('-') then
            repeat
                if lSalesLine."Line Type" <> lSalesLine."line type"::Structure then begin
                    if Type in [Type::Item, Type::Resource] then begin
                        lSalesLine.Validate("Unit Cost (LCY)", Value * lSalesLine."Qty. per Unit of Measure");
                        lSalesLine."Vendor No." := "Vendor No.";
                        lSalesLine.Modify;
                        if lSalesLine."Structure Line No." <> 0 then
                            if lStructureLine.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Structure Line No.") then begin
                                lxRec := lStructureLine;
                                StructureMgt.SumStructureLines(lStructureLine);
                                lStructureLine.Modify;
                                lStructureLine.wUpdateLine(lStructureLine, lxRec, false);
                            end;
                    end;
                end;
            until lSalesLine.Next = 0;
    end;
}

