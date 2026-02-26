Table 50032 "Detail Rapport DG"
{

    fields
    {
        field(1; "Marché"; Code[20])
        {
            TableRelation = Job."No.";
        }
        field(2; "Date Rapport"; Date)
        {
        }
        field(3; Designatiion; Text[150])
        {

            trigger OnValidate()
            begin
                //IF "Type Ligne"<>"Type Ligne"::"Frais Annexe" THEN  "Charge Fixe":=TRUE;
                // if "Type Ligne" = "type ligne"::"Frais Annexe" then
                //     if ItemCharge.Get("Code Frais") then begin
                //         ItemCharge."Description Bilan" := Designatiion;
                //         ItemCharge.Modify;
                //     end;
            end;
        }
        field(4; "Unité"; Text[30])
        {
        }
        field(5; "Quantité Marché"; Decimal)
        {
        }
        field(6; "Quantité Exécuté"; Decimal)
        {
        }
        field(7; "Quantité Livré"; Decimal)
        {
        }
        field(8; Difference; Decimal)
        {
        }
        field(9; Niveau; Integer)
        {
        }
        field(10; Observation; Text[250])
        {
        }
        field(11; "N° Rapport"; Code[20])
        {
        }
        field(12; "Type Ligne"; Option)
        {
            OptionMembers = Materiaux,MO,Gasoil,Materiel,Decompte,"Frais Annexe",Loyer,"Puce TelePhonique",Divers,"Reste à Facturer",Ratios,"Revision Prix",Bilan,Resultat,Totaux;
        }
        field(13; Effectif; Integer)
        {
        }
        field(14; "MS Actuelle"; Decimal)
        {
        }
        field(15; "MS Cumulée"; Decimal)
        {
        }
        field(16; "Nombre F"; Integer)
        {
            Description = 'Fonctionnel';
        }
        field(17; "Nombre P"; Integer)
        {
            Description = 'Panne';
        }
        field(18; "Nombre D"; Integer)
        {
            Description = 'Disponible';
        }
        field(19; "Nombre C"; Integer)
        {
            Description = 'Congé';
        }
        field(20; "Nombre Ref"; Integer)
        {
            Description = 'Reformé';
        }
        field(21; "Nombre M.T"; Integer)
        {
            Description = 'Mauvais Temps';
        }
        field(22; "% Occupation"; Decimal)
        {
        }
        field(23; "Nombre Heures"; Decimal)
        {
        }
        field(24; "N° Ligne"; Integer)
        {
        }
        field(28; "Grande famille Materiel"; Code[30])
        {
        }
        field(29; "Cout Location"; Decimal)
        {
        }
        field(30; Montant; Decimal)
        {

            trigger OnValidate()
            begin
                "Charge Fixe" := true;
            end;
        }
        field(31; "Observation 2"; Text[50])
        {
        }
        field(32; "Date Ordre Service"; Date)
        {
        }
        field(33; "Date Mise a Jour"; Date)
        {
        }
        field(34; "Nombre De Mois"; Integer)
        {
        }
        field(35; "Montant Marché"; Decimal)
        {
        }
        field(36; "Montant Decompte"; Decimal)
        {
        }
        field(37; "Charge Fixe"; Boolean)
        {
        }
        field(38; "Cloturée"; Boolean)
        {
        }
        field(41; "Regroupement Foison."; Code[20])
        {
            Description = 'Taux Foisonnement';
            TableRelation = "Regroupement Rapport DG" where(Type = const("Rapport DG"));
        }
        field(42; "Montant Diff"; Decimal)
        {
        }
        field(43; "Prix Unitaire Moy  Marché"; Decimal)
        {
        }
        field(44; "Regroupement Bilan"; Code[20])
        {
            SQLDataType = Varchar;
            TableRelation = "Regroupement Rapport DG" where(Type = const(Bilan));
        }
        field(45; "Type Diff"; Option)
        {
            OptionMembers = " ",D,S;
        }
        field(46; "Taux Foisonnement"; Decimal)
        {
        }
        field(47; "Quantité"; Decimal)
        {
        }
        field(48; "Coeficent Colisage T/M3"; Decimal)
        {
        }
        field(49; "Non Inclu Reste à facturer"; Boolean)
        {
        }
        field(50; "Poste N°"; Code[20])
        {
        }
        field(51; "Reste a Facturer"; Boolean)
        {
        }
        field(52; "Quantitée Difference"; Decimal)
        {
        }
        field(53; "Quantité Decompte"; Decimal)
        {
        }
        field(54; Ratios; Decimal)
        {
        }
        field(55; Archiver; Boolean)
        {
        }
        field(56; "Quantité Origine"; Decimal)
        {
        }
        field(57; "Code Frais"; Code[20])
        {
        }
        field(58; "Sous Traitance"; Boolean)
        {

            trigger OnValidate()
            begin
                // if "Type Ligne" = "type ligne"::"Frais Annexe" then
                //     if ItemCharge.Get("Code Frais") then begin
                //         ItemCharge."Sous Traitance" := "Sous Traitance";
                //         ItemCharge.Modify;
                //     end;
            end;
        }
        field(59; "Delai Suspension"; Decimal)
        {
        }
        field(60; "Prix Marché"; Decimal)
        {
        }
        field(61; "Jours Payés"; Decimal)
        {
        }
        field(62; "Date Fin Previsionnelle"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Marché", "N° Rapport", "N° Ligne", "Type Ligne", "Date Rapport")
        {
            Clustered = true;
        }
        key(Key2; Niveau)
        {
        }
        key(Key3; "Marché", "Date Rapport", "Type Ligne", Designatiion)
        {
        }
    }

    fieldgroups
    {
    }

    var
        ItemCharge: Record "Item Charge";
}

