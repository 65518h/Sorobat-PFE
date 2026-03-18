Table 52049028 "Ligne Rapport Chantier"
{
    //GL2024  ID dans Nav 2009 : "39004753"
    fields
    {
        field(1; Journee; Date)
        {
        }
        field(2; Marche; Code[10])
        {
            TableRelation = Job;
        }
        field(3; "Affectation Marche"; Code[20])
        {
            TableRelation = "Affectation Marche" where(Marche = field(Marche));
        }
        field(4; Ressource; Option)
        {
            OptionMembers = " ",MO,Transport,Engins,Appro;
        }
        field(5; Produit; Code[20])
        {
            TableRelation = Item;

            // trigger OnValidate()
            // begin
            //     if Item.Get(Produit) then Description := Item.Description;
            // end;
        }
        field(6; Heure; Time)
        {
        }
        field(7; Voyage; Integer)
        {
        }
        field(9; Provenance; Text[20])
        {
            TableRelation = "Chargement - Dechargement";
        }
        field(10; Destination; Text[20])
        {
            TableRelation = "Chargement - Dechargement";
        }
        field(11; Materiel; Code[20])
        {
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                IF Ressource = Ressource::Transport THEN
                    IF Vehicule.GET(Materiel) THEN BEGIN
                        IF Vehicule.Volume <> 0 THEN
                            Volume := Vehicule.Volume
                        ELSE
                            Volume := 18;
                    END;

            end;
        }
        field(12; Conducteur; Code[10])
        {
            TableRelation = "Shipping Agent";
        }
        field(13; MO; Code[20])
        {
            TableRelation = Resource."No." WHERE(Type = CONST(Person));

            /*  trigger OnValidate()
              begin
                  if RecSalarier.Get(MO) then begin
                      "MO Description" := RecSalarier."Nom Et Prenom";
                  end;

                  if RecEmployee.Get(MO) then begin
                      Affectation := RecEmployee.Affectation;
                      Qualification := RecEmployee.Qualification;
                      if RecSection.Get(RecEmployee.Affectation) then "Description Affectation" := RecSection.Decription;
                      if RecQualification.Get(RecEmployee.Qualification) then "Description Qualification" := RecQualification.Description;

                      RecEmployee.CalcFields("Total Indemnité Par Defaut");
                      if RecEmployee."Salaire De Base Horaire" = 0 then
                          "Slaire Brut" := RecEmployee."Total Indemnité Par Defaut" + RecEmployee."Basis salary"
                      else
                          "Slaire Brut" := RecEmployee."Total Indemnité Par Defaut" + RecEmployee."Salaire De Base Horaire";


                  end;

                  if RecEmploymentContract.Get(MO) then begin
                      "Regime Salarier" := RecEmploymentContract."Regimes of work";
                      if RecRegimesofwork.Get(RecEmploymentContract."Regimes of work") then begin
                          "Nbre Heure par mois" := RecRegimesofwork."Work Hours per month";
                          "Cout Horaire MO" := "Slaire Brut" / "Nbre Heure par mois";
                      end;
                  end;

                  if (Affectation = 'AD') or (Affectation = 'AD2') or (Affectation = 'AD3') then begin
                      "Nbre Heure par mois" := 0;
                      "Cout Horaire MO" := 0;
                      "Slaire Brut" := 0;
                  end
              end;*/
        }
        field(14; "Heure Debut"; Time)
        {
        }
        field(15; "Heure Fin"; Time)
        {
        }
        field(16; "Index Depart"; Integer)
        {
        }
        field(17; "Index Final"; Integer)
        {
        }
        field(18; "Heure Debut Panne"; Time)
        {
        }
        field(19; "Heure Fin Panne"; Time)
        {
        }
        field(20; "% Occupation"; Decimal)
        {
        }
        field(21; Localisation; Code[20])
        {
            TableRelation = "Sous Affectation Marche" where(Marche = field(Marche));
        }
        field(22; Ligne; Integer)
        {
            AutoIncrement = true;
        }
        field(23; Fonction; Code[50])
        {
        }
        field(50001; "Sous Affectation Marche"; Code[50])
        {
            TableRelation = "Sous Affectation Marche" where(Marche = field(Marche));
        }
        field(50002; "Quantité Excutée"; Decimal)
        {
        }
        field(50003; Description; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD(Produit)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "N° Document"; Code[20])
        {
        }
        field(50005; Observation; Text[250])
        {
        }
        field(50006; "MO Description"; Text[100])
        {
            CalcFormula = Lookup(Resource.Name WHERE("No." = FIELD(MO)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Compteur En Panne"; Boolean)
        {
        }
        field(50008; "Nombre Ressource"; Integer)
        {
        }
        field(50009; "Nombre Heure"; Integer)
        {
        }
        field(50010; "Tot M3"; Integer)
        {
        }
        field(50011; "Tot Heure"; Integer)
        {

            // trigger OnValidate()
            // begin
            //     "Coût Ligne" := "Cout Horaire MO" * "Tot Heure";
            // end;
        }
        field(50012; "Distance Parcourus"; Decimal)
        {
        }
        field(50013; "Description Engins"; Text[100])
        {
            CalcFormula = lookup(Véhicule.Désignation where("N° Vehicule" = field(Materiel)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50014; "Cout Direct"; Boolean)
        {
        }
        field(50015; Cout; Decimal)
        {
            DecimalPlaces = 0 : 3;
            Editable = false;
        }
        field(50016; Volume; Integer)
        {

        }
        field(50017; Statut; Option)
        {
            OptionMembers = Ouvert,"Validé";
        }

        /*    field(50021; "Heure Dispo"; Decimal)
            {
            }
            field(50022; "Cout Journalier"; Decimal)
            {
                DecimalPlaces = 3 : 3;
                Editable = false;
            }
            field(50023; "Quantité Stocké sur Chantier"; Decimal)
            {
            }
            field(50024; "Regime Salarier"; Code[10])
            {
            }
            field(50025; "Nbre Heure par mois"; Decimal)
            {
            }
            field(50026; Affectation; Code[10])
            {
            }
            field(50027; Qualification; Code[10])
            {
            }
            field(50028; "Description Affectation"; Text[100])
            {
            }
            field(50038; "WIP Report No."; Code[20])
            {
                Caption = 'WIP Report No.';
            }
            field(50029; "Description Qualification"; Text[100])
            {
            }
            field(50030; "Cout Horaire MO"; Decimal)
            {
            }
            field(50031; "Slaire Brut"; Decimal)
            {
            }
            field(50032; "Achèvement"; Boolean)
            {
            }
            field(50033; "Description Tache"; Text[250])
            {
            }
            field(50034; "Coût Ligne"; Decimal)
            {
            }
            field(50035; "Quantité Restante"; Decimal)
            {
            }
            field(50036; "Num Bon Besoin"; Text[30])
            {
            }
            field(50037; "Code unité"; Code[10])
            {
                Caption = 'Unit of Measure Code';
                TableRelation = "Unit of Measure";

                trigger OnValidate()
                var
                    UnitOfMeasureTranslation: Record "Unit of Measure Translation";
                    ResUnitofMeasure: Record "Resource Unit of Measure";
                    lCurrFieldNo: Integer;
                //  lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
                begin
                end;
            }*/
    }

    keys
    {
        key(STG_Key1; "N° Document", Ligne)
        {
            Clustered = true;
        }
        key(STG_Key2; Journee, Marche, Materiel)
        {
        }
        key(STG_Key3; Journee, Marche, Produit)
        {
        }
        key(STG_Key4; Journee, Marche, MO)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if EnteteRapportChantier.Get("N° Document") then begin
            Journee := EnteteRapportChantier.Journee;
            Marche := EnteteRapportChantier.Marche;
            "Affectation Marche" := EnteteRapportChantier.Article;
            "Sous Affectation Marche" := EnteteRapportChantier."Sous Article";
        end;
    end;

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
        RecSection: Record "Tranche STC";
        RecQualification: Record Qualification;
}

