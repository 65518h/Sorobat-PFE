codeunit 50044 FormatAddressEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvSellTo', '', true, true)]
    local procedure OnBeforeSalesInvSellTo(var AddrArray: array[8] of Text[100]; var SalesInvoiceHeader: Record "Sales Invoice Header"; var Handled: Boolean)

    begin
        CduFormatAddr.FormatAddr(
         //+REF+INVOICE
         //    AddrArray,"Sell-to Customer Name","Sell-to Customer Name 2","Sell-to Contact","Sell-to Address","Sell-to Address 2",
         AddrArray, SalesInvoiceHeader."Sell-to Customer Name", SalesInvoiceHeader."Sell-to Customer Name 2", '', SalesInvoiceHeader."Sell-to Address", SalesInvoiceHeader."Sell-to Address 2",
     //+REF+INVOICE//
     SalesInvoiceHeader."Sell-to City", SalesInvoiceHeader."Sell-to Post Code", SalesInvoiceHeader."Sell-to County", SalesInvoiceHeader."Sell-to Country/Region Code");
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvBillTo', '', true, true)]
    local procedure OnBeforeSalesInvBillTo(var AddrArray: array[8] of Text[100]; var SalesInvHeader: Record "Sales Invoice Header"; var Handled: Boolean)
    begin
        CduFormatAddr.FormatAddr(
        //+REF+INVOICE
        //    AddrArray,"Bill-to Name","Bill-to Name 2","Bill-to Contact","Bill-to Address","Bill-to Address 2",
        AddrArray, SalesInvHeader."Bill-to Name", SalesInvHeader."Bill-to Name 2", '', SalesInvHeader."Bill-to Address", SalesInvHeader."Bill-to Address 2",
        //+REF+INVOICE//
        SalesInvHeader."Bill-to City", SalesInvHeader."Bill-to Post Code", SalesInvHeader."Bill-to County", SalesInvHeader."Bill-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvShipTo', '', true, true)]
    local procedure OnBeforeSalesInvShipTo(var AddrArray: array[8] of Text[100]; var SalesInvHeader: Record "Sales Invoice Header"; var Handled: Boolean; var Result: Boolean; var CustAddr: array[8] of Text[100])
    begin
        CduFormatAddr.FormatAddr(
         //+REF+INVOICE
         //    AddrArray,"Ship-to Name","Ship-to Name 2","Ship-to Contact","Ship-to Address","Ship-to Address 2",
         AddrArray, SalesInvHeader."Ship-to Name", SalesInvHeader."Ship-to Name 2", '', SalesInvHeader."Ship-to Address", SalesInvHeader."Ship-to Address 2",
         //+REF+INVOICE//
         SalesInvHeader."Ship-to City", SalesInvHeader."Ship-to Post Code", SalesInvHeader."Ship-to County", SalesInvHeader."Ship-to Country/Region Code");
    end;

    PROCEDURE fSetCompanyCountryCode(pCountryCode: Code[10]);
    BEGIN
        //+REF+INVOICE
        gCompanyCountryCode := pCountryCode;
        //+REF+INVOICE//
    END;

    PROCEDURE wJob(VAR AddrArray: ARRAY[8] OF Text[50]; VAR Job: Record Job);
    BEGIN
        WITH Job DO
            CduFormatAddr.FormatAddr(
              AddrArray, Description, "Description 2", '', "Job Address", "Job Address 2",
              "Job City", "Job Post Code", "Job County", "Job Country Code");
    END;

    PROCEDURE fSetPrintName(pPrintName: Boolean);
    BEGIN
        //#6818
        wPrintName := pPrintName;
        //#6818//
    END;

    PROCEDURE fGetPrintName1() Retour: Boolean;
    BEGIN
        //#6818
        Retour := wPrintName;
        //#6818//
    END;

    var
        myInt: Integer;
        CduFormatAddr: Codeunit "Format Address";
        gCompanyCountryCode: Code[10];
        wPrintName: Boolean;
}