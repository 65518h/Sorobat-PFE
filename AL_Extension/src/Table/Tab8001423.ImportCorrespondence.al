Table 8001423 "Import Correspondence"
{
    // //+REF+IMPORT CLA 22/03/04 Table de correspondance pour les imports génériques

    Caption = 'Import Correspondence';
    //  LookupPageID = 8001433;

    fields
    {
        field(1; "Import Code"; Code[20])
        {
            Caption = 'Import Code';
            TableRelation = Import.Code;
        }
        field(2; "Field No."; Integer)
        {
            Caption = 'Field No.';
        }
        field(3; "External Code"; Code[20])
        {
            Caption = 'External Code';
        }
        field(4; "Navision Code"; Code[20])
        {
            Caption = 'Navision Code';

            trigger OnLookup()
            var
                lImport: Record Import;
                lTableRelation: Codeunit TableRelation;
                lCode: Code[20];
            begin
                lImport.Get("Import Code");
                lCode := "Navision Code";
                if lTableRelation.LookUp(lImport."Table ID", "Field No.", lCode) then
                    "Navision Code" := lCode;
            end;
        }
        field(5; Comment; Text[30])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(Key1; "Import Code", "Field No.", "External Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure ToNavision(pImport: Code[20]; pField: Integer; pCode: Code[20]) Return: Code[20]
    begin
        SetCurrentkey("Import Code");
        if Get(pImport, pField, pCode) then
            Return := "Navision Code"
        else
            Return := pCode;
    end;


    procedure FromNavision(pImport: Code[20]; pField: Integer; pCode: Code[20]) Return: Code[20]
    begin
        SetCurrentkey("Import Code");
        SetRange("Import Code", pImport);
        SetRange("Field No.", pField);
        SetRange("Navision Code", pCode);
        if Find('-') then
            Return := "External Code"
        else
            Return := pCode;
    end;
}

