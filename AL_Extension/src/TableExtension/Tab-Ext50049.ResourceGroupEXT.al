TableExtension 50049 "Resource GroupEXT" extends "Resource Group"
{
    fields
    {

        modify(Capacity)
        {
            Description = 'Modification CalcFormula';
        }

        modify("Qty. on Order (Job)")
        {

            Description = 'Modification CalcFormula';
            Caption = 'Qty. on Order (Job)';


        }
        modify("Qty. Quoted (Job)")
        {

            Description = 'Modification CalcFormula';
            Caption = 'Qty. Quoted (Job)';


        }
        modify("Usage (Qty.)")
        {
            Description = 'Modification CalcFormula';
        }
        modify("Usage (Cost)")
        {
            Description = 'Modification CalcFormula';
        }
        modify("Usage (Price)")
        {
            Description = 'Modification CalcFormula';
        }
        modify("Sales (Qty.)")
        {
            Description = 'Modification CalcFormula';
        }
        modify("Sales (Cost)")
        {
            Description = 'Modification CalcFormula';
        }
        modify("Sales (Price)")
        {
            Description = 'Modification CalcFormula';
        }


        field(8003900; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(8003901; "Job Filter"; Code[20])
        {
            Caption = 'Job Filter';
            FieldClass = FlowFilter;
            TableRelation = Job."No." where(Status = const(Open),
                                             "Job Type" = const(External));
        }
        field(8003903; "Audit Res. Gr. Qty."; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line".Quantity where("Job No." = field("Job Filter"),
                                                                  "Resource Group No." = field("No."),
                                                                  "Resource Group No." = field(filter(Totaling))));
            Caption = 'Audit Res. Gr. Qty.';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8003904; "Posted Res. Gr. Qty"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry".Quantity where("Job No." = field("Job Filter"),
                                                                 "Resource Group No." = field("No."),
                                                                 "Resource Group No." = field(filter(Totaling))));
            Caption = 'Posted Res. Gr. Qty';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8003907; "Audit Res. Gr. Cost"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line"."Total Cost" where("Job No." = field("Job Filter"),
                                                                      "Resource Group No." = field("No."),
                                                                      "Resource Group No." = field(filter(Totaling))));
            Caption = 'Audit Res. Gr. Cost';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8003908; "Posted Res. Gr. Cost"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry"."Total Cost" where("Job No." = field("Job Filter"),
                                                                     "Resource Group No." = field("No."),
                                                                     "Resource Group No." = field(filter(Totaling))));
            Caption = 'Posted Res. Gr. Cost';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8003909; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Person,Machine';
            OptionMembers = Person,Machine;
        }
        field(8003910; Totaling; Text[250])
        {
            Caption = 'Totaling';
        }
        field(8004130; "Period Planning Time (h)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where("Resource Group No." = field("No."),
                                                               Date = field("Date Filter"),
                                                               Private = const(false)));
            Caption = 'Period Planning Time (h)';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004132; "Planning Time (h)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where("Resource Group No." = field("No."),
                                                               Private = const(false)));
            Caption = 'Planning Time (h)';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004133; "Default Time per Day (h)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Time per Day (h)';
            DecimalPlaces = 0 : 2;
        }
        field(8004134; "Document Type Filter"; Option)
        {
            Caption = 'Document Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8004135; "Document No. Filter"; Code[20])
        {
            Caption = 'Document No. Filter';
            FieldClass = FlowFilter;
            TableRelation = "Sales Line"."Document No." where("Document Type" = field("Document Type Filter"));
        }
        field(8035010; "Tree Code"; Code[20])
        {
            Caption = 'Tree Code';
            TableRelation = Tree.Code where(Type = const("Resource Group"));

            trigger OnLookup()
            var
                lPyramid: Record Tree;
            begin
                //#8259
                lPyramid.SetRange(Type, lPyramid.Type::Structure);
                lPyramid.SetFilter(Code, "Tree Code");
                if lPyramid.Find('-') then;
                lPyramid.SetRange(Code);
                Type := lPyramid.Type::"Resource Group";
                "Tree Code" := lPyramid.LookUpForm(lPyramid.Type::"Resource Group", "Tree Code");
                //#8259//
            end;
        }
    }



    //var
    //ResCost : 202;
    //ResCost : 8004162;

}

