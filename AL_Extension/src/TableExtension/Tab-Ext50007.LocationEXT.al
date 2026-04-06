TableExtension 50007 LocationEXT extends Location
{
    fields
    {
        field(50000; "Inventory Resp. Ctr. Filter"; Code[10])
        {
            Caption = 'Inventory Resp. Ctr. Filter';
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = "Responsibility Center";
        }
        field(50001; "Article Associé"; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = Item;
        }
        field(50030; "Project Location"; Boolean)
        {
            Caption = 'Project Location';
            DataClassification = ToBeClassified;
        }
        field(50002; "Stock Physique"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Article Associé"),
                                                                  "Location Code" = field(Code)));
            Description = 'HJ DSFT 23-03-2012';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; Synchronise; Boolean)
        {
        }
        field(50004; "Num Sequence Syncro"; Integer)
        {
            Description = 'HJ SORO 03-02-2015';

        }
        field(50005; Affaire; code[20])
        {
            TableRelation = Job;
            Description = 'RB SORO 20/04/2015';
        }

        field(50006; "Bon de sortie Nos."; code[20])
        {
            Caption = 'Bon de sortie Nos.';
            TableRelation = "No. Series";
        }
        field(50007; "Magasin Centrale"; Boolean)
        {
            Description = 'RB SORO 20/04/2015';
        }
        field(50008; "No. Series Gasoil"; code[20])
        {
            TableRelation = "No. Series";
            Caption = 'N° de Souche  Gasoil';

        }
        field(50009; "Bon d entree Nos."; code[20])
        {
            Caption = 'Bon d''entrée Nos.';
            TableRelation = "No. Series";
        }
        field(8001400; "Tracking Not Required"; Boolean)
        {
            Caption = 'Tracking Not Required';
        }
        field(8003900; "Bal. Job No."; Code[20])
        {
            Caption = 'N° affaire contrepartie';
            TableRelation = Job;
        }

    }
    keys
    {

        //  GL2024
        /*  key(STG_Key4; "Bal. Job No.", "Code")
           {
           }*/
        key(STG_Key5; Synchronise)
        {
        }
    }
}

