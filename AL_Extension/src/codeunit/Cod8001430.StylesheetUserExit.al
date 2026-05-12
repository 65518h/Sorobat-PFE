Codeunit 8001430 "Stylesheet UserExit"
{
    // #8046 SD 01/06/10


    trigger OnRun()
    begin
    end;

    var
        gFieldArray: array[100, 2] of Text[100];
        gCount: Integer;
        gAdded: Integer;
        gRecordRef: RecordRef;
    //GL2024   gAppMgt: Codeunit ApplicationManagement;
    //GL2024   StyleSheetFunctions: Codeunit 681;

    /*

    //GL2024 Automation non compatible
        procedure AddFields(var wrdMergefile: Automation; var pStylesheetHeader: Record 680; var pRecordRef: RecordRef; var pFieldCount: Integer)
        begin
            // Set globals
            gRecordRef := pRecordRef;
            gAdded := 0;

            // Set UserExit fields
            case pStylesheetHeader."Form No." of
                page::"Purchase Order":
                    begin
                        case pRecordRef.Number of
                            Database::"Purchase Header":
                                begin
                                    wrdMergefile.AddField(FullName('xPurchaserName'));
                                    wrdMergefile.AddField(FullName('xManager'));
                                end;
                            Database::"Purchase Line":
                                begin
                                    wrdMergefile.AddField(FullName('xJobResponsible'));
                                end;
                        end;
                    end;
            end;

            // Update
            pFieldCount += gAdded;
        end;
    */
    /*

    //GL2024 Automation non compatible
        procedure AddElements(var pParentNode: Automation; var pCreatedChildNode: Automation; var pRecordRef: RecordRef)
        var
            lPurchaseHeader: Record 38;
            lPurchaseLine: Record 39;
            lPurchaser: Record 13;
            lText: Text[30];
            lPrefix: Text[30];
            lJob: Record 8004160;
            lRecordRef: RecordRef;
        begin
            lPrefix := StyleSheetFunctions.MailMergeFieldName(pRecordRef.Name, '_');

            case pRecordRef.Number of

                Database::"Purchase Header":
                    begin
                        pRecordRef.SetTable(lPurchaseHeader);
                        if lPurchaser.Get(lPurchaseHeader."Purchaser Code") then;
                        lRecordRef.GetTable(lPurchaser);
                      //GL2024 Automation non compatible  AddElement(pParentNode, pCreatedChildNode, lPrefix + 'xPurchaserName', lPurchaser.Name);
                      //GL2024 Automation non compatible  AddElement(pParentNode, pCreatedChildNode, lPrefix + 'xManager', GetRecordLink(lRecordRef.RecordId, 'xManager'));
                    end;

                Database::"Purchase Line":
                    begin
                        pRecordRef.SetTable(lPurchaseLine);
                        if lJob.Get(lPurchaseLine."Job No.") then;
                      //GL2024 Automation non compatible  AddElement(pParentNode, pCreatedChildNode, lPrefix + 'xJobResponsible', lJob."Person Responsible");

                    end;
            end;
        end;
    */

    procedure FullName(pField: Text[100]): Text[100]
    begin
        gAdded += 1;
        gCount += 1;
        gFieldArray[gCount, 1] := Format(gRecordRef.Number);
        //GL2024    gFieldArray[gCount, 2] := StyleSheetFunctions.MailMergeFieldName(gRecordRef.Name, pField);
        exit(gFieldArray[gCount, 2]);
    end;


    procedure NodeExists(var pTableNo: Integer; pNodeText: Text[100]): Boolean
    var
        i: Integer;
    begin
        for i := 1 to gCount do
            if (gFieldArray[i, 1] = Format(pTableNo)) and (gFieldArray[i, 2] = pNodeText) then
                exit(true);
        exit(false);
    end;

    /*  
    //GL2024 Automation non compatible
     local procedure AddElement(var ParentNode: Automation; var CreatedChildNode: Automation; NodeName: Text[250]; NodeText: Text[250])
       var
           ChildNode: Automation;
       begin
           ChildNode := ParentNode.ownerDocument.createNode('element', NodeName, '');
           ChildNode.text := NodeText;
           ParentNode.appendChild(ChildNode);
           CreatedChildNode := ChildNode;
       end;
   */
    local procedure GetRecordLink(pRecordID: RecordID; pTag: Text[30]): Text[250]
    var
        lRecordLink: Record "Record Link";
    begin
        lRecordLink.SetCurrentkey("Record ID");
        lRecordLink.SetFilter("Record ID", Format(pRecordID));
        lRecordLink.SetRange(Company, COMPANYNAME);
        lRecordLink.SetRange(URL1, pTag);
        if lRecordLink.FindFirst then;
        exit(lRecordLink.Description);
    end;


    procedure CurrencyCode(pCurrencyCode: Code[10]): Code[10]
    var
        lGLSetup: Record "General Ledger Setup";
    begin
        if pCurrencyCode <> '' then
            exit(pCurrencyCode);
        lGLSetup.Get;
        exit(lGLSetup."LCY Code");
    end;


    /*GL2024 procedure FormatAmount(pAmount: Decimal; pCurrencyCode: Code[10]): Text[30]
     begin
         exit(Format(pAmount, 0, gAppMgt.AutoFormatTranslate(1, pCurrencyCode)));
     end;*/
}

