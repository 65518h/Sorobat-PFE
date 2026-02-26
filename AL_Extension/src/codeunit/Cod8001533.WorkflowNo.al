Codeunit 8001533 "Workflow No."
{
    //GL2024  ID dans Nav 2009 : "8004200"
    // //+WKF+ CW 23/08/02 Apply to Record
    // //+WKF+CUSTOM CW 05/12/02 "Posted Purchase Invoice" release "On hold" on vendor ledger entry

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
        WorkFlowTemplate: Record "Workflow Document Template";
        WorkFlowDocument: Record "Workflow Document";
        WorkflowAddOnIntegr: Codeunit "Workflow Add-on Integr.";
        WorkflowUserExit: Codeunit "Workflow UserExit";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesHeaderArchive: Record "Sales Header Archive";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        PurchHeader: Record "Purchase Header";
        PurchHeaderArchive: Record "Purchase Header Archive";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        Resource: Record Resource;
        Job: Record Job;
        GLBudgetName: Record "G/L Budget Name";
        BankAcct: Record "Bank Account";
        ReminderHeader: Record "Reminder Header";
        IssuedReminderHeader: Record "Issued Reminder Header";
        Contact: Record Contact;
        Segment: Record "Segment Header";
        Employee: Record Employee;
        FixedAsset: Record "Fixed Asset";
        TransferHeader: Record "Transfer Header";
        ServHeader: Record "Service Header";
        NonStockItem: Record "Nonstock Item";
        Loaner: Record Loaner;
        ServiceItem: Record "Service Item";
        ServiceContract: Record "Service Contract Header";
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnShipmentHeader: Record "Return Shipment Header";
        MachineCenter: Record "Machine Center";
        WorkCenter: Record "Work Center";
        Routing: Record "Routing Header";
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionOrder: Record "Production Order";
        tIsRequired: label '%1 is required';
        tActionNotEnable: label 'Action not enable on form %1';
        tTriggerNotEnable: label 'Trigger %2 not enable on form %1';
        tDoesntExists: label '%1 %2 doesn''t exist';
        tInserted: label '%2 %1 inserted';
        ReqWkshName: Record "Requisition Wksh. Name";
        ReqLine: Record "Requisition Line";
        tBlock: label 'Block';
        tRelease: label 'Release';


    procedure InsertTypes()
    begin
        with WorkFLowType do begin
            // Documents
            InsertType(page::"Customer Card", true, Database::Customer);
            InsertType(page::"Vendor Card", true, Database::Vendor);
            InsertType(page::"Item Card", true, Database::Item);
            InsertType(page::"Sales Quote", false, 0);
            InsertType(page::"Sales Order", false, 0);
            InsertType(page::"Sales Invoice", false, 0);
            InsertType(page::"Sales Credit Memo", false, 0);
            InsertType(page::"Purchase Quote", false, 0);
            InsertType(page::"Purchase Order", false, 0);
            InsertType(page::"Purchase Invoice", false, 0);
            InsertType(page::"Purchase Credit Memo", false, 0);
            InsertType(page::"Resource Card", false, Database::Resource);
            //USEREXIT
            /*
              InsertType(page::"Job Card",FALSE,Database::"Job");
            */
            //USEREXIT//
            InsertType(page::Budget, false, 0);
            InsertType(page::"Posted Sales Shipment", true, Database::"Sales Shipment Header");
            InsertType(page::"Posted Sales Invoice", false, Database::"Sales Invoice Header");
            InsertType(page::"Posted Sales Credit Memo", false, Database::"Sales Cr.Memo Header");
            InsertType(page::"Posted Purchase Receipt", true, Database::"Purch. Rcpt. Header");
            InsertType(page::"Posted Purchase Invoice", false, Database::"Purch. Inv. Header");
            InsertType(page::"Posted Purchase Credit Memo", false, Database::"Purch. Cr. Memo Hdr.");
            InsertType(page::"Bank Account Card", false, Database::"Bank Account");
            InsertType(page::Reminder, false, Database::"Reminder Header");
            InsertType(page::"Issued Reminder", false, Database::"Issued Reminder Header");
            InsertType(page::"Blanket Sales Order", false, 0);
            InsertType(page::"Blanket Purchase Order", false, 0);
            InsertType(page::"Contact Card", false, Database::Contact);
            InsertType(page::Segment, false, Database::"Segment Header");
            InsertType(page::"Employee Card", false, Database::Employee);
            InsertType(page::"Fixed Asset Card", false, Database::"Fixed Asset");
            //#8614
            InsertType(page::"Transfer Order", false, Database::"Transfer Header");
            //#8614//
            InsertType(page::"Service Order", false, 0);
            InsertType(page::"Service Quote", false, 0);
            InsertType(page::"Loaner Card", false, 0);
            InsertType(page::"Service Item Card", false, Database::"Service Item");
            InsertType(page::"Service Contract", false, 0);
            InsertType(page::"Service Contract Quote", false, 0);
            InsertType(page::"Sales Return Order", false, 0);
            InsertType(page::"Purchase Return Order", false, 0);
            InsertType(page::"Posted Return Receipt", false, 0);
            InsertType(page::"Posted Return Shipment", false, 0);
            InsertType(page::"Work Center Card", false, Database::"Work Center");
            InsertType(page::"Machine Center Card", false, Database::"Machine Center");
            InsertType(page::Routing, false, Database::"Routing Comment Line");
            InsertType(page::"Production BOM", false, Database::"Production BOM Comment Line");
            InsertType(page::"Planned Production Order", false, 0);
            InsertType(page::"Firm Planned Prod. Order", false, 0);
            InsertType(page::"Released Production Order", false, 0);
            InsertType(page::"Finished Production Order", false, 0);
            InsertType(page::"Simulated Production Order", false, 0);

            // Journals
            InsertType(page::"Req. Worksheet", false, 0);

            // Workflow Documents
            //GL2024 NAVIBAT   InsertType(page::"Workflow Document Card", false, 0);
            //  InsertType(page::"Workflow Document Card1",FALSE,0);
            //  InsertType(page::"Workflow Document Card2",FALSE,,0);

            //GL2024    WorkflowAddOnIntegr.InsertTypes();
            WorkflowUserExit.InsertTypes();
        end;

    end;


    procedure GetRec(pType: Integer; pJnlTemplate: Code[10]; pNo: Code[20]) Return: Boolean
    var
        lWorkflowType: Record "Workflow Type";
    begin
        case pType of
            0:
                ;
            page::"Customer Card":
                if Customer.ReadPermission then
                    Return := Customer.Get(pNo)
                else
                    Return := false;
            page::"Vendor Card":
                if Vendor.ReadPermission then
                    Return := Vendor.Get(pNo)
                else
                    Return := false;
            page::"Item Card":
                if Item.ReadPermission then
                    Return := Item.Get(pNo)
                else
                    Return := false;
            page::"Sales Quote":
                if SalesHeader.ReadPermission then
                    Return := SalesHeader.Get(SalesHeader."document type"::Quote, pNo)
                else
                    Return := false;
            page::"Sales Order":
                if SalesHeader.ReadPermission then
                    Return := SalesHeader.Get(SalesHeader."document type"::Order, pNo)
                else
                    Return := false;
            page::"Sales Invoice":
                if SalesHeader.ReadPermission then
                    Return := SalesHeader.Get(SalesHeader."document type"::Invoice, pNo)
                else
                    Return := false;
            page::"Sales Credit Memo":
                if SalesHeader.ReadPermission then
                    Return := SalesHeader.Get(SalesHeader."document type"::"Credit Memo", pNo)
                else
                    Return := false;
            page::"Purchase Quote":
                if PurchHeader.ReadPermission then
                    Return := PurchHeader.Get(PurchHeader."document type"::Quote, pNo)
                else
                    Return := false;
            page::"Purchase Order":
                if PurchHeader.ReadPermission then
                    Return := PurchHeader.Get(PurchHeader."document type"::Order, pNo)
                else
                    Return := false;
            page::"Purchase Invoice":
                if PurchHeader.ReadPermission then
                    Return := PurchHeader.Get(PurchHeader."document type"::Invoice, pNo)
                else
                    Return := false;
            page::"Purchase Credit Memo":
                if PurchHeader.ReadPermission then
                    Return := PurchHeader.Get(PurchHeader."document type"::"Credit Memo", pNo)
                else
                    Return := false;
            page::"Resource Card":
                if Resource.ReadPermission then
                    Return := Resource.Get(pNo)
                else
                    Return := false;
            //USEREXIT
            /*
              page::"Job Card":
                IF Job.READPERMISSION THEN
                  Return := Job.GET(pNo)
                ELSE
                  Return := FALSE;
            */
            //USEREXIT//
            page::Budget:
                if GLBudgetName.ReadPermission then
                    Return := GLBudgetName.Get(pNo)
                else
                    Return := false;
            page::"Posted Sales Shipment":
                if SalesShptHeader.ReadPermission then
                    Return := SalesShptHeader.Get(pNo)
                else
                    Return := false;
            page::"Posted Sales Invoice":
                if SalesInvHeader.ReadPermission then
                    Return := SalesInvHeader.Get(pNo)
                else
                    Return := false;
            page::"Posted Sales Credit Memo":
                if SalesCrMemoHeader.ReadPermission then
                    Return := SalesCrMemoHeader.Get(pNo)
                else
                    Return := false;
            page::"Posted Purchase Receipt":
                if PurchRcptHeader.ReadPermission then
                    Return := PurchRcptHeader.Get(pNo)
                else
                    Return := false;
            page::"Posted Purchase Invoice":
                if PurchInvHeader.ReadPermission then
                    Return := PurchInvHeader.Get(pNo)
                else
                    Return := false;
            page::"Posted Purchase Credit Memo":
                if PurchCrMemoHeader.ReadPermission then
                    Return := PurchCrMemoHeader.Get(pNo)
                else
                    Return := false;
            page::"Bank Account Card":
                if BankAcct.ReadPermission then
                    Return := BankAcct.Get(pNo)
                else
                    Return := false;
            page::Reminder:
                if ReminderHeader.ReadPermission then
                    Return := ReminderHeader.Get(pNo)
                else
                    Return := false;
            page::"Issued Reminder":
                if IssuedReminderHeader.ReadPermission then
                    Return := IssuedReminderHeader.Get(pNo)
                else
                    Return := false;
            page::"Blanket Sales Order":
                if SalesHeader.ReadPermission then
                    Return := SalesHeader.Get(SalesHeader."document type"::"Blanket Order", pNo)
                else
                    Return := false;
            page::"Blanket Purchase Order":
                if PurchHeader.ReadPermission then
                    Return := PurchHeader.Get(PurchHeader."document type"::"Blanket Order", pNo)
                else
                    Return := false;
            page::"Contact Card":
                if Contact.ReadPermission then
                    Return := Contact.Get(pNo)
                else
                    Return := false;
            page::Segment:
                if Segment.ReadPermission then
                    Return := Segment.Get(pNo)
                else
                    Return := false;
            page::"Employee Card":
                if Employee.ReadPermission then
                    Return := Employee.Get(pNo)
                else
                    Return := false;
            page::"Fixed Asset Card":
                if FixedAsset.ReadPermission then
                    Return := FixedAsset.Get(pNo)
                else
                    Return := false;
            //#8614
            page::"Transfer Order":
                if TransferHeader.ReadPermission then
                    Return := TransferHeader.Get(pNo)
                else
                    Return := false;
            //#8614//
            page::"Service Order":
                if ServHeader.ReadPermission then
                    Return := ServHeader.Get(ServHeader."document type"::Order, pNo)
                else
                    Return := false;
            page::"Service Quote":
                if ServHeader.ReadPermission then
                    Return := ServHeader.Get(ServHeader."document type"::Quote, pNo)
                else
                    Return := false;
            page::"Loaner Card":
                if Loaner.ReadPermission then
                    Return := Loaner.Get(pNo)
                else
                    Return := false;
            page::"Service Item Card":
                if ServiceItem.ReadPermission then
                    Return := ServiceItem.Get(pNo)
                else
                    Return := false;
            page::"Service Contract":
                if ServiceContract.ReadPermission then
                    Return := ServiceContract.Get(ServiceContract."contract type"::Quote, pNo)
                else
                    Return := false;
            page::"Service Contract Quote":
                if ServiceContract.ReadPermission then
                    //GL2024 Return := ServiceContract.Get(ServiceContract."contract type"::"2", pNo)
                    Return := ServiceContract.Get(ServiceContract."contract type"::Template, pNo)
                else
                    Return := false;
            page::"Sales Return Order":
                if SalesHeader.ReadPermission then
                    Return := SalesHeader.Get(SalesHeader."document type"::"Return Order", pNo)
                else
                    Return := false;
            page::"Purchase Return Order":
                if PurchHeader.ReadPermission then
                    Return := PurchHeader.Get(PurchHeader."document type"::"Return Order", pNo)
                else
                    Return := false;
            page::"Posted Return Receipt":
                if ReturnReceiptHeader.ReadPermission then
                    Return := ReturnReceiptHeader.Get(pNo)
                else
                    Return := false;
            page::"Posted Return Shipment":
                if ReturnShipmentHeader.ReadPermission then
                    Return := ReturnShipmentHeader.Get(pNo)
                else
                    Return := false;
            page::"Work Center Card":
                if WorkCenter.ReadPermission then
                    Return := WorkCenter.Get(pNo)
                else
                    Return := false;
            page::"Machine Center Calendar":
                if MachineCenter.ReadPermission then
                    Return := MachineCenter.Get(pNo)
                else
                    Return := false;
            page::Routing:
                if Routing.ReadPermission then
                    Return := Routing.Get(pNo)
                else
                    Return := false;
            page::"Production BOM":
                if ProductionBOMHeader.ReadPermission then
                    Return := ProductionBOMHeader.Get(pNo)
                else
                    Return := false;
            page::"Planned Production Order":
                if ProductionOrder.ReadPermission then
                    Return := ProductionOrder.Get(ProductionOrder.Status::Planned, pNo)
                else
                    Return := false;
            page::"Firm Planned Prod. Order":
                if ProductionOrder.ReadPermission then
                    Return := ProductionOrder.Get(ProductionOrder.Status::"Firm Planned", pNo)
                else
                    Return := false;
            page::"Released Production Order":
                if ProductionOrder.ReadPermission then
                    Return := ProductionOrder.Get(ProductionOrder.Status::Released, pNo)
                else
                    Return := false;
            page::"Finished Production Order":
                if ProductionOrder.ReadPermission then
                    Return := ProductionOrder.Get(ProductionOrder.Status::Finished, pNo)
                else
                    Return := false;
            page::"Simulated Production Order":
                if ProductionOrder.ReadPermission then
                    Return := ProductionOrder.Get(ProductionOrder.Status::Simulated, pNo)
                else
                    Return := false;

            // Journals
            page::"Req. Worksheet":
                if ReqWkshName.ReadPermission then
                    Return := ReqWkshName.Get(pJnlTemplate, pNo)
                else
                    Return := false;

            // Workflow Documents
            else
                if WorkFlowTemplate.Get(pType) then
                    Return := WorkFlowDocument.Get(pType, pNo)

                else
                    /*  //GL2024if WorkflowAddOnIntegr.GetRec(pType, pJnlTemplate, pNo) then
                         exit(true)
                     else*/
                    if WorkflowUserExit.GetRec(pType, pJnlTemplate, pNo) then
                        exit(true)
                    else
                        Error(tActionNotEnable, pType);
        end;

    end;


    procedure ShowCard(pType: Integer; pWorksheet: Code[10]; pNo: Code[20])
    var
        lAllObjWithCaption: Record AllObjWithCaption;
    begin
        if not GetRec(pType, pWorksheet, pNo) then begin
            lAllObjWithCaption.Get(lAllObjWithCaption."object type"::Page, pType);
            //#7694
            //  ERROR(tActionNotEnable,pNo,lAllObjWithCaption."Object Caption",FALSE);
            Error(tActionNotEnable, lAllObjWithCaption."Object Caption");
            //#7694
        end;
        SalesHeader.SetRecfilter;
        case pType of
            page::"G/L Account Card":
                PAGE.Run(pType, GLAccount);
            page::"Customer Card":
                PAGE.Run(pType, Customer);
            page::"Vendor Card":
                PAGE.Run(pType, Vendor);
            page::"Item Card":
                PAGE.Run(pType, Item);
            page::"Sales Quote",
            page::"Sales Order",
            page::"Sales Invoice",
            page::"Sales Credit Memo",
            page::"Blanket Sales Order",
            page::"Sales Return Order":
                begin
                    SalesHeader.SetRecfilter;
                    PAGE.Run(pType, SalesHeader);
                end;
            page::"Purchase Quote",
          page::"Purchase Order",
          page::"Purchase Invoice",
          page::"Purchase Credit Memo",
          page::"Blanket Purchase Order",
          page::"Purchase Return Order":
                PAGE.Run(pType, PurchHeader);
            page::"Resource Card":
                PAGE.Run(pType, Resource);
            //USEREXIT
            /*
              page::"Job Card":
                PAGE.Run(pType,Job);
            */
            //USEREXIT//
            page::Budget:
                PAGE.Run(pType, GLBudgetName);
            page::"Posted Sales Shipment":
                PAGE.Run(pType, SalesShptHeader);
            page::"Posted Sales Invoice":
                PAGE.Run(pType, SalesInvHeader);
            page::"Posted Sales Credit Memo":
                PAGE.Run(pType, SalesCrMemoHeader);
            page::"Posted Purchase Receipt":
                PAGE.Run(pType, PurchRcptHeader);
            page::"Posted Purchase Invoice":
                PAGE.Run(pType, PurchInvHeader);
            page::"Posted Purchase Credit Memo":
                PAGE.Run(pType, PurchCrMemoHeader);
            page::"Bank Account Card":
                PAGE.Run(pType, BankAcct);
            /* GL2024  page::Reminder:
                   PAGE.Run(pType, ReminderHeader);
               page::"Issued Reminder":
                   PAGE.Run(pType, IssuedReminderHeader);
               page::Reminder:
                   PAGE.Run(pType, ReminderHeader);*/
            page::"Contact Card":
                PAGE.Run(pType, Contact);
            page::Segment:
                PAGE.Run(pType, Segment);
            page::"Employee Card":
                PAGE.Run(pType, Employee);
            page::"Fixed Asset Card":
                PAGE.Run(pType, FixedAsset);
            //#8614
            page::"Transfer Order":
                PAGE.Run(pType, TransferHeader);
            //#8614//
            page::"Service Order",
          page::"Service Quote":
                PAGE.Run(pType, ServHeader);
            page::"Loaner Card":
                PAGE.Run(pType, Loaner);
            page::"Service Item Card":
                PAGE.Run(pType, ServiceItem);
            page::"Service Contract",
          page::"Service Contract Quote":
                PAGE.Run(pType, ServiceContract);
            page::"Posted Return Receipt":
                PAGE.Run(pType, ReturnReceiptHeader);
            page::"Posted Return Shipment":
                PAGE.Run(pType, ReturnShipmentHeader);
            page::"Work Center Card":
                PAGE.Run(pType, WorkCenter);
            page::"Machine Center Calendar":
                PAGE.Run(pType, MachineCenter);
            page::Routing:
                PAGE.Run(pType, Routing);
            page::"Production BOM":
                PAGE.Run(pType, ProductionBOMHeader);
            page::"Planned Production Order":
                PAGE.Run(pType, ProductionOrder);
            page::"Firm Planned Prod. Order":
                PAGE.Run(pType, ProductionOrder);
            page::"Released Production Order":
                PAGE.Run(pType, ProductionOrder);
            page::"Finished Production Order":
                PAGE.Run(pType, ProductionOrder);
            page::"Simulated Production Order":
                PAGE.Run(pType, ProductionOrder);
            // Journals
            page::"Req. Worksheet":
                begin
                    ReqLine.FilterGroup := 2;
                    ReqLine.SetRange("Worksheet Template Name", ReqWkshName."Worksheet Template Name");
                    ReqLine.SetRange("Journal Batch Name", pNo);
                    ReqLine.FilterGroup := 0;
                    PAGE.Run(page::"Req. Worksheet", ReqLine);
                end;
        /* //GL2024 else
             if WorkflowAddOnIntegr.ShowCard(pType, pWorksheet, pNo) then
                 exit
             else
                 if WorkflowUserExit.ShowCard(pType, pWorksheet, pNo) then
                     exit
                 else

            // Workflow documents
            begin
                     WorkFlowDocument.SetRange("Document Template", pType);
                     PAGE.Run(pType, WorkFlowDocument);
                 end;*/
        end;

    end;


    procedure GetName(pType: Integer; pJnlTemplate: Code[10]; pNo: Code[20]) Return: Text[50]
    begin
        if (pType = 0) or (pNo = '') then
            exit('');
        if GetRec(pType, pJnlTemplate, pNo) then
            case pType of
                page::"G/L Account Card":
                    exit(GLAccount.Name);
                page::"Customer Card":
                    exit(Customer.Name);
                page::"Vendor Card":
                    exit(Vendor.Name);
                page::"Item Card":
                    exit(Item.Description);
                page::"Sales Quote",
page::"Sales Order",
page::"Sales Invoice",
page::"Sales Credit Memo",
page::"Blanket Sales Order",
page::"Sales Return Order":
                    exit(SalesHeader."Bill-to Name");
                page::"Purchase Quote",
page::"Purchase Order",
page::"Purchase Invoice",
page::"Purchase Credit Memo",
page::"Blanket Purchase Order",
page::"Purchase Return Order":
                    exit(PurchHeader."Pay-to Name");
                page::"Resource Card":
                    exit(Resource.Name);
                //USEREXIT
                /*
                  page::"Job Card":
                    EXIT(Job.Description);
                */
                //USEREXIT//
                page::Budget:
                    exit(GLBudgetName.Description);
                page::"Posted Sales Shipment":
                    exit(SalesShptHeader."Bill-to Name");
                page::"Posted Sales Invoice":
                    exit(SalesInvHeader."Bill-to Name");
                page::"Posted Sales Credit Memo":
                    exit(SalesCrMemoHeader."Bill-to Name");
                page::"Posted Purchase Receipt":
                    exit(PurchRcptHeader."Pay-to Name");
                page::"Posted Purchase Invoice":
                    exit(PurchInvHeader."Pay-to Name");
                page::"Posted Purchase Credit Memo":
                    exit(PurchCrMemoHeader."Pay-to Name");
                page::"Bank Account Card":
                    exit(BankAcct.Name);
                /* GL2024 page::Reminder:
                      exit(ReminderHeader.Name);
                  page::"Issued Reminder":
                      exit(IssuedReminderHeader.Name);
                  page::Reminder:
                      exit(ReminderHeader.Name);
                  page::Reminder:
                      exit(ReminderHeader.Name);*/
                page::"Contact Card":
                    exit(Contact.Name);
                page::Segment:
                    exit(Segment.Description);
                page::"Employee Card":
                    exit(Employee."Last Name");
                page::"Fixed Asset Card":
                    exit(FixedAsset.Description);
                //#8614
                page::"Transfer Order":
                    exit(TransferHeader."Transfer-to Name");
                //#8614//
                page::"Service Order",
page::"Service Quote":
                    exit(ServHeader."Bill-to City");
                page::"Loaner Card":
                    exit(Loaner.Description);
                page::"Service Item Card":
                    exit(ServiceItem.Name);
                page::"Service Contract":
                    exit(ServiceContract.Name);
                page::"Service Contract Quote":
                    exit(ServiceContract.Name);
                page::"Posted Return Receipt":
                    exit(ReturnReceiptHeader."Bill-to Name");
                page::"Posted Return Shipment":
                    exit(ReturnShipmentHeader."Pay-to Name");
                page::"Work Center Card":
                    exit(WorkCenter.Name);
                page::"Machine Center Calendar":
                    exit(MachineCenter.Name);
                page::Routing:
                    exit(Routing.Description);
                page::"Production BOM":
                    exit(ProductionBOMHeader.Description);
                page::"Planned Production Order",
page::"Firm Planned Prod. Order",
page::"Released Production Order",
page::"Finished Production Order",
page::"Simulated Production Order":
                    exit(ProductionOrder.Description);

                // Journals
                page::"Req. Worksheet":
                    exit(ReqWkshName.Description);
            /* //GL2024 else
                 if WorkflowAddOnIntegr.GetName(pType, pJnlTemplate, pNo) <> '' then begin
                 end
                 else
                     if WorkflowUserExit.GetName(pType, pJnlTemplate, pNo) <> '' then begin
                     end

                     // Workflow Documents
                     else
                         if WorkFlowTemplate.Get(pType) then
                             exit(CopyStr(WorkFlowDocument.Subject, 1, MaxStrLen(Return)))
                         else
                             Error(tActionNotEnable, pType);*/
            end;

    end;


    procedure Lookup(pType: Integer; pJnlTemplate: Code[10]; pNo: Code[20]): Code[20]
    begin
        if GetRec(pType, pJnlTemplate, pNo) then;
        case pType of
            page::"Customer Card":
                if Page.RunModal(0, Customer) = Action::LookupOK then
                    exit(Customer."No.");
            page::"Vendor Card":
                if Page.RunModal(0, Vendor) = Action::LookupOK then
                    exit(Vendor."No.");
            page::"Item Card":
                if Page.RunModal(0, Item) = Action::LookupOK then
                    exit(Item."No.");
            page::"Sales Quote",
          page::"Sales Order",
          page::"Sales Invoice",
          page::"Sales Credit Memo",
          page::"Blanket Sales Order",
          page::"Sales Return Order":
                if Page.RunModal(0, SalesHeader) = Action::LookupOK then
                    exit(SalesHeader."No.");
            page::"Purchase Quote",
          page::"Purchase Order",
          page::"Purchase Invoice",
          page::"Purchase Credit Memo",
          page::"Blanket Purchase Order",
          page::"Purchase Return Order":
                if Page.RunModal(0, PurchHeader) = Action::LookupOK then
                    exit(PurchHeader."No.");
            page::"Resource Card":
                if Page.RunModal(0, Resource) = Action::LookupOK then
                    exit(Resource."No.");
            //USEREXIT
            /*
              page::"Job Card":
                IF Page.RunModal(0,Job) = ACTION::LookupOK THEN
                  EXIT(Job."No.");
            */
            //USEREXIT//
            page::Budget:
                if Page.RunModal(0, GLBudgetName) = Action::LookupOK then
                    exit(GLBudgetName.Name);
            page::"Posted Sales Shipment":
                if Page.RunModal(0, SalesShptHeader) = Action::LookupOK then
                    exit(SalesShptHeader."No.");
            page::"Posted Sales Invoice":
                if Page.RunModal(0, SalesInvHeader) = Action::LookupOK then
                    exit(SalesInvHeader."No.");
            page::"Posted Sales Credit Memo":
                if Page.RunModal(0, SalesCrMemoHeader) = Action::LookupOK then
                    exit(SalesCrMemoHeader."No.");
            page::"Posted Purchase Receipt":
                if Page.RunModal(0, PurchRcptHeader) = Action::LookupOK then
                    exit(PurchRcptHeader."No.");
            page::"Posted Purchase Invoice":
                if Page.RunModal(0, PurchInvHeader) = Action::LookupOK then
                    exit(PurchInvHeader."No.");
            page::"Posted Purchase Credit Memo":
                if Page.RunModal(0, PurchCrMemoHeader) = Action::LookupOK then
                    exit(PurchCrMemoHeader."No.");
            page::"Bank Account Card":
                if Page.RunModal(0, BankAcct) = Action::LookupOK then
                    exit(BankAcct."No.");
            /*  GL2024  page::Reminder:
                    if Page.RunModal(0, ReminderHeader) = Action::LookupOK then
                        exit(ReminderHeader."No.");
                page::"Issued Reminder":
                    if Page.RunModal(0, IssuedReminderHeader) = Action::LookupOK then
                        exit(IssuedReminderHeader."No.");
                page::Reminder:
                    if Page.RunModal(0, ReminderHeader) = Action::LookupOK then
                        exit(ReminderHeader."No.");
                page::Reminder:
                    if Page.RunModal(0, ReminderHeader) = Action::LookupOK then
                        exit(ReminderHeader."No.");*/
            page::"Contact Card":
                if Page.RunModal(0, Contact) = Action::LookupOK then
                    exit(Contact."No.");
            page::Segment:
                if Page.RunModal(0, Segment) = Action::LookupOK then
                    exit(Segment."No.");
            page::"Employee Card":
                if Page.RunModal(0, Employee) = Action::LookupOK then
                    exit(Employee."No.");
            page::"Fixed Asset Card":
                if Page.RunModal(0, FixedAsset) = Action::LookupOK then
                    exit(FixedAsset."No.");
            //#8614
            page::"Transfer Order":
                if Page.RunModal(0, TransferHeader) = Action::LookupOK then
                    exit(TransferHeader."No.");
            //#8614//
            page::"Service Order",
          page::"Service Quote":
                if Page.RunModal(0, ServHeader) = Action::LookupOK then
                    exit(ServHeader."No.");
            page::"Loaner Card":
                if Page.RunModal(0, Loaner) = Action::LookupOK then
                    exit(Loaner."No.");
            page::"Service Item Card":
                if Page.RunModal(0, ServiceItem) = Action::LookupOK then
                    exit(ServiceItem."No.");
            page::"Service Contract":
                if Page.RunModal(0, ServiceContract) = Action::LookupOK then
                    exit(ServiceContract."Contract No.");
            page::"Service Contract Quote":
                if Page.RunModal(0, ServiceContract) = Action::LookupOK then
                    exit(ServiceContract."Contract No.");
            page::"Posted Return Receipt":
                if Page.RunModal(0, ReturnReceiptHeader) = Action::LookupOK then
                    exit(ReturnReceiptHeader."No.");
            page::"Posted Return Shipment":
                if Page.RunModal(0, ReturnShipmentHeader) = Action::LookupOK then
                    exit(ReturnShipmentHeader."No.");
            page::"Work Center Card":
                if Page.RunModal(0, WorkCenter) = Action::LookupOK then
                    exit(WorkCenter."No.");
            page::"Machine Center Calendar":
                if Page.RunModal(0, MachineCenter) = Action::LookupOK then
                    exit(MachineCenter."No.");
            page::Routing:
                if Page.RunModal(0, Routing) = Action::LookupOK then
                    exit(Routing."No.");
            page::"Production BOM":
                if Page.RunModal(0, ProductionBOMHeader) = Action::LookupOK then
                    exit(ProductionBOMHeader."No.");
            page::"Planned Production Order",
          page::"Firm Planned Prod. Order",
          page::"Released Production Order",
          page::"Finished Production Order",
          page::"Simulated Production Order":
                if Page.RunModal(0, ProductionOrder) = Action::LookupOK then
                    exit(ProductionOrder."No.");
            else
        /*  //GL2024 if WorkflowAddOnIntegr.Lookup(pType, pJnlTemplate, pNo) <> '' then begin
          end
          else
              if WorkflowUserExit.Lookup(pType, pJnlTemplate, pNo) <> '' then begin
              end
              else
                  Error(tActionNotEnable, pType);*/
        end;
        exit(pNo);

    end;


    procedure "Trigger"(pRec: Record "Workflow Journal Line"; pTrigger: Integer)
    var
        lTrigger: Record "Workflow Trigger";
        lVendorLedgerEntry: Record "Vendor Ledger Entry";
        lOnHold: Code[10];
    begin
        if pTrigger <> 0 then
            if not GetRec(pRec.Type, pRec."Template Name", pRec."No.") then
                exit;
        case pRec.Type of
            page::"G/L Account Card":
                with GLAccount do begin
                    case pTrigger of
                        0:
                            begin
                                lTrigger.InsertTrigger(pRec.Type, -1, tBlock);
                                lTrigger.InsertTrigger(pRec.Type, 1, tRelease);
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
            page::"Customer Card":
                with Customer do begin
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
                            Validate(Blocked, Blocked::All);
                        else
                            Error(tTriggerNotEnable, pRec.Type, pTrigger);
                    end;
                    Modify;
                end;
            page::"Vendor Card":
                with Vendor do begin
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
                            Validate(Blocked, Blocked::All);
                        else
                            Error(tTriggerNotEnable, pRec.Type, pTrigger);
                    end;
                    Modify;
                end;
            page::"Item Card":
                with Item do begin
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
            //WORKFLOW_CUSTOM
            page::"Sales Order":
                with SalesHeader do begin
                    case pTrigger of
                        0:
                            begin
                                lTrigger.InsertTrigger(pRec.Type, -1, tRelease);
                                exit;
                            end;
                        -1:
                            begin
                                Status := -1;
                                Codeunit.Run(Codeunit::"Release Sales Document", SalesHeader);
                            end;
                        else
                            Error(tTriggerNotEnable, pRec.Type, pTrigger);
                    end;
                    Modify;
                end;
            page::"Purchase Order":
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
            //WORKFLOW_CUSTOM//
            page::"Resource Card":
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
            //USEREXIT
            /*
              page::"Job Card":WITH Job DO BEGIN
                CASE pTrigger OF
                   0:BEGIN
                     lTrigger.InsertTrigger(pRec.Type,-1,tRelease);
                     lTrigger.InsertTrigger(pRec.Type, 1,tBlock);
                     EXIT;
                     END;
                  -1:VALIDATE(Blocked,0);
                   1:VALIDATE(Blocked,1);
                 ELSE
                   ERROR(tTriggerNotEnable,pRec.Type,pTrigger);
                 END;
                MODIFY;
              END;
            */
            //USEREXIT//
            page::Budget:
                with GLBudgetName do begin
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
            //WORKFLOW_CUSTOM
            page::"Posted Purchase Invoice":
                with PurchInvHeader do begin
                    case pTrigger of
                        0:
                            begin
                                lTrigger.InsertTrigger(pRec.Type, -1, tRelease);
                                exit;
                            end;
                        -1:
                            begin
                                //        lVendorLedgerEntry.SETCURRENTKEY("Document No.","Document Type","Vendor No.");
                                lVendorLedgerEntry.SetCurrentkey("Document No.");
                                lVendorLedgerEntry.SetRange("Document No.", "No.");
                                lVendorLedgerEntry.SetRange("Document Type", lVendorLedgerEntry."document type"::Invoice);
                                lVendorLedgerEntry.SetRange("Vendor No.", PurchInvHeader."Pay-to Vendor No.");
                                if not lVendorLedgerEntry.IsEmpty then
                                    lVendorLedgerEntry.Find('-');
                                repeat
                                    lVendorLedgerEntry."On Hold" := '';
                                    lVendorLedgerEntry.Modify;
                                until lVendorLedgerEntry.Next = 0;
                            end;
                        else
                            Error(tTriggerNotEnable, pRec.Type, pTrigger);
                    end;
                end;
            //WORKFLOW_CUSTOM//
            page::"Bank Account Card":
                with BankAcct do begin
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
            page::"Fixed Asset Card":
                with FixedAsset do begin
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
            //#8614
            page::"Transfer Order":
                with TransferHeader do begin
                    case pTrigger of
                        0:
                            begin
                                lTrigger.InsertTrigger(pRec.Type, -1, tRelease);
                                exit;
                            end;
                        -1:
                            begin
                                Status := -1;
                                Codeunit.Run(Codeunit::"Release Transfer Document", TransferHeader);
                            end;
                        else
                            Error(tTriggerNotEnable, pRec.Type, pTrigger);
                    end;
                    Modify;
                end;
            //#8614//
            page::"Loaner Card":
                with Loaner do begin
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
            page::"Work Center Card":
                with WorkCenter do begin
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
            page::"Machine Center Calendar":
                with MachineCenter do begin
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
            page::"Planned Production Order",
          page::"Firm Planned Prod. Order",
          page::"Released Production Order",
          page::"Finished Production Order",
          page::"Simulated Production Order":
                with ProductionOrder do begin
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
        //GL2024
        end;
    end;   //GL2024
    //#7898
    /*
    ELSE
      IF WorkflowAddOnIntegr.Trigger(pRec,pTrigger) THEN
        BEGIN END
      ELSE IF WorkflowUserExit.Trigger(pRec,pTrigger) THEN
        BEGIN END
    */
    //#7898//
    /* GL2024   else
            if WorkFlowTemplate.Get(pRec.Type) then begin
                WorkFlowDocument."Document Template" := pRec.Type;
                WorkFlowDocument.trigger pTrigger;
                IF WorkFlowTemplate."Codeunit ID" <> 0 THEN
    //#5433
    //    CODEUNIT.RUN(WorkFlowTemplate."Codeunit ID",WorkFlowDocument);
    //    CODEUNIT.RUN(WorkFlowTemplate."Codeunit ID");
        CODEUNIT.RUN(WorkFlowTemplate."Codeunit ID", WorkFlowDocument);
                //#5433//
                "END"
                //#7898
                else
                "IF" WorkflowAddOnIntegr.trigger(pRec) THEN
                begin
                    "END"
                    else if WorkflowUserExit.pRec,pTrigger) THEN
        begin
                    end
                    //#7898//
                    else
                    if pTrigger <> 0 then
                        Error(tActionNotEnable, pRec.Type);
                end;

            end;*/


    procedure GetRecRef(pType: Integer;
            pJnlTemplate:
                Code[10];
            pNo:
                Code[20]; var pRecRef: RecordRef) Return: Boolean
    var
        lWorkflowType: Record "Workflow Type";
    begin
        case pType of
            0:
                ;
            page::"Customer Card":
                if Customer.ReadPermission then begin
                    Return := Customer.Get(pNo);
                    pRecRef.GetTable(Customer);
                end else
                    Return := false;
            page::"Vendor Card":
                if Vendor.ReadPermission then begin
                    Return := Vendor.Get(pNo);
                    pRecRef.GetTable(Vendor);
                end else
                    Return := false;
            page::"Item Card":
                if Item.ReadPermission then begin
                    Return := Item.Get(pNo);
                    pRecRef.GetTable(Item);
                end else
                    Return := false;
            page::"Sales Quote":
                if SalesHeader.ReadPermission then begin
                    Return := SalesHeader.Get(SalesHeader."document type"::Quote, pNo);
                    pRecRef.GetTable(SalesHeader);
                end else
                    Return := false;
            page::"Sales Order":
                if SalesHeader.ReadPermission then begin
                    Return := SalesHeader.Get(SalesHeader."document type"::Order, pNo);
                    pRecRef.GetTable(SalesHeader);
                end else
                    Return := false;
            page::"Sales Invoice":
                if SalesHeader.ReadPermission then begin
                    Return := SalesHeader.Get(SalesHeader."document type"::Invoice, pNo);
                    pRecRef.GetTable(SalesHeader);
                end else
                    Return := false;
            page::"Sales Credit Memo":
                if SalesHeader.ReadPermission then begin
                    Return := SalesHeader.Get(SalesHeader."document type"::"Credit Memo", pNo);
                    pRecRef.GetTable(SalesHeader);
                end else
                    Return := false;
            page::"Purchase Quote":
                if PurchHeader.ReadPermission then begin
                    Return := PurchHeader.Get(PurchHeader."document type"::Quote, pNo);
                    pRecRef.GetTable(PurchHeader);
                end else
                    Return := false;
            page::"Purchase Order":
                if PurchHeader.ReadPermission then begin
                    Return := PurchHeader.Get(PurchHeader."document type"::Order, pNo);
                    pRecRef.GetTable(PurchHeader);
                end else
                    Return := false;
            page::"Purchase Invoice":
                if PurchHeader.ReadPermission then begin
                    Return := PurchHeader.Get(PurchHeader."document type"::Invoice, pNo);
                    pRecRef.GetTable(PurchHeader);
                end else
                    Return := false;
            page::"Purchase Credit Memo":
                if PurchHeader.ReadPermission then begin
                    Return := PurchHeader.Get(PurchHeader."document type"::"Credit Memo", pNo);
                    pRecRef.GetTable(PurchHeader);
                end else
                    Return := false;
            page::"Resource Card":
                if Resource.ReadPermission then begin
                    Return := Resource.Get(pNo);
                    pRecRef.GetTable(Resource);
                end else
                    Return := false;
            //USEREXIT
            /*
              page::"Job Card":
                IF Job.READPERMISSION THEN BEGIN
                  Return := Job.GET(pNo);
                  pRecRef.GETTABLE(Job);
                END ELSE
                  Return := FALSE;
            */
            //USEREXIT//
            page::Budget:
                if GLBudgetName.ReadPermission then begin
                    Return := GLBudgetName.Get(pNo);
                    pRecRef.GetTable(GLBudgetName);
                end else
                    Return := false;
            page::"Posted Sales Shipment":
                if SalesShptHeader.ReadPermission then begin
                    Return := SalesShptHeader.Get(pNo);
                    pRecRef.GetTable(SalesShptHeader);
                end else
                    Return := false;
            page::"Posted Sales Invoice":
                if SalesInvHeader.ReadPermission then begin
                    Return := SalesInvHeader.Get(pNo);
                    pRecRef.GetTable(SalesInvHeader);
                end else
                    Return := false;
            page::"Posted Sales Credit Memo":
                if SalesCrMemoHeader.ReadPermission then begin
                    Return := SalesCrMemoHeader.Get(pNo);
                    pRecRef.GetTable(SalesCrMemoHeader);
                end else
                    Return := false;
            page::"Posted Purchase Receipt":
                if PurchRcptHeader.ReadPermission then begin
                    Return := PurchRcptHeader.Get(pNo);
                    pRecRef.GetTable(PurchRcptHeader);
                end else
                    Return := false;
            page::"Posted Purchase Invoice":
                if PurchInvHeader.ReadPermission then begin
                    Return := PurchInvHeader.Get(pNo);
                    pRecRef.GetTable(PurchInvHeader);
                end else
                    Return := false;
            page::"Posted Purchase Credit Memo":
                if PurchCrMemoHeader.ReadPermission then begin
                    Return := PurchCrMemoHeader.Get(pNo);
                    pRecRef.GetTable(PurchCrMemoHeader);
                end else
                    Return := false;
            page::"Bank Account Card":
                if BankAcct.ReadPermission then begin
                    Return := BankAcct.Get(pNo);
                    pRecRef.GetTable(BankAcct);
                end else
                    Return := false;
            page::Reminder:
                if ReminderHeader.ReadPermission then begin
                    Return := ReminderHeader.Get(pNo);
                    pRecRef.GetTable(ReminderHeader);
                end else
                    Return := false;
            page::"Issued Reminder":
                if IssuedReminderHeader.ReadPermission then begin
                    Return := IssuedReminderHeader.Get(pNo);
                    pRecRef.GetTable(IssuedReminderHeader);
                end else
                    Return := false;
            page::"Blanket Sales Order":
                if SalesHeader.ReadPermission then begin
                    Return := SalesHeader.Get(SalesHeader."document type"::"Blanket Order", pNo);
                    pRecRef.GetTable(SalesHeader);
                end else
                    Return := false;
            page::"Blanket Purchase Order":
                if PurchHeader.ReadPermission then begin
                    Return := PurchHeader.Get(PurchHeader."document type"::"Blanket Order", pNo);
                    pRecRef.GetTable(PurchHeader);
                end else
                    Return := false;
            page::"Contact Card":
                if Contact.ReadPermission then begin
                    Return := Contact.Get(pNo);
                    pRecRef.GetTable(Contact);
                end else
                    Return := false;
            page::Segment:
                if Segment.ReadPermission then begin
                    Return := Segment.Get(pNo);
                    pRecRef.GetTable(Segment);
                end else
                    Return := false;
            page::"Employee Card":
                if Employee.ReadPermission then begin
                    Return := Employee.Get(pNo);
                    pRecRef.GetTable(Employee);
                end else
                    Return := false;
            page::"Fixed Asset Card":
                if FixedAsset.ReadPermission then begin
                    Return := FixedAsset.Get(pNo);
                    pRecRef.GetTable(FixedAsset);
                end else
                    Return := false;
            //#8614
            page::"Transfer Order":
                if TransferHeader.ReadPermission then begin
                    Return := TransferHeader.Get(pNo);
                    pRecRef.GetTable(TransferHeader);
                end else
                    Return := false;
            //#8614//
            page::"Service Order":
                if ServHeader.ReadPermission then begin
                    Return := ServHeader.Get(ServHeader."document type"::Order, pNo);
                    pRecRef.GetTable(ServHeader);
                end else
                    Return := false;
            page::"Service Quote":
                if ServHeader.ReadPermission then begin
                    Return := ServHeader.Get(ServHeader."document type"::Quote, pNo);
                    pRecRef.GetTable(ServHeader);
                end else
                    Return := false;
            page::"Loaner Card":
                if Loaner.ReadPermission then begin
                    Return := Loaner.Get(pNo);
                    pRecRef.GetTable(Loaner);
                end else
                    Return := false;
            page::"Service Item Card":
                if ServiceItem.ReadPermission then begin
                    Return := ServiceItem.Get(pNo);
                    pRecRef.GetTable(ServiceItem);
                end else
                    Return := false;
            page::"Service Contract":
                if ServiceContract.ReadPermission then begin
                    Return := ServiceContract.Get(ServiceContract."contract type"::Quote, pNo);
                    pRecRef.GetTable(ServiceContract);
                end else
                    Return := false;
            page::"Service Contract Quote":
                if ServiceContract.ReadPermission then begin
                    //GL2024  Return := ServiceContract.Get(ServiceContract."contract type"::"2", pNo);
                    Return := ServiceContract.Get(ServiceContract."contract type"::Template, pNo);
                    pRecRef.GetTable(ServiceContract);
                end else
                    Return := false;
            page::"Sales Return Order":
                if SalesHeader.ReadPermission then begin
                    Return := SalesHeader.Get(SalesHeader."document type"::"Return Order", pNo);
                    pRecRef.GetTable(SalesHeader);
                end else
                    Return := false;
            page::"Purchase Return Order":
                if PurchHeader.ReadPermission then begin
                    Return := PurchHeader.Get(PurchHeader."document type"::"Return Order", pNo);
                    pRecRef.GetTable(PurchHeader);
                end else
                    Return := false;
            page::"Posted Return Receipt":
                if ReturnReceiptHeader.ReadPermission then begin
                    Return := ReturnReceiptHeader.Get(pNo);
                    pRecRef.GetTable(ReturnReceiptHeader);
                end else
                    Return := false;
            page::"Posted Return Shipment":
                if ReturnShipmentHeader.ReadPermission then begin
                    Return := ReturnShipmentHeader.Get(pNo);
                    pRecRef.GetTable(ReturnShipmentHeader);
                end else
                    Return := false;
            page::"Work Center Card":
                if WorkCenter.ReadPermission then begin
                    Return := WorkCenter.Get(pNo);
                    pRecRef.GetTable(WorkCenter);
                end else
                    Return := false;
            page::"Machine Center Calendar":
                if MachineCenter.ReadPermission then begin
                    Return := MachineCenter.Get(pNo);
                    pRecRef.GetTable(MachineCenter);
                end else
                    Return := false;
            page::Routing:
                if Routing.ReadPermission then begin
                    Return := Routing.Get(pNo);
                    pRecRef.GetTable(Routing);
                end else
                    Return := false;
            page::"Production BOM":
                if ProductionBOMHeader.ReadPermission then begin
                    Return := ProductionBOMHeader.Get(pNo);
                    pRecRef.GetTable(ProductionBOMHeader);
                end else
                    Return := false;
            page::"Planned Production Order":
                if ProductionOrder.ReadPermission then begin
                    Return := ProductionOrder.Get(ProductionOrder.Status::Planned, pNo);
                    pRecRef.GetTable(ProductionOrder);
                end else
                    Return := false;
            page::"Firm Planned Prod. Order":
                if ProductionOrder.ReadPermission then begin
                    Return := ProductionOrder.Get(ProductionOrder.Status::"Firm Planned", pNo);
                    pRecRef.GetTable(ProductionOrder);
                end else
                    Return := false;
            page::"Released Production Order":
                if ProductionOrder.ReadPermission then begin
                    Return := ProductionOrder.Get(ProductionOrder.Status::Released, pNo);
                    pRecRef.GetTable(ProductionOrder);
                end else
                    Return := false;
            page::"Finished Production Order":
                if ProductionOrder.ReadPermission then begin
                    Return := ProductionOrder.Get(ProductionOrder.Status::Finished, pNo);
                    pRecRef.GetTable(ProductionOrder);
                end else
                    Return := false;
            page::"Simulated Production Order":
                if ProductionOrder.ReadPermission then begin
                    Return := ProductionOrder.Get(ProductionOrder.Status::Simulated, pNo);
                    pRecRef.GetTable(ProductionOrder);
                end else
                    Return := false;

            // Journals
            page::"Req. Worksheet":
                if ReqWkshName.ReadPermission then begin
                    Return := ReqWkshName.Get(pJnlTemplate, pNo);
                    pRecRef.GetTable(ReqWkshName);
                end else
                    Return := false;

            // Workflow Documents
            else
                if WorkFlowTemplate.Get(pType) then begin
                    Return := WorkFlowDocument.Get(pType, pNo);
                    pRecRef.GetTable(WorkFlowDocument);
                end else
                    /* //GL2024  if WorkflowAddOnIntegr.GetRec(pType, pJnlTemplate, pNo) then
                          exit(true)
                      else*/
                    if WorkflowUserExit.GetRec(pType, pJnlTemplate, pNo) then
                        exit(true)
                    else
                        Error(tActionNotEnable, pType);
        end;

    end;
}

