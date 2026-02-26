
Table 52049037 "Pneumatique Véhicule"
{
    //GL2024  ID dans Nav 2009 : "39004681"

    //GL2024     LookupPageID = 39001591;
    //GL2024   DrillDownPageID = 39001591;
    fields
    {
        field(1; "N° Véhicule"; Code[10])
        {
            /* trigger OnValidate()
             begin

                 RecVéhicule.RESET();
                 RecVéhicule.SETRANGE("N° Vehicule", "N° Véhicule");
                 IF RecVéhicule.FINDFIRST() THEN BEGIN
                     Désignation := RecVéhicule.Désignation;
                     "Immatriculation Véhicule" := RecVéhicule.Immatriculation;
                     "Type Index" := RecVéhicule."Type Index";
                     "Famille Véhicule" := RecVéhicule.Famille;
                     "Index actuelle" := RecVéhicule."Compteur Actuel";
                 END;

                 RecUserSetup.RESET();
                 IF RecUserSetup.GET(USERID) THEN BEGIN
                     Chantier := RecUserSetup."Affaire Par Defaut";
                 END;
                 "Agent de saisie" := USERID;
                 "Date de saisie" := TODAY();
             end;*/
        }
        field(2; "Réf. Pneu"; Code[100])
        {

            trigger OnValidate()
            begin
                Pne.Reset;
                Pne.SetRange("Réf. Pneu", "Réf. Pneu");
                //Pne.SETRANGE("Date d'installation", "Date d'installation");
                Pne.SetFilter("N° Véhicule", '<>%1', "N° Véhicule");
                if Pne.Find('-') then
                    Error('Pneu installer dans une autre véhicule, Vérifier la référence du pneu');
            end;
        }
        field(3; "Désignation"; Text[50])
        {
        }
        field(4; "Type Pneu"; Code[10])
        {
            TableRelation = "Type Pneu";

            trigger OnValidate()
            begin
                if TypePneu.Get("Type Pneu") then begin
                    Largeur := TypePneu.Largeur;
                    Diamétre := TypePneu.Diamétre;
                    "durée de vie" := TypePneu."durée de vie";
                end;
            end;
        }
        field(5; "Marque Pneu"; Code[10])
        {
            TableRelation = "Marque Pneu";
        }
        field(6; Largeur; Code[10])
        {
            Editable = false;
        }
        field(7; "Diamétre"; Code[10])
        {
            Editable = false;
        }
        field(8; "Date d'installation"; Date)
        {
        }
        field(9; "durée de vie"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(10; Position; Code[10])
        {
            //GL2024   TableRelation = "Position Pneu";
        }
        field(11; Parcourus; Decimal)
        {
            CalcFormula = sum("Mission Enregistré"."Km Parcourus" where("N° Véhicule" = field("N° Véhicule"),
                                                                         "Date Mission" = field("Filtre Date")));
            FieldClass = FlowField;
        }
        field(12; "Filtre Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(13; "Date D'enLevement"; Date)
        {
        }
        field(14; Enlever; Boolean)
        {
        }
        field(15; Qualité; Option)
        {
            OptionCaption = ' ,Original,Occasion,Rechapé';
            OptionMembers = " ",Original,"Occasion","Rechapé";
        }
        field(16; "Position sur le Véhicule"; Option)
        {
            OptionCaption = ' ,1ere direction coté droite,1ere direction coté gauche,2eme direction cote droite,"2eme direction cote gauche,1er pont arrière a droite,1er pont arrière a gauche,2eme pont arriere a droite,2eme pont arriere a gauche';
            OptionMembers = " ","1ere direction coté droite","1ere direction coté gauche","2eme direction cote droite","2eme direction cote gauche","1er pont arrière a droite","1er pont arrière a gauche","2eme pont arriere a droite","2eme pont arriere a gauche";
            trigger OnValidate()
            begin

                RecPneumatiqueVéhicule.RESET;
                RecPneumatiqueVéhicule.SETCURRENTKEY("N° Véhicule", "Date d'installation");
                RecPneumatiqueVéhicule.SETRANGE("N° Véhicule", "N° Véhicule");
                RecPneumatiqueVéhicule.SETRANGE("Position sur le Véhicule", "Position sur le Véhicule");
                RecPneumatiqueVéhicule.SETFILTER("Date d'installation", '<%1', "Date d'installation");
                IF RecPneumatiqueVéhicule.FINDLAST() THEN BEGIN
                    "Date derniere remplacement" := RecPneumatiqueVéhicule."Date d'installation";
                    "Index derniere remplacement" := RecPneumatiqueVéhicule."Index actuelle";
                END;

            end;
        }
        field(17; "Famille Véhicule"; code[100])
        {

        }
        field(18; "Immatriculation Véhicule"; code[20])
        {

        }
        field(19; "Index actuelle"; Integer)
        {

        }
        field(20; "Type Index"; Option)
        {
            OptionCaption = ' ,Horaire,Kilometrage';
            OptionMembers = " ",Horaire,Kilometrage;
        }
        field(21; "N° Bon Sortie"; code[20])
        {

        }
        field(22; "Chantier"; code[20])
        {

        }
        field(23; "Nature de l'opération"; Option)
        {
            OptionCaption = ' ,Sortie Magasin,Transfert';
            OptionMembers = " ","Sortie Magasin","Transfert";
        }
        field(24; "Date derniere remplacement"; date)
        {

        }
        field(25; "Index derniere remplacement"; Integer)
        {

        }
        field(26; "Agent de saisie"; code[20])
        {

        }
        field(27; "Date de saisie"; date)
        {

        }
        field(28; "Observation"; Text[250])
        {

        }
        field(29; "Validé"; Boolean)
        {

        }

    }

    keys
    {
        key(Key1; "N° Véhicule", "Réf. Pneu", "Date d'installation")
        {
            Clustered = true;
        }
        key(Key2; "N° Véhicule", "Date d'installation")
        {

        }
        key(Key3; "Date d'installation", "N° Véhicule")
        {

        }
    }

    fieldgroups
    {
    }

    var
        TypePneu: Record "Type Pneu";
        Pne: Record "Pneumatique Véhicule";
        RecVéhicule: Record Véhicule;
        RecPneumatiqueVéhicule: Record "Pneumatique Véhicule";
        RecUserSetup: Record 91;
}

