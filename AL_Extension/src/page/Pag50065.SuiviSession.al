Page 50065 "Suivi Session"
{
    PageType = list;
    SourceTable = Session;
    SourceTableView = where("Database Name" = const('SOROUBAT'), "Application Name" = const('Microsoft Dynamics NAV Classic client'));
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Session Tracking';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("Connection ID"; rec."Connection ID")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("My Session"; rec."My Session")
                {
                    ApplicationArea = all;
                }
                field("Login Time"; rec."Login Time")
                {
                    ApplicationArea = all;
                }
                field("Login Date"; rec."Login Date")
                {
                    ApplicationArea = all;
                }
                field("Login Type"; rec."Login Type")
                {
                    ApplicationArea = all;
                }
                field("Application Name"; rec."Application Name")
                {
                    ApplicationArea = all;
                }
                field(posMin; posMin)
                {
                    ApplicationArea = all;
                }
                field(PosHeure; PosHeure)
                {
                    ApplicationArea = all;
                }
                field("Host Name"; rec."Host Name")
                {
                    ApplicationArea = all;
                }
                /*GL2024 field("Idle Time"; rec."Idle Time")
                 {
                     ApplicationArea = all;
                 }*/
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Kill Session")
            {
                ApplicationArea = all;
                Caption = 'Kill Session';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    RecSession.Reset;
                    RecSession.Copy(Rec);
                    RecSession.SetFilter("Login Date", '<%1', Today);
                    RecSession.SetRange("My Session", false);
                    if RecSession.FindFirst then
                        repeat
                        //  RecSession.DELETE;
                        until RecSession.Next = 0;



                    RecSession.Reset;
                    RecSession.Copy(Rec);
                    //RecSession.SETFILTER("Idle Time",'%1','*Minutes*');
                    if rec.FindFirst then
                        repeat
                            /*GL2024 Chaine := Format(rec."Idle Time");
                            Now := Format(rec."Idle Time");*/
                            posMin := StrPos(Chaine, 'minute');
                            PosHeure := StrPos(Chaine, 'heure');
                        until rec.Next = 0;
                end;
            }
        }
    }

    var
        RecSession: Record Session;
        Text001: label 'Effectuer Cette Tache';
        Now: Text[30];
        posMin: Integer;
        PosHeure: Integer;
        Chaine: Text[100];
}

