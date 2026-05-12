page 52048981 "Ligne Pointage Journalier"
{ //GL2024  ID dans Nav 2009 : "39001508"
    DelayedInsert = true;
    InsertAllowed = true;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Ligne Pointage Salarié Chanti";
    SourceTableView = sorting(Affectation, "Base Jour", Matricule)
                      where(Statut = const(Ouvert));
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Ligne Pointage Journalier';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Matricule; Rec.Matricule)
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        if RecGEmp.Get(Rec.Matricule) then
                            Rec.Bage := RecGEmp."N° Badge";
                        MatriculeOnAfterValidate;
                    end;
                }
                field(Nom; Rec.Nom)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }


                field("15% Ant"; Rec."15% Ant")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field("35% Ant"; Rec."35% Ant")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(S1; Rec.S1)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(S2; Rec.S2)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(S3; Rec.S3)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(S4; Rec.S4)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(S5; Rec.S5)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(D1; Rec.D1)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(D2; Rec.D2)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(D3; Rec.D3)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(D4; Rec.D4)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(D5; Rec.D5)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(D6; Rec.D6)
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field(espace; espace)
                {
                    ApplicationArea = Basic;
                    Caption = '-';
                    //    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("1"; Rec."1")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("2"; Rec."2")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("3"; Rec."3")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("4"; Rec."4")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("5"; Rec."5")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("6"; Rec."6")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("7"; Rec."7")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("8"; Rec."8")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("9"; Rec."9")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("10"; Rec."10")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("11"; Rec."11")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("12"; Rec."12")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("13"; Rec."13")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("14"; Rec."14")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("15"; Rec."15")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("16"; Rec."16")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("17"; Rec."17")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("18"; Rec."18")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("19"; Rec."19")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("20"; Rec."20")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("21"; Rec."21")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("22"; Rec."22")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("23"; Rec."23")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("24"; Rec."24")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("25"; Rec."25")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("26"; Rec."26")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("27"; Rec."27")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("28"; Rec."28")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("29"; Rec."29")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("30"; Rec."30")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CalculPresence;
                    end;
                }
                field("31"; Rec."31")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        OnFormat();
                        FinMois(31);
                        CalculPresence;
                    end;
                }
                field("15%"; rec."15%") { ApplicationArea = Basic; }
                field("35%"; rec."35%") { ApplicationArea = Basic; }
                field("60%"; rec."60%") { ApplicationArea = Basic; }
                field("Heures Feriés Sup 60%"; rec."Heures Feriés Sup 60%") { ApplicationArea = Basic; }
                field("Presence Perso"; rec."Presence Perso") { ApplicationArea = Basic; }
                field("Total Presence"; rec."Total Presence") { ApplicationArea = Basic; }
                field(Présence; rec.Présence) { ApplicationArea = Basic; }
                field("Congé"; Rec.Congé)
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 2;
                    Style = Strong;
                    StyleExpr = true;
                    Editable = false;
                }
                field("Férier"; Rec.Férier)
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                // field("Conger Speciale"; Rec."Conger Speciale")
                // {
                //     ApplicationArea = Basic;
                //     Style = Strong;
                //     StyleExpr = true;
                //     Editable = false;
                // }
                // field(Deplacement; Rec.Deplacement)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Deplac';
                //     DecimalPlaces = 0 : 2;
                // }
                // field("Heure Mauvais Temps"; Rec."Heure Mauvais Temps")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'HMVT';
                //     DecimalPlaces = 0 : 1;
                // }
                // field("Retenue Heure Mauvais Temps"; Rec."Retenue Heure Mauvais Temps")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'RMVT';
                //     DecimalPlaces = 0 : 1;
                // }
                // field("Solde Heure Mauvais Temps"; Rec."Solde Heure Mauvais Temps")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'SMVT';
                //     DecimalPlaces = 0 : 1;
                //     Editable = false;
                // }
                field(Presence1; Presence)
                {
                    ApplicationArea = Basic;
                    Caption = 'Tot Pres.';
                    DecimalPlaces = 0 : 1;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                // field("Total Heures"; Rec."Total Heures")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'TOT H';
                //     DecimalPlaces = 0 : 1;
                // }
                /*  field("Remize a Zero"; Rec."Remize a Zero")
                  {
                      ApplicationArea = Basic;
                      Editable = false;

                      trigger OnValidate()
                      begin
                          Rec."1" := 0;
                          Rec."2" := 0;
                          Rec."3" := 0;
                          Rec."4" := 0;
                          Rec."5" := 0;
                          Rec."6" := 0;
                          Rec."7" := 0;
                          Rec."8" := 0;
                          Rec."9" := 0;
                          Rec."10" := 0;
                          Rec."11" := 0;
                          Rec."12" := 0;
                          Rec."13" := 0;
                          Rec."14" := 0;
                          Rec."15" := 0;
                          Rec."16" := 0;
                          Rec."17" := 0;
                          Rec."18" := 0;
                          Rec."19" := 0;
                          Rec."20" := 0;
                          Rec."21" := 0;
                          Rec."22" := 0;
                          Rec."23" := 0;
                          Rec."24" := 0;
                          Rec."25" := 0;
                          Rec."26" := 0;
                          Rec."27" := 0;
                          Rec."28" := 0;
                          Rec."29" := 0;
                          Rec."30" := 0;
                          Rec.Présence := 0;
                          Rec."Dimanche 1" := 0;
                          Rec."Dimanche 2" := 0;
                          Rec."Dimanche 3" := 0;
                          Rec."Dimanche 4" := 0;
                          Rec."Dimanche 5" := 0;
                          Rec."Base Jour" := 0;
                          Rec."Nombre De Jours Travaillé" := 0;
                          Rec."31" := 0;
                          RemizeaZeroOnAfterValidate;
                      end;
                  }*/
            }
            label(Control1000000073)
            {
                ApplicationArea = Basic;
                Caption = '-1 :CONGER ;          -2 : CONGER SPECIALE       ;                -3 : FERIER';
                Style = Strong;
                StyleExpr = true;
            }
            field("COUNT"; Rec.Count)
            {
                ApplicationArea = Basic;
                Caption = 'Nombre Salariés';
                Editable = false;
                Style = Unfavorable;
                StyleExpr = true;
            }

        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetRecordONFORMAT();
        OnFormat;
    end;

    trigger OnOpenPage()
    begin
        Rec.CalcFields("Nombre Salarier");
        NombreSalarié := Rec."Nombre Salarier";
    end;

    var
        EtatMensuellePaie: Record "Etat Mensuelle Paie";
        RecGEmp: Record Employee;
        i: Integer;
        d: Dialog;
        dialogMess1: label 'Défalcation des Heures Supp.';
        dialogMess2: label 'Mise à jours des lignes défalcation.';
        //GL3900    MgmtSuppHour: Codeunit "Management of Work Hours";
        ToTNbrjours: Decimal;
        ToTNbrHeures: Decimal;
        Text001: label 'Suppression Impossible, Journée Valider';
        Text002: label 'Tâche chevée Avec Succée';
        Text003: label 'Attention Vous Allez Supprimer Toutes Les Informations !!!! Continuer Quand Meme ??????????????????';
        CodeQualification: Code[20];
        CodeAffectation: Code[20];
        "NombreSalarié": Integer;
        Text004: label 'Vous Avez Depasser Le Nombre De Jours Autorisés';
        HeureV: Time;
        NbrJours: Integer;
        DateDimanche: Date;
        Cumul: Decimal;
        d1: Date;
        d2: Date;
        d3: Date;
        d4: Date;
        d5, D6 : Date;
        j: Integer;
        Ladate: Date;
        Ladate2: Date;
        Ladate3: Date;
        Ladate4: Date;
        k: Integer;
        CumD1: Decimal;
        CumD2: Decimal;
        CumD3: Decimal;
        CumD4: Decimal;
        CumD5: Decimal;
        Cumul2: Decimal;
        espace: Text[30];
        GDate: Date;
        NbrTotalHeure: Decimal;
        [InDataSet]
        "1Emphasize": Boolean;
        [InDataSet]
        "2Emphasize": Boolean;
        [InDataSet]
        "3Emphasize": Boolean;
        [InDataSet]
        "4Emphasize": Boolean;
        [InDataSet]
        "5Emphasize": Boolean;
        [InDataSet]
        "6Emphasize": Boolean;
        [InDataSet]
        "7Emphasize": Boolean;
        [InDataSet]
        "8Emphasize": Boolean;
        [InDataSet]
        "9Emphasize": Boolean;
        [InDataSet]
        "10Emphasize": Boolean;
        [InDataSet]
        "11Emphasize": Boolean;
        [InDataSet]
        "12Emphasize": Boolean;
        [InDataSet]
        "13Emphasize": Boolean;
        [InDataSet]
        "14Emphasize": Boolean;
        [InDataSet]
        "15Emphasize": Boolean;
        [InDataSet]
        "16Emphasize": Boolean;
        [InDataSet]
        "17Emphasize": Boolean;
        [InDataSet]
        "18Emphasize": Boolean;
        [InDataSet]
        "19Emphasize": Boolean;
        [InDataSet]
        "20Emphasize": Boolean;
        [InDataSet]
        "21Emphasize": Boolean;
        [InDataSet]
        "22Emphasize": Boolean;
        [InDataSet]
        "23Emphasize": Boolean;
        [InDataSet]
        "24Emphasize": Boolean;
        [InDataSet]
        "25Emphasize": Boolean;
        [InDataSet]
        "26Emphasize": Boolean;
        [InDataSet]
        "27Emphasize": Boolean;
        [InDataSet]
        "28Emphasize": Boolean;
        [InDataSet]
        "29Emphasize": Boolean;
        [InDataSet]
        "30Emphasize": Boolean;
        [InDataSet]
        "31Emphasize": Boolean;
        Text19021340: label '-1 :CONGER ;          -2 : CONGER SPECIALE       ;                -3 : FERIER';
        L: Integer;
        M: Integer;
        N: Integer;
        O: Integer;
        Q: Integer;
        Seuil: Integer;


    procedure CalculPresence()
    begin
        /*  if RecGEmp.Get(Rec.Matricule) then;
          Rec."Total Presence" := Presence;
          if RecGEmp.Horaire then TotalHeure;
          if RecGEmp."En Deplacement" then begin
              if Rec.Présence <= 26 then
                  Rec.Deplacement := Rec.Présence
              else
                  Rec.Deplacement := 26;
          end;*/
        IF RecGEmp.GET(rec.Matricule) THEN;
        rec."Total Presence" := rec."1" + rec."2" + rec."3" + rec."4" + rec."5" + rec."6" + rec."7" + rec."8" + rec."9" + rec."10" + rec."11" + rec."12" + rec."13" + rec."14" + rec."15" + rec."16" + rec."17" + rec."18" + rec."19" + rec."20" + rec."21" + rec."22" + rec."23" + rec."24" +
                          rec."25" + rec."26" + rec."27" + rec."28" + rec."29" + rec."30" + rec."31";
        IF RecGEmp.Horaire THEN rec."Total Presence" := rec."Total Presence";
        IF NOT RecGEmp.Horaire THEN rec.Absence := rec.Présence + DimancheTravaille - rec."Total Presence";
        //MESSAGE('Presence %1',Rec.Présence);
        //MESSAGE('Presence %1',"Total Presence");
        //MESSAGE('Presence %1',DimancheTravaille);

        ChercheDimanches;
        DimancheHeureSupp;
        CalcHeureSup;
        CalculJoursMois;
        /* Conge;
         Ferie;
         CongSpecial;*/
    end;

    PROCEDURE CalculJoursMois();
    BEGIN
        rec."Total Presence" := 0;
        IF rec."1" <> 0 THEN rec."Total Presence" += 1;
        IF rec."2" <> 0 THEN rec."Total Presence" += 1;
        IF rec."3" <> 0 THEN rec."Total Presence" += 1;
        IF rec."4" <> 0 THEN rec."Total Presence" += 1;
        IF rec."5" <> 0 THEN rec."Total Presence" += 1;
        IF rec."6" <> 0 THEN rec."Total Presence" += 1;
        IF rec."7" <> 0 THEN rec."Total Presence" += 1;
        IF rec."8" <> 0 THEN rec."Total Presence" += 1;
        IF rec."9" <> 0 THEN rec."Total Presence" += 1;
        IF rec."10" <> 0 THEN rec."Total Presence" += 1;
        IF rec."11" <> 0 THEN rec."Total Presence" += 1;
        IF rec."12" <> 0 THEN rec."Total Presence" += 1;
        IF rec."13" <> 0 THEN rec."Total Presence" += 1;
        IF rec."14" <> 0 THEN rec."Total Presence" += 1;
        IF rec."15" <> 0 THEN rec."Total Presence" += 1;
        IF rec."16" <> 0 THEN rec."Total Presence" += 1;
        IF rec."17" <> 0 THEN rec."Total Presence" += 1;
        IF rec."18" <> 0 THEN rec."Total Presence" += 1;
        IF rec."19" <> 0 THEN rec."Total Presence" += 1;
        IF rec."20" <> 0 THEN rec."Total Presence" += 1;
        IF rec."21" <> 0 THEN rec."Total Presence" += 1;
        IF rec."22" <> 0 THEN rec."Total Presence" += 1;
        IF rec."23" <> 0 THEN rec."Total Presence" += 1;
        IF rec."24" <> 0 THEN rec."Total Presence" += 1;
        IF rec."25" <> 0 THEN rec."Total Presence" += 1;
        IF rec."26" <> 0 THEN rec."Total Presence" += 1;
        IF rec."27" <> 0 THEN rec."Total Presence" += 1;
        IF rec."28" <> 0 THEN rec."Total Presence" += 1;
        IF rec."29" <> 0 THEN rec."Total Presence" += 1;
        IF rec."30" <> 0 THEN rec."Total Presence" += 1;
        IF rec."31" <> 0 THEN rec."Total Presence" += 1;

        rec.Dimanches := 0;
        IF rec.D1 <> 0 THEN rec.Dimanches += rec.D1;
        IF rec.D2 <> 0 THEN rec.Dimanches += rec.D2;
        IF rec.D3 <> 0 THEN rec.Dimanches += rec.D3;
        IF rec.D4 <> 0 THEN rec.Dimanches += rec.D4;
        IF rec.D5 <> 0 THEN rec.Dimanches += rec.D5;

        rec."Presence Perso" := rec."Total Presence";
        rec."Dimanche Non Travailléé" := 0;
        //IF D6=0 THEN "Dimanche Non Travailléé"+=1;
        IF EstDimanches(1) THEN BEGIN IF rec."1" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(2) THEN BEGIN IF rec."2" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(3) THEN BEGIN IF rec."3" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(4) THEN BEGIN IF rec."4" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(5) THEN BEGIN IF rec."5" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(6) THEN BEGIN IF rec."6" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(7) THEN BEGIN IF rec."7" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(8) THEN BEGIN IF rec."8" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(9) THEN BEGIN IF rec."9" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(10) THEN BEGIN IF rec."10" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(11) THEN BEGIN IF rec."11" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(12) THEN BEGIN IF rec."12" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(13) THEN BEGIN IF rec."13" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(14) THEN BEGIN IF rec."14" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(15) THEN BEGIN IF rec."15" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(16) THEN BEGIN IF rec."16" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(17) THEN BEGIN IF rec."17" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(18) THEN BEGIN IF rec."18" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(19) THEN BEGIN IF rec."19" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(20) THEN BEGIN IF rec."20" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(21) THEN BEGIN IF rec."21" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(22) THEN BEGIN IF rec."22" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(23) THEN BEGIN IF rec."23" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(24) THEN BEGIN IF rec."24" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(25) THEN BEGIN IF rec."25" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(26) THEN BEGIN IF rec."26" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(27) THEN BEGIN IF rec."27" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(28) THEN BEGIN IF rec."28" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(29) THEN BEGIN IF rec."29" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(30) THEN BEGIN IF rec."30" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        IF EstDimanches(31) THEN BEGIN IF rec."31" = 0 THEN rec."Dimanche Non Travailléé" += 1 END;
        rec."Total Presence" += rec."Dimanche Non Travailléé";

        rec.Présence := 0;
        IF rec."1" <> 0 THEN Rec."Présence" += rec."1";
        IF rec."2" <> 0 THEN Rec.Présence += rec."2";
        IF rec."3" <> 0 THEN Rec.Présence += rec."3";
        IF rec."4" <> 0 THEN Rec.Présence += rec."4";
        IF rec."5" <> 0 THEN Rec.Présence += rec."5";
        IF rec."6" <> 0 THEN Rec.Présence += rec."6";
        IF rec."7" <> 0 THEN Rec.Présence += rec."7";
        IF rec."8" <> 0 THEN Rec.Présence += rec."8";
        IF rec."9" <> 0 THEN Rec.Présence += rec."9";
        IF rec."10" <> 0 THEN Rec.Présence += rec."10";
        IF rec."11" <> 0 THEN Rec.Présence += rec."11";
        IF rec."12" <> 0 THEN Rec.Présence += rec."12";
        IF rec."13" <> 0 THEN Rec.Présence += rec."13";
        IF rec."14" <> 0 THEN Rec.Présence += rec."14";
        IF rec."15" <> 0 THEN Rec.Présence += rec."15";
        IF rec."16" <> 0 THEN Rec.Présence += rec."16";
        IF rec."17" <> 0 THEN Rec.Présence += rec."17";
        IF rec."18" <> 0 THEN Rec.Présence += rec."18";
        IF rec."19" <> 0 THEN Rec.Présence += rec."19";
        IF rec."20" <> 0 THEN Rec.Présence += rec."20";
        IF rec."21" <> 0 THEN Rec.Présence += rec."21";
        IF rec."22" <> 0 THEN Rec.Présence += rec."22";
        IF rec."23" <> 0 THEN Rec.Présence += rec."23";
        IF rec."24" <> 0 THEN Rec.Présence += rec."24";
        IF rec."25" <> 0 THEN Rec.Présence += rec."25";
        IF rec."26" <> 0 THEN Rec.Présence += rec."26";
        IF rec."27" <> 0 THEN Rec.Présence += rec."27";
        IF rec."28" <> 0 THEN Rec.Présence += rec."28";
        IF rec."29" <> 0 THEN Rec.Présence += rec."29";
        IF rec."30" <> 0 THEN Rec.Présence += rec."30";
        IF rec."31" <> 0 THEN Rec.Présence += rec."31";

        Rec.Présence := Rec.Présence - rec.Dimanches;
        IF Rec.Présence - rec."15%" - rec."35%" > 173.33 THEN
            rec."Presence à Payer" := 30
        ELSE
            rec."Presence à Payer" := rec."Total Presence";

        IF rec."Presence à Payer" > 30 THEN rec."Presence à Payer" := 30;
    END;

    PROCEDURE CalcHeureSup();
    BEGIN
        //60 %
        rec."60%" := rec.D1 + rec.D2 + rec.D3 + rec.D4 + rec.D5 + rec.D6;
        //15%
        rec."15%" := 0;
        rec."35%" := 0;
        IF RecGEmp.GET(rec.Matricule) THEN;
        Seuil := RecGEmp."SeuilHeure Sup";
        IF Seuil = 0 THEN EXIT;
        IF (rec.S1 > Seuil) AND (rec.S1 <= Seuil + 8) THEN rec."15%" += rec.S1 - Seuil;
        IF (rec.S2 > Seuil) AND (rec.S2 <= Seuil + 8) THEN rec."15%" += rec.S2 - Seuil;
        IF (rec.S3 > Seuil) AND (rec.S3 <= Seuil + 8) THEN rec."15%" += rec.S3 - Seuil;
        IF (rec.S4 > Seuil) AND (rec.S4 <= Seuil + 8) THEN rec."15%" += rec.S4 - Seuil;
        IF (rec.S5 > Seuil) AND (rec.S5 <= Seuil + 8) THEN rec."15%" += rec.S5 - Seuil;
        IF (rec.S6 > Seuil) AND (rec.S6 <= Seuil + 8) THEN rec."15%" += rec.S6 - Seuil;
        // 35%
        IF (rec.S1 > Seuil + 8) THEN rec."35%" += rec.S1 - (Seuil + 8);
        IF (rec.S2 > Seuil + 8) THEN rec."35%" += rec.S2 - (Seuil + 8);
        IF (rec.S3 > Seuil + 8) THEN rec."35%" += rec.S3 - (Seuil + 8);
        IF (rec.S4 > Seuil + 8) THEN rec."35%" += rec.S4 - (Seuil + 8);
        IF (rec.S5 > Seuil + 8) THEN rec."35%" += rec.S5 - (Seuil + 8);
        IF (rec.S6 > Seuil + 8) THEN rec."35%" += rec.S6 - (Seuil + 8);

        IF (rec.S1 > Seuil + 8) THEN rec."15%" += 8;
        IF (rec.S2 > Seuil + 8) THEN rec."15%" += 8;
        IF (rec.S3 > Seuil + 8) THEN rec."15%" += 8;
        IF (rec.S4 > Seuil + 8) THEN rec."15%" += 8;
        IF (rec.S5 > Seuil + 8) THEN rec."15%" += 8;
        IF (rec.S6 > Seuil + 8) THEN rec."15%" += 8;
        rec."15%" += rec."15% Ant";
        rec."35%" += rec."35% Ant";
    END;

    PROCEDURE DimancheHeureSupp() EnMoins: Integer;
    VAR
        DateDebut: Date;
        TextL001: Label 'FRA=Jour Dimanche Saisie Interdite';
        DateFin: Date;
        DimTravaille: Integer;
        J: Integer;
        K: Integer;
        M: Integer;
    BEGIN
        DimTravaille := 0;
        EnMoins := 0;
        Q := 0;

        IF rec."Mois Attachement" = 1 THEN
            DateDebut := DMY2DATE(20, 12, rec."Annee Attachement" - 1)
        ELSE
            DateDebut := DMY2DATE(20, rec."Mois Attachement" - 1, rec."Annee Attachement");


        DateFin := CALCDATE('FM', DateDebut);
        O := 21;
        J := DateFin - DateDebut + 1;
        FOR L := 1 TO J DO BEGIN
            DateDimanche := DateDebut + L;
            IF DATE2DWY(DateDimanche, 1) = 7 THEN BEGIN
                Q += 1;
                IF DATE2DMY(DateDimanche, 1) = 21 THEN N := rec."21";
                IF DATE2DMY(DateDimanche, 1) = 22 THEN N := rec."22";
                IF DATE2DMY(DateDimanche, 1) = 23 THEN N := rec."23";
                IF DATE2DMY(DateDimanche, 1) = 24 THEN N := rec."24";
                IF DATE2DMY(DateDimanche, 1) = 25 THEN N := rec."25";
                IF DATE2DMY(DateDimanche, 1) = 26 THEN N := rec."26";
                IF DATE2DMY(DateDimanche, 1) = 27 THEN N := rec."27";
                IF DATE2DMY(DateDimanche, 1) = 28 THEN N := rec."28";
                IF DATE2DMY(DateDimanche, 1) = 29 THEN N := rec."29";
                IF DATE2DMY(DateDimanche, 1) = 30 THEN N := rec."30";
                IF DATE2DMY(DateDimanche, 1) = 31 THEN N := rec."31";


            END;
            IF Q = 1 THEN rec.D1 := N;
            IF Q = 2 THEN rec.D2 := N;
            IF Q = 3 THEN rec.D3 := N;
            IF Q = 4 THEN rec.D4 := N;
            IF Q = 5 THEN rec.D5 := N;
            IF Q = 6 THEN rec.D6 := N;


        END;
        L := 0;

        FOR L := 1 TO 20 DO BEGIN
            DateDimanche := DMY2DATE(L, rec."Mois Attachement", rec."Annee Attachement");
            IF DATE2DWY(DateDimanche, 1) = 7 THEN BEGIN
                Q += 1;
                N := 0;
                IF L = 1 THEN N := rec."1";
                IF L = 2 THEN N := rec."2";
                IF L = 3 THEN N := rec."3";
                IF L = 4 THEN N := rec."4";
                IF L = 5 THEN N := rec."5";
                IF L = 6 THEN N := rec."6";
                IF L = 7 THEN N := rec."7";
                IF L = 8 THEN N := rec."8";
                IF L = 9 THEN N := rec."9";
                IF L = 10 THEN N := rec."10";
                IF L = 11 THEN N := rec."11";
                IF L = 12 THEN N := rec."12";
                IF L = 13 THEN N := rec."13";
                IF L = 14 THEN N := rec."14";
                IF L = 15 THEN N := rec."15";
                IF L = 16 THEN N := rec."16";
                IF L = 17 THEN N := rec."17";
                IF L = 18 THEN N := rec."18";
                IF L = 19 THEN N := rec."19";
                IF L = 20 THEN N := rec."20";
            END;
            IF Q = 1 THEN rec.D1 := N;
            IF Q = 2 THEN rec.D2 := N;
            IF Q = 3 THEN rec.D3 := N;
            IF Q = 4 THEN rec.D4 := N;
            IF Q = 5 THEN rec.D5 := N;
            IF Q = 6 THEN rec.D6 := N;
        END;
    END;

    procedure FinMois(ParaJournee: Integer) DateFin: Date
    var
        Text001: label 'Depassement Dans La Date Saisie, Mois Max Journée : %1';
    begin
        DateFin := CalcDate('FM', WorkDate);
        if ParaJournee > Date2dmy(DateFin, 1) then;// ERROR(Text001,DATE2DMY(DateFin,1));
    end;


    procedure DimancheTravaille() EnMoins: Integer
    var
        DateDebut: Date;
        TextL001: label 'Jour Dimanche Saisie Interdite';
        DateFin: Date;
        DimTravaille: Integer;
        J: Integer;
        K: Integer;
        M: Integer;
    begin
        DimTravaille := 0;
        EnMoins := 0;

        DateDimanche := Dmy2date(1, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."1" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(2, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."2" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(3, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."3" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(4, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."4" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(5, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."5" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(6, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."6" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(7, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."7" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(8, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."8" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(9, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."9" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(10, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."10" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(11, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."11" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(12, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."12" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(13, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."13" = 1 then EnMoins += 1;


        DateDimanche := Dmy2date(14, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."14" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(15, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."15" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(16, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."16" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(17, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."17" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(18, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."18" = 1 then EnMoins += 1;


        DateDimanche := Dmy2date(19, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."19" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(20, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."20" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(21, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."21" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(22, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."22" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(23, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."23" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(24, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."24" = 1 then EnMoins += 1;

        DateDimanche := Dmy2date(25, Rec."Mois Attachement", Rec."Annee Attachement");
        if Date2dwy(DateDimanche, 1) = 7 then if Rec."25" = 1 then EnMoins += 1;


        if Rec."Mois Attachement" = 1 then
            DateDebut := DMY2DATE(21, 12, rec."Annee Attachement" - 1)
        else
            DateDebut := DMY2DATE(21, rec."Mois Attachement" - 1, rec."Annee Attachement");


        DateFin := CalcDate('FM', DateDebut);
        M := 25;
        J := DateFin - DateDebut;

        for K := 1 to J do begin
            M += 1;
            IF M = 21 THEN BEGIN
                DateDimanche := DMY2DATE(21, DATE2DMY(DateDebut, 2), DATE2DMY(DateDebut, 3));
                IF DATE2DWY(DateDimanche, 1) = 7 THEN IF rec."21" = 1 THEN EnMoins += 1;

            END;

            IF M = 22 THEN BEGIN
                DateDimanche := DMY2DATE(22, DATE2DMY(DateDebut, 2), DATE2DMY(DateDebut, 3));
                IF DATE2DWY(DateDimanche, 1) = 7 THEN IF rec."22" = 1 THEN EnMoins += 1;

            END;

            IF M = 23 THEN BEGIN
                DateDimanche := DMY2DATE(23, DATE2DMY(DateDebut, 2), DATE2DMY(DateDebut, 3));
                IF DATE2DWY(DateDimanche, 1) = 7 THEN IF rec."23" = 1 THEN EnMoins += 1;

            END;

            IF M = 24 THEN BEGIN
                DateDimanche := DMY2DATE(24, DATE2DMY(DateDebut, 2), DATE2DMY(DateDebut, 3));
                IF DATE2DWY(DateDimanche, 1) = 7 THEN IF rec."24" = 1 THEN EnMoins += 1;

            END;

            IF M = 25 THEN BEGIN
                DateDimanche := DMY2DATE(25, DATE2DMY(DateDebut, 2), DATE2DMY(DateDebut, 3));
                IF DATE2DWY(DateDimanche, 1) = 7 THEN IF rec."25" = 1 THEN EnMoins += 1;

            END;
            if M = 26 then begin
                DateDimanche := Dmy2date(26, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
                if Date2dwy(DateDimanche, 1) = 7 then if Rec."26" = 1 then EnMoins += 1;

            end;
            if M = 27 then begin
                DateDimanche := Dmy2date(27, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
                if Date2dwy(DateDimanche, 1) = 7 then if Rec."27" = 1 then EnMoins += 1;

            end;
            if M = 28 then begin
                DateDimanche := Dmy2date(28, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
                if Date2dwy(DateDimanche, 1) = 7 then if Rec."28" = 1 then EnMoins += 1;

            end;
            if M = 29 then begin
                DateDimanche := Dmy2date(29, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
                if Date2dwy(DateDimanche, 1) = 7 then if Rec."29" = 1 then EnMoins += 1;

            end;

            if M = 30 then begin
                DateDimanche := Dmy2date(30, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
                if Date2dwy(DateDimanche, 1) = 7 then if Rec."30" = 1 then EnMoins += 1;

            end;

            if M = 31 then begin
                DateDimanche := Dmy2date(31, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
                if Date2dwy(DateDimanche, 1) = 7 then if Rec."31" = 1 then EnMoins += 1;

            end;




        end;
    end;


    procedure ChercheDimanches()
    begin
        Ladate := DMY2DATE(1, rec."Mois Attachement", rec."Annee Attachement");
        Ladate2 := Ladate - 1;
        i := 0;
        j := 0;
        k := 0;
        rec.S1 := 0;
        rec.S2 := 0;
        rec.S3 := 0;
        rec.S4 := 0;
        rec.S5 := 0;
        rec.S6 := 0;
        Cumul2 := 0;
        FOR i := 21 TO DATE2DMY(Ladate2, 1) DO BEGIN
            Ladate3 := DMY2DATE(i, DATE2DMY(Ladate2, 2), DATE2DMY(Ladate2, 3));
            IF DATE2DWY(Ladate3, 1) = 7 THEN BEGIN
                k += 1;
                IF NOT EstDimanches(21) THEN IF i = 21 THEN Cumul2 += rec."21";
                IF NOT EstDimanches(22) THEN BEGIN IF i = 22 THEN Cumul2 += rec."22" END;
                IF NOT EstDimanches(23) THEN BEGIN IF i = 23 THEN Cumul2 += rec."23" END;
                IF NOT EstDimanches(24) THEN BEGIN IF i = 24 THEN Cumul2 += rec."24" END;
                IF NOT EstDimanches(25) THEN BEGIN IF i = 25 THEN Cumul2 += rec."25" END;
                IF NOT EstDimanches(26) THEN BEGIN IF i = 26 THEN Cumul2 += rec."26" END;
                IF NOT EstDimanches(27) THEN BEGIN IF i = 27 THEN Cumul2 += rec."27" END;
                IF NOT EstDimanches(28) THEN BEGIN IF i = 28 THEN Cumul2 += rec."28" END;
                IF NOT EstDimanches(29) THEN BEGIN IF i = 29 THEN Cumul2 += rec."29" END;
                IF NOT EstDimanches(30) THEN BEGIN IF i = 30 THEN Cumul2 += rec."30" END;
                IF NOT EstDimanches(31) THEN BEGIN IF i = 31 THEN Cumul2 += rec."31" END;
                IF k = 1 THEN rec.S1 := Cumul2;
                IF k = 2 THEN rec.S2 := Cumul2;
                Cumul2 := 0;
            END
            ELSE BEGIN
                IF i = 21 THEN Cumul2 += rec."21";
                IF i = 22 THEN Cumul2 += rec."22";
                IF i = 23 THEN Cumul2 += rec."23";
                IF i = 24 THEN Cumul2 += rec."24";
                IF i = 25 THEN Cumul2 += rec."25";
                IF i = 26 THEN Cumul2 += rec."26";
                IF i = 27 THEN Cumul2 += rec."27";
                IF i = 28 THEN Cumul2 += rec."28";
                IF i = 29 THEN Cumul2 += rec."29";
                IF i = 30 THEN Cumul2 += rec."30";
                IF i = 31 THEN Cumul2 += rec."31";

            END;

        END;

        FOR j := 1 TO 20 DO BEGIN
            Ladate3 := DMY2DATE(j, DATE2DMY(Ladate, 2), DATE2DMY(Ladate, 3));
            IF DATE2DWY(Ladate3, 1) = 7 THEN BEGIN
                k += 1;
                IF NOT EstDimanches(1) THEN BEGIN IF j = 1 THEN Cumul2 += rec."1" END;
                IF NOT EstDimanches(2) THEN BEGIN IF j = 2 THEN Cumul2 += rec."2" END;
                IF NOT EstDimanches(3) THEN BEGIN IF j = 3 THEN Cumul2 += rec."3" END;
                IF NOT EstDimanches(4) THEN BEGIN IF j = 4 THEN Cumul2 += rec."4" END;
                IF NOT EstDimanches(5) THEN BEGIN IF j = 5 THEN Cumul2 += rec."5" END;
                IF NOT EstDimanches(6) THEN BEGIN IF j = 6 THEN Cumul2 += rec."6" END;
                IF NOT EstDimanches(7) THEN BEGIN IF j = 7 THEN Cumul2 += rec."7" END;
                IF NOT EstDimanches(8) THEN BEGIN IF j = 8 THEN Cumul2 += rec."8" END;
                IF NOT EstDimanches(9) THEN BEGIN IF j = 9 THEN Cumul2 += rec."9" END;
                IF NOT EstDimanches(10) THEN BEGIN IF j = 10 THEN Cumul2 += rec."10" END;
                IF NOT EstDimanches(11) THEN BEGIN IF j = 11 THEN Cumul2 += rec."11" END;
                IF NOT EstDimanches(12) THEN BEGIN IF j = 12 THEN Cumul2 += rec."12" END;
                IF NOT EstDimanches(13) THEN BEGIN IF j = 13 THEN Cumul2 += rec."13" END;
                IF NOT EstDimanches(14) THEN BEGIN IF j = 14 THEN Cumul2 += rec."14" END;
                IF NOT EstDimanches(15) THEN BEGIN IF j = 15 THEN Cumul2 += rec."15" END;
                IF NOT EstDimanches(16) THEN BEGIN IF j = 16 THEN Cumul2 += rec."16" END;
                IF NOT EstDimanches(17) THEN BEGIN IF j = 17 THEN Cumul2 += rec."17" END;
                IF NOT EstDimanches(18) THEN BEGIN IF j = 18 THEN Cumul2 += rec."18" END;
                IF NOT EstDimanches(19) THEN BEGIN IF j = 19 THEN Cumul2 += rec."19" END;
                IF NOT EstDimanches(20) THEN BEGIN IF j = 20 THEN Cumul2 += rec."20" END;
                IF k = 1 THEN rec.S1 := Cumul2;
                IF k = 2 THEN rec.S2 := Cumul2;
                IF k = 3 THEN rec.S3 := Cumul2;
                IF k = 4 THEN rec.S4 := Cumul2;
                IF k = 5 THEN rec.S5 := Cumul2;

                Cumul2 := 0;


            END
            ELSE BEGIN
                IF j = 1 THEN Cumul2 += rec."1";
                IF j = 2 THEN Cumul2 += rec."2";
                IF j = 3 THEN Cumul2 += rec."3";
                IF j = 4 THEN Cumul2 += rec."4";
                IF j = 5 THEN Cumul2 += rec."5";
                IF j = 6 THEN Cumul2 += rec."6";
                IF j = 7 THEN Cumul2 += rec."7";
                IF j = 8 THEN Cumul2 += rec."8";
                IF j = 9 THEN Cumul2 += rec."9";
                IF j = 10 THEN Cumul2 += rec."10";
                IF j = 11 THEN Cumul2 += rec."11";
                IF j = 12 THEN Cumul2 += rec."12";
                IF j = 13 THEN Cumul2 += rec."13";
                IF j = 14 THEN Cumul2 += rec."14";
                IF j = 15 THEN Cumul2 += rec."15";
                IF j = 16 THEN Cumul2 += rec."16";
                IF j = 17 THEN Cumul2 += rec."17";
                IF j = 18 THEN Cumul2 += rec."18";
                IF j = 19 THEN Cumul2 += rec."19";

                IF k = 5 THEN rec.S6 := Cumul2;
            END;
        END;
        IF (rec.S5 = 0) AND (rec.S6 = 0) THEN rec.S5 := Cumul2;
    end;


    procedure EstDimanches(ParaJour: Integer) EstDim: Boolean
    var
        LFinMois: Date;
        Localdate: Date;
        Localdate2: Date;
        Localdate3: Date;
    begin
        IF (ParaJour = 0) OR (rec."Mois Attachement" = 0) OR (rec."Annee Attachement" = 0) THEN EXIT;
        EstDim := FALSE;
        IF (ParaJour >= 21) AND (ParaJour <= 30) THEN BEGIN
            IF rec."Mois Attachement" = 1 THEN
                Localdate := DMY2DATE(ParaJour, 12, rec."Annee Attachement" - 1)
            ELSE
                Localdate := DMY2DATE(ParaJour, rec."Mois Attachement" - 1, rec."Annee Attachement");
            IF DATE2DWY(Localdate, 1) = 7 THEN EXIT(TRUE);
        END;
        IF ParaJour = 31 THEN BEGIN
            IF rec."Mois Attachement" = 1 THEN
                Localdate := DMY2DATE(ParaJour, 12, rec."Annee Attachement" - 1)
            ELSE BEGIN
                Localdate2 := DMY2DATE(1, rec."Mois Attachement" - 1, rec."Annee Attachement");
                Localdate3 := CALCDATE('FM', Localdate2);
                IF DATE2DMY(Localdate3, 1) = 31 THEN BEGIN
                    Localdate := DMY2DATE(ParaJour, rec."Mois Attachement" - 1, rec."Annee Attachement");
                    IF DATE2DWY(Localdate, 1) = 7 THEN EXIT(TRUE);
                END
                ELSE
                    EXIT(FALSE);
            END;

        END;

        IF (ParaJour >= 1) AND (ParaJour < 21) THEN BEGIN
            Localdate := DMY2DATE(ParaJour, rec."Mois Attachement", rec."Annee Attachement");
            IF DATE2DWY(Localdate, 1) = 7 THEN EXIT(TRUE);
        END;
        /*  if (ParaJour = 0) or (Rec."Mois Attachement" = 0) or (Rec."Annee Attachement" = 0) then exit;
          EstDim := false;
          LFinMois := CalcDate('FM', Dmy2date(1, Rec."Mois Attachement", Rec."Annee Attachement"));
          if ParaJour > Date2dmy(LFinMois, 1) then exit;
          Ladate := Dmy2date(ParaJour, Rec."Mois Attachement", Rec."Annee Attachement");
          if Date2dwy(Ladate, 1) = 7 then exit(true);*/
    end;


    procedure Presence() JoursPres: Decimal
    var
        LTotJour: Decimal;
    begin
        JoursPres := 0;
        if RecGEmp.Horaire then begin
            if Rec."1" > 0 then JoursPres += 1;
            if Rec."2" > 0 then JoursPres += 1;
            if Rec."3" > 0 then JoursPres += 1;
            if Rec."4" > 0 then JoursPres += 1;
            if Rec."5" > 0 then JoursPres += 1;
            if Rec."6" > 0 then JoursPres += 1;
            if Rec."7" > 0 then JoursPres += 1;
            if Rec."8" > 0 then JoursPres += 1;
            if Rec."9" > 0 then JoursPres += 1;
            if Rec."10" > 0 then JoursPres += 1;
            if Rec."11" > 0 then JoursPres += 1;
            if Rec."12" > 0 then JoursPres += 1;
            if Rec."13" > 0 then JoursPres += 1;
            if Rec."14" > 0 then JoursPres += 1;
            if Rec."15" > 0 then JoursPres += 1;
            if Rec."16" > 0 then JoursPres += 1;
            if Rec."17" > 0 then JoursPres += 1;
            if Rec."18" > 0 then JoursPres += 1;
            if Rec."19" > 0 then JoursPres += 1;
            if Rec."20" > 0 then JoursPres += 1;
            if Rec."21" > 0 then JoursPres += 1;
            if Rec."22" > 0 then JoursPres += 1;
            if Rec."23" > 0 then JoursPres += 1;
            if Rec."24" > 0 then JoursPres += 1;
            if Rec."25" > 0 then JoursPres += 1;
            if Rec."26" > 0 then JoursPres += 1;
            if Rec."27" > 0 then JoursPres += 1;
            if Rec."28" > 0 then JoursPres += 1;
            if Rec."29" > 0 then JoursPres += 1;
            if Rec."30" > 0 then JoursPres += 1;
            if Rec."31" > 0 then JoursPres += 1;
        end;
        if not RecGEmp.Horaire then begin
            if Rec."1" > 0 then LTotJour += Rec."1";
            if Rec."2" > 0 then LTotJour += Rec."2";
            if Rec."3" > 0 then LTotJour += Rec."3";
            if Rec."4" > 0 then LTotJour += Rec."4";
            if Rec."5" > 0 then LTotJour += Rec."5";
            if Rec."6" > 0 then LTotJour += Rec."6";
            if Rec."7" > 0 then LTotJour += Rec."7";
            if Rec."8" > 0 then LTotJour += Rec."8";
            if Rec."9" > 0 then LTotJour += Rec."9";
            if Rec."10" > 0 then LTotJour += Rec."10";
            if Rec."11" > 0 then LTotJour += Rec."11";
            if Rec."12" > 0 then LTotJour += Rec."12";
            if Rec."13" > 0 then LTotJour += Rec."13";
            if Rec."14" > 0 then LTotJour += Rec."14";
            if Rec."15" > 0 then LTotJour += Rec."15";
            if Rec."16" > 0 then LTotJour += Rec."16";
            if Rec."17" > 0 then LTotJour += Rec."17";
            if Rec."18" > 0 then LTotJour += Rec."18";
            if Rec."19" > 0 then LTotJour += Rec."19";
            if Rec."20" > 0 then LTotJour += Rec."20";
            if Rec."21" > 0 then LTotJour += Rec."21";
            if Rec."22" > 0 then LTotJour += Rec."22";
            if Rec."23" > 0 then LTotJour += Rec."23";
            if Rec."24" > 0 then LTotJour += Rec."24";
            if Rec."25" > 0 then LTotJour += Rec."25";
            if Rec."26" > 0 then LTotJour += Rec."26";
            if Rec."27" > 0 then LTotJour += Rec."27";
            if Rec."28" > 0 then LTotJour += Rec."28";
            if Rec."29" > 0 then LTotJour += Rec."29";
            if Rec."30" > 0 then LTotJour += Rec."30";
            if Rec."31" > 0 then LTotJour += Rec."31";
            JoursPres := LTotJour;
        end;

        exit(JoursPres);
    end;


    procedure Conge() JoursPres: Integer
    begin
        JoursPres := 0;
        if Rec."1" = -1 then JoursPres += 1;
        if Rec."2" = -1 then JoursPres += 1;
        if Rec."3" = -1 then JoursPres += 1;
        if Rec."4" = -1 then JoursPres += 1;
        if Rec."5" = -1 then JoursPres += 1;
        if Rec."6" = -1 then JoursPres += 1;
        if Rec."7" = -1 then JoursPres += 1;
        if Rec."8" = -1 then JoursPres += 1;
        if Rec."9" = -1 then JoursPres += 1;
        if Rec."10" = -1 then JoursPres += 1;
        if Rec."11" = -1 then JoursPres += 1;
        if Rec."12" = -1 then JoursPres += 1;
        if Rec."13" = -1 then JoursPres += 1;
        if Rec."14" = -1 then JoursPres += 1;
        if Rec."15" = -1 then JoursPres += 1;
        if Rec."16" = -1 then JoursPres += 1;
        if Rec."17" = -1 then JoursPres += 1;
        if Rec."18" = -1 then JoursPres += 1;
        if Rec."19" = -1 then JoursPres += 1;
        if Rec."20" = -1 then JoursPres += 1;
        if Rec."21" = -1 then JoursPres += 1;
        if Rec."22" = -1 then JoursPres += 1;
        if Rec."23" = -1 then JoursPres += 1;
        if Rec."24" = -1 then JoursPres += 1;
        if Rec."25" = -1 then JoursPres += 1;
        if Rec."26" = -1 then JoursPres += 1;
        if Rec."27" = -1 then JoursPres += 1;
        if Rec."28" = -1 then JoursPres += 1;
        if Rec."29" = -1 then JoursPres += 1;
        if Rec."30" = -1 then JoursPres += 1;
        if Rec."31" = -1 then JoursPres += 1;
        Rec.Congé := JoursPres;
    end;


    procedure Ferie() JoursPres: Integer
    begin
        JoursPres := 0;

        if Rec."1" = -3 then JoursPres += 1;
        if Rec."2" = -3 then JoursPres += 1;
        if Rec."3" = -3 then JoursPres += 1;
        if Rec."4" = -3 then JoursPres += 1;
        if Rec."5" = -3 then JoursPres += 1;
        if Rec."6" = -3 then JoursPres += 1;
        if Rec."7" = -3 then JoursPres += 1;
        if Rec."8" = -3 then JoursPres += 1;
        if Rec."9" = -3 then JoursPres += 1;
        if Rec."10" = -3 then JoursPres += 1;
        if Rec."11" = -3 then JoursPres += 1;
        if Rec."12" = -3 then JoursPres += 1;
        if Rec."13" = -3 then JoursPres += 1;
        if Rec."14" = -3 then JoursPres += 1;
        if Rec."15" = -3 then JoursPres += 1;
        if Rec."16" = -3 then JoursPres += 1;
        if Rec."17" = -3 then JoursPres += 1;
        if Rec."18" = -3 then JoursPres += 1;
        if Rec."19" = -3 then JoursPres += 1;
        if Rec."20" = -3 then JoursPres += 1;
        if Rec."21" = -3 then JoursPres += 1;
        if Rec."22" = -3 then JoursPres += 1;
        if Rec."23" = -3 then JoursPres += 1;
        if Rec."24" = -3 then JoursPres += 1;
        if Rec."25" = -3 then JoursPres += 1;
        if Rec."26" = -3 then JoursPres += 1;
        if Rec."27" = -3 then JoursPres += 1;
        if Rec."28" = -3 then JoursPres += 1;
        if Rec."29" = -3 then JoursPres += 1;
        if Rec."30" = -3 then JoursPres += 1;
        if Rec."31" = -3 then JoursPres += 1;
        Rec.Férier := JoursPres;
    end;


    procedure CongSpecial() JoursPres: Integer
    begin
        JoursPres := 0;

        if Rec."1" = -2 then JoursPres += 1;
        if Rec."2" = -2 then JoursPres += 1;
        if Rec."3" = -2 then JoursPres += 1;
        if Rec."4" = -2 then JoursPres += 1;
        if Rec."5" = -2 then JoursPres += 1;
        if Rec."6" = -2 then JoursPres += 1;
        if Rec."7" = -2 then JoursPres += 1;
        if Rec."8" = -2 then JoursPres += 1;
        if Rec."9" = -2 then JoursPres += 1;
        if Rec."10" = -2 then JoursPres += 1;
        if Rec."11" = -2 then JoursPres += 1;
        if Rec."12" = -2 then JoursPres += 1;
        if Rec."13" = -2 then JoursPres += 1;
        if Rec."14" = -2 then JoursPres += 1;
        if Rec."15" = -2 then JoursPres += 1;
        if Rec."16" = -2 then JoursPres += 1;
        if Rec."17" = -2 then JoursPres += 1;
        if Rec."18" = -2 then JoursPres += 1;
        if Rec."19" = -2 then JoursPres += 1;
        if Rec."20" = -2 then JoursPres += 1;
        if Rec."21" = -2 then JoursPres += 1;
        if Rec."22" = -2 then JoursPres += 1;
        if Rec."23" = -2 then JoursPres += 1;
        if Rec."24" = -2 then JoursPres += 1;
        if Rec."25" = -2 then JoursPres += 1;
        if Rec."26" = -2 then JoursPres += 1;
        if Rec."27" = -2 then JoursPres += 1;
        if Rec."28" = -2 then JoursPres += 1;
        if Rec."29" = -2 then JoursPres += 1;
        if Rec."30" = -2 then JoursPres += 1;
        if Rec."31" = -2 then JoursPres += 1;

        //  Rec."Conger Speciale" := JoursPres;
    end;


    procedure TotalHeure() TotH: Decimal
    var
        LTotHeure: Decimal;
    begin
        LTotHeure := 0;
        if Rec."1" > 0 then LTotHeure += Rec."1";
        if Rec."2" > 0 then LTotHeure += Rec."2";
        if Rec."3" > 0 then LTotHeure += Rec."3";
        if Rec."4" > 0 then LTotHeure += Rec."4";
        if Rec."5" > 0 then LTotHeure += Rec."5";
        if Rec."6" > 0 then LTotHeure += Rec."6";
        if Rec."7" > 0 then LTotHeure += Rec."7";
        if Rec."8" > 0 then LTotHeure += Rec."8";
        if Rec."9" > 0 then LTotHeure += Rec."9";
        if Rec."10" > 0 then LTotHeure += Rec."10";
        if Rec."11" > 0 then LTotHeure += Rec."11";
        if Rec."12" > 0 then LTotHeure += Rec."12";
        if Rec."13" > 0 then LTotHeure += Rec."13";
        if Rec."14" > 0 then LTotHeure += Rec."14";
        if Rec."15" > 0 then LTotHeure += Rec."15";
        if Rec."16" > 0 then LTotHeure += Rec."16";
        if Rec."17" > 0 then LTotHeure += Rec."17";
        if Rec."18" > 0 then LTotHeure += Rec."18";
        if Rec."19" > 0 then LTotHeure += Rec."19";
        if Rec."20" > 0 then LTotHeure += Rec."20";
        if Rec."21" > 0 then LTotHeure += Rec."21";
        if Rec."22" > 0 then LTotHeure += Rec."22";
        if Rec."23" > 0 then LTotHeure += Rec."23";
        if Rec."24" > 0 then LTotHeure += Rec."24";
        if Rec."25" > 0 then LTotHeure += Rec."25";
        if Rec."26" > 0 then LTotHeure += Rec."26";
        if Rec."27" > 0 then LTotHeure += Rec."27";
        if Rec."28" > 0 then LTotHeure += Rec."28";
        if Rec."29" > 0 then LTotHeure += Rec."29";
        if Rec."30" > 0 then LTotHeure += Rec."30";
        if Rec."31" > 0 then LTotHeure += Rec."31";

        //  Rec."Total Heures" := LTotHeure;
    end;

    local procedure MatriculeOnAfterValidate()
    begin
        if RecGEmp.Get(Rec.Matricule) then
            Rec.Bage := RecGEmp."N° Badge";
    end;

    local procedure RemizeaZeroOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure MatriculeOnAfterInput(var Text: Text[1024])
    begin
        if RecGEmp.Get(Rec.Matricule) then
            Rec.Bage := RecGEmp."N° Badge";
    end;

    local procedure MatriculeOnFormat()
    begin
        //GL2024
        //IF RecGEmp.GET(Matricule) THEN;
        //IF RecGEmp.Horaire THEN BEGIN END
        //ELSE CurrPage.Matricule.UPDATEFORECOLOR(16711680)
    end;

    local procedure OnFormat()
    begin
        if Rec."Mois Attachement" = 0 then exit;
        if Rec."Mois Attachement" = 1 then
            GDate := Dmy2date(1, 12, Rec."Annee Attachement" - 1)
        else
            GDate := Dmy2date(1, Rec."Mois Attachement" - 1, Rec."Annee Attachement");
        GDate := CalcDate('FM', GDate);
        if Date2dmy(GDate, 1) = 31 then begin

            if EstDimanches(31) then begin
                "31Emphasize" := true;
                //GL2024
                //CurrPage."31".UPDATEFORECOLOR(255)
            end;
        end;
    end;

    local procedure OnAfterGetRecordONFORMAT()
    begin
        MatriculeOnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
        OnFormat;
    end;
}

