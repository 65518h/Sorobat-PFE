PageExtension 50204 "Fixed Asset Card_PagEXT" extends "Fixed Asset Card"

{


    layout
    {
        modify("Serial No.")
        {
            trigger OnAfterValidate()
            begin

                RecFixedAsset.RESET;
                RecFixedAsset.SETRANGE("Serial No.", rec."Serial No.");
                IF RecFixedAsset.FINDFIRST THEN ERROR('N° Serie Existe Déja');
            end;
        }
        addafter("Last Date Modified")
        {
            field("Materiel Exploiatation"; Rec."Materiel Exploiatation")
            {
                ApplicationArea = all;
            }

            field("Matériel"; Rec."Matériel")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin

                    IF rec.Matériel THEN BEGIN
                        CdeFamilleVISIBLE := TRUE;
                        LblFamilleVISIBLE := TRUE;
                        BtGenererVISIBLE := TRUE;
                    END
                    ELSE BEGIN
                        CdeFamilleVISIBLE := FALSE;
                        LblFamilleVISIBLE := FALSE;
                        BtGenererVISIBLE := FALSE;
                        rec.Famille := '';
                    END;
                end;
            }
            field(Famille; Rec.Famille)
            {
                ApplicationArea = all;
                Visible = CdeFamilleVISIBLE;

            }
            field("Ancien Code"; Rec."Ancien Code")
            {
                ApplicationArea = all;
                Editable = FALSE;
            }
            field("Non Amortissable"; Rec."Non Amortissable")
            {
                ApplicationArea = all;
            }
        }
        addafter("Professional Tax")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Vendor No.")
        {
            field("N° Facture Fournisseur"; Rec."N° Facture Fournisseur")
            {
                ApplicationArea = all;
                Editable = FALSE;
            }
            field("Date Comptabilisation"; Rec."Date Comptabilisation")
            {
                ApplicationArea = all;
                Editable = FALSE;
            }
            field("N° Facture"; Rec."N° Facture")
            {
                ApplicationArea = all;
                Editable = FALSE;
            }
        }
    }
    actions
    {
        addafter("C&opy Fixed Asset")
        {
            action(Folder)
            {
                Caption = 'Folder';
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    lFolderManagement: Codeunit "Folder management";
                BEGIN
                    //+REF+FOLDER
                    lFolderManagement.FixedAsset(Rec);
                    //+REF+FOLDER//

                end;
            }
            //DYS page addon non migrer
            /*action(Characteristics)
            {
                Caption = 'Characteristics';
                ApplicationArea = all;
                RunObject = Page 8001403;
                RunPageLink = "Table Name" = CONST("Fixed Asset"),
                                  "No." = FIELD("No.");
            }
            */
        }
        addafter("C&opy Fixed Asset_Promoted")
        {
            actionref(Folder1; Folder)
            {

            }
        }

        addafter("Fixed &Asset")
        {
            action("BtGenerer")
            {
                Caption = 'Generate equipment';
                ApplicationArea = all;
                Visible = BtGenererVISIBLE;
                trigger OnAction()
                begin

                    // >> HJ DSFT 21 06 2012
                    IF rec.Famille = '' THEN EXIT;
                    RecResource.SETRANGE(Type, RecResource.Type::Machine);
                    RecResource.SETRANGE("Tree Code", rec.Famille);
                    IF RecResource.FINDLAST THEN BEGIN
                        RecNewResource.TRANSFERFIELDS(RecResource);
                        CdeLastNum := RecResource."No.";
                        CdeNewNum := CdeLastNum;
                        IncrementNoText(CdeNewNum, 1);
                        RecNewResource."No." := CdeNewNum;
                        RecNewResource.Name := rec.Description;
                        IF RecNewResource.INSERT THEN BEGIN
                            RecDefaultDimension.SETRANGE("Table ID", 156);
                            RecDefaultDimension.SETRANGE("No.", CdeLastNum);
                            IF RecDefaultDimension.FINDFIRST THEN
                                REPEAT
                                    RecNewDefaultDimension.INIT;
                                    RecNewDefaultDimension.TRANSFERFIELDS(RecDefaultDimension);
                                    RecNewDefaultDimension."No." := CdeNewNum;
                                    RecNewDefaultDimension.INSERT;
                                UNTIL RecDefaultDimension.NEXT = 0;
                        END;
                    END;
                    rec.Famille := '';
                    MESSAGE(Text001, CdeNewNum);
                    // >> HJ DSFT 21 06 2012
                end;
            }
        }
        addafter(Statistics_Promoted)
        {
            actionref("BtGenerer1"; "BtGenerer")
            {

            }
        }

    }
    trigger OnNewRecord(BelowxRec: Boolean)
    VAR
        lRecordRef: RecordRef;
        lTemplateMgt: Codeunit "Config. Template Management";
        CduFunction: Codeunit SoroubatFucntion;
    begin

        //+REF+TEMPLATE
        lRecordRef.GETTABLE(Rec);
        IF NOT CduFunction.GetTemplate(lRecordRef) THEN
            Currpage.CLOSE;
        lRecordRef.SETTABLE(Rec);
        //+REF+TEMPLATE//
    end;



    PROCEDURE IncrementNoText(VAR No: Code[20]; IncrementByNo: Decimal);
    VAR
        DecimalNo: Decimal;
        StartPos: Integer;
        EndPos: Integer;
        NewNo: Text[30];
        Text001: Label 'You must configure the quarantine decision number series, article journal template, and transfer type';
    BEGIN
        // >> HJ DSFT 05 04 2010
        IF No = '' THEN ERROR(Text001);
        GetIntegerPos(No, StartPos, EndPos);
        EVALUATE(DecimalNo, COPYSTR(No, StartPos, EndPos - StartPos + 1));
        NewNo := FORMAT(DecimalNo + IncrementByNo, 0, 1);
        ReplaceNoText(No, NewNo, 0, StartPos, EndPos);
        // >> HJ DSFT 05 04 2010
    END;

    PROCEDURE GetIncrementNoText(VAR No: Code[20]; IncrementByNo: Decimal) NewNoDoc: Code[20];
    VAR
        DecimalNo: Decimal;
        StartPos: Integer;
        EndPos: Integer;
        NewNo: Text[30];
        Text001: label 'You must configure the quarantine decision series, article journal template, and transfer type';
    BEGIN
        // >> HJ DSFT 05 04 2010
        IF No = '' THEN ERROR(Text001);
        GetIntegerPos(No, StartPos, EndPos);
        EVALUATE(DecimalNo, COPYSTR(No, StartPos, EndPos - StartPos + 1));
        NewNo := FORMAT(DecimalNo + IncrementByNo, 0, 1);
        ReplaceNoText(No, NewNo, 0, StartPos, EndPos);
        EXIT(NewNo);
        // >> HJ DSFT 05 04 2010
    END;

    PROCEDURE ReplaceNoText(VAR No: Code[20]; NewNo: Code[20]; FixedLength: Integer; StartPos: Integer; EndPos: Integer);
    VAR
        StartNo: Code[20];
        EndNo: Code[20];
        ZeroNo: Code[20];
        NewLength: Integer;
        OldLength: Integer;
        Text001: label 'Incorrect length';
    BEGIN
        // >> HJ DSFT 05 04 2010
        IF StartPos > 1 THEN
            StartNo := COPYSTR(No, 1, StartPos - 1);
        IF EndPos < STRLEN(No) THEN
            EndNo := COPYSTR(No, EndPos + 1);
        NewLength := STRLEN(NewNo);
        OldLength := EndPos - StartPos + 1;
        IF FixedLength > OldLength THEN
            OldLength := FixedLength;
        IF OldLength > NewLength THEN
            ZeroNo := PADSTR('', OldLength - NewLength, '0');
        IF STRLEN(StartNo) + STRLEN(ZeroNo) + STRLEN(NewNo) + STRLEN(EndNo) > 20 THEN
            ERROR(
              Text001,
              No);
        No := StartNo + ZeroNo + NewNo + EndNo;
        // >> HJ DSFT 05 04 2010
    END;

    PROCEDURE GetIntegerPos(No: Code[20]; VAR StartPos: Integer; VAR EndPos: Integer);
    VAR
        IsDigit: Boolean;
        i: Integer;
    BEGIN
        // >> HJ DSFT 05 04 2010
        StartPos := 0;
        EndPos := 0;
        IF No <> '' THEN BEGIN
            i := STRLEN(No);
            REPEAT
                IsDigit := No[i] IN ['0' .. '9'];
                IF IsDigit THEN BEGIN
                    IF EndPos = 0 THEN
                        EndPos := i;
                    StartPos := i;
                END;
                i := i - 1;
            UNTIL (i = 0) OR (StartPos <> 0) AND NOT IsDigit;
        END;
        // >> HJ DSFT 05 04 2010
    END;








    VAR

        RecResource: Record Resource;
        RecNewResource: Record Resource;
        RecDefaultDimension: Record "Default Dimension";
        RecNewDefaultDimension: Record "Default Dimension";
        CdeLastNum: Code[20];
        CdeNewNum: Code[20];
        RecFixedAsset: Record "Fixed Asset";
        Text001: Label 'Material No. %1 has been successfully created';
        //GL2024
        BtGenererVISIBLE: Boolean;
        LblFamilleVISIBLE: Boolean;
        CdeFamilleVISIBLE: Boolean;


}