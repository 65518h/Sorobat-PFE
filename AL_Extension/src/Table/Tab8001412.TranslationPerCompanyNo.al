Table 8001412 "Translation PerCompanyNo"
{
    // //+REF+TRANSLATION STATSEXPLORER 26/01/02 New table for Code translation

    DataPerCompany = false;
    //LookupPageID = 8001424;

    fields
    {
        field(1; TableID; Integer)
        {
            Caption = 'ID Table';
        }
        field(2; FieldID; Integer)
        {
        }
        field(3; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(4; Language; Code[10])
        {
            Caption = 'Language';
            NotBlank = true;

            trigger OnLookup()
            var
                lLanguage: Record Language;
            begin
                lLanguage.Get(Language);
                if PAGE.RunModal(0, lLanguage) = Action::LookupOK then
                    Language := lLanguage.Code;
            end;

            trigger OnValidate()
            var
                lLanguage: Record Language;
            begin
                lLanguage.SetFilter(Code, '%1', Language + '*');
                lLanguage.FindFirst;
                Language := lLanguage.Code;
            end;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(7; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(STG_Key1; TableID, FieldID, "Code", "Line No.", Language)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

