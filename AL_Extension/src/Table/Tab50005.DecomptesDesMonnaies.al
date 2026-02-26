table 50005 "Calcul Interet Moratoire"
{
    // DrillDownPageID = "Suivie Décompte";
    //  LookupPageID = "Suivie Décompte";



    fields
    {
        field(1; "Type Document"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "N°Document"; Code[20])
        {
        }
        field(3; "N°Client"; Code[20])
        {
        }
        field(4; "Type amortissement"; Option)
        {
            OptionCaption = 'Degressif,Constant';
            OptionMembers = Degressif,Constant;
        }
        field(6; "Montant CMT"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(7; "Taux d'interêt"; Decimal)
        {
        }
        field(8; "N°Ligne"; Integer)
        {
        }
        field(9; "Echéance"; Date)
        {
        }
        field(10; "Principal Encours"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(11; Ammortissements; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(12; "Nombres de jours"; Text[50])
        {
        }
        field(13; "Intérêts"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(14; "Total de l'Echéance"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(15; "%TVA"; Decimal)
        {
        }
        field(16; "Montant TVA"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(17; "Traite générée"; Boolean)
        {
        }
        field(18; "N°Traite"; Code[20])
        {
        }
        field(19; "N°Facture"; Code[20])
        {
        }
        field(20; "N° Expedition"; Code[20])
        {
            CalcFormula = Lookup("Sales Shipment Header"."No." WHERE("Order No." = FIELD("N°Document")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Type Document", "N°Document", "N°Ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure Imprimer()
    var
        Rep50054: Report 50054;

    begin
        Rep50054.SETTABLEVIEW(Rec);
        Rep50054.RUNMODAL;
    end;
}

