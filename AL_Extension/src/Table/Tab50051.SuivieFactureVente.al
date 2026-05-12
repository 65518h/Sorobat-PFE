Table 50051 "Suivie Facture Vente"
{
    // DrillDownPageID = Emplacement;
    //LookupPageID = Emplacement;

    fields
    {
        field(1; "Séquence"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "N° Décompte"; Text[40])
        {
            Caption = 'N° Décompte';
        }
        field(3; "Code Client"; Code[10])
        {
            Caption = 'Code Client';
            TableRelation = Customer;
        }
        field(4; "N° Bailleurs De Fonds"; Code[20])
        {
            Caption = 'N° Bailleurs De Fonds';
            TableRelation = Customer;
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Facture Vente,Encaissement,Avenant,MarchéInitial';
            OptionMembers = "Facture Vente",Encaissement,Avenant,"MarchéInitial";
        }
        field(6; Designation; Text[80])
        {
            Caption = 'Designation';
        }
        field(7; "Montant Debit"; Decimal)
        {

            trigger OnValidate()
            begin
                "Montant credit" := 0;
                UpdateCout(0);
            end;
        }
        field(8; "Montant credit"; Decimal)
        {

            trigger OnValidate()
            begin
                "Montant Debit" := 0;
                UpdateCout(1);
            end;
        }
        field(9; "Code devise"; Code[10])
        {
            Caption = 'Code devise';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "Montant Debit" <> 0 then UpdateCout(0) else UpdateCout(1);
            end;
        }
        field(10; Montant; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(11; "Montant Ds"; Decimal)
        {
            Caption = 'Montant Ds';
            Editable = false;
        }
        field(12; "Facteur devise"; Decimal)
        {
            Caption = 'Facteur devise';
        }
        field(13; "Montant TVA DS"; Decimal)
        {
            Caption = 'Montant TVA DS';

            trigger OnLookup()
            begin
                "Montant TVA DS" := "Montant Debit" * 0.18;
            end;

            trigger OnValidate()
            begin
                //  "Montant TVA DS":="Montant Ds"*0.18;
            end;
        }
        field(14; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'Modification TableRelation';
            TableRelation = Job;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                lContributor: Record "Sales Contributor";
                lContributor2: Record "Sales Contributor";
                //  lJobStatusMgt: Codeunit "Job Status Management";
                lJobStatus: Record "Job Status";
                lTempDocDim: Record "Gen. Jnl. Dim. Filter" temporary;
            begin
            end;
        }
        field(15; "Date Facture"; Date)
        {
            Caption = 'Date Facture';

            trigger OnValidate()
            begin
                if ("Date Echéance" = 0D) and ("Date Facture" <> 0D) then "Date Echéance" := CalcDate('45J', "Date Facture");
                if ("Date Echéance" <> 0D) and ("Date Facture" <> 0D) then "Nbr De Jours Retard" := "Work Date (Date Paiement)" - "Date Echéance";
            end;
        }
        field(16; "Date Echéance"; Date)
        {
            Caption = 'Date Echéance';

            trigger OnValidate()
            begin
                if "Date Echéance" <> 0D then "Nbr De Jours Retard" := "Work Date (Date Paiement)" - "Date Echéance";
            end;
        }
        field(17; "Work Date (Date Paiement)"; Date)
        {
            Caption = 'Work Date (Date Paiement)';

            trigger OnValidate()
            begin
                if "Date Echéance" <> 0D then "Nbr De Jours Retard" := "Work Date (Date Paiement)" - "Date Echéance";
            end;
        }
        field(18; "Nbr De Jours Retard"; Integer)
        {
            Caption = 'Nbr De Jours Retard';
            Editable = false;
        }
        field(19; "Taux Intéret Amoratoire"; Decimal)
        {
            Caption = 'Taux Intéret Amoratoire';

            trigger OnValidate()
            begin
                //"Taux Intéret Amoratoire":=5;
                "Interet Calculé" := Montant * "Nbr De Jours Retard" * "Taux Intéret Amoratoire" / 36500;
                "Interet Calculé Ds" := "Montant Ds" * "Nbr De Jours Retard" * "Taux Intéret Amoratoire" / 36500;
            end;
        }
        field(20; "Interet Calculé"; Decimal)
        {
            Caption = 'Interet Calculé';
        }
        field(21; "Interet Calculé Ds"; Decimal)
        {
        }
        field(22; "Facteur Devises"; Decimal)
        {
        }
        field(25; "Montant Payé"; Decimal)
        {
        }
        field(26; "Reste A Payé"; Decimal)
        {

            trigger OnLookup()
            begin
                "Reste A Payé" := "Montant Ds" - "Montant Payé";
            end;

            trigger OnValidate()
            begin
                //"Reste A Payé":="Montant Ds"-"Montant Payé";
            end;
        }
    }

    keys
    {
        key(STG_Key1; "Séquence")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecCurrency: Record Currency;
        RecCurrencyExchangeRate: Record "Currency Exchange Rate";
        DecAmountDevise: Decimal;
        DecAmountDs: Decimal;


    procedure UpdateCout(ParaSens: Integer)
    begin
        // >> HJ DSFT 06-03-2013
        if ParaSens = 1 then begin
            "Montant Ds" := -"Montant credit";
            Montant := -"Montant credit";
            if RecCurrency.Get("Code devise") then begin
                "Montant credit" := ROUND("Montant credit", RecCurrency."Amount Rounding Precision");
                "Facteur devise" := RecCurrencyExchangeRate.ExchangeRate(Today, "Code devise");
                "Montant Ds" := RecCurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Code devise", "Montant credit", "Facteur devise");
            end;
        end;
        if ParaSens = 0 then begin
            "Montant Ds" := "Montant Debit";
            Montant := "Montant Debit";
            if RecCurrency.Get("Code devise") then begin
                "Montant Debit" := ROUND("Montant Debit", RecCurrency."Amount Rounding Precision");
                "Facteur devise" := RecCurrencyExchangeRate.ExchangeRate(Today, "Code devise");
                "Montant Ds" := RecCurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Code devise", "Montant Debit", "Facteur devise");
            end;
        end;
        if "Work Date (Date Paiement)" = 0D then "Work Date (Date Paiement)" := Today;
        if "Date Echéance" <> 0D then "Nbr De Jours Retard" := "Work Date (Date Paiement)" - "Date Echéance";
        "Montant TVA DS" := "Montant Ds" * 0.18;
        "Reste A Payé" := "Montant Ds" - "Montant Payé";
    end;
}

