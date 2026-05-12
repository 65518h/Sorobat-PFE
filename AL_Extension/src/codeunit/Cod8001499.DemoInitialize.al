Codeunit 8001499 "Demo-Initialize"
{
    // //+BGW+CODE        CW 29/01/02 Initialisation
    // //+REF+FOLDER      CW 29/01/02 Initialisation
    // //+REF+CHARACT      CW 29/01/02 Initialisation
    // //+REF+TRANSLATION CW 29/01/02 Initialisation
    // //+REF+OFFICE      CW 03/04/02 Initialisation


    trigger OnRun()
    begin
        Window.Open(Text000);

        //+REF+FOLDER
        with FolderSetup do begin
            Init;
            "Table ID" := 18;  // Client
            "Folder path" := 'C:\Cronus\Clients\%2';
            if Insert then;
            "Table ID" := 167; // Projet
            "Folder path" := 'C:\Cronus\Clients\%1\%3';
            if Insert then;
            "Table ID" := 5050; // Contact
            "Folder path" := 'C:\Cronus\Contacts\%2';
            if Insert then;
            "Table ID" := 27; // Item
            "Folder path" := 'C:\Cronus\Articles\'; // Sans % pour appel document html
            if Insert then;
        end;
        //+REF+FOLDER//

        //+BGW+CODE
        InsertCode(5200, 50004, 'COM', 'Commercial', 'SalesPerson');
        InsertCode(5200, 50004, 'CPT', 'Comptable', 'Accountant');
        InsertCode(5200, 50004, 'SEC', 'Secrétaire', 'Secretary');
        //+BGW+CODE//

        //+REF+CHARACT
        with CharactCode do if not Find('-') then begin
                Init;
                "Table Name" := "table name"::Contact;
                Code := '10';
                Description := 'Date de naissance';
                Type := Type::Date;
                Insert;
                Code := '20';
                Description := 'Nbre enfants';
                Type := Type::Integer;
                Insert;
                Code := '30';
                Description := 'Origine';
                Type := Type::Option;
                Insert;
                Code := '40';
                Description := 'Remarque';
                Type := Type::Text;
            end;
        with CharactOption do if not Find('-') then begin
                Init;
                "Table Name" := "table name"::Contact;
                "Characteristic code" := '30';
                Option := 'RELATION';
                Description := 'Par relation';
                Insert;
                Option := 'ANNONCE';
                Description := 'Suite annonce';
                Insert;
                Option := 'SPONTANE';
                Description := 'Spontané';
                Insert;
            end;
        with CharactValue do if not Find('-') and Contact.Find('-') then begin
                Init;
                "Table Name" := "table name"::Contact;
                "No." := Contact."No.";
                "Characteristic Code" := '10';
                Value := '15/07/75';
                Insert;
                "Characteristic Code" := '20';
                Value := '2';
                Insert;
                "Characteristic Code" := '30';
                Value := 'ANNONCE';
                Insert;
            end;
        //+REF+CHARACT//
        /*
        //+REF+TRANSLATION
        WITH Translation DO IF NOT FIND('-') THEN BEGIN
          PaymentTerms.FIND('-');
          TableID := 3;
          FieldID := 'FM';
          Code := 'EN';
          Language := 'End of Month';
          INSERT;
          FieldID := 'PR';
          Language := 'When received';
          INSERT;
        END;
        //+REF+TRANSLATION//
        */
        //+REF+OFFICE
        if Cust.Get('10000') and (Cust."E-Mail" = '') then begin
            Cust."E-Mail" := 'contact@gesway.com';
            Cust.Modify;
        end;
        /*GL2024  with ReportSelection do begin
              if not Get(Usage::"S.Shipment", '2') then
                  InsertRepSelection(Usage::"S.Shipment", '2', Report::Report81300);
              if not Get(Usage::"P.Receipt", '2') then
                  InsertRepSelection(Usage::"P.Receipt", '2', Report::Report89902);
          end;*/
        //+REF+OFFICE//

        Window.Close;

    end;

    var
        Text000: label 'Initializing demo company...';
        ReportSelection: Record "Report Selections";
        FolderSetup: Record "Folder Setup";
        "Code": Record Code;
        Contact: Record Contact;
        CharactCode: Record "Characteristic Code";
        CharactOption: Record "Characteristic Option";
        CharactValue: Record Characteristic;
        Translation: Record Translation2;
        PaymentTerms: Record "Payment Terms";
        Cust: Record Customer;
        Item: Record Item;
        Window: Dialog;

    local procedure InsertSourceCode(var SourceCodeDefCode: Code[10]; "Code": Code[10]; Description: Text[50])
    var
        SourceCode: Record "Source Code";
    begin
        SourceCodeDefCode := Code;
        SourceCode.Init;
        SourceCode.Code := Code;
        SourceCode.Description := Description;
        SourceCode.Insert;
    end;

    local procedure InsertStandardText("Code": Code[10]; Description: Text[50])
    var
        StdTxt: Record "Standard Text";
    begin
        StdTxt.Init;
        StdTxt.Code := Code;
        StdTxt.Description := Description;
        StdTxt.Insert;
    end;

    local procedure InsertRepSelection(ReportUsage: Integer; Sequence: Code[10]; ReportID: Integer)
    var
        ReportSelection: Record "Report Selections";
    begin
        ReportSelection.Init;
        ReportSelection.Usage := ReportUsage;
        ReportSelection.Sequence := Sequence;
        ReportSelection."Report ID" := ReportID;
        ReportSelection.Insert;
    end;


    procedure InsertCode(pTableID: Integer; pFieldID: Integer; pCode: Code[10]; pDescription: Text[30]; pTranslation: Text[30])
    var
        "Code": Record Code;
        CodeTransl: Record Translation2;
    begin
        //+BGW+CODE
        with Code do begin
            "Table No" := pTableID;
            "Field No" := pFieldID;
            Code := pCode;
            Description := pDescription;
            if Insert then;
        end;

        with CodeTransl do begin
            TableID := pTableID;
            FieldID := pFieldID;
            Code := pCode;
            "Language Code" := 'EN';
            Description := pTranslation;
            if Insert then;
        end;
        //+BGW+CODE//
    end;
}

