TableExtension 50199 "Payment ClassEXT" extends "Payment Class"
{
    Caption = 'Payment Class';
    fields
    {


        field(50000; "Communication XRT"; Boolean)
        {
            Description = 'STD V.100';
        }
        field(50001; Caisse; Boolean)
        {
            Description = 'STD V.100';
        }
        field(50002; "Header Account Type"; Option)
        {
            Caption = 'Header Account Type';
            Description = 'STD V.100';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(50003; "Mode Paiement"; Code[20])
        {
            Description = 'HJ DSFT 17-03-2011';
            TableRelation = "Payment Method";
        }
        field(50004; EXT; Boolean)
        {
            Description = 'HJ DSFT 17-03-2011';
        }
        field(50005; CPT; Boolean)
        {
            Description = 'HJ DSFT 17-03-2011';
        }
        field(50006; "Credit Bancaire Avec Echeancie"; Boolean)
        {
            Description = 'HJ DELTA 10-02-2014';
        }
        field(50007; "Piece De Paiement Obligatoire"; Boolean)
        {
            Description = 'HJ DELTA 10-02-2014';
        }
        field(50008; "Banque Bénéficiaire Obligatoir"; Boolean)
        {
            Description = 'HJ DELTA 10-02-2014';
        }
        field(50009; "Caisse Par Defaut"; code[20])
        {
            TableRelation = "Bank Account";
        }
        /*  field(50010; "Verifier Compte Ligne"; Boolean)
          {
              Description = 'RB SORO 08/02/2016';
          }
          field(50011; "Affectation Financier"; Code[60])
          {
              Description = 'HJ SORO 23-02-2017';
              TableRelation = "Affectation Opération Bancaire";
          }
          field(50012; "Verifier Affectation Financier"; Boolean)
          {
              Description = 'HJ SORO 23-02-2017';
          }*/
    }



}

