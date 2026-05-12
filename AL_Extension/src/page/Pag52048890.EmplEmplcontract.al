page 52048890 "Empl - Empl.contract"
{
    //GL2024  ID dans Nav 2009 : "39001411"
    Editable = false;
    PageType = listPart;
    SourceTable = Employee;
    Caption = 'Empl - Empl.contract';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("""First And Last Name"" + ' ' + ""Last Name"""; rec."First Name" + ' ' + Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

