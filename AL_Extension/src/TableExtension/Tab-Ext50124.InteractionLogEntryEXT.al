TableExtension 50124 "Interaction Log EntryEXT" extends "Interaction Log Entry"
{
    fields
    {
        field(8001400; "Sales Document Type"; Option)
        {
            Caption = 'Sales Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8001401; "Sales Document No."; Code[20])
        {
            Caption = 'Sales Document No.';
        }
        field(8001402; TableID; Integer)
        {
            Caption = 'Table ID';
        }
        field(8001403; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
    }
    keys
    {
        key(Key19; "Sales Document Type", "Sales Document No.")
        {
        }
    }


    procedure fSearchDocType(pDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; pLogEntryDocType: Option " ","Sales Qte.","Sales Blnkt. Ord","Sales Ord. Cnfrmn.","Sales Inv.","Sales Shpt. Note","Sales Cr. Memo","Sales Stmnt.","Sales Rmdr.","Serv. Ord. Create","Serv. Ord. Post","Purch.Qte.","Purch. Blnkt. Ord.","Purch. Ord.","Purch. Inv.","Purch. Rcpt.","Purch. Cr. Memo","Cover Sheet","Sales Return Order","Sales Finance Charge Memo","Sales Return Receipt","Purch. Return Shipment","Purch. Return Ord. Cnfrmn.","Service Contract","Service Contract Quote","Service Quote"; pDirection: Option SalesToLog,PurchToLog,LogToDoc): Integer
    begin
        //+REF+MAILING
        case pDirection of
            Pdirection::SalesToLog:
                begin
                    case pDocType of
                        Pdoctype::Quote:
                            exit(1);      //"Document Type"::"Sales Qte."
                        Pdoctype::Order:
                            exit(3);      //"Document Type"::"Sales Ord. Cnfrmn."
                        Pdoctype::Invoice:
                            exit(4);      //"Document Type"::"Sales Inv."
                        Pdoctype::"Credit Memo":
                            exit(6);      //"Document Type"::"Sales Cr. Memo"
                    end;
                end;
            Pdirection::PurchToLog:
                begin
                    case pDocType of
                        Pdoctype::Quote:
                            exit(11);      //"Document Type"::"Purch.Qte."
                        Pdoctype::Order:
                            exit(13);      //"Document Type"::"Purch. Ord."
                        Pdoctype::Invoice:
                            exit(14);      //"Document Type"::"Purch. Inv."
                        Pdoctype::"Credit Memo":
                            exit(16);      //"Document Type"::"Purch. Cr. Memo"
                    end;
                end;
            Pdirection::LogToDoc:
                begin
                    case pLogEntryDocType of
                        Plogentrydoctype::"Sales Qte.", Plogentrydoctype::"Purch.Qte.":
                            exit(0);      //"Document Type"::Quote
                        Plogentrydoctype::"Sales Ord. Cnfrmn.", Plogentrydoctype::"Purch. Ord.":
                            exit(1);      //"Document Type"::Order
                        Plogentrydoctype::"Sales Inv.", Plogentrydoctype::"Purch. Inv.":
                            exit(2);      //"Document Type"::Invoice
                        Plogentrydoctype::"Sales Cr. Memo", Plogentrydoctype::"Purch. Cr. Memo":
                            exit(3);      //"Document Type"::"Credit Memo"
                    end;
                end;
        end;
    end;
}

