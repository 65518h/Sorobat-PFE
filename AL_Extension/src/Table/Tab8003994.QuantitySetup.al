Table 8003994 "Quantity Setup"
{
    // //POINTAGE GESWAY 11/03/05 Paramètres quantité

    Caption = 'Quantity Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(8003900; "Value Formula"; Text[80])
        {
            Caption = 'Value Formula';

            trigger OnValidate()
            var
                lGenLedgerSetup: Record "General Ledger Setup";
            begin
                VerifFormule("Value Formula");
                if "Rounding Precision Formule" = 0 then begin
                    lGenLedgerSetup.Get;
                    "Rounding Precision Formule" := lGenLedgerSetup."Amount Rounding Precision";
                end;
            end;
        }
        field(8003901; "Value 1 Name"; Text[30])
        {
            Caption = 'Value 1 Name';

            trigger OnValidate()
            begin
                if "Value 1 Name" = '' then
                    "Value 1 Default" := 0;
            end;
        }
        field(8003902; "Value 2 Name"; Text[30])
        {
            Caption = 'Value 2 Name';

            trigger OnValidate()
            begin
                if "Value 2 Name" = '' then
                    "Value 2 Default" := 0;
            end;
        }
        field(8003903; "Value 3 Name"; Text[30])
        {
            Caption = 'Value 3 Name';

            trigger OnValidate()
            begin
                if "Value 3 Name" = '' then
                    "Value 3 Default" := 0;
            end;
        }
        field(8003904; "Value 4 Name"; Text[30])
        {
            Caption = 'Value 4 Name';

            trigger OnValidate()
            begin
                if "Value 4 Name" = '' then
                    "Value 4 Default" := 0;
            end;
        }
        field(8003905; "Value 5 Name"; Text[30])
        {
            Caption = 'Value 5 Name';

            trigger OnValidate()
            begin
                if "Value 5 Name" = '' then
                    "Value 5 Default" := 0;
            end;
        }
        field(8003906; "Value 6 Name"; Text[30])
        {
            Caption = 'Value 6 Name';

            trigger OnValidate()
            begin
                if "Value 6 Name" = '' then
                    "Value 6 Default" := 0;
            end;
        }
        field(8003907; "Value 7 Name"; Text[30])
        {
            Caption = 'Value 7 Name';

            trigger OnValidate()
            begin
                if "Value 7 Name" = '' then
                    "Value 7 Default" := 0;
            end;
        }
        field(8003908; "Value 8 Name"; Text[30])
        {
            Caption = 'Value 8 Name';

            trigger OnValidate()
            begin
                if "Value 8 Name" = '' then
                    "Value 8 Default" := 0;
            end;
        }
        field(8003909; "Value 9 Name"; Text[30])
        {
            Caption = 'Value 9 Name';

            trigger OnValidate()
            begin
                if "Value 9 Name" = '' then
                    "Value 9 Default" := 0;
            end;
        }
        field(8003910; "Value 10 Name"; Text[30])
        {
            Caption = 'Value 10 Name';

            trigger OnValidate()
            begin
                if "Value 10 Name" = '' then
                    "Value 10 Default" := 0;
            end;
        }
        field(8003911; "Value 1 Default"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Value 1';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Value 1 Name");
            end;
        }
        field(8003912; "Value 2 Default"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Value 2';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Value 2 Name");
            end;
        }
        field(8003913; "Value 3 Default"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Value 3';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Value 3 Name");
            end;
        }
        field(8003914; "Value 4 Default"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Value 4';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Value 4 Name");
            end;
        }
        field(8003915; "Value 5 Default"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Value 5';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Value 5 Name");
            end;
        }
        field(8003916; "Value 6 Default"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Value 6';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Value 6 Name");
            end;
        }
        field(8003917; "Value 7 Default"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Value 7';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Value 7 Name");
            end;
        }
        field(8003918; "Value 8 Default"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Value 8';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Value 8 Name");
            end;
        }
        field(8003919; "Value 9 Default"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Value 9';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Value 9 Name");
            end;
        }
        field(8003920; "Value 10 Default"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Value 10';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Value 10 Name");
            end;
        }
        field(8003931; "Executed Formule Qty"; Option)
        {
            Caption = 'Calcul quantité valeur';
            OptionCaption = ' ,Value 1,Value 2,Value 3,Value 4,Value 5,Value 6,Value 7,Value 8,Value 9,Value 10';
            OptionMembers = " ","Value 1","Value 2","Value 3","Value 4","Value 5","Value 6","Value 7","Value 8","Value 9","Value 10";
        }
        field(8003932; "Rounding Precision Formule"; Decimal)
        {
            //blankzero = true;
            Caption = 'Rounding Precision Formule';
            DecimalPlaces = 0 : 5;
        }
        field(8003933; "Formula desactivated / Sales"; Boolean)
        {
            Caption = 'Formula desactivated / Sales';
        }
        field(8003941; "Value 1 Total"; Boolean)
        {
            //blankzero = true;
            Caption = 'Total Value 1';

            trigger OnValidate()
            begin
                TestField("Value 1 Name");
            end;
        }
        field(8003942; "Value 2 Total"; Boolean)
        {
            //blankzero = true;
            Caption = 'Total Value 2';

            trigger OnValidate()
            begin
                TestField("Value 2 Name");
            end;
        }
        field(8003943; "Value 3 Total"; Boolean)
        {
            //blankzero = true;
            Caption = 'Total Value 3';

            trigger OnValidate()
            begin
                TestField("Value 3 Name");
            end;
        }
        field(8003944; "Value 4 Total"; Boolean)
        {
            //blankzero = true;
            Caption = 'Total Value 4';

            trigger OnValidate()
            begin
                TestField("Value 4 Name");
            end;
        }
        field(8003945; "Value 5 Total"; Boolean)
        {
            //blankzero = true;
            Caption = 'Total Value 5';

            trigger OnValidate()
            begin
                TestField("Value 5 Name");
            end;
        }
        field(8003946; "Value 6 Total"; Boolean)
        {
            //blankzero = true;
            Caption = 'Total Value 6';

            trigger OnValidate()
            begin
                TestField("Value 6 Name");
            end;
        }
        field(8003947; "Value 7 Total"; Boolean)
        {
            //blankzero = true;
            Caption = 'Total Value 7';

            trigger OnValidate()
            begin
                TestField("Value 7 Name");
            end;
        }
        field(8003948; "Value 8 Total"; Boolean)
        {
            //blankzero = true;
            Caption = 'Total Value 8';

            trigger OnValidate()
            begin
                TestField("Value 8 Name");
            end;
        }
        field(8003949; "Value 9 Total"; Boolean)
        {
            //blankzero = true;
            Caption = 'Total Value 9';

            trigger OnValidate()
            begin
                TestField("Value 9 Name");
            end;
        }
        field(8003950; "Value 10 Total"; Boolean)
        {
            //blankzero = true;
            Caption = 'Total Value 10';

            trigger OnValidate()
            begin
                TestField("Value 10 Name");
            end;
        }
        field(8003951; "Used in 1"; Option)
        {
            Caption = 'Used in 1';
            OptionCaption = 'Purchases,Sales,Both';
            OptionMembers = Purchases,Sales,Both;
        }
        field(8003952; "Used in 2"; Option)
        {
            Caption = 'Used in 2';
            OptionCaption = 'Purchases,Sales,Both';
            OptionMembers = Purchases,Sales,Both;
        }
        field(8003953; "Used in 3"; Option)
        {
            Caption = 'Used in 3';
            OptionCaption = 'Purchases,Sales,Both';
            OptionMembers = Purchases,Sales,Both;
        }
        field(8003954; "Used in 4"; Option)
        {
            Caption = 'Used in 4';
            OptionCaption = 'Purchases,Sales,Both';
            OptionMembers = Purchases,Sales,Both;
        }
        field(8003955; "Used in 5"; Option)
        {
            Caption = 'Used in 5';
            OptionCaption = 'Purchases,Sales,Both';
            OptionMembers = Purchases,Sales,Both;
        }
        field(8003956; "Used in 6"; Option)
        {
            Caption = 'Used in 6';
            OptionCaption = 'Purchases,Sales,Both';
            OptionMembers = Purchases,Sales,Both;
        }
        field(8003957; "Used in 7"; Option)
        {
            Caption = 'Used in 7';
            OptionCaption = 'Purchases,Sales,Both';
            OptionMembers = Purchases,Sales,Both;
        }
        field(8003958; "Used in 8"; Option)
        {
            Caption = 'Used in 8';
            OptionCaption = 'Purchases,Sales,Both';
            OptionMembers = Purchases,Sales,Both;
        }
        field(8003959; "Used in 9"; Option)
        {
            Caption = 'Used in 9';
            OptionCaption = 'Purchases,Sales,Both';
            OptionMembers = Purchases,Sales,Both;
        }
        field(8003960; "Used in 10"; Option)
        {
            Caption = 'Used in 10';
            OptionCaption = 'Purchases,Sales,Both';
            OptionMembers = Purchases,Sales,Both;
        }
    }

    keys
    {
        key(STG_Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Error1: label 'The parenthesis at position %1 is misplaced.';
        Error2: label 'You cannot have two consecutive operators. The error occurred at position %1.';
        Error3: label 'There is an operand missing after position %1.';
        Error4: label 'There are more left parentheses than right parentheses.';
        Error5: label 'There are more right parentheses than left parentheses.';


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


    procedure fSalesUsed() Return: Boolean
    begin
        //#6767
        Return := (("Value Formula" <> '') and (not "Formula desactivated / Sales") and
                   (("Used in 1" in ["used in 1"::Sales, "used in 1"::Both]) or
                    ("Used in 2" in ["used in 2"::Sales, "used in 2"::Both]) or
                    ("Used in 3" in ["used in 3"::Sales, "used in 3"::Both]) or
                    ("Used in 4" in ["used in 4"::Sales, "used in 4"::Both]) or
                    ("Used in 5" in ["used in 5"::Sales, "used in 5"::Both]) or
                    ("Used in 6" in ["used in 6"::Sales, "used in 6"::Both]) or
                    ("Used in 7" in ["used in 7"::Sales, "used in 7"::Both]) or
                    ("Used in 8" in ["used in 8"::Sales, "used in 8"::Both]) or
                    ("Used in 9" in ["used in 9"::Sales, "used in 9"::Both]) or
                    ("Used in 10" in ["used in 10"::Sales, "used in 10"::Both])
                   )
                  );
        //#6767//
    end;


    procedure fPurchaseUsed() Return: Boolean
    begin
        //#6767
        Return := (("Value Formula" <> '') and
                   (("Used in 1" in ["used in 1"::Purchases, "used in 1"::Both]) or
                    ("Used in 2" in ["used in 2"::Purchases, "used in 2"::Both]) or
                    ("Used in 3" in ["used in 3"::Purchases, "used in 3"::Both]) or
                    ("Used in 4" in ["used in 4"::Purchases, "used in 4"::Both]) or
                    ("Used in 5" in ["used in 5"::Purchases, "used in 5"::Both]) or
                    ("Used in 6" in ["used in 6"::Purchases, "used in 6"::Both]) or
                    ("Used in 7" in ["used in 7"::Purchases, "used in 7"::Both]) or
                    ("Used in 8" in ["used in 8"::Purchases, "used in 8"::Both]) or
                    ("Used in 9" in ["used in 9"::Purchases, "used in 9"::Both]) or
                    ("Used in 10" in ["used in 10"::Purchases, "used in 10"::Both])
                   )
                  );
        //#6767//
    end;
}

