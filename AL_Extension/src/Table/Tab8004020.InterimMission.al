Table 8004020 "Interim Mission"
{
    // //INTERIM GESWAY 26/06/02 Nouvelle table des missions des intérimaires
    // //+REF+REPLIC AC 28/06/05 OnInsert, OnModify, OnDelete, OnRename
    //                           + field "Replication" (ID = 73754 ), boolean, editable=No

    Caption = 'Interim Mission';
    // LookupPageID = 8004020;

    fields
    {
        field(1; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            NotBlank = true;
            TableRelation = Resource."No." where(Status = const(External),
                                                  Type = const(Person));
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;

            trigger OnValidate()
            var
                lInterimMission: Record "Interim Mission";
            begin
                if "Starting Date" <> 0D then begin
                    if ("Ending Date" < "Starting Date") and ("Ending Date" <> 0D) then
                        Error(Text1100280004, FieldCaption("Starting Date"), FieldCaption("Ending Date"));
                    lInterimMission.SetRange("Resource No.", "Resource No.");
                    lInterimMission.SetRange("Starting Date", 0D, "Starting Date");
                    lInterimMission.SetFilter("Ending Date", '>=%1', "Starting Date");
                    if lInterimMission.Count <> 0 then
                        Error(Text1100280002, "Resource No.", "Starting Date");
                end;
            end;
        }
        field(3; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            var
                lInterimMission: Record "Interim Mission";
            begin
                if "Ending Date" <> 0D then begin
                    if "Ending Date" < "Starting Date" then
                        Error(Text1100280003, FieldCaption("Ending Date"), FieldCaption("Starting Date"));
                    lInterimMission.SetRange("Resource No.", "Resource No.");
                    lInterimMission.SetRange("Starting Date", "Starting Date" + 1, "Ending Date");
                    if lInterimMission.Count <> 0 then
                        Error(Text1100280002, "Resource No.", "Ending Date");
                end;
            end;
        }
        field(4; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor where("External Work Force" = const(true));
        }
        field(5; "Mission Code"; Code[10])
        {
            Caption = 'Mission Code';
            TableRelation = Mission;

            trigger OnValidate()
            begin
                if Mission.Get("Mission Code") then
                    Description := Mission.Description;
            end;
        }
        field(6; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(8; Comment; Text[80])
        {
            Caption = 'Co&mment';
        }
        field(9; "Mission No."; Code[20])
        {
            Caption = 'Mission No.';

            trigger OnValidate()
            begin
                if "Mission No." <> xRec."Mission No." then begin
                    NaviBatSetup.GET2;
                    NoSeriesMgt.TestManual(NaviBatSetup."Interim Mission Nos");
                end;
            end;
        }
        field(10; "External Mission No."; Code[20])
        {
            Caption = 'External Mission No.';
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
    }

    keys
    {
        key(STG_Key1; "Resource No.", "Mission No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Vendor No.")
        {
        }
        key(STG_Key3; "Resource No.", "Starting Date", "Ending Date")
        {
        }
        key(STG_Key4; "Vendor No.", "Resource No.", "Ending Date", "Mission No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //+REF+REPLIC
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnInsert()
    begin
        if GetFilter("Vendor No.") <> '' then
            "Vendor No." := GetRangeMin("Vendor No.");
        if "Resource No." <> '' then
            if Res.Get("Resource No.") then
                if Res.Status = Res.Status::Internal then
                    Res.TestField(Status, Res.Status::External);
        if "Mission No." = '' then begin
            NaviBatSetup.GET2;
            NaviBatSetup.TestField("Interim Mission Nos");
            Clear(NoSeriesMgt);
            "Mission No." := NoSeriesMgt.GetNextNo(NaviBatSetup."Interim Mission Nos", WorkDate, true);
        end;

        //+REF+REPLIC
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnModify()
    var
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        lReplicationRef.GetTable(xRec);
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnRename()
    var
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        lReplicationRef.GetTable(xRec);
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //+REF+REPLIC//
    end;

    var
        NaviBatSetup: Record NavibatSetup;
        Res: Record Resource;
        Mission: Record Mission;
        Text1100280002: label 'You must define one an only one mission for %1 on %2';
        Text1100280003: label '%1 must be superior to %2.';
        Text1100280004: label '%1 cannot be greater than %2';
        NoSeriesMgt: Codeunit 396;
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
}

