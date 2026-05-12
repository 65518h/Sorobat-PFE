Table 8001408 "Add-On Licence"
{
    // //+BGW+PKI GESWAY 01/11/99 Add-On Licence
    //                     24/03/04 Supp. variable report8001300 inutilisée et dépendante de StatsExplorer

    Caption = 'Add-On Licence';
    DataPerCompany = false;

    fields
    {
        field(1; "Granule ID"; Code[20])
        {
            Caption = 'Granule ID';
        }
        field(2; "Licence ID"; Code[30])
        {
            Caption = 'Licence ID';
        }
        field(10; "Granule Key"; Code[20])
        {
            Caption = 'Granule KEY';
        }
    }

    keys
    {
        key(STG_Key1; "Granule ID", "Licence ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

