TableExtension 50170 "Value EntryEXT" extends "Value Entry"
{
    fields
    {


        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }

        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        modify("Job Task No.")
        {
            Caption = 'Job Task No.';
        }
        field(50001; "Centre de Gestion"; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50002; "N° Dossier"; Code[20])
        {
        }
        field(50003; "Currency Code"; Code[20])
        {
            Caption = 'Code devise';
        }
        field(50004; Famille; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50011; "Type Frais"; Option)
        {
            OptionCaption = ' ,Frais Financiers,Assurances,Magasinage,Transit,Douane,Frais d''emballage / mise à FOB,Frèt,Frais D''acconage,Dif. Change,Transport,Frais Bancaires,Etat et taxes,Autres Frais';
            OptionMembers = " ","Frais Financiers",Assurances,Magasinage,Transit,Douane,"Frais d'emballage / mise à FOB","Frèt","Frais D'acconage","Dif. Change",Transport,"Frais Bancaires","Etat et taxes","Autres Frais";
        }
        field(50020; "N° Réception"; Code[20])
        {
        }
        field(50021; "N° Ligne Réception"; Integer)
        {
        }
        field(50099; origine; Code[20])
        {
            CalcFormula = lookup("Item Ledger Entry"."Source No." where("Entry No." = field("Item Ledger Entry No.")));
            FieldClass = FlowField;
        }
        field(51000; "Description Soroubat"; Text[100])
        {
            Caption = 'Description Soroubat';
        }
        field(51001; "External Document No. Soroubat"; Code[200])
        {
            Caption = 'External Document No. Soroubat';
        }
        field(8001400; "Financial Document"; Boolean)
        {
            Caption = 'Financial Document';
        }
        field(8003900; "Job Quantity"; Decimal)
        {
            Caption = 'Job quantity';
            DecimalPlaces = 0 : 5;
        }
        field(8003901; "Job Cost"; Decimal)
        {
            Caption = 'Job Cost';
        }
    }
    keys
    {

        key(Key20; "Item Ledger Entry Type", "Item No.", "Source Type", "Source No.", "Location Code", "Inventory Posting Group", "Source Posting Group", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "Salespers./Purch. Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Reason Code", "Posting Date")
        {
        }

        /*GL2024    key(Key21;"N° Dossier","Document No.","Item Charge No.","Valued Quantity")
            {
            SumIndexFields = "Cost Amount (Actual)";
            }

            key(Key22;"Source Type","Type Frais","Invoiced Quantity","N° Dossier","Valued Quantity")
            {
            SumIndexFields = "Cost Amount (Actual)";
            }*/

        key(Key23; "Item No.", "Item Ledger Entry No.", "Item Charge No.", "Expected Cost", "Entry No.")
        {
            SumIndexFields = "Cost Amount (Actual)";
        }

        key(Key24; "Cost per Unit")
        {
        }

        key(Key25; "Document No.", "Document Type", "Document Line No.")
        {
        }

        key(Key26; "Item No.", "Source No.", "Item Ledger Entry Type", "Location Code")
        {
        }

        key(Key27; "Item No.", "Item Ledger Entry Type", "Cost per Unit")
        {
        }
    }
}

