report 50049 "Mise a Jour Grp Compta Stock"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/MiseaJourGrpComptaStock.rdlc';

    dataset
    {
        dataitem("Inventory Posting Group"; 94)
        {
            trigger OnAfterGetRecord()
            begin
                IF location.FINDFIRST THEN
                    REPEAT
                        Inventorypostingsetup."Location Code" := location.Code;
                        Inventorypostingsetup."Invt. Posting Group Code" := "Inventory Posting Group".Code;
                        Inventorypostingsetup."Inventory Account" := '31100013';
                        Inventorypostingsetup."Inventory Account (Interim)" := '31100013';
                        Inventorypostingsetup."WIP Account" := '31100013';
                        Inventorypostingsetup."Material Variance Account" := '31100013';
                        Inventorypostingsetup."Capacity Variance Account" := '31100013';
                        Inventorypostingsetup."Mfg. Overhead Variance Account" := '31100013';
                        Inventorypostingsetup."Cap. Overhead Variance Account" := '31100013';
                        Inventorypostingsetup."Subcontracted Variance Account" := '31100013';
                        IF Inventorypostingsetup.INSERT THEN;
                    UNTIL location.NEXT = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Inventorypostingsetup: Record 5813;
        location: Record 14;
}

