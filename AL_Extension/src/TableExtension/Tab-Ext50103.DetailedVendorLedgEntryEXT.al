TableExtension 50103 "Detailed Vendor Ledg. EntryEXT" extends "Detailed Vendor Ledg. Entry"
{
    Caption = 'Detailed Vendor Ledg. Entry';
    fields
    {
        field(50000; "N° Dossier"; Code[20])
        {
            Description = 'HJ DSFT 13/12/2010';
        }
        field(50002; Lettre; Text[4])
        {
        }

        /*    field(50003; "Num Doc"; Code[20])
            {
                CalcFormula = lookup("Vendor Ledger Entry"."Document No." where("Entry No." = field("Applied Vend. Ledger Entry No.")));
                FieldClass = FlowField;
            }
            field(50004; "Num Doc Origine"; Code[20])
            {
                CalcFormula = lookup("Vendor Ledger Entry"."Document No." where("Entry No." = field("Vendor Ledger Entry No.")));
                FieldClass = FlowField;
            }
            field(50005; "Folio N°"; Text[20])
            {
            }
            //GL2024
            field(50006; "Transaction No. Soroubat"; Integer)
            {
                Caption = 'Transaction No. Soroubat';

            }*/
        field(8001600; "Value Date"; Date)
        {
            Caption = 'Value Date';
        }
    }
    keys
    {

        /* GL2024 key(STG_Key13;"Vendor No.","Value Date","Currency Code")
           {
           SumIndexFields = Amount,"Amount (LCY)","Debit Amount","Credit Amount","Debit Amount (LCY)","Credit Amount (LCY)";
           }
           key(STG_Key14;"Entry Type","Vendor No.","N° Dossier","Document Type","Amount (LCY)")
           {
           SumIndexFields = "Amount (LCY)";
           }*/
        key(STG_Key15; "Vendor No.", "Document No.")
        {
            SumIndexFields = "Amount (LCY)";
        }
        key(STG_Key16; Lettre)
        {
        }
    }




}



