TableExtension 50872 "Resource CostEXT" extends "Resource Cost"
{
    fields
    {
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8003900; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(8003901; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor where("External Work Force" = const(true));
        }
        field(8003902; "Mission Code"; Code[10])
        {
            Caption = 'Mission Code';
            TableRelation = Mission;
        }
        field(8003903; "Mission No."; Code[20])
        {
            Caption = 'Mission No.';
            TableRelation = if (Type = const(Resource),
                                Code = filter(<> ''),
                                "Vendor No." = filter(<> ''),
                                "Mission Code" = filter(<> '')) "Interim Mission"."Mission No." where("Resource No." = field(Code),
                                                                                                    "Vendor No." = field("Vendor No."),
                                                                                                    "Mission Code" = field("Mission Code"))
            else
            if (Type = const(Resource),
                                                                                                             Code = filter(<> ''),
                                                                                                             "Vendor No." = filter(<> '')) "Interim Mission"."Mission No." where("Resource No." = field(Code),
                                                                                                                                                                               "Vendor No." = field("Vendor No."))
            else
            if (Type = const(Resource),
                                                                                                                                                                                        Code = filter(<> '')) "Interim Mission"."Mission No." where("Resource No." = field(Code))
            else
            if (Type = const(Resource),
                                                                                                                                                                                                 Code = filter(<> ''),
                                                                                                                                                                                                 "Mission Code" = filter(<> '')) "Interim Mission"."Mission No." where("Resource No." = field(Code),
                                                                                                                                                                                                                                                                     "Mission Code" = field("Mission Code"))
            else
            "Interim Mission"."Mission No.";
        }
        field(8003904; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            Description = 'Modif TableRelation';
            TableRelation = "Resource Group";

            trigger OnLookup()
            var
                lResourceGroup: Record "Resource Group";
            begin
            end;

            trigger OnValidate()
            var
                lResGr: Record "Resource / Resource Group";
            begin
            end;
        }

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
        Text000: label 'cannot be specified when %1 is %2';
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
}