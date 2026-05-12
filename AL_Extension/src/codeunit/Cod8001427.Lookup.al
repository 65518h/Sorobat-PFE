Codeunit 8001427 Lookup
{
    // //+REF+SUGG_ACC CW 31/05/07 from SalesLine.OnLookup("No.") et PurchLine.OnLookup("No.")


    trigger OnRun()
    begin
    end;


    procedure SalesLineNo(var pRec: Record "Sales Line")
    begin
        if lLookupTypeNo(Database::"Sales Line", pRec.Type, pRec."No.") then
            pRec.Validate("No.", pRec."No.");
    end;


    procedure PurchLineNo(var pRec: Record "Purchase Line")
    begin
        //#6438
        if pRec.Type = pRec.Type::" " then begin
            if lLookupTextStd(pRec."Document Type", pRec."No.") then
                pRec.Validate("No.", pRec."No.");
            exit;
        end;
        //#6438//
        if lLookupTypeNo(Database::"Purchase Line", pRec.Type, pRec."No.") then
            pRec.Validate("No.", pRec."No.");
    end;


    procedure lLookupTypeNo(pTableID: Integer; pType: Integer; var pNo: Code[20]) Return: Boolean
    var
        lStdText: Record "Standard Text";
        lGLAccount: Record "G/L Account";
        lItem: Record Item;
        lResource: Record Resource;
        lFixedAsset: Record "Fixed Asset";
        lItemCharge: Record "Item Charge";
        lLine: Record "Sales Line";
    begin
        //+REF+SUGG_ACC
        case pType of
            lLine.Type::" ":
                begin
                    if lStdText.Get(pNo) then;
                    Return := Page.RunModal(0, lStdText) = Action::LookupOK;
                    pNo := lStdText.Code;
                end;
            lLine.Type::Item:
                begin
                    if lItem.Get(pNo) then;
                    Return := Page.RunModal(0, lItem) = Action::LookupOK;
                    pNo := lItem."No.";
                end;
            lLine.Type::Resource:
                begin
                    if lResource.Get(pNo) then;
                    Return := Page.RunModal(0, lResource) = Action::LookupOK;
                    pNo := lResource."No.";
                end;
            lLine.Type::"G/L Account":
                begin
                    case pTableID of
                        Database::"Sales Line":
                            lGLAccount.SetRange("Sugg. for Sales Doc.", true);
                        Database::"Purchase Line":
                            lGLAccount.SetRange("Sugg. for Purch. Doc.", true);
                    end;
                    if lGLAccount.Get(pNo) then;
                    Return := Page.RunModal(0, lGLAccount) = Action::LookupOK;
                    pNo := lGLAccount."No.";
                end;
            lLine.Type::"Fixed Asset":
                begin
                    if lFixedAsset.Get(pNo) then;
                    Return := Page.RunModal(0, lFixedAsset) = Action::LookupOK;
                    pNo := lFixedAsset."No.";
                end;
            lLine.Type::"Charge (Item)":
                begin
                    if lItemCharge.Get(pNo) then;
                    Return := Page.RunModal(0, lItemCharge) = Action::LookupOK;
                    pNo := lItemCharge."No.";
                end;
        end;
        exit(Return);
        //+REF+SUGG_ACC//
    end;


    procedure lLookupTextStd(pTypeDoc: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; var pNo: Code[20]) Return: Boolean
    var
        lStdText: Record "Standard Text";
        lGLAccount: Record "G/L Account";
        lItem: Record Item;
        lResource: Record Resource;
        lFixedAsset: Record "Fixed Asset";
        lItemCharge: Record "Item Charge";
        lLine: Record "Sales Line";
        lExtendedText: Record "Extended Text Header";
    begin
        //#6438
        lExtendedText.SetRange("Table Name", lExtendedText."table name"::"Standard Text");
        lStdText.Reset;
        if lStdText.Find('-') then begin
            repeat
                lExtendedText.SetRange("No.", lStdText.Code);
                case pTypeDoc of
                    Ptypedoc::Quote:
                        lExtendedText.SetRange("Purchase Quote", true);
                    Ptypedoc::Invoice:
                        lExtendedText.SetRange("Purchase Invoice", true);
                    Ptypedoc::Order:
                        lExtendedText.SetRange("Purchase Order", true);
                    Ptypedoc::"Credit Memo":
                        lExtendedText.SetRange("Purchase Credit Memo", true);
                    Ptypedoc::"Return Order":
                        lExtendedText.SetRange("Purchase Return Order", true);
                    Ptypedoc::"Blanket Order":
                        lExtendedText.SetRange("Purchase Blanket Order", true);
                end;
                if not lExtendedText.IsEmpty then
                    lStdText.Mark(true);
            until lStdText.Next = 0;
        end;
        lStdText.MarkedOnly(true);

        if lStdText.Get(pNo) then;
        Return := Page.RunModal(0, lStdText) = Action::LookupOK;
        pNo := lStdText.Code;
    end;
}

