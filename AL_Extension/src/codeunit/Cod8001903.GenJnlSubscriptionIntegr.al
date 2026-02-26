Codeunit 8001903 "Gen. Jnl. Subscription Integr."
{
    // #8296 CW 15/11/10
    // #8410 SD 21/10/10
    // //+ABO+ GESWAY 01/01/09 **ControlDateSubscription** : controle sur périodes d'abonnement fonction du comtpe comptable
    //                         **SetGLEntrySubscription** : Initialisation de l'écriture Comptable


    trigger OnRun()
    begin
    end;

    var
        Text8001901: label ' is mandatory to post on %1 %2.';
        Text8001902: label ' must be %1 to post on %2 %3.';
        Text8001903: label ' must be empty to post on %1 %2.';
        Text8001904: label 'Recurring period is not completely filled.';
        Text8001905: label ' must be purchase or sale ';


    procedure ControlDateSubscription(var pGenJnlLine: Record "Gen. Journal Line"; pGLAcc: Record "G/L Account")
    begin
        with pGenJnlLine do begin
            if "Subscription Entry No." = 0 then begin
                //#8410
                if "Posting Date" = ClosingDate("Posting Date") then begin
                    //cloture
                    "Subscription Starting Date" := 0D;
                    "Subscription End Date" := 0D;
                end else begin
                    //#8410//
                    case pGLAcc."Subscription Period Control" of
                        pGLAcc."subscription period control"::"Obligatory period":
                            begin
                                if ("Subscription Starting Date" = 0D) then
                                    FieldError(
                                      "Subscription Starting Date",
                                      StrSubstNo(Text8001901, pGLAcc.TableName, pGLAcc."No."));
                                if ("Subscription End Date" = 0D) then
                                    FieldError(
                                      "Subscription End Date",
                                      StrSubstNo(Text8001901, pGLAcc.TableName, pGLAcc."No."));
                                if ("Gen. Posting Type" <> "gen. posting type"::Purchase) and
                                  ("Gen. Posting Type" <> "gen. posting type"::Sale) then
                                    FieldError(
                                    "Gen. Posting Type",
                                    StrSubstNo(Text8001905));
                            end;
                        //#8296
                        /*
                              pGLAcc."Subscription Period Control"::"No period": BEGIN
                                "Subscription Starting Date" := 0D;
                                "Subscription End Date" := 0D;
                              END;
                              ELSE BEGIN
                                "Subscription Starting Date" := 0D;
                                "Subscription End Date" := 0D;
                              END;
                        */
                        pGLAcc."subscription period control"::"No period":
                            begin
                                TestField("Subscription Starting Date", 0D);
                                TestField("Subscription End Date", 0D);
                            end;
                        else
                            //      IF NOT ("Gen. Posting Type" IN ["Gen. Posting Type"::Purchase,"Gen. Posting Type"::Sale]) THEN BEGIN
                            if pGLAcc."Income/Balance" <> pGLAcc."income/balance"::"Income Statement" then begin
                                "Subscription Starting Date" := 0D;
                                "Subscription End Date" := 0D;
                                "Subscription Entry No." := 0;
                            end;
                    //#8296//
                    end;
                    //#8410
                end;
                //#8410//
            end; // Case
            if (("Subscription Starting Date" <> 0D) and ("Subscription End Date" = 0D)) or
               (("Subscription End Date" <> 0D) and ("Subscription Starting Date" = 0D)) then
                Error(Text8001904);
        end; // With

    end;


    procedure SetGLEntrySubscription(var pGLEntry: Record "G/L Entry"; pGenJnlLine: Record "Gen. Journal Line")
    begin
        //+ABO+
        pGLEntry."Subscription Starting Date" := pGenJnlLine."Subscription Starting Date";
        pGLEntry."Subscription End Date" := pGenJnlLine."Subscription End Date";
        if pGLEntry."Subscription Starting Date" <> 0D then
            pGLEntry."Subscription Entry No." := pGLEntry."Entry No."
        else
            pGLEntry."Subscription Entry No." := pGenJnlLine."Subscription Entry No.";
        //+ABO+//
    end;
}

