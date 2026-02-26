Table 8001540 "Stock Setup"
{
    //GL2024  ID dans Nav 2009 : "8001608"
    // //+RAP+VMP GESWAY 01/08/02 Table 8001608 "Stock Setup"

    Caption = 'Stock Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Costing Method"; Option)
        {
            Caption = 'Costing Method';
            OptionCaption = 'FIFO,LIFO,Average';
            OptionMembers = FIFO,LIFO,"Average";

            trigger OnValidate()
            begin
                if StockLine.Find('-') then
                    Error(Text001, FieldCaption("Costing Method"));
            end;
        }
        field(3; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(4; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting Nos.';
            TableRelation = "No. Series";
        }
        field(5; "Value Date Calculation"; DateFormula)
        {
            Caption = 'Value Date Calculation';
        }
        field(6; "Call Description"; Text[20])
        {
            Caption = 'Calls Description';
        }
        field(7; "Put Description"; Text[20])
        {
            Caption = 'Puts Description';
        }
        field(8; "Bank Charges Description"; Text[20])
        {
            Caption = 'Bank Charges Description';
        }
        field(9; "Stock No. Series"; Code[10])
        {
            Caption = 'Stock Nos.';
            TableRelation = "No. Series";
        }
        field(10; "Default Home Page"; Text[250])
        {
            Caption = 'Default Home Page';
        }
        field(11; "Email Confirmation Text Code"; Code[10])
        {
            Caption = 'Email Confirmation Text Code';
            TableRelation = "Standard Text";
        }
        field(12; "Reason Code Mandatory"; Boolean)
        {
            Caption = 'Reason Code Mandatory';
        }
        field(13; "Job No. Mandatory"; Boolean)
        {
        }
        field(14; "Use Journal Template"; Boolean)
        {
            Caption = 'Use Journal Template';
        }
        field(15; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(16; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(17; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(18; "Reason Value Posting"; Option)
        {
            Caption = 'Reason Code Value Posting';
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        StockLine: Record "Stock Line";
        Text001: label 'You cannot change %1 because there is existing transactions.';
}

