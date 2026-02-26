Table 50023 "Liste Factures Lettrage"
{

    fields
    {
        field(1; Sequence; Integer)
        {
            Editable = false;
        }
        field(2; Fournisseurs; Code[20])
        {
            Editable = false;
        }
        field(3; "Nom Et Prenom"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field(Fournisseurs)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Numero Facture"; Code[20])
        {
            Editable = false;
        }
        field(5; "Montant Facture"; Decimal)
        {
            Editable = false;
        }
        field(6; Lettrage; Boolean)
        {
        }
        field(7; "Date Document"; Date)
        {
            Editable = false;
        }
        field(8; Description; Text[100])
        {
            Editable = false;
        }
        field(9; "ID Lettrage"; Code[50])
        {
        }
        field(10; "Numero Reglement"; Code[20])
        {
            Editable = false;
        }
        field(11; "Montant Reglement"; Decimal)
        {
        }
        field(12; RS; Code[20])
        {
            Editable = false;
        }
        field(13; "Montant Retenu"; Decimal)
        {
            Editable = false;
        }
        field(14; "Date Reglement"; Date)
        {
            Editable = false;
        }
        field(15; "Compte Bancaire"; Code[20])
        {
        }
        field(16; Banque; Option)
        {
            OptionMembers = " ",ATB,ATTIJARI,BNA,BH,BT,BTE,BTL,BTK,QNB,STB,IUB,UBCI,ZITOUNA;
        }
        field(17; "Date Echeance"; Date)
        {
        }
        field(18; "Numero Piece"; Code[20])
        {
        }
        field(19; "Mode Paiement"; Option)
        {
            OptionMembers = " ",Cheque,Traite,Espece;
        }
        field(20; "Num Ligne Reglement"; Integer)
        {
        }
        field(21; "Num Facture Fournisseur"; Code[20])
        {
            CalcFormula = lookup("Purch. Inv. Header"."Vendor Invoice No." where("No." = field("Numero Facture")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Sequence, "Numero Reglement", "Num Ligne Reglement")
        {
            Clustered = true;
        }
        key(Key2; "Numero Reglement")
        {
        }
        key(Key3; "Mode Paiement")
        {
        }
    }

    fieldgroups
    {
    }
}

