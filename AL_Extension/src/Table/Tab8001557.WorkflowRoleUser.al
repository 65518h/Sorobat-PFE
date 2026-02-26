Table 8001557 "Workflow Role - User"
{
    //GL2024  ID dans Nav 2009 : "8004203"
    // //+WKF+ MB 10/01/07 Verification en cas de suppression de role si des fiches sont affectés
    // //+WKF+ CW 03/08/02 New

    Caption = 'Role - User';
    //  LookupPageID = 8004214;

    fields
    {
        field(1; "Role ID"; Code[10])
        {
            Caption = 'Role ID';
            TableRelation = "Workflow Role";
        }
        field(2; "User ID"; Code[20])
        {
            Caption = 'User ID';
            //GL2024 TableRelation = Login;
        }
    }

    keys
    {
        key(Key1; "Role ID", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lWkfJnlLine: Record "Workflow Journal Line";
        lWkfJnlLineNew: Record "Workflow Journal Line";
        lWkfJnlLineOld: Record "Workflow Journal Line";
    begin
        //+WKF+
        lWkfJnlLine.SetCurrentkey(Open, "Due Date");
        lWkfJnlLine.SetRange(Open, true);
        lWkfJnlLine.SetRange("To Role", "Role ID");
        lWkfJnlLine.SetRange("To User ID", "User ID");
        if not lWkfJnlLine.IsEmpty then
            if Confirm(Text001, false, lWkfJnlLine.Count, "User ID") then begin
                lWkfJnlLine.Find('-');
                repeat
                    lWkfJnlLineNew.Copy(lWkfJnlLine);
                    lWkfJnlLineOld.Get(lWkfJnlLine."Entry No.");
                    lWkfJnlLineOld.Open := false;
                    lWkfJnlLineOld.Modify();
                    lWkfJnlLineNew."Entry No." := 0;
                    lWkfJnlLineNew."To User ID" := '';
                    lWkfJnlLineNew.Insert(true);
                until lWkfJnlLine.Next = 0;
            end else
                Error('');
        //+WKF+//
    end;

    var
        Text001: label '%2 has %1 task, Would you continue ?';


    procedure UserRoleFilter() Return: Text[1000]
    begin
        if UserId = '' then
            exit('');
        SetRange("User ID", UserId);
        if not IsEmpty then
            if Find('-') then begin
                Return := '''''';
                repeat
                    Return := Return + '|' + "Role ID";
                until Next = 0;
            end;
    end;
}

