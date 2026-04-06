Table 52048986 "Réparation Véhicule"
{
    //GL2024  ID dans Nav 2009 : "39004689"
    DrillDownPageID = "Liste Réparation";
    LookupPageID = "Liste Réparation";

    fields
    {
        field(1; "N° Reparation"; Code[20])
        {
        }
        field(2; "N° Véhicule"; Code[20])
        {
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                if Veh.Get("N° Véhicule") then begin
                    "N° Immantricule" := Veh.Immatriculation;
                    Index := Veh."Index Théorique Final";
                    if "Date Acceptation" <= Veh."Date Fin de Garantie" then
                        Garentie := true;
                    Affectation := Veh.marche;
                end;
            end;
        }
        field(3; "N° Intervenant"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if interv.Get("N° Intervenant") then
                    "Descriptif Panne" := interv.Name;
            end;
        }
        field(4; "Date Acceptation"; Date)
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
            CalcFormula = sum("Détail Reparation"."Montant Reparation" where("N° Reparation" = field("N° Reparation")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "No. Series"; Code[20])
        {
        }
        field(9; "N° Immantricule"; Code[20])
        {
        }
        field(10; "Descriptif Panne"; Text[250])
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
            DecimalPlaces = 0 : 0;
        }
        field(15; "Nature Panne"; Option)
        {
            OptionCaption = ' ,Mécanique,Electrique,Pneumatique,Tollerie';
            OptionMembers = " ","Mécanique",Electrique,Pneumatique,Tollerie;
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
        field(18; "Filtre Date"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = Date;
        }
        field(133; Affectation; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';
            TableRelation = Job;

            trigger OnValidate()
            begin
                TestField("N° Véhicule");
                if Veh.Get("N° Véhicule") then begin
                    Veh.marche := Affectation;
                    Veh.Modify;
                end;
            end;
        }
        field(134; "N° Tache Affaire"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';
            TableRelation = "Job Task"."Job Task No.";
        }
        field(135; "Centre de Gestion"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'HJ DSFT 29-06-2012';
            Editable = false;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var

            begin
            end;
        }
        field(50000; "Heure Debut Réparation"; Time)
        {
        }
        field(50001; "Heure Fin Réparation"; Time)
        {
        }
        field(50003; "Heure Acceptation"; Time)
        {
        }
        field(50004; Valider; Boolean)
        {
        }
        field(50005; "Statut Materiel"; Option)
        {
            OptionMembers = " ",Fonctionnel,Disponible,Panne,"Mauvais Temps";

            trigger OnValidate()
            begin
                TestField("N° Véhicule");
                if Veh.Get("N° Véhicule") then begin
                    Veh."Statut" := "Statut Materiel";
                    Veh.Modify;
                end;
            end;
        }
        field(50006; "Total Cout réparation"; Decimal)
        {
            CalcFormula = sum("PR Réparation"."Coût Total" where("N° Reparation" = field("N° Reparation")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Date Prevision Réparation"; Date)
        {
        }
        field(50008; "Heure Prevision Réparation"; Time)
        {
        }
        field(50009; "Motif  Ecart"; Option)
        {
            OptionMembers = " ","Piece Non Disponible","Main Ouevre Non Disponible","Travail Supplementaire","DA En Cours","Livraison Partielle Piece",Autre;
        }
        field(50010; Statut; Option)
        {
            OptionMembers = Ouvert,"En Attente","En Cours","Clôturé";

            trigger OnValidate()
            begin
                if Statut = Statut::Clôturé then begin
                    if Veh.Get("N° Véhicule") then begin
                        Choice := StrMenu(Text001, 1);
                        if Choice = 1 then Veh.Statut := Veh.Statut::Fonctionnel;
                        if Choice = 2 then Veh.Statut := Veh.Statut::Disponible;
                        if Choice = 3 then Veh.Statut := Veh.Statut::Panne;

                        Veh.Modify;
                    end;
                end;
            end;
        }
        field(50011; Synchronise; Boolean)
        {
        }
        field(50012; "Opération Realisées"; Text[250])
        {
        }
        field(50013; "Sous Nature Panne"; Code[50])
        {
            //GL3900  TableRelation = "Sous Nature Panne"."Sous Nature Panne" where("Nature Panne" = field("Nature Panne"));
        }
    }

    keys
    {
        key(STG_Key1; "N° Reparation")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        PaymentClass: Record "Payment Class";
        NoSeriesManagement: Codeunit NoSeriesManagement;


        IsHandled: Boolean;
    begin
        /*GL2024   if "N° Reparation" = '' then begin
               ParcSetup.Get;
               if RecUserSetup.Get(UserId) then;
               "Centre de Gestion" := RecUserSetup."Car Pool Resp. Ctr. Filter";

               ParcSetup.TestField("N° Réparation");
               CduNoSeriesRespCentManagement.InitSeries(ParcSetup."N° Réparation", xRec."No. Series", 0D, "N° Reparation", "No. Series",
               RecUserSetup."Car Pool Resp. Ctr. Filter");
           end;
           "Date Acceptation" := Today;
   */

        //GL2024
        if "N° Reparation" = '' then begin
            ParcSetup.Get;
            if RecUserSetup.Get(UserId) then;
            "Centre de Gestion" := RecUserSetup."Car Pool Resp. Ctr. Filter";
            ParcSetup.TestField("N° Réparation");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(ParcSetup."N° Réparation", xRec."No. Series", 0D, "N° Reparation", rec."No. Series", IsHandled);
            if not IsHandled then begin

                rec."No. Series" := ParcSetup."N° Réparation";
                if NoSeries.AreRelated(rec."No. Series", xRec."No. Series") then
                    rec."No. Series" := xRec."No. Series";
                rec."N° Reparation" := NoSeries.GetNextNo(rec."No. Series");

                NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(rec."No. Series", ParcSetup."N° Réparation", 0D, rec."N° Reparation");
            end;
            //GL2024
        end;
        "Date Acceptation" := Today;
    end;

    var
        ParcSetup: Record "Paramétre Parc";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Veh: Record "Véhicule";
        interv: Record Vendor;
        //GL3900    pneu: Record "Pneumatique Véhicule";
        RecRepaPneu: Record "Reparation Pneu";
        //CduNoSeriesRespCentManagement: Codeunit NoSeriesRespCenterManagement;
        RecUserSetup: Record "User Setup";
        "N°  Affaire": Code[20];
        Text001: label 'Fonctionnel,Disponible,Panne';
        Choice: Integer;


    procedure AssistEdit(OldRep: Record "Réparation Véhicule"): Boolean
    var
        Rep: Record "Réparation Véhicule";
    begin
        with Rec do begin
            Rep := Rec;
            ParcSetup.Get;
            ParcSetup.TestField("N° Réparation");
            if NoSeriesMgt.SelectSeries(ParcSetup."N° Réparation", OldRep."No. Series", "No. Series") then begin
                ParcSetup.Get;
                ParcSetup.TestField("N° Réparation");

                NoSeriesMgt.SetSeries("N° Reparation");
                Rec := Rep;
                exit(true);
            end;
        end;



    end;


}

