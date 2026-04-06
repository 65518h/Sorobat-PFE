Table 8001546 "BAR : Apply Ledger Entry"
{
    //GL2024  ID dans Nav 2009 : "8001614"
    // //RAPPRO GESWAY 26/06/02 Table des comptes bancaires suivis en rapprochement automatique (multi société)
    //                          Détermine l'appartenance d'un RIB à une société et son N° compte bancaire

    Caption = 'B.A.R. : Bank Account';
    DataPerCompany = false;
    //LookupPageID = 8001614;

    fields
    {
        field(1; "Bank Account Internal No."; Integer)
        {
            Caption = 'Bank Account Internal No.';
        }
    }

    keys
    {
        key(STG_Key1; "Bank Account Internal No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
        EcrBque: Record "BAR : Bank Entry";
    begin
    end;

    var
        CompteBancaire: Record "Bank Account";
        InterBancaire: Record "BAR : Interbank Code";
        Loi: Record "BAR : Reconciliation Rule";
        RapproCompte: Record "BAR : Bank Account";
        Fenetre: Dialog;
        Text10000: label '%1 %2  %4 %5 already exist.';
        Text10001: label 'You must modify Bank Code %1 to %2 in .';
        Text10002: label 'Bank Entry Update.';
        Text10003: label '%1 %2 doesn''t exist.';
}

