Table 52048960 "Image Chantier"
{
    //GL2024  ID dans Nav 2009 : "39001509"
    fields
    {
        field(1; Sequence; Integer)
        {
            NotBlank = false;
        }
        field(2; "Sequence / Document / Code"; Code[20])
        {
        }
        field(3; "Ligne / Sequence"; Integer)
        {
        }
        field(4; Fournisseur; Code[20])
        {
        }
        field(5; "Nom Fournisseur"; Text[100])
        {
        }
        field(6; Magasin; Code[20])
        {
        }
        field(7; "Quantité"; Decimal)
        {
        }
        field(8; Description; Text[100])
        {
        }
        field(9; "Table"; Integer)
        {
        }
        field(10; Article; Code[30])
        {
        }
        field(50000; "Description Article"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Article)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Nom Table"; Option)
        {
            OptionMembers = " ",DA,"Ligne DA","Ecriture Article",Achat,Recpetion,"Ligne Reception",Gasoil,"Ligne Gasoil",Pointage,"Ligne Pointage",Reparation,"Ligne Reparation",Article,"Ligne Achat",Retour,"Ligne Retour";
        }
        field(50002; Chantier; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; Chantier, "Table", Sequence)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

