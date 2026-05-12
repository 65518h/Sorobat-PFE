Page 52048949 "Change Status on Work.Order11"
{//GL2024  ID dans Nav 2009 : "39002164"
    Caption = 'Change Status on Work Order';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                label(Control2)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19024205;
                    MultiLine = true;
                }
                field(FirmPlannedStatus; NewStatus)
                {
                    ApplicationArea = Basic;
                    Caption = 'New Status';
                    OptionCaption = ',,Firm Planned,Released,Finished';

                    trigger OnValidate()
                    begin
                        if NewStatus = Newstatus::Terminé then
                            Termin233NewStatusOnValidate;
                        if NewStatus = Newstatus::Lancé then
                            Lanc233NewStatusOnValidate;
                        if NewStatus = Newstatus::"Planifié ferme" then
                            Planifi233fermeNewStatusOnVali;
                    end;
                }
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field(cost; ReqUpdUnitCost)
                {
                    ApplicationArea = Basic;
                    Caption = 'Update costs';
                }
                field(it; ValidateItem)
                {
                    ApplicationArea = Basic;
                    Caption = 'Validate Item Consumption';
                    Editable = itEditable;
                }
                field(res; ValidateRes)
                {
                    ApplicationArea = Basic;
                    Caption = 'Validate Resoure Consumption';
                    Editable = resEditable;
                }
                field(Pit; PrintItem)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print Items consumption Doc.';
                    Editable = PitEditable;
                }
                field(Pres; PrintRes)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print Res. consumption Doc.';
                    Editable = PresEditable;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        FinishedStatusEditable := true;
        ReleasedStatusEditable := true;
        FirmPlannedStatusEditable := true;
    end;

    trigger OnOpenPage()
    begin
        ReqUpdUnitCost := true;
    end;

    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin
        //GL3900  if CloseAction = Action::Yes then
        //GL3900    YesOnPush;
    end;

    var
        NewStatus: Option "Simulé","Planifié","Planifié ferme","Lancé","Terminé";
        PostingDate: Date;
        ReqUpdUnitCost: Boolean;
        ValidateRes: Boolean;
        ValidateItem: Boolean;
        PrintItem: Boolean;
        PrintRes: Boolean;
        //GL3900    RecGOTP: Record OTP;
        //  RecBTP: Record BTP;
        Text000: label 'L''enregistrement OTP %1 %2 a été transformé en OTP %3.';
        AncienStatus: Option "Simulé","Planifié","Planifié ferme","Lancé","Terminé";
        [InDataSet]
        itEditable: Boolean;
        [InDataSet]
        resEditable: Boolean;
        [InDataSet]
        PitEditable: Boolean;
        [InDataSet]
        PresEditable: Boolean;
        [InDataSet]
        FirmPlannedStatusEditable: Boolean;
        [InDataSet]
        ReleasedStatusEditable: Boolean;
        [InDataSet]
        FinishedStatusEditable: Boolean;
        Text666: label '%1 is not a valid selection.';
        Text19024205: label 'Do you want to change the status of this Work Order?';
    //GL3900 

    /*
        procedure Set(WorkOrder: Record OTP)
        begin
            FirmPlannedStatusEditable := WorkOrder.status < WorkOrder.Status::"Planifié ferme";
            ReleasedStatusEditable := WorkOrder.status <> WorkOrder.Status::Lancé;
            FinishedStatusEditable := WorkOrder.status = WorkOrder.Status::Lancé;


            if WorkOrder.status > WorkOrder.Status::Simulé then
                NewStatus := WorkOrder.status + 1
            else
                NewStatus := Newstatus::"Planifié ferme";

            PostingDate := WorkDate;

            //Affichage des booléens de validation des consommations
            itEditable := NewStatus >= Newstatus::Lancé;
            resEditable := NewStatus >= Newstatus::Lancé;
            PitEditable := NewStatus >= Newstatus::Lancé;
            PresEditable := NewStatus >= Newstatus::Lancé;
            if NewStatus >= Newstatus::Lancé then begin
                ValidateRes := true;
                ValidateItem := true;
            end;
        end;

    */
    //GL3900 
    procedure ReturnPostingInfo(var Status: Option Simulated,Planned,"Firm Planned",Released,Finished; var PostingDate2: Date; var UpdUnitCost: Boolean)
    begin
        Status := NewStatus;
        PostingDate2 := PostingDate;
        UpdUnitCost := ReqUpdUnitCost;
    end;


    procedure ReturnValidationInfo(var ValIt: Boolean; var ValRe: Boolean; var PrintI: Boolean; var PrintR: Boolean)
    begin
        ValIt := ValidateItem;
        ValRe := ValidateRes;
        PrintI := PrintItem;
        PrintR := PrintRes;
    end;
    //GL3900 
    /*
        procedure GetRec(RecOTP: Record OTP)
        begin
            RecGOTP := RecOTP;
        end;

        local procedure YesOnPush()
        begin
            AncienStatus := RecGOTP.status;
            if NewStatus = Newstatus::"Planifié ferme" then begin
                RecGOTP.status := RecGOTP.Status::"Planifié ferme";
                RecGOTP.Modify;
                Commit;
            end else
                if NewStatus = Newstatus::Lancé then begin
                    RecGOTP.status := RecGOTP.Status::Lancé;
                    RecGOTP.Modify;
                    Commit;
                end else
                    if NewStatus = Newstatus::Terminé then begin
                        RecGOTP.status := RecGOTP.Status::Terminé;
                        RecGOTP.Modify;
                        Commit;
                    end;
            RecBTP.Reset;
            RecBTP.SetRange(cd_OTP, RecGOTP."code OTP");
            if RecBTP.FindFirst then
                repeat
                begin
                    RecBTP.status := RecGOTP.status;
                    RecBTP.Modify;
                end;
                until RecBTP.Next = 0;
            Message(Text000, RecGOTP."code OTP", AncienStatus, NewStatus)
        end;
    */
    //GL3900 
    local procedure Planifi233fermeNewStatusOnVali()
    begin
        if not (FirmPlannedStatusEditable) then
            Error(Text666, NewStatus);
        if NewStatus = Newstatus::"Planifié ferme" then begin
            itEditable := false;
            resEditable := false;
            ValidateRes := false;
            ValidateItem := false;
            PitEditable := false;
            PresEditable := false;
            PrintItem := false;
            PrintRes := false;
        end;
    end;

    local procedure Lanc233NewStatusOnValidate()
    begin
        if not (ReleasedStatusEditable) then
            Error(Text666, NewStatus);
        if NewStatus = Newstatus::Lancé then begin
            itEditable := true;
            resEditable := true;
            ValidateRes := true;
            ValidateItem := true;
            PitEditable := true;
            PresEditable := true;
            PrintItem := false;
            PrintRes := false;

        end;
    end;

    local procedure Termin233NewStatusOnValidate()
    begin
        if not (FinishedStatusEditable) then
            Error(Text666, NewStatus);
        if NewStatus = Newstatus::Terminé then begin
            itEditable := true;
            resEditable := true;
            ValidateRes := true;
            ValidateItem := true;
            PitEditable := true;
            PresEditable := true;
            PrintItem := false;
            PrintRes := false;

        end;
    end;
}

