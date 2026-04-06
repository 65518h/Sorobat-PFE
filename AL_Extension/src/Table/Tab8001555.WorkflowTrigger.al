Table 8001555 "Workflow Trigger"
{
    //GL2024  ID dans Nav 2009 : "8004201"
    // //+WKF+ CW 13/12/02 New

    Caption = 'Workflow Trigger';
    DataPerCompany = false;
    // DrillDownPageID = 8004201;
    //LookupPageID = 8004201;

    fields
    {
        field(1; "Workflow Type"; Integer)
        {
            Caption = 'Type';
            TableRelation = "Workflow Type";

            trigger OnValidate()
            var
                lAllObjWithCaption: Record AllObjWithCaption;
            begin
            end;
        }
        field(2; "Trigger ID"; Integer)
        {
            Caption = 'Trigger ID';
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(STG_Key1; "Workflow Type", "Trigger ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Error(tCodeunitInsertOnly, Codeunit::"Workflow No.");
    end;

    var
        tCodeunitInsertOnly: label 'New types must be defined in codeunit %1';


    procedure InsertTrigger(pType: Integer; pTriggerID: Integer; pDescription: Text[30])
    var
        lRec: Record "Workflow Trigger";
    begin
        lRec."Workflow Type" := pType;
        lRec."Trigger ID" := pTriggerID;
        lRec.Description := pDescription;
        if lRec.Insert then;
    end;
}

