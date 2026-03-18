TableExtension 50203 "Payment Post. BufferEXT" extends "Payment Post. Buffer"
{
    fields
    {

        /* GL2024 modify("Currency Code")
          {
            //  DecimalPlaces=0:15
          }*/
        field(50050; "Compte Retenue"; Code[20])
        {
            Description = 'STD V2.00';
        }
        field(50051; "Amount Retenue"; Decimal)
        {
            Description = 'STD V2.00';
        }
        field(50052; "Amount Retenue (LCY)"; Decimal)
        {
            Description = 'STD V2.00';
        }
        field(50070; "Compte TVA"; Code[20])
        {
            Description = 'STD V2.00';
        }
        field(50071; "Amount TVA"; Decimal)
        {
            Description = 'STD V2.00';
        }
        field(50072; "Amount TVA (LCY)"; Decimal)
        {
            Description = 'STD V2.00';
        }
        field(50080; "Compte Comission"; Code[20])
        {
            Description = 'STD V2.00';
        }
        field(50081; "Amount Comission"; Decimal)
        {
            AutoFormatType = 1;
            Description = 'STD V2.00';
        }
        field(50082; "Amount Comission (LCY)"; Decimal)
        {
            Description = 'STD V2.00';
        }
        field(50085; "Compte TVA/Comission"; Code[20])
        {
            Description = 'STD V2.00';
        }
        field(50086; "Amount TVA/Comission"; Decimal)
        {
            AutoFormatType = 1;
            Description = 'STD V2.00';
        }
        field(50087; "Amount TVA/Comission (LCY)"; Decimal)
        {
            Description = 'STD V2.00';
        }
        field(50088; Commentaires; Text[100])
        {
            Description = 'STD V2.00';
        }
        field(50089; "Compte Intérêt FED"; Code[10])
        {
            Description = 'IMS 11 05 2011';
        }
        field(50090; "Montant Intérêt FED"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50091; "Montant Intérêt FED (DS)"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50092; "Compte Intérêt Escompte"; Code[10])
        {
            Description = 'IMS 11 05 2011';
        }
        field(50093; "Montant Intérêt Escompte"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50094; "Montant Intérêt Escompte (DS)"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50095; "Compte Intérêt sur Prêt"; Code[10])
        {
            Description = 'IMS 02 06 2011';
        }
        field(50096; "Montant Intérêt sur Prêt"; Decimal)
        {
            Description = 'IMS 02 06 2011';
        }
        field(50097; "Montant Intérêt sur Prêt (DS)"; Decimal)
        {
            Description = 'IMS 02 06 2011';
        }
        field(50098; Salarie; Code[20])
        {
            Description = 'HJ SORO 03-08-2016';
        }
        field(50099; "Affectation Fianciere"; Code[60])
        {
            Description = 'HJ SORO 23-02-2017';
        }
    }
    keys
    {

        key(STG_Key3; "GL Entry No.", "Account Type", "Account No.")
        {
        }
    }
}

