Codeunit 8001529 "BAR Integration"
{
    //GL2024  ID dans Nav 2009 : "8001608"

    trigger OnRun()
    begin
    end;

    var
        Text8001600: label ' is mandatory to post on %1 %2.';
        Text8001601: label ' must be %1 to post on %2 %3.';
        Text8001602: label ' must be empty to post on %1 %2.';


    procedure CheckReasonCode(var pRec: Record "Gen. Journal Line"; pGLAcc: Record "G/L Account")
    begin
        if ClosingDate(pRec."Posting Date") <> pRec."Posting Date" then begin
            case pGLAcc."Reason Value Posting" of
                pGLAcc."reason value posting"::"Code Mandatory":
                    if pRec."Reason Code" = '' then
                        pRec.FieldError(
                          "Reason Code", StrSubstNo(Text8001600, pGLAcc.TableName, pGLAcc."No."));
                pGLAcc."reason value posting"::"Same Code":
                    if pRec."Reason Code" <> pGLAcc."Reason Code" then
                        pRec.FieldError(
                          "Reason Code", StrSubstNo(Text8001601, pGLAcc."Reason Code", pGLAcc.TableName, pGLAcc."No."));
                pGLAcc."reason value posting"::"No Code":
                    if pRec."Reason Code" <> '' then
                        pRec.FieldError(
                          "Reason Code", StrSubstNo(Text8001602, pGLAcc.TableName, pGLAcc."No."));
            end;
        end;
    end;
}

