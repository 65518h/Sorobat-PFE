Codeunit 8001408 TableRelation
{
    // //IMPORT CW 05/06/04 ImportCorrespondence TableRelation LookUp


    trigger OnRun()
    begin
    end;


    procedure LookUp(pTableID: Integer; pFieldID: Integer; var pCode: Code[20]): Boolean
    var
        lField: Record "Field";
        lRecordRef: RecordRef;
        lFieldRef: FieldRef;
        lOK: action;
        l3: Record "Payment Terms";
        l4: Record Currency;
        l6: Record "Customer Price Group";
        l8: Record Language;
        l9: Record "Country/Region";
        l10: Record "Shipment Method";
        l13: Record "Salesperson/Purchaser";
        l14: Record Location;
        l92: Record "Customer Posting Group";
        l93: Record "Vendor Posting Group";
        l94: Record "Inventory Posting Group";
        l152: Record "Resource Group";
        l200: Record "Work Type";
        l204: Record "Unit of Measure";
        l230: Record "Source Code";
        l231: Record "Reason Code";
        l250: Record "Gen. Business Posting Group";
        l251: Record "Gen. Product Posting Group";
        l258: Record "Transaction Type";
        l259: Record "Transport Method";
        l286: Record Territory;
        l289: Record "Payment Method";
        l291: Record "Shipping Agent";
        l292: Record "Reminder Terms";
        //GL2024     l308: Record 308;
        l323: Record "VAT Business Posting Group";
        l324: Record "VAT Product Posting Group";
        l5053: Record "Business Relation";
        l5057: Record "Industry Group";
        l5066: Record "Job Responsibility";
        l5068: Record Salutation;
        l5070: Record "Organizational Level";
        l5202: Record Qualification;
        l5204: Record Relative;
        l5206: Record "Cause of Absence";
        l5209: Record Union;
        l5210: Record "Cause of Inactivity";
        l5211: Record "Employment Contract";
        l5212: Record "Employee Statistics Group";
        l5213: Record "Misc. Article";
        l5215: Record Confidential;
        l5217: Record "Grounds for Termination";
        l5607: Record "FA Class";
        l5609: Record "FA Location";
        l5714: Record "Responsibility Center";
        l5720: Record Manufacturer;
        l5721: Record Purchasing;
        l5722: Record "Item Category";
        l8001400: Record Code;
    begin
        lOK := Action::LookupOK;
        if (pTableID = 0) or (pFieldID = 0) then
            exit(false);
        lRecordRef.Open(pTableID);
        lFieldRef := lRecordRef.Field(pFieldID);
        Evaluate(lField.Type, Format(lFieldRef.Type));
        if lField.Type <> lField.Type::Code then // Avoid lFieldRef.RELATION system error
            exit(false);
        case lFieldRef.Relation of
            0:
                ;
            Database::"Payment Terms":
                if Page.RunModal(0, l3) = lOK then
                    pCode := l3.Code else
                    exit(false);
            Database::Currency:
                if Page.RunModal(0, l4) = lOK then
                    pCode := l4.Code else
                    exit(false);
            Database::"Customer Price Group":
                if Page.RunModal(0, l6) = lOK then
                    pCode := l6.Code else
                    exit(false);
            Database::Language:
                if Page.RunModal(0, l8) = lOK then
                    pCode := l8.Code else
                    exit(false);
            Database::"Country/Region":
                if Page.RunModal(0, l9) = lOK then
                    pCode := l9.Code else
                    exit(false);
            Database::"Shipment Method":
                if Page.RunModal(0, l10) = lOK then
                    pCode := l10.Code else
                    exit(false);
            Database::"Salesperson/Purchaser":
                if Page.RunModal(0, l13) = lOK then
                    pCode := l13.Code else
                    exit(false);
            Database::Location:
                if Page.RunModal(0, l14) = lOK then
                    pCode := l14.Code else
                    exit(false);
            Database::"Customer Posting Group":
                if Page.RunModal(0, l92) = lOK then
                    pCode := l92.Code else
                    exit(false);
            Database::"Vendor Posting Group":
                if Page.RunModal(0, l93) = lOK then
                    pCode := l93.Code else
                    exit(false);
            Database::"Inventory Posting Group":
                if Page.RunModal(0, l94) = lOK then
                    pCode := l94.Code else
                    exit(false);
            /* GL2024  Database::"No. Series":
                   if Page.RunModal(0, l308) = lOK then
                       pCode := l308.Code else
                       exit(false);*/
            Database::"Resource Group":
                if Page.RunModal(0, l152) = lOK then
                    pCode := l152."No." else
                    exit(false);
            Database::"Work Type":
                if Page.RunModal(0, l200) = lOK then
                    pCode := l200.Code else
                    exit(false);
            Database::"Unit of Measure":
                if Page.RunModal(0, l204) = lOK then
                    pCode := l204.Code else
                    exit(false);
            Database::"Source Code":
                if Page.RunModal(0, l230) = lOK then
                    pCode := l230.Code else
                    exit(false);
            Database::"Reason Code":
                if Page.RunModal(0, l231) = lOK then
                    pCode := l231.Code else
                    exit(false);
            Database::"Gen. Business Posting Group":
                if Page.RunModal(0, l250) = lOK then
                    pCode := l250.Code else
                    exit(false);
            Database::"Gen. Product Posting Group":
                if Page.RunModal(0, l251) = lOK then
                    pCode := l251.Code else
                    exit(false);
            Database::"Transaction Type":
                if Page.RunModal(0, l258) = lOK then
                    pCode := l258.Code else
                    exit(false);
            Database::"Transport Method":
                if Page.RunModal(0, l259) = lOK then
                    pCode := l259.Code else
                    exit(false);
            Database::Territory:
                if Page.RunModal(0, l286) = lOK then
                    pCode := l286.Code else
                    exit(false);
            Database::"Payment Method":
                if Page.RunModal(0, l289) = lOK then
                    pCode := l289.Code else
                    exit(false);
            Database::"Shipping Agent":
                if Page.RunModal(0, l291) = lOK then
                    pCode := l291.Code else
                    exit(false);
            Database::"Reminder Terms":
                if Page.RunModal(0, l292) = lOK then
                    pCode := l292.Code else
                    exit(false);
            Database::"VAT Business Posting Group":
                if Page.RunModal(0, l323) = lOK then
                    pCode := l323.Code else
                    exit(false);
            Database::"VAT Product Posting Group":
                if Page.RunModal(0, l324) = lOK then
                    pCode := l324.Code else
                    exit(false);
            Database::"Business Relation":
                if Page.RunModal(0, l5053) = lOK then
                    pCode := l5053.Code else
                    exit(false);
            Database::"Industry Group":
                if Page.RunModal(0, l5057) = lOK then
                    pCode := l5057.Code else
                    exit(false);
            Database::"Job Responsibility":
                if Page.RunModal(0, l5066) = lOK then
                    pCode := l5066.Code else
                    exit(false);
            Database::Salutation:
                if Page.RunModal(0, l5068) = lOK then
                    pCode := l5068.Code else
                    exit(false);
            Database::"Organizational Level":
                if Page.RunModal(0, l5070) = lOK then
                    pCode := l5070.Code else
                    exit(false);
            Database::Qualification:
                if Page.RunModal(0, l5202) = lOK then
                    pCode := l5202.Code else
                    exit(false);
            Database::Relative:
                if Page.RunModal(0, l5204) = lOK then
                    pCode := l5204.Code else
                    exit(false);
            Database::"Cause of Absence":
                if Page.RunModal(0, l5206) = lOK then
                    pCode := l5206.Code else
                    exit(false);
            Database::Union:
                if Page.RunModal(0, l5209) = lOK then
                    pCode := l5209.Code else
                    exit(false);
            Database::"Cause of Inactivity":
                if Page.RunModal(0, l5210) = lOK then
                    pCode := l5210.Code else
                    exit(false);
            Database::"Employment Contract":
                if Page.RunModal(0, l5211) = lOK then
                    pCode := l5211.Code else
                    exit(false);
            Database::"Employee Statistics Group":
                if Page.RunModal(0, l5212) = lOK then
                    pCode := l5212.Code else
                    exit(false);
            Database::"Misc. Article":
                if Page.RunModal(0, l5213) = lOK then
                    pCode := l5213.Code else
                    exit(false);
            Database::Confidential:
                if Page.RunModal(0, l5215) = lOK then
                    pCode := l5215.Code else
                    exit(false);
            Database::"Grounds for Termination":
                if Page.RunModal(0, l5217) = lOK then
                    pCode := l5217.Code else
                    exit(false);
            Database::"FA Class":
                if Page.RunModal(0, l5607) = lOK then
                    pCode := l5607.Code else
                    exit(false);
            Database::"FA Location":
                if Page.RunModal(0, l5609) = lOK then
                    pCode := l5609.Code else
                    exit(false);
            Database::"Responsibility Center":
                if Page.RunModal(0, l5714) = lOK then
                    pCode := l5714.Code else
                    exit(false);
            Database::Manufacturer:
                if Page.RunModal(0, l5720) = lOK then
                    pCode := l5720.Code else
                    exit(false);
            Database::Purchasing:
                if Page.RunModal(0, l5721) = lOK then
                    pCode := l5721.Code else
                    exit(false);
            Database::"Item Category":
                if Page.RunModal(0, l5722) = lOK then
                    pCode := l5722.Code else
                    exit(false);
            Database::Code:
                begin
                    l8001400.FilterGroup(2);
                    l8001400.SetRange(l8001400."Table No", pTableID);
                    l8001400.SetRange(l8001400."Field No", pFieldID);
                    l8001400.FilterGroup(0);
                    if Page.RunModal(0, l8001400) = lOK then pCode := l8001400.Code else exit(false);
                end;
            else
        end;
        exit(true);
    end;
}

