Codeunit 8004104 "Demo Payment Initialize"
{
    // //+PMT+PAYMENT GESWAY 01/08/02 Initialisation


    trigger OnRun()
    var
        lSourceCodeSetup: Record "Source Code Setup";
    begin
        if not Confirm(tDataInitConfirm) then
            exit;

        InsertReason('ENC,Remise effet à l''encaissement');
        InsertReason('ESC,Remise effet à l''escompte');
        if GLSetup.Get then begin
            Evaluate(GLSetup."Bank Waiting Period", '<-10D>');
            GLSetup."Cash Hand. Reason Code" := 'ENC';
            GLSetup."Discount Hand. Reason Code" := 'ESC';
            GLSetup.Modify;
        end;

        InsertGLAccount('403100,Effets à payer / B1');
        InsertGLAccount('403200,Effets à payer / B2');
        InsertGLAccount('403101,VCOM à payer / B1');
        InsertGLAccount('403202,VCOM à payer / B2');
        InsertGLAccount('413000,Effets à recevoir');
        InsertGLAccount('512100,Banque B1');
        InsertGLAccount('512200,Banque B2');

        InsertBankPostingGroup('EAP-B1,403100');
        InsertBankPostingGroup('EAP-B2,403200');
        InsertBankPostingGroup('VCOM-B1,403101');
        InsertBankPostingGroup('VCOM-B2,403201');
        InsertBankPostingGroup('EAR,413000');
        InsertBankPostingGroup('B1,512100');
        InsertBankPostingGroup('B2,512200');

        InsertBankAccount('EAR,Effets à recevoir,A recevoir,EAR,ER000001');
        InsertBankAccount('B1,Banque Première,0,B1,B1000001,FR76 30076 02902 15165700200 49,C:\ETEBAC-LCR-B1.txt,111111');
        InsertBankAccount('B2,Banque Seconde,0,B2,B2000001,FR76 30027 00057 00000104446 34,C:\ETEBAC-LCR-B2.txt,222222');
        InsertBankAccount('EAP-B1,Effets à payer B1,A payer,EAP-B1,EPB10001,FR76 30076 02902 15165700200 49');
        InsertBankAccount('EAP-B2,Effets à payer B2,A payer,EAP-B2,EPB20001,FR76 30027 00057 00000104446 34');
        InsertBankAccount('VCOM-B1,VCOM à payer B1,A payer,VCOM-B1,VCB10001,FR76 30076 02902 15165700200 49');
        InsertBankAccount('VCOM-B2,VCOM à payer B2,A payer,VCOM-B2,VCB20001,FR76 30027 00057 00000104446 34');

        InsertPaymentMethod('LCR,Lettre de Change Relevé,Effet,Accepté');
        InsertPaymentMethod('BOR,Billet à Ordre,Effet,BOR');
        InsertPaymentMethod('LNA,LCR non soumise à accept.,Effet,Non accepté,EAR');
        InsertPaymentMethod('CHQ,Chèque,Chèque');
        InsertPaymentMethod('VCOM,Virement,VCOM');
        InsertPaymentMethod('VIR,Virement,Virement');
        InsertPaymentMethod('PRL,Prélèvement Client,Prélèvement');
        InsertPaymentMethod('PRL-B1,Prélèvement Fourn. / B1,0,0,B1');

        //GL2024 InsertSeries('FSCPTA-EAR,Règlements par effet');
        //GL2024 InsertSeriesLine('FSCPTA-EAR,10000,ER000001,1');

        lSourceCodeSetup.Get;
        InsertGenJnlTemplate(StrSubstNo('REGL-B1,Règlements B1,Règlements,%1,%2,B1,FSCPTA-REG',
          lSourceCodeSetup."Cash Receipt Journal", page::"Cash Receipt Journal"));
        InsertGenJnlTemplate(StrSubstNo('REGL-EAR,Règlements effets,Règlements,%1,%2,EAR,FSCPTA-EAR',
          lSourceCodeSetup."Cash Receipt Journal", page::"Cash Receipt Journal"));
        InsertGenJnlTemplate(StrSubstNo('REGL-PRL,Règlements prélèvements,Règlements,%1,%2',
          lSourceCodeSetup."Cash Receipt Journal", page::"Cash Receipt Journal"));

        InsertGenJnlTemplate(StrSubstNo('AUTO,Paiments automatiques,Paiements,%1,%2',
          lSourceCodeSetup."Payment Journal", page::"Payment Journal"));

        if Customer.Get('10000') then begin
            InsertCustomerBankAccount('10000,SG,FR76 30003 01289 00050423624 60');
            //  Customer."Default Payment Bank Account" := 'SG';
            Customer."Payment Method Code" := 'LCR';
            Customer.Modify;
        end;
        if Customer.Get('20000') then begin
            InsertCustomerBankAccount('20000,01,FR76 12000 03100 00012123003 07');
            //  Customer."Default Payment Bank Account" := '01';
            Customer."Payment Method Code" := 'BOR';
            Customer.Modify;
        end;
        if Customer.Get('30000') then begin
            InsertCustomerBankAccount('30000,1,FR76 30003 01289 00050423624 60');
            //  Customer."Default Payment Bank Account" := '1';
            Customer."Payment Method Code" := 'PRL';
            Customer.Modify;
        end;
        if Customer.Get('50000') then begin
            InsertCustomerBankAccount('50000,BN,FR76 12000 03100 00012123003 07');
            //  Customer."Default Payment Bank Account" := 'BN';
            Customer."Payment Method Code" := 'LNA';
            Customer.Modify;
        end;

        if Vendor.Get('10000') then begin
            InsertVendorBankAccount('10000,SG,FR76 30003 01289 00050423624 60');
            //  Vendor."Default Payment Bank Account" := 'SG';
            Vendor."Payment Method Code" := 'LCR';
            Vendor.Modify;
        end;
        if Vendor.Get('20000') then begin
            InsertVendorBankAccount('20000,BN,FR76 12000 03100 00012123003 07');
            //  Vendor."Default Payment Bank Account" := 'BN';
            Vendor."Payment Method Code" := 'LCR';
            Vendor.Modify;
        end;
        if Vendor.Get('30000') then begin
            InsertVendorBankAccount('30000,BN,FR76 12000 03100 00012123003 07');
            //  Vendor."Default Payment Bank Account" := 'BN';
            Vendor."Payment Method Code" := 'VCOM';
            Vendor.Modify;
        end;
        if Vendor.Get('50000') then begin
            Vendor."Payment Method Code" := 'PRL-B1';
            Vendor.Modify;
        end;

        InsertBankPayment('EAP-B1,Effet,EPB100000');
        InsertBankPayment('EAP-B2,Effet,EPB200000');
        InsertBankPayment('VCOM-B1,VCOM,VCB100000,Non,,C:\VCOM-B1.txt,VCOM1000');
        InsertBankPayment('VCOM-B2,VCOM,VCB200000,Non,,C:\VCOM-B2.txt,VCOM1000');
        InsertBankPayment('B1,Chèque,CHB100000');
        InsertBankPayment('B2,Chèque,CHB200000');
        InsertBankPayment('B1,Virement,VIB100000,Oui,111111,C:\ETEBAC-VIR-B1.txt,ETEBAC');
        InsertBankPayment('B2,Virement,VIB200000,Oui,222222,C:\ETEBAC-VIR-B2.txt,ETEBAC');
        InsertBankPayment('B1,Prélèvement,PRB100000,Oui,111111,C:\ETEBAC-PRL-B1.txt');
        InsertBankPayment('B2,Prélèvement,PRB200000,Oui,222222,C:\ETEBAC-PRL-B2.txt');

        with ReportSelection do begin
            if Get(Usage::"B.Check", '1') then
                Delete;
            Init;
            Usage := Usage::"B.Check";
            Sequence := '1';
            //GL2024 NAVIBAT   "Report ID" := Report::"Generate Payments";
            Insert;
        end;

        InsertPaymentTerms('3FOIS,0J,20% comptant puis 2 mens.');
        InsertPaymentTermsFract('3FOIS,10000,20,+1M+FM');
        InsertPaymentTermsFract('3FOIS,20000,40,+1M+FM');
        InsertPaymentTermsFract('3FOIS,30000,40');

        UpdateReportSelections('15,1,8004121');
        UpdateReportSelections('17,1,8004122');

        Message(tInitDone);
    end;

    var
        ReportSelection: Record "Report Selections";
        Customer: Record Customer;
        Vendor: Record Vendor;
        tDataInitConfirm: label 'Do you want do init demonstration data ?';
        tInitDone: label 'Init done';
        GLSetup: Record "General Ledger Setup";
        BankAccount: Record "Bank Account";


    procedure ExtractText(var pText: Text[250]) Return: Text[50]
    var
        i: Integer;
    begin
        i := StrPos(pText, ',');
        if i = 0 then begin
            Return := pText;
            pText := '';
        end else begin
            Return := CopyStr(pText, 1, i - 1);
            pText := CopyStr(pText, i + 1);
        end;
    end;


    procedure ExtractInteger(var pText: Text[250]) Return: Integer
    var
        lText: Text[30];
    begin
        lText := ExtractText(pText);
        if lText = '' then
            Return := 0
        else
            Evaluate(Return, lText);
    end;


    procedure ExtractBoolean(var pText: Text[250]) Return: Boolean
    var
        lText: Text[30];
    begin
        lText := ExtractText(pText);
        if lText = '' then
            Return := false
        else
            Evaluate(Return, lText);
    end;


    procedure InsertReason(pValues: Text[250])
    var
        lRec: Record "Reason Code";
    begin
        with lRec do begin
            Code := ExtractText(pValues);
            Description := ExtractText(pValues);
            if Insert then;
        end;
    end;


    procedure InsertGLAccount(pValues: Text[250])
    var
        lRec: Record "G/L Account";
    begin
        with lRec do begin
            "No." := ExtractText(pValues);
            Name := ExtractText(pValues);
            if Insert then;
        end;
    end;


    procedure InsertBankPostingGroup(pValues: Text[250])
    var
        lRec: Record "Bank Account Posting Group";
    begin
        with lRec do begin
            Code := ExtractText(pValues);
            //GL2024   "G/L Bank Account No." := ExtractText(pValues);
            if Insert then;
        end;
    end;


    procedure InsertBankAccount(pValues: Text[250])
    var
        lRec: Record "Bank Account";
    begin
        with lRec do begin
            "No." := ExtractText(pValues);
            Validate(Name, ExtractText(pValues));
            Evaluate("Bank Type", ExtractText(pValues));
            "Bank Acc. Posting Group" := ExtractText(pValues);
            "Last Statement No." := ExtractText(pValues);
            if "Bank Type" = 0 then
                Validate(Iban, ExtractText(pValues));
            "LCR file name" := ExtractText(pValues);
            "LCR Transfer No." := ExtractText(pValues);
            if Insert then;
        end;
    end;


    procedure InsertPaymentMethod(pValues: Text[250])
    var
        lRec: Record "Payment Method";
    begin
        with lRec do begin
            Code := ExtractText(pValues);
            Description := ExtractText(pValues);
            Evaluate("Payment Type", ExtractText(pValues));
            Evaluate("Bill Type", ExtractText(pValues));
            "Bal. Account Type" := "bal. account type"::"Bank Account";
            "Bal. Account No." := ExtractText(pValues);
            if Insert then;
        end;
    end;

    /* GL2024
        procedure InsertSeries(pValues: Text[250])
        var
            lRec: Record 308;
        begin
            with lRec do begin
                Code := ExtractText(pValues);
                Description := ExtractText(pValues);
                "Default Nos." := true;
                if Insert then;
            end;
        end;


        procedure InsertSeriesLine(pValues: Text[250])
        var
            lRec: Record 309;
        begin
            with lRec do begin
                "Series Code" := ExtractText(pValues);
                "Line No." := ExtractInteger(pValues);
                "Starting No." := ExtractText(pValues);
                ;
                "Increment-by No." := ExtractInteger(pValues);
                ;
                Open := true;
                if Insert then;
            end;
        end;

    */
    procedure InsertGenJnlTemplate(pValues: Text[250])
    var
        lRec: Record "Gen. Journal Template";
    begin
        with lRec do begin
            Name := ExtractText(pValues);
            Description := ExtractText(pValues);
            Evaluate(Type, ExtractText(pValues));
            "Source Code" := ExtractText(pValues);
            Validate("PAGE ID", ExtractInteger(pValues));
            "Bal. Account Type" := "bal. account type"::"Bank Account";
            Validate("Bal. Account No.", ExtractText(pValues));
            Validate("No. Series", ExtractText(pValues));
            if Insert then;
        end;
    end;


    procedure InsertCustomerBankAccount(pValues: Text[250])
    var
        lRec: Record "Customer Bank Account";
    begin
        with lRec do begin
            "Customer No." := ExtractText(pValues);
            Code := ExtractText(pValues);
            Validate(Iban, ExtractText(pValues));
            if Insert then;
        end;
    end;


    procedure InsertVendorBankAccount(pValues: Text[250])
    var
        lRec: Record "Vendor Bank Account";
    begin
        with lRec do begin
            "Vendor No." := ExtractText(pValues);
            Code := ExtractText(pValues);
            Validate(Iban, ExtractText(pValues));
            if Insert then;
        end;
    end;


    procedure InsertBankPayment(pValues: Text[250])
    var
        lRec: Record "Bank Payment Type";
    begin
        with lRec do begin
            "Bank Account No." := ExtractText(pValues);
            Evaluate("Payment Type", ExtractText(pValues));
            "Last Payment No." := ExtractText(pValues);
            "Bal. Summarize" := ExtractBoolean(pValues);
            "Transfer No." := ExtractText(pValues);
            FileName := ExtractText(pValues);
            Evaluate("Export Type", ExtractText(pValues));
            if Insert then;
        end;
    end;


    procedure InsertPaymentTerms(pValues: Text[250])
    var
        lRec: Record "Payment Terms";
    begin
        with lRec do begin
            Code := ExtractText(pValues);
            Evaluate("Due Date Calculation", ExtractText(pValues));
            Description := ExtractText(pValues);
            if Insert then;
        end;
    end;


    procedure InsertPaymentTermsFract(pValues: Text[250])
    var
        lRec: Record Fractionation;
    begin
        with lRec do begin
            "Payment Terms Code" := ExtractText(pValues);
            "Line No." := ExtractInteger(pValues);
            "Fractionation %" := ExtractInteger(pValues);
            Evaluate("Time between fractionation", ExtractText(pValues));
            if Insert then;
        end;
    end;


    procedure UpdateReportSelections(pValues: Text[250])
    var
        lRec: Record "Report Selections";
    begin
        with lRec do begin
            Usage := ExtractInteger(pValues);
            Sequence := ExtractText(pValues);
            if Get(Usage, Sequence) then
                Delete;
            "Report ID" := ExtractInteger(pValues);
            if Insert then;
        end;
    end;
}

