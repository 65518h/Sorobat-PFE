TableExtension 50882 "Transfer Shipment LineEXT" extends "Transfer Shipment Line"
{
    fields
    {


        field(50003; "N° Materiel"; Code[20])
        {
            Description = 'RB SORO 10/06/2015';
            TableRelation = Véhicule;
        }
        field(50004; Affaire; Code[20])
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

