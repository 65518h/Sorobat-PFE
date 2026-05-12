Codeunit 8001495 ObjectUsageSingleInst
{
    // //+REF+OBJECT_USAGE CW 18/10/10 Source http://dynamicsuser.net/blogs/mark_brummel/archive/2009/12/01/tip-20-save-report-usage.aspx

    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        ObjectUsageTemp: Record "Object Usage Log" temporary;


    procedure Log(pObjectType: Integer; pObjectID: Integer)
    var
        lExists: Boolean;
    begin
        with ObjectUsageTemp do begin
            Init;
            "Object Type" := pObjectType;
            "Object ID" := pObjectID;
            Date := Today;
            "User ID" := UserId;
            "Company Name" := COMPANYNAME;
            lExists := Get("Object Type", "Object ID", Date, "User ID", "Company Name");
            "No. of Usage" += 1;
            if lExists then
                Modify
            else
                Insert;
        end;
    end;


    procedure Save()
    var
        lObjectUsage: Record "Object Usage Log";
    begin
        if ObjectUsageTemp.FindSet then
            repeat
                with lObjectUsage do begin
                    Copy(ObjectUsageTemp);
                    if Find('=') then begin
                        "No. of Usage" += ObjectUsageTemp."No. of Usage";
                        Modify;
                    end else begin
                        "No. of Usage" := ObjectUsageTemp."No. of Usage";
                        Insert;
                    end;
                end;
            until ObjectUsageTemp.Next = 0;
    end;
}

