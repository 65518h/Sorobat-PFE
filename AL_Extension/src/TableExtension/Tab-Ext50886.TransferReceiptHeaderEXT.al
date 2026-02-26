TableExtension 50886 "Transfer Receipt HeaderEXT" extends "Transfer Receipt Header"
{
    fields
    {
        field(50000; Observation; Text[100])
        {
            Description = 'RB SORO 30/05/2015';
        }
        field(50001; "N° Materiel"; Code[20])
        {
            Description = 'RB SORO 30/05/2015';
            TableRelation = Véhicule;
        }
        field(50002; Materiel; Code[20])
        {
            Description = 'RB SORO 30/05/2015';
            TableRelation = Resource where(Type = const(Machine));
        }
        field(50003; Receptioneur; Text[30])
        {
            Description = 'RB SORO 30/05/2015';
        }
        field(50004; "Id Expediteur"; Code[20])
        {
            Description = 'RB SORO 30/05/2015';
        }
        field(50005; "Id Receptioneur"; Code[20])
        {
            Description = 'RB SORO 30/05/2015';
        }
        field(50006; "Date Saisie"; Date)
        {
            Description = 'RB SORO 30/05/2015';
        }
        field(50007; "Chantier Origine"; Code[20])
        {
            Description = 'HJ SORO 13-06-2015';
            TableRelation = Job;
        }
        field(50008; "Chantier Destination"; Code[20])
        {
            Description = 'HJ SORO 13-06-2015';
            TableRelation = Job;
        }
    }
}

