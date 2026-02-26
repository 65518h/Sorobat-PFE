Table 8001533 "BAR : Bank Account"
{
    //GL2024  ID dans Nav 2009 : "8001601"
    // //+RAP+RAPPRO GESWAY 26/06/02 Table des comptes bancaires suivis en rapprochement automatique (multi société)
    //                          Détermine l'appartenance d'un RIB à une société et son N° compte bancaire
    //                 23/02/04 Supprime champs ancien rib Bank "Branch No.","Agency Code","Bank Account" (champs 6,7,8)
    //                          Ajout champs IBAN et "SWIFT Code"
    //                          Modif clé : Bank Branch No.,Agency Code,Bank Account No.,Company,Bank Account Code
    //                            devient IBAN,Company,Bank Account Code

    Caption = 'B.A.R. : Bank Account';
    DataPerCompany = false;
    // LookupPageID = 8001614;

    fields
    {
        field(1; "Bank Account Internal No."; Integer)
        {
            Caption = 'Bank Account Internal No.';
        }
        field(3; Company; Text[30])
        {
            Caption = 'Company';
            TableRelation = Company;

            trigger OnValidate()
            begin
                if "Bank Account No." <> '' then
                    Validate("Bank Account No.");
            end;
        }
        field(4; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';

            trigger OnLookup()
            begin
                if Company <> '' then
                    CompteBancaire.ChangeCompany(Company);
                if PAGE.RunModal(page::"Bank Account List", CompteBancaire) = Action::LookupOK then begin
                    "Bank Account No." := CompteBancaire."No.";
                    Validate("Bank Account No.");
                end;
            end;

            trigger OnValidate()
            begin
                if Company <> '' then
                    CompteBancaire.ChangeCompany(Company);
                if not CompteBancaire.Get("Bank Account No.") then
                    Error(Text10003, FieldName("Bank Account No."), "Bank Account No.")
                else begin
                    Validate(Iban, CompteBancaire.Iban);
                    "SWIFT Code" := CompteBancaire."SWIFT Code";
                end;
            end;
        }
        field(5; "Excluded From Import"; Boolean)
        {
            Caption = 'Excluded From Import';
        }
        field(6; "Bank Branch No."; Text[5])
        {
            Caption = 'Bank Branch No.';
        }
        field(7; "Agency Code"; Text[5])
        {
            Caption = 'Agency Code';
        }
        field(8; "Account No."; Text[11])
        {
            Caption = 'Bank Account No.';
        }
        field(9; "Net Operation"; Decimal)
        {
            CalcFormula = sum("BAR : Bank Entry".Amount where("Operation Date" = field("Date Filter"),
                                                               "Bank Account No." = field("Bank Account No."),
                                                               Company = field(Company),
                                                               "Reason Code" = field("Reason Filter"),
                                                               "Statement Line No. (Treat.)" = field(filter("Statement Line No. Filter"))));
            Caption = 'Net Operation';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Net Value"; Decimal)
        {
            CalcFormula = sum("BAR : Bank Entry".Amount where("Value Date" = field("Date Filter"),
                                                               "Bank Account No." = field("Bank Account No."),
                                                               Company = field(Company),
                                                               "Reason Code" = field("Reason Filter"),
                                                               "Statement Line No. (Treat.)" = field(filter("Statement Line No. Filter"))));
            Caption = 'Net Value';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(12; "Reason Filter"; Code[10])
        {
            Caption = 'Reason Filter';
            FieldClass = FlowFilter;
            TableRelation = "Reason Code";
        }
        field(13; "Statement Line No. Filter"; Integer)
        {
            Caption = 'Statement Line No. Filter';
            FieldClass = FlowFilter;
        }
        field(14; "Excluded From Cash Flow"; Boolean)
        {
            Caption = 'Excluded From Cash Flow';
        }
        field(15; Iban; Code[50])
        {
            Caption = 'IBAN';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.CheckIBAN(Iban);
                MakeOldRIB;
            end;
        }
        field(16; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
        }
        field(17; "Balance at Date"; Decimal)
        {
            CalcFormula = sum("BAR : Bank Entry".Amount where(Company = field(Company),
                                                               "Bank Account No." = field("Bank Account No."),
                                                               "Operation Date" = field(upperlimit("Date Filter"))));
            Caption = 'Balance at Date';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Bank Account Internal No.")
        {
            Clustered = true;
        }
        key(Key2; Iban, Company, "Bank Account No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RapproCompte.Reset;
        RapproCompte.SetRange(Iban, Iban);
        RapproCompte.SetRange(Company, Company);
        RapproCompte.SetRange("Bank Account No.", "Bank Account No.");
        if not RapproCompte.Find('-') then begin
            InterBancaire.SetRange("Bank Account No.", "Bank Account No.");
            InterBancaire.DeleteAll(true);

            Loi.SetRange("Bank Account No.", "Bank Account No.");
            Loi.DeleteAll(true);
        end;
    end;

    trigger OnInsert()
    begin
        RapproCompte.SetRange(Iban, Iban);
        /*
        RapproCompte.SETRANGE(Company,Company);
        RapproCompte.SETRANGE("Bank Account No.","Bank Account No.");
        */
        if (Iban <> '') and RapproCompte.Find('-') then
            Error(Text001, Iban, Company, "Bank Account No.");

    end;

    trigger OnModify()
    var
        EcrBque: Record "BAR : Bank Entry";
    begin
        if (xRec."Excluded From Import" = "Excluded From Import") and
           (xRec."Excluded From Cash Flow" = "Excluded From Cash Flow") then begin
            RapproCompte.SetRange(Iban, Iban);
            /*
              RapproCompte.SETRANGE(Company,Company);
              RapproCompte.SETRANGE("Bank Account No.","Bank Account No.");
            */
            RapproCompte.SetFilter("Bank Account Internal No.", '<>%1', "Bank Account Internal No.");
            if (Iban <> '') and RapproCompte.Find('-') then
                Error(Text001, Iban, Company, "Bank Account No.");

            if xRec."Bank Account No." <> "Bank Account No." then begin
                InterBancaire.SetRange("Bank Account No.", xRec."Bank Account No.");
                if InterBancaire.Find('-') then
                    Message(Text10001, xRec."Bank Account No.", Rec."Bank Account No.", InterBancaire.TableName);

                Loi.SetRange("Bank Account No.", xRec."Bank Account No.");
                if Loi.Find('-') then
                    Message(Text10001, xRec."Bank Account No.", Rec."Bank Account No.", Loi.TableName);
            end;

        end;
        if xRec."Excluded From Cash Flow" <> "Excluded From Cash Flow" then begin
            Fenetre.Open(Text10002);
            EcrBque.SetCurrentkey(Company, "Bank Account No.");
            EcrBque.SetRange(Company, Company);
            EcrBque.SetRange("Bank Account No.", "Bank Account No.");
            EcrBque.ModifyAll("Excluded From Cash Flow", "Excluded From Cash Flow");
            Fenetre.Close;
        end;

    end;

    var
        CompteBancaire: Record "Bank Account";
        InterBancaire: Record "BAR : Interbank Code";
        Loi: Record "BAR : Reconciliation Rule";
        RapproCompte: Record "BAR : Bank Account";
        Fenetre: Dialog;
        Text001: label '%1 %2 %3 already exist.';
        Text10001: label 'You must modify Bank Code %1 to %2 in %3.';
        Text10002: label 'Bank Entry Update.';
        Text10003: label '%1 %2 does not exist.';


    procedure MakeOldRIB()
    var
        TempIBAN: Text[50];
    begin
        TempIBAN := DelChr(Iban);
        "Bank Branch No." := CopyStr(TempIBAN, 5, 5);
        "Agency Code" := CopyStr(TempIBAN, 10, 5);
        "Account No." := CopyStr(TempIBAN, 15, 11);
    end;
}

