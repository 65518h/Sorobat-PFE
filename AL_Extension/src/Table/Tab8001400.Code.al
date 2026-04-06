Table 8001400 "Code"
{
    // //+BGW+CODE             GESWAY 01/01/00 Codes table

    Caption = 'Code';
    // LookupPageID = 8001400;

    fields
    {
        field(1; "Table No"; Integer)
        {
            Caption = 'Table';

            //GL2024 License  TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(2; "Field No"; Integer)
        {
            Caption = 'Field';
            TableRelation = Field."No." where(TableNo = field("Table No"));
        }
        field(3; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
    }

    keys
    {
        key(STG_Key1; "Table No", "Field No", "Code")
        {
            Clustered = true;
        }
        key(STG_Key2; Synchronise)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lRecordRef: RecordRef;
    begin
    end;

    trigger OnRename()
    var
        lRecordRef: RecordRef;
    begin
    end;


    procedure Translation(pLanguage: Code[10]) Return: Text[50]
    var
        lTranslation: Record Translation2;
    begin

        if lTranslation.Get("Table No", "Field No", Code, pLanguage) then
            Return := lTranslation.Description
        else
            Return := Description;
    end;
}

