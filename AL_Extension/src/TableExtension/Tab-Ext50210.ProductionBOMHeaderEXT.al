TableExtension 50210 "Production BOM HeaderEXT" extends "Production BOM Header"
{
    fields
    {


        field(50000; Centrale; Code[20])
        {
            Description = 'HJ SORO 20-08-2015';
            TableRelation = Location;
        }
        field(50001; "Article Lié"; Code[20])
        {
            Description = 'HJ SORO 20-08-2015';
            TableRelation = Item where("Production BOM No." = filter(<> ''));
        }
        field(50002; "Type Production"; Option)
        {
            OptionMembers = " ",Beton,"Enrobé",Prefa;
        }
        field(50003; Stockable; Boolean)
        {
            Description = 'HJ SORO 23-11-2016';
        }
    }
    keys
    {


        key(STG_Key5; "Article Lié")
        {
        }
    }



}

