Table 8004069 "Sales Document Cost"
{
    // //PROJET_FG GESWAY 25/04/03 Nouvelle table des Frais généraux et marge d'un document
    // //PERF AC 03/04/06

    Caption = 'Sales Document Cost';

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
            OptionCaption = 'Item,Resource,Cross-Reference';
            OptionMembers = Item,Resource,"Cross-Reference";
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            TableRelation = if (Type = filter(Item)) Item
            else
            if (Type = filter(Resource)) Resource;
        }
        field(5; Value; Decimal)
        {
            Caption = 'Value';

            trigger OnValidate()
            begin
                UpdateSalesLines(Rec);
            end;
        }
        field(6; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                UpdateSalesLines(Rec);
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
            TableRelation = "Purchase Line"."Document No." where("Document Type" = field("Purchasing Document Type"));
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
        field(15; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(STG_Key1; "Document Type", "Document No.", Type, "No.", "Line No.", "Purchasing Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure UpdateSalesLines(pRec: Record "Sales Document Cost")
    var
        lSalesLine: Record "Sales Line";
        lStructureLine: Record "Sales Line";
        StructureMgt: Codeunit "Structure Management";
        lxRec: Record "Sales Line";
    begin
        with pRec do begin

            if (Type <> Type::Item) or (Type <> Type::Resource) then
                exit;

            lSalesLine.SetCurrentkey("Job No.", "Document Type", "Document No.", "Gen. Prod. Posting Group", Option, Disable, "Assignment Basis",
                                      Type, "Line Type", "Presentation Code", "Structure Line No.", "No.");

            lSalesLine.SetRange("Document Type", "Document Type");
            lSalesLine.SetRange("Document No.", "Document No.");
            case Type of
                Type::Item:
                    lSalesLine.SetRange(Type, lSalesLine.Type::Item);
                Type::Resource:
                    lSalesLine.SetRange(Type, lSalesLine.Type::Resource);
            end;
            lSalesLine.SetRange("No.", "No.");
            lSalesLine.SetFilter("Line Type", '<>%1', lSalesLine."line type"::Structure);
            if lSalesLine.Find('-') then
                repeat
                    //  IF lSalesLine."Line Type" <> lSalesLine."Line Type"::Structure THEN BEGIN
                    //    IF Type IN [Type::Item,Type::Resource] THEN BEGIN
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
                //    END;
                //  END;
                until lSalesLine.Next = 0;
        end;
    end;
}

