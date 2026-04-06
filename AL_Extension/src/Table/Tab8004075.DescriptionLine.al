Table 8004075 "Description Line"
{
    // //OUVRAGE GESWAY 12/03/03 Nouvelle table Commentaire lignes
    // //+REF+REPLIC AC 28/06/05 OnInsert, OnModify, OnDelete, OnRename
    //                           + field "Replication" (ID = 73754 ), boolean, editable=No
    // //PERF AC 03/04/06

    Caption = 'Description Line';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = "0","1","2","3","4";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
        }
        field(8; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(9; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8001400; Separator; Integer)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Table ID", "Document Type", "Document No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //+REF+REPLIC
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnInsert()
    var
        lDescLine: Record "Description Line";
    begin
        if "Line No." = 0 then begin
            lDescLine.SetRange("Table ID", "Table ID");
            lDescLine.SetRange("Document Type", "Document Type");
            lDescLine.SetRange("Document No.", "Document No.");
            lDescLine.SetRange("Document Line No.", "Document Line No.");
            //#5821
            //  lDescLine.SETRANGE("Description Type","Description Type");
            //#5821//
            if lDescLine.Find('+') then
                "Line No." := lDescLine."Line No." + 10000
            else
                "Line No." := 10000;
        end;

        //+REF+REPLIC
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnModify()
    var
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        lReplicationRef.GetTable(xRec);
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnRename()
    var
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        lReplicationRef.GetTable(xRec);
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //+REF+REPLIC//
    end;

    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;


    procedure ShowDescription(pTableID: Integer; pDocType: Integer; pDocNo: Code[20]; pLineNo: Integer)
    var
        lDescriptionLine: Record "Description Line";
        lMemoPad: Codeunit "MemoPad Management";
        lRecordRef: RecordRef;
    begin
        lDescriptionLine.SetRange("Table ID", pTableID);
        lDescriptionLine.SetRange("Document Type", pDocType);
        lDescriptionLine.SetRange("Document No.", pDocNo);
        lDescriptionLine.SetRange("Document Line No.", pLineNo);
        lDescriptionLine."Table ID" := pTableID;
        lDescriptionLine."Document Type" := pDocType;
        lDescriptionLine."Document No." := pDocNo;
        lDescriptionLine."Document Line No." := pLineNo;
        //#5821
        //PAGE.RunModal(page::"Description Sheet",lDescriptionLine);
        lRecordRef.GetTable(lDescriptionLine);
        lMemoPad.Edit(lRecordRef, lDescriptionLine.TableCaption);
        //#5821//
    end;


    procedure DeleteLines(pTableID: Integer; pDocType: Integer; pDocNo: Code[20]; pLineNo: Integer)
    begin
        SetRange("Table ID", pTableID);
        SetRange("Document Type", pDocType);
        SetRange("Document No.", pDocNo);
        SetRange("Document Line No.", pLineNo);
        if not IsEmpty then
            DeleteAll;
    end;


    procedure CopyLines(FromTableID: Integer; FromDocType: Integer; FromDocNo: Code[20]; FromLineNo: Integer; ToTableID: Integer; ToDocType: Integer; ToDocNo: Code[20]; ToLineNo: Integer)
    var
        lRec: Record "Description Line";
    begin
        SetRange("Table ID", FromTableID);
        SetRange("Document Type", FromDocType);
        SetRange("Document No.", FromDocNo);
        SetRange("Document Line No.", FromLineNo);
        if Find('-') then begin
            repeat
                lRec := Rec;
                lRec."Table ID" := ToTableID;
                lRec."Document Type" := ToDocType;
                lRec."Document No." := ToDocNo;
                lRec."Document Line No." := ToLineNo;
                if lRec.Insert(true) then;
            until Next = 0;
        end;
    end;


    procedure SetUpNewLine()
    var
        lDescriptionLine: Record "Description Line";
    begin
        lDescriptionLine.SetRange("Table ID", "Table ID");
        lDescriptionLine.SetRange("Document Type", "Document Type");
        lDescriptionLine.SetRange("Document No.", "Document No.");
        lDescriptionLine.SetRange("Document Line No.", "Document Line No.");
        //#5821
        //lDescriptionLine.SETRANGE("Description Type","Description Type");
        //#5821//
        if lDescriptionLine.IsEmpty then
            Date := WorkDate;
    end;
}

