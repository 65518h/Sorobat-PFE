Table 8001554 "Workflow Type"
{
    //GL2024  ID dans Nav 2009 : "39001539"
    //GL2024  ID dans Nav 2009 : "8004200"
    // #7878 CW 08/03/10 + Table ID
    // //+WKF+ CW 03/08/02 New

    Caption = 'Workflow Type';
    DataPerCompany = false;
    //LookupPageID = 8004200;

    fields
    {
        field(1; Type; Integer)
        {
            Caption = 'Type';

            trigger OnValidate()
            var
                lAllObjWithCaption: Record AllObjWithCaption;
            begin
                if lAllObjWithCaption.Get(lAllObjWithCaption."object type"::page, Type) then
                    Description := lAllObjWithCaption."Object Caption";
            end;
        }
        field(2; Description; Text[30])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(page),
                                                                           "Object ID" = field(Type)));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Link Enable"; Boolean)
        {
            Caption = 'Link Enable';
        }
        field(4; "No. of Procedures"; Integer)
        {
            //blankzero = true;
            CalcFormula = count("Workflow Procedure Header" where("Workflow Type" = field(Type)));
            Caption = 'No. of Procedures';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Table ID"; Integer)
        {
            //blankzero = true;
            Caption = 'Table ID';
            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
    }

    keys
    {
        key(Key1; Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lTrigger: Record "Workflow Trigger";
    begin
        lTrigger.SetRange("Workflow Type", Type);
        lTrigger.DeleteAll;
    end;

    trigger OnInsert()
    begin
        // Error(tCodeunitInsertOnly, Codeunit::"Workflow No.");
    end;

    var
        tCodeunitInsertOnly: label 'New types must be defined in codeunit %1';
    //    WorkflowNo: Codeunit "Workflow No.";


    procedure InsertType(pType: Integer; pLinkEnable: Boolean; pTableID: Integer)
    var
        lRec: Record "Workflow Type";
        lWorkflowJnlLine: Record "Workflow Journal Line";
        lWorkflowTemplate: Record "Workflow Document Template";
    begin
        //DYS PAGE ADDON NON MIGRER
        // if pType <> page::"Workflow Document Card" then begin
        //     lRec.Type := pType;
        //     lRec.Validate(Type);
        //     lRec."Link Enable" := pLinkEnable;
        //     lRec."Table ID" := pTableID;
        //     if lRec.Insert then;
        //     lWorkflowJnlLine.Type := pType;
        //     WorkflowNo.trigger(lWorkflowJnlLine);
        //     END
        //     else IF NOT lWorkflowTemplate.IsEmpty THEN
        //   if lWorkflowTemplate.Find('-') then
        //         repeat
        //             lRec.Type := lWorkflowTemplate."Document Template";
        //             lRec.Validate(Type);
        //             lRec."Link Enable" := false;
        //             if lRec.Insert then;
        //             lWorkflowJnlLine.Type := lRec.Type;
        //             WorkflowNo.lWorkflowJnlLine,0);
        //             lWorkflowTemplate.Next = 0;
        //             UNTIL lWorkflowTemplate.NEXT = 0;

    end;
}

