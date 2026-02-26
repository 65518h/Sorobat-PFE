Page 50142 "M.A.J. Rappel Salarié"
{
    // MultipleNewLines = true;
    PageType = List;
    SourceTable = "Default Indemnities";
    SourceTableView = sorting("Type Indemnité", "Indemnity Code", "Employment Contract Code")
                      where("Indemnity Code" = filter(443));
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'M.A.J. Rappel Salarié';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Employment Contract Code"; REC."Employment Contract Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                    Style = Strong;
                    StyleExpr = true;
                    trigger OnValidate()
                    begin
                        if RecEmployee.Get(REC."Employment Contract Code") then
                            EmplyName := RecEmployee."First Name";
                    end;
                }
                field("Indemnity Code"; REC."Indemnity Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(EmplyName; EmplyName)
                {
                    ApplicationArea = all;
                    Caption = 'Salarié';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                // field("RecEmployee.""First And Last Name"""; RecEmployee."First Name")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Salarié';
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                field("Default amount"; REC."Default amount")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Type Indemnité"; REC."Type Indemnité")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if RecEmployee.Get(REC."Employment Contract Code") then
            EmplyName := RecEmployee."First Name";
    end;

    var
        RecEmployee: Record Employee;
        EmplyName: Text[100];
}

