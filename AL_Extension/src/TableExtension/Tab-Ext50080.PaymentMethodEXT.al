TableExtension 50080 "Payment MethodEXT" extends "Payment Method"
{
    fields
    {
        field(50000; Traite; Boolean)
        {
            Description = 'IMS DSFT 14 12 2010';
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {

        }
        field(50002; "Nature Réglement"; Option)
        {
            Description = 'HJ DSFT 17-03-2011';
            OptionMembers = " ",Espece,Cheque,Traite;
        }
        field(50003; "Priorité"; Option)
        {
            Description = 'HJ DSFT 17-03-2011';
            OptionMembers = " ","0","1","2","3","4","5","6","7","8","9";
        }
        field(50004; Synchronise; Boolean)
        {
        }

        field(8001401; "Bill Type"; Option)
        {
            Caption = 'Bill Type';
            OptionCaption = ' ,Not Accepted,Accepted,BOR';
            OptionMembers = " ","Not Accepted",Accepted,BOR;
        }
        field(8001402; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            OptionCaption = ' ,Check,Bill,Transfer,Direct Debit,Credit Card,VCOM';
            OptionMembers = " ",Check,Bill,Transfer,"Direct Debit","Credit Card",VCOM;
        }
        field(8001403; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
    }
    keys
    {
        key(STG_Key2; Synchronise)
        {
        }
    }
    trigger OnAfterRename()
    VAR
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //+REF+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.RenameTranslations(lRecordRef.NUMBER, FIELDNO(Description), xRec.Code, Code);
        //+REF+TRANSLATION 
    end;

    trigger OnAfterDelete()
    VAR
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //+REF+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.DeleteTranslations(lRecordRef.NUMBER, FIELDNO(Description), Code);
        //+REF+TRANSLATION//
    end;


}

