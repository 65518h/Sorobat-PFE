Table 8004183 "Ligne Rapport Panne véhicule"
{

    fields
    {
        field(1; "N°"; Code[20])
        {
        }
        field(2; Journee; Date)
        {
        }
        field(3; Marche; Code[20])
        {
            TableRelation = Job;
        }
        field(4; Materiel; Code[20])
        {
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                if Vehicule.Get(Materiel) then begin
                    Description := Vehicule.Désignation;
                end;
            end;
        }
        field(5; Description; Text[150])
        {
            Editable = false;
        }
        field(6; Emplacement; Text[50])
        {
        }
        field(7; "Date Panne"; Date)
        {
        }
        field(8; "Numero DA"; Text[30])
        {
        }
        field(9; "Nature de Panne"; Text[250])
        {
        }
        field(10; "Date Début Réparation"; Date)
        {
        }
        field(11; "Date Fin Réparation"; Date)
        {
        }
        field(12; Observation; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "N°", Materiel)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Vehicule: Record "Véhicule";
        Resource: Record Resource;
        Item: Record Item;
        EnteteRapportChantier: Record "Entete Rapport Chantier";
        Text001: label 'Qualification non mentionné pour cette ressource, veuiller remplir ce champ';
        RecSalarier: Record Salarier;
        RecEmploymentContract: Record "Employment Contract";
        RecRegimesofwork: Record "Regimes of work";
        RecEmployee: Record Employee;
        //GL2024   RecSection: Record Section;
        RecQualification: Record Qualification;
}

