Table 8001539 "BAR : Bank Entry"
{
    //GL2024  ID dans Nav 2009 : "8001607"
    // //+RAP+RAPPRO GESWAY 26/06/02 Table des mouvements importés de la banque (multi société)
    //                 23/02/04 Adaptation IBAN -> Validate("Bank Account No.")
    // //RELEVE_DE_COMPTE OF 19/03/08 modif index 2 : BankStatementDate -> Company,Bank Account no,BankStatementDate

    Caption = 'B.A.R. : Bank Entry';
    DataPerCompany = false;
    //DrillDownPageID = 8001608;
    //LookupPageID = 8001608;

    fields
    {
        field(1; "Entry Code"; Text[2])
        {
            Caption = 'Entry Code';
        }
        field(3; "Bank Branch No."; Text[5])
        {
            Caption = 'Bank Branch No.';
        }
        field(8; "Internal Operation Code"; Text[4])
        {
            Caption = 'Internal Operation Code';
        }
        field(12; "Agency Code"; Text[5])
        {
            Caption = 'Agency Code';
        }
        field(17; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';

            trigger OnLookup()
            begin
                wCurrency.ChangeCompany(Company);
                if wCurrency.Get("Currency Code") then;
                if PAGE.RunModal(page::Currencies, wCurrency) = Action::LookupOK then begin
                    Validate("Currency Code", wCurrency.Code);
                end;
            end;

            trigger OnValidate()
            begin
                wCurrency.ChangeCompany(Company);
                wCurrency.Get("Currency Code");
            end;
        }
        field(20; "Number of Decimals"; Text[1])
        {
            Caption = 'Number of Decimals';
        }
        field(21; "Currency Source"; Text[1])
        {
            Caption = 'Source Currency';
        }
        field(22; "Account No."; Text[11])
        {
            Caption = 'Account No.';
        }
        field(33; "Interbank Code"; Text[2])
        {
            Caption = 'Interbank Code';
        }
        field(35; "Operation Date"; Date)
        {
            Caption = 'Operation Date';
        }
        field(41; "Discharge Reason Code"; Text[2])
        {
            Caption = 'Discharge Reason Code';
        }
        field(43; "Value Date"; Date)
        {
            Caption = 'Value Date';
        }
        field(49; Description; Text[31])
        {
            Caption = 'Description';
        }
        field(80; "Reserved Zone 2"; Text[2])
        {
            Caption = 'Reserved Zone 2';
        }
        field(82; "Document No."; Text[7])
        {
            Caption = 'Document No.';
        }
        field(89; "Indication of Commission"; Text[1])
        {
            Caption = 'Indication of Commission Without VAT';
        }
        field(90; "Indication of Indisponibility"; Text[1])
        {
            Caption = 'Indication of Indisponibility';
        }
        field(91; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(105; "Reference Zone"; Text[16])
        {
            Caption = 'Reference Zone';
        }
        field(200; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(201; Company; Text[30])
        {
            Caption = 'Company';

            trigger OnLookup()
            begin
                if wCompany.Get(Company) then;
                if PAGE.RunModal(0, wCompany) = Action::LookupOK then
                    Company := wCompany.Name;
            end;

            trigger OnValidate()
            begin
                wCompany.Get(Company);
            end;
        }
        field(202; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';

            trigger OnLookup()
            begin
                wBankAccount.ChangeCompany(Company);
                if wBankAccount.Get("Bank Account No.") then;
                if PAGE.RunModal(0, wBankAccount) = Action::LookupOK then
                    Validate("Bank Account No.", wBankAccount."No.");
            end;

            trigger OnValidate()
            var
                ParamCpta: Record "General Ledger Setup";
            begin
                Banque.ChangeCompany(Company);
                if Banque.Get("Bank Account No.") then begin
                    //"Currency Code" := Banque."Currency Code";
                    //"Bank Branch No." := Banque."Bank Branch No.";
                    //"Agency Code" := Banque."Agency Code";
                    //"Account No." := Banque."Bank Account No.";
                    Iban := Banque.Iban;
                    "SWIFT Code" := Banque."SWIFT Code";
                end;
            end;
        }
        field(203; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';

            trigger OnLookup()
            begin
                wReason.ChangeCompany(Company);
                if wReason.Get("Reason Code") then;
                if PAGE.RunModal(0, wReason) = Action::LookupOK then
                    Rec.Validate("Reason Code", wReason.Code);
            end;

            trigger OnValidate()
            begin
                wReason.ChangeCompany(Company);
                wReason.Get("Reason Code");
            end;
        }
        field(204; "Statement No. (Treatement)"; Code[20])
        {
            Caption = 'Statement No. (Treatement)';
            Description = '#9244';
        }
        field(205; "Description Complement"; Text[31])
        {
            Caption = 'Description Complement';
        }
        field(206; "Bank Statement Date"; Date)
        {
            Caption = 'Bank Statement Date';
        }
        field(207; "Statement Line No. (Treat.)"; Integer)
        {
            Caption = 'Statement Line No. (Treatement)';
        }
        field(208; Centralisable; Boolean)
        {
            Caption = 'Centralisable';
        }
        field(209; "Excluded From Cash Flow"; Boolean)
        {
            Caption = 'Excluded From Cash Flow';
        }
        field(210; Iban; Code[50])
        {
            Caption = 'IBAN';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(211; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; Company, "Bank Account No.", "Bank Statement Date")
        {
            SumIndexFields = Amount;
        }
        key(Key3; Company, "Bank Account No.", "Reason Code", "Operation Date", "Value Date", "Statement No. (Treatement)", "Statement Line No. (Treat.)")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Amount;
        }
        key(Key4; Company, "Bank Account No.", "Operation Date", "Reason Code", Amount)
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Amount;
        }
        key(Key5; Company, "Bank Account No.", "Value Date", "Reason Code", Amount)
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Amount;
        }
        key(Key6; Company, "Bank Account No.", Amount)
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Amount;
        }
        key(Key7; Company, "Bank Account No.", "Statement No. (Treatement)", "Statement Line No. (Treat.)")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Company = '' then
            Company := COMPANYNAME;
        if "Entry Code" = '' then
            "Entry Code" := '04';
        if "Entry No." = 0 then begin
            EcrImport.LockTable;
            EcrImport.Reset;
            if EcrImport.FindLast then;
            "Entry No." := EcrImport."Entry No." + 1;
        end;

        if "Reason Code" = '' then
            if not RechercheMotif(Company, "Bank Account No.", "Interbank Code", Amount) then
                Error(Text10000, "Interbank Code");
    end;

    trigger OnModify()
    begin
        if "Reason Code" = '' then
            if not RechercheMotif(Company, "Bank Account No.", "Interbank Code", Amount) then
                Error(Text10000, "Interbank Code");
    end;

    var
        Banque: Record "Bank Account";
        EcrImport: Record "BAR : Bank Entry";
        Text10000: label 'The interbank code does not have correspondence with the codes reason.';
        wCurrency: Record Currency;
        wCompany: Record Company;
        wBankAccount: Record "Bank Account";
        wReason: Record "Reason Code";
        Text8001600: label 'You have to complete the reason code of the %1 interbank code of the %2 company.';


    procedure RechercheMotif(Societe: Text[30]; NoCompte: Code[20]; InterBanc: Code[2]; Montant: Decimal) Trouve: Boolean
    var
        ParamRapproMotif: Record "BAR : Interbank Code";
    begin
        Trouve := false;
        ParamRapproMotif.Reset;
        ParamRapproMotif.ChangeCompany(Societe);
        ParamRapproMotif.SetRange("Bank Account No.", NoCompte);
        ParamRapproMotif.SetRange("Interbank Code", InterBanc);
        if Montant < 0 then
            ParamRapproMotif.SetFilter(Direction, '%1|%2', ParamRapproMotif.Direction::Both, ParamRapproMotif.Direction::Credit)
        else
            ParamRapproMotif.SetFilter(Direction, '%1|%2', ParamRapproMotif.Direction::Both, ParamRapproMotif.Direction::Debit);
        if ParamRapproMotif.Find('-') then begin
            if ParamRapproMotif."Reason Code" = '' then
                Error(StrSubstNo(Text8001600, InterBanc, Societe));
            "Reason Code" := ParamRapproMotif."Reason Code";
            Centralisable := ParamRapproMotif.Centralize;
            Trouve := true;
        end;
    end;
}

