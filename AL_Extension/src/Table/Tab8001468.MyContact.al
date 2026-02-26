Table 8001468 "My Contact"
{
    // //RTC CW 30/03/10 Copy from 9150 VersionList=NAVW16.00

    Caption = 'My Contact';

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
        field(2; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            NotBlank = true;
            TableRelation = Contact;
        }
    }

    keys
    {
        key(Key1; "User ID", "Contact No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label 'Added %1 new %2';


    procedure AddEntities(FilterStr: Text[250])
    var
        Contact: Record Contact;
        "Count": Integer;
    begin
        Count := 0;

        Contact.SetFilter("No.", FilterStr);
        if Contact.FindSet then
            repeat
                "User ID" := UserId;
                "Contact No." := Contact."No.";
                if Insert then
                    Count += 1;
            until Contact.Next = 0;

        Message(Text001, Count, Contact.TableCaption);
    end;
}

