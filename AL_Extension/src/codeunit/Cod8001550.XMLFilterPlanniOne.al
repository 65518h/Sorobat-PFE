Codeunit 8001550 "XML Filter PlanniOne"
{
    //GL2024  ID dans Nav 2009 : "8035003"
    // #7457 OFE 21/10/09


    trigger OnRun()
    begin
    end;

    var
        gFilter: Record "Filter Header";


    procedure fFilterRes(var pResource: Record Resource; pFilterCode: Code[10])
    begin
        if pFilterCode = '' then
            exit;
        gFilter.Get(Database::Resource, pFilterCode);
        pResource.SetView(gFilter.Get_View);
    end;


    procedure fFilterRole(var pRole: Record "Resource Group"; pFilterCode: Code[10])
    begin
        if pFilterCode = '' then
            exit;
        gFilter.Get(Database::"Resource Group", pFilterCode);
        pRole.SetView(gFilter.Get_View);
    end;


    procedure fFilterSkill(var pSkill: Record "Planning Skill"; pFilterCode: Code[10])
    begin
        if pFilterCode = '' then
            exit;
        //#7457
        //gFilter.GET(DATABASE::"Resource Group",pFilterCode);
        gFilter.Get(Database::"Planning Skill", pFilterCode);
        //#7457//
        pSkill.SetView(gFilter.Get_View);
    end;


    procedure fFilterScheduleTemplate(var pScheduleTemplate: Record "Weekly Schedule Template"; pFilterCode: Code[10])
    begin
        if pFilterCode = '' then
            exit;
        //#7457
        //gFilter.GET(DATABASE::"Resource Group",pFilterCode);
        gFilter.Get(Database::"Weekly Schedule Template", pFilterCode);
        //#7457//
        pScheduleTemplate.SetView(gFilter.Get_View);
    end;
}

