table 52048996 "Ligne bon de chargement Parc"
{

    //GL2024  ID dans Nav 2009 : "39004713"
    DrillDownPageID = "Ligne Rendement Vehicule";
    LookupPageID = "Ligne Rendement Vehicule";

    fields
    {
        field(1; "N Séquence"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "N° Expédition"; Code[20])
        {
        }
        field(3; "Code Article"; Code[20])
        {
        }
        field(4; "Désignation Article"; Text[80])
        {
        }
        field(5; "Quantité"; Decimal)
        {
        }
        field(6; Conditionnement; Decimal)
        {
        }
        field(7; Poids; Decimal)
        {
        }
        field(8; "N° Lot"; Text[100])
        {
        }
        field(9; Transporteur; Code[20])
        {
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                RecLignebonchargement.SETRANGE("N° Bon Chargenemt", "N° Bon Chargenemt");
                RecLignebonchargement.MODIFYALL(Transporteur, Transporteur);
                //RecTransCamion.SETRANGE(Transporteur,Transporteur);
                IF RecTransCamion.FINDFIRST THEN BEGIN
                    RecLignebonchargement.SETRANGE("N° Bon Chargenemt", "N° Bon Chargenemt");
                    RecLignebonchargement.MODIFYALL("Code Camion", RecTransCamion.Code);
                END;
            end;
        }
        field(10; "Départ"; Code[20])
        {
            TableRelation = Territory;
        }
        field(11; "Déstination"; Code[20])
        {
            TableRelation = Territory;
        }
        field(12; Kilometrage; Decimal)
        {
        }
        field(13; "N° Bon Chargenemt"; Code[20])
        {
        }
        field(14; "Code Camion"; Code[20])
        {

            trigger OnLookup()
            begin
                //>>IBK DSFT 04 08 2010
                /*    RecTransCamion.SETRANGE(Transporteur, Transporteur);
                    IF page.RUNMODAL(page::"Transport Methods", RecTransCamion) = ACTION::LookupOK THEN
                        "Code Camion" := RecTransCamion.Code;
                    RecLignebonchargement.SETRANGE("N° Bon Chargenemt", "N° Bon Chargenemt");
                    RecLignebonchargement.MODIFYALL("Code Camion", RecTransCamion.Code);*/
                //<<IBK DSFT 04 08 2010
            end;
        }
        field(15; "Frais Transport Associé"; Code[20])
        {
        }
        field(16; "Plus Loin Distance"; Boolean)
        {
        }
        field(17; Alerte; Text[250])
        {
        }
        field(18; "Tonnage Camion"; Decimal)
        {
        }
        field(19; "Date Livraison"; Date)
        {
        }
        field(20; "N° Sequence Ecriture Article"; Integer)
        {
        }
        field(21; "Chargement enregistrer"; Boolean)
        {
        }
        field(22; "Chargement A valider"; Boolean)
        {
        }
        field(23; Encours; Boolean)
        {
        }
        field(24; "N° Seaquence Initial"; Integer)
        {
        }
        field(25; Type; Option)
        {
            OptionMembers = "Bon De Livraision","Retour Vente","Ordre De Transfert","Bon De Reception","Retour Achat";
        }
        field(26; Enlever; Boolean)
        {
        }
        field(27; "Date Chargement"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "N° Expédition", "Code Article", "N Séquence")
        {
            Clustered = true;
        }
        key(Key2; "Code Article")
        {
        }
        key(Key3; Transporteur)
        {
        }
        key(Key4; Transporteur, "Déstination")
        {
        }
        key(Key5; Kilometrage)
        {
        }
        key(Key6; "Code Camion")
        {
        }
        key(Key7; "Tonnage Camion")
        {
        }
        key(Key8; Transporteur, "N° Bon Chargenemt", "Départ", "Déstination", "Code Camion")
        {
        }
        key(Key9; Transporteur, "N° Bon Chargenemt", "Code Camion", "Frais Transport Associé")
        {
        }
        key(Key10; Transporteur, "N° Bon Chargenemt", "Déstination", "Frais Transport Associé")
        {
        }
        key(Key11; Transporteur, "N° Bon Chargenemt", "Frais Transport Associé")
        {
        }
        key(Key12; "N Séquence")
        {
        }
    }

    fieldgroups
    {
    }

    var
        RecTransCamion: Record 259;
        RecLignebonchargement: Record 52048996;
}

