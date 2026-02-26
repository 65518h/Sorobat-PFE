codeunit 50046 DimensionManagementEvent
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
        Text019: Label 'Vous avez modifié un axe analytique.\\Voulez-vous mettre … jour les lignes?';
        OverflowDimFilterErr: Label 'La conversion du filtre axe a généré un filtre devenu trop long.';
        CduDimMgment: Codeunit DimensionManagement;
        GLSetupShortcutDimCode: array[8] of Code[20];

    PROCEDURE TypeToTableID2000001(Type: Option " ",Customer,Vendor): Integer;
    BEGIN
        //BE_CODA
        CASE Type OF
            Type::" ":
                EXIT(0);
            Type::Customer:
                EXIT(DATABASE::Customer);
            Type::Vendor:
                EXIT(DATABASE::Vendor);
        END;
        //BE_CODA
    END;

    PROCEDURE fSetDefaultDim(pTableID: Integer; pNo: Code[20]; pFieldNumber: Integer; pShortcutDimCode: Code[20]);
    VAR
        lDefaultDim: Record "Default Dimension";
        lRecRef: RecordRef;
        lChangeLogMgt: Codeunit "Change Log Management";
    BEGIN
        //+REF+TEMPLATE
        // CduDimMgment.GetGLSetup(GLSetupShortcutDimCode[pFieldNumber]);
        IF pShortcutDimCode <> '' THEN BEGIN
            lDefaultDim.INIT;
            lDefaultDim.VALIDATE("Table ID", pTableID);
            lDefaultDim."No." := pNo; // Without Validate (call from OnInsert)
            lDefaultDim.VALIDATE("Dimension Code", GLSetupShortcutDimCode[pFieldNumber]);
            lDefaultDim.VALIDATE("Dimension Value Code", pShortcutDimCode);
            lDefaultDim.INSERT;
            lRecRef.GETTABLE(lDefaultDim);
            lChangeLogMgt.LogInsertion(lRecRef);
        END;
        //+REF+TEMPLATE//
    END;

    PROCEDURE fSetDocDim(pTableID: Integer; pDocumentType: Integer; pDocumentNo: Code[20]; pLineNo: Integer; pFieldNumber: Integer; pShortcutDimCode: Code[20]);
    VAR
        lDocDim: Record "Gen. Jnl. Dim. Filter";
        lRecRef: RecordRef;
        lChangeLogMgt: Codeunit "Change Log Management";
    BEGIN
        //+REF+TEMPLATE
        //   GetGLSetup;
        //   IF pShortcutDimCode <> '' THEN BEGIN
        //     lDocDim.INIT;
        //     lDocDim.VALIDATE("Table ID",pTableID);
        //     lDocDim."Document Type" := pDocumentType; // Without Validate (call from OnInsert)
        //     lDocDim."Document No." := pDocumentNo; // Without Validate (call from OnInsert)
        //     lDocDim."Line No." := pLineNo; // Without Validate (call from OnInsert)
        //     lDocDim.VALIDATE("Dimension Code",GLSetupShortcutDimCode[pFieldNumber]);
        //     lDocDim.VALIDATE("Dimension Value Code",pShortcutDimCode);
        //     lDocDim."Dimension Value Code" := pShortcutDimCode; // Without Validate
        //     lDocDim.INSERT;
        //     lRecRef.GETTABLE(lDocDim);
        //     lChangeLogMgt.LogInsertion(lRecRef);
        //END;
        //+REF+TEMPLATE//
    END;

    PROCEDURE fMoveOneDocDimToRenbrPostDocDi(VAR FromDocDim: Record "Gen. Jnl. Dim. Filter"; FromTableId: Integer; FromDocType: Integer; FromDocNo: Code[20]; FromLineNo: Integer; ToTableID: Integer; ToDocNo: Code[20]; ToLineNo: Integer);
    VAR
        ToPostedDocDim: Record "Reservation Worksheet Log";
    BEGIN
        //   //#7439
        //   WITH FromDocDim DO BEGIN
        //     SETRANGE("Table ID",FromTableId);
        //     SETRANGE("Document Type",FromDocType);
        //     SETRANGE("Document No.",FromDocNo);
        //     SETRANGE("Line No.",FromLineNo);
        //     IF FINDSET THEN
        //       REPEAT
        //         ToPostedDocDim.INIT;
        //         ToPostedDocDim."Table ID" := ToTableID;
        //         ToPostedDocDim."Document No." := ToDocNo;
        //         ToPostedDocDim."Line No." := ToLineNo;
        //         ToPostedDocDim."Dimension Code" := "Dimension Code";
        //         ToPostedDocDim."Dimension Value Code" := "Dimension Value Code";
        //         ToPostedDocDim.INSERT;
        //       UNTIL NEXT = 0;
        //   END;
        //#7439//
    END;
}