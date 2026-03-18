Table 8001534 "BAR : Interbank Code"
{
    //GL2024  ID dans Nav 2009 : "8001602"
    // //+RAP+RAPPRO GESWAY 26/06/02 Table de correspondance du code interbancaire et du code motif
    //                          par société et par N° compte bancaire (multi société)

    Caption = 'B.A.R. : Interbank Code';

    fields
    {
        field(2; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(3; "Interbank Code"; Code[2])
        {
            Caption = 'Interbank Code';
        }
        field(4; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(5; Centralize; Boolean)
        {
            Caption = 'Centralize';
        }
        field(6; Direction; Option)
        {
            Caption = 'Direction';
            InitValue = Both;
            OptionCaption = 'Debit,Credit,Both';
            OptionMembers = Debit,Credit,Both;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(STG_Key1; "Bank Account No.", "Interbank Code", Direction)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField("Interbank Code");
        if "Bank Account No." = '' then begin
            if not ParamRappro.Find('-') or (ParamRappro."Default Bank No." = '') then
                Error(Text10000);
            "Bank Account No." := ParamRappro."Default Bank No.";
        end;
    end;

    trigger OnModify()
    begin
        if xRec."Reason Code" <> '' then
            TestField("Reason Code");
    end;

    trigger OnRename()
    begin
        if xRec."Reason Code" <> '' then
            TestField("Reason Code");
    end;

    var
        Motif: Record "Reason Code";
        ParamRappro: Record "BAR : Setup";
        Text10000: label 'You must inform the default bank in reconciliation setup.';
}

