TableExtension 50200 "Payment StatusEXT" extends "Payment Status"
{
    fields
    {
        field(50000; "Communication XRT"; Boolean)
        {
            Description = 'STD V1.00';
        }
        field(50001; "En Banque"; Boolean)
        {
            Description = 'STD V1.00';
        }
        field(50002; "Changement Agence Permis"; Boolean)
        {
            Description = 'HJ DSFT 10 12 2010';
        }
        field(50003; "Changement Agence Par"; Code[20])
        {
            Description = 'HJ DSFT 10 12 2010';
            TableRelation = User;
        }
        field(50004; Rapprocher; Boolean)
        {
        }
        field(50005; Annulation; Boolean)
        {
            Description = 'STD V1.00';

            trigger OnValidate()
            begin
                //>>DSFT-TRIUM 01/06/09
                RecGPaymentLine.Reset;
                RecGPaymentLine.SetRange(RecGPaymentLine."Payment Class", "Payment Class");
                RecGPaymentLine.SetRange(RecGPaymentLine."Status No.", Line);
                if RecGPaymentLine.Find('-') then begin
                    RecGPaymentLine.Annulation := true;
                    RecGPaymentLine.Modify;
                end;
                //<<DSFT-TRIUM 01/06/09
            end;
        }
        field(50006; "Compte Rapprochement"; Code[20])
        {
            Description = 'HJ SORO 10-08-2015';
            TableRelation = "G/L Account";
        }
        field(50011; "Type Engagement"; Option)
        {
            Description = 'HJ DSFT 08-02-2014';
            OptionMembers = " ",Fournisseur,Banque,"Fournisseur Et Banque","Client Et Banque",Client;
        }
        field(50012; "Sens Engagement"; Option)
        {
            OptionMembers = " ","Débit","Crédit";
        }
        field(50050; "Calculer Retenue à la source"; Boolean)
        {
            Description = 'STD V1.00';

            trigger OnValidate()
            begin
                //>>DSFT-TRIUM 01/06/09
                Clear(RecGPaymentStatus);
                RecGPaymentStatus.Reset;
                RecGPaymentStatus.SetCurrentkey("Payment Class", "Calculer Retenue à la source");
                RecGPaymentStatus.SetFilter("Payment Class", "Payment Class");
                RecGPaymentStatus.SetFilter("Calculer Retenue à la source", '%1', true);
                if RecGPaymentStatus.Find('-') and ("Calculer Retenue à la source" = true) then
                    Error('LE calcule de Retenu à la Source Ce fait une seule fois !!!!!');
                //<<DSFT-TRIUM 01/06/09
            end;
        }
        field(50070; "Calculer Retenue Sur TVA"; Boolean)
        {
            Description = 'STD V1.00';

            trigger OnValidate()
            begin
                //>>DSFT-TRIUM 01/06/09
                Clear(RecGPaymentStatus);
                RecGPaymentStatus.Reset;
                RecGPaymentStatus.SetCurrentkey("Payment Class", "Calculer Retenue Sur TVA");
                RecGPaymentStatus.SetFilter("Payment Class", "Payment Class");
                RecGPaymentStatus.SetFilter("Calculer Retenue Sur TVA", '%1', true);
                if RecGPaymentStatus.Find('-') and ("Calculer Retenue Sur TVA" = true) then
                    Error('LE calcule de Retenu Sur T.V.A fait une seule fois !!!!!');
                //<<DSFT-TRIUM 01/06/09
            end;
        }
        field(50080; "Tva Sur Commission"; Boolean)
        {
            Description = 'STD V1.00';
        }
        field(50081; Commission; Boolean)
        {
            Description = 'STD V1.00';
        }
        field(50090; Modifiable; Boolean)
        {
            Description = 'STD V1.00';
        }
        field(50095; "Calculer Retenue sur Garantie"; Boolean)
        {
            Description = 'STD V1.00';
        }
        field(50096; "Compte en-tête"; Boolean)
        {
            Description = 'STD V1.00';
        }
        field(50097; "Contrôle Compte en-tête"; Boolean)
        {
            Description = 'STD V1.00';
        }
        field(50600; Objet; Boolean)
        {
            Description = 'STD V1.00';
        }
        field(50610; "Référence Chèque"; Boolean)
        {
            Description = 'MBK';
        }
        field(50611; "Libelle Type Reglement text"; Text[50])
        {
            CalcFormula = lookup("Payment Class".Name where(Code = field("Payment Class")));
            FieldClass = FlowField;
        }
        field(50612; "Retenu Loyer"; Boolean)
        {
            Description = 'HJ SORO 25-06-2015';
        }
    }
    keys
    {

        /*GL2024  key(Key2;"Payment Class","Calculer Retenue à la source")
          {
          }*/
    }




    var
        RecGPaymentStatus: Record "Payment Status";
        RecGPaymentLine: Record "Payment Line";
}

