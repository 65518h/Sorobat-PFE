Table 8004059 "Import/Export Setup"
{
    // //DEVIS GESWAY 14/04/03 Nouvelle table. Import appel d'offre. Définition en-tête

    Caption = 'Import/Export Setup';
    //DrillDownPageID = 8004079;
    //LookupPageID = 8004079;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Starting Line No."; Integer)
        {
            Caption = 'Starting Line No.';
        }
        field(4; "End Markup"; Text[30])
        {
            Caption = 'End Markup';
        }
        field(5; FileName; Text[250])
        {
            Caption = 'File Name';
        }
        field(6; "Excel Worksheet Name"; Text[250])
        {
            Caption = 'Excel Worksheet Name';
        }
        field(7; "Level Accord. Cross-Reference"; Boolean)
        {
            Caption = 'Level According Cross-Reference';
        }
        field(8; "XMLPort ID"; Integer)
        {
            Caption = 'XMLPort ID';
            //GL2024 License   TableRelation = Object.ID where(Type = const(XMLport));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(XmlPort));
            //GL2024 License
        }
        field(9; "Source File Type"; Option)
        {
            Caption = 'Source File Type';
            OptionMembers = Excel,XML;
        }
        field(11; "Default Structure No."; Code[20])
        {
            Caption = 'Default Structure No.';
            TableRelation = Resource."No." where(Type = filter(Structure));
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ImportQuoteLine.SetRange(Code, Code);
        ImportQuoteLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        CheckFieldValue;
    end;

    trigger OnModify()
    begin
        CheckFieldValue;
    end;

    var
        ImportQuoteLine: Record "Import/Export Setup Lines";


    procedure CheckFieldValue()
    begin
        if "Starting Line No." < 1 then
            "Starting Line No." := 1;
    end;
}

