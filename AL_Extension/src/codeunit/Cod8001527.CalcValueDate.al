Codeunit 8001527 "Calc Value Date"
{
    //GL2024  ID dans Nav 2009 : "8001606"
    // //+RAP+TOOLS GESWAY 20/04/04 Mise à jour de la date de valeur, échéance dans les tables 81,271,379,380

    Permissions = TableData "Cust. Ledger Entry" = rimd,
                  TableData "Vendor Ledger Entry" = rimd,
                  TableData "Gen. Journal Line" = rimd,
                  TableData "Bank Account Ledger Entry" = rimd,
                  TableData "Detailed Cust. Ledg. Entry" = rimd,
                  TableData "Detailed Vendor Ledg. Entry" = rimd;

    trigger OnRun()
    begin
        if Confirm(tConfirm, false) then begin
            Window.Open(tProgress);
            UpdateGenJnl;
            UpdateBank;
            UpdateCust;
            UpdateVend;
            UpdateCustDet;
            UpdateVendDet;
            Window.Close;
        end;
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        BankEntry: Record "Bank Account Ledger Entry";
        CustEntrydet: Record "Detailed Cust. Ledg. Entry";
        VendorEntrydet: Record "Detailed Vendor Ledg. Entry";
        VendorEntry: Record "Vendor Ledger Entry";
        CustEntry: Record "Cust. Ledger Entry";
        Window: Dialog;
        JaugeMax: Integer;
        Jauge: Integer;
        tProgress: label 'In progress...\#1######################\@2@@@@@@@@@@@@@@@@@@@@@@';
        tConfirm: label 'Do you want to update value date?';


    procedure UpdateGenJnl()
    begin
        with GenJnlLine do
            if Find('-') then begin
                Window.Update(1, TableName);
                JaugeMax := Count;
                Jauge := 0;
                repeat
                    Jauge += 1;
                    Window.Update(2, ROUND(Jauge / JaugeMax * 10000, 1));
                    if "Value Date" = 0D then begin
                        if "Due Date" <> 0D then
                            "Value Date" := "Due Date"
                        else
                            "Value Date" := "Posting Date";
                        Modify
                    end;
                until Next = 0;
            end;
    end;


    procedure UpdateBank()
    begin
        with BankEntry do
            if Find('-') then begin
                Window.Update(1, TableName);
                JaugeMax := Count;
                Jauge := 0;
                repeat
                    Jauge += 1;
                    Window.Update(2, ROUND(Jauge / JaugeMax * 10000, 1));
                    if "Due Date" = 0D then begin
                        "Due Date" := "Posting Date";
                        Modify
                    end;
                until Next = 0;
            end;
    end;


    procedure UpdateCust()
    begin
        with CustEntry do
            if Find('-') then begin
                Window.Update(1, TableName);
                JaugeMax := Count;
                Jauge := 0;
                repeat
                    Jauge += 1;
                    Window.Update(2, ROUND(Jauge / JaugeMax * 10000, 1));
                    if "Value Date" = 0D then begin
                        "Value Date" := "Due Date";
                        Modify
                    end;
                until Next = 0;
            end;
    end;


    procedure UpdateVend()
    begin
        with VendorEntry do
            if Find('-') then begin
                Window.Update(1, TableName);
                JaugeMax := Count;
                Jauge := 0;
                repeat
                    Jauge += 1;
                    Window.Update(2, ROUND(Jauge / JaugeMax * 10000, 1));
                    if "Value Date" = 0D then begin
                        "Value Date" := "Due Date";
                        Modify
                    end;
                until Next = 0;
            end;
    end;


    procedure UpdateCustDet()
    begin
        with CustEntrydet do
            if Find('-') then begin
                Window.Update(1, TableName);
                JaugeMax := Count;
                Jauge := 0;
                repeat
                    Jauge += 1;
                    Window.Update(2, ROUND(Jauge / JaugeMax * 10000, 1));
                    if "Value Date" = 0D then begin
                        "Value Date" := "Initial Entry Due Date";
                        Modify
                    end;
                until Next = 0;
            end;
    end;


    procedure UpdateVendDet()
    begin
        with VendorEntrydet do
            if Find('-') then begin
                Window.Update(1, TableName);
                JaugeMax := Count;
                Jauge := 0;
                repeat
                    Jauge += 1;
                    Window.Update(2, ROUND(Jauge / JaugeMax * 10000, 1));
                    if "Value Date" = 0D then begin
                        "Value Date" := "Initial Entry Due Date";
                        Modify
                    end;
                until Next = 0;
            end;
    end;
}

