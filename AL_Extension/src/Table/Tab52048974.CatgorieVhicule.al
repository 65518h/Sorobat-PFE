Table 52048974 "Catégorie Véhicule"
{
    //GL2024  ID dans Nav 2009 : "39004674"
    DrillDownPageID = "Catégorie Véhicule";
    LookupPageID = "Catégorie Véhicule";

    fields
    {
        field(1; "Code Catégorie"; Code[50])
        {
        }
        field(2; "Désignation"; Text[30])
        {
        }
        field(3; Synchronise; Boolean)
        {
        }
        field(4; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        /*  field(51000; "Cout Location Journalier"; Decimal)
          {
              Description = 'HJ SORO 15-02-2014';

                trigger OnValidate()
                begin
                    if "Cout Location Journalier" = 0 then exit;
                    if not Confirm(Text001) then exit;
                    RecVehicule.SetRange(Famille, "Code Catégorie");
                    RecVehicule.ModifyAll(RecVehicule."Cout Location Journaliere", "Cout Location Journalier");
                    HistoriqueVéhicule.Init;
                    HistoriqueVéhicule.Type := HistoriqueVéhicule.Type::Location;
                    HistoriqueVéhicule."Date Affectation" := WorkDate;
                    HistoriqueVéhicule.Famille := "Code Catégorie";
                    HistoriqueVéhicule."Montant Location" := "Cout Location Journalier";
                    if not HistoriqueVéhicule.Insert then HistoriqueVéhicule.Modify;
                end;
          }*/
    }

    keys
    {
        key(Key1; "Code Catégorie")
        {
            Clustered = true;
        }
        key(Key2; Synchronise)
        {
        }
    }

    fieldgroups
    {
    }

    var
        RecVehicule: Record "Véhicule";
        Text001: label 'Appliquer Ce Montant ?';
    //  "HistoriqueVéhicule": Record "Historique Véhicule";
}

