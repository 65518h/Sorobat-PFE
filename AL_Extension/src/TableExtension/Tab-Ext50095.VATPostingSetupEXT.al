TableExtension 50095 "VAT Posting SetupEXT" extends "VAT Posting Setup"
{
    Caption = 'Paramètres compta. TVA';
    fields
    {
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Groupe compta. marché TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'Groupe compta. produit TVA';
        }
        modify("VAT Calculation Type")
        {
            Caption = 'Mode calcul TVA';
            OptionCaption = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("VAT %")
        {
            Caption = '% TVA';
        }
        modify("Unrealized VAT Type")
        {
            Caption = 'Type TVA sur encaissement';
            OptionCaption = ' ,Pourcentage,Premier,Dernier,Premier (payé entièrement),Dernier (payé entièrement)';
        }
        modify("Adjust for Payment Discount")
        {
            Caption = 'Ajuster pour escompte';
        }
        modify("Sales VAT Account")
        {
            Caption = 'Compte TVA vente';
        }
        modify("Sales VAT Unreal. Account")
        {
            Caption = 'Cpte TVA/encaissement vente';
        }
        modify("Purchase VAT Account")
        {
            Caption = 'Compte TVA achat';
        }
        modify("Purch. VAT Unreal. Account")
        {
            Caption = 'Cpte TVA/décaissement achat';
        }
        modify("Reverse Chrg. VAT Acc.")
        {
            Caption = 'Compte TVA due intracomm.';
        }
        modify("Reverse Chrg. VAT Unreal. Acc.")
        {
            Caption = 'Cpte TVA due intra./décaisst';
        }
        modify("VAT Identifier")
        {
            Caption = 'Identifiant TVA';
        }

        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
    }
    keys
    {
        key(Key3; Synchronise)
        {
        }
    }


}

