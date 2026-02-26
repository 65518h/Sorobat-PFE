Page 50172 "Alerte Papier"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Véhicule";
    //  SourceTableView = where("Alerte Papier" = const(true));
    SourceTableView = SORTING(marche, "N° Vehicule")
                    WHERE("Alerte Papier" = CONST(true));
    ApplicationArea = all;
    Caption = 'Alerte Papier';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = true;
                ShowCaption = false;
                field("N° Vehicule"; REC."N° Vehicule")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Désignation"; REC.Désignation)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Marché"; REC.Marche)
                {
                    ApplicationArea = all;
                    Caption = 'Marché';
                    Style = Attention;
                    StyleExpr = true;

                }
                field("Date Expiration AT"; Rec."Date Expiration AT")
                {
                    ApplicationArea = all;
                }
                field("Date Expiration Assurance"; Rec."Date Expiration Assurance")
                {
                    ApplicationArea = all;
                }
                field("Date Expiration Visite Tech"; Rec."Date Expiration Visite Tech")
                {
                    ApplicationArea = all;
                }
                // field("Date Assurance"; REC."Date Assurance")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;

                //     trigger OnAssistEdit()
                //     begin
                //         if not Confirm(Text001) then exit;
                //         Choix := StrMenu(Text002, 1);
                //         if Choix = 1 then REC."Date Assurance" := CalcDate('3M', REC."Date Assurance");
                //         if Choix = 2 then REC."Date Assurance" := CalcDate('6M', REC."Date Assurance");
                //         if Choix = 3 then REC."Date Assurance" := CalcDate('12M', REC."Date Assurance");
                //     end;
                // }
                // field("Date Taxe Circulation"; REC."Date Taxe Circulation")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;

                //     trigger OnAssistEdit()
                //     begin
                //         if not Confirm(Text001) then exit;
                //         Choix := StrMenu(Text002, 1);
                //         if Choix = 1 then REC."Date Taxe Circulation" := CalcDate('3M', REC."Date Taxe Circulation");
                //         if Choix = 2 then REC."Date Taxe Circulation" := CalcDate('6M', REC."Date Taxe Circulation");
                //         if Choix = 3 then REC."Date Taxe Circulation" := CalcDate('12M', REC."Date Taxe Circulation");
                //     end;
                // }
                // field("Date Visite Technique"; REC."Date Visite Technique")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;

                //     trigger OnAssistEdit()
                //     begin
                //         if not Confirm(Text001) then exit;
                //         Choix := StrMenu(Text002, 1);
                //         if Choix = 1 then REC."Date Visite Technique" := CalcDate('3M', REC."Date Visite Technique");
                //         if Choix = 2 then REC."Date Visite Technique" := CalcDate('6M', REC."Date Visite Technique");
                //         if Choix = 3 then REC."Date Visite Technique" := CalcDate('12M', REC."Date Visite Technique");
                //     end;
                // }
                // field("Date Vignette"; REC."Date Vignette")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = true;

                //     trigger OnAssistEdit()
                //     begin
                //         if not Confirm(Text001) then exit;
                //         Choix := StrMenu(Text002, 1);
                //         if Choix = 1 then REC."Date Vignette" := CalcDate('3M', REC."Date Vignette");
                //         if Choix = 2 then REC."Date Vignette" := CalcDate('6M', REC."Date Vignette");
                //         if Choix = 3 then REC."Date Vignette" := CalcDate('12M', REC."Date Vignette");
                //     end;
                // }
            }
            field("Delai Prochain"; REC."Delai Prochain")
            {
                ApplicationArea = all;
                Caption = 'Date Expiration Vignette';
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RecVehicule.SetRange(RecVehicule.Bloquer, false);
        if RecVehicule.FindFirst then
            repeat
                IF (RecVehicule."Date Expiration Vignette" IN [WORKDATE - 360 .. WORKDATE + 30]) OR
                     (RecVehicule."Date Expiration Assurance" IN [WORKDATE - 360 .. WORKDATE + 30]) OR
                     (RecVehicule."Date Expiration AT" IN [WORKDATE - 360 .. WORKDATE + 30]) OR
                     (RecVehicule."Date Expiration Visite Tech" IN [WORKDATE - 360 .. WORKDATE + 30]) THEN begin
                    RecVehicule."Alerte Papier" := true;
                    RecVehicule.Modify;
                    Trouver := TRUE;
                end
                else begin
                    RecVehicule."Alerte Papier" := false;
                    RecVehicule.Modify;

                end;
            until RecVehicule.Next = 0;
        IF NOT Trouver THEN CurrPage.CLOSE;
    end;

    var
        Trouver: Boolean;
        RecVehicule: Record "Véhicule";
        Text001: label 'Confirmer Cette Action ?';
        Text002: label '3M,6M,12';
        Choix: Integer;


    procedure DelaiProchain()
    begin
    end;
}

