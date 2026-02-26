Table 8001570 "Workflow Cue"
{
    //GL2024  ID dans Nav 2009 : "8004229"
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Notification Number 1"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To Role" = field(filter("Role Filter 1")),
                                                               "To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter")));
            //CaptionClass = GetCaptionClass(10);
            FieldClass = FlowField;
        }
        field(11; "Notification Number 2"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To Role" = field(filter("Role Filter 2")),
                                                               "To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter")));
            //CaptionClass = GetCaptionClass(11);
            FieldClass = FlowField;
        }
        field(12; "Notification Number 3"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To Role" = field(filter("Role Filter 3")),
                                                               "To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter")));
            //CaptionClass = GetCaptionClass(12);
            FieldClass = FlowField;
        }
        field(13; "Notification Number 4"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To Role" = field(filter("Role Filter 4")),
                                                               "To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter")));
            //CaptionClass = GetCaptionClass(13);
            FieldClass = FlowField;
        }
        field(14; "Notification Number 5"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To Role" = field(filter("Role Filter 5")),
                                                               "To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter")));
            //CaptionClass = GetCaptionClass(14);
            FieldClass = FlowField;
        }
        field(15; "Notification Number 6"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To Role" = field(filter("Role Filter 6")),
                                                               "To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter")));
            //CaptionClass = GetCaptionClass(15);
            FieldClass = FlowField;
        }
        field(16; "Notification Number 7"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To Role" = field(filter("Role Filter 7")),
                                                               "To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter")));
            //CaptionClass = GetCaptionClass(16);
            FieldClass = FlowField;
        }
        field(17; "Notification Number 8"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To Role" = field(filter("Role Filter 8")),
                                                               "To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter")));
            //CaptionClass = GetCaptionClass(17);
            FieldClass = FlowField;
        }
        field(18; "Notification Number 9"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To Role" = field(filter("Role Filter 9")),
                                                               "To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter")));
            //CaptionClass = GetCaptionClass(18);
            FieldClass = FlowField;
        }
        field(19; "Notification Number 10"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To Role" = field(filter("Role Filter 10")),
                                                               "To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter")));
            //CaptionClass = GetCaptionClass(19);
            FieldClass = FlowField;
        }
        field(20; "Notify Workflow Journal Line"; Integer)
        {
            CalcFormula = count("Workflow Journal Line" where("To User ID" = field("User Filter"),
                                                               Open = const(true),
                                                               "Due Date" = field("Due Date Filter"),
                                                               Notification = const(true)));
            Caption = 'Notify Workflow Journal Line';
            Description = '#9184';
            FieldClass = FlowField;
        }
        field(110; "Role Filter 1"; Code[10])
        {
            //CaptionClass = GetCaptionClass(110);
            FieldClass = FlowFilter;
        }
        field(111; "Role Filter 2"; Code[10])
        {
            //CaptionClass = GetCaptionClass(111);
            FieldClass = FlowFilter;
        }
        field(112; "Role Filter 3"; Code[10])
        {
            //CaptionClass = GetCaptionClass(112);
            FieldClass = FlowFilter;
        }
        field(113; "Role Filter 4"; Code[10])
        {
            //CaptionClass = GetCaptionClass(113);
            FieldClass = FlowFilter;
        }
        field(114; "Role Filter 5"; Code[10])
        {
            //CaptionClass = GetCaptionClass(114);
            FieldClass = FlowFilter;
        }
        field(115; "Role Filter 6"; Code[10])
        {
            //CaptionClass = GetCaptionClass(115);
            FieldClass = FlowFilter;
        }
        field(116; "Role Filter 7"; Code[10])
        {
            //CaptionClass = GetCaptionClass(116);
            FieldClass = FlowFilter;
        }
        field(117; "Role Filter 8"; Code[10])
        {
            //CaptionClass = GetCaptionClass(117);
            FieldClass = FlowFilter;
        }
        field(118; "Role Filter 9"; Code[10])
        {
            //CaptionClass = GetCaptionClass(118);
            FieldClass = FlowFilter;
        }
        field(119; "Role Filter 10"; Code[10])
        {
            //CaptionClass = GetCaptionClass(119);
            FieldClass = FlowFilter;
        }
        field(1000; "User Filter"; Code[20])
        {
            Caption = 'User filter';
            FieldClass = FlowFilter;
        }
        field(1001; "Due Date Filter"; Date)
        {
            Caption = 'Due Date';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure GetCaptionClass(pField: Integer) return: Text[30]
    var
        lRole: Code[20];
        lReturn: Text[50];
    begin
        case pField of
            10, 110:
                lRole := GetFilter("Role Filter 1");
            11, 111:
                lRole := GetFilter("Role Filter 2");
            12, 112:
                lRole := GetFilter("Role Filter 3");
            13, 113:
                lRole := GetFilter("Role Filter 4");
            14, 114:
                lRole := GetFilter("Role Filter 5");
            15, 115:
                lRole := GetFilter("Role Filter 6");
            16, 116:
                lRole := GetFilter("Role Filter 7");
            17, 117:
                lRole := GetFilter("Role Filter 8");
            18, 118:
                lRole := GetFilter("Role Filter 9");
            19, 119:
                lRole := GetFilter("Role Filter 10");
        end;
        return := GetRoleCaptionClass(pField, lRole, lReturn);
        return := lReturn;
    end;


    procedure GetRoleCaptionClass(pField: Integer; pRole: Text[30]; var pReturn: Text[50]): Text[50]
    var
        lRole: Record "Workflow Role";
        TextFilter: label '%1 Filter';
        lRecRef: RecordRef;
        lFieldRef: FieldRef;
        TextField: label '%1 Filter';
    begin
        if lRole.Get(pRole) then begin
            case pField of
                10:
                    pReturn := StrSubstNo(TextField, lRole.Description);
                11 .. 20:
                    pReturn := StrSubstNo(TextField, lRole.Description);
                100, 120:
                    pReturn := StrSubstNo(TextFilter, lRole.Description);
            end;
        end else begin
            lRecRef.GetTable(Rec);
            lFieldRef := lRecRef.Field(pField);

            case pField of
                9 .. 20:
                    pReturn := StrSubstNo(TextField, lFieldRef.Name);
                100, 120:
                    pReturn := StrSubstNo(TextFilter, lFieldRef.Name);
            end;
        end;
    end;
}

