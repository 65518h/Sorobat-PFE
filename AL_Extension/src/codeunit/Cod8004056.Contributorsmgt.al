Codeunit 8004056 "Contributors mgt"
{
    // //BAT AC 24/10/06 Appel Fiche via le menu


    trigger OnRun()
    var
        lCode: Record Code;
    begin
        lCode.SetRange("Table No", Database::"Sales Contributor");
        lCode.SetRange("Field No", 5);
        //GL2024 NAVIBAT   Page.RunModal(Page::Codes, lCode);
    end;
}

