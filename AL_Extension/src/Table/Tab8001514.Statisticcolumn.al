Table 8001514 "Statistic column"
{
    //GL2024  ID dans Nav 2009 : "8001307"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Statistic column setup
    // //STATSEXPLORER STATSEXPLORER 08/01/03 New field : line title

    Caption = 'Statistic column';
    //LookupPageID = 8001307;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = "Column style name".Code where(Code = field(Code));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Column No."; Code[10])
        {
            Caption = 'Column No.';
        }
        field(5; "Column Layout Name"; Text[30])
        {
            Caption = 'Column Layout Name';
        }
        field(10; "Column type"; Text[30])
        {
            Caption = 'Column type';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter(Value),
                                                                     Enabled = filter(true));

            trigger OnLookup()
            begin
                Critere.FilterGroup(7);
                Critere.SetRange(Type, Critere.Type::Value);
                Critere.SetRange(Enabled, true);
                Critere.FilterGroup(0);
                if PAGE.RunModal(0, Critere) = Action::LookupOK then
                    "Column type" := Critere."Field name";
            end;

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::Value, "Column type") then
                    if (Critere."Field No." = 35) or (Critere."Field No." = 38) or
                       ((Critere."Field No." >= 70) and (Critere."Field No." <= 79)) then
                        Message(Mess1);
            end;
        }
        field(11; "Entry Type"; Text[30])
        {
            Caption = 'Entry Type';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter(Flow),
                                                                     Enabled = filter(true));

            trigger OnLookup()
            begin
                Critere.FilterGroup(7);
                Critere.SetRange(Type, Critere.Type::Flow);
                Critere.SetRange(Enabled, true);
                Critere.FilterGroup(0);
                if PAGE.RunModal(0, Critere) = Action::LookupOK then
                    "Entry Type" := Critere."Field name";
            end;
        }
        field(12; "Reverse sign"; Boolean)
        {
            Caption = 'Reverse sign';
        }
        field(13; "Print column"; Option)
        {
            Caption = 'Print column';
            OptionCaption = 'Always,Never,When Positive,When Negative';
            OptionMembers = Always,Never,"When Positive","When Negative";
        }
        field(14; "Rounding Factor"; Option)
        {
            Caption = 'Rounding Factor';
            OptionCaption = 'None,1,1000,1000000';
            OptionMembers = "None","1","1000","1000000";
        }
        field(15; "Process from date"; DateFormula)
        {
            Caption = 'Process from date';
        }
        field(16; "Process to date"; DateFormula)
        {
            Caption = 'Process to date';
        }
        field(17; Formula; Text[80])
        {
            Caption = 'Formula';

            trigger OnValidate()
            begin
                VerifFormule(Formula);
            end;
        }
        field(20; "Additional filter"; Boolean)
        {
            CalcFormula = exist("Statistic column filter" where(Code = field(Code),
                                                                 "Line No." = field("Line No.")));
            Caption = 'Additional filter';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "New line"; Boolean)
        {
            Caption = 'New line';
        }
        field(31; "Line title"; Text[30])
        {
            Caption = 'Line title';
        }
    }

    keys
    {
        key(Key1; "Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if FiltreColonne.Get(Code, "Line No.") then
            FiltreColonne.Delete;
    end;

    var
        Critere: Record "Statistic criteria";
        Colonne: Record "Statistic column";
        FiltreColonne: Record "Statistic column filter";
        i: Integer;
        Mess1: label 'Column number required for formula field';
        Error1: label 'The parenthesis at position %1 is misplaced.';
        Error2: label 'You cannot have two consecutive operators. The error occurred at position %1.';
        Error3: label 'There is an operand missing after position %1.';
        Error4: label 'There are more left parentheses than right parentheses.';
        Error5: label 'There are more right parentheses than left parentheses.';
        Error6: label 'Column %1 not defined';


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

        // Contrôle %
        if Critere.Get(Critere.Type::Value, "Column type") then
            if (Critere."Field No." = 35) or (Critere."Field No." = 38) then begin
                Colonne.SetRange(Colonne."Column No.", Formule);
                if Colonne.IsEmpty then
                    Error(Error6, Formule);
            end;
    end;
}

