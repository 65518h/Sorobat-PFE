Table 8001525 "Statistic Scheduler header"
{
    //GL2024  ID dans Nav 2009 : "8001319"
    // //STATSEXPLORER STATSEXPLORER 01/10/10 Day,Week,Month,Quarter,Year,Period

    Caption = 'Statistic Scheduler header';
    //LookupPageID = 8001313;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(3; "Process agregate"; Boolean)
        {
            Caption = 'Process aggregate';
        }
        field(4; "Process from date"; DateFormula)
        {
            Caption = 'Process from date';

            trigger OnValidate()
            begin
                if (CopyStr(Format("Process from date"), 1, 1) <> '-') and (CopyStr(Format("Process from date"), 1, 1) <> '+') then
                    Message(Message1);
            end;
        }
        field(5; "Process to date"; DateFormula)
        {
            Caption = 'Process to date';

            trigger OnValidate()
            begin
                if (CopyStr(Format("Process to date"), 1, 1) <> '-') and (CopyStr(Format("Process to date"), 1, 1) <> '+') then
                    Message(Message1);
            end;
        }
        field(6; "Period total basis"; Option)
        {
            Caption = 'Period total basis';
            OptionCaption = 'Day,Week,Month,Quarter,Year,Period';
            OptionMembers = Day,Week,Month,Quarter,Year,Period;
        }
        field(10; "Last calculation date"; Date)
        {
            Caption = 'Last calculation date';
            Editable = false;
        }
        field(11; "Frequency of calculation"; DateFormula)
        {
            Caption = 'Frequency of calculation';
        }
        field(12; "Type of treatment"; Option)
        {
            OptionCaption = 'All,Non real-time entries';
            OptionMembers = All,"Only non-real time entries";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LigneAutomate.SetRange("Code treatment", Code);
        if not LigneAutomate.IsEmpty then
            LigneAutomate.DeleteAll;
        UserAutomate.SetRange("Sheduler code", Code);
        if not LigneAutomate.IsEmpty then
            UserAutomate.DeleteAll;
    end;

    var
        LigneAutomate: Record "Statistic Scheduler line";
        Message1: label 'Attention : Process from date and Process to date should contain "+" or "-"';
        UserAutomate: Record "Statistic User";
}

