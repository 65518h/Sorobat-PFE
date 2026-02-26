Table 8004076 "Description Line Archive"
{
    // //OUVRAGE GESWAY 12/03/03 Nouvelle table Archive Commentaire lignes
    // 
    // ShowDescriptionLine(pTableID : Integer;pDocType : Integer;pDocNo : Code[20];PLineNo : Integer)
    // lMultiComment.SETRANGE("Table ID",pTableID);
    // lMultiComment.SETRANGE("Document Type",pDocType);
    // lMultiComment.SETRANGE("Document No.",pDocNo);
    // lMultiComment.SETRANGE("Document Line No.",PLineNo);
    // Page.Run(page::"Description Sheet",lMultiComment);

    Caption = 'Description Line Archive';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
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
        field(5; "Description Type"; Option)
        {
            Caption = 'Description Type';
            OptionCaption = 'External,Internal';
            OptionMembers = External,Internal;
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
        field(8003901; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(8003902; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
    }

    keys
    {
        key(Key1; "Table ID", "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Document Line No.", "Description Type", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure ShowDescription(pTableID: Integer; pDocType: Integer; pDocNo: Code[20]; pLineNo: Integer; pVersion: Integer; pOcc: Integer)
    var
        lDescriptionLine: Record "Description Line Archive";
    begin
        lDescriptionLine.SetRange("Table ID", pTableID);
        lDescriptionLine.SetRange("Document Type", pDocType);
        lDescriptionLine.SetRange("Document No.", pDocNo);
        lDescriptionLine.SetRange("Document Line No.", pLineNo);
        lDescriptionLine.SetRange("Doc. No. Occurrence", pOcc);
        lDescriptionLine.SetRange("Version No.", pVersion);
        //DYS page addon non migrer
        //PAGE.RunModal(page::"Description Multi Sheets Archi", lDescriptionLine);
    end;
}

