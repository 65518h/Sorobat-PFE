Table 8001493 OutlookLink
{
    // //+REF+OUTLOOK CW 04/05/11

    Caption = 'Outlook Link';

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(4; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if ("Table ID" = const(18)) Customer
            else
            if ("Table ID" = const(23)) Vendor
            else
            if ("Table ID" = const(27)) Item
            else
            if ("Table ID" = const(36)) "Sales Header"."No."
            else
            if ("Table ID" = const(156)) Resource
            else
            if ("Table ID" = const(167)) "Job"
            else
            if ("Table ID" = const(5050)) Contact;

            trigger OnValidate()
            begin
                Check;
            end;
        }
        field(6; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
            Editable = false;
        }
        field(7; "Company Name"; Text[50])
        {
            Caption = 'Company Name';
            Editable = false;
        }
        field(8; "Contact Name"; Text[50])
        {
            Caption = 'Contact Name';
            Editable = false;
        }
        field(10; "Outlook EntryID"; Text[140])
        {
            Caption = 'Outlook EntryID';
            Editable = false;
        }
        field(11; Outlook; Boolean)
        {
            Caption = 'Outlook';
            Editable = false;
        }
        field(12; Linked; Boolean)
        {
            Caption = 'Linked';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "User ID", "Table ID", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "User ID", "Table ID", "Source Type", "No.")
        {
        }
        key(Key3; "User ID", "Table ID", "Search Name")
        {
        }
        key(Key4; "User ID", "Table ID", "Outlook EntryID")
        {
        }
        key(Key5; "Table ID", "Source Type", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Outlook := ("Outlook EntryID" <> '');
        Linked := ("Outlook EntryID" <> '') and ("No." <> '')
    end;

    trigger OnModify()
    begin
        Outlook := ("Outlook EntryID" <> '');
        Linked := ("Outlook EntryID" <> '') and ("No." <> '')
    end;

    var
        OutlookContactManagement: Codeunit "OutlookLink ContactManagement";
        tReplace: label 'This No. as already linked with %1 %2.\Do you want to replace it?';


    procedure AddContact(var pContact: Record Contact; pEntryID: Text[250]): Boolean
    begin
        Init;
        "User ID" := UserId;
        "Table ID" := Database::Contact;
        ;
        "Line No." := 0; // AutoIncrement
        "No." := pContact."No.";
        case pContact.Type of
            pContact.Type::Company:
                begin
                    "Company Name" := pContact.Name;
                    "Search Name" := pContact."Search Name";
                end;
            pContact.Type::Person:
                begin
                    "Company Name" := pContact."Company Name";
                    "Contact Name" := pContact.Name;
                    if pContact."Company Name" = '' then
                        "Search Name" := pContact."Search Name"
                    else
                        "Search Name" := pContact."Company Name";
                end;
        end;
        "Outlook EntryID" := pEntryID;
        exit(Insert(true));
    end;


    procedure ShowCard()
    var
        lContact: Record Contact;
    begin
        case "Table ID" of
            Database::Contact:
                begin
                    TestField("No.");
                    lContact.Get("No.");
                    PAGE.RunModal(page::"Contact Card", lContact);
                end;
        end;
    end;


    procedure OutlookCard(): Boolean
    var
        lContact: Record Contact;
    begin
        TestField("Outlook EntryID");
        exit(OutlookContactManagement.Display("Outlook EntryID"));
    end;


    procedure Exists(pSourceType: Integer; pNo: Code[20]): Boolean
    begin
        TestField("Table ID");
        SetCurrentkey("User ID", "Table ID", "Source Type", "No.");
        SetRange("User ID", UserId);
        SetRange("Table ID", "Table ID");
        SetRange("Source Type", pSourceType);
        SetRange("No.", pNo);
        //exit(findfirst);
        exit(FindFirst);
    end;


    procedure ExistsEntryID(pOutlookEntryID: Text[140]): Boolean
    begin
        TestField("Table ID");
        SetCurrentkey("User ID", "Table ID", "Outlook EntryID");
        SetRange("User ID", UserId);
        SetRange("Table ID", "Table ID");
        SetRange("Outlook EntryID", pOutlookEntryID);
        //EXIT(FINDFIRST);
        exit(not IsEmpty);
    end;

    local procedure Check()
    var
        lOutlookLink: Record OutlookLink;
    begin
        if "No." = '' then
            exit;
        TestField("Table ID");
        lOutlookLink.SetCurrentkey("User ID", "Table ID", "Source Type", "No.");
        lOutlookLink.SetRange("User ID", "User ID");
        lOutlookLink.SetRange("Table ID", "Table ID");
        lOutlookLink.SetRange("Source Type", "Source Type");
        lOutlookLink.SetRange("No.", "No.");
        if lOutlookLink.FindFirst then
            if not Confirm(tReplace, false, lOutlookLink."Contact Name", lOutlookLink."Company Name") then
                "No." := xRec."No."
            else begin
                lOutlookLink."No." := '';
                lOutlookLink.Modify(true);
            end;
    end;
}

