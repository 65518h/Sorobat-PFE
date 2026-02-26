Table 8004060 "Import/Export Setup Lines"
{
    // //DEVIS GESWAY 14/04/03 Import appel d'offre. Définition des lignes
    //                16/06/03 Ajout champ Usage,"Exclude line"
    //                27/06/05 Ajout du champ Niveau dans la liste

    Caption = 'Import/Export Setup Lines';

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = "Import/Export Setup".Code;
        }
        field(3; "Column ID"; Text[10])
        {
            Caption = 'Column ID';
            CharAllowed = 'Az';
            NotBlank = true;

            trigger OnValidate()
            begin
                "Column ID" := UpperCase("Column ID");
            end;
        }
        field(4; "Column Description"; Text[30])
        {
            Caption = 'Column Description';
        }
        field(5; "Target Field No."; Integer)
        {
            Caption = 'Target Field No.';
            TableRelation = Field."No." where(TableNo = const(37));

            trigger OnLookup()
            begin
                InitFieldList;
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable2) = Action::LookupOK then
                //     Validate("Target Field No.", FieldTable2."No.");
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                InitFieldList;
                TestField("Target Field No.");
                if not FieldTable2.Get(37, "Target Field No.") then
                    Error(Text001);
                CalcFields("Target Field Caption");
            end;
        }
        field(6; Usage; Option)
        {
            Caption = 'Usage';
            OptionCaption = 'Import,Export,Both';
            OptionMembers = Import,Export,Both;
        }
        field(7; "Exclude Line"; Boolean)
        {
            Caption = 'Exclude Line If Empty';
        }
        field(8; "Target Field Caption"; Text[30])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = const(37),
                                                              "No." = field("Target Field No.")));
            Caption = 'Target Field Caption';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", "Column ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField(Code);
    end;

    var
        FieldTable: Record "Field";
        FieldTable2: Record "Field" temporary;
        Text001: label 'You have entered an illegal value.';
        SelFieldNo: array[11] of Integer;
        i: Integer;
        j: Integer;


    procedure InitFieldList()
    begin
        i := 1;
        SelFieldNo[1] := 5;
        SelFieldNo[2] := 6;
        SelFieldNo[3] := 11;
        SelFieldNo[4] := 15;
        SelFieldNo[5] := 22;
        SelFieldNo[6] := 100;
        SelFieldNo[7] := 103;
        SelFieldNo[8] := 5407;
        SelFieldNo[9] := 5705;
        SelFieldNo[10] := 8004057;
        SelFieldNo[11] := 8003916;

        if not FieldTable2.Find('-') then begin
            FieldTable.SetRange(TableNo, 37);
            FieldTable.Find('-');
            repeat
                i := 1;
                while i <= ArrayLen(SelFieldNo) do begin
                    if FieldTable."No." = SelFieldNo[i] then
                        FieldTable.Mark(true);
                    i += 1;
                end;
            until FieldTable.Next = 0;

            FieldTable.MarkedOnly(true);
            FieldTable.Find('-');
            repeat
                FieldTable2 := FieldTable;
                FieldTable2.Insert;
            until FieldTable.Next = 0;
        end;
    end;
}

