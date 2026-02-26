Table 8001407 "History treatment"
{
    // //STATSEXPLORER STATSEXPLORER 01/11/99 History treatments

    Caption = 'History treatments';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Type of Treatment"; Option)
        {
            Caption = 'Type of Treatment';
            OptionCaption = 'Table Data,Table,Form,Report,Dataport,Codeunit,,,,,System';
            OptionMembers = "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System;
        }
        field(3; "Treatment No."; Integer)
        {
            Caption = 'Treatment No.';
        }
        field(4; "Treatment name"; Text[30])
        {
            /*//GL2024 License    CalcFormula = lookup(Object.Name where(Type = field("Type of Treatment"),
                                                        ID = field("Treatment No.")));*///GL2024 License

            //GL2024 License
            CalcFormula = lookup(AllObj."Object Name" where("Object Type" = field("Type of Treatment"),
                                                    "Object ID" = field("Treatment No.")));
            //GL2024 License                                
            Caption = 'Treatment name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; Date; Date)
        {
            Caption = 'Date';
        }
        field(10; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
        }
        field(11; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
        }
        field(15; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(20; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Type of Treatment", "Treatment No.", Date, "Starting Time")
        {
        }
        key(Key3; Date, "Starting Time", "Ending Time", "User ID")
        {
        }
    }

    fieldgroups
    {
    }


    procedure CreerHistorique(NumeroSequence: Integer; NomTraitement: Text[250]; TypeTraitement: Integer; NumeroTraitement: Integer) NumSuivEcr: Integer
    begin
        if NumeroSequence = 0 then begin
            if Find('+') then
                NumSuivEcr := "Entry No." + 1
            else
                NumSuivEcr := 1;
            Init;
            "Entry No." := NumSuivEcr;
            "Type of Treatment" := TypeTraitement;
            "Treatment No." := NumeroTraitement;
            Date := Today;
            "Starting Time" := Time;
            Description := NomTraitement;
            "User ID" := UserId;
            Insert;
        end else
            if Get(NumeroSequence) then begin
                "Ending Time" := Time;
                Modify;
            end;
        exit(NumSuivEcr);
    end;
}

