Codeunit 8001539 "Workflow UserExit"
{
    //GL2024  ID dans Nav 2009 : "8004206"
    // #7694 CW 25/11/09
    // //+WKF+WORKFLOW CW 25/11/09
    // To define a new Workflow Type (Ex : page::"New Form" on table "New Table" with "No." as primary key and "Name" as description)
    // 
    // 1) Declare Global variable of relative record datatype :
    //     NewTable Record "New Table"
    // 2) InsertTypes, add this call to insert a new line in Workflow type table :
    //     InsertType(page::"New Form");
    // 3) GetRec : Get relative record
    //     page::"New Form":
    //       Return := NewTable.GET(pNo);
    // 4) ShowCard :
    //     PAGE.Run(pType,NewTable);
    // 5) GetName
    //     page::"New form":
    //       EXIT(NewTable.Name);
    // 6) Lookup (for Document link only, Optionnal)
    //     IF Page.RunModal(0,NewTable) = ACTION::LookupOK THEN
    //       EXIT(NewTable."No.");
    // 7) Trigger (if action in needed, Optionnal)
    //     Copy existing lines as template and customize
    // 
    // Save this codeunit, then RUN IT to insert the new workflow type in "Workflow Type" table.

    Permissions = TableData "Vendor Ledger Entry" = rm;

    trigger OnRun()
    var
        lBefore: Integer;
    begin
        lBefore := WorkFLowType.Count;
        InsertTypes;
        Message(tInserted, WorkFLowType.TableCaption, WorkFLowType.Count - lBefore)
    end;

    var
        WorkFLowType: Record "Workflow Type";
        Job: Record Job;
        tIsRequired: label '%1 is required';
        tActionNotEnable: label 'Action not enable on form %1';
        tTriggerNotEnable: label 'Trigger %2 not enable on form %1';
        tDoesntExists: label '%1 %2 doesn''t exist';
        tInserted: label '%2 %1 inserted';
        tBlock: label 'Block';
        tRelease: label 'Release';


    procedure InsertTypes()
    begin
        with WorkFLowType do begin
            //USEREXIT
            InsertType(page::"Job Card", false, Database::"Job");
            //USEREXIT//
        end;
    end;


    procedure GetRec(pType: Integer; pJnlTemplate: Code[10]; pNo: Code[20]) Return: Boolean
    var
        lWorkflowType: Record "Workflow Type";
    begin
        case pType of
            //USEREXIT
            page::"Job Card":
                if Job.ReadPermission then
                    Return := Job.Get(pNo)
                else
                    Return := false;
        //USEREXIT//
        end;
    end;


    procedure ShowCard(pType: Integer; pWorksheet: Code[10]; pNo: Code[20]) Return: Boolean
    var
        lAllObjWithCaption: Record AllObjWithCaption;
    begin
        Return := true;
        case pType of
            //USEREXIT
            page::"Job Card":
                PAGE.Run(pType, Job);
            //USEREXIT//
            else
                exit(false);
        end;
    end;


    procedure GetName(pType: Integer; pJnlTemplate: Code[10]; pNo: Code[20]) Return: Text[50]
    begin
        if (pType = 0) or (pNo = '') then
            exit('');
        if GetRec(pType, pJnlTemplate, pNo) then
            case pType of
                //USEREXIT
                page::"Job Card":
                    exit(Job.Description);
            //USEREXIT//
            end;
    end;


    procedure Lookup(pType: Integer; pJnlTemplate: Code[10]; pNo: Code[20]): Code[20]
    begin
        if GetRec(pType, pJnlTemplate, pNo) then;
        case pType of
            //USEREXIT
            page::"Job Card":
                if Page.RunModal(0, Job) = Action::LookupOK then
                    exit(Job."No.");
        //USEREXIT//
        end;
        exit(pNo);
    end;


    procedure "Trigger"(pRec: Record "Workflow Journal Line"; pTrigger: Integer) Return: Boolean
    var
        lTrigger: Record "Workflow Trigger";
        lVendorLedgerEntry: Record "Vendor Ledger Entry";
        lOnHold: Code[10];
    begin
        Return := true;
        if pTrigger <> 0 then
            if not GetRec(pRec.Type, pRec."Template Name", pRec."No.") then
                exit;
        case pRec.Type of
            //USEREXIT
            page::"Job Card":
                with Job do begin
                    case pTrigger of
                        0:
                            begin
                                lTrigger.InsertTrigger(pRec.Type, -1, tRelease);
                                lTrigger.InsertTrigger(pRec.Type, 1, tBlock);
                                exit;
                            end;
                        -1:
                            Validate(Blocked, 0);
                        1:
                            Validate(Blocked, 1);
                        else
                            Error(tTriggerNotEnable, pRec.Type, pTrigger);
                    end;
                    Modify;
                end;
            //USEREXIT//
            else
                exit(false);
        end;
    end;
}

