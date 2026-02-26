table 50039 Agence
{
    // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs

    LookupPageID = "Sites";

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Code Magasin"; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(4; "Code Client Début"; Code[10])
        {
        }
        field(5; "Code Client Fin"; Code[10])
        {
        }
        field(6; "Code client Bts Début"; Code[10])
        {
        }
        field(7; "Code client Bts Fin"; Code[10])
        {
        }
        field(8; "Code usr Début"; Code[10])
        {
        }
        field(9; "Code usr Fin"; Code[10])
        {
        }
        field(10; Actif; Boolean)
        {
        }
        field(11; "Code Client Immo"; Code[10])
        {
            TableRelation = Customer;
        }
        field(50001; "Quote Nos."; Code[10])
        {
            Caption = 'Quote Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Vente';
            TableRelation = "No. Series";
        }
        field(50002; "Order Nos."; Code[10])
        {
            Caption = 'Order Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Vente';
            TableRelation = "No. Series";
        }
        field(50003; "Invoice Nos."; Code[10])
        {
            Caption = 'Invoice Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Vente';
            TableRelation = "No. Series";
        }
        field(50004; "Posted Invoice Nos."; Code[10])
        {
            Caption = 'Posted Invoice Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Vente';
            TableRelation = "No. Series";
        }
        field(50005; "Credit Memo Nos."; Code[10])
        {
            Caption = 'Credit Memo Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Vente';
            TableRelation = "No. Series";
        }
        field(50006; "Posted Credit Memo Nos."; Code[10])
        {
            Caption = 'Posted Credit Memo Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Vente';
            TableRelation = "No. Series";
        }
        field(50007; "Posted Shipment Nos."; Code[10])
        {
            Caption = 'Posted Shipment Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Vente';
            TableRelation = "No. Series";
        }
        field(50008; "Blanket Order Nos."; Code[10])
        {
            Caption = 'Blanket Order Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Vente';
            TableRelation = "No. Series";
        }
        field(50009; "Return Order Nos."; Code[10])
        {
            Caption = 'Return Order Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Vente';
            TableRelation = "No. Series";
        }
        field(50010; "Posted Return Receipt Nos."; Code[10])
        {
            Caption = 'Posted Return Receipt Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Vente';
            TableRelation = "No. Series";
        }
        field(50011; "A Quote Nos."; Code[10])
        {
            Caption = 'Quote Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Achat';
            TableRelation = "No. Series";
        }
        field(50012; "A Order Nos."; Code[10])
        {
            Caption = 'Order Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Achat';
            TableRelation = "No. Series";
        }
        field(50013; "A Invoice Nos."; Code[10])
        {
            Caption = 'Invoice Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Achat';
            TableRelation = "No. Series";
        }
        field(50014; "A Posted Invoice Nos."; Code[10])
        {
            Caption = 'Posted Invoice Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Achat';
            TableRelation = "No. Series";
        }
        field(50015; "A Credit Memo Nos."; Code[10])
        {
            Caption = 'Credit Memo Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Achat';
            TableRelation = "No. Series";
        }
        field(50016; "A Posted Credit Memo Nos."; Code[10])
        {
            Caption = 'Posted Credit Memo Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Achat';
            TableRelation = "No. Series";
        }
        field(50017; "A Posted Receipt Nos."; Code[10])
        {
            Caption = 'Posted Receipt Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Achat';
            TableRelation = "No. Series";
        }
        field(50018; "A Blanket Order Nos."; Code[10])
        {
            Caption = 'Blanket Order Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Achat';
            TableRelation = "No. Series";
        }
        field(50019; "A Posted Return Shpt. Nos."; Code[10])
        {
            Caption = 'Posted Return Shpt. Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Achat';
            TableRelation = "No. Series";
        }
        field(50020; "A Return Order Nos."; Code[10])
        {
            Caption = 'Return Order Nos.';
            Description = 'HJ 28 12 2009 Redirection Souche Achat';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

