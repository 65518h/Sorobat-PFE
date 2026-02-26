Codeunit 8001538 "Workflow Add-on Integr."
{
    //GL2024  ID dans Nav 2009 : "8004205"
    // //NDF CW 16/11/07
    // //NAVIBAT MB 01/06/07 Reordering Requisition,NaviBat Jon Card, Job Stats, Structure Card

    Permissions = TableData "Vendor Ledger Entry" = rm;

    trigger OnRun()
    var
        lBefore: Integer;
    begin
        lBefore := WorkFLowType.Count;
        //GL2024  InsertTypes;
        Message(tInserted, WorkFLowType.TableCaption, WorkFLowType.Count - lBefore)
    end;

    var
        WorkFLowType: Record "Workflow Type";
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
        Resource: Record Resource;
        Job: Record Job;
        tIsRequired: label '%1 is required';
        tActionNotEnable: label 'Action not enable on form %1';
        tTriggerNotEnable: label 'Trigger %2 not enable on form %1';
        tDoesntExists: label '%1 %2 doesn''t exist';
        tInserted: label '%2 %1 inserted';
        tBlock: label 'Block';
        tRelease: label 'Release';


    /*
    GL2024 NAVIBAT
    procedure InsertTypes()
    begin
        with WorkFLowType do begin

            //NAVIBAT
            InsertType(page::"Reordering Requisition", false, 0);
            InsertType(page::"NaviBat Job Card", false, Database::Job);
            InsertType(page::"Job Stats", false, 0);
            InsertType(page::"Structure Card", false, Database::Resource);
            InsertType(page::"Other Resources", false, Database::Resource);
            InsertType(page::"Machine Resource", false, Database::Resource);
            //NAVIBAT//
            //+NDF+
            InsertType(page::"Note of Expenses", false, 0);
            //+NDF+//
        end;
    end;*/


    /*   
        GL2024 NAVIBAT
    procedure GetRec(pType: Integer; pJnlTemplate: Code[10]; pNo: Code[20]) Return: Boolean
       var
           lWorkflowType: Record 8004200;
       begin
           case pType of
               //NAVIBAT
               page::"Reordering Requisition":
                   if SalesHeader.ReadPermission then
                       Return := SalesHeader.Get(SalesHeader."document type"::Order, pNo)
                   else
                       Return := false;
               page::"NaviBat Job Card":
                   if Job.ReadPermission then
                       Return := Job.Get(pNo)
                   else
                       Return := false;
               page::"Structure Card":
                   if Resource.ReadPermission then
                       Return := Resource.Get(pNo)
                   else
                       Return := false;
               page::"Other Resources":
                   if Resource.ReadPermission then
                       Return := Resource.Get(pNo)
                   else
                       Return := false;
               page::"Machine Resource":
                   if Resource.ReadPermission then
                       Return := Resource.Get(pNo)
                   else
                       Return := false;
               //NAVIBAT//
               //+NDF+
               page::"Note of Expenses":
                   if PurchHeader.ReadPermission then
                       Return := PurchHeader.Get(PurchHeader."document type"::"Note of Expenses", pNo)
                   else
                       Return := false;
               //+NDF+//
               else
                   exit(false);
           end;
       end;
   */
    /*
        GL2024 NAVIBAT
        procedure ShowCard(pType: Integer; pWorksheet: Code[10]; pNo: Code[20]) Return: Boolean
        begin
            Return := true;
            case pType of
                //NAVIBAT
                page::"Job Card":
                    PAGE.Run(pType, Job);
                page::"Reordering Requisition":
                    PAGE.Run(pType, SalesHeader);
                page::"NaviBat Job Card":
                    PAGE.Run(pType, Job);
                page::"Structure Card":
                    PAGE.Run(pType, Resource);
                page::"Other Resources":
                    PAGE.Run(pType, Resource);
                page::"Machine Resource":
                    PAGE.Run(pType, Resource);
                //NAVIBAT//
                //+NDF+
                page::"Note of Expenses":
                    PAGE.Run(pType, PurchHeader);
                //+NDF+//
                else
                    exit(false);
            end;
        end;
    */
    /*
    GL2024 NAVIBAT
        procedure GetName(pType: Integer; pJnlTemplate: Code[10]; pNo: Code[20]) Return: Text[50]
        begin
            if (pType = 0) or (pNo = '') then
                exit('');
            if GetRec(pType, pJnlTemplate, pNo) then
                case pType of
                    //NAVIBAT
                    page::"Job Card":
                        exit(Job.Description);
                    page::"Reordering Requisition":
                        exit(SalesHeader."Bill-to Name");
                    page::"NaviBat Job Card":
                        exit(Job.Description);
                    page::"Structure Card":
                        exit(Resource.Name);
                    page::"Other Resources":
                        exit(Resource.Name);
                    page::"Machine Resource":
                        exit(Resource.Name);
                    //NAVIBAT//
                    //+NDF+
                    page::"Note of Expenses":
                        exit(PurchHeader."Pay-to Name");
                //+NDF+//
                end;
        end;
    */
    /*
    //GL2024 NAVIBAT
        procedure Lookup(pType: Integer; pJnlTemplate: Code[10]; pNo: Code[20]): Code[20]
        begin
            if GetRec(pType, pJnlTemplate, pNo) then;
            case pType of
                //NAVIBAT
                page::"NaviBat Job Card":
                    if Page.RunModal(0, Job) = Action::LookupOK then
                        exit(Job."No.");
                page::"Structure Card":
                    if Page.RunModal(Page::"Structure Card", Resource) = Action::LookupOK then
                        exit(Resource."No.");
                page::"Other Resources":
                    if Page.RunModal(Page::"Structure Card", Resource) = Action::LookupOK then
                        exit(Resource."No.");
                page::"Machine Resource":
                    if Page.RunModal(Page::"Structure Card", Resource) = Action::LookupOK then
                        exit(Resource."No.");
                //NAVIBAT//
                //+NDF+
                page::"Note of Expenses":
                    if Page.RunModal(0, PurchHeader) = Action::LookupOK then
                        exit(PurchHeader."No.");
            //+NDF+//
            end;
            exit(pNo);
        end;
    */
    /*
    GL2024 NAVIBAT
        procedure "Trigger"(pRec: Record 8004210; pTrigger: Integer) Return: Boolean
        var
            lTrigger: Record 8004201;
            lVendorLedgerEntry: Record 25;
            lOnHold: Code[10];
        begin
            Return := true;
            case pRec.Type of
                //NAVIBAT
                page::"Structure Card":
                    with Resource do begin
                        case pTrigger of
                            0:
                                begin
                                    lTrigger.InsertTrigger(pRec.Type, -1, tRelease);
                                    lTrigger.InsertTrigger(pRec.Type, 1, tBlock);
                                    exit;
                                end;
                            -1:
                                Validate(Blocked, false);
                            1:
                                Validate(Blocked, true);
                            else
                                Error(tTriggerNotEnable, pRec.Type, pTrigger);
                        end;
                        Modify;
                    end;
                page::"Other Resources":
                    with Resource do begin
                        case pTrigger of
                            0:
                                begin
                                    lTrigger.InsertTrigger(pRec.Type, -1, tRelease);
                                    lTrigger.InsertTrigger(pRec.Type, 1, tBlock);
                                    exit;
                                end;
                            -1:
                                Validate(Blocked, false);
                            1:
                                Validate(Blocked, true);
                            else
                                Error(tTriggerNotEnable, pRec.Type, pTrigger);
                        end;
                        Modify;
                    end;
                page::"Machine Resource":
                    with Resource do begin
                        case pTrigger of
                            0:
                                begin
                                    lTrigger.InsertTrigger(pRec.Type, -1, tRelease);
                                    lTrigger.InsertTrigger(pRec.Type, 1, tBlock);
                                    exit;
                                end;
                            -1:
                                Validate(Blocked, false);
                            1:
                                Validate(Blocked, true);
                            else
                                Error(tTriggerNotEnable, pRec.Type, pTrigger);
                        end;
                        Modify;
                    end;
                //NAVIBAT//
                //+NDF+
                page::"Note of Expenses":
                    with PurchHeader do begin
                        case pTrigger of
                            0:
                                begin
                                    lTrigger.InsertTrigger(pRec.Type, -1, tRelease);
                                    exit;
                                end;
                            -1:
                                begin
                                    Status := -1;
                                    Codeunit.Run(Codeunit::"Release Purchase Document", PurchHeader);
                                end;
                            else
                                Error(tTriggerNotEnable, pRec.Type, pTrigger);
                        end;
                        Modify;
                    end;
                //+NDF+//
                else
                    exit(false);
            end;
        end;*/
}

