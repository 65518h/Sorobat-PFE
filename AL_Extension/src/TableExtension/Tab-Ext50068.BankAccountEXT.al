TableExtension 50068 "Bank AccountEXT" extends "Bank Account"
{
    fields
    {
        modify("Net Change (LCY)")
        {
            Description = 'Modification du CalcFormula';
        }

        modify("Balance at Date")
        {
            Description = 'Modification du CalcFormula';
        }

        modify("Balance at Date (LCY)")
        {
            Description = 'Modification du CalcFormula';
        }

        modify("Debit Amount")
        {
            Description = 'Modification du CalcFormula';
        }
        modify("Credit Amount")
        {
            Description = 'Modification du CalcFormula';
        }
        modify("Debit Amount (LCY)")
        {
            Description = 'Modification du CalcFormula';
        }


        modify("Bank Branch No.")
        {


            Caption = 'Nom Banque Etat';
        }


        field(50000; "Source code"; Code[10])
        {
            Caption = 'Code journal';
            Description = 'MZK 24/12/09 SADIR';
            TableRelation = "Source Code".Code;
        }
        field(50001; "Ancien Code"; Code[20])
        {
        }
        field(50002; Synchronise; Boolean)
        {
        }
        field(50003; RIB; Code[30])
        {
        }
        field(50004; "Num Sequence Syncro"; Integer)
        {
        }
        field(50005; "Souche N° Banque"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50010; "Solde Caisse Extra"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Payment Line"."Amount (LCY)" where("Payment Class" = filter('ALIMENTATION CAISSE' | 'Decaiss Espèce'),
                                                                   "Copied To No." = filter(''),
                                                                   "Status No." = filter(8000 | 50000)));
            Caption = 'Solde Caisse Extra';
            Description = 'BSK';
            FieldClass = FlowField;
        }
        field(50100; "Type Compte"; Option)
        {
            Caption = 'Type Compte';
            Description = 'BSK 22/04/2012';
            OptionMembers = Banque,Caisse,"Caisse Ex","Mandat Trésor";
        }

        field(60001; Agence; Text[30])
        {
            Caption = 'Agency Code';
            InitValue = '00000';

            trigger OnValidate()
            begin
                if StrLen(Agence) < 3 then
                    Agence := PadStr('', 3 - StrLen(Agence), '0') + Agence;
                "RIB Checked" := RIBKey.Check("Bank Branch No.", Agence, "Bank Account No.", "RIB Key");
            end;
        }
        field(60002; "RIB Key1"; Integer)
        {
            Caption = 'RIB Key';

            trigger OnValidate()
            begin
                "RIB Checked" := RIBKey.Check("Bank Branch No.", Agence, "Bank Account No.", "RIB Key");
            end;
        }
        field(60003; "RIB Checked1"; Boolean)
        {
            Caption = 'RIB Checked';
            Editable = false;
        }
        field(60004; "National Issuer No.1"; Code[6])
        {
            Caption = 'National Issuer No.';
            Numeric = true;

            trigger OnValidate()
            begin
                if (StrLen("National Issuer No.") > 0) and (StrLen("National Issuer No.") < 6) then
                    Error(Text10800);
            end;
        }
        field(2000040; "Protocol No."; Text[3])
        {
            Caption = 'Protocol No.';
        }
        field(2000041; "Version Code"; Text[1])
        {
            Caption = 'Version Code';
        }
        field(2000042; SubAccount; Text[10])
        {
            Caption = 'SubAccount';
        }
        field(8001401; "Bank Type"; Option)
        {
            Caption = 'Bank Type';
            OptionCaption = ' ,Bill To Pay,Bill To Receive,VCOM';
            OptionMembers = " ",Payable,Receivable;

            trigger OnValidate()
            begin
                if "Bank Type" <> 0 then begin
                    TestField("LCR file name", '');
                    TestField("LCR Transfer No.", '');
                end;
            end;
        }
        field(8001405; "Reason Filter"; Code[10])
        {
            Caption = 'Reason Filter';
            FieldClass = FlowFilter;
            TableRelation = "Reason Code";
        }
        field(8001406; "Remaining Amount"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry"."Remaining Amount" where(Open = const(true),
                                                                                    "Bank Account No." = field("No."),
                                                                                    "Posting Date" = field("Date Filter"),
                                                                                    "Due Date" = field("Due Date Filter")));
            Caption = 'Remaining Amount';
            FieldClass = FlowField;
        }
        field(8001407; "Remaining Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where(Open = const(true),
                                                                                "Bank Account No." = field("No."),
                                                                                "Posting Date" = field("Date Filter"),
                                                                                "Due Date" = field("Due Date Filter")));
            Caption = 'Remaining Amount (LCY)';
            FieldClass = FlowField;
        }
        field(8001408; "Due Date Filter"; Date)
        {
            Caption = 'Due Date Filter';
            FieldClass = FlowFilter;
        }
        field(8001409; "LCR file name"; Text[250])
        {
            Caption = 'LCR File Name';

            trigger OnValidate()
            begin
                if "LCR file name" <> '' then
                    TestField("Bank Type", 0);
            end;
        }
        field(8001410; "LCR Transfer No."; Code[10])
        {
            Caption = 'LCR Transfer No.';

            trigger OnValidate()
            begin
                if "LCR Transfer No." <> '' then
                    TestField("Bank Type", 0);
            end;
        }
        field(8001600; "Open Filter"; Boolean)
        {
            Caption = 'Open Filter';
            FieldClass = FlowFilter;
        }
        field(8001601; "Simulation Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("Gen. Journal Line"."Amount (LCY)" where("Account Type" = const("Bank Account"),
                                                                        "Journal Template Name" = field("Journal Template Name Filter"),
                                                                        "Account No." = field("No."),
                                                                        "Value Date" = field("Due Date Filter"),
                                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Simulation Amount (LCY)';
            FieldClass = FlowField;
        }
        field(8001602; "Journal Template Name Filter"; Code[10])
        {
            Caption = 'Journal Template Name Filter';
            FieldClass = FlowFilter;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(8003900; "Guarantee Celling"; Decimal)
        {
            //blankzero = true;
            Caption = 'Guarantee Celling';
        }
        field(8003901; "Guarantee in Progress"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Guarantee Entry"."Amount (LCY)" where("Bank Account No." = field("No."),
                                                                      "Closed Date" = field("Due Date Filter"),
                                                                      "Posting Date" = field("Date Filter"),
                                                                      Open = const(true)));
            Caption = 'Guarantee in Progress';
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key6; Synchronise)
        {
        }
    }
    trigger OnAfterInsert()
    begin
        // HJ ARRETER LE 21 JANV 2013 IF NOT InsertFromContact THEN     UpdateContFromBank.OnInsert(Rec);
    end;


    var
        RIBKey: Codeunit "RIB Key";
        Text10800: label 'You must enter 6 positions in this field.';
}

