TableExtension 50026 "Item Journal TemplateEXT" extends "Item Journal Template"
{
    fields
    {


        field(50000; "Inventory Resp. Ctr. Filter"; Code[10])
        {
            Caption = 'Inventory Resp. Ctr. Filter';
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = "Responsibility Center";
        }
        field(50001; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Description = 'HJ DSFT 23-03-2012';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.";
        }
        field(50002; "Affaire Obligatoire"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50003; "Materiel Obligatoire"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50004; "Feuille Affectaion Charge"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50005; "Afficher Index"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50006; "Afficher Heure"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50007; "Afficher Nom Utilisateur"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50008; "Afficher Destination"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50009; "Afficher Materiel"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50010; "Afficher Affaire"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50011; "Afficher Chauffeur"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50012; Magasin; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = Location;
        }
        field(50013; Synchronise; Boolean)
        {
        }
        field(50014; "Num Sequence Syncro"; Integer)
        {
            Description = 'HJ SORO 06-01-2015';
        }
        field(50015; "Approbateur 01"; Code[20])
        {
            Description = 'HJ SORO 06-01-2015';
            TableRelation = "User Setup";
        }
        field(50016; "Approbateur 02"; Code[20])
        {
            Description = 'HJ SORO 06-01-2015';
            TableRelation = "User Setup";
        }
        field(50017; "Approbateur 03"; Code[20])
        {
            Description = 'HJ SORO 06-01-2015';
            TableRelation = "User Setup";
        }
        field(50018; "Synchronisation Automatique"; Boolean)
        {
            Description = 'HJ SORO 06-01-2015';
            Editable = true;
        }
        field(50019; "Filtre Utilisateur"; Code[20])
        {
            Description = 'HJ SORO 09-01-2015';
            TableRelation = "User Setup";
        }
        field(50020; "Bon Sortie"; Boolean)
        {
        }
        field(50021; Consommation; Boolean)
        {
        }
        field(50022; Production; Boolean)
        {
        }
        field(50023; "Affecter Utilisateur"; Code[20])
        {
            Description = 'RB SORO 30/07/2015';
            TableRelation = "User Setup";



        }

        field(50024; "PC-PCHANTIER"; Boolean)
        {

        }
        field(50025; "Affectation Marche Obligatoire"; Boolean)
        {

        }
        field(50026; "Sous Affect Marche Obligatoire"; Boolean)
        {

        }
        field(51000; "Transfert Inter Chantier"; Boolean)
        {
            Description = 'HJ SORO 07-08-2018';
        }
        field(51001; "Inverser Signe"; Boolean)
        {
            Description = 'HJ SORO 16-08-208';
        }
    }
    keys
    {
        key(Key3; Synchronise)
        {
        }
    }
}

