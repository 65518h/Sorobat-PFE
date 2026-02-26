table 52049020 "Entete frais mission"
{ //GL2024  ID dans Nav 2009 : "39001498"
  //GL2024  DrillDownPageID = 70154;
  //GL2024   LookupPageID = 70154;

    fields
    {
        field(1; "N° Demande"; Code[20])
        {
        }
        field(2; Demandeur; Code[20])
        {
        }
        field(3; "Nom Demandeur"; Text[50])
        {
        }
        field(4; "N° CIN"; Integer)
        {
        }
        field(5; Qualite; Text[50])
        {
        }
        field(6; Destination; Code[20])
        {

            trigger OnValidate()
            var
                RecLDestination: Record "Liste des destinations";
            begin
                IF RecLDestination.GET(RecLDestination.Code) THEN
                    "Groupe destination" := RecLDestination."Groupe destination";
            end;
        }
        field(7; "Objet mission"; Code[20])
        {
        }
        field(8; Commentaire; Text[250])
        {
        }
        field(9; "Date debut"; Date)
        {
        }
        field(10; "Date fin"; Date)
        {
        }
        field(11; "Moyen transport"; Code[20])
        {
        }
        field(12; Statut; Option)
        {
            OptionCaption = 'En attente,Apprové,Refusé,Validé';
            OptionMembers = "En attente",Approve,Refuse,Valide;
        }
        field(13; "Global Dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Global Dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(20; "Groupe destination"; Code[20])
        {
            TableRelation = "Dimension Value";
        }
        field(51; "Type mission"; Option)
        {
            OptionMembers = Locale,Etranger;
        }
        field(150; "Item Budget Name"; Code[20])
        {
            TableRelation = "Item Budget Name".Name;
        }
        field(151; "Enveloppe Bank"; Code[20])
        {
            TableRelation = "Item Budget Name";
        }
        field(500; "Statut ordre mission"; Option)
        {
            OptionCaption = 'En cours,Clôturé';
            OptionMembers = "En cours",Cloture;
        }
        field(501; Comptabilise; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "N° Demande")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

