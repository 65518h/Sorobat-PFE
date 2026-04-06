table 52049017 "Entete BRD"
{
    // DrillDownPageID = "ASS-Liste Entete BRD";
    ////  LookupPageID = "ASS-Liste Entete BRD";
    //GL2024  ID dans Nav 2009 : "39001495"

    fields
    {
        field(1; "No. BRD"; Code[20])
        {
        }
        field(2; DateLastModif; Date)
        {
        }
        field(3; Mois; Option)
        {
            OptionMembers = Janvier,Fevrier,Mars,Avril,Mai,Juin,Juillet,Aout,Septembre,Octobre,Novembre,"Décembre";
        }
        field(4; Annee; Integer)
        {
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(6; Statut; Option)
        {
            OptionCaption = 'Encour,Validé';
            OptionMembers = Encour,Valide;
        }
    }

    keys
    {
        key(STG_Key1; "No. BRD")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No. BRD" = '' THEN BEGIN
            HumanRessourceSetup.GET;
            HumanRessourceSetup.TESTFIELD("N° Borderau");
            NoSeriesMgt.InitSeries(HumanRessourceSetup."N° Borderau", xRec."No. BRD", 0D, "No. BRD", "No. Series");
        END;
        Annee := DATE2DMY(WORKDATE, 3);
        Mois := DATE2DMY(WORKDATE, 2) - 1;
    end;

    trigger OnModify()
    begin
        DateLastModif := TODAY;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        HumanRessourceSetup: Record 5218;
}

