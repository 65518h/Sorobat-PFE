Table 50043 "Commande Central Enrobe"
{

    fields
    {
        field(1; "Num Bon"; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Type Client"; Option)
        {
            OptionCaption = ' ,Interne,Externe';
            OptionMembers = " ",Interne,Externe;
        }
        field(4; "Code Client"; Code[20])
        {
            TableRelation = if ("Type Client" = filter(Interne)) Job."No."
            else
            if ("Type Client" = filter(Externe)) Customer."No.";

            trigger OnValidate()
            begin
                if "Type Client" = "type client"::Externe then
                    if RecCustomer.Get("Code Client") then
                        Nom := RecCustomer.Name
                    else
                        if RecJob.Get("Code Client") then Nom := RecJob.Description;
            end;
        }
        field(5; Nom; Text[50])
        {
        }
        field(6; "Code Produit"; Code[20])
        {
            TableRelation = Item."No." where("Tree Code" = filter('A-300 12 01' | '"A-300 12 03'));

            trigger OnValidate()
            begin
                if RecItem.Get("Code Produit") then "Description Produit" := RecItem.Description;
            end;
        }
        field(7; "Description Produit"; Text[200])
        {
            Editable = false;
        }
        field(8; "Code Central"; Code[20])
        {
        }
        field(9; "Quantité"; Decimal)
        {
        }
        field(10; "Prix Unitaire"; Decimal)
        {
        }
        field(11; Montant; Decimal)
        {
            Editable = false;
        }
        field(12; Status; Option)
        {
            OptionCaption = 'En cours,Validé Interne,Validé Externe';
            OptionMembers = "En cours","Validé Interne","Validé Externe";
        }
        field(13; "Code Camion"; Code[20])
        {

            trigger OnValidate()
            begin
                if RecVéhicule.Get("Code Camion") then "Description Camion" := RecVéhicule.Désignation;
            end;
        }
        field(14; "Description Camion"; Text[60])
        {
            Editable = false;
        }
        field(15; Chauffeur; Text[50])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Num Bon")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecCustomer: Record Customer;
        RecJob: Record Job;
        RecItem: Record Item;
        "RecVéhicule": Record "Véhicule";
}

