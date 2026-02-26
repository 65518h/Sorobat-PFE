Table 8001566 "Workflow Document"
{
    //GL2024  ID dans Nav 2009 : "8004225"
    // //+WKF+DOC CW 24/08/02 Workflow Document
    //                DL 18/10/05 Ajout champ Comment
    // //+WKF+ MB 11/09/06 Ajout du champ description

    Caption = 'Workflow Document';
    // LookupPageID = 8004225;

    fields
    {
        field(1; "Document Template"; Integer)
        {
            //blankzero = true;
            Caption = 'Document Template';
            NotBlank = true;
            TableRelation = "Workflow Document Template";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            SQLDataType = Variant;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    Template.Get("Document Template");
                    NoSeriesMgt.TestManual(Template."No. Series");
                    "No. Series" := '';
                end;
            end;
        }
        field(3; Subject; Text[80])
        {
            Caption = 'Subject';
        }
        field(4; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(5; "Creation UserID"; Code[20])
        {
            Caption = 'Creation User ID';
            Editable = false;
            //GL2024 TableRelation = Login;
            TableRelation = "User Setup";



            trigger OnValidate()
            begin
                // LoginManagement.ValidateUserID("Creation UserID");
            end;
        }
        field(6; URL; Text[80])
        {
            Caption = 'HyperLink';
        }
        field(7; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(8; "Link Type Filter"; Integer)
        {
            Caption = 'Link Type Filter';
            FieldClass = FlowFilter;
            TableRelation = "Workflow Type";
        }
        field(9; "Link No. Filter"; Code[20])
        {
            Caption = 'Link No. Filter';
            FieldClass = FlowFilter;
        }
        field(10; Linked; Boolean)
        {
            CalcFormula = exist("Workflow Document Link" where(Type = field("Link Type Filter"),
                                                                "No." = field("Link No. Filter"),
                                                                "Document Template" = field("Document Template"),
                                                                "Document No." = field("No.")));
            Caption = 'Linked';
            FieldClass = FlowField;
        }
        field(11; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(12; "Status Code"; Code[10])
        {
            Caption = 'Status Code';
            TableRelation = "Workflow Document Code".Code where("Table No" = const(8004225),
                                                                 "Field No" = const(12),
                                                                 "Document Template" = field("Document Template"));
        }
        field(13; "Close Date"; Date)
        {
            Caption = 'Close Date';
            Editable = false;

            trigger OnValidate()
            begin
                Open := "Close Date" = 0D;
            end;
        }
        field(14; "Company No."; Code[20])
        {
            Caption = 'Company No.';
            TableRelation = Contact where(Type = const(Company));

            trigger OnValidate()
            var
                lContact: Record Contact;
            begin
                if lContact.Get("Company No.") then begin
                    if "Contact Name" = '' then
                        "Contact Name" := lContact.Name;
                end;
            end;
        }
        field(15; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = if ("Company No." = filter('')) Contact
            else
            if ("Company No." = filter(<> '')) Contact where(Type = const(Person),
                                                                                "Company No." = field("Company No."));

            trigger OnValidate()
            var
                lContact: Record Contact;
            begin
                if lContact.Get("Contact No.") then begin
                    "Company No." := lContact."Company No.";
                    if lContact.Type = lContact.Type::Company then
                        "Contact No." := '';
                    if "Contact Name" = '' then
                        "Contact Name" := lContact.Name;
                end;
            end;
        }
        field(16; "Contact Name"; Text[50])
        {
            Caption = 'Contact Name';
            Description = '#8709';
        }
        field(17; Open; Boolean)
        {
            Caption = 'Open';
            InitValue = true;

            trigger OnValidate()
            begin
                if Open then
                    "Close Date" := 0D
                else
                    if "Close Date" = 0D then
                        "Close Date" := WorkDate
            end;
        }
        field(18; Comment; Boolean)
        {
            CalcFormula = exist("Workflow Document Comment" where("Document Template" = field("Document Template"),
                                                                   "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; Description; Boolean)
        {
            CalcFormula = exist("Workflow Document Line" where("Document Template" = field("Document Template"),
                                                                "No." = field("No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Trigger"; Integer)
        {
            Description = 'Dummy for codeunit';
        }
        field(101; Integer1; Integer)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(FIELDNO(Integer1));
        }
        field(102; Integer2; Integer)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(FIELDNO(Integer2));
        }
        field(201; Text1; Text[30])
        {
            //CaptionClass = GetCaptionClass(FIELDNO(Text1));
        }
        field(202; Text2; Text[30])
        {
            //CaptionClass = GetCaptionClass(FIELDNO(Text2));
        }
        field(301; Code1; Code[10])
        {
            //CaptionClass = GetCaptionClass(FIELDNO(Code1));
            TableRelation = "Workflow Document Code".Code where("Document Template" = field("Document Template"),
                                                                 "Table No" = const(8004225),
                                                                 "Field No" = const(301));
        }
        field(302; Code2; Code[10])
        {
            //CaptionClass = GetCaptionClass(FIELDNO(Code2));
            TableRelation = "Workflow Document Code".Code where("Document Template" = field("Document Template"),
                                                                 "Table No" = const(8004225),
                                                                 "Field No" = const(302));
        }
        field(401; Decimal1; Decimal)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(FIELDNO(Decimal1));
        }
        field(402; Decimal2; Decimal)
        {
            //blankzero = true;
            //CaptionClass = GetCaptionClass(FIELDNO(Decimal2));
        }
        field(501; Boolean1; Boolean)
        {
            //CaptionClass = GetCaptionClass(FIELDNO(Boolean1));
        }
        field(502; Boolean2; Boolean)
        {
            //CaptionClass = GetCaptionClass(FIELDNO(Boolean2));
        }
        field(601; Date1; Date)
        {
            //CaptionClass = GetCaptionClass(FIELDNO(Date1));
        }
        field(602; Date2; Date)
        {
            //CaptionClass = GetCaptionClass(FIELDNO(Date2));
        }
        field(701; Time1; Time)
        {
            //CaptionClass = GetCaptionClass(FIELDNO(Time1));
        }
        field(702; Time2; Time)
        {
            //CaptionClass = GetCaptionClass(FIELDNO(Time2));
        }
    }

    keys
    {
        key(Key1; "Document Template", "No.")
        {
            Clustered = true;
        }
        key(Key2; "Company No.", "Creation Date")
        {
        }
        key(Key3; "Document Template", "Company No.")
        {
        }
        key(Key4; "Document Template", "Status Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lJnlLine: Record "Workflow Journal Line";
        lDocCommentLine: Record "Workflow Document Line";
        lDocumentLink: Record "Workflow Document Link";
    begin
        TestField(Open);

        lJnlLine.SetCurrentkey(Type, "No.");
        lJnlLine.SetRange(Type, "Document Template");
        lJnlLine.SetRange("No.", "No.");
        lJnlLine.DeleteAll;

        lDocCommentLine.SetCurrentkey("Document Template", "No.");
        lDocCommentLine.SetRange("Document Template", "Document Template");
        lDocCommentLine.SetRange("No.", "No.");
        lDocCommentLine.DeleteAll;

        lDocumentLink.SetCurrentkey("Document Template", "Document No.");
        lDocumentLink.SetRange("Document Template", "Document Template");
        lDocumentLink.SetRange("Document No.", "No.");
        lDocumentLink.DeleteAll;
    end;

    trigger OnInsert()
    var
        lLink: Record "Workflow Document Link";
    begin
        "Creation Date" := Today;
        "Creation UserID" := UserId;

        if "No." = '' then begin
            Template.Get("Document Template");
            Template.TestField(Template."No. Series");
            NoSeriesMgt.InitSeries(Template."No. Series", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;

        lLink."Document Template" := "Document Template";
        lLink."Document No." := "No.";
        if GetFilter("Link Type Filter") <> '' then
            Evaluate(lLink.Type, GetFilter("Link Type Filter"))
        else
            lLink.Type := 0;
        lLink."No." := GetFilter("Link No. Filter");
        if (lLink.Type <> 0) and (lLink."No." <> '') then begin
            lLink.Insert(true);
            Mark(true);
        end;
    end;

    trigger OnModify()
    begin
        if xRec.Open <> Open then
            TestField(Open, false);
    end;

    var
        Template: Record "Workflow Document Template";
        NoSeriesMgt: Codeunit 396;
        Document: Record "Workflow Document";
        LoginManagement: Codeunit "User Management";


    procedure AssistEdit(OldDocument: Record "Workflow Document"): Boolean
    begin
        with Document do begin
            Document := Rec;
            Template.Get("Document Template");
            Template.TestField("No. Series");
            if NoSeriesMgt.SelectSeries(Template."No. Series", OldDocument."No. Series", "No. Series") then begin
                Template.Get("Document Template");
                Template.TestField("No. Series");
                NoSeriesMgt.SetSeries("No.");
                Rec := Document;
                exit(true);
            end;
        end;
    end;

    local procedure GetFieldCaption(FieldNo: Integer): Text[100]
    var
        "Field": Record "Field";
    begin
        Field.Get(Database::"Workflow Document", FieldNo);
        exit(Field."Field Caption");
    end;

    local procedure GetCaptionClass(pFieldNo: Integer): Text[80]
    begin
        FilterGroup(3); // FormView
        if HasFilter then
            "Document Template" := GetRangeMin("Document Template");
        FilterGroup(0);
        if ("Document Template" = 0) or not Template.Get("Document Template") then
            exit('8001400,' + GetFieldCaption(pFieldNo))
        else
            with Template do case pFieldNo of
                                 101:
                                     exit('8001400,' + Integer1);
                                 102:
                                     exit('8001400,' + Integer2);
                                 201:
                                     exit('8001400,' + Text1);
                                 202:
                                     exit('8001400,' + Text2);
                                 301:
                                     exit('8001400,' + Code1);
                                 302:
                                     exit('8001400,' + Code2);
                                 401:
                                     exit('8001400,' + Decimal1);
                                 402:
                                     exit('8001400,' + Decimal2);
                                 501:
                                     exit('8001400,' + Boolean1);
                                 502:
                                     exit('8001400,' + Boolean2);
                                 601:
                                     exit('8001400,' + Date1);
                                 602:
                                     exit('8001400,' + Date2);
                                 701:
                                     exit('8001400,' + Time1);
                                 702:
                                     exit('8001400,' + Time2);
                                 else
                                     exit('CaptionClass ' + GetFieldCaption(pFieldNo));
                end;
    end;
}

