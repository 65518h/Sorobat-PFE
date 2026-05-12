Page 52048986 "Dispo. Véhicule"
{//GL2024  ID dans Nav 2009 : "39004721"
    Caption = 'Monthly Calendar';
    DataCaptionExpression = GetCaption2;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = Date;
    SourceTableView = where("Period Type" = const(Week));
    ApplicationArea = All;

    layout
    {
    }

    actions
    {
    }

    var
        Year: Integer;
        Month: Option January,February,March,April,May,June,July,August,September,October,November,December;
        FirstMonday: Date;
        LastMonday: Date;
        CurrentMonth: Date;
        FlagNonworkingDay: Boolean;
        CalendarMgmt: Codeunit "Calendar Management";
        NewDescription: Text[30];
        CurrentSourceType: Option Company,Customer,Vendor,Location,"Shipping Agent","Véhicule";
        CurrentSourceCode: Code[20];
        CurrentAddSourceCode: Code[20];
        CurrentBaseCalCode: Code[10];
        CurrentDate2: Date;
        TEMPDATE: Date;
        TempDay: Integer;
        BaseCalendar: Record "Base Calendar";
        CalledFromWindow: Integer;
        StatusDescription: Text[30];
        OK: Boolean;
        Veh: Record "Véhicule";
        VehPeriodLength: Integer;
        rep: Record "Réparation Véhicule";
        REPARATION: Boolean;
        Mission: Record Missions;
        Vig: Record "Vignette Véhicule";
    //GL3900   Visite: Record "Visite Technique";


    procedure Calculate()
    begin
    end;


    procedure SetCalendarCode(CalledFrom: Integer; SourceType: Option Company,Customer,Vendor,Location,"Shipping Agent"; SourceCode: Code[20]; AddSourceCode: Code[20]; BaseCalendarCode: Code[10]; CurrentDate: Date)
    begin
    end;


    procedure GetCaption2(): Text[250]
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        Location: Record Location;
        ShippingAgentService: Record "Shipping Agent Services";
        "Véhicule": Record "Véhicule";
    begin
    end;


    procedure Set(var NewVeh: Record "Véhicule"; NewResPeriodLength: Integer)
    begin
    end;


    procedure VerifReparation(Vehicule: Record "Véhicule"; DateRep: Date) VarRep: Boolean
    begin
    end;


    procedure VerifMission(Vehicule: Record "Véhicule"; DateRep: Date) VarMiss: Boolean
    begin
    end;


    procedure VerifVignette(Vehicule: Record "Véhicule"; DateRep: Date) VarVig: Boolean
    begin
    end;


    procedure VerifVisitetech(Vehicule: Record "Véhicule"; DateRep: Date) VarVis: Boolean
    begin
    end;
}

