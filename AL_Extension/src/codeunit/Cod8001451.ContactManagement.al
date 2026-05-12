Codeunit 8001451 "Contact Management"
{
    // //+REF+CRM CW 27/05/11


    trigger OnRun()
    begin
    end;


    procedure Merge(var pContact1: Record Contact; var pContact2: Record Contact)
    var
        ltProgress: label 'In progress...';
        lProgress: Dialog;
        lContIndustGrp: array[2] of Record "Contact Industry Group";
        lContactWebSource: array[2] of Record "Contact Web Source";
        lContMailingGrp: array[2] of Record "Contact Mailing Group";
        lContProfileAnswer: array[2] of Record "Contact Profile Answer";
        lRMCommentLine: array[2] of Record "Rlshp. Mgt. Comment Line";
        lContAltAddr: array[2] of Record "Contact Alt. Address";
        lContAltAddrDateRange: array[2] of Record "Contact Alt. Addr. Date Range";
        //GL2024    lSearchWordDetail: array[2] of Record 5118;
        lContDuplicateSearchString: array[2] of Record "Cont. Duplicate Search String";
        lFavorite: array[2] of Record "Filter Favorite";
        lOutlookLink: array[2] of Record OutlookLink;
        ltConfirm1: label 'Do you want to transfer information linked from contact\  %2 (%1)\to contact\  %4 (%3)?';
        ltConfirm2: label 'Warning : in case of conflict, information from the second one will be kept, and those from the first one will be lost.';
    begin
        // Principe :
        //  Pour les tables ayant "N° contact" dans la clé primaire, copier sur Contact2 ce qui peut l'être et supprimer
        //  puis delete(FALSE) de contact2
        //  et enfin RENAME Contact1 en Contact2 (tout le reste suit grace à la TableRelation)

        if pContact2."No." = pContact1."No." then
            exit;
        pContact1.TestField("No.");
        pContact2.TestField("No.");
        pContact1.Get(pContact1."No.");
        pContact2.Get(pContact2."No.");
        pContact2.TestField(Type, pContact1.Type);
        if pContact1.Type = pContact1.Type::Person then
            pContact2.TestField("Company No.", pContact1."Company No.");

        if not Confirm(ltConfirm1 + '\\' + ltConfirm2, true, pContact1."No.", pContact1.Name, pContact2."No.", pContact2.Name) then
            exit;

        lProgress.Open(ltProgress);

        with pContact2 do begin
            if "Phone No." = '' then
                Validate("Phone No.", pContact1."Phone No.");
            if "Territory Code" = '' then
                Validate("Territory Code", pContact1."Territory Code");
            if "Salesperson Code" = '' then
                Validate("Salesperson Code", pContact1."Salesperson Code");
            if "Country/Region Code" = '' then
                Validate("Country/Region Code", pContact1."Country/Region Code");
            if "Fax No." = '' then
                Validate("Fax No.", pContact1."Fax No.");
            if "VAT Registration No." = '' then
                "VAT Registration No." := pContact1."VAT Registration No.";
            if "E-Mail" = '' then
                Validate("E-Mail", pContact1."E-Mail");
            if "Home Page" = '' then
                Validate("Home Page", pContact1."Home Page");
            if "Extension No." = '' then
                Validate("Extension No.", pContact1."Extension No.");
            if "Mobile Phone No." = '' then
                Validate("Mobile Phone No.", pContact1."Mobile Phone No.");
            if "Trade Register" = '' then
                Validate("Trade Register", pContact1."Trade Register");
            if "APE Code" = '' then
                Validate("APE Code", pContact1."APE Code");
            if "Legal Form" = '' then
                Validate("Legal Form", pContact1."Legal Form");
            if "Stock Capital" = '' then
                Validate("Stock Capital", pContact1."Stock Capital");
            Modify(true);
        end;

        // Table 5051
        lContAltAddr[1].SetRange("Contact No.", pContact1."No.");
        if lContAltAddr[1].FindSet then
            repeat
                lContAltAddr[1].Delete;
                lContAltAddr[2].Copy(lContAltAddr[1]);
                lContAltAddr[2]."Contact No." := pContact2."No.";
                if lContAltAddr[2].Insert then;
            until lContAltAddr[1].Next = 0;

        // Table 5052
        lContAltAddrDateRange[1].SetRange("Contact No.", pContact1."No.");
        if lContAltAddrDateRange[1].FindSet then
            repeat
                lContAltAddrDateRange[1].Delete;
                lContAltAddrDateRange[2].Copy(lContAltAddrDateRange[2]);
                lContAltAddrDateRange[2]."Contact No." := pContact2."No.";
                if lContAltAddrDateRange[2].Insert then;
            until lContAltAddrDateRange[1].Next = 0;

        // Table 5056
        lContMailingGrp[1].SetRange("Contact No.", pContact1."No.");
        if lContMailingGrp[1].FindSet then
            repeat
                lContMailingGrp[1].Delete;
                lContMailingGrp[2].Copy(lContMailingGrp[1]);
                lContMailingGrp[2]."Contact No." := pContact2."No.";
                if lContMailingGrp[2].Insert then;
            until lContMailingGrp[1].Next = 0;

        // Table 5058
        lContIndustGrp[1].SetRange("Contact No.", pContact1."No.");
        if lContIndustGrp[1].FindSet then
            repeat
                lContIndustGrp[1].Delete;
                lContIndustGrp[2].Copy(lContIndustGrp[2]);
                lContIndustGrp[2]."Contact No." := pContact2."No.";
                if lContIndustGrp[2].Insert then;
            until lContIndustGrp[1].Next = 0;

        // Table 5060
        lContactWebSource[1].SetRange("Contact No.", pContact1."No.");
        if lContactWebSource[1].FindSet then
            repeat
                lContactWebSource[1].Delete;
                lContactWebSource[2].Copy(lContactWebSource[1]);
                lContactWebSource[2]."Contact No." := pContact2."No.";
                if lContactWebSource[2].Insert then;
            until lContactWebSource[1].Next = 0;

        // Table 5061 Append Contact1Comments to Contact2Comments
        lRMCommentLine[1].SetRange("Table Name", lRMCommentLine[1]."table name"::Contact);
        lRMCommentLine[1].SetRange("No.", pContact1."No.");
        lRMCommentLine[1].SetRange("Sub No.", 0);
        if lRMCommentLine[1].FindSet then begin
            lRMCommentLine[2].SetRange("Table Name", lRMCommentLine[2]."table name"::Contact);
            lRMCommentLine[2].SetRange("No.", pContact2."No.");
            lRMCommentLine[2].SetRange("Sub No.", 0);
            if lRMCommentLine[2].FindLast then;
            repeat
                lRMCommentLine[2].Init;
                lRMCommentLine[2].TransferFields(lRMCommentLine[1]);
                lRMCommentLine[2]."No." := pContact2."No.";
                lRMCommentLine[2]."Line No." += 10000;
                lRMCommentLine[2].Insert;
                lRMCommentLine[1].Delete;
            until lRMCommentLine[1].Next = 0;
        end;

        // Table 5086
        lContDuplicateSearchString[1].SetRange("Contact Company No.", pContact1."No.");
        if lContDuplicateSearchString[1].FindSet then
            repeat
                lContDuplicateSearchString[1].Delete;
                lContDuplicateSearchString[2].Copy(lContDuplicateSearchString[2]);
                lContDuplicateSearchString[2]."Contact Company No." := pContact2."No.";
                if lContDuplicateSearchString[2].Insert then;
            until lContDuplicateSearchString[1].Next = 0;

        // Table 5089
        lContProfileAnswer[1].SetRange("Contact No.", pContact1."No.");
        if lContProfileAnswer[1].FindSet then
            repeat
                lContProfileAnswer[1].Delete;
                lContProfileAnswer[2].Copy(lContProfileAnswer[1]);
                lContProfileAnswer[2]."Contact No." := pContact2."No.";
                if lContProfileAnswer[2].Insert then;
            until lContProfileAnswer[1].Next = 0;

        //+REF+FAVORITE
        lFavorite[1].SetCurrentkey("Table ID", "Source Type", "No.");
        lFavorite[1].SetRange("Table ID", Database::Contact);
        lFavorite[1].SetRange("Source Type", 0);
        lFavorite[1].SetRange("No.", pContact1."No.");
        if lFavorite[1].FindSet then
            repeat
                lFavorite[1].Delete;
                lFavorite[2].Copy(lFavorite[1]);
                lFavorite[2]."No." := pContact2."No.";
                if lFavorite[2].Insert then;
            until lFavorite[1].Next = 0;
        //+REF+FAVORITE//

        //+REF+OUTLOOK_LINK
        lOutlookLink[1].SetCurrentkey("Table ID", "Source Type", "No.");
        lOutlookLink[1].SetRange("Table ID", Database::Contact);
        lOutlookLink[1].SetRange("Source Type", 0);
        lOutlookLink[1].SetRange("No.", pContact1."No.");
        if lOutlookLink[1].FindSet then
            repeat
                lOutlookLink[1].Delete;
                lOutlookLink[2].Copy(lOutlookLink[1]);
                lOutlookLink[2]."No." := pContact2."No.";
                if lOutlookLink[2].Insert then;
            until lOutlookLink[1].Next = 0;
        //+REF+OUTLOOK_LINK//

        pContact1.TransferFields(pContact2, false);
        pContact1."Lookup Contact No." := pContact1."No.";
        pContact1.Modify(false);
        pContact2.Delete(false);

        /* GL2024  lSearchWordDetail[1].SetCurrentkey("No.", "Sub No.", "Table Name", "Word Position");
           lSearchWordDetail[1].SetRange("No.", pContact1."No.");
           lSearchWordDetail[1].DeleteAll;*/
        pContact1.Rename(pContact2."No.");

        lProgress.Close;
    end;
}

