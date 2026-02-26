Codeunit 8001559 UserExit
{
    //GL2024  ID dans Nav 2009 : "8001400"
    // //+BGW+USEREXIT CW 06/11/06 Allow customization
    // 
    // Template for CodeunitOnRun, based on codeunit 414:ReleaseSalesDocument :
    // 
    // CASE pObjectID OF
    // 
    //   CODEUNIT::"Release Sales Document":BEGIN
    //     pRecordRef.SETTABLE(lSalesHeader);
    //     case pTriggerID of
    //       +1:BEGIN // Release
    //       end;
    //       -1:BEGIN // ReOpen
    //       END;
    //     END;
    //     pRecordRef.GETTABLE(lSalesHeader);
    //   END;
    // 
    // end;


    trigger OnRun()
    begin
    end;


    procedure CodeunitOnRun(var pRecordRef: RecordRef; pObjectID: Integer; pTriggerID: Integer) return: Integer
    begin
        // from a codeunit
        return := -1;
    end;
}

