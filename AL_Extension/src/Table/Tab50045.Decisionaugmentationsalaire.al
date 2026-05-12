Table 50045 "Decision augmentation salaire"
{
    LookupPageID = "Liste Décision augmentation";

    fields
    {
        field(1; "N° Decision"; Code[20])
        {
        }
        field(2; Matricule; Code[20])
        {
            TableRelation = Employee where(Blocked = filter(false));

            // trigger OnValidate()
            // begin
            //     if RecEmploye.Get(Matricule) then begin
            //         //   GL2024    "Nom et Prénom" := RecEmploye."First Name";
            //         "Nom et Prénom" := RecEmploye."First Name";
            //         Qualification := RecEmploye.Qualification;
            //         Affectation := RecEmploye.Affectation;
            //         "Date de recrutement" := RecEmploye."Employment Date";
            //         "Salaire actuel" := RecEmploye."Salaire Net Simulé";
            //         if RecQualification.Get(RecEmploye.Qualification) then "Description Qualification" := RecQualification.Description;
            //         if Recsection.Get(RecEmploye.Affectation) then "Description Affectation" := Recsection.Decription;
            //     end
            // end;
        }
        field(3; "Nom et Prénom"; Text[100])
        {
        }
        field(4; Qualification; Code[20])
        {
        }
        field(5; "Description Qualification"; Text[100])
        {
        }
        field(6; Affectation; Code[20])
        {
        }
        field(7; "Description Affectation"; Text[100])
        {
        }
        field(8; "Date de recrutement"; Date)
        {
        }
        field(9; "Salaire actuel"; Decimal)
        {
        }
        field(10; "Montant d'augmentation"; Decimal)
        {

            trigger OnValidate()
            begin
                "Nouveau Salaire" := "Salaire actuel" + "Montant d'augmentation" + "Motant Complement" + "Augmentation sur complement";
            end;
        }
        field(11; "Nouveau Salaire"; Decimal)
        {
        }
        field(12; "Date d'effet"; Date)
        {
        }
        field(13; "Proposé par"; Text[100])
        {
        }
        field(14; "Date Création"; Date)
        {
        }
        field(15; "Créer par"; Code[20])
        {
        }
        field(16; "Validé"; Boolean)
        {
        }
        field(17; "Date Validation"; Date)
        {
        }
        field(18; "Validé Par"; Code[20])
        {
        }
        field(19; "Motant Complement"; Decimal)
        {
        }
        field(20; "Augmentation sur complement"; Decimal)
        {

            trigger OnValidate()
            begin
                "Nouveau Salaire" := "Salaire actuel" + "Montant d'augmentation" + "Motant Complement" + "Augmentation sur complement";
            end;
        }
        field(21; "Nouveau slaire complement"; Decimal)
        {
        }
        field(22; "Champs Libre"; Decimal)
        {
        }
        field(23; Observation; Text[250])
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° Decision")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Recsection: Record "Tranche STC";
        RecQualification: Record Qualification;
        Affect: Text[150];
        Qualif: Text[150];
        RecEmploye: Record Employee;
}

