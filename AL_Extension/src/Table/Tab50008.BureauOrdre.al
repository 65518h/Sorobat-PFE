Table 50008 "Bureau Ordre"
{
    DrillDownPageID = "Bureau Ordre Lister";
    LookupPageID = "Bureau Ordre Lister";

    fields
    {
        field(1; "Document N°"; Code[20])
        {
        }
        field(2; ImageP1; Blob)
        {
        }
        field(3; "Date Reception"; Date)
        {
            Editable = false;
        }
        field(4; "Receptionné Par"; Code[20])
        {
            Editable = false;
        }
        field(5; "Receptionné Le"; datetime)
        {
            Editable = false;
        }
        field(6; "Categorie Document"; Option)
        {
            OptionMembers = " ","Facture Achat",Fax,"Courrier Bancaire",Decompte,Autre;
        }
        field(7; "Page N°"; Integer)
        {
        }
        field(8; ImageP2; Blob)
        {
        }
        field(9; ImageP3; Blob)
        {
        }
        field(10; ImageP4; Blob)
        {
        }
        field(11; ImageP5; Blob)
        {
        }
        field(12; ImageP6; Blob)
        {
        }
        field(13; ImageP7; Blob)
        {
        }
        field(14; ImageP8; Blob)
        {
        }
        field(15; ImageP9; Blob)
        {
        }
        field(16; ImageP10; Blob)
        {
        }
        field(17; ImageP11; Blob)
        {
        }
        field(18; ImageP12; Blob)
        {
        }
        field(19; Remarque; Text[250])
        {
        }
        field(20; "Nombre de Page"; Integer)
        {
        }
        field(21; Urgence; Option)
        {
            OptionMembers = Normal,Urgent,"Trés Urgent";
        }
        field(22; "Type Tiers"; Option)
        {
            OptionMembers = " ",Banque,Fournisseurs,Client,Autre;

            trigger OnValidate()
            begin
                Tiers := '';
                "Nom Tiers" := '';
            end;
        }
        field(23; Tiers; Code[20])
        {
            TableRelation = if ("Type Tiers" = const(Banque)) "Bank Account"."No."
            else
            if ("Type Tiers" = const(Fournisseurs)) Vendor."No."
            else
            if ("Type Tiers" = const(Client)) Customer."No.";

            trigger OnValidate()
            begin
                if "Type Tiers" = "type tiers"::Banque then if RecBankAccount.Get(Tiers) then "Nom Tiers" := RecBankAccount.Name;
                if "Type Tiers" = "type tiers"::Fournisseurs then if RecVendor.Get(Tiers) then "Nom Tiers" := RecVendor.Description;
                if "Type Tiers" = "type tiers"::Client then if RecCustomer.Get(Tiers) then "Nom Tiers" := RecCustomer.Name;
            end;
        }
        field(24; "Nom Tiers"; Text[50])
        {
            Editable = false;
        }
        field(25; Objet; Text[250])
        {
        }
        field(26; "Livré Par"; Text[250])
        {
        }
        field(27; "Envoyé à Service"; Option)
        {
            OptionMembers = " ","Direction Comptable","Direction Achat","Direction Administratif","Direction RH","Direction Parc Auto"," Direction Magasin","Direction Fianciére","Direction General";
        }
        field(28; "Envoyé à Personne"; Code[20])
        {
        }
        field(29; "Clôturer"; Boolean)
        {
            Editable = false;
        }
        field(30; ImageP13; Blob)
        {
        }
        field(31; ImageP14; Blob)
        {
        }
        field(32; ImageP15; Blob)
        {
        }
        field(33; ImageP16; Blob)
        {
        }
        field(34; ImageP17; Blob)
        {
        }
        field(35; ImageP18; Blob)
        {
        }
        field(36; ImageP19; Blob)
        {
        }
        field(37; ImageP20; Blob)
        {
        }
        field(38; "Reference Document Externe"; Code[20])
        {
        }
        field(39; "Instruction Par"; Option)
        {
            OptionMembers = " ","Directeur Génèral","Directeur Administratif","Direction Financier","Directeur Audit","Direction Appro","Direction Achat";
        }
        field(50000; "Journée"; Date)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Document N°")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        IF Clôturer THEN ERROR(Text001);
        BureauOrdreDiffusion.SETRANGE("Document N°", "Document N°");
        BureauOrdreDiffusion.DELETEALL;
    end;

    trigger OnInsert()
    begin
        RecGeneralLedgerSetup.Get;
        if "Document N°" = '' then begin
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, RecGeneralLedgerSetup."Souche Bureau Ordre"
            , Today, "Document N°", RecGeneralLedgerSetup."Souche Bureau Ordre");
        end;

        "Receptionné Par" := UserId;
        "Receptionné Le" := CURRENTDATETIME;
        Journée := Today;
        if RecUserSetup.FindFirst then
            repeat
                RecBureauOrdreEnvoyéa."No. Document" := "Document N°";
                RecBureauOrdreEnvoyéa.Utilisateur := RecUserSetup."User ID";
                RecBureauOrdreEnvoyéa.Service := RecUserSetup.Service;
                if RecBureauOrdreEnvoyéa.Insert then;
            until RecUserSetup.Next = 0;
    end;

    var
        RecCustomer: Record Customer;
        RecVendor: Record Item;
        RecBankAccount: Record "Bank Account";
        RecGeneralLedgerSetup: Record "General Ledger Setup";
        "RecBureauOrdreEnvoyéa": Record "Bureau Ordre Envoyé a";
        RecUserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit 396;
        BureauOrdreDiffusion: Record 50009;
        Text001: label 'Dossier Cloturer';

    local procedure GetNoSeriesCode(): Code[10]
    begin
        exit(RecGeneralLedgerSetup."Souche Bureau Ordre");
    end;

    local procedure TestNoSeries(): Boolean
    begin
        RecGeneralLedgerSetup.TestField("Souche Bureau Ordre");
    end;
}

