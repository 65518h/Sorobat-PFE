page 52048962 "Base Calendar Card P"
{//GL2024  ID dans Nav 2009 : "39001483"
    Caption = 'Fiche calendrier principal';
    PageType = Card;
    SourceTable = "Base Calendar";
    UsageCategory = Administration;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Customized Changes Exist"; rec."Customized Changes Exist")
                {
                    ApplicationArea = all;
                }
            }
            part(BaseCalendarEntries; "Monthly Calendar")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("&Maintain Base Calendar Changes1"; "&Maintain Base Calendar Changes") { }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Maintain Base Calendar Changes")
                {
                    ApplicationArea = all;
                    Caption = '&Maintain Base Calendar Changes';
                    RunObject = Page "Base Calendar Changes";
                    RunPageLink = "Base Calendar Code" = FIELD(Code);
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Currentdate := WORKDATE;
        //Currpage.BaseCalendarEntries.FORM.SetCalendarCode(Code);
        //DYS a verifier
        //CurrPage.BaseCalendarEntries.page.SetCalendarCode(1, 0, '', '', rec.Code, Currentdate);
    end;

    var
        Currentdate: Date;
}

