Codeunit 8001516 "Aggr., Update default values"
{
    //GL2024  ID dans Nav 2009 : "8001316"
    // #6464 AC 30/09/08
    // //STATSEXPLORER STATSEXPLORER 01/01/00 Add values from item,customer,...
    // 
    // 
    // IMPORTANT TECHNICAL INFORMATIONS FOR DEVELOPERS :
    // -----------------------------------------------
    // 
    // You can find at the end of this codeunit several functions dedicated to take
    // specific fields in the cards : Item, Resource, Account G/L, Employee, Job, Customer, Vendor.
    // 
    // To put one of your specific fields in one of the free fields of StatsExplorer, your have to add only 3 C/AL lines :
    // 
    // 1 - Define this field description in Statistic Setup (Free Fields)
    // 
    // 2 - Add 1 C/AL line in the function SearchSpecificFieldsxxxx (xxxx = item,resource,...) like that :
    // 
    //     Stats."Free field 1" := Item."My Specific Field";
    //    Where
    //     Stats."Free field 1" could be "Free field 1" to "Free field 10",
    //     "Free date 1" to "Free date 5", "Free boolean 1" to "Free boolean 5"
    //    And Where
    //     Item."My Specific Field" could be Item,Resource,Account,Employee,Job,Customer,Vendor
    //     (You don't need to GET item, ressource, ...)
    // 
    // 3 - Create the codes and descriptions of this free field in table 8001400
    //     with the function CreateCodeAndDescription like that :
    // 
    //     a - Add your specific table which contains Code+Description of your field in C/AL locals (MyTable,Record,"My Table")
    // 
    //     b - GET the current code : MyTable.GET(Item."My Specific Field")
    // 
    //     c - Use the function CreateCodeAndDescription of this codeunit to add records with Code+Description in table 8001400 :
    // 
    //         CreateCodeAndDescription(TableNumber,FieldNumber,CodeValue,CodeDescription)
    //        Where
    //         TableNumber     = 8001300
    //         FieldNumber     = 1001..1010 for "Free field 1" to "Free field 10"
    //                           1011..1015 for "Free date 1" to "Free date 5"
    //                           1021..1025 for "Free boolean 1" to "Free boolean 5"
    // 
    //         CodeValue       = MyTable.Code
    //         CodeDescription = MyTable.Description
    // 
    // Don't forget documentation and version list ...

    TableNo = "Statistic aggregate";

    trigger OnRun()
    begin
        Stats := Rec;
        StatisticSetup.Get;

        SearchJob;
        SearchCustomerOrVendor;
        ModifyDateValues;

        if Rec."No." <> '' then
            case Rec.Type of
                Rec.Type::Item:
                    SearchItem;
                Rec.Type::Resource:
                    SearchResource;
                Rec.Type::"Account (G/L)":
                    SearchAccountGL;
                Rec.Type::Employee:
                    SearchEmployee;
            end;

        StatisticCriteria.SetRange(Type, StatisticCriteria.Type::"Sort criteria");
        StatisticCriteria.SetRange("Field No.", 35);
        if not StatisticCriteria.IsEmpty then
            if StatisticCriteria.FindFirst and StatisticCriteria.Enabled then
                SearchFiscalDate;

        Rec := Stats;
    end;

    var
        StatisticSetup: Record "Statistics setup";
        StatisticCriteria: Record "Statistic criteria";
        Stats: Record "Statistic aggregate";
        "Code": Record Code;
        Item: Record Item;
        Resource: Record Resource;
        Account: Record "G/L Account";
        Employee: Record Employee;
        Job: Record Job;
        Customer: Record Customer;
        //GL2024 License "Object": Record "Object";
        //GL2024 License
        "Object": Record AllObj;
        //GL2024 License
        Vendor: Record Vendor;


    procedure SearchItem()
    begin
        if Item.Get(Stats."No.") then
            with Stats do begin
                if StatisticSetup."Item criteria 1 required" then
                    Item.TestField("Criteria 1");
                if StatisticSetup."Item criteria 2 required" then
                    Item.TestField("Criteria 2");
                if StatisticSetup."Item criteria 3 required" then
                    Item.TestField("Criteria 3");
                if StatisticSetup."Item criteria 4 required" then
                    Item.TestField("Criteria 4");
                if StatisticSetup."Item criteria 5 required" then
                    Item.TestField("Criteria 5");
                if StatisticSetup."Item criteria 6 required" then
                    Item.TestField("Criteria 6");
                if StatisticSetup."Item criteria 7 required" then
                    Item.TestField("Criteria 7");
                if StatisticSetup."Item criteria 8 required" then
                    Item.TestField("Criteria 8");
                if StatisticSetup."Item criteria 9 required" then
                    Item.TestField("Criteria 9");
                if StatisticSetup."Item criteria 10 required" then
                    Item.TestField("Criteria 10");
                Volume := Quantity * Item."Unit Volume";
                "Item criteria 1" := Item."Criteria 1";
                "Item criteria 2" := Item."Criteria 2";
                "Item criteria 3" := Item."Criteria 3";
                "Item criteria 4" := Item."Criteria 4";
                "Item criteria 5" := Item."Criteria 5";
                "Item criteria 6" := Item."Criteria 6";
                "Item criteria 7" := Item."Criteria 7";
                "Item criteria 8" := Item."Criteria 8";
                "Item criteria 9" := Item."Criteria 9";
                "Item criteria 10" := Item."Criteria 10";
                if "Manufacturer Code" = '' then
                    "Manufacturer Code" := Item."Manufacturer Code";
                if "Item Category Code" = '' then
                    "Item Category Code" := Item."Item Category Code";
                if "Service Item Group" = '' then
                    "Service Item Group" := Item."Service Item Group";
                /*  GL2024 if "Product Group Code" = '' then
                       "Product Group Code" := Item."Product Group Code";*/
                if "Inventory Posting Group" = '' then
                    "Inventory Posting Group" := Item."Inventory Posting Group";
                if "Gen. Prod. Posting Group" = '' then
                    "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";

                SearchSpecificFieldsItem;
            end;
    end;


    procedure SearchResource()
    begin
        if Resource.Get(Stats."No.") then
            with Stats do begin
                Volume := Quantity;
                if "Global Dimension 1 Code" = '' then
                    "Global Dimension 1 Code" := Resource."Global Dimension 1 Code";
                if "Global Dimension 2 Code" = '' then
                    "Global Dimension 2 Code" := Resource."Global Dimension 2 Code";
                if "Resource Group No." = '' then
                    "Resource Group No." := Resource."Resource Group No.";
                if "Gen. Prod. Posting Group" = '' then
                    "Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                SearchSpecificFieldsResource;
            end;
    end;


    procedure SearchAccountGL()
    begin
        if Account.Get(Stats."No.") then
            with Stats do begin
                Volume := Quantity;
                if "Global Dimension 1 Code" = '' then
                    "Global Dimension 1 Code" := Account."Global Dimension 1 Code";
                if "Global Dimension 2 Code" = '' then
                    "Global Dimension 2 Code" := Account."Global Dimension 2 Code";
                if "Consol. Debit Acc." = '' then
                    "Consol. Debit Acc." := Account."Consol. Debit Acc.";
                if "Consol. Credit Acc." = '' then
                    "Consol. Credit Acc." := Account."Consol. Credit Acc.";
                if "Gen. Prod. Posting Group" = '' then
                    "Gen. Prod. Posting Group" := Account."Gen. Prod. Posting Group";
                SearchSpecificFieldsAccount;
            end;
    end;


    procedure SearchEmployee()
    begin
        if Employee.Get(Stats."No.") then
            with Stats do begin
                Volume := Quantity;
                if "Global Dimension 1 Code" = '' then
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                if "Global Dimension 2 Code" = '' then
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                SearchSpecificFieldsEmployee;
            end;
    end;


    procedure SearchJob()
    begin
        if Stats."Job No." <> '' then
            if Job.Get(Stats."Job No.") then
                with Stats do begin
                    if ("Source No." = '') and (Job."Bill-to Customer No." <> '') then begin
                        "Source Type" := "source type"::Customer;
                        "Source No." := Job."Bill-to Customer No.";
                    end;
                    "Job criteria 1" := Job."Criteria 1";
                    "Job criteria 2" := Job."Criteria 2";
                    "Job criteria 3" := Job."Criteria 3";
                    "Job criteria 4" := Job."Criteria 4";
                    "Job criteria 5" := Job."Criteria 5";
                    "Job criteria 6" := Job."Criteria 6";
                    "Job criteria 7" := Job."Criteria 7";
                    "Job criteria 8" := Job."Criteria 8";
                    "Job criteria 9" := Job."Criteria 9";
                    "Job criteria 10" := Job."Criteria 10";
                    if "Global Dimension 1 Code" = '' then
                        "Global Dimension 1 Code" := Job."Global Dimension 1 Code";
                    if "Global Dimension 2 Code" = '' then
                        "Global Dimension 2 Code" := Job."Global Dimension 2 Code";
                    if "Job Posting Group" = '' then
                        "Job Posting Group" := Job."Job Posting Group";
                    if "Person Responsible" = '' then
                        "Person Responsible" := Job."Person Responsible";
                    if Object.Get(Object."Object Type"::Codeunit, '', 8004001) then
                        Codeunit.Run(Codeunit::"StatsExplorer Job Fields", Stats);
                    SearchSpecificFieldsJob;
                end;
    end;


    procedure SearchCustomerOrVendor()
    begin
        case Stats."Source Type" of
            Stats."source type"::Customer:
                begin
                    if Customer.Get(Stats."Source No.") then
                        with Stats do begin
                            if StatisticSetup."Customer criteria 1 required" then
                                Customer.TestField("Criteria 1");
                            if StatisticSetup."Customer criteria 2 required" then
                                Customer.TestField("Criteria 2");
                            if StatisticSetup."Customer criteria 3 required" then
                                Customer.TestField("Criteria 3");
                            if StatisticSetup."Customer criteria 4 required" then
                                Customer.TestField("Criteria 4");
                            if StatisticSetup."Customer criteria 5 required" then
                                Customer.TestField("Criteria 5");
                            if StatisticSetup."Customer criteria 6 required" then
                                Customer.TestField("Criteria 6");
                            if StatisticSetup."Customer criteria 7 required" then
                                Customer.TestField("Criteria 7");
                            if StatisticSetup."Customer criteria 8 required" then
                                Customer.TestField("Criteria 8");
                            if StatisticSetup."Customer criteria 9 required" then
                                Customer.TestField("Criteria 9");
                            if StatisticSetup."Customer criteria 10 required" then
                                Customer.TestField("Criteria 10");
                            "Customer criteria 1" := Customer."Criteria 1";
                            "Customer criteria 2" := Customer."Criteria 2";
                            "Customer criteria 3" := Customer."Criteria 3";
                            "Customer criteria 4" := Customer."Criteria 4";
                            "Customer criteria 5" := Customer."Criteria 5";
                            "Customer criteria 6" := Customer."Criteria 6";
                            "Customer criteria 7" := Customer."Criteria 7";
                            "Customer criteria 8" := Customer."Criteria 8";
                            "Customer criteria 9" := Customer."Criteria 9";
                            "Customer criteria 10" := Customer."Criteria 10";
                            "Country Code" := Customer."Country/Region Code";
                            if "Global Dimension 1 Code" = '' then
                                "Global Dimension 1 Code" := Customer."Global Dimension 1 Code";
                            if "Global Dimension 2 Code" = '' then
                                "Global Dimension 2 Code" := Customer."Global Dimension 2 Code";
                            if "Salespers./Purch. Code" = '' then
                                "Salespers./Purch. Code" := Customer."Salesperson Code";
                            if "Source Posting Group" = '' then
                                "Source Posting Group" := Customer."Customer Posting Group";
                            if "Gen. Bus. Posting Group" = '' then
                                "Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
                            SearchSpecificFieldsCustomer;
                        end;
                end;
            Stats."source type"::Vendor:
                begin
                    if Vendor.Get(Stats."Source No.") then
                        with Stats do begin
                            if "Global Dimension 1 Code" = '' then
                                "Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                            if "Global Dimension 2 Code" = '' then
                                "Global Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                            if "Salespers./Purch. Code" = '' then
                                "Salespers./Purch. Code" := Vendor."Purchaser Code";
                            if "Source Posting Group" = '' then
                                "Source Posting Group" := Vendor."Vendor Posting Group";
                            if "Gen. Bus. Posting Group" = '' then
                                "Gen. Bus. Posting Group" := Vendor."Gen. Bus. Posting Group";
                            SearchSpecificFieldsVendor;
                        end;
                end;
        end;
    end;


    procedure SearchFiscalDate()
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        with Stats do begin
            AccountingPeriod.SetFilter("Starting Date", '>=%1', "Ending Date");
            AccountingPeriod.SetRange("New Fiscal Year", true);
            if not AccountingPeriod.IsEmpty then
                if AccountingPeriod.FindFirst then
                    "Fiscal year closing date" := AccountingPeriod."Starting Date" - 1;
        end;
    end;


    procedure CreateCodeAndDescription(TableNumber: Integer; FieldNumber: Integer; CodeValue: Code[20]; CodeDescription: Text[30])
    begin
        with Code do
            if not Get(TableNumber, FieldNumber, CodeValue) then begin
                Init;
                "Table No" := TableNumber;
                "Field No" := FieldNumber;
                Code := CodeValue;
                Description := CodeDescription;
                Insert;
            end else begin
                Description := CodeDescription;
                Modify;
            end;
    end;


    procedure ModifyDateValues()
    begin
        Stats.Year := Date2dmy(Stats."Ending Date", 3);
        Stats.Month := Date2dmy(Stats."Ending Date", 2);
        Stats.Week := Date2dwy(Stats."Ending Date", 2);
        Stats."Week Day" := Date2dwy(Stats."Ending Date", 1);
        case Stats.Month of
            1, 2, 3:
                begin
                    Stats."Half Year" := 1;
                    Stats.Quarter := 1;
                end;
            4, 5, 6:
                begin
                    Stats."Half Year" := 1;
                    Stats.Quarter := 2;
                end;
            7, 8, 9:
                begin
                    Stats."Half Year" := 2;
                    Stats.Quarter := 3;
                end;
            10, 11, 12:
                begin
                    Stats."Half Year" := 2;
                    Stats.Quarter := 4;
                end;
        end;
    end;


    procedure SearchFields(pFirstNo: Integer; pLastNo: Integer; pDiff: Integer; pRecRef: RecordRef)
    var
        Description: Text[30];
        lRecRef: RecordRef;
        lFieldRef: FieldRef;
        i: Integer;
        lLocField: FieldRef;
        lStatsRef: RecordRef;
        lStatsField: FieldRef;
        lStatsField2: FieldRef;
        lField: Text[30];
        lNoField: Integer;
        lTableRelation: RecordRef;
        lTableRelationField: FieldRef;
        lValue: Text[250];
        lRes: Record Resource;
        lRecordField: Record "Field";
    begin
        //PROJET
        lRecRef.GetTable(StatisticSetup);
        for i := pFirstNo to pLastNo do begin
            lFieldRef := lRecRef.Field(i);
            if Format(lFieldRef.Value) <> '' then begin
                if CopyStr(Format(lFieldRef.Value), 1, StrPos(Format(lFieldRef.Value), '.') - 1) = Format(pRecRef.Number) then begin
                    lField := CopyStr(Format(lFieldRef.Value), StrPos(Format(lFieldRef.Value), '.') + 1);
                    Evaluate(lNoField, lField);
                    Description := '';
                    if lNoField <> 0 then begin
                        lStatsRef.GetTable(Stats);
                        lLocField := pRecRef.Field(lNoField);
                        lStatsField := lStatsRef.Field(i - pDiff);
                        //#4269
                        //      lValue := COPYSTR(FORMAT(lLocField),1,lStatsField.LENGTH);
                        lValue := Format(lLocField);
                        //#4269//
                        if lValue <> '' then begin
                            lStatsField := lStatsRef.Field(i - pDiff);
                            SetFiledRefValue(lStatsField, lValue);
                            /*DELETE
                                    IF lValue <> COPYSTR(FORMAT(lLocField.VALUE),1,lStatsField.LENGTH) THEN
                                      lStatsField.VALUE(lValue)
                                    ELSE
                                      lStatsField.VALUE(COPYSTR(FORMAT(lLocField.VALUE),1,lStatsField.LENGTH));
                            DELETE*/
                            lStatsRef := lStatsField.Record;
                            lStatsRef.SetTable(Stats);
                            if lValue = CopyStr(Format(lLocField.Value), 1, lStatsField.Length) then      //Option
                                if pFirstNo <> 100071 then begin              //Boolean
                                    if lRecordField.Get(pRecRef.Number, lNoField) then
                                        if lRecordField.RelationTableNo <> 0 then begin
                                            lTableRelation.Open(lRecordField.RelationTableNo);
                                            lTableRelationField := lTableRelation.Field(1);
                                            case lLocField.Relation of
                                                8003929:
                                                    begin
                                                        lStatsField2 := lStatsRef.Field(5);
                                                        if Format(lStatsField2.Value) = '1' then begin
                                                            lTableRelationField.Value(3);
                                                            lTableRelation := lTableRelationField.Record;
                                                            lStatsField.Value(Item.TableCaption + ' ' + Format(lLocField.Value));
                                                            lStatsRef := lStatsField.Record;
                                                            lStatsRef.SetTable(Stats);
                                                        end;
                                                        if Format(lStatsField2.Value) = '2' then begin
                                                            lStatsField2 := lStatsRef.Field(6);
                                                            if lRes.Get(lStatsField2.Value) then begin
                                                                lTableRelationField.Value(lRes.Type);
                                                                lTableRelation := lTableRelationField.Record;
                                                                lStatsField.Value(Format(lRes.Type) + ' ' + Format(lLocField.Value));
                                                                lStatsRef := lStatsField.Record;
                                                                lStatsRef.SetTable(Stats);
                                                            end;
                                                        end;
                                                        lTableRelationField := lTableRelation.Field(2);
                                                        lTableRelationField.Value(lValue);
                                                        lTableRelation := lTableRelationField.Record;
                                                    end;
                                                8001400:
                                                    begin
                                                        lTableRelationField.Value(pRecRef.Number);
                                                        lTableRelation := lTableRelationField.Record;
                                                        lTableRelationField := lTableRelation.Field(2);
                                                        lTableRelationField.Value(lNoField);
                                                        lTableRelation := lTableRelationField.Record;
                                                        lTableRelationField := lTableRelation.Field(3);
                                                        lTableRelationField.Value(lValue);
                                                        lTableRelation := lTableRelationField.Record;
                                                    end;
                                                else begin
                                                    lTableRelationField.Value(lValue);
                                                    lTableRelation := lTableRelationField.Record;
                                                end;
                                            end;
                                            lTableRelation.SetRecfilter;
                                            if not lTableRelation.IsEmpty then
                                                if lTableRelation.FindFirst then begin
                                                    lTableRelation := lTableRelationField.Record;
                                                    case lTableRelation.Number of
                                                        156, 8003929:
                                                            lTableRelationField := lTableRelation.Field(3);
                                                        8001400:
                                                            lTableRelationField := lTableRelation.Field(4);
                                                        else
                                                            lTableRelationField := lTableRelation.Field(2);
                                                    end;
                                                    Description := CopyStr(Format(lTableRelationField.Value), 1, MaxStrLen(Description));
                                                end;
                                            lValue := lStatsField.Value;
                                        end
                                        else begin
                                            //            Description := lValue;
                                            Description := CopyStr(Format(lLocField.Value), 1, MaxStrLen(Description));
                                        end;
                                end;
                            //#6464
                            lTableRelation.Close;
                            //#6464//
                            CreateCodeAndDescription(8001300, i - pDiff, CopyStr(lValue, 1, 20), Description);
                        end;
                    end;
                end;
            end;
        end;
        //PROJET//

    end;


    procedure SearchSpecificFieldsItem()
    var
        lItemRef: RecordRef;
    begin
        lItemRef.GetTable(Item);
        SearchFields(100041, 100050, 99040, lItemRef);
        SearchFields(100061, 100065, 99050, lItemRef);
        SearchFields(100071, 100075, 99050, lItemRef);
    end;


    procedure SearchSpecificFieldsResource()
    var
        lResRef: RecordRef;
    begin
        lResRef.GetTable(Resource);
        SearchFields(100041, 100050, 99040, lResRef);
        SearchFields(100061, 100065, 99050, lResRef);
        SearchFields(100071, 100075, 99050, lResRef);
    end;


    procedure SearchSpecificFieldsAccount()
    var
        lAccRef: RecordRef;
    begin
        lAccRef.GetTable(Account);
        SearchFields(100041, 100050, 99040, lAccRef);
        SearchFields(100061, 100065, 99050, lAccRef);
        SearchFields(100071, 100075, 99050, lAccRef);
    end;


    procedure SearchSpecificFieldsEmployee()
    var
        lEmplRef: RecordRef;
    begin
        lEmplRef.GetTable(Employee);
        SearchFields(100041, 100050, 99040, lEmplRef);
        SearchFields(100061, 100065, 99050, lEmplRef);
        SearchFields(100071, 100075, 99050, lEmplRef);
    end;


    procedure SearchSpecificFieldsJob()
    var
        lJobRef: RecordRef;
    begin
        lJobRef.GetTable(Job);
        SearchFields(100041, 100050, 99040, lJobRef);
        SearchFields(100061, 100065, 99050, lJobRef);
        SearchFields(100071, 100075, 99050, lJobRef);
    end;


    procedure SearchSpecificFieldsCustomer()
    var
        lCustRef: RecordRef;
    begin
        lCustRef.GetTable(Customer);
        SearchFields(100041, 100050, 99040, lCustRef);
        SearchFields(100061, 100065, 99050, lCustRef);
        SearchFields(100071, 100075, 99050, lCustRef);
    end;


    procedure SearchSpecificFieldsVendor()
    var
        lVendRef: RecordRef;
    begin
        lVendRef.GetTable(Vendor);
        SearchFields(100041, 100050, 99040, lVendRef);
        SearchFields(100061, 100065, 99050, lVendRef);
        SearchFields(100071, 100075, 99050, lVendRef);
    end;


    procedure SetFiledRefValue(var pFieldRef: FieldRef; pValue: Text[250])
    var
        lFieldRef: Record "Field";
        lBoolean: Boolean;
        lInteger: Integer;
        lDecimal: Decimal;
        lDate: Date;
    begin
        Evaluate(lFieldRef.Type, Format(pFieldRef.Type));
        case lFieldRef.Type of
            lFieldRef.Type::Code,
            lFieldRef.Type::Text:
                begin
                    if pValue = CopyStr(pValue, 1, pFieldRef.Length) then
                        pFieldRef.Value(pValue)
                    else
                        pFieldRef.Value(CopyStr(pValue, 1, pFieldRef.Length));
                end;
            lFieldRef.Type::Boolean:
                if Evaluate(lBoolean, pValue) then
                    pFieldRef.Value := lBoolean;
            lFieldRef.Type::Integer, lFieldRef.Type::Option:
                if pValue = '' then
                    pFieldRef.Value := 0
                else
                    if Evaluate(lInteger, pValue) then
                        pFieldRef.Value := lInteger;
            lFieldRef.Type::Decimal:
                if pValue = '' then
                    pValue := '0'
                else
                    if Evaluate(lDecimal, pValue) then
                        pFieldRef.Value := lDecimal;
            lFieldRef.Type::Date:
                if Evaluate(lDate, pValue) then
                    pFieldRef.Value := lDate;
            else
                Error('');
        end;
    end;
}

