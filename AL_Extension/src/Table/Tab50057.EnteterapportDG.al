Table 50057 "Entete rapport DG"
{
    DrillDownPageID = "Societe Affaire";
    LookupPageID = "Societe Affaire";

    fields
    {
        field(1; "N° Rapport"; Code[20])
        {
        }
        field(2; Description; Text[150])
        {
        }
        field(3; "Date Rapport"; Date)
        {
        }
        field(4; "Marché"; Code[20])
        {
            TableRelation = Job;
        }
        field(5; "Cloturé"; Boolean)
        {

            trigger OnValidate()
            begin
                DetailRapportDG.SetRange("N° Rapport", "N° Rapport");
                DetailRapportDG.ModifyAll(Cloturée, true);
            end;
        }
        field(6; "Prix Gasoil"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(7; Rabais; Decimal)
        {
        }
        field(8; Centrale; Boolean)
        {
        }
        field(9; "Correspandance Marché"; Text[150])
        {
        }
        field(10; "Code Centrale Materiel"; Code[20])
        {
            TableRelation = Véhicule;
        }
        field(11; "Cout Location Terrain"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(12; "Remise Location Materiel"; Decimal)
        {
        }
        field(13; "Integrer Tout Materiaux"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "N° Rapport")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DetailRapportDG.SetRange("N° Rapport", "N° Rapport");
        DetailRapportDG.DeleteAll;
    end;

    trigger OnInsert()
    begin
        // if "N° Rapport" = '' then begin
        //     if JobsSetup.Get then;
        //     "N° Rapport" := NoSeriesMgt.GetNextNo(JobsSetup."N° Rapport DG", 0D, true);

        // end;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        JobsSetup: Record "Jobs Setup";
        DetailRapportDG: Record "Detail Rapport DG";
        Text001: label 'Vous devez d''abord archiver avant de changer de date rapport';
        DetailRapportDGArchive: Record "Detail Rapport DG Archivé";
        Text002: label 'Archivage Terminé avec succé';
}

