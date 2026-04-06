Table 8003923 "Job Status"
{
    // //JOB_STATUS CW 24/10/05 +Job Status Check Rules
    // //TRANSLATION CW 11/10/05 OnDelete, OnRename

    Caption = 'Job Status';
    //    LookupPageID = 8003935;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Planning,Quote,Order,Completed';
            OptionMembers = Planning,Quote,"Order",Completed;
        }
        field(4; "To Status Filter"; Code[10])
        {
            Caption = 'To Status Filter';
            FieldClass = FlowFilter;
        }
        field(5; "To Status Granted"; Boolean)
        {
            CalcFormula = exist("Job Status Matrix" where("From Status" = field(Code),
                                                           "To Status Code" = field("To Status Filter")));
            Caption = 'User Granted';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "To Status Granted" := xRec."To Status Granted";
            end;
        }
        field(6; "Start Status"; Boolean)
        {
            Caption = 'First Status';
        }
        field(7; "Codeunit ID"; Integer)
        {
            //blankzero = true;
            Caption = 'Codeunit ID';
            //GL2024 License TableRelation = Object.ID where(Type = const(Codeunit));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Codeunit));
            //GL2024 License

            trigger OnLookup()
            var
                //GL2024 License      lObject: Record "Object";
                //GL2024 License
                lObject: Record AllObj;
            //GL2024 License
            begin
                lObject.SetRange("Object Type", lObject."Object Type"::Codeunit);
                if PAGE.RunModal(page::Objects, lObject) = Action::LookupOK then
                    "Codeunit ID" := lObject."Object id";
                CalcFields("Codeunit Caption")
            end;

            trigger OnValidate()
            begin
                CalcFields("Codeunit Caption")
            end;
        }
        field(8; "Codeunit Caption"; Text[30])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Codeunit),
                                                                           "Object ID" = field("Codeunit ID")));
            Caption = 'Table Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Sales Document"; Boolean)
        {
            Caption = 'Sales Document';
        }
        field(11; "Sales Quote to Order"; Boolean)
        {
            Caption = 'Quote to Order';
        }
        field(12; "Sales Posting"; Boolean)
        {
            Caption = 'Sales Posting';
        }
        field(13; "Sales to Initial Job Budget"; Boolean)
        {
            Caption = 'Initial Budget Update';
        }
        field(14; "Sales to Audit Job Budget"; Boolean)
        {
            Caption = 'Audit Budget Update';
        }
        field(15; "Cost Forecast Update"; Boolean)
        {
            Caption = 'Forecast Budget Update';
        }
        field(21; "Reordering Requisition"; Boolean)
        {
            Caption = 'Reordering Requisition';
        }
        field(30; "Purchase Order"; Boolean)
        {
            Caption = 'Purchase Document';
        }
        field(31; "Purchase Posting"; Boolean)
        {
            Caption = 'Purchase Positng';
        }
        field(40; "Usage Posting"; Boolean)
        {
            Caption = 'Activity Posting';
        }
        field(41; "Resource Posting"; Boolean)
        {
            Caption = 'Work Activity Posting';
        }
        field(51; "WIP Balancing"; Boolean)
        {
            Caption = 'WIP Balancing';
        }
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
        key(STG_Key2; Synchronise)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //TRANSLATION
        lRecordRef.GetTable(Rec);
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo(Description), Code);
        //TRANSLATION//
    end;

    trigger OnRename()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //TRANSLATION
        lRecordRef.GetTable(Rec);
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo(Description), xRec.Code, Code);
        //TRANSLATION
    end;


    procedure Check(pJobNo: Code[20]; pFieldNo: Integer)
    var
        lJobStatusMgt: Codeunit "Job Status Management";
    begin
        lJobStatusMgt.Check(pJobNo, pFieldNo);
    end;
}

