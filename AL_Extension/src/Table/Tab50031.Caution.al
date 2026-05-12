Table 50031 Caution
{
    DrillDownPageID = "Liste Caution";
    LookupPageID = "Liste Caution";

    fields
    {
        field(1; "No. Caution"; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                /*
                //>>IBK DSFT 13 07 2010
                //***************Nombre de reception Réel***********
                
                RecRecpLine.SETRANGE("No.","No. Article");
                RecRecpLine.SETRANGE("Buy-from Vendor No.","No. Fournisseur");
                IF RecRecpLine.FINDFIRST THEN
                REPEAT
                  IntCompteurReception+=1;
                UNTIL RecRecpLine.NEXT=0;
                
                "Nbr.Reception Réel":=IntCompteurReception;
                //<<IBK DSFT 13 07 2010
                */

            end;
        }
        field(2; "Marché"; Text[100])
        {
            TableRelation = if ("Type Caution" = const(Provisoire)) Job
            else
            if ("Type Caution" = filter(<> Provisoire)) Customer."No." where("No." = filter('CPQ*'));
        }
        field(3; "Lot N°"; Text[30])
        {
        }
        field(4; "Type Caution"; Option)
        {
            OptionMembers = " ",Provisoire,Definitive,"Démarrage","Retenu De Garantie",Avance,"Garantie de Soumission",Solidaire,Approvisionnement;

            trigger OnValidate()
            begin
                // if "No. Caution" <> '' then Error(Text001);


                // if GeneralLedgerSetup.Get then;
                // if "Type Caution" = "type caution"::Provisoire then
                //     "No. Caution" := NoSeriesManagment.GetNextNo(GeneralLedgerSetup."N° Caution Provisoire", WorkDate, true);

                // if "Type Caution" = "type caution"::Definitive then
                //     "No. Caution" := NoSeriesManagment.GetNextNo(GeneralLedgerSetup."N° Caution Definitive", WorkDate, true);

                // if "Type Caution" = "type caution"::"Garantie de Soumission" then
                //     "No. Caution" := NoSeriesManagment.GetNextNo(GeneralLedgerSetup."N° Caution Garantie", WorkDate, true);

                // if "Type Caution" = "type caution"::Avance then
                //     "No. Caution" := NoSeriesManagment.GetNextNo(GeneralLedgerSetup."N° Caution Avance", WorkDate, true);

                // if "Type Caution" = "type caution"::Approvisionnement then
                //     "No. Caution" := NoSeriesManagment.GetNextNo(GeneralLedgerSetup."N° Caution Approvisionnement", WorkDate, true);

                // if "Type Caution" = "type caution"::Solidaire then
                //     "No. Caution" := NoSeriesManagment.GetNextNo(GeneralLedgerSetup."N° Caution Solidaire", WorkDate, true);
            end;
        }
        field(5; Banque; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(6; "Date Echeance"; Date)
        {
        }
        field(7; "Montant Caution"; Decimal)
        {
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                Encours := "Montant Caution" - "Apurement 1";
            end;
        }
        field(8; "Apurement 1"; Decimal)
        {

            trigger OnValidate()
            begin
                "Cumul Apurement" := "Apurement 1" + "Apurement 2";
                Encours := "Montant Caution" - "Cumul Apurement";
            end;
        }
        field(9; Encours; Decimal)
        {
            Editable = false;
        }
        field(10; "Condition Apurement Recpt Prov"; Text[30])
        {
        }
        field(11; "Decompte N°"; Text[30])
        {
        }
        field(12; "Cumul Apurement"; Decimal)
        {
            Editable = false;
        }
        field(13; Condition; Text[30])
        {
        }
        field(14; "Condition Apur Recpt Definitiv"; Text[30])
        {
        }
        field(15; "Apurement 2"; Decimal)
        {

            trigger OnValidate()
            begin
                "Cumul Apurement" := "Apurement 1" + "Apurement 2";
                Encours := "Montant Caution" - "Cumul Apurement";
            end;
        }
        field(16; "Date Obtention"; Date)
        {
        }
        field(17; Benificaire; Text[50])
        {
        }
        field(18; "Lien Caution Origine"; Code[20])
        {
        }
        field(19; Statut; Option)
        {
            OptionMembers = Ouvert,"Demande Effectuée",Obtenue,"Deposée","Apurée","Refusé",Echu,"Delivré",Provisoire;
        }
        field(20; "Motif Refus"; Option)
        {
            OptionMembers = " ","Limite Depassée",Administratif,Autre;
        }
        field(21; Pays; Code[20])
        {
        }
        field(22; "Date Depart"; Date)
        {
        }
        field(23; "Date Demande"; Date)
        {
        }
        field(24; "N° Caution Chez Banque"; Code[20])
        {
        }
        field(25; "Date Main Levée"; Date)
        {
        }
        field(26; "Date Depot Main Levée"; Date)
        {
        }
        field(27; "Montant Main Levée"; Decimal)
        {
        }
        field(28; "Montant Ouvert"; Decimal)
        {
            Editable = true;
        }
        field(29; Fournisseur; Code[20])
        {
            TableRelation = Vendor;
        }
        field(30; "Nom Fournisseur"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field(Fournisseur)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; Garant; Text[100])
        {
        }
        field(32; Compteur; Integer)
        {
            AutoIncrement = true;
        }
        field(33; "Date signature"; Date)
        {
        }
        field(34; Observation; Text[250])
        {
        }
    }

    keys
    {
        key(STG_Key1; Compteur)
        {
            Clustered = true;
        }
        key(STG_Key2; "Marché", "Type Caution")
        {
        }
        key(STG_Key3; "Type Caution")
        {
        }
        key(STG_Key4; Banque, "Type Caution")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        NoSeriesManagment: Codeunit 396;
        Text001: label 'Modification Interdite Car Numero Caution Est Lié Au Type de Caution';
}

