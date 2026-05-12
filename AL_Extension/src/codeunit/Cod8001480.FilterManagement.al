Codeunit 8001480 "Filter Management"
{
    // //+BGW+FILTER CW 11/07/09


    trigger OnRun()
    begin
        Add(Database::"Salesperson/Purchaser", 0, 1, 2); // 13
        Add(Database::"G/L Account", 0, 1, 2); // 15
        Add(Database::Customer, 0, 1, 2); // 18
        Add(Database::Vendor, 0, 1, 2); // 23
        Add(Database::Item, 0, 1, 3); // 27
        Add(Database::"Sales Header", 1, 3, 79); // 36
        Add(Database::"Purchase Header", 1, 3, 79); // 27
        Add(Database::Resource, 0, 1, 3); // 156
        Add(Database::"Job", 0, 1, 3); // 167
        Add(Database::"Bank Account", 0, 1, 2); // 270
        Add(Database::Contact, 0, 1, 2); // 5050
        Add(Database::Opportunity, 0, 1, 2); // 5092
        Add(Database::Employee, 0, 1, 7); // 5200
        Add(Database::"Production Order", 1, 2, 3); // 5405
        Add(Database::"Nonstock Item", 0, 1, 5); // 5718
        Add(Database::"Transfer Header", 0, 1, 12); // 5740
        Add(Database::"Service Item", 0, 1, 4); // 5940
                                                //GL2024 Add(Database::Table50167, 0, 1, 3); // 50167
        Add(Database::Job, 0, 1, 3); // 8004160
    end;

    var
        tIncorrectRecordID: label 'Record ID %1 not define';
        tIncorrectFieldID: label 'Field ID %1 not define';
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Item: Record Item;
        Resource: Record Resource;
        Job: Record Job;
        Contact: Record Contact;
        Employee: Record Employee;
        FixedAsset: Record "Fixed Asset";
        NonstockItem: Record "Nonstock Item";
        tFormUndefine: label 'No form defined for TableID %1';


    procedure Add(pTableNo: Integer; pSourceTypeFieldNo: Integer; pSourceNoFieldNo: Integer; pDescriptionFieldNo: Integer)
    var
        lRec: Record "Filter Table Relation";
    begin
        with lRec do begin
            TableNo := pTableNo;
            "Source Type FieldNo" := pSourceTypeFieldNo;
            "Source No. FieldNo" := pSourceNoFieldNo;
            "Source Description FieldNo" := pDescriptionFieldNo;
            if Insert then;
        end;
    end;


    procedure ShowList(pTableID: Integer; pFilterCode: Code[20])
    var
        lFilter: Record "Filter Header";
    begin
        if pFilterCode <> '' then
            lFilter.Get(pTableID, pFilterCode);
        case pTableID of
            Database::"G/L Account":
                begin
                    GLAccount.SetView(lFilter.Get_View);
                    Page.RunModal(0, GLAccount);
                end;
            Database::Customer:
                begin
                    Customer.SetView(lFilter.Get_View);
                    Page.RunModal(0, Customer);
                end;
            Database::Vendor:
                begin
                    Vendor.SetView(lFilter.Get_View);
                    Page.RunModal(0, Vendor);
                end;
            Database::Item:
                begin
                    Item.SetView(lFilter.Get_View);
                    Page.RunModal(0, Item);
                end;
            Database::Resource:
                begin
                    Resource.SetView(lFilter.Get_View);
                    Page.RunModal(0, Resource);
                end;
            Database::"Job":
                begin
                    Job.SetView(lFilter.Get_View);
                    Page.RunModal(0, Job);
                end;
            Database::Job:
                begin
                    Job.SetView(lFilter.Get_View);
                    Page.RunModal(0, Job);
                end;
            Database::Contact:
                begin
                    Contact.SetView(lFilter.Get_View);
                    Page.RunModal(0, Contact);
                end;
            Database::Employee:
                begin
                    Employee.SetView(lFilter.Get_View);
                    Page.RunModal(0, Employee);
                end;
            Database::"Fixed Asset":
                begin
                    FixedAsset.SetView(lFilter.Get_View);
                    Page.RunModal(0, FixedAsset);
                end;
            Database::"Nonstock Item":
                begin
                    NonstockItem.SetView(lFilter.Get_View);
                    Page.RunModal(0, NonstockItem);
                end;
            else
                Error(tFormUndefine, pTableID);
        end;
    end;


    procedure GetView(var pRecordRef: RecordRef): Boolean
    var
        lFilter: Record "Filter Header";
    //GL2024 NAVIBAT    lFilterList: Page 8001482;
    begin
        //GL2024 NAVIBAT   lFilterList.Set(pRecordRef);
        //GL2024 NAVIBAT   lFilterList.LookupMode(true);
        /*  //GL2024 NAVIBAT if lFilterList.RunModal = Action::LookupOK then begin
             lFilterList.GetRecord(lFilter);
             pRecordRef.SetView(lFilter.Get_View);
             exit(true);
         end;*/
    end;
}

