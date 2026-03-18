Table 8001430 "Replication Table"
{
    // //+REF+REPLIC CW 02/02/05 Replication setup table list

    Caption = 'Replicate Table';

    fields
    {
        field(1; "Table No."; Integer)
        {
            //blankzero = true;
            Caption = 'Table No.';
            NotBlank = true;
            //GL2024 License  TableRelation = Object.ID where(Type = const(Table));

            //GL2024 License    
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(2; Name; Text[30])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Name" where("Object Type" = const(Table),
                                                                        "Object ID" = field("Table No.")));
            Caption = 'Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; Caption; Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Table),
                                                                           "Object ID" = field("Table No.")));
            Caption = 'Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Field Exception"; Integer)
        {
            //blankzero = true;
            CalcFormula = count("Replication Exception" where("Table No." = field("Table No.")));
            Caption = 'Field Exception';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Editable; Boolean)
        {
            Caption = 'Editable';
        }
    }

    keys
    {
        key(STG_Key1; "Table No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lField: Record "Field";
    begin
        if not lField.Get("Table No.", 73754) then // 73754 is for R E P L I on a mobile phone keyboard !
            Error(tNoReplication, "Table No.");
    end;

    var
        tNoReplication: label 'Table %1 is not define for replication.';
        tNoTable: label 'No table to replace.';
        tConfirmCopy1: label 'Do you want to replace table "%1"?';
        tConfirmCopyMany: label 'Do you want to replace these % selected tables?';


    procedure Replace()
    var
        lReplicationSetup: Record "Replication Setup";
        lReplicationMgt: Codeunit "Replication Management";
    begin
        lReplicationSetup.Get;
        with Rec do begin
            if not Find('-') then
                Error(tNoTable)
            else
                if Next = 0 then begin
                    CalcFields(Caption);
                    if not Confirm(tConfirmCopy1, false, Caption) then
                        exit;
                end else
                    if not Confirm(tConfirmCopyMany, false, Count) then
                        exit;
            lReplicationMgt.HideConfirmation();
            if Find('-') then begin
                repeat
                    lReplicationMgt.CopyTable(lReplicationSetup."Company Name", "Table No.");
                until Next = 0;
            end;
        end;
    end;


    procedure Exceptions()
    var
        lReplicationException: Record "Replication Exception";
    begin
        lReplicationException.SetRange("Table No.", "Table No.");
        //DYS page Addon non migrer
        //Page.Run(page::"Replication Exceptions", lReplicationException);
    end;


    procedure Fill()
    var
        //GL2024 License   lObject: Record "Object";
        //GL2024 License
        lObject: Record AllObj;
        //GL2024 License
        lField: Record "Field";
        lProgress: Codeunit "Progress Dialog2";
    begin
        Init;
        lObject.SetRange("Object Type", lObject."Object Type"::Table);
        lProgress.Open('', lObject.Count);
        repeat
            lProgress.Update;
            "Table No." := lObject."Object ID";
            if lField.Get(lObject."Object ID", 73754) then
                if not Get("Table No.") then
                    Insert;
        until lObject.Next = 0;
        lProgress.Close;
    end;
}

