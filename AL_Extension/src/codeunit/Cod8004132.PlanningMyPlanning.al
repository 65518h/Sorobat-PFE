Codeunit 8004132 "Planning My Planning"
{
    // //PLANNING_TASK CW 27/08/09 MyPlanning


    trigger OnRun()
    var
        lResource: Record Resource;
    begin
        if UserId = '' then
            lResource.TestField("User ID");
        lResource.SetCurrentkey("User ID");
        lResource.SetRange("User ID", UserId);
        if lResource.FindFirst then
            PAGE.Run(page::"Resource Availability", lResource)
        else
            Error(tNoResource, UserId);
    end;

    var
        tNoResource: label 'No resource defined for user %1.';
}

