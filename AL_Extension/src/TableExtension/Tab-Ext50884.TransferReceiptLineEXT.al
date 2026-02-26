TableExtension 50884 "Transfer Receipt LineEXT" extends "Transfer Receipt Line"
{
    fields
    {


        field(50003; "N° Materiel"; Code[20])
        {
            Description = 'RB SORO 10/06/2015';
            TableRelation = Véhicule;
        }
        field(50004; Chantier; Code[20])
        {
            Description = 'HJ SORO 13-06-2015';
        }
        field(51000; "Description Soroubat"; text[100])
        {

        }
        field(51001; "N° vehicule"; Code[20])
        {
            TableRelation = Véhicule;

        }
    }
}

