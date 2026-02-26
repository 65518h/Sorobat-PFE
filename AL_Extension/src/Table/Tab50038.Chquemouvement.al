Table 50038 "Chèque mouvementé"
{
    //  //>>>MBK:05/02/2010: Référence chèque


    fields
    {
        field(2; "N° ligne"; Integer)
        {
        }
        field(3; "Code banque"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(4; "Référence chèque"; Code[20])
        {
        }
        field(5; "N°Chèque"; Integer)
        {
        }
        field(9; Statut; Option)
        {
            OptionMembers = " ",Bloquer,Encours,Confirmer,"Comptabilisé","Annulé";
        }
        field(10; "N° Bordereu"; Code[20])
        {
        }
        field(11; "N° Ligne Bordereu"; Integer)
        {
        }
        field(12; "Statut Bordereau"; Text[50])
        {
            //GL2024 CalcFormula = lookup("Payment Header"."Status Name" where("No." = field("N° Bordereu")));
            // FieldClass = FlowField;
        }
        field(13; "N° Statut"; Integer)
        {
            CalcFormula = lookup("Payment Header"."Status No." where("No." = field("N° Bordereu")));
            FieldClass = FlowField;
        }
        field(14; "Statut Modifiable"; Boolean)
        {
            CalcFormula = exist("Payment Header" where("No." = field("N° Bordereu"),
                                                        "Status No." = const(0)));
            FieldClass = FlowField;
        }
        field(15; "N° Fournisseur"; Code[20])
        {
            CalcFormula = lookup("Payment Line"."Account No." where("No." = field("N° Bordereu"),
                                                                     "N° chèque" = field("N°Chèque")));
            Description = 'IBK DSFT 13 12 2010';
            FieldClass = FlowField;
        }
        field(16; "Nom Fournisseur"; Text[50])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("N° Fournisseur")));
            Description = 'IBK DSFT 13 12 2010';
            FieldClass = FlowField;
        }
        field(17; "Montant ligne"; Decimal)
        {
            CalcFormula = lookup("Payment Line".Amount where("No." = field("N° Bordereu"),
                                                              "Account No." = field("N° Fournisseur"),
                                                              "N° chèque" = field("N°Chèque")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code banque", "Référence chèque", "N°Chèque")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

