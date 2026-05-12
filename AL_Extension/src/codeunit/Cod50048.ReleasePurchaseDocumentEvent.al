codeunit 50048 ReleasePurchaseDocumentEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', true, true)]
    local procedure OnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var SkipCheckReleaseRestrictions: Boolean; var IsHandled: Boolean; SkipWhseRequestOperations: Boolean)
    var
        lProcessusWKFIntegr: Codeunit "Processus workflow Integr.";
    begin
        //+WKF+CUSTOM
        IF gAddOnLicencePermission.HasPermissionWKF() THEN
            IF lProcessusWKFIntegr.ReleasePurchDoc(PurchaseHeader) THEN
                EXIT;
        //+WKF+CUSTOM//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnCheckPurchLineLocationCode', '', true, true)]
    local procedure OnCodeOnCheckPurchLineLocationCode(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        //PROJET
        wCheckLine(PurchaseLine);
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeModifyPurchDoc', '', true, true)]
    local procedure OnBeforeModifyPurchDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        lRecordRef: RecordRef;
        lTemplateMgt: Codeunit "Config. Template Management";
    begin
        //+REF+TEMPLATE
        lRecordRef.GETTABLE(PurchaseHeader);
        //DYS fonction Check supprimer 
        // lTemplateMgt.Check(lRecordRef, '');
        //+REF+TEMPLATE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', true, true)]
    local procedure OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    var
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(PurchaseHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Release Purchase Document", +1);
        lRecordRef.SETTABLE(PurchaseHeader);
        //+REF+USEREXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReopenPurchaseDoc', '', true, true)]
    local procedure OnAfterReopenPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; SkipWhseRequestOperations: Boolean)
    var
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(PurchaseHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Release Purchase Document", +1);
        lRecordRef.SETTABLE(PurchaseHeader);
        //+REF+USEREXIT//
    end;

    PROCEDURE wCheckLine(VAR PuchLine: Record "Purchase Line");
    VAR
        lJobsSetup: Record "Jobs Setup";
        lWorkType: Record "Work Type";
        lCalendar: Codeunit "Calendar Management";
        lSetup: Record "Company Information";
        MSG: Text[80];
        lJob: Record Job;
        lRes: Record Resource;
    BEGIN
        //PROJET
        IF PuchLine."dysJob No." <> '' THEN BEGIN
            lJobsSetup.GET;

            WITH lJobsSetup DO BEGIN
                // Check Work Type Code
                CASE PuchLine.Type OF
                    PuchLine.Type::Item:
                        IF (("Check usage work type code" = "Check usage work type code"::Item) OR
                            ("Check usage work type code" = "Check usage work type code"::"Item and resource") OR
                            ("Check usage work type code" = "Check usage work type code"::"Item and Account (G/L)") OR
                            ("Check usage work type code" = "Check usage work type code"::"Item resource and Account (G/L)")) THEN
                            PuchLine.TESTFIELD("Work Type Code");
                    PuchLine.Type::"G/L Account":
                        IF (("Check usage work type code" = "Check usage work type code"::"Account (G/L)") OR
                            ("Check usage work type code" = "Check usage work type code"::"Resource and Account (G/L)") OR
                            ("Check usage work type code" = "Check usage work type code"::"Item and Account (G/L)") OR
                            ("Check usage work type code" = "Check usage work type code"::"Item resource and Account (G/L)")) THEN
                            PuchLine.TESTFIELD("Work Type Code");
                END;

                // Check Prod. posting Group
                CASE PuchLine.Type OF
                    PuchLine.Type::Item:
                        IF (("Check usage prod. posting Gr." = "Check usage prod. posting Gr."::Item) OR
                            ("Check usage prod. posting Gr." = "Check usage prod. posting Gr."::"Item and resource") OR
                            ("Check usage prod. posting Gr." = "Check usage prod. posting Gr."::"Item and Account (G/L)") OR
                            ("Check usage prod. posting Gr." = "Check usage prod. posting Gr."::"Item resource and Account (G/L)")) THEN
                            PuchLine.TESTFIELD("Gen. Prod. Posting Group");
                    PuchLine.Type::"G/L Account":
                        IF (("Check usage prod. posting Gr." = "Check usage prod. posting Gr."::"Account (G/L)") OR
                            ("Check usage prod. posting Gr." = "Check usage prod. posting Gr."::"Resource and Account (G/L)") OR
                            ("Check usage prod. posting Gr." = "Check usage prod. posting Gr."::"Item and Account (G/L)") OR
                            ("Check usage prod. posting Gr." = "Check usage prod. posting Gr."::"Item resource and Account (G/L)")) THEN
                            PuchLine.TESTFIELD("Gen. Prod. Posting Group");
                END;
            END;
        END;
    END;

    var
        myInt: Integer;
        tUseWorkflowToRelease: Label 'Use workflow to release an order';
        gAddOnLicencePermission: Codeunit IntegrManagement;
}