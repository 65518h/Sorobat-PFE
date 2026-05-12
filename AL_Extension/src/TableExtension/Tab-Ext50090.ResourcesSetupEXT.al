TableExtension 50090 "Resources SetupEXT" extends "Resources Setup"
{
    fields
    {
        field(8003900; "Person Nos."; Code[10])
        {
            Caption = 'Person Nos.';
            TableRelation = "No. Series";
        }
        field(8003903; "Machine Nos."; Code[10])
        {
            Caption = 'Machine Nos.';
            TableRelation = "No. Series";
        }
        field(8003905; "Structure Nos."; Code[10])
        {
            Caption = 'Structure Nos.';
            TableRelation = "No. Series";
        }
        field(8003906; "ressources Projet"; Code[10])
        {

            TableRelation = "Resource";
        }
    }
}

