Codeunit 8004057 "Sales Contrib. Form Opening"
{
    // //BAT AC 24/10/06 Appel Fiche via le menu


    trigger OnRun()
    var
        lCodes: Record Code;
    begin
        lCodes.SetRange("Table No", 8004050);
        lCodes.SetRange(lCodes."Field No", 5);
        //GL2024 NAVIBAT Page.RunModal(Page::Codes, lCodes);
    end;
}

