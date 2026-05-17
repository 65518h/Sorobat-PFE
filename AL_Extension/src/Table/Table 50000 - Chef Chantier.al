table 50000 "Chef Chantier"
{
    DataClassification = CustomerContent;
    Caption = 'Chef de Chantier';

    fields
    {
        field(1; "Id"; Guid)
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }

        field(2; "Nom et Prenom"; Text[100])
        {
            Caption = 'Nom et Prénom';
        }

        // Nouveau champ : Adresse Email
        field(3; "Adresse Email"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail; // Permet à BC de reconnaître le champ comme un email (lien cliquable)

            trigger OnValidate()
            begin
                if ("Adresse Email" <> '') and (not "Adresse Email".Contains('@')) then
                    Error('L''adresse email n''est pas valide.');
            end;
        }

        field(4; "Actif"; Boolean)
        {
            Caption = 'Actif';
            InitValue = true;
        }

        field(5; "Num Projet"; Code[20])
        {
            Caption = 'N° Projet géré';
            TableRelation = Job."No.";
        }

        field(6; "Id Approbateur"; Code[50])
        {
            Caption = 'Id Approbateur';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup"."User ID";
        }
        field(7; "Password Hash"; Text[100])
        {
            Caption = 'Mot de passe (hash BCrypt)';
            DataClassification = EndUserPseudonymousIdentifiers;
        }
    }



    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if IsNullGuid(Rec.Id) then
            Rec.Id := CreateGuid();
    end;
}