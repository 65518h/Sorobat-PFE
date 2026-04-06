Table 8001564 "Workflow Document Template"
{
    //GL2024  ID dans Nav 2009 : "8004221"
    // //+WKF+DOC CW 24/08/02 Workflow Template

    Caption = 'Document Type';
    //LookupPageID = 8004220;

    fields
    {
        field(1; "Document Template"; Integer)
        {
            //blankzero = true;
            Caption = 'Document Template';
            NotBlank = true;
            //GL2024 License  TableRelation = Object.ID where(Type = const(PAGE));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(PAGE));
            //GL2024 License

            trigger OnValidate()
            var
                lAllObjWithCaption: Record AllObjWithCaption;
            begin
                if lAllObjWithCaption.Get(lAllObjWithCaption."object type"::page, "Document Template") then
                    Description := lAllObjWithCaption."Object Caption";
            end;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(3; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(4; "Default Link Type"; Integer)
        {
            //blankzero = true;
            Caption = 'Default Link Type';
            TableRelation = "Workflow Type" where("Link Enable" = const(true));
        }
        field(5; "Role ID"; Code[10])
        {
            Caption = 'Role ID';
            TableRelation = "Workflow Role";
        }
        field(6; "Report ID"; Integer)
        {
            //blankzero = true;
            Caption = 'Report No.';
            //GL2024 License    TableRelation = Object.ID where(Type = const(Report));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Report));
            //GL2024 License
        }
        field(7; "Report Caption"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report),
                                                                           "Object ID" = field("Report ID")));
            Caption = 'Report Name';
            FieldClass = FlowField;
        }
        field(8; "Codeunit ID"; Integer)
        {
            //blankzero = true;
            Caption = 'N° codeunit';
            //GL2024 License     TableRelation = Object.ID where(Type = const(Codeunit));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Codeunit));
            //GL2024 License
        }
        field(9; "Codeunit Caption"; Text[80])
        {
            /*   //GL2024 License    CalcFormula = lookup(Object.Name where(Type = const(Codeunit),
                                                        ID = field("Codeunit ID")));*/   //GL2024 License
                                                                                         //GL2024 License
            CalcFormula = lookup(AllObj."Object Name" where("Object Type" = const(Codeunit),
                                                   "Object ID" = field("Codeunit ID")));
            //GL2024 License
            Caption = 'Codeunit Name';
            FieldClass = FlowField;
        }
        field(101; Integer1; Text[30])
        {
            Caption = 'Integer1';
        }
        field(102; Integer2; Text[30])
        {
            Caption = 'Integer2';
        }
        field(201; Text1; Text[30])
        {
            Caption = 'Text1';
        }
        field(202; Text2; Text[30])
        {
            Caption = 'Text2';
        }
        field(301; Code1; Text[30])
        {
            Caption = 'Code1';
        }
        field(302; Code2; Text[30])
        {
            Caption = 'Code2';
        }
        field(401; Decimal1; Text[30])
        {
            Caption = 'Amount1';
        }
        field(402; Decimal2; Text[30])
        {
            Caption = 'Amount2';
        }
        field(501; Boolean1; Text[30])
        {
            Caption = 'Yes/No1';
        }
        field(502; Boolean2; Text[30])
        {
            Caption = 'Yes/No2';
        }
        field(601; Date1; Text[30])
        {
            Caption = 'Date1';
        }
        field(602; Date2; Text[30])
        {
            Caption = 'Date2';
        }
        field(701; Time1; Text[30])
        {
            Caption = 'Time1';
        }
        field(702; Time2; Text[30])
        {
            Caption = 'Time2';
        }
    }

    keys
    {
        key(STG_Key1; "Document Template")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

