Codeunit 39001408 "Note Personnel"
{
    //GL2024  ID dans Nav 2009 : "39001408"
    trigger OnRun()
    begin
    end;

    var
        Window: Dialog;
        i: Integer;
        j: Integer;
        RecNote: Record "Ligne Pointage Salarié Chanti";
        text1: label 'Supprimer la note de %1';
        BoolExist: Boolean;
        RecSalEng: Record "Rec. Salary Lines";


    procedure ValiderNote(var Sal: Record Employee; "Année": Integer; TrimestreT: Option "1ère","2ème","3ème","4ème",Annuel)
    var
        SalTmp: Record Employee;
        Noten: Record "Ligne Pointage Salarié Chanti";
    begin
        SalTmp.CopyFilters(Sal);
        SalTmp.SetFilter(Trimestre, '%1', TrimestreT);
        SalTmp.SetRange("Type Note", 0, 5);
        i := 0;
        Noten.Reset;
        j := 0;
        if Noten.Find('+') then
            j := Noten.Séquence;

        Window.Open('Validation Notes Personnel              \' +
                     ' Année #1#### #2#### Trimetsre         \' +
                     '                                       \' +
                     'Salariée #3########################### \' +
                     ' @4@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \');
        if SalTmp.Find('-') then
            repeat
                i := i + 1;
                Window.Update(1, Année);
                Window.Update(2, TrimestreT);
                Window.Update(3, (SalTmp."No." + ' ' + SalTmp."Last Name" + ' ' + SalTmp."First Name"));
                Window.Update(4, (ROUND(i / SalTmp.Count, 0.01) * 10000));
                if not TestNte(SalTmp, Année, TrimestreT) then begin
                    j := j + 1;
                    EnregistrerNote(SalTmp, Année, TrimestreT, j);
                end;
            until SalTmp.Next = 0;
        Window.Close;
    end;


    procedure TestNte(Sal: Record Employee; "AnnéeT": Integer; trim: Option "1ère","2ème","3ème","4ème",Annuel) Im: Boolean
    var
        Noteeng: Record "Ligne Pointage Salarié Chanti";
    begin
        Im := false;
        Clear(Noteeng);
        Noteeng.Reset;
        Noteeng.SetCurrentkey(Matricule, Nom, "Nom 1", "D.Hr sup");
        Noteeng.SetFilter("Nom 1", Sal."No.");
        Noteeng.SetFilter(Matricule, '%1', format(AnnéeT));
        Noteeng.SetFilter(Nom, '%1', format(trim));
        // Noteeng.CALCSUMS(Note,Montant);
        if (Noteeng.Panier <> 0) or (Noteeng."Jour repos" <> 0) then
            Im := true;
    end;


    procedure EnregistrerNote(Sal: Record Employee; "AnnéeT": Integer; trim: Option "1ère","2ème","3ème","4ème",Annuel; var nseq: Integer)
    var
        Noteeng: Record "Ligne Pointage Salarié Chanti";
    begin
        Noteeng.SetFilter(Matricule, '%1', format(AnnéeT));
        Noteeng.SetFilter(Nom, '%1', format(trim));
        Noteeng.SetFilter("Nom 1", Sal."No.");
        BoolExist := false;
        if Noteeng.Find('-') then
            BoolExist := true
        else
            BoolExist := false;

        case BoolExist of
            true:
                begin
                    if Sal.Note <> 0 then begin
                        RecSalEng.Reset;
                        RecSalEng.SetRange(Year, AnnéeT);
                        RecSalEng.SetRange(Month, 14);
                        Noteeng.Panier := Sal.Note;
                        Noteeng.Validate(Panier);
                        /*  Noteeng."Heure 35" := UserId;
                          Noteeng.Présence := Today;
                          Noteeng.Congé := Time;
                          Noteeng.Férier := WorkDate;*/
                        //  IF NOT ((RecSalEng.FIND('-')) AND (Sal."Relation de travail"=2)) THEN
                        //  BEGIN
                        Noteeng.Modify;
                        Sal.Note := 0;
                        Sal.Modify;
                        //       END;
                    end
                end;
            false:
                begin
                    if Sal.Note <> 0 then begin
                        Noteeng.Init;
                        Noteeng.Matricule := format(AnnéeT);
                        Noteeng.Nom := format(trim);
                        Noteeng."Nom 1" := Sal."No.";
                        Noteeng.Séquence := nseq;
                        Noteeng."D.Hr sup" := format(4);
                        Noteeng.Panier := Sal.Note;
                        Noteeng."Type Heure" := format(Sal.Pourcentage);
                        Noteeng.Validate(Panier);
                        /* GL2024 Noteeng."Heure 35" := UserId;
                          Noteeng.Présence := Today;
                          Noteeng.Congé := Time;
                          Noteeng.Férier := WorkDate;*/
                        Noteeng.Insert;
                        Sal.Note := 0;
                        Sal.Pourcentage := 0;
                        Sal.Modify;
                    end
                end;
        end;
    end;
}

