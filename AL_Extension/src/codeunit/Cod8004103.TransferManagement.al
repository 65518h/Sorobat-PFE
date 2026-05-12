Codeunit 8004103 "Transfer Management"
{
    // //+PMT+PAYMENT GESWAY 01/08/02 Nouveau CodeUnit pour la gestion des virements et des prélèvements (V2.60)

    //GL2024   Permissions = TableData 8000050 = rim;

    trigger OnRun()
    begin
    end;

    var
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlLine3: Record "Gen. Journal Line";
        NextDocNo: Code[20];
        Text001: label 'Transfert';


    procedure InsertTransfer()
    begin
        //Table des virements qui n'existe plus Local : VAR VIREMENT
        //Virement2.LOCKTABLE;
        //Virement2.RESET;
        //Virement2.SETCURRENTKEY("N°");
        //Virement2.SETRANGE("N°",Virement."N°");
        //IF Virement2.FIND('-') THEN
        //  ERROR('Virement %1 existe déjà.',Virement."N°");

        //Virement."Code utilisateur" := USERID;
        //Virement.INSERT;
    end;


    procedure VoidTransfer(var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine.TestField("Check Printed", true);
        //GenJnlLine.TESTFIELD("N° opération bancaire");
        GenJnlLine.TestField("Payment Type", GenJnlLine."payment type"::Transfer);

        GenJnlLine2.Reset;
        GenJnlLine2.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJnlLine2.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        //GenJnlLine2.SETRANGE("N° opération bancaire",GenJnlLine."N° opération bancaire");
        GenJnlLine2.SetRange("Payment Type", GenJnlLine."Payment Type");
        if GenJnlLine2.Find('-') then
            repeat
                if GenJnlLine."Bal. Account No." = '' then begin
                    if GenJnlLine2."Account No." = '' then begin
                        GenJnlLine2."Account Type" := GenJnlLine2."account type"::"Bank Account";
                        GenJnlLine2."Account No." := GenJnlLine."Account No.";
                    end else
                        GenJnlLine2."Bal. Account Type" := GenJnlLine2."bal. account type"::"Bank Account";
                    GenJnlLine2.Validate(Amount);
                    GenJnlLine2."Bank Payment Type" := GenJnlLine."Bank Payment Type";
                    GenJnlLine2."Document No." := '';
                end;
                //    GenJnlLine2."N° opération bancaire" := '';
                GenJnlLine2."Bank Payment Type" := GenJnlLine2."bank payment type"::" ";

                //+PMT+PAYMENT
                GenJnlLine2."Payment Type" := 0;
                //+PMT+PAYMENT//

                GenJnlLine2."Check Printed" := false;
                GenJnlLine2.UpdateSource;
                GenJnlLine2.Modify;
            until GenJnlLine2.Next = 0;

        /*Virement2.RESET;
        Virement2.SETCURRENTKEY("Etat virement");
        Virement2.SETRANGE("Etat virement",Virement2."Etat virement"::Généré);
        Virement2.SETRANGE("N°",GenJnlLine."N° opération bancaire");
        Virement2.FIND('-');
        Virement2."Etat initial de l'écriture" := Virement2."Etat virement";
        Virement2."Etat virement" := Virement2."Etat virement"::Annulé;
        Virement2.MODIFY;*/

    end;


    procedure VoidFinancialTransfer()
    begin
        //LOCALS VAR Table VIREMENT
        /*
        Virement.TESTFIELD("Etat virement",Virement."Etat virement"::Enregistré);
        ParamCodeOrig.GET;
        EcrFourn.SETRANGE("N° virement",Virement."N°");
        EcrFourn.SETFILTER("Source Code",'<> %1',ParamCodeOrig."Virement annulé financièrement");
        IF EcrFourn.FIND('-') THEN BEGIN
          GenJnlLine2."Posting Date" := Virement."Date comptabilisation";
          GenJnlLine2."Source Code" := ParamCodeOrig."Virement annulé financièrement";
          GenJnlLine2."System-Created Entry" := TRUE;
          REPEAT
            GenJnlLine2."Document No." := EcrFourn."Document No.";
            GenJnlLine2."N° opération bancaire" := EcrFourn."N° virement";
            GenJnlLine2."Type opération bancaire" := GenJnlLine2."Type opération bancaire"::"1";
            GenJnlLine2."Account Type" := GenJnlLine2."Account Type"::"Bank Account";
            GenJnlLine2."Account No." := Virement."N° compte bancaire";
            GenJnlLine2.Description := STRSUBSTNO('Annulation virement %1.',EcrFourn."N° virement");
            GenJnlLine2."Bal. Account Type" := GenJnlLine2."Bal. Account Type"::Vendor;
            GenJnlLine2."Bal. Account No." := EcrFourn."Vendor No.";
            GenJnlLine2.VALIDATE(Amount,EcrFourn.Amount);
            GenJnlLine2."Shortcut Dimension 1 Code" := EcrFourn."Global Dimension 1 Code";
            GenJnlLine2."Shortcut Dimension 2 Code" := EcrFourn."Global Dimension 2 Code";
            GenJnlPostLine.RUN(GenJnlLine2);
          UNTIL EcrFourn.NEXT = 0;
          GenJnlLine2.DELETEALL;
        END;
        
        Virement."Etat initial de l'écriture" := Virement."Etat virement";
        Virement."Etat virement" := Virement."Etat virement"::"Annulé financièrement";
        Virement.MODIFY;
        */

    end;


    procedure CompressTransfert(var GenJnlLine: Record "Gen. Journal Line")
    var
        OldVendorNo: Code[20];
        OldDocNo: Code[20];
        OldBankAccountCode: Code[10];
        NoSerieMngt: Codeunit NoSeriesManagement;
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        if GenJnlLine.Find('-') then begin
            GenJnlBatch.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
            NoSerieMngt.TestManual(GenJnlBatch."No. Series");
            NextDocNo := NoSerieMngt.GetNextNo(GenJnlBatch."No. Series", GenJnlLine."Posting Date", false);
            repeat
                if (OldVendorNo <> GenJnlLine."Account No.") or (OldDocNo <> GenJnlLine."Document No.") or
                  (OldBankAccountCode <> GenJnlLine."Payment Bank Account") then begin
                    CompressGenJnlLine(GenJnlLine, OldVendorNo, OldDocNo, OldBankAccountCode);
                    OldVendorNo := GenJnlLine."Account No.";
                    OldDocNo := GenJnlLine."Document No.";
                    OldBankAccountCode := GenJnlLine."Payment Bank Account";
                end;
            until GenJnlLine.Next = 0;
            CompressGenJnlLine(GenJnlLine, OldVendorNo, OldDocNo, OldBankAccountCode);
        end;
    end;

    local procedure CompressGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; OldVendorNo: Code[20]; OldDocNo: Code[20]; OldBankAccountCode: Code[10])
    var
        TotalAmount: Decimal;
        Vendor: Record Vendor;
    begin
        GenJnlLine2.Reset;
        GenJnlLine2.Copy(GenJnlLine);
        GenJnlLine2.SetRange("Account No.", OldVendorNo);
        GenJnlLine2.SetRange("Document No.", OldDocNo);
        GenJnlLine2.SetRange("Payment Bank Account", OldBankAccountCode);
        if GenJnlLine2.Find('-') then begin
            TotalAmount := 0;
            GenJnlLine3.Init;
            GenJnlLine3.Copy(GenJnlLine2);
            GenJnlLine3."Document No." := NextDocNo;
            if (GenJnlLine2.Count > 1) then begin
                repeat
                    TotalAmount := TotalAmount + GenJnlLine2.Amount;
                until GenJnlLine2.Next = 0;
                Vendor.SetCurrentkey("No.");
                Vendor.SetRange("No.", GenJnlLine3."Account No.");
                if Vendor.Find('-') then
                    GenJnlLine3.Description := StrSubstNo(Text001 + ' ' + Vendor.Name)
                else
                    GenJnlLine3.Description := StrSubstNo(Text001);
                GenJnlLine3.Validate(Amount, TotalAmount);
                GenJnlLine3."Applies-to Doc. Type" := GenJnlLine3."applies-to doc. type"::" ";
                GenJnlLine3."Applies-to Doc. No." := '';
            end;
            GenJnlLine2.DeleteAll;
            GenJnlLine3.Insert(true);
            NextDocNo := IncStr(NextDocNo);
        end;
    end;
}

