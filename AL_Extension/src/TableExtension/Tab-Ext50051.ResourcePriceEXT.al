TableExtension 50051 "Work TypeEXT" extends "Work Type"
{

    //DYS page addon non migrer
    //Permissions = TableData 8004161 = rm;

    fields
    {
        field(8001701; Reevaluated; Option)
        {
            Caption = 'Reevaluated';
            OptionCaption = 'Reevaluated,Not reevaluated,Asked,Charge Rate';
            OptionMembers = Reevaluated,"Not reevaluated",Asked,"Charge Rate";
        }
        field(8003901; Monday; Boolean)
        {
            Caption = 'Monday';
        }
        field(8003902; Tuesday; Boolean)
        {
            Caption = 'Tuesday';
        }
        field(8003903; Wednesday; Boolean)
        {
            Caption = 'Wednesday';
        }
        field(8003904; Thursday; Boolean)
        {
            Caption = 'Thursday';
        }
        field(8003905; Friday; Boolean)
        {
            Caption = 'Friday';
        }
        field(8003906; Saturday; Boolean)
        {
            Caption = 'Saturday';
        }
        field(8003907; Sunday; Boolean)
        {
            Caption = 'Sunday';
        }
        field(8003908; Holiday; Boolean)
        {
            Caption = 'Holiday';
        }
        field(8003909; "Job Absence No."; Code[20])
        {
            Caption = 'Job Absence No.';
            TableRelation = Job where(Blocked = const(" "));
        }
        field(8003911; "Work Time Type"; Option)
        {
            Caption = 'Work Time Type';
            OptionCaption = ' ,Producted Hours,Unproduced Hours,Absence Hours,Premium,Transport,Meal';
            OptionMembers = " ","Producted Hours","Unproduced Hours","Absence Hours",Premium,Transport,Meal;

            trigger OnValidate()
            var
                lJobLedgerEntry: Record "Job Ledger Entry";
            begin
                if "Work Time Type" <> xRec."Work Time Type" then
                    if not Confirm(
                                   TextChangeWorkTimeType +
                                   TextModify,
                                   true,
                                   FieldCaption("Work Time Type")) then
                        Error('')
                    else begin
                        lJobLedgerEntry.SetCurrentkey(Type, "No.", "Posting Date", "Job No.", "Work Type Code");
                        lJobLedgerEntry.SetRange("Work Type Code", Code);
                        lJobLedgerEntry.ModifyAll("Work Time Type", "Work Time Type");
                    end;
            end;
        }
        field(8003912; "Increase %"; Decimal)
        {
            BlankZero = true;
            Caption = 'Increase %';
        }
        field(8003913; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(8004000; "Posted Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry".Quantity where("Work Type Code" = field(Code),
                                                                 Type = const(Resource),
                                                                 "No." = field("Resource Filter"),
                                                                 "Posting Date" = field("Date Filter"),
                                                                 "Mission No." = field("Mission Filter")));
            Caption = 'Posted Quantity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004001; "Journal Line Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Quantity (Base)" where("Work Type Code" = field(Code),
                                                                           Type = const(Resource),
                                                                           "No." = field("Resource Filter"),
                                                                           "Planning Date" = field("Date Filter")));
            Caption = 'Journal Line Quantity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004002; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(8004003; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource where(Type = const(Person),
                                            Status = filter(Internal .. External));
        }
        field(8004004; "Mission Filter"; Code[20])
        {
            Caption = 'Mission Filter';
            FieldClass = FlowFilter;
            TableRelation = "Interim Mission"."Mission No." where("Resource No." = field("Resource Filter"));
        }
        field(8004130; "Quantity (Base) in Hours"; Boolean)
        {
            Caption = 'Quantity (Base) in Hours';

            trigger OnValidate()
            var
                lJobLedgerEntry: Record "Job Ledger Entry";
                TextChangeWorkTimeType: label 'If you change %1, job ledger entries will be change.\';
                TextModify: label 'Do you want to change %1?';
            begin
                //RES_USAGE\\
                if "Quantity (Base) in Hours" <> xRec."Quantity (Base) in Hours" then
                    if not Confirm(TextChangeWorkTimeType + TextModify, true, FieldCaption("Quantity (Base) in Hours")) then
                        Error('')
                    else begin
                        lJobLedgerEntry.SetRange("Work Type Code", Code);
                        if lJobLedgerEntry.FindSet then
                            repeat
                                if "Quantity (Base) in Hours" then begin
                                    lJobLedgerEntry."Qty. per Unit of Measure" := 1;
                                    lJobLedgerEntry."Quantity (Base)" := lJobLedgerEntry.Quantity;
                                end else begin
                                    lJobLedgerEntry."Qty. per Unit of Measure" := 0;
                                    lJobLedgerEntry."Quantity (Base)" := 0;
                                end;
                                lJobLedgerEntry.Modify;
                            until lJobLedgerEntry.Next = 0;
                    end;
            end;
        }
        field(8004132; "Working Time On Order"; Boolean)
        {
            Caption = 'Working Time On Order';
        }
        field(8004134; "Planning Color"; Integer)
        {
            BlankZero = true;
            Caption = 'Planning Color';

            trigger OnValidate()
            begin
                //PLANNING\\
            end;
        }
    }
    keys
    {
        /* GL2024  key(STG_Key2; "Work Time Type", "Code")
           {
           }*/
    }

    var
        TextChangeWorkTimeType: label 'If you change %1, job ledger entries will be change.\';
        TextModify: label 'Do you want to change %1?';
}

