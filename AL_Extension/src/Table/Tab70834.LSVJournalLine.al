Table 70834 "LSV Journal Line"
{
    //GL2024  ID dans Nav 2009 : "3010834"
    // <changelog>
    //   <add id="CH2810" dev="SRYSER" date="2006-04-15" area="LS"
    //     releaseversion="CH4.00.03" feature="PS9380">
    //     LSV Plus redesign</add>
    //   <change id="CH2812" dev="SRYSER" date="2006-04-15" area="LS"
    //     baseversion="CH4.00.03" releaseversion="CH4.00.03" feature="PS18541">
    //     Changes around LSV Status</change>
    //   <change id="CH2820" dev="SRYSER" date="2006-07-27" area="LS"
    //     baseversion="CH4.00.03" releaseversion="CH4.00.03" feature="PS18586">
    //     OnDelete, dont update Customer Ledger Entry</change>
    //   <change id="CH2821" dev="sryser" date="2006-08-07" area="LS"
    //     baseversion="CH4.00.03" releaseversion="CH5.00" feature="PSCORS1045">
    //     Changed CustLedgEntry.SetCurrentkey because of W1 change</change>
    // </changelog>

    Caption = 'LSV Journal Line';
    // DrillDownPageID = 3010835;
    //LookupPageID = 3010835;
    Permissions = TableData "Cust. Ledger Entry" = rm;

    fields
    {
        field(1; "LSV Journal No."; Integer)
        {
            Caption = 'LSV Journal No.';
            TableRelation = "LSV Journal"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if "Customer No." <> xRec."Customer No." then begin
                    "Applies-to Doc. No." := '';
                    "Cust. Ledg. Entry No." := 0;
                end;
            end;
        }
        field(7; "Collection Amount"; Decimal)
        {
            Caption = 'Collection Amount';
            Editable = false;
        }
        field(8; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(9; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(11; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            begin
                TestField("Customer No.");
                LSVJournal.Get("LSV Journal No.");
                CustLedgEntry.Reset;
                CustLedgEntry.FilterGroup := 2;
                if (LSVJournal."LSV Status" = LSVJournal."lsv status"::Edit) and ("Applies-to Doc. No." = '') then begin
                    CustLedgEntry.SetCurrentkey("Customer No.", Open, Positive, "Due Date", "Currency Code");
                    CustLedgEntry.SetRange("Customer No.", "Customer No.");
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("On Hold", '');
                    GLSetup.Get;
                    if not (LSVJournal."Currency Code" = GLSetup."LCY Code") then
                        CustLedgEntry.SetRange("Currency Code", LSVJournal."Currency Code");
                end else begin
                    // CH2821.BEGIN
                    CustLedgEntry.SetCurrentkey("Document No.");
                    // CH2821.END
                    CustLedgEntry.SetRange("Document Type", CustLedgEntry."document type"::Invoice);
                    CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                end;

                if CustLedgEntry.Get("Cust. Ledg. Entry No.") then;
                CustLedgEntry.FilterGroup := 0;
                if PAGE.RunModal(0, CustLedgEntry) = Action::LookupOK then begin
                    if CustLedgEntry."Entry No." = 0 then
                        exit;
                    "Applies-to Doc. No." := CustLedgEntry."Document No.";
                    "Cust. Ledg. Entry No." := CustLedgEntry."Entry No.";
                    CompletePmtSuggestLines(Rec);
                end;
            end;

            trigger OnValidate()
            begin
                if "Applies-to Doc. No." = '' then
                    exit;

                // CH2821.BEGIN
                CustLedgEntry.SetCurrentkey("Document No.");
                // CH2821.END
                CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                if not CustLedgEntry.Find('-') then
                    Error(Text000);

                "Cust. Ledg. Entry No." := CustLedgEntry."Entry No.";
                CompletePmtSuggestLines(Rec);
            end;
        }
        field(13; "Cust. Ledg. Entry No."; Integer)
        {
            Caption = 'Cust. Ledg. Entry No.';
            TableRelation = "Cust. Ledger Entry"."Entry No.";

            trigger OnLookup()
            begin
                TestField("Customer No.");
                LSVJournal.Get("LSV Journal No.");
                CustLedgEntry.FilterGroup := 2;
                if (LSVJournal."LSV Status" = LSVJournal."lsv status"::Edit) and ("Cust. Ledg. Entry No." = 0) then begin
                    CustLedgEntry.SetCurrentkey("Customer No.", Open, Positive, "Due Date", "Currency Code");
                    CustLedgEntry.SetRange("Customer No.", "Customer No.");
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("On Hold", '');
                    LSVJournal.Get("LSV Journal No.");
                    GLSetup.Get;
                    if not (LSVJournal."Currency Code" = GLSetup."LCY Code") then
                        CustLedgEntry.SetRange("Currency Code", LSVJournal."Currency Code");
                end else begin
                    CustLedgEntry.SetCurrentkey("Customer No.", Open, Positive, "Due Date", "Currency Code");
                    CustLedgEntry.SetRange("Customer No.", "Customer No.");
                    CustLedgEntry.SetRange("Entry No.", "Cust. Ledg. Entry No.");
                end;

                if CustLedgEntry.Get("Cust. Ledg. Entry No.") then;
                CustLedgEntry.FilterGroup := 0;
                if PAGE.RunModal(0, CustLedgEntry) = Action::LookupOK then begin
                    "Applies-to Doc. No." := CustLedgEntry."Document No.";
                    "Cust. Ledg. Entry No." := CustLedgEntry."Entry No.";
                    "Customer No." := CustLedgEntry."Customer No.";
                    CompletePmtSuggestLines(Rec);
                end;
            end;

            trigger OnValidate()
            begin
                if "Cust. Ledg. Entry No." = 0 then
                    exit;

                CustLedgEntry.Reset;
                CustLedgEntry.FilterGroup := 2;
                CustLedgEntry.SetCurrentkey("Entry No.");
                CustLedgEntry.SetRange("Entry No.", "Cust. Ledg. Entry No.");
                if CustLedgEntry.Get("Cust. Ledg. Entry No.") then;
                CustLedgEntry.FilterGroup := 0;
                CompletePmtSuggestLines(Rec);
            end;
        }
        field(15; "LSV Status"; Option)
        {
            Caption = 'LSV Status';
            OptionCaption = 'Open,Closed by ESR,Transferred to Pmt. Journal,Rejected';
            OptionMembers = Open,"Closed by ESR","Transferred to Pmt. Journal",Rejected;

            trigger OnValidate()
            begin
                // CH2812.BEGIN
                LSVJournal.Get("LSV Journal No.");
                if LSVJournal."LSV Status" <> LSVJournal."lsv status"::"File Created" then
                    Error(Text005);

                if xRec."LSV Status" >= "lsv status"::"Closed by ESR" then
                    Error(Text003);

                if Rec."LSV Status" in ["lsv status"::"Closed by ESR", "lsv status"::"Transferred to Pmt. Journal"] then
                    Error(Text003);

                if Rec."LSV Status" = "lsv status"::Rejected then
                    UpdateCustLedgEntry("Cust. Ledg. Entry No.", 0, 3);
                // CH2812.END
            end;
        }
        field(20; "Remaining Amount"; Decimal)
        {
            Caption = 'Remaining Amount';
            Editable = false;
        }
        field(21; "Pmt. Discount"; Decimal)
        {
            Caption = 'Pmt. Discount';
            Editable = false;
        }
        field(80; "Last Modified By"; Code[20])
        {
            Caption = 'Last Modified By';
            Editable = false;
        }
    }

    keys
    {
        key(STG_Key1; "LSV Journal No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Collection Amount";
        }
        key(STG_Key2; "Applies-to Doc. No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // CH2812.BEGIN
        LSVJournal.Get("LSV Journal No.");
        if LSVJournal."LSV Status" = LSVJournal."lsv status"::"File Created" then
            Error(Text004);
        // CH2820.BEGIN
        if LSVJournal."LSV Status" <> LSVJournal."lsv status"::Finished then begin
            UpdateCustLedgEntry("Cust. Ledg. Entry No.", 0, 3);

            LSVJournal.Get("LSV Journal No.");
            LSVJournal.Validate("LSV Status");
            LSVJournal.Modify;
        end;
        // CH2820.END
        // CH2812.END
    end;

    trigger OnInsert()
    begin
        "Last Modified By" := UserId;
        UpdateCustLedgEntry("Cust. Ledg. Entry No.", "LSV Journal No.", 1);

        LSVJournalLine2.SetRange("LSV Journal No.", "LSV Journal No.");
        if LSVJournalLine2.Find('+') then
            "Line No." := LSVJournalLine2."Line No." + 1
        else
            "Line No." := 1;
    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
        // CH2812.BEGIN
        if "LSV Status" <> "lsv status"::Rejected then
            UpdateCustLedgEntry("Cust. Ledg. Entry No.", "LSV Journal No.", 2);

        LSVJournal.Get("LSV Journal No.");
        LSVJournal.Validate("LSV Status");
        LSVJournal.Modify;
        // CH2812.END
    end;

    var
        Text000: label 'This value does not exist.';
        Text001: label 'The %1 entry is set on hold by %2.';
        Text002: label 'For this collection only Currency %1 is allowed.';
        Text003: label 'This change is not allowed.';
        Text004: label 'Delete not allowed because File has already been created.';
        Text005: label 'Change only allowed when File has already been created.';
        CustLedgEntry: Record "Cust. Ledger Entry";
        LSVJournal: Record "LSV Journal";
        LSVJournalLine2: Record "LSV Journal Line";
        Customer: Record Customer;
        GLSetup: Record "General Ledger Setup";

    local procedure UpdateCustLedgEntry(CustLedgEntryNo: Integer; LSVNo: Integer; Caller: Integer)
    begin
        CustLedgEntry.Reset;
        if not CustLedgEntry.Get(CustLedgEntryNo) then
            exit;

        case Caller of
            1:
                begin
                    if CustLedgEntry."On Hold" <> '' then begin
                        Rec := xRec;
                        Error(Text001, CustLedgEntry.TableCaption, CustLedgEntry."On Hold");
                    end;
                    CustLedgEntry."On Hold" := 'LSV';
                    CustLedgEntry."LSV No." := LSVNo;

                end;
            2:
                begin
                    CustLedgEntry."On Hold" := 'LSV';
                    CustLedgEntry."LSV No." := LSVNo;
                end;
            3:
                begin
                    CustLedgEntry."On Hold" := '';
                    CustLedgEntry."LSV No." := 0;
                end;

        end;
        CustLedgEntry.Modify;
    end;


    procedure CompletePmtSuggestLines(var ActLSVJournalLine: Record "LSV Journal Line")
    var
        ActCustLedgEntry: Record "Cust. Ledger Entry";
    begin
        ActCustLedgEntry.Get(ActLSVJournalLine."Cust. Ledg. Entry No.");

        GLSetup.Get;
        if ActCustLedgEntry."Currency Code" = '' then
            ActCustLedgEntry."Currency Code" := GLSetup."LCY Code";

        LSVJournal.Get("LSV Journal No.");
        if LSVJournal."Currency Code" <> ActCustLedgEntry."Currency Code" then
            Error(Text002, LSVJournal."Currency Code");

        ActCustLedgEntry.CalcFields("Remaining Amount");
        ActLSVJournalLine."Remaining Amount" := ActCustLedgEntry."Remaining Amount";
        ActLSVJournalLine."Pmt. Discount" := ActCustLedgEntry."Original Pmt. Disc. Possible";
        ActLSVJournalLine."Collection Amount" := ActCustLedgEntry."Remaining Amount" - CustLedgEntry."Original Pmt. Disc. Possible";

        "Customer No." := CustLedgEntry."Customer No.";
        Customer.Get("Customer No.");
        Name := Customer.Name;

        if "Applies-to Doc. No." = '' then
            "Applies-to Doc. No." := CustLedgEntry."Document No.";

        if "Cust. Ledg. Entry No." = 0 then
            "Cust. Ledg. Entry No." := CustLedgEntry."Entry No.";
    end;
}

