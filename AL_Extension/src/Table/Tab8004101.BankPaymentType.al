Table 8004101 "Bank Payment Type"
{
    // //+PMT+SEPA CW 02/09/10 #8219 + "Export Type"::SEPA
    // #4948 CW 12/09/07
    // #4641 FL 31/05/05
    // //+PMT+PAYMENT GESWAY 01/08/02 Table Type de paiement par banque
    //                   09/01/03 "Payment Type" options : + ,Direct Debit,Credit Card
    //                   21/01/03 "Export Type" options :  ,ETEBAC,ISABEL
    //                   17/07/03 Ajout champ "Standard Text Code","External Payment"
    // //+PMT+REPORT GESWAY 26/09/03 Ajout champ option Type (Standard,Extended)
    // //+BGW+LONG_TEXT GESWAY 18/04/05 Ne visualiser que les textes longs (OnLookup de "Standard Text Code")
    // //+PMT+VCOM FL 21/06/06  ajout options VCOM 1000, VCOM 400 SG,VCOM 400 CL dans 'export type'

    Caption = 'Bank Payment Type';
    //LookupPageID = 8004111;

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            NotBlank = true;
            TableRelation = "Bank Account";
        }
        field(2; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            OptionCaption = ' ,Check,Bill,Transfer,Direct Debit,Credit Card,VCOM';
            OptionMembers = " ",Check,Bill,Transfer,"Direct Debit","Credit Card",VCOM;
        }
        field(3; "Transfer No."; Code[10])
        {
            Caption = 'Credit Transfer No.';

            trigger OnValidate()
            begin
                if (StrLen("Transfer No.") > 0) and (StrLen("Transfer No.") < 6) then
                    Error(tSixDigits);
            end;
        }
        field(4; FileName; Text[80])
        {
            Caption = 'File Name';
        }
        field(5; "Bal. Summarize"; Boolean)
        {
            Caption = 'Bal. Summarize';

            trigger OnValidate()
            begin
                if "Payment Type" = "payment type"::VCOM then
                    TestField("Bal. Summarize", false);
            end;
        }
        field(6; "Last Payment No."; Code[20])
        {
            Caption = 'Last Payment No.';
        }
        field(7; Preprinted; Boolean)
        {
            Caption = 'Preprinted';
        }
        field(8; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(9; "Export Type"; Option)
        {
            Caption = 'Export Type';
            OptionCaption = ' ,CFONB160,ISABEL,VCOM1000,VCOM400-SG,VCOM400-CL,BBVA,SEPA';
            OptionMembers = " ",CFONB160,ISABEL,VCOM1000,"VCOM400-SG","VCOM400-CL",BBVA,SEPA;

            trigger OnValidate()
            var
                lPaymentIntegration: Codeunit "Payment Integration";
            begin
                lPaymentIntegration.BPTCheckExportType(Rec, xRec);
            end;
        }
        field(11; "External Payment"; Boolean)
        {
            Caption = 'External Payment';
        }
    }

    keys
    {
        key(STG_Key1; "Bank Account No.", "Payment Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        tSixDigits: label 'You must tape 6 positions in this field.';
        tMustBe: label '%1 must be %2 or %3.';
        texportType: label 'ISABEL or ETEBAC Export Type can be select only for "Transfert" and "Direct Debit" payment Type.';
}

