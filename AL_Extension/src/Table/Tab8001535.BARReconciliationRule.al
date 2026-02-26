Table 8001535 "BAR : Reconciliation Rule"
{
    //GL2024  ID dans Nav 2009 : "8001603"
    // #9232 AC 19/12/11
    // //+RAP+RAPPRO GESWAY 26/06/02 Table des lois de rapprochement bancaire à appliquer
    //                          par société et par N° compte bancaire (multi société)

    Caption = 'B.A.R. : Reconciliation Rule';

    fields
    {
        field(2; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(3; "Application Order"; Integer)
        {
            Caption = 'Application Order';
            Editable = false;
        }
        field(4; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";

            trigger OnValidate()
            begin
                if Motif.Get("Reason Code") then
                    Description := Motif.Description;
            end;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; "Type of Date"; Option)
        {
            Caption = 'Type of Date';
            OptionCaption = 'Operation,Value';
            OptionMembers = Operation,Value;
        }
        field(7; "Confidence interval"; DateFormula)
        {
            Caption = 'Confidence interval';
            InitValue = '10D';
        }
        field(8; "Reconciliation Mode"; Text[30])
        {
            Caption = 'Reconciliation Mode';
            TableRelation = "BAR : Reconciliation Mode"."Reconciliation Mode";
        }
    }

    keys
    {
        key(Key1; "Bank Account No.", "Reason Code", "Application Order")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField("Reason Code");
        TestField("Application Order");
        if "Reconciliation Mode" = '' then
            if ModeRappro.Find('-') then
                "Reconciliation Mode" := ModeRappro."Reconciliation Mode";
    end;

    trigger OnModify()
    begin
        TestField("Reason Code");
        TestField("Application Order");
        TestField("Reconciliation Mode");
    end;

    trigger OnRename()
    begin
        TestField("Reason Code");
        TestField("Application Order");
        TestField("Reconciliation Mode");
    end;

    var
        Motif: Record "Reason Code";
        ModeRappro: Record "BAR : Reconciliation Mode";
        ParamRappro: Record "BAR : Setup";
        Loi: Record "BAR : Reconciliation Rule";
}

