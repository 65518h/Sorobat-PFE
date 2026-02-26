TableExtension 50001 "Payment TermsEXT" extends "Payment Terms"
{
    fields
    {
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';

        }
        field(8004100; "Number of Fractionation"; Integer)
        {
            //blankzero = true;
            CalcFormula = count(Fractionation where("Payment Terms Code" = field(Code)));
            Caption = 'Number of Fractionation';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key2; Synchronise)
        {
        }
    }


    trigger OnafterDelete()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //+PMT+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.DeleteTranslations(lRecordRef.NUMBER, FIELDNO(Description), Code);
        //+PMT+TRANSLATION//
    end;

    trigger OnafterRename()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //+PMT+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.RenameTranslations(lRecordRef.NUMBER, FIELDNO(Description), xRec.Code, Code);
        //+PMT+TRANSLATION//
    end;










}

