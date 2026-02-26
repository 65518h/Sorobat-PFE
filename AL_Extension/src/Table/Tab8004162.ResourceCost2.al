Table 8004162 "Resource Cost2"
{
    // //POINTAGE GESWAY 22/08/02 Ajout des champs Date début, N° fournisseur, Code mission, N° mission
    //                            Ajout de ces champs dans la clé primaire
    //                            Ajout clé Vendor No.
    //                   10/03/03 Ajout du champ "Resource Group No."
    // //+REF+REPLIC GESWAY 01/02/06 OnInsert + Onmodify + OnDelete + OnRename
    //                               Gestion de la réplication

    Caption = 'Resource Cost';

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Group(Resource),All';
            OptionMembers = Resource,"Group(Resource)",All;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = if (Type = const(Resource)) Resource
            else
            if (Type = const("Group(Resource)")) "Resource Group";

            trigger OnValidate()
            begin
                if (Code <> '') and (Type = Type::All) then
                    FieldError(Code, StrSubstNo(Text000, FieldCaption(Type), Format(Type)));
            end;
        }
        field(3; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(4; "Cost Type"; Option)
        {
            Caption = 'Cost Type';
            OptionCaption = 'Fixed,% Extra,LCY Extra';
            OptionMembers = "Fixed","% Extra","LCY Extra";

            trigger OnValidate()
            begin
                if "Work Type Code" = '' then
                    TestField("Cost Type", "cost type"::Fixed);
            end;
        }
        field(5; "Direct Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
        }
        field(6; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
        }
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

    keys
    {
        key(Key1; Type, "Code", "Work Type Code", "Starting Date", "Vendor No.", "Mission Code", "Mission No.")
        {
            Clustered = true;
        }
        key(Key2; "Cost Type", "Code", "Work Type Code")
        {
        }
        key(Key3; "Vendor No.")
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

