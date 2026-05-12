Table 8001426 "Sort Field"
{
    // //+BGW+SORT CW 21/07/03 Sort

    Caption = 'Sort Field';

    fields
    {
        field(1; TableNo; Integer)
        {
            Caption = 'TableNo';
            //GL2024 License    TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(2; SortKey; Integer)
        {
            Caption = 'Sort Key';
            TableRelation = "Sort Key".SortKey where(TableNo = field(TableNo));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'N° Ligne';
        }
        field(4; FieldNo; Integer)
        {
            //blankzero = true;
            Caption = 'FieldNo';
            TableRelation = Field."No." where(TableNo = field(TableNo));

            trigger OnLookup()
            var
                lField: Record "Field";
            begin
                lField.SetRange(TableNo, TableNo);
                //DYS page Addon non migrer
                // if Action::LookupOK = PAGE.RunModal(page::"Field List", lField) then
                //     FieldNo := lField."No.";
                Validate(FieldNo);
                //CALCFIELDS("Field Caption","Field Type Name");
            end;

            trigger OnValidate()
            var
                lField: Record "Field";
            begin
                if FieldNo <> xRec.FieldNo then begin
                    "Sort Direction" := 0;
                    Periodicity := 0;
                end;

                CalcFields("Field Caption", "Field Type Name");
                if lField.Get(TableNo, FieldNo) and
                   (lField.Type in [lField.Type::Text, lField.Type::Code, lField.Type::Option, lField.Type::Boolean]) then begin
                    Header := true;
                    Footer := true;
                end else begin
                    Header := false;
                    Footer := false;
                end;
            end;
        }
        field(6; "Start Position"; Integer)
        {
            //blankzero = true;
            Caption = 'Start Position';

            trigger OnValidate()
            var
                lField: Record "Field";
            begin
                Validate(Length);
                if "Start Position" <> 0 then begin
                    lField.Get(TableNo, FieldNo);
                    with lField do
                        if (Type in [Type::Date]) then
                            Error(tPositionNotAllowed);
                end;
            end;
        }
        field(7; "End Position"; Integer)
        {
            //blankzero = true;
            Caption = 'End Position';

            trigger OnValidate()
            var
                lField: Record "Field";
            begin
                if "End Position" <> 0 then begin
                    lField.Get(TableNo, FieldNo);
                    with lField do
                        if (Type in [Type::Date]) then
                            Error(tPositionNotAllowed)
                        else begin
                            if "End Position" = 0 then
                                Length := 0
                            else
                                Length := "End Position" - "Start Position" + 1;
                        end;
                end;
            end;
        }
        field(8; Length; Integer)
        {
            //blankzero = true;
            Caption = 'Field Length';

            trigger OnValidate()
            var
                lField: Record "Field";
            begin
                lField.Get(TableNo, FieldNo);
                with lField do
                    if (Type in [Type::Date]) then
                        Error(tPositionNotAllowed);

                "End Position" := "Start Position" + Length - 1;
                if "End Position" < 0 then
                    "End Position" := 0;
            end;
        }
        field(9; Divisor; Decimal)
        {
            //blankzero = true;
            Caption = 'Divisor';
            DecimalPlaces = 0 : 5;
        }
        field(10; NewPage; Boolean)
        {
            Caption = 'New Page';
        }
        field(11; Header; Boolean)
        {
            Caption = 'Header';
        }
        field(12; Footer; Boolean)
        {
            Caption = 'Footer';
        }
        field(13; "Sort Direction"; Option)
        {
            Caption = 'Sort Direction';
            OptionCaption = 'Ascending,Descending';
            OptionMembers = "Ascending","Descending";

            trigger OnValidate()
            var
                lField: Record "Field";
            begin
                if "Sort Direction" = "sort direction"::Descending then begin
                    lField.Get(TableNo, FieldNo);
                    with lField do
                        if not (Type in [Type::Integer, Type::Decimal, Type::Date]) then
                            Error(tDescendingNotAllowed);
                end;
            end;
        }
        field(14; Periodicity; Option)
        {
            Caption = 'Periodicity';
            OptionCaption = ' ,Week,Month,Quarter,Year,Accounting Period';
            OptionMembers = " ",Week,Month,Quarter,Year,"Accounting Period";

            trigger OnValidate()
            var
                lField: Record "Field";
            begin
                if Periodicity <> 0 then begin
                    lField.Get(TableNo, FieldNo);
                    with lField do
                        if not (Type in [Type::Date]) then
                            Error(tPeriodicityNotAllowed);
                end;
            end;
        }
        field(100; "Field Caption"; Text[80])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field(TableNo),
                                                              "No." = field(FieldNo)));
            Caption = 'Field Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(101; "Field Type Name"; Text[30])
        {
            CalcFormula = lookup(Field."Type Name" where(TableNo = field(TableNo),
                                                          "No." = field(FieldNo)));
            Caption = 'Type';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; TableNo, SortKey, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        tDescendingNotAllowed: label 'Descending sort direction is only allowed for Decimal, Integer or Date field type.';
        tPeriodicityNotAllowed: label 'Periodicity sort direction is only allowed for Date field type.';
        tPositionNotAllowed: label 'Position sort is not allowed for Date field type.';
}

