Table 8001403 Characteristic
{
    // //+REF+CHARACT GESWAY 01/01/00 Table des caractéristiques complémentaires par n°

    Caption = 'Characteristic';

    fields
    {
        field(1; "Table Name"; Option)
        {
            Caption = 'Table Name';
            OptionCaption = 'Account (G/L),Customer,Contact,Vendor,Item,Resource,Job,Fixed Asset,Employee';
            OptionMembers = "Account (G/L)",Customer,Contact,Vendor,Item,Resource,Job,"Fixed Asset",Employee;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Characteristic Code"; Code[10])
        {
            Caption = 'Characteristic code';
            NotBlank = true;
            TableRelation = "Characteristic Code".Code where("Table Name" = field("Table Name"));
        }
        field(4; Value; Text[80])
        {
            Caption = 'Value';

            trigger OnLookup()
            var
                lCodeCaract: Record "Characteristic Code";
                lCaractOptions: Record "Characteristic Option";
            //GL2024  frmCaractOptions: Page 8001402;
            begin
                if not lCodeCaract.Get("Table Name", "Characteristic Code") or (lCodeCaract.Type <> lCodeCaract.Type::Option) then
                    exit;
                lCaractOptions.SetRange("Table Name", "Table Name");
                lCaractOptions.SetRange("Characteristic code", "Characteristic Code");
                //DYS page Addon non migrer
                // if PAGE.RunModal(Page::"Characteristic Options", lCaractOptions) = Action::LookupOK then
                //     Value := lCaractOptions.Option;
            end;

            trigger OnValidate()
            var
                lCodeCaract: Record "Characteristic Code";
                i: Integer;
                lInteger: Integer;
                lDecimal: Decimal;
                lBoolean: Boolean;
                lDate: Date;
                lCaractOptions: Record "Characteristic Option";
            begin
                if not lCodeCaract.Get("Table Name", "Characteristic Code") or (Value = '') then
                    exit;
                if lCodeCaract.Type in [lCodeCaract.Type::Integer, lCodeCaract.Type::Decimal] then
                    CadrerDroite(Value, MaxStrLen(Value), ' ')
                else
                    CadrerGauche(Value);
                case lCodeCaract.Type of
                    lCodeCaract.Type::Text:
                        ;
                    lCodeCaract.Type::Option:
                        begin
                            Value := UpperCase(Value);
                            if not lCaractOptions.Get("Table Name", "Characteristic Code", Value) then begin
                                lCaractOptions.Reset;
                                lCaractOptions.SetRange("Table Name", "Table Name");
                                lCaractOptions.SetRange("Characteristic code", "Characteristic Code");
                                lCaractOptions.SetRange(Option, Value, 'zzzz');
                                if lCaractOptions.Find('-') then
                                    Value := lCaractOptions.Option
                                else
                                    Error(Error1);
                            end;
                        end;
                    lCodeCaract.Type::Integer:
                        if not Evaluate(lInteger, Value) then
                            Error(Error2)
                        else
                            Value := Format(lInteger);
                    lCodeCaract.Type::Decimal:
                        if not Evaluate(lDecimal, Value) then
                            Error(Error3)
                        else
                            Value := Format(lDecimal);
                    lCodeCaract.Type::Boolean:
                        if not Evaluate(lBoolean, Value) then
                            Error(Error4)
                        else
                            Value := Format(lBoolean);
                    lCodeCaract.Type::Date:
                        if not Evaluate(lDate, Value) then
                            Error(Error5)
                        else
                            Value := Format(lDate);
                end;
            end;
        }
    }

    keys
    {
        key(STG_Key1; "Table Name", "No.", "Characteristic Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Error1: label 'Option non definie pour cette caractéristique';
        Error2: label 'Cette caractéristique doit être un entier';
        Error3: label 'Cette caractéristique doit être un nombre décimal';
        Error4: label 'Cette caractéristique doit être oui ou non';
        Error5: label 'Cette caractéristique doit être une date';


    procedure CadrerDroite(Chaine: Text[80]; Longueur: Integer; Caractere: Text[80]) Return: Text[80]
    begin
        if Chaine = '' then
            exit('');
        while StrLen(Chaine) < Longueur do
            Chaine := InsStr(Chaine, Caractere, 1);
        Return := Chaine;
    end;


    procedure CadrerGauche(var Chaine: Text[80]) Return: Text[80]
    begin
        while (StrLen(Chaine) > 0) and (Chaine[1] = ' ') do
            Chaine := DelStr(Chaine, 1, 1);
        Return := Chaine;
    end;
}

