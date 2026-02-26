Codeunit 8003984 "Documents Transfer"
{
    // //BGW GESWAY 13/05/05 Document Transfer (single instance)

    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        DocType: Option Devis,Commande,Facture,Avoir,"Commande prévisionnelle";
        DocNo: Code[20];
        ImportSetupCode: Code[10];


    procedure GetDocumentNo(var pDocType: Option Devis,Commande,Facture,Avoir,"Commande prévisionnelle"; var pDocNo: Code[20])
    begin
        pDocType := DocType;
        pDocNo := DocNo;
    end;


    procedure SetDocumentNo(pDocType: Option Devis,Commande,Facture,Avoir,"Commande prévisionnelle"; pDocNo: Code[20])
    begin
        DocType := pDocType;
        DocNo := pDocNo;
    end;


    procedure SetImportSetupNo(pImportSetupCode: Code[10])
    begin
        ImportSetupCode := pImportSetupCode;
    end;


    procedure GetImportSetupNo(var pImportSetupCode: Code[10])
    begin
        pImportSetupCode := ImportSetupCode;
    end;
}

