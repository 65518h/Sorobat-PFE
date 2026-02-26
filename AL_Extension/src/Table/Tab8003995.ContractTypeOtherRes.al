Table 8003995 "Contract Type - Other Res."
{
    Caption = 'Contract Type - Document Footer';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Contract Type"; Code[10])
        {
            Caption = 'Contract Type';
            TableRelation = "Contract Type".Code;

            trigger OnValidate()
            var
                lContract: Record "Contract Type";
                lTextCode: array[20] of Code[10];
                //   lSalesTextMgt: Codeunit "Sales Text Management";
                lSalesCommentLine: Record "Sales Comment Line";
            begin
            end;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Resource."No." where(Type = const(Other));

            trigger OnValidate()
            var
                lRes: Record Resource;
            begin
                if lRes.Get("No.") then begin
                    "Value Option" := lRes."Value Option";
                    "Rate Amount" := lRes."Rate Amount";
                    "Assignment Method" := lRes."Assignment Method";
                    "Assignment Basis" := lRes."Assignment Basis";
                end else begin
                    "Value Option" := 0;
                    "Rate Amount" := 0;
                    "Assignment Method" := 0;
                    "Assignment Basis" := 0;
                end;
            end;
        }
        field(4; "Value Option"; Option)
        {
            Caption = 'Mode de calcul';
            OptionCaption = 'Amount,% on Base,% on Result';
            OptionMembers = Amount,"% on Base","% on Result";
        }
        field(5; "Rate Amount"; Decimal)
        {
            Caption = 'Rate or Amount';
            Description = 'Taux ou montant de frais ou de remise en fonction du mode de calcul sélectionné';
        }
        field(6; "Assignment Method"; Option)
        {
            Caption = 'Distribution Method';
            OptionCaption = ' ,All';
            OptionMembers = " ",All;

            trigger OnValidate()
            var
                lTextNoAssgnt: label 'You must enter a %1.';
                lTextError: label 'You cannot enter %1 on a text line.';
            begin
            end;
        }
        field(7; "Assignment Basis"; Option)
        {
            Caption = 'Job Cost Assignment Basis';
            OptionCaption = ' ,Person Quantity,Direct Cost,Cost Price,Estimated Price,Specific';
            OptionMembers = " ","Person Quantity","Direct Cost","Cost Price","Estimated Price",Specific;

            trigger OnValidate()
            begin
                if "Assignment Basis" <> "assignment basis"::" " then
                    "Assignment Method" := "assignment method"::All
                else
                    "Assignment Method" := "assignment method"::" ";
            end;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

