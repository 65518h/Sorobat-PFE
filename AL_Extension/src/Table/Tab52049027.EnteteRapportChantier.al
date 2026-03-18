Table 52049027 "Entete Rapport Chantier"
{
    //GL2024  ID dans Nav 2009 : "39004752"
    DrillDownPageID = "Affectation Marche";
    LookupPageID = "Affectation Marche";

    fields
    {
        field(1; Journee; Date)
        {

            trigger OnValidate()
            begin
                LigneRapportChantier.SetRange("N° Document", "N° Document");
                if LigneRapportChantier.FindFirst then
                    repeat
                        LigneRapportChantier.Journee := Journee;
                        LigneRapportChantier.Modify;
                    until LigneRapportChantier.Next = 0;
            end;
        }
        field(2; Marche; Code[10])
        {
            TableRelation = Job;

            trigger OnValidate()
            begin
                LigneRapportChantier.SetRange("N° Document", "N° Document");
                if LigneRapportChantier.FindFirst then
                    repeat
                        LigneRapportChantier.Journee := Journee;
                        LigneRapportChantier.Modify;
                    until LigneRapportChantier.Next = 0;
            end;
        }
        field(3; Article; Code[20])
        {
            TableRelation = "Affectation Marche" where(Marche = field(Marche));

            trigger OnValidate()
            begin
                SalesLine.SETRANGE("No.", Article);
                IF SalesLine.FINDFIRST THEN PU := SalesLine."Unit Price";

            end;
        }
        field(4; "Quantité Prevue"; Decimal)
        {
        }
        field(5; "Unité"; Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(50001; "Sous Article"; Code[50])
        {
            TableRelation = "Sous Affectation Marche" where(Marche = field(Marche));
        }
        field(50002; Produit; Code[20])
        {
            TableRelation = Item;
        }
        field(50003; "Quantité Transporté"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(50004; "Quantité Exécutée"; Decimal)
        {
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                "Montant Article" := PU * "Quantité Exécutée";
            end;
        }
        field(50005; Foisonnement; Decimal)
        {
        }
        field(50006; Temperature; Integer)
        {
        }
        field(50007; Vent; Integer)
        {
        }
        field(50008; Pluie; Integer)
        {
        }
        field(50009; "Nombre Heure Journée"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(50010; "Unité Excécution"; Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(50011; "N° Document"; Code[20])
        {
        }
        field(50012; "Heure Arrêt"; Integer)
        {
        }
        field(50013; Observation; Text[250])
        {
        }
        field(50014; Statut; Option)
        {
            OptionMembers = Ouvert,"Validé";
        }
        field(50015; PK; Code[50])
        {
        }
        field(50016; "PT Debut"; Code[50])
        {
        }
        field(50017; "PT Fin"; Code[50])
        {
        }
        field(50018; "Largeur Moyenne"; Decimal)
        {
        }
        field(50019; Surface; Decimal)
        {
        }
        field(50020; Volume; Decimal)
        {
        }
        field(50021; "Cout MO"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50022; "Cout Engins"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50023; "Cout Transport"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50024; "Cout Appro"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50025; "Cout Total"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50026; PU; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = Normal;
        }
        field(50027; "Montant Article"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50028; "Exécution"; Boolean)
        {
        }
        /*  field(50029; "Cout Unitaire Exécuté"; Decimal)
          {
              DecimalPlaces = 3 : 3;
              Editable = false;
          }
          field(50031; Chapitre; Text[100])
          {
              Editable = false;
          }
          field(50032; "Cout Gasoil"; Decimal)
          {
          }
          field(50033; Probleme; Boolean)
          {
          }
          field(50034; "Description Article"; Text[100])
          {
              Editable = false;
          }
          field(50035; "Nom Responsable"; Text[100])
          {
          }
          field(50036; Emplacement; Text[100])
          {
          }
          field(50037; "Sous Traitant"; Boolean)
          {
          }
          field(50038; Lot; Text[30])
          {
          }
          field(50039; "Agent Saisie"; Code[20])
          {
          }
          field(50040; "Date Saisie"; Date)
          {
          }
          field(50041; "Lot Marché"; Text[150])
          {
              //  TableRelation = "Lot de Marché";
          }
          field(50042; "Article Marché"; Text[150])
          {
          }*/
    }

    keys
    {
        key(STG_Key1; "N° Document")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LigneRapportChantier.SetRange("N° Document", "N° Document");
        LigneRapportChantier.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "N° Document" = '' then begin
            if ParametreParc.Get then;
            "N° Document" := NoSeriesMgt.GetNextNo(ParametreParc."N° Rapport Chantier", 0D, true);
            //Journee:=TODAY;
            /*  "Agent Saisie" := UserId;
              "Date Saisie" := Today();*/
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParametreParc: Record "Paramétre Parc";
        LigneRapportChantier: Record "Ligne Rapport Chantier";
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
}

