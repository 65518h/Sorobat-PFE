PageExtension 50091 "Item Journal Temp. List_PagEXT" extends "Item Journal Template List"
{
    layout
    {
        modify(Description)
        {
            Editable = false;
        }
        addafter(Description)
        {
            field("PC-PCHANTIER"; rec."PC-PCHANTIER")
            {
                ApplicationArea = all;
            }
        }
    }
    var
        RecItemJournalTemplate: Record "Item Journal Template";

    trigger OnOpenPage()
    begin

        // RB SORO 31/07/2015
        /*     RecItemJournalTemplate.RESET;
             IF RecItemJournalTemplate.FINDFIRST THEN
                 REPEAT
                     IF (RecItemJournalTemplate."Affecter Utilisateur" = UPPERCASE(USERID)) THEN BEGIN
                         RecItemJournalTemplate.MARK := TRUE;
                     END;
                 UNTIL RecItemJournalTemplate.NEXT = 0;
             RecItemJournalTemplate.MARKEDONLY(TRUE);
             rec.COPY(RecItemJournalTemplate);*/
        // RB SORO 31/07/2015
    end;

}

