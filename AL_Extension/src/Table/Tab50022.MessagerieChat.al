Table 50022 "Messagerie Chat"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; FromUser; Code[20])
        {
        }
        field(3; Message; Text[250])
        {
        }
        field(4; ToUser; Code[20])
        {
        }
        field(5; Date; Date)
        {
        }
        field(6; "Message Time"; Time)
        {
        }
        field(10; Read; Boolean)
        {
        }
        field(11; "New Message"; Boolean)
        {
        }
        field(15; File; Boolean)
        {
        }
        field(16; Attachment; Blob)
        {
        }
        field(17; "File Name"; Text[250])
        {
        }
        field(18; NumDoc; Code[20])
        {
        }
        field(19; "Type Message"; Option)
        {
            OptionMembers = " ","Frequence Changement","Notif Min Max";
        }
        field(20; Article; Code[20])
        {
        }
        field(21; "Quantité Actuelle"; Decimal)
        {
        }
        field(22; "Min"; Integer)
        {
        }
        field(23; "Max"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

