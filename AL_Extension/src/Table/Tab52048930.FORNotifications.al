table 52048930 "FOR-Notifications"
{

    //GL2024  ID dans Nav 2009 : "39001481"
    // DrillDownPageID = 70123;
    //LookupPageID = 70123;


    fields
    {
        field(1; "N° Notification"; Integer)
        {
        }
        field(2; Designation; Text[250])
        {
            Caption = 'Désignation';
        }
        field(3; "Affecte a"; Code[20])
        {
            Caption = 'Affecté à';
            TableRelation = User;
        }
        field(4; "Date echeance"; Date)
        {
            Caption = 'Date echéance';
        }
        field(5; "Date debut"; Date)
        {
            Caption = 'Date début';
        }
        field(6; "Temps reste (jours)"; Integer)
        {
            Caption = 'Temps resté (jours)';
        }
        field(7; Statut; Option)
        {
            OptionCaption = ' ,Encours,Résolue';
            OptionMembers = ,Encours,Resolue;
        }
        field(8; Type; Option)
        {
            OptionCaption = ' ,Formation,Recrutement';
            OptionMembers = ,Formation,Recrutement;
        }
        field(9; "N° Document"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "N° Notification")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

