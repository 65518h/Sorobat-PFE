Table 8001409 "Sage Interface Setup"
{
    // //+REF+INTERFACE GESWAY 20/03/00 Nouvelle table de paramètres
    //                         05/06/06 Ajout Longueur N° compte général


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Global Dim 1 Starting Position"; Integer)
        {
            Caption = 'Global Dimension 1 Starting Position';
            Description = 'Paie 500 : code analytique';
        }
        field(11; "Global Dimension 1 Code Length"; Integer)
        {
            Caption = 'Global Dimension 1 Code Length';
            Description = 'Paie 500 : code analytique';
        }
        field(12; "Global Dim 2 Starting Position"; Integer)
        {
            Caption = 'Global Dimension 2 Starting Position';
            Description = 'Paie 500 : code analytique';
        }
        field(13; "Global Dimension 2 Code Length"; Integer)
        {
            Caption = 'Global Dimension 2 Code Length';
            Description = 'Paie 500 : code analytique';
        }
        field(14; "Job No. Starting Position"; Integer)
        {
            Caption = 'Job No. Starting Position';
            Description = 'Paie 500 : code analytique';
        }
        field(15; "Job No. Length"; Integer)
        {
            Caption = 'Job No. Length';
            Description = 'Paie 500 : code analytique';
        }
        field(16; "G/L Account No. Length"; Integer)
        {
            Caption = 'G/L Account No. Length';
            MaxValue = 13;
            MinValue = 0;
        }
        field(21; "Pay Journal Code"; Code[10])
        {
            Caption = 'Pay Journal Code';
            Description = 'Paie 500';
            TableRelation = "Source Code";
        }
        field(22; "Pay Journal Template Name"; Code[10])
        {
            Caption = 'Pay Journal Template Name';
            Description = 'Paie 500';
            TableRelation = if ("Pay Journal Code" = filter(<> '')) "Gen. Journal Template".Name where("Source Code" = field("Pay Journal Code"))
            else
            if ("Pay Journal Code" = filter('')) "Gen. Journal Template".Name;

            trigger OnValidate()
            begin
                if ModeleFeuille.Get("Pay Journal Template Name") then
                    "Pay Journal Code" := ModeleFeuille."Source Code";
            end;
        }
        field(23; "Pay Journal Name"; Code[10])
        {
            Caption = 'Pay Journal Name';
            Description = 'Paie 500';
            TableRelation = if ("Pay Journal Template Name" = filter(<> '')) "Gen. Journal Batch".Name where("Journal Template Name" = field("Pay Journal Template Name"))
            else
            if ("Pay Journal Template Name" = filter('')) "Gen. Journal Batch".Name;
        }
    }

    keys
    {
        key(STG_Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ModeleFeuille: Record "Gen. Journal Template";
        NomFeuille: Record "Gen. Journal Batch";
}

