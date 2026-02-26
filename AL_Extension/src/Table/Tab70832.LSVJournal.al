Table 70832 "LSV Journal"
{
    //GL2024  ID dans Nav 2009 : "3010832"
    // <changelog>
    //   <add id="CH9500" dev="SRYSER" date="2005-09-21" area="LS"
    //     releaseversion="CH4.00.02"  request="CH-START-400SP2-RENU">
    //     Renumber of Existing Functionality
    //     Swiss Payment Add-On (LSV)</add>
    //   <change id="CH2810" dev="SRYSER" date="2006-04-15" area="LS"
    //     baseversion="CH4.00.02" releaseversion="CH4.00.03" feature="PS9380">
    //     LSV Plus redesign</change>
    //   <change id="CH2820" dev="SRYSER" date="2006-07-27" area="LS"
    //     baseversion="CH4.00.03" releaseversion="CH4.00.03" feature="PS18586">
    //     Creating No. checks now also in CustLedgerEntry</change>
    //   <change id="CH2821" dev="SRYSER" date="2006-10-02" area="LS"
    //     baseversion="CH4.00.03" releaseversion="CH5.00" feature="NAVCORS4665">
    //     Field 100 extended to 20</change>
    //   <change id="CH2822" dev="SRYSER" date="2006-10-02" area="LS"
    //     baseversion="CH5.00" releaseversion="CH5.00" feature="PSCORS593">
    //     Field 110 and 120 removed</change>
    // </changelog>

    Caption = 'LSV Journal';
    //  DrillDownPageID = 3010832;
    //LookupPageID = 3010832;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
        }
        field(2; "LSV Journal Description"; Text[150])
        {
            Caption = 'LSV Journal Description';
        }
        field(5; "LSV Status"; Option)
        {
            Caption = 'LSV Status';
            Editable = false;
            OptionCaption = 'Edit,Released,File Created,Finished';
            OptionMembers = Edit,Released,"File Created",Finished;

            trigger OnValidate()
            begin
                if "LSV Status" in ["lsv status"::"File Created", "lsv status"::Finished] then begin
                    LSVJournalLine.Reset;
                    LSVJournalLine.SetRange("LSV Journal No.", "No.");
                    LSVJournalLine.SetRange("LSV Status", LSVJournalLine."lsv status"::Open);
                    if LSVJournalLine.Find('-') then
                        "LSV Status" := "lsv status"::"File Created"
                    else
                        "LSV Status" := "lsv status"::Finished;
                end;
            end;
        }
        field(10; "Credit Date"; Date)
        {
            Caption = 'Credit Date';
        }
        field(12; "LSV Bank Code"; Code[20])
        {
            Caption = 'LSV Bank Code';
            TableRelation = "LSV Setup";

            trigger OnValidate()
            begin
                if "LSV Bank Code" <> '' then begin
                    LSVSetup.Get("LSV Bank Code");
                    "Currency Code" := LSVSetup."LSV Currency Code";
                end;
            end;
        }
        field(30; "Collection Completed On"; Date)
        {
            Caption = 'Collection Completed On';
        }
        field(40; "File Written On"; Date)
        {
            Caption = 'File Written On';
        }
        field(50; "No. Of Entries"; Integer)
        {
            Caption = 'No. Of Entries';
        }
        field(51; "No. Of Entries Plus"; Integer)
        {
            CalcFormula = count("LSV Journal Line" where("LSV Journal No." = field("No.")));
            Caption = 'No. Of Entries Plus';
            FieldClass = FlowField;
        }
        field(52; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(53; "Amount Plus"; Decimal)
        {
            CalcFormula = sum("LSV Journal Line"."Collection Amount" where("LSV Journal No." = field("No.")));
            Caption = 'Amount Plus';
            FieldClass = FlowField;
        }
        field(54; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(100; "Collection Completed By"; Code[20])
        {
            Caption = 'Collection Completed By';
            TableRelation = User;
        }
        field(130; "DebitDirect Orderno."; Code[2])
        {
            Caption = 'DebitDirect Orderno.';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if not ("LSV Status" in ["lsv status"::Edit, "lsv status"::Finished]) then
            Error(Text001);

        LSVJournalLine.Reset;
        LSVJournalLine.SetRange("LSV Journal No.", "No.");
        LSVJournalLine.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        if LsvJournal2.Find('+') then
            "No." := LsvJournal2."No." + 1
        else
            "No." := 1;

        // CH2820.BEGIN
        CustLedgerEntry.Reset;
        CustLedgerEntry.SetCurrentkey("LSV No.");
        if CustLedgerEntry.Find('+') then begin
            if CustLedgerEntry."LSV No." > "No." then
                "No." := CustLedgerEntry."LSV No." + 1
        end;
        // CH2820.BEGIN
    end;

    var
        LsvJournal2: Record "LSV Journal";
        LSVSetup: Record "LSV Setup";
        LSVJournalLine: Record "LSV Journal Line";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Text001: label 'You can only delete LSV Journal entries with Status edit or finished.';
}

