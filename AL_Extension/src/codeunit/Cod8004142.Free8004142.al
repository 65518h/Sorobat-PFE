Codeunit 8004142 "Free 8004142"
{
    // //PLANNING_TASK CW 30/08/09


    trigger OnRun()
    begin
    end;

    var
        tOnValidate: label 'Trigger not defined for table %1 field %2';
        tBudgetDate: label 'Attention budget déjà été caclculé jusqu''''au %1. Confirmez la modification de %2 ?';
        tEndingDate: label '%1 doit être superieure à %2';
        tJobTask: label 'Le budget de l''abonnement a été calculé jusqu''au %1. Confirmer vous le changement de %2.';
        tEntryExists: label 'You cannot change %1 because there are one or more entries associated.';
        tIsNotANumber: label 'can''t be incremented';
}

