Table 8001494 "OutlookLink Compare Buffer"
{
    // //OUTLOOKLINK CW 05/05/11


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Table No."; Integer)
        {
            Caption = 'Table No.';
        }
        field(3; "Field No."; Integer)
        {
            Caption = 'Field No.';
        }
        field(4; "Dynamics-NAV"; Text[250])
        {
            Caption = 'Dynamics-NAV';
        }
        field(5; Outlook; Text[250])
        {
            Caption = 'Outlook';
            Editable = false;
        }
        field(6; Changed; Boolean)
        {
            Caption = 'Changed';
        }
        field(103; "Field Caption"; Text[250])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."),
                                                              "No." = field("Field No.")));
            Caption = 'Field Caption';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Changed := (UpperCase("Dynamics-NAV") <> UpperCase(Outlook));
    end;

    trigger OnModify()
    begin
        Changed := (UpperCase("Dynamics-NAV") <> UpperCase(Outlook));
    end;

    var
        gRecordRef: RecordRef;


    procedure Set(var pRecordRef: RecordRef)
    begin
        gRecordRef := pRecordRef;
        SetRange(Changed);
        DeleteAll;
    end;


    procedure Add(pFieldNo: Integer; pDynamicsNAV: Text[250]; pOutlook: Text[250])
    var
        lFieldRef: FieldRef;
    begin
        if (pOutlook = '') and (pDynamicsNAV = '') then
            exit;
        "Entry No." += 1;
        "Table No." := gRecordRef.Number;
        "Field No." := pFieldNo;
        "Dynamics-NAV" := pDynamicsNAV;
        Outlook := pOutlook;
        //lFieldRef := gRecordRef.FIELD(pFieldNo);
        //"Field Caption" := lFieldRef.CAPTION;
        Insert(true);
    end;
}

