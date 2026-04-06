Table 52048995 "PR Réparation Enreg."
{
    //GL2024  ID dans Nav 2009 : "39004704"
    fields
    {
        field(1; "N° Reparation"; Code[20])
        {
        }
        field(2; "N° Ligne"; Integer)
        {
        }
        field(7; "Réf. PR"; Code[20])
        {
            TableRelation = if (Type = const(Article)) Item."No."
            else
            if (Type = const("Frais annexe")) "Item Charge"."No.";
        }
        field(8; "Quantité"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(10; "Coût Unitaire"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(11; "Coût Total"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(12; "Désignation Piéce"; Text[100])
        {
        }
        field(13; Type; Option)
        {
            OptionMembers = " ",Article,"Frais annexe";
        }
        field(14; "N° Véhicule"; Code[20])
        {
        }
        field(15; "N° Affaire"; Code[20])
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° Reparation", "N° Ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        PR.Reset;
        PR.SetRange("N° Reparation", "N° Reparation");
        if PR.Find('+') then
            "N° Ligne" := PR."N° Ligne" + 10000
        else
            "N° Ligne" := 10000;
        InsertItemEntry();
    end;

    var
        PR: Record "PR Réparation";


    procedure InsertItemEntry()
    var
        RecItemEntry: Record "Item Journal Line";
        CUItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        "RecParamétreParc": Record "Paramétre Parc";
        Text001: label 'Sortie Sur Reparation N° : ';
        Text002: label 'Erreur Insertion';
    begin
        if (RecParamétreParc.Get) and (Type = Type::Article) then begin
            //MBY 14/02/2011
            RecItemEntry.Reset;
            RecItemEntry."Journal Template Name" := RecParamétreParc."Journal Template";
            RecItemEntry."Journal Batch Name" := RecParamétreParc."Journal Batch";
            RecItemEntry."Line No." := 10000;
            RecItemEntry."Document No." := "N° Reparation";
            if RecItemEntry.FindSet then
                RecItemEntry.DeleteAll;
            RecItemEntry.Reset;
            RecItemEntry."Journal Template Name" := RecParamétreParc."Journal Template";
            RecItemEntry."Journal Batch Name" := RecParamétreParc."Journal Batch";
            RecItemEntry."Line No." := 10000;
            RecItemEntry.Validate("Item No.", "Réf. PR");
            RecItemEntry."Document No." := "N° Reparation";

            RecItemEntry.Validate("Posting Date", Today);
            RecItemEntry.Validate("Entry Type", 3);//negatif adjustment
            RecItemEntry."Location Code" := RecParamétreParc."Code Magasin";
            RecItemEntry.Validate(Quantity, Quantité);
            RecItemEntry.Validate("Unit Cost", "Coût Unitaire");
            RecItemEntry.Description := CopyStr(Text001, 1) + "N° Reparation";
            // RecItemEntry."N° Véhicule" := "N° Véhicule";
            // RecItemEntry."N° Affaire":="N° Affaire";
            RecItemEntry.Insert;
            CUItemJnlPostLine.Run(RecItemEntry);
        end
        else
            ERROR(Text002);
    end;
}

