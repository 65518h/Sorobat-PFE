Table 8004031 "Resource / Resource Group"
{
    // //PLANNING GESWAY 25/09/02 Liste des groupes de ressource par ressource
    // //+REF+REPLIC AC 28/06/05 OnInsert, OnModify, OnDelete, OnRename
    //                           + field "Replication" (ID = 73754 ), boolean, editable=No

    Caption = 'Resource / Resource Group';
    // DrillDownPageID = 8004033;
    //LookupPageID = 8004033;

    fields
    {
        field(1; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            NotBlank = true;
            TableRelation = Resource."No." where(Type = filter(Person | Machine));
        }
        field(2; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group  No.';
            TableRelation = "Resource Group";
        }
        field(3; Name; Text[50])
        {
            CalcFormula = lookup(Resource.Name where("No." = field("Resource No.")));
            Caption = 'Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Name Gp"; Text[50])
        {
            CalcFormula = lookup("Resource Group".Name where("No." = field("Resource Group No.")));
            Caption = 'Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Weight; Decimal)
        {
            //blankzero = true;
            Caption = 'Weight';
            InitValue = 1;
            MinValue = 1;
        }
        field(39; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(40; "Unit of Measure Filter"; Code[10])
        {
            Caption = 'Unit of Measure Filter';
            FieldClass = FlowFilter;
            TableRelation = "Unit of Measure";
        }
        field(41; Capacity; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Res. Capacity Entry".Capacity where("Resource No." = field(filter("Resource No.")),
                                                                    Date = field("Date Filter"),
                                                                    "Resource Group No." = field(filter("Resource Group No."))));
            Caption = 'Capacity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(44; "Usage (Qty.)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Res. Ledger Entry"."Quantity (Base)" where("Entry Type" = const(Usage),
                                                                           Chargeable = field("Chargeable Filter"),
                                                                           "Resource No." = field("Resource No."),
                                                                           "Posting Date" = field("Date Filter")));
            Caption = 'Usage (Qty.)';
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Usage (Cost)"; Decimal)
        {
            AutoFormatType = 2;
            //blankzero = true;
            CalcFormula = sum("Res. Ledger Entry"."Total Cost" where("Entry Type" = const(Usage),
                                                                      Chargeable = field("Chargeable Filter"),
                                                                      "Resource No." = field("Resource No."),
                                                                      "Posting Date" = field("Date Filter")));
            Caption = 'Usage (Cost)';
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; "Usage (Price)"; Decimal)
        {
            AutoFormatType = 2;
            //blankzero = true;
            CalcFormula = sum("Res. Ledger Entry"."Total Price" where("Entry Type" = const(Usage),
                                                                       Chargeable = field("Chargeable Filter"),
                                                                       "Posting Date" = field("Date Filter"),
                                                                       "Resource No." = field("Resource No.")));
            Caption = 'Usage (Price)';
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Chargeable Filter"; Boolean)
        {
            Caption = 'Chargeable Filter';
            FieldClass = FlowFilter;
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8003953; "Default Number Of Resources"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Task Assignment".Quantity where("Task No." = field("Task No. Filter"),
                                                                         "No." = field("Resource Group No.")));
            Caption = 'Default Number Of Resources';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            InitValue = 1;
        }
        field(8004130; "Period Planning Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where(Date = field("Date Filter"),
                                                               "No." = field(filter("Resource No.")),
                                                               Private = const(false),
                                                               Status = filter(<> Deleted),
                                                               "Resource Group No." = field("Resource Group No.")));
            Caption = 'Planning Quantity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004131; "Period Planning Task Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where("No." = field(filter("Resource No.")),
                                                               Date = field("Date Filter"),
                                                               Private = const(false),
                                                               "Planning Task No." = field("Task No. Filter"),
                                                               "Resource Group No." = field("Resource Group No.")));
            Caption = 'Planning Task Quantity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004162; "Job. Posted Quantity (Base)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry"."Quantity (Base)" where("No." = field(filter("Resource No.")),
                                                                          "Entry Type" = const(Usage),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Resource Group No." = field("Resource Group No.")));
            Caption = 'Posted Quantity (Base)';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004166; "Res. Posted Quantity (Base)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Res. Ledger Entry"."Quantity (Base)" where("Entry Type" = const(Usage),
                                                                           Chargeable = field("Chargeable Filter"),
                                                                           "Resource No." = field(filter("Resource No.")),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Planning Source" = const(true),
                                                                           "Resource Group No." = field("Resource Group No.")));
            Caption = 'Posted Planning Quantity (Base)';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8035003; "Task No. Filter"; Text[20])
        {
            Caption = 'Task No. Filter';
            FieldClass = FlowFilter;
        }
        field(8035004; Imposed; Boolean)
        {
            CalcFormula = exist("Planning Task Assignment" where("Task No." = field("Task No. Filter"),
                                                                  "No." = field("Resource No."),
                                                                  Type = const(Resource)));
            Caption = 'Imposed';
            FieldClass = FlowField;
        }
        field(8035005; "In Skill"; Boolean)
        {
            CalcFormula = exist("Resource / Planning Skill" where("Skill Code" = field("Skill Group Filter")));
            Caption = 'In Skill';
            FieldClass = FlowField;
        }
        field(8035009; "Skill Group Filter"; Code[20])
        {
            Caption = 'Skill Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
    }

    keys
    {
        key(Key1; "Resource No.", "Resource Group No.")
        {
        }
        key(Key2; "Resource Group No.", "Resource No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = Weight;
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
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
}

