Table 8001436 "BOQ Template"
{
    // #7005 XPE 18/03/09 Création de la table et des traitements

    // DrillDownPageID = 8001466;
    //LookupPageID = 8001466;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[80])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lRecRef: RecordRef;
        lBoqCustMgt: Codeunit "BOQ Custom Management";
    begin
        //#7005
        lRecRef.GetTable(Rec);
        lBoqCustMgt.gOndelete(lRecRef, true);
        //#7005//
    end;

    trigger OnRename()
    var
        lRecRef: RecordRef;
        lxRecRef: RecordRef;
        lBoqCustMgt: Codeunit "BOQ Custom Management";
    begin
        //#7005
        lRecRef.GetTable(Rec);
        lxRecRef.GetTable(xRec);
        // Maintenant c'est bien gentil tous ça, mais il faut supprimer le document orphelin sur l'ancienne clé
        lRecRef.GetTable(xRec);
        lBoqCustMgt.gOndelete(lRecRef, true);
        //#7005//
    end;
}

