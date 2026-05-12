tableextension 50245 "Document Attachment EXT" extends "Document Attachment"
{
    fields
    {
        // Add changes to table fields here
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    //HS
    trigger OnDelete()
    var
    begin
        RecUserSetup.Get(UserId);
        RecPurchasesPayablesSetup.Get();
        DateInsertFile := DT2Date(Rec."Attached Date");
        DeleteDate := CalcDate(RecPurchasesPayablesSetup."Durée Suppression Fichier", DateInsertFile);
        if (Rec.User <> UserId) then
            Error('Vous ne pouvez pas supprimer un fichier inséré par un autre utilisateur.');
        if (Today > DeleteDate) and (not RecUserSetup."Autoriser Suppression Fichiers") then
            Error('Le fichier inséré le %1 est expiré (durée %2 dépassée).',
                  DateInsertFile, Format(RecPurchasesPayablesSetup."Durée Suppression Fichier"));
    end;
    //HS
    var
        RecUserSetup: Record "User Setup";
        RecPurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DateInsertFile: Date;
        DeleteDate: Date;

}