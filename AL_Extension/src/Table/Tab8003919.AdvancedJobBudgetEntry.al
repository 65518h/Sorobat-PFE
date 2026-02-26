Table 8003919 "Advanced Job Budget Entry"
{
    // //PROJET_BUDGET DL 24/06/04 Nouvelle table Budget chantier avancé (inspirée de Job Budget Entry)
    // //PERF MB 21/08/06 MAJ SIFT Index

    Caption = 'Advanced Job Budget Entry';
    // DrillDownPageID = 8003919;
    //LookupPageID = 8003919;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Job Status"; Option)
        {
            Caption = 'Job Status';
            OptionCaption = 'Template,Quote,Order,Completed';
            OptionMembers = Template,Quote,"Order",Completed;
        }
        field(3; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            begin
                Job.Get("Job No.");
                "Job Status" := Job.Status;
            end;
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account,Group (Resource)';
            OptionMembers = Resource,Item,"G/L Account","Group (Resource)";
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Resource)) Resource
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const("Group (Resource)")) "Resource Group";

            trigger OnValidate()
            begin
                if "No." = '' then
                    exit;

                if Type = Type::Resource then begin
                    Res.Get("No.");
                    "Resource Group No." := Res."Resource Group No.";
                end else
                    if Type = Type::"Group (Resource)" then
                        "Resource Group No." := "No.";
            end;
        }
        field(9; Date; Date)
        {
            Caption = 'Date';
        }
        field(10; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            TableRelation = "Resource Group";
        }
        field(11; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            Description = 'Modification de Name et Caption ML';
        }
        field(12; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(13; Price; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Price';
        }
        field(14; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = "User Setup";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.LookupUserID("User ID");
            end;
        }
        field(15; "Progress %"; Decimal)
        {
            Caption = 'Progress %';
        }
        field(1000; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(8003904; "Line Type"; Option)
        {
            Caption = 'Line Type';
            OptionCaption = 'Person,Machine,Item,Other';
            OptionMembers = Person,Machine,Item,Other;
        }
        field(8003905; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(8003906; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(8003907; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(8003911; "Gross Total Cost"; Decimal)
        {
            Caption = 'Gross Total Cost';
            Editable = false;
        }
        field(8004054; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
        }
        field(8004055; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8004056; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Document Type"));
        }
        field(8004057; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(8004058; Canceled; Boolean)
        {
            Caption = 'Canceled';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", "Line No.", "Line Type")
        {
            SumIndexFields = Quantity, Cost, Price, "Gross Total Cost";
        }
        key(Key3; "Job No.", "Job Task No.", "Gen. Prod. Posting Group", Type, "No.", "Variant Code", "Line Type", Date, "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
            SumIndexFields = Quantity, Cost, Price, "Gross Total Cost";
        }
        key(Key4; "Shipment No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
        lSalesLine: Record "Sales Line";
    begin
    end;

    var
        Text000: label 'You must specify %1.';
        Job: Record Job;
        Res: Record Resource;
        ResGr: Record "Resource Group";
        Text1100280006: label 'You can''t change this line wich is relied to %1 %2.';
        Text1100280005: label 'You can''t delete this line wich is relied to %1 %2.';


    procedure wSetType(pType: Option " ","G/L Account",Item,Resource)
    begin
        case pType of
            Ptype::Item:
                Type := Type::Item;
            Ptype::Resource:
                Type := Type::Resource;
            Ptype::"G/L Account":
                Type := Type::"G/L Account";
        end;
    end;
}

