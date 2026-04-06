Table 52048983 "Mission Enregistré"
{
    //GL2024  ID dans Nav 2009 : "39004684"
    DrillDownPageID = "Liste Missions enreg.";
    LookupPageID = "Liste Missions enreg.";

    fields
    {
        field(1; "N° Mission"; Code[30])
        {
        }
        field(2; "Date document"; Date)
        {
        }
        field(3; "Date Mission"; Date)
        {
        }
        field(4; "Code Demandeur"; Code[10])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if employer.Get("Code Demandeur") then begin
                    "Nom Demandeur" := employer."First Name";
                    "Fonction Demandeur" := employer."Job Title";
                end;
            end;
        }
        field(5; "Nom Demandeur"; Text[30])
        {
            Editable = false;
        }
        field(6; "Fonction Demandeur"; Text[30])
        {
            Editable = false;
        }
        field(7; "Objet mission"; Text[100])
        {
        }
        field(8; "Date Départ"; Date)
        {
        }
        field(9; "Date Arrivée"; Date)
        {
        }
        field(10; "Lieu départ"; Code[50])
        {
            TableRelation = "Post Code";
        }
        field(11; "Lieu Arrivé"; Code[50])
        {
            TableRelation = "Post Code";
        }
        field(12; "N° Véhicule"; Code[10])
        {
            TableRelation = Véhicule;


            trigger OnValidate()
            begin
                if Veh.Get("N° Véhicule") then
                    if Veh.Bloquer then
                        Error('Véhicule Bloquer');
                CartGrise.Reset;
                CartGrise.SetRange("N° Veh", "N° Véhicule");
                if CartGrise.Find('-') then begin
                    "Type Véhicule" := CartGrise.Type;
                    "Puissance Véhicule" := CartGrise.Puissance;
                    Modify;
                end;
            end;
        }
        field(13; "Type Véhicule"; Code[20])
        {
            Editable = false;
        }
        field(14; "Puissance Véhicule"; Code[10])
        {
            Editable = false;
        }
        field(15; "Km Parcourus"; Decimal)
        {
            DecimalPlaces = 0 : 3;

            trigger OnValidate()
            begin
                //Refresh Index Théorique Final dans la fiche véhicule
                if Veh.Get("N° Véhicule") then begin
                    Veh."Index Théorique Final" := Veh."Index Théorique Final" - xRec."Km Parcourus" + "Km Parcourus";
                    Veh.Modify;
                end;
            end;
        }
        field(16; "No. Series"; Code[10])
        {
        }
        field(17; "Index Cpt. Depart"; Decimal)
        {
            DecimalPlaces = 0 : 3;

            trigger OnValidate()
            begin
                Validate("Km Parcourus", "Index Cpt. Retour" - "Index Cpt. Depart");
            end;
        }
        field(18; "Index Cpt. Retour"; Decimal)
        {
            DecimalPlaces = 0 : 3;

            trigger OnValidate()
            begin
                Validate("Km Parcourus", "Index Cpt. Retour" - "Index Cpt. Depart");
            end;
        }
        field(19; "Filtre Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Filtre Véhicule"; Code[10])
        {
            FieldClass = FlowFilter;
            //GL2024  TableRelation = Table70000;
        }
        field(21; "Heure Départ"; Time)
        {
        }
        field(22; "Heure Arrivée"; Time)
        {
        }
        field(110; "Type Vehicule Mission"; Option)
        {
            OptionMembers = " ","Voiture de la Société","Voiture Personnel";
        }
        field(111; "N° Demande Mission RH"; Code[10])
        {
        }
        field(112; "No. Immatriculation"; Code[20])
        {
        }
        field(113; Status; Option)
        {
            OptionMembers = "Lancée","Modifiée","Annulée";
        }
        field(114; "Code Utilisateur"; Code[20])
        {
        }
        field(115; "Code Convoyeur"; Code[10])
        {
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                /*
                IF transporteur.GET("Code Convoyeur") THEN
                   "Nom Convoyeur" := transporteur.Name;
                 */

            end;
        }
        field(116; "Nom Convoyeur"; Text[60])
        {
        }
        field(120; "Code Client"; Code[20])
        {
            TableRelation = Customer;
        }
        field(121; "Nbre Heure Prepara marchandise"; Decimal)
        {
        }
        field(122; "Total Frais deplacement"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(123; "Coût  Marchandise"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(124; "Coût de kilometrage"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(125; "Coût de livraison"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(126; "Nbre heure"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(127; "Index Dérnier Rép"; Decimal)
        {
            Description = 'IMS 11 02 2011';
        }
        field(128; "Index Rép Prévu"; Decimal)
        {
            Description = 'IMS 11 02 2011';
        }
        field(129; "Index Fréquence"; Decimal)
        {
            Description = 'IMS 11 02 2011';
        }
        field(130; "Index Cumul"; Decimal)
        {
            Description = 'IMS 11 02 2011';
        }
        field(131; Alerte; Text[250])
        {
            Description = 'IMS 11 02 2011';
        }
        field(133; "N° Affaire"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';
            TableRelation = Job;
        }
        field(134; "N° Tache Affaire"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("N° Affaire"));
        }
        field(135; "Centre de Gestion"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'HJ DSFT 29-06-2012';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
            //   lSingleinstance: Codeunit "Import SingleInstance2";
            begin
            end;
        }
        /*  field(139; "Engin Transporté"; Code[20])
          {
              Description = 'HJ SORO 21-04-2015';
              TableRelation = Véhicule;
          }*/
    }

    keys
    {
        key(STG_Key1; "N° Mission")
        {
            Clustered = true;
            SumIndexFields = "Km Parcourus";
        }
        key(STG_Key2; Status)
        {
            SumIndexFields = "Km Parcourus";
        }
        key(STG_Key3; "N° Véhicule", Status)
        {
            SumIndexFields = "Km Parcourus";
        }
        key(STG_Key4; "N° Véhicule", "Index Cpt. Depart")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF "N° Mission" = '' THEN BEGIN
          ParcSetup.GET;
          ParcSetup.TESTFIELD("N° Mission");
            NoSeriesMgt.InitSeries(ParcSetup."N° Mission",xRec."No. Series",0D,"N° Mission","No. Series");
        END;*/
        //"Date document" := TODAY;
        "Code Utilisateur" := UserId;

    end;

    trigger OnModify()
    begin
        "Code Utilisateur" := UserId;
    end;

    var
        ParcSetup: Record "Paramétre Parc";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        employer: Record Employee;
        CartGrise: Record "Carte Grise Vehicule";
        Veh: Record "Véhicule";


    procedure AssistEdit(OldMiss: Record Missions): Boolean
    var
        Miss: Record Missions;
    begin
        /*WITH Rec DO BEGIN
          Miss := Rec;
          ParcSetup.GET;
          ParcSetup.TESTFIELD("N° Mission");
          IF NoSeriesMgt.SelectSeries(ParcSetup."N° Mission",OldMiss."No. Series","No. Series") THEN BEGIN
            ParcSetup.GET;
            ParcSetup.TESTFIELD("N° Mission");
            NoSeriesMgt.SetSeries("N° Mission");
            Rec := Miss;
            EXIT(TRUE);
          END;
        END;*/

    end;


    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc(Today, "N° Mission");
        NavigateForm.Run;
    end;
}

