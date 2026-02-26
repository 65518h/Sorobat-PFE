Table 8003925 "Column Field"
{
    // //REPORT YB 12/08/04 table des choix de colonne (Cf. report 8003904)
    //          DL 12/08/05 Si code nature = Total -> Rapatrie le champ Totalisation
    //          MB 26/02/07 Ajout option Unit Cost,Unit Person (Qty),Unit Price dans type

    Caption = 'Column Field';

    fields
    {
        field(1; TableNo; Integer)
        {
            Caption = 'TableNo';
            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(2; ColumnKey; Integer)
        {
            Caption = 'Key';
            TableRelation = "Column Key".ColumnKey where(TableNo = field(TableNo));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(13; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Cost,Person (Qty),Price,Unit Cost,Unit Person (Qty),Unit Price';
            OptionMembers = Cost,"Person (Qty)",Price,"Unit Cost","Unit Person (Qty)","Unit Price";

            trigger OnValidate()
            var
                lField: Record "Field";
            begin
            end;
        }
        field(14; "Gen. Prod. Post. Group Filter"; Text[250])
        {
            Caption = 'Gen. Prod. Post. Group Filter';
            TableRelation = "Gen. Product Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                lRec: Record "Gen. Product Posting Group";
            begin
                if PAGE.RunModal(page::"Gen. Product Posting Groups", lRec) = Action::LookupOK then
                    /*  IF lRec.Summarize THEN
                        "Gen. Prod. Post. Group Filter" := lRec.Totaling
                      ELSE
                    */
                    "Gen. Prod. Post. Group Filter" := lRec.Code;

            end;

            trigger OnValidate()
            begin
                //#6197 GenProductPostingGroup.GET("Gen. Prod. Post. Group Filter");
            end;
        }
        field(101; "Field Type Name"; Text[30])
        {
            Caption = 'Field Type Name';
            Editable = true;
            FieldClass = Normal;
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; TableNo, ColumnKey, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GenProductPostingGroup: Record "Gen. Product Posting Group";
}

