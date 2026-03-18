TableExtension 50202 "Payment Step LedgerEXT" extends "Payment Step Ledger"
{
    fields
    {
        field(50010; "Compta montant intial"; Boolean)
        {
            Description = 'DSFT AGA 09/06/20111';
        }
        field(50040; "Salary Posting Group"; Code[20])
        {
            Caption = 'Salary Posting Group';
            Description = 'SDT V1.00';
            TableRelation = Employee;
        }
        field(50050; "Compta. Retenue à la source"; Boolean)
        {
            Description = 'SDT V1.00';

            trigger OnValidate()
            var
                Step1: Record "Payment Step";
                Step2: Record "Payment Step";
            begin
                //>>DSFT-TRIUM 01/06/09
                Clear(RecGPaymentStepLedger);
                RecGPaymentStepLedger.Reset;
                RecGPaymentStepLedger.SetCurrentkey("Payment Class", "Compta. Retenue à la source", "Compta. Retenue Sur TVA", Line);
                RecGPaymentStepLedger.SetFilter("Payment Class", "Payment Class");
                RecGPaymentStepLedger.SetRange("Compta. Retenue à la source", true);
                Clear(Step1);
                Clear(Step2);
                Step1.Get("Payment Class", Line);

                if "Compta. Retenue à la source" then
                    if RecGPaymentStepLedger.Find('-') and ((RecGPaymentStepLedger.Line <> Line) or (RecGPaymentStepLedger.Sign <> Sign)) then begin
                        Step2.Get("Payment Class", Line);
                        if Step1."Previous Status" <> Step2."Previous Status" then
                            Error('Vous avez déjà spécifier la Retenu à la Source !!!');
                    end;
                if not "Compta. Retenue à la source" then
                    "Compte Retenue à la source" := '';
                //>>DSFT-TRIUM 01/06/09
            end;
        }
        field(50060; "Compte Retenue à la source"; Code[20])
        {
            Description = 'SDT V1.00';
            TableRelation = "G/L Account";
        }
        field(50070; "Compta. Retenue Sur TVA"; Boolean)
        {
            Description = 'SDT V1.00';

            trigger OnValidate()
            begin
                //>>DSFT-TRIUM 01/06/09
                Clear(RecGPaymentStepLedger);
                RecGPaymentStepLedger.Reset;
                RecGPaymentStepLedger.SetCurrentkey("Payment Class", "Compta. Retenue à la source", "Compta. Retenue Sur TVA", Line);
                RecGPaymentStepLedger.SetFilter("Payment Class", "Payment Class");
                RecGPaymentStepLedger.SetRange("Compta. Retenue Sur TVA", true);
                if "Compta. Retenue Sur TVA" then
                    if RecGPaymentStepLedger.Find('-') and ((RecGPaymentStepLedger.Line <> Line) or (RecGPaymentStepLedger.Sign <> Sign)) then
                        Error('Vous avez déjà spécifier la Retenu Sur T.V.A !!!');
                if not "Compta. Retenue Sur TVA" then
                    "Compte Retenue Sur TVA" := '';
                //>>DSFT-TRIUM 01/06/09
            end;
        }
        field(50071; "Compte Retenue Sur TVA"; Code[20])
        {
            Description = 'SDT V1.00';
            TableRelation = "G/L Account";
        }
        field(50080; "Inclure Commission"; Boolean)
        {
            Description = 'SDT V1.00';

            trigger OnValidate()
            begin
                //>>DSFT-TRIUM 01/06/09
                /*
                CLEAR(RecGPaymentStepLedger);
                RecGPaymentStepLedger.RESET;
                RecGPaymentStepLedger.SETCURRENTKEY("Payment Class","Inclure Commission",Line);
                RecGPaymentStepLedger.SETFILTER("Payment Class","Payment Class");
                RecGPaymentStepLedger.SETRANGE("Inclure Commission",TRUE);
                 IF "Inclure Commission" THEN
                     IF RecGPaymentStepLedger.FIND('-') AND ((RecGPaymentStepLedger.Line<>Line) OR (RecGPaymentStepLedger.Sign<>Sign)) THEN
                       ERROR('Vous avez déjà spécifier la Commission !!!');
                       */
                if not "Inclure Commission" then begin
                    "Compte Commission" := '';
                    "Compte TVA/Commission" := '';
                end;
                //>>DSFT-TRIUM 01/06/09

            end;
        }
        field(50081; "Compte Commission"; Code[20])
        {
            Description = 'SDT V1.00';
            TableRelation = "G/L Account";
        }
        field(50082; "Compte TVA/Commission"; Code[20])
        {
            Description = 'SDT V1.00';
            TableRelation = "G/L Account";
        }
        field(50083; "% TVA"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'SDT V1.00';
        }
        field(50090; "Annuler Compta Retn. à la Sour"; Boolean)
        {
            Description = 'SDT V1.00';

            trigger OnValidate()
            begin
                Clear(RecGPaymentStepLedger);
                RecGPaymentStepLedger.Reset;
                RecGPaymentStepLedger.SetCurrentkey("Payment Class", "Annuler Compta Retn. à la Sour", Line);
                RecGPaymentStepLedger.SetFilter("Payment Class", "Payment Class");
                RecGPaymentStepLedger.SetRange("Annuler Compta Retn. à la Sour", true);
                if "Compta. Retenue à la source" then
                    if RecGPaymentStepLedger.Find('-') and ((RecGPaymentStepLedger.Line <> Line) or (RecGPaymentStepLedger.Sign <> Sign)) then
                        Error('Vous avez déjà Annuler la Retenu à la Source !!!');
                if "Annuler Compta Retn. à la Sour" then
                    "Compta. Retenue à la source" := false;
            end;
        }
        field(50091; "Forcer Imputation débit/crédit"; Boolean)
        {
            Description = 'SDT V1.00';
        }
        field(50095; "Retenue sur Garantie"; Boolean)
        {
            Description = 'SDT V1.00';

            trigger OnValidate()
            begin
                //>>DSFT-TRIUM 01/06/09
                Clear(RecGPaymentStepLedger);
                RecGPaymentStepLedger.Reset;
                RecGPaymentStepLedger.SetCurrentkey("Payment Class", "Compta. Retenue à la source", "Compta. Retenue Sur TVA", Line);
                RecGPaymentStepLedger.SetFilter("Payment Class", "Payment Class");
                RecGPaymentStepLedger.SetRange("Retenue sur Garantie", true);
                if "Retenue sur Garantie" then
                    if RecGPaymentStepLedger.Find('-') and ((RecGPaymentStepLedger.Line <> Line) or (RecGPaymentStepLedger.Sign <> Sign)) then
                        Error('Vous avez déjà spécifier la Retenu de Garantie !!!');
                //<<DSFT-TRIUM 01/06/09
            end;
        }
        field(50096; "Inclure IntérêtFED"; Boolean)
        {
            Description = 'IMS 11 05 11';
        }
        field(50097; "Compte Intérêt FED"; Code[10])
        {
            Description = 'IMS 11 05 11';
            TableRelation = "G/L Account";
        }
        field(50098; "Inclure Intérêt Escompte"; Boolean)
        {
            Description = 'IMS 11 05 11';
        }
        field(50099; "Compte Intérêt Escompte"; Code[10])
        {
            Description = 'IMS 11 05 11';
            TableRelation = "G/L Account";
        }
        field(50100; "Inclure Interêt sur Prêt"; Boolean)
        {
            Description = 'IMS 02 06 11';
        }
        field(50101; "Compte Intérêt sur Prêt"; Code[10])
        {
            Description = 'IMS 02 06 11';
            TableRelation = "G/L Account";
        }
        field(50102; "Libelle Type Reglement text"; Text[50])
        {
            CalcFormula = lookup("Payment Class".Name where(Code = field("Payment Class")));
            FieldClass = FlowField;
        }
    }
    keys
    {

        /*GL2024  key(STG_Key2;"Payment Class","Compta. Retenue à la source","Compta. Retenue Sur TVA",Line)
          {
          }

          key(STG_Key3;"Payment Class","Inclure Commission",Line)
          {
          }

          key(STG_Key4;"Payment Class","Annuler Compta Retn. à la Sour",Line)
          {
          }*/
    }

    var
        RecGPaymentStepLedger: Record "Payment Step Ledger";
}

