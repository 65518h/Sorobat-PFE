Table 50009 "Bureau Ordre Diffusion"
{
    DrillDownPageID = "Ligne Document Bureau Ordre";
    LookupPageID = "Ligne Document Bureau Ordre";

    fields
    {
        field(1; "Document N°"; Code[20])
        {
        }
        field(2; "Type Destination"; Option)
        {
            Editable = false;
            OptionMembers = " ",Service,Utilisateur;
        }
        field(3; "Action"; Option)
        {
            Editable = false;
            OptionMembers = " ","Diffusé","Info Supplémantaire","Relancé",Rappel,"Transféré","Clôturer";
        }
        field(4; "Action Faite Le"; DateTime)
        {
            Editable = false;
        }
        field(5; "Action Faite Par"; Code[10])
        {
            Editable = false;
        }
        field(6; Remarque; Text[250])
        {
        }
        field(7; Destinataire; Code[20])
        {
        }
        field(8; Suivi; Option)
        {
            OptionMembers = " ","Lû","Relancé Action";
            trigger OnValidate()
            begin
                IF Suivi = Suivi::Lû THEN "Lû Le Par" := 'Lû Par ' + USERID + ' Le ' + FORMAT(CURRENTDATETIME);
                IF Suivi = Suivi::"Relancé Action" THEN "Relancé Le Par" := 'Relancé Par ' + USERID + ' Le ' + FORMAT(CURRENTDATETIME);
            end;

        }
        field(9; "Service Destinataire"; Text[30])
        {
            Editable = false;
        }
        field(10; "Lû Le Par"; Text[100])
        {
            Editable = false;
        }
        field(11; "Relancé Le Par"; Text[100])
        {
            Editable = false;
        }
        field(12; "Statut"; Option)
        {
            OptionMembers = ,Contrôle,"Vérifié Et Comptabilisé",Refusé,"Préparation Payement","Vérification Payement","En Signature","Signé Et Validé","Remise Payement";
        }
        field(50000; "N° Fournisseur"; Code[20])
        {

        }
        field(50001; "N° Ligne"; Integer)
        {
        }
        field(50002; "Nom Fournisseur"; Text[250])
        {
        }
        field(50003; "Adresse Fournisseur"; Text[250])
        {
        }
        field(50004; "Matricule Fiscale"; Text[250])
        {
        }
        field(50005; "Montant HT"; Decimal)
        {
        }
        field(50006; "Montant TTC"; Decimal)
        {
        }
        field(50007; "Montant TVA"; Decimal)
        {
        }
        field(50008; "Numero Facture"; Code[20])
        {
        }
        field(50009; "Numero Commande"; Code[20])
        {
        }
        field(50010; "Date Facture"; Date)
        {
        }
        field(50011; "Numero Fature Achat Associé"; Code[20])
        {
        }
        field(50012; "Date Jointure"; Date)
        {
        }
        field(50013; "Agent Jointure"; Code[20])
        {
        }
        field(50014; "Type identifiant"; Option)
        {
            OptionMembers = " ","Matricule Fiscal",CIN,"N° Passeport","N° Carte Sejour";
        }
        field(50015; "Receptionné Par"; Code[20])
        {
            Editable = false;
        }
        field(50016; "Receptionné Le"; Date)
        {
            Editable = false;
        }
        field(50017; "Clôturer"; Boolean)
        {
            Editable = true;
        }
        field(50018; "Référence Ligne"; Code[50])
        {
        }
        field(50019; "Date Vérification Facture"; Date)
        {
        }
        field(50020; "User Facture"; Code[20])
        {
        }
        field(50021; "Montant Timbre"; Decimal)
        {
        }
        field(50022; "N° Facture Ebreg"; Code[20])
        {
        }
        field(50023; "Statut Facture"; Option)
        {
            OptionMembers = "Verifié","Réglement en Préparation","En Cours De Signature","Signée","Payée","Partiellement Payé","Contrôle Financier en Cours","Réglement Préparé";
        }
        field(50024; "Date Facture Fournisseur"; Date)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Document N°", Action, "Action Faite Par", "Type Destination", Destinataire)
        {
            Clustered = true;
        }
        key(STG_Key2; "Document N°", "Action Faite Le")
        {

        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Receptionné Par" := UserId;
        "Receptionné Le" := Today;
    end;

    var

}

