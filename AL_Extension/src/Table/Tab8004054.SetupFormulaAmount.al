Table 8004054 "Setup Formula Amount"
{
    // //DEVIS GESWAY 02/06/03 Paramètres de 10 champs libres de ligne vente pour calcul selon une formule

    Caption = 'Setup Formula Amount';
    //LookupPageID = 8004081;

    fields
    {
        field(1; "Column No."; Integer)
        {
            Caption = 'Column No.';
        }
        field(2; Formula; Text[80])
        {
            Caption = 'Formula';

            trigger OnValidate()
            begin
                VerifFormule(Formula);
            end;
        }
        field(23; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(24; "Table No."; Integer)
        {
            //blankzero = true;
            Caption = 'Table No.';
            /*//GL2024 License   TableRelation = Object.ID where(Type = const(Table),
                                                ID = filter(37 | 8004160 | 251 | 8003902));*///GL2024 License

            TableRelation = AllObj."Object ID" where("Object Type" = const(Table),
                                            "Object id" = filter(37 | 8004160 | 251 | 8003902));

            trigger OnLookup()
            var
                //GL2024 License    lObject: Record "Object";
                //GL2024 License
                lObject: Record AllObj;
            //GL2024 License
            begin
                //lObject.SETRANGE("Company Name",COMPANYNAME);
                lObject.SetRange("Object Type", lObject."Object Type"::Table);
                lObject.SetFilter("Object ID", '37|8004160|251|8003902');
                if Action::LookupOK = PAGE.RunModal(page::Objects, lObject) then
                    "Table No." := lObject."Object ID";
            end;
        }
        field(25; "Table Name"; Text[30])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(TableData),
                                                                           "Object ID" = field("Table No.")));
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Rounding Precision"; Decimal)
        {
            Caption = 'Rounding Precision';
            InitValue = 1;
        }
    }

    keys
    {
        key(Key1; "Table No.", "Column No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    begin
        Error(Text001);
    end;

    var
        Error1: label 'The parenthesis at position %1 is misplaced.';
        Error2: label 'You cannot have two consecutive operators. The error occurred at position %1.';
        Error3: label 'There is an operand missing after position %1.';
        Error4: label 'There are more left parentheses than right parentheses.';
        Error5: label 'There are more right parentheses than left parentheses.';
        Text001: label 'You can''t rename this record.';


    procedure VerifFormule(Formule: Code[80])
    var
        i: Integer;
        NiveauParenthese: Integer;
        PossedeOperateur: Boolean;
    begin
        NiveauParenthese := 0;
        for i := 1 to StrLen(Formule) do begin
            if Formule[i] = '(' then
                NiveauParenthese := NiveauParenthese + 1
            else
                if Formule[i] = ')' then
                    NiveauParenthese := NiveauParenthese - 1;
            if NiveauParenthese < 0 then
                Error(Error1, i);
            if Formule[i] in ['+', '-', '*', '/', '^'] then begin
                if PossedeOperateur then
                    Error(Error2, i)
                else
                    PossedeOperateur := true;
                if i = StrLen(Formule) then
                    Error(Error3, i)
                else
                    if Formule[i + 1] = ')' then
                        Error(Error3, i);
            end else
                PossedeOperateur := false;
        end;
        if NiveauParenthese > 0 then
            Error(Error4)
        else
            if NiveauParenthese < 0 then
                Error(Error5);
    end;
}

