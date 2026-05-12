Codeunit 8001520 MakeDateFilter
{
    //GL2024  ID dans Nav 2009 : "8001320"
    // //BASIC_STATSEXPLORER STATSEXPLORER 01/01/00 Codeunit de mise en forme d'un filtre date


    trigger OnRun()
    begin
    end;

    var
        ParamCompta: Record "General Ledger Setup";
        PeriodeCompta: Record "Accounting Period";
        TexteStandard: Record "Standard Text";
        DateTravailLogin: Date;
        DateLogin: Date;
        HeureLogin: Time;
        Position: Integer;
        Longueur: Integer;
        Position2: Integer;
        PositionChaine: Integer;
        Signe: Text[1];
        PartieDeTexte: Text[132];
        Date: Date;
        Date1: Date;
        Date2: Date;
        Texte1: Text[30];
        Texte2: Text[30];
        Numerique: Integer;
        i: Integer;
        OK: Boolean;
        Intervalle: Text[2];
        Dec1: Decimal;
        Dec2: Decimal;
        Dec: Decimal;
        TexteToday: label 'TODAY';
        TexteWorkdate: label 'WORKDATE';


    procedure FaireDate(var TexteFiltreDate: Text[50]) FiltreDate: Text[50]
    var
        lCumulStatistiques: Record "Statistic aggregate";
    begin
        lCumulStatistiques.SetFilter("Free date 1", TexteFiltreDate);
        exit(lCumulStatistiques.GetFilter("Free date 1"));
    end;


    procedure FaireTexteDate(var TexteDate: Text[250]): Integer
    begin
        Position := 1;
        Longueur := StrLen(TexteDate);
        LireCaractere(' ', TexteDate, Position, Longueur);
        if not RechText(PartieDeTexte, TexteDate, Position, Longueur) then
            exit(0);
        case PartieDeTexte of
            CopyStr(TexteToday, 1, StrLen(PartieDeTexte)):
                Date := Today;
            CopyStr(TexteWorkdate, 1, StrLen(PartieDeTexte)):
                Date := WorkDate;
            else
                exit(0);
        end;
        Position := Position + StrLen(PartieDeTexte);
        LireCaractere(' ', TexteDate, Position, Longueur);
        if Position > Longueur then begin
            TexteDate := Format(Date);
            exit(0);
        end;
        exit(Position);
    end;

    local procedure RechText(var PartieDeTexte: Text[250]; var Texte: Text[250]; Position: Integer; Longueur: Integer): Boolean
    begin
        Position2 := Position;
        LireCaractere('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Texte, Position, Longueur);
        if Position = Position2 then
            exit(false);
        PartieDeTexte := UpperCase(CopyStr(Texte, Position2, Position - Position2));
        exit(true);
    end;

    local procedure LireCaractere(Caractere: Text[50]; var Texte: Text[250]; var Position: Integer; Longueur: Integer)
    begin
        while (Position <= Longueur) and (StrPos(Caractere, UpperCase(CopyStr(Texte, Position, 1))) <> 0) do
            Position := Position + 1;
    end;
}

