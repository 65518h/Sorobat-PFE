Codeunit 8001494 "OutlookLink ContactMapping"
{
    // //+REF+OUTLOOK CW 04/05/11


    trigger OnRun()
    begin
    end;

    /*
     //GL2024 Automation non compatible
        procedure NavToOutlook(var pContact: Record 5050; var pOutlook: Automation)
        var
            lSalutationFormula: Record 5069;
        begin
            with pContact do begin
                case Type of
                    Type::Company:
                        begin
                            pOutlook.CompanyName := Name;
                            pOutlook.GovernmentIDNumber := "VAT Registration No.";
                            pOutlook.LastName := '';
                            pOutlook.MiddleName := '';
                            pOutlook.FirstName := '';
                            pOutlook.Title := '';
                        end;
                    Type::Person:
                        begin
                            pOutlook.CompanyName := "Company Name";
                            pOutlook.GovernmentIDNumber := '';
                            pOutlook.LastName := Surname;
                            pOutlook.MiddleName := pContact."Middle Name";
                            pOutlook.FirstName := "First Name";
                            if lSalutationFormula.Get("Salutation Code", "Language Code", lSalutationFormula."salutation type"::"10") then
                                pOutlook.Title := lSalutationFormula.Salutation;
                        end;
                end;
                pOutlook.BusinessAddressStreet := Address;
                pOutlook.BusinessAddressStreet := Append(pOutlook.BusinessAddressStreet, "Address 2");
                pOutlook.BusinessAddressCity := City;
                pOutlook.BusinessAddressPostalCode := "Post Code";
                pOutlook.BusinessTelephoneNumber := "Phone No.";
                pOutlook.MobileTelephoneNumber := "Mobile Phone No.";
                pOutlook.BusinessHomePage := "Home Page";
                pOutlook.Email1Address := "E-Mail";
                pOutlook.JobTitle := "Job Title";
            end;
        end;


        procedure OutlookToNav(var pOutlook: Automation; var pContact: Record 5050)
        begin
            with pContact do begin
                if (pOutlook.CompanyName <> '') and (pOutlook.LastName = '') then begin
                    Type := Type::Company;
                    fSetText(Name, pOutlook.CompanyName);
                    fSetText("VAT Registration No.", pOutlook.GovernmentIDNumber);
                end else begin
                    Type := Type::Person;
                    fSetText("Company Name", pOutlook.CompanyName);
                    fSetText("First Name", pOutlook.FirstName);
                    fSetText("Middle Name", pOutlook.MiddleName);
                    fSetText(Surname, pOutlook.LastName);
                    Validate(Name, CalculatedName());
                end;
                fSetText(Address, MultiLine(pOutlook.BusinessAddressStreet, 1));
                fSetText("Address 2", MultiLine(pOutlook.BusinessAddressStreet, 2));
                fSetText(City, pOutlook.BusinessAddressCity);
                fSetCode("Post Code", pOutlook.BusinessAddressPostalCode);
                fSetText("Phone No.", pOutlook.BusinessTelephoneNumber);
                fSetText("Mobile Phone No.", pOutlook.MobileTelephoneNumber);
                fSetText("Home Page", pOutlook.BusinessHomePage);
                fSetText("E-Mail", pOutlook.Email1Address);
                fSetText("Job Title", pOutlook.JobTitle);
            end;
        end;


        procedure Compare(var pContact: Record 5050; var pNav: Automation; var pOutlook: Automation; var pOutlookCompare: Record 8001494): Integer
        begin
            with pOutlookCompare do begin
                Add(pContact.FieldNo("Company Name"), pNav.CompanyName, pOutlook.CompanyName);
                Add(pContact.FieldNo("VAT Registration No."), pNav.GovernmentIDNumber, pOutlook.GovernmentIDNumber);
                Add(pContact.FieldNo(Surname), pNav.LastName, pOutlook.LastName);
                Add(pContact.FieldNo("Middle Name"), pNav.MiddleName, pOutlook.MiddleName);
                Add(pContact.FieldNo("First Name"), pNav.FirstName, pOutlook.FirstName);
                Add(pContact.FieldNo("Salutation Code"), pNav.Title, pOutlook.Title);
                Add(pContact.FieldNo(Address), pContact.Address, MultiLine(pOutlook.BusinessAddressStreet, 1));
                Add(pContact.FieldNo("Address 2"), pContact."Address 2", MultiLine(pOutlook.BusinessAddressStreet, 2));
                Add(pContact.FieldNo(City), pNav.BusinessAddressCity, pOutlook.BusinessAddressCity);
                Add(pContact.FieldNo("Post Code"), pNav.BusinessAddressPostalCode, pOutlook.BusinessAddressPostalCode);
                Add(pContact.FieldNo("Phone No."), pNav.BusinessTelephoneNumber, pOutlook.BusinessTelephoneNumber);
                Add(pContact.FieldNo("Mobile Phone No."), pNav.MobileTelephoneNumber, pOutlook.MobileTelephoneNumber);
                Add(pContact.FieldNo("Home Page"), pNav.BusinessHomePage, pOutlook.BusinessHomePage);
                Add(pContact.FieldNo("E-Mail"), pNav.Email1Address, pOutlook.Email1Address);
                Add(pContact.FieldNo("Job Title"), pNav.JobTitle, pOutlook.JobTitle);
            end;
        end;


        procedure Match(var pOutlook: Automation; var pContact: Record 5050): Boolean
        begin
            with pContact do begin
                Reset;

                if pOutlook.Email1Address <> '' then begin
                    fSetCode("Search E-Mail", pOutlook.Email1Address);
                    SetCurrentkey("Search E-Mail");
                    SetRange("Search E-Mail", "Search E-Mail");
                    if FindFirst and (Next = 0) then
                        exit(true);
                end;

                if pOutlook.BusinessTelephoneNumber <> '' then begin
                    fSetText("Phone No.", pOutlook.BusinessTelephoneNumber);
                    SetCurrentkey("Phone No.");
                    SetRange("Phone No.", "Phone No.");
                    if FindFirst and (Next = 0) then
                        exit(true);
                end;

                if pOutlook.LastName <> '' then begin
                    fSetCode("Search Name", pOutlook.LastName + ' ' + pOutlook.FirstName);
                    SetCurrentkey("Search Name");
                    SetRange("Search Name", "Search Name");
                    if FindFirst and (Next = 0) then
                        exit(true);
                end;

                if pOutlook.FirstName <> '' then begin
                    fSetCode("Search Name", pOutlook.FirstName + ' ' + pOutlook.LastName);
                    SetCurrentkey("Search Name");
                    SetRange("Search Name", "Search Name");
                    if FindFirst and (Next = 0) then
                        exit(true);
                end;

                if pOutlook.GovernmentIDNumber <> '' then begin
                    fSetText("VAT Registration No.", pOutlook.GovernmentIDNumber);
                    SetCurrentkey("VAT Registration No.");
                    SetRange("VAT Registration No.", "VAT Registration No.");
                    SetRange(Type, Type::Company);
                    if FindFirst and (Next = 0) then
                        exit(true);
                end;

                if pOutlook.CompanyName <> '' then begin
                    fSetCode("Search Name", pOutlook.CompanyName);
                    SetCurrentkey("Search Name");
                    SetRange("Search Name", "Search Name");
                    SetRange(Type, Type::Company);
                    if FindFirst and (Next = 0) then
                        exit(true);
                end;
            end;
        end;

    */
    procedure fSetText(var pText: Text[250]; pValue: Text[250])
    begin
        pText := CopyStr(pValue, 1, MaxStrLen(pText));
    end;


    procedure fSetCode(var pCode: Code[250]; pValue: Text[250]): Code[250]
    begin
        pCode := CopyStr(pValue, 1, MaxStrLen(pCode));
    end;


    procedure MultiLine(pText: Text[1000]; pIndex: Integer) Return: Text[1000]
    var
        lLineFeed: Text[30];
        lPos: Integer;
        i: Integer;
    begin
        if pIndex <= 0 then
            exit('');
        lLineFeed := ' ';
        lLineFeed[1] := 10;
        repeat
            i += 1;
            lPos := StrPos(pText, lLineFeed);
            if lPos = 0 then begin
                Return := pText;
                pText := '';
            end else begin
                Return := CopyStr(pText, 1, lPos - 1);
                pText := CopyStr(pText, lPos + 1);
            end;
        until i = pIndex;
    end;


    procedure Append(pText: Text[1000]; pValue: Text[250]): Text[1000]
    var
        lLineFeed: Text[1];
    begin
        lLineFeed := ' ';
        lLineFeed[1] := 10;
        if pText = '' then
            exit(pValue)
        else
            exit(pText + lLineFeed + pValue);
    end;
}

