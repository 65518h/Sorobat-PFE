Codeunit 8001412 "Progress Dialog2"
{
    // //+BGW+ GESWAY 08/03/05 Barre de progression


    trigger OnRun()
    var
        Length: Integer;
    begin
    end;

    var
        Window: Dialog;
        "Count": BigInteger;
        OldTime: Time;
        tDefault: label 'In progress...';
        "Max": BigInteger;
        OldProgress: BigInteger;
        tIsEmpty: label 'Is empty';
        MaxToStart: Integer;


    procedure Open(pDescription: Text[250]; pMax: BigInteger)
    begin
        Max := pMax;
        //IF pMax = 0 THEN
        //  ERROR(tIsEmpty);
        if (MaxToStart < Max) and (MaxToStart > 0) then
            exit;
        OldTime := Time;
        if pDescription = '' then
            pDescription := tDefault;
        Window.Open(pDescription + '\' + '@1@@@@@@@@@@@@@@@@@@');
    end;


    procedure Update()
    var
        lTime: Time;
        lProgress: Decimal;
    begin
        if (MaxToStart < Max) and (MaxToStart > 0) then
            exit;

        Count += 1;
        lTime := Time;
        if lTime < OldTime then
            OldTime := lTime
        else
            if Time - OldTime > 1000 then begin
                lProgress := ROUND(Count / Max * 100, 1);
                if lProgress <> OldProgress then begin
                    OldProgress := lProgress;
                    Window.Update(1, lProgress * 100);
                end;
                OldTime := Time;
            end;
    end;


    procedure Close()
    begin
        if (MaxToStart < Max) and (MaxToStart > 0) then
            exit;

        Window.Close;
    end;


    procedure SetMaxToStart(pMaxToStart: Integer)
    begin
        MaxToStart := pMaxToStart
    end;
}

