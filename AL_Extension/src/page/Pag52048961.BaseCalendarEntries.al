page 52048961 "Base Calendar Entries"
{//GL2024  ID dans Nav 2009 : "39001482"
    Caption = 'Sous-form. écritures calendrier principal';
    SourceTable = Date;
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group("Horraire du Travail")
            {
                Caption = 'Horraire du Travail';
                field("Period Start"; Rec."Period Start")
                {
                    ApplicationArea = Basic;
                    Caption = 'Début période';
                }
                field("<Jour Chomé>"; Nonworking)
                {
                    ApplicationArea = Basic;
                    Caption = 'Jour Chomé';

                    trigger OnValidate()
                    begin
                        Modif := true;
                    end;
                }
                group(Matin)
                {

                    Caption = 'Matin';

                    field(HeureDM; HeureDM)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Heure Debut';

                        trigger OnValidate()
                        begin
                            Modif := true;
                        end;
                    }
                    field(HeureFM; HeureFM)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Heure Fin';

                        trigger OnValidate()
                        begin
                            Modif := true;
                        end;
                    }

                    label("Après Midi")
                    {
                        ApplicationArea = Basic;
                    }
                    field(HeureDA; HeureDA)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Heure Debut';

                        trigger OnValidate()
                        begin
                            Modif := true;
                        end;
                    }
                    field(HeureFA; HeureFA)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Heure Fin';

                        trigger OnValidate()
                        begin
                            Modif := true;
                        end;
                    }
                }
                group(Description1)
                {

                    Caption = 'Description';

                    field(Description; Desc)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
    }

    actions
    {

    }

    trigger OnAfterGetRecord()
    begin
        Nonworking := CheckDateStatus(CurrentCalendarCode, Rec."Period Start", Desc);
        //WeekNo := DATE2DWY("Period Start",2);
        //DYS fonction n'existe pas dans NAV
        // CalendarMgmt.CheckDateTime(CurrentCalendarCode, rec."Period Start", HeureDM, HeureFM, HeureDA, HeureFA, Nonworking, JourFree);
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(PeriodFormMgt.FindDate(Which, Rec, ItemPeriodLength));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //EXIT(PeriodFormMgt.NextDate(Steps,Rec,ItemPeriodLength));
    end;

    trigger OnOpenPage()
    begin
        Rec.Reset;
        //GL2024 Rec.SetFilter("Period Start", '>%1', 00001231D);
        Modif := false;
    end;

    var
        Item: Record Item;
        //GL2024  PeriodFormMgt: Codeunit 359;
        //GL2024
        PeriodFormMgt: Codeunit PeriodPageManagement;
        ItemPeriodLength: Option Day,Week,Month,Quarter,Year,Period;
        Nonworking: Boolean;
        Description: Text[50];
        CurrentCalendarCode: Code[10];
        CalendarMgmt: Codeunit "Calendar Management";
        BaseCalendarChange: Record "Base Calendar Change";
        WeekNo: Integer;
        HeureDM: Time;
        HeureFM: Time;
        HeureDA: Time;
        HeureFA: Time;
        Modif: Boolean;
        Desc: Text[50];
        DatedebR: Date;
        NligneR: Integer;
        JourFree: Boolean;


    procedure SetCalendarCode(CalendarCode: Code[10])
    begin
        CurrentCalendarCode := CalendarCode;
        CurrPage.Update;
        //CurrForm.UPDATECONTROLS;
    end;


    procedure UpdateBaseCalendarChanges()
    begin
        if Nonworking then begin
            Clear(HeureDM);
            Clear(HeureFM);
            Clear(HeureDA);
            Clear(HeureFA);
        end
        else
            Clear(Desc);
        BaseCalendarChange.Reset;
        BaseCalendarChange.SetRange("Base Calendar Code", CurrentCalendarCode);
        BaseCalendarChange.SetRange(Date, Rec."Period Start");
        if BaseCalendarChange.Find('-') then
            BaseCalendarChange.Delete;
        if (Nonworking) or (HeureDM <> 0T) or (HeureFM <> 0T) or (HeureDA <> 0T) or (HeureFA <> 0T) then begin
            BaseCalendarChange.Init;
            BaseCalendarChange."Base Calendar Code" := CurrentCalendarCode;
            BaseCalendarChange.Date := Rec."Period Start";
            BaseCalendarChange.Description := Desc;
            BaseCalendarChange.Nonworking := Nonworking;
            BaseCalendarChange.Day := Rec."Period No.";

            /* GL2024   BaseCalendarChange."Heure Début (Matin)" := HeureDM;
                BaseCalendarChange."Heure Fin (Matin)" := HeureFM;
                BaseCalendarChange."Heure Début (Après Midi)" := HeureDA;
                BaseCalendarChange."Heure Fin (Après Midi)" := HeureFA;*/
            BaseCalendarChange.Insert;
        end;

    end;


    procedure GetCurrentDate(): Date
    begin
        exit(Rec."Period Start");
    end;


    procedure SetCalendarCodeTmp(var CalendarCode: Code[10])
    begin
        CurrentCalendarCode := CalendarCode;
    end;


    procedure SetCalendarCodeTmp1(var CalendarCode: Code[10]; DateDeb: Date; NligneT: Integer)
    begin
        CurrentCalendarCode := CalendarCode;
        DatedebR := DateDeb;
        NligneR := NligneT;
    end;

    procedure CheckDateStatus(CalendarCode: code[10]; TargetDate: Date; var Description: text[50]): Boolean
    var
        BaseCalChange: Record "Base Calendar Change";
    begin

        BaseCalChange.RESET;
        BaseCalChange.SETRANGE("Base Calendar Code", CalendarCode);
        IF BaseCalChange.FINDSET THEN
            REPEAT
                CASE BaseCalChange."Recurring System" OF
                    BaseCalChange."Recurring System"::" ":
                        //PLANNING
                        //        IF TargetDate = BaseCalChange.Date THEN BEGIN
                        IF (TargetDate = BaseCalChange.Date) AND (BaseCalChange."To Date" = 0D) OR
                           (TargetDate >= BaseCalChange.Date) AND (TargetDate <= BaseCalChange."To Date") THEN BEGIN
                            //PLANNING//
                            Description := BaseCalChange.Description;
                            EXIT(BaseCalChange.Nonworking);
                        END;
                    BaseCalChange."Recurring System"::"Weekly Recurring":
                        IF DATE2DWY(TargetDate, 1) = BaseCalChange.Day THEN BEGIN
                            Description := BaseCalChange.Description;
                            EXIT(BaseCalChange.Nonworking);
                        END;
                    //PLANNING

                    BaseCalChange."Recurring System"::"Annual Recurring":
                        BEGIN
                            IF BaseCalChange."To Date" = 0D THEN
                                BaseCalChange."To Date" := BaseCalChange.Date;
                            IF (DATE2DMY(TargetDate, 2) >= DATE2DMY(BaseCalChange.Date, 2)) AND
                               (DATE2DMY(TargetDate, 1) >= DATE2DMY(BaseCalChange.Date, 1)) AND
                               (DATE2DMY(TargetDate, 2) <= DATE2DMY(BaseCalChange."To Date", 2)) AND
                               (DATE2DMY(TargetDate, 1) <= DATE2DMY(BaseCalChange."To Date", 1))
                            THEN BEGIN
                                Description := BaseCalChange.Description;
                                EXIT(BaseCalChange.Nonworking);
                            END;
                        END;
                //PLANNING//
                END;
            UNTIL BaseCalChange.NEXT = 0;
        Description := '';
    end;
}

