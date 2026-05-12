TableExtension 50089 "Inventory SetupEXT" extends "Inventory Setup"
{
    fields
    {

        field(50000; "Model Journal"; Code[20])
        {
            Description = 'HJ DSFT 27-03-2012';
            TableRelation = "Gen. Journal Template";
        }
        field(50001; "Nom Model De Feuille"; Code[20])
        {
            Description = 'HJ DSFT 27-03-2012';
        }
        field(50002; "Article Gasoil"; Code[20])
        {
            Description = 'HJ DSFT 30-04-2012';
            TableRelation = Item;
        }
        field(50003; "Model Feuille Article"; Code[20])
        {
            Description = 'HJ DSFT 30-04-2012';
            TableRelation = "Item Journal Template";
        }
        field(50004; "Nom Model Par Defaut"; Code[20])
        {
            Description = 'HJ DSFT 30-04-2012';
        }
        field(50005; "Fiche Gasoil Nos."; Code[10])
        {
            Caption = 'Fiche Gasoil Nos.';
            Description = 'HJ DSFT 30-04-2012';
            TableRelation = "No. Series";
        }




        field(50006; "Magasin Chantier 01"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HJ SORO 13-01-2015';
            TableRelation = Location;
        }
        field(50007; "Magasin Chantier 02"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HJ SORO 13-01-2015';
            TableRelation = Location;
        }
        field(50008; "Nom Fichier Synchro"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HJ SORO 13-01-2015';
        }
        field(50009; "Inventory Consumption Delay"; DateFormula)
        {
            caption = 'Inventory Consumption Delay';
        }
        field(50999; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(51000; "Magasin de transfert"; Code[20])
        {
            TableRelation = Location;
        }
    }
}

