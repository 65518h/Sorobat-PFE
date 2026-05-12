Table 52048989 "Réparation Véhicule Enreg."
{//GL2024  ID dans Nav 2009 : "39004696"
    DrillDownPageID = "Liste Réparation Enreg.";
    LookupPageID = "Liste Réparation Enreg.";

    fields
    {
        field(1; "N° Reparation"; Code[20])
        {
        }
        field(2; "N° Véhicule"; Code[20])
        {
            //GL2024  TableRelation = Table70000;
        }
        field(3; "N° Intervenant"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(4; "Date document"; Date)
        {
        }
        field(5; "Date Début Réparation"; Date)
        {
        }
        field(6; "Date Fin réparation"; Date)
        {
        }
        field(7; "Montant Réparation"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Détail Reparation Enreg."."Montant Reparation" where("N° Reparation" = field("N° Reparation")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "No. Series"; Code[10])
        {
        }
        field(9; "N° Immantricule"; Code[20])
        {
        }
        field(10; "Nom Intervenant"; Text[30])
        {
        }
        field(11; Garentie; Boolean)
        {
        }
        field(12; "Accidentée"; Boolean)
        {
        }
        field(13; "N° Accident"; Code[10])
        {
        }
        field(14; Index; Decimal)
        {
        }
        field(15; "Nature de panne"; Option)
        {
            OptionCaption = ' ,Mécanique,Electrique,Pneumatique';
            OptionMembers = " ","Mécanique",Electrique,Pneumatique;
        }
        field(16; "Degré d'Urgence"; Option)
        {
            OptionCaption = 'Normal,Urgent, Trés Urgent';
            OptionMembers = Normal,Urgent," Trés Urgent";
        }
        field(17; Type; Option)
        {
            OptionCaption = 'Corrective,Préventive';
            OptionMembers = Corrective,"Préventive";
        }
        field(18; "N° Affaire"; Code[20])
        {
            TableRelation = Job;
        }
        field(19; "N° Tache Affaire"; Code[20])
        {
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("N° Affaire"));
        }
        field(20; "Centre de Gestion"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
            // lSingleinstance: Codeunit "Import SingleInstance2";
            begin
            end;
        }
        field(50000; "Intervenant Interne"; Code[20])
        {
            TableRelation = Salarier;
        }
        field(50001; "Nom Intervenant Interne"; Text[100])
        {
            // CalcFormula = lookup(Salarier."Nom Et Prenom" where(Salarie = field("Intervenant Interne")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(50002; Statut; Option)
        {
            Description = 'HJ SORO 21-04-2015';
            OptionMembers = Saisie,"Lancé","En Cours","Terminé";
        }
    }

    keys
    {
        key(STG_Key1; "N° Reparation")
        {
            Clustered = true;
        }
        key(STG_Key2; "N° Véhicule")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ParcSetup: Record "Paramétre Parc";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Veh: Record "Véhicule";
        interv: Record Vendor;


    procedure AssistEdit(OldRep: Record "Réparation Véhicule"): Boolean
    var
        Rep: Record "Réparation Véhicule";
    begin
    end;
}

