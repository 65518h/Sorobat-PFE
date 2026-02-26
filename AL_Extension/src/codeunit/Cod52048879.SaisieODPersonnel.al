Codeunit 52048879 "Saisie OD Personnel"
{
    //GL2024  ID dans Nav 2009 : "39001410"
    trigger OnRun()
    begin
        //bool := FALSE;
        //GenJnlManagement.TemplateSelection(4,FALSE);
        //GenJnlManagement.TemplateSelection(250,4,FALSE,gen,bool);
        // GenJnlManagement.TemplateSelection(FormID,FormTemplate,RecurringJnl,GenJnlLine,JnlSelected)
    end;

    var
        GenJnlManagement: Codeunit GenJnlManagement;
        gen: Record "Gen. Journal Line";
        bool: Boolean;
}

