xmlport 50016 "Importation Avances"
{
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;
    FieldSeparator = ';';
    Caption = 'Importation Avances';
    TableSeparator = '<NewLine><NewLine>';
    //RecordSeparator = '<NewLine>';



    schema
    {
        textelement(Root)
        {
            tableelement(LoanAdvance; "Loan & Advance")   // Table 39001412
            {
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'LoanAdvance';

                textelement(Numero) { }
                textelement(Matricule) { }
                textelement(DateAv) { }
                textelement(Montant) { }

                trigger OnBeforeInsertRecord()
                var
                    DateAv2: date;
                    Montant2: Integer;
                begin
                    Evaluate(DateAv2, DateAv);
                    Evaluate(Montant2, Montant);
                    LoanAdvance.Init();
                    Clear(LoanAdvance);
                    LoanAdvance."No." := Numero;
                    LoanAdvance.VALIDATE(Employee, Matricule);
                    LoanAdvance.Type := 0;
                    LoanAdvance.VALIDATE("Date d'effet", DateAv2);
                    LoanAdvance.VALIDATE("Date fin Prêt", DateAv2);
                    LoanAdvance.VALIDATE(Amount, Montant2);
                    //
                    LoanAdvance."type amortissement" := 2;
                    LoanAdvance."Last Date Modified" := WorkDate;
                    LoanAdvance."User ID" := UserId;
                    LoanAdvance."Date Comptabilisation" := WorkDate;
                    //
                    //     LoanAdvance.INSERT(true);
                    //LoanAdvance.INSERT(false);
                end;

                trigger OnAfterInsertRecord()
                begin
                    LoanAdvance.INSERT(false);
                end;

                trigger OnPreXmlItem()
                begin
                    COMMIT;
                end;
            }
        }
    }

    var
    // Numero: Code[20];
    // Matricule: Code[20];
    // DateAv: Date;
    // Montant: Decimal;
}
