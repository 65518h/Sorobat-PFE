TableExtension 50171 "Item Charge Assignment (Pu)EXT" extends "Item Charge Assignment (Purch)"
{

    LookuppageID = "Affectation Frais Annexes";
    DrillDownpageID = "Affectation Frais Annexes";
    fields
    {
        field(50002; "N° Dossier"; Code[20])
        {
        }
        field(50010; "Montant associé"; Decimal)
        {
            AutoFormatType = 2;
        }
        field(50011; "Type Frais"; Option)
        {
            OptionCaption = ' ,Frais Financiers,Assurances,Magasinage,Transit,Douane,Frais d''emballage / mise à FOB,Frèt,Frais D''acconage,Dif. Change,Transport,Frais Bancaires,Etat et taxes,Autres Frais';
            OptionMembers = " ","Frais Financiers",Assurances,Magasinage,Transit,Douane,"Frais d'emballage / mise à FOB","Frèt","Frais D'acconage","Dif. Change",Transport,"Frais Bancaires","Etat et taxes","Autres Frais";
        }
        field(50020; "Code devise"; Code[10])
        {
        }
        field(50021; "Facteur Devise"; Decimal)
        {
            DecimalPlaces = 0 : 15;
        }
        field(50022; "Montant associé DS"; Decimal)
        {
            AutoFormatType = 2;
        }
        field(50030; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(50031; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else
            if ("Source Type" = const(Vendor)) Vendor
            else
            if ("Source Type" = const(Item)) Item;
        }
    }
    keys
    {
        key(Key4; "Source Type", "Type Frais", "N° Dossier")
        {
            SumIndexFields = "Montant associé DS", "Montant associé";
        }

        /* GL2024   key(Key5;"Source No.","Source Type","Type Frais","N° Dossier","Item Charge No.")
            {
            }

            key(Key6;"Item Charge No.","N° Dossier")
            {
            }

            key(Key7;"Document Type","Document No.","Document Line No.","N° Dossier","Item Charge No.")
            {
            SumIndexFields = "Montant associé DS";
            }*/
    }
}

