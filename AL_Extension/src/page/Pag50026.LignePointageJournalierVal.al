page 50026 "Ligne Pointage Journalier Val"
{
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Ligne Pointage Salarié Chanti";
    Caption = 'Ligne Pointage Journalier Validé';


    layout
    {
        area(content)
        {

            repeater(Control1)
            {
                //Editable = false;
                ShowCaption = false;
                field(Matricule; rec.Matricule)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;

                    trigger OnValidate()
                    begin
                        IF RecGEmp.GET(rec.Matricule) THEN
                            rec.Bage := RecGEmp."N° Badge";
                        MatriculeOnAfterValidate;
                    end;
                }
                field(Nom; rec.Nom)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Fonction; Rec.Fonction)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("15% Ant"; rec."15% Ant")
                // {
                //     Editable = false;
                //     ApplicationArea = all;
                // }
                // field("35% Ant"; rec."35% Ant")
                // {
                //     Editable = false;
                //     ApplicationArea = all;
                // }
                field(S1; rec.S1)
                {
                    ApplicationArea = all;
                    Caption = 'S1';
                    Style = Attention;
                    StyleExpr = true;
                    Editable = false;
                }
                field(S2; rec.S2)
                {
                    ApplicationArea = all;
                    Caption = 'S2';
                    Style = Attention;
                    StyleExpr = true;
                    Editable = false;
                }
                field(S3; rec.S3)
                {
                    ApplicationArea = all;
                    Caption = 'S3';
                    Style = Attention;
                    StyleExpr = true;
                    Editable = false;
                }
                field(S4; rec.S4)
                {
                    ApplicationArea = all;
                    Caption = 'S4';
                    Style = Attention;
                    Editable = false;
                    StyleExpr = true;
                }
                field(S5; rec.S5)
                {
                    ApplicationArea = all;
                    Caption = 'S5';
                    Style = Attention;
                    Editable = false;
                    StyleExpr = true;
                }
                field(S6; rec.S6)
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    Editable = false;
                    Caption = 'S6';
                    Style = Attention;
                    StyleExpr = true;
                    DecimalPlaces = 0 : 1;
                }
                field(D1; rec.D1)
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    Editable = false;
                    StyleExpr = true;
                }
                field(D2; rec.D2)
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    Editable = false;
                    StyleExpr = true;
                }
                field(D3; rec.D3)
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    StyleExpr = true;
                    Editable = false;
                }
                field(D4; rec.D4)
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    StyleExpr = true;
                    Editable = false;
                }
                field(D5; rec.D5)
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    StyleExpr = true;
                    Editable = false;
                }
                field(D6; rec.D6)
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    Editable = false;
                    StyleExpr = true;
                }
                field(Espace; Espace)
                {
                    ApplicationArea = all;
                    Caption = '-';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Affectation; rec.Affectation)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("21"; rec."21")
                {

                    CaptionClass = ArrayDay[21] + ' 21';
                    ApplicationArea = all;
                    Editable = IsEditable;
                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(21, rec."21");
                        //TotalPresence();
                        //S11();
                        //if rec."21" <> 0 then
                        //rec.D1 += 1;
                    end;
                }
                field("22"; rec."22")
                {
                    CaptionClass = ArrayDay[22] + ' 22';
                    Editable = IsEditable;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(22, rec."22");
                        //TotalPresence();
                        //S11();
                        //if rec."22" <> 0 then
                        // rec.D1 += 1;
                    end;
                }
                field("23"; rec."23")
                {
                    CaptionClass = ArrayDay[23] + '23';
                    Editable = IsEditable;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(23, rec."23");
                        // TotalPresence();
                        // S11();
                        // if rec."23" <> 0 then
                        //     rec.D1 += 1;
                    end;
                }
                field("24"; rec."24")
                {
                    CaptionClass = ArrayDay[24] + ' 24';
                    Editable = IsEditable;
                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(24, rec."24");
                        // TotalPresence();
                        // S11();
                        // if rec."24" <> 0 then
                        //     rec.D1 += 1;
                    end;
                }
                field("25"; rec."25")
                {
                    CaptionClass = ArrayDay[25] + ' 25';
                    Editable = IsEditable;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(25, rec."25");
                        // TotalPresence();
                        // S11();
                        // if rec."25" <> 0 then
                        //     rec.D1 += 1;
                    end;
                }
                field("26"; rec."26")
                {
                    CaptionClass = ArrayDay[26] + ' 26';
                    Editable = IsEditable;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(26, rec."26");
                        // TotalPresence();
                        // S11();
                        // if rec."26" <> 0 then
                        //     rec.D1 += 1;
                    end;
                }
                field("27"; rec."27")
                {
                    ApplicationArea = all;
                    CaptionClass = ArrayDay[27] + ' 27';
                    Editable = IsEditable;
                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(27, rec."27");
                        // CalculPresence;
                        // TotalPresence();
                    end;
                }
                field("28"; rec."28")
                {
                    CaptionClass = ArrayDay[28] + ' 28';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(28, rec."28");
                        // CalculPresence;
                        // TotalPresence();
                        // S22();
                        // if rec."28" <> 0 then
                        //     rec.D2 += 1;
                    end;
                }
                field("29"; rec."29")
                {
                    CaptionClass = ArrayDay[29] + ' 29';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(29, rec."29");
                        // CalculPresence;
                        // TotalPresence();
                        // S22();
                        // if rec."29" <> 0 then
                        //     rec.D2 += 1;
                    end;
                }
                field("30"; rec."30")
                {
                    CaptionClass = ArrayDay[30] + ' 30';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(30, rec."30");
                        // CalculPresence;
                        // S22();
                        // if rec."30" <> 0 then
                        //     rec.D2 += 1;
                        // TotalPresence();
                    end;
                }
                field("31"; rec."31")
                {
                    CaptionClass = ArrayDay[31] + ' 31';
                    Editable = IsEditable;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(31, rec."31");
                        // CalculPresence;
                        // S22();
                        // if rec."31" <> 0 then
                        //     rec.D2 += 1;
                        // TotalPresence();
                    end;
                }
                field("1"; rec."1")
                {
                    CaptionClass = ArrayDay[1] + ' 1';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(1, rec."1");
                        // CalculPresence;
                        // TotalPresence();
                        // S22();
                        // if rec."1" <> 0 then
                        //     rec.D2 += 1;
                    end;
                }
                field("2"; rec."2")
                {
                    CaptionClass = ArrayDay[2] + ' 2';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(2, rec."2");
                        // CalculPresence;
                        // S22();
                        // if rec."2" <> 0 then
                        //     rec.D2 += 1;
                        // TotalPresence();
                    end;
                }
                field("3"; rec."3")
                {
                    CaptionClass = ArrayDay[3] + ' 3';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(3, rec."3");
                        //CalculPresence;
                        //TotalPresence();
                    end;
                }
                field("4"; rec."4")
                {
                    CaptionClass = ArrayDay[4] + ' 4';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(4, rec."4");
                        // CalculPresence;
                        // S33();
                        // if rec."4" <> 0 then
                        //     rec.D3 += 1;
                        // TotalPresence();
                    end;
                }
                field("5"; rec."5")
                {
                    CaptionClass = ArrayDay[5] + ' 5';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(5, rec."5");
                        // CalculPresence;
                        // TotalPresence();
                        // S33();
                        // if rec."5" <> 0 then
                        //     rec.D3 += 1;
                    end;
                }
                field("6"; rec."6")
                {
                    CaptionClass = ArrayDay[6] + ' 6';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(6, rec."6");
                        // CalculPresence;
                        // TotalPresence();
                        // S33();

                        // if rec."6" <> 0 then
                        //     rec.D3 += 1;
                    end;
                }
                field("7"; rec."7")
                {
                    CaptionClass = ArrayDay[7] + ' 7';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(7, rec."7");
                        // CalculPresence;
                        // TotalPresence();
                        // S33();
                        // if rec."7" <> 0 then
                        //     rec.D3 += 1;
                    end;
                }
                field("8"; rec."8")
                {
                    CaptionClass = ArrayDay[8] + ' 8';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(8, rec."8");
                        // CalculPresence;
                        // S33();
                        // if rec."8" <> 0 then
                        //     rec.D3 += 1;
                        // TotalPresence();
                    end;
                }
                field("9"; rec."9")
                {
                    CaptionClass = ArrayDay[9] + ' 9';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(9, rec."9");
                        // CalculPresence;
                        // TotalPresence();
                        // S33();
                        // if rec."9" <> 0 then
                        //     rec.D3 += 1;
                    end;
                }
                field("10"; rec."10")
                {
                    CaptionClass = ArrayDay[10] + ' 10';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(10, rec."10");
                        // CalculPresence;
                        // TotalPresence();
                    end;
                }
                field("11"; rec."11")
                {
                    CaptionClass = ArrayDay[11] + ' 11';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(11, rec."11");
                        // CalculPresence;
                        // TotalPresence();
                        // S44();
                        // if rec."11" <> 0 then
                        //     rec.D4 += 1;
                    end;
                }
                field("12"; rec."12")
                {
                    CaptionClass = ArrayDay[12] + ' 12';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(12, rec."12");
                        // CalculPresence;
                        // S44();
                        // if rec."12" <> 0 then
                        //     rec.D4 += 1;
                        // TotalPresence();
                    end;
                }
                field("13"; rec."13")
                {
                    CaptionClass = ArrayDay[13] + ' 13';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(13, rec."13");
                        // CalculPresence;
                        // S44();
                        // if rec."13" <> 0 then
                        //     rec.D4 += 1;
                        // TotalPresence();
                    end;
                }
                field("14"; rec."14")
                {
                    CaptionClass = ArrayDay[14] + ' 14';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(14, rec."14");
                        // CalculPresence;
                        // S44();
                        // if rec."14" <> 0 then
                        //     rec.D4 += 1;
                        // TotalPresence();
                    end;
                }
                field("15"; rec."15")
                {
                    CaptionClass = ArrayDay[15] + ' 15';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(15, rec."15");
                        // CalculPresence;
                        // TotalPresence();
                        // S44();
                        // if rec."15" <> 0 then
                        //     rec.D4 += 1;
                    end;
                }
                field("16"; rec."16")
                {
                    CaptionClass = ArrayDay[16] + ' 16';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(16, rec."16");
                        // CalculPresence;
                        // S44();
                        // if rec."16" <> 0 then
                        //     rec.D4 += 1;
                        // TotalPresence();
                    end;
                }
                field("17"; rec."17")
                {
                    CaptionClass = ArrayDay[17] + ' 17';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(17, rec."17");
                        // CalculPresence;
                        //  TotalPresence();
                    end;
                }
                field("18"; rec."18")
                {
                    CaptionClass = ArrayDay[18] + ' 18';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(18, rec."18");
                        // CalculPresence;
                        // S55();
                        // if rec."18" <> 0 then
                        //     rec.D5 += 1;
                        // TotalPresence();
                    end;
                }
                field("19"; rec."19")
                {
                    CaptionClass = ArrayDay[19] + ' 19';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(19, rec."19");
                        // CalculPresence;
                        // S55();
                        // if rec."19" <> 0 then
                        //     rec.D5 += 1;
                        // TotalPresence();
                    end;
                }
                field("20"; rec."20")
                {
                    CaptionClass = ArrayDay[20] + ' 20';
                    Editable = IsEditable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdatePointageEntry(20, rec."20");
                        // CalculPresence;
                        // S55();
                        // if rec."20" <> 0 then
                        //     rec.D5 += 1;
                        // TotalPresence();
                    end;
                }
                field("15%"; rec."15%")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
                field("35%"; rec."35%")
                {
                    ApplicationArea = all;
                    Style = StandardAccent;
                    Editable = false;
                    StyleExpr = true;
                }
                // field("60%"; rec."60%")
                // {
                //     ApplicationArea = all;
                //     Style = StandardAccent;
                //     StyleExpr = true;
                // }
                // field("Heures Feriés Sup 60%"; rec."Heures Feriés Sup 60%")
                // {
                //     ApplicationArea = all;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }
                // field("Presence Perso"; rec."Presence Perso")
                // {
                //     ApplicationArea = all;
                //     DecimalPlaces = 0 : 2;
                // }
                // field("Dimanche Non Travailléé"; rec."Dimanche Non Travailléé")
                // {
                //     ApplicationArea = all;
                //     // DecimalPlaces = 0 : 2;
                // }
                field("Total Presence"; rec."Total Presence")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 0 : 2;
                    Editable = false;
                }
                // field(Présence; rec.Présence)
                // {
                //     ApplicationArea = all;
                //     DecimalPlaces = 0 : 2;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }
                // field("Presence à Payer"; rec."Presence à Payer")
                // {
                //     ApplicationArea = all;
                // }
            }
        }
    }

    actions
    {
        // area(processing)
        // {
        //     action(Rafraichir)
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Rafraichir';
        //         Promoted = true;
        //         PromotedCategory = Process;

        //         trigger OnAction()
        //         begin
        //             IF LAffecatation = '' THEN ERROR(Text004);
        //             IF MoisAttach = 0 THEN ERROR(Text004);
        //             AnneeAttach := DATE2DMY(WORKDATE, 3);
        //             rec.RESET;
        //             rec.SETRANGE(Affectation, LAffecatation);
        //             rec.SETRANGE("Annee Attachement", AnneeAttach);
        //             rec.SETRANGE("Mois Attachement", MoisAttach);
        //         end;
        //     }
        // }
    }

    trigger OnAfterGetRecord()
    begin
        MatriculeOnFormat;
        // TotalPresence();
        // S11();
        // S22();
        // S33();
        // S44();
        // S55();
        UpdateColumnCaption(ArrayDay);

    end;

    // trigger OnAfterGetCurrRecord()
    // begin
    //     UpdateColumnCaption(ArrayDay);
    // end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CurrPage.EDITABLE(TRUE);
    end;

    var
        Text001: Label 'Valider Cette Attachement';
        EtatMensuellePaie: Record "Ligne Pointage Salarié Chanti";
        EntetePointageJournalier: Record "Entete Pointage Salarié Chanti";
        EntetePointageJournalier2: Record "Entete Pointage Salarié Chanti";
        BonReglement: Record "Bon Reglement";
        RecGEmp: Record 5200;
        i: Integer;
        d: Dialog;
        MgmtSuppHour: Codeunit "Management of Work Hours";
        ToTNbrjours: Decimal;
        ToTNbrHeures: Decimal;
        CodeQualification: Code[20];
        CodeAffectation: Code[20];
        "NombreSalarié": Integer;
        Heure: Time;
        "PointageJournalierValidé": Record "Ligne Pointage Journ. Validé";
        "PointageJournalierValidé2": Record "Ligne Pointage Journ. Validé";
        LignePointageJournalier: Record "Ligne Pointage Salarié Chanti";
        Text002: Label 'Validation Effectuée Avec Succée';
        Text003: Label 'Journee Deja Validé';
        "EntetePointageJournValidé": Record "Entete Pointage Journ. Validé";
        LAffecatation: Code[20];
        MoisAttach: Option " ",Janvier,Fevrier,Mars,Avril,Mai,Jiun,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
        AnneeAttach: Integer;
        Text004: Label 'Remplir Tous Les Champs';
        DateAttach: Date;
        FinMois: Date;
        k: Integer;
        Dimanche: Integer;
        DateDebut: Date;
        DateFin: Date;
        Text005: Label 'Le Salarié %1 Est Attaché A L''Affectaion  %2 Pour Cette Année et Ce Mois';
        Espace: Code[20];

        ArrayDay: array[31] of Text;
        Header: Record "Entete Pointage Salarié Chan";
        IsEditable: Boolean;


    procedure CalculPresence()
    begin
    end;


    procedure FinMois2(ParaJournee: Integer) DateFin: Date
    var
        Text001: Label 'Depassement Dans La Date Saisie, Mois Max Journée : %1';
    begin
    end;


    procedure DimancheTravaille() EnMoins: Integer
    var
        DateDebut: Date;
        TextL001: Label 'Jour Dimanche Saisie Interdite';
        DateFin: Date;
        DimTravaille: Integer;
        J: Integer;
        K: Integer;
        M: Integer;
    begin
    end;


    procedure DimancheHeureSupp() EnMoins: Integer
    var
        DateDebut: Date;
        TextL001: Label 'Jour Dimanche Saisie Interdite';
        DateFin: Date;
        DimTravaille: Integer;
        J: Integer;
        K: Integer;
        M: Integer;

    begin
    end;


    procedure ChercheDimanches()
    begin
    end;


    procedure EstDimanches(ParaJour: Integer) EstDim: Boolean
    var
        Localdate: Date;
        Localdate2: Date;
        Localdate3: Date;
    begin
    end;


    procedure CalcHeureSup()
    begin
    end;


    procedure CalculJoursMois()
    begin
    end;

    local procedure MatriculeOnAfterValidate()
    begin
        IF RecGEmp.GET(rec.Matricule) THEN
            rec.Bage := RecGEmp."N° Badge";
    end;

    local procedure MatriculeOnAfterInput(var Text: Text[1024])
    begin
        IF RecGEmp.GET(rec.Matricule) THEN
            rec.Bage := RecGEmp."N° Badge";
    end;

    local procedure MatriculeOnFormat()
    begin
        IF RecGEmp.GET(rec.Matricule) THEN;
        //IF RecGEmp.Horaire THEN BEGIN END
        //ELSE CurrPage.Matricule.UPDATEFORECOLOR(16711680)
    end;

    procedure UpdateColumnCaption(var ArrayDay: array[31] of Text)
    var
        RecLPointageHeader: Record "Entete Pointage Salarié Chan";
        ColumnNumber: Integer;
    begin
        if RecLPointageHeader.get(rec."No. Pointage") then begin


            for ColumnNumber := 1 to 20 do
                if (RecLPointageHeader."Mois Attachement" <> 0) and (RecLPointageHeader."Annee Attachement" <> 0) then
                    ArrayDay[ColumnNumber] := format(DMY2Date(ColumnNumber, RecLPointageHeader."Mois Attachement", RecLPointageHeader."Annee Attachement"), 0, '<Weekday Text>');

            if (RecLPointageHeader."Mois Attachement" > 1) and (RecLPointageHeader."Annee Attachement" <> 0) then
                for ColumnNumber := 21 to Date2DMY(CalcDate('FM', DMY2Date(1, RecLPointageHeader."Mois Attachement" - 1, RecLPointageHeader."Annee Attachement")), 1) do
                    ArrayDay[ColumnNumber] := format(DMY2Date(ColumnNumber, RecLPointageHeader."Mois Attachement" - 1, RecLPointageHeader."Annee Attachement"), 0, '<Weekday Text>');

            if (RecLPointageHeader."Mois Attachement" = 1) and (RecLPointageHeader."Annee Attachement" <> 0) then
                for ColumnNumber := 21 to Date2DMY(CalcDate('FM', DMY2Date(1, 12, RecLPointageHeader."Annee Attachement" - 1)), 1) do
                    ArrayDay[ColumnNumber] := format(DMY2Date(ColumnNumber, 12, RecLPointageHeader."Annee Attachement" - 1), 0, '<Weekday Text>');

        end;
    end;

    procedure DisableFields(DocumentNo: Code[50])
    begin
        if Header.Get(DocumentNo) then begin
            if (Header.Statut = Header.Statut::Ouvert) then
                IsEditable := true
            else
                IsEditable := false
        end
        else if DocumentNo = '' then begin
            IsEditable := true
        end;
        CurrPage.Update(false);
    end;





    procedure UpdatePointageEntry(IntDay: Integer; DecLQty: Decimal)
    var
        RecLPoitageEntry: Record "Ecriture Pointage Journalier";
        RecLPoitageEntry2: Record "Ecriture Pointage Journalier";
        RecLLignePointage: Record "Ligne Pointage Salarié Chanti";
        HeurSup: Decimal;
    begin
        // RecLPoitageEntry2.SetRange("No. Pointage", rec."No. Pointage");
        // if RecLPoitageEntry2.FindLast() then;
        RecLPoitageEntry.Init();
        RecLPoitageEntry."No. Pointage" := rec."No. Pointage";
        //RecLPoitageEntry."Entry No." := RecLPoitageEntry2."Entry No." + 1;
        RecLPoitageEntry."Entry No." := IntDay;
        RecLPoitageEntry.Matricule := rec.Matricule;
        RecLPoitageEntry.Affectation := rec.Affectation;
        RecLPoitageEntry."Mois Attachement" := rec."Mois Attachement";
        RecLPoitageEntry."Annee Attachement" := rec."Annee Attachement";
        RecLPoitageEntry."Day Number" := IntDay;
        RecLPoitageEntry.Heure := DecLQty;
        RecLPoitageEntry.Day := DecLQty / 8;
        if RecLPoitageEntry.Day > 1 then
            RecLPoitageEntry.Day := 1;
        RecLPoitageEntry.Date := DMY2Date(IntDay, rec."Mois Attachement", rec."Annee Attachement");
        RecLPoitageEntry.week := Date2DWY(RecLPoitageEntry.Date, 2);
        IF NOt RecLPoitageEntry.insert then
            RecLPoitageEntry.Modify();
        RecLPoitageEntry.CalcFields("First week");
        RecLPoitageEntry."week Number" := RecLPoitageEntry.week - RecLPoitageEntry."First week" + 1;
        RecLPoitageEntry.Modify();
        RecLLignePointage.get(rec."No. Pointage", rec.Matricule, rec."Annee Attachement", rec."Mois Attachement", rec.Affectation);
        RecLLignePointage.SetRange("Week Filter", RecLPoitageEntry.week);
        RecLLignePointage.CalcFields("Total heurs week");
        HeurSup := RecLLignePointage."Total heurs week" - 40;
        IF HeurSup < 0 then
            exit
        else
            if HeurSup <= 8 then
                InsertHSUP15(RecLPoitageEntry, HeurSup)
            else begin
                InsertHSUP15(RecLPoitageEntry, 8);
                InsertHSUP35(RecLPoitageEntry, HeurSup - 8);
            end;
    end;

    local procedure InsertHSUP15(VAR RecLPoitageEntry: Record "Ecriture Pointage Journalier"; HeurSup: Decimal)
    var
        RecLPointageEntryHSup: Record "Ecriture Pointage Journalier";
    begin
        RecLPointageEntryHSup.Init();
        RecLPointageEntryHSup.TransferFields(RecLPoitageEntry);
        RecLPointageEntryHSup."Entry No." := 15;
        RecLPointageEntryHSup.Day := 0;
        RecLPointageEntryHSup."Day Number" := 0;
        RecLPointageEntryHSup.Heure := 0;
        RecLPointageEntryHSup."HSup 15" := HeurSup;
        IF NOT RecLPointageEntryHSup.Insert() then
            RecLPointageEntryHSup.Modify();
    end;

    local procedure InsertHSUP35(VAR RecLPoitageEntry: Record "Ecriture Pointage Journalier"; HeurSup: Decimal)
    var
        RecLPointageEntryHSup: Record "Ecriture Pointage Journalier";
    begin
        RecLPointageEntryHSup.Init();
        RecLPointageEntryHSup.TransferFields(RecLPoitageEntry);
        RecLPointageEntryHSup."Entry No." := 35;
        RecLPointageEntryHSup.Day := 0;
        RecLPointageEntryHSup."Day Number" := 0;
        RecLPointageEntryHSup.Heure := 0;
        RecLPointageEntryHSup."HSup 35" := HeurSup;
        IF NOT RecLPointageEntryHSup.Insert() then
            RecLPointageEntryHSup.Modify();
    end;

    local procedure GetNextEntryNo(VAR RecLPoitageEntry: Record "Ecriture Pointage Journalier"): Integer
    var
        RecLPointageEntryHSupLast: Record "Ecriture Pointage Journalier";
    begin
        RecLPointageEntryHSupLast.SetRange("No. Pointage", RecLPoitageEntry."No. Pointage");
        IF RecLPointageEntryHSupLast.FindLast() then
            exit(RecLPointageEntryHSupLast."Entry No." + 1)
        else
            exit(1);
    end;
}

