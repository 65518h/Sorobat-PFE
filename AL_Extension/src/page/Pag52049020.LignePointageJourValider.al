// page 52049020 "Ligne Pointage Jour. Valider"
// {
//     //GL2024  ID dans Nav 2009 : "39001548"
//     DelayedInsert = true;
//     InsertAllowed = true;
//     PageType = ListPart;
//     SourceTable = "Ligne Pointage Salarié Chanti";
//     SourceTableView = sorting(Affectation, "Base Jour", Matricule)
//                       where(Statut = const(Valider));

//     Caption = 'Ligne Pointage Jour. Valider';
//     ApplicationArea = All;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field(Matricule; Rec.Matricule)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;

//                     trigger OnValidate()
//                     begin
//                         if RecGEmp.Get(Rec.Matricule) then
//                             Rec.Bage := RecGEmp."N° Badge";
//                         MatriculeOnAfterValidate;
//                     end;
//                 }
//                 field(Nom; Rec.Nom)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(espace; espace)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = '-';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("1"; Rec."1")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("2"; Rec."2")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("3"; Rec."3")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("4"; Rec."4")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("5"; Rec."5")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("6"; Rec."6")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("7"; Rec."7")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("8"; Rec."8")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("9"; Rec."9")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("10"; Rec."10")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("11"; Rec."11")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("12"; Rec."12")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("13"; Rec."13")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("14"; Rec."14")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("15"; Rec."15")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("16"; Rec."16")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("17"; Rec."17")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("18"; Rec."18")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("19"; Rec."19")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("20"; Rec."20")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("21"; Rec."21")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("22"; Rec."22")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("23"; Rec."23")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("24"; Rec."24")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("25"; Rec."25")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("26"; Rec."26")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("27"; Rec."27")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("28"; Rec."28")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("29"; Rec."29")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("30"; Rec."30")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         CalculPresence;
//                     end;
//                 }
//                 field("31"; Rec."31")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         FinMois(31);
//                         CalculPresence;
//                     end;
//                 }
//                 field("Congé"; Rec.Congé)
//                 {
//                     ApplicationArea = Basic;
//                     DecimalPlaces = 0 : 2;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Férier"; Rec.Férier)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Conger Speciale"; Rec."Conger Speciale")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Deplacement; Rec.Deplacement)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Deplac';
//                     DecimalPlaces = 0 : 2;
//                 }
//                 field("Heure Mauvais Temps"; Rec."Heure Mauvais Temps")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'HMVT';
//                     DecimalPlaces = 0 : 1;
//                 }
//                 field("Retenue Heure Mauvais Temps"; Rec."Retenue Heure Mauvais Temps")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'RMVT';
//                     DecimalPlaces = 0 : 1;
//                 }
//                 field("Solde Heure Mauvais Temps"; Rec."Solde Heure Mauvais Temps")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'SMVT';
//                     DecimalPlaces = 0 : 1;
//                 }
//                 field(Presence1; Presence)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Tot Pres.';
//                     DecimalPlaces = 0 : 1;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Total Heures"; Rec."Total Heures")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'TOT H';
//                     DecimalPlaces = 0 : 1;
//                 }
//                 field("Remize a Zero"; Rec."Remize a Zero")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         Rec."1" := 0;
//                         Rec."2" := 0;
//                         Rec."3" := 0;
//                         Rec."4" := 0;
//                         Rec."5" := 0;
//                         Rec."6" := 0;
//                         Rec."7" := 0;
//                         Rec."8" := 0;
//                         Rec."9" := 0;
//                         Rec."10" := 0;
//                         Rec."11" := 0;
//                         Rec."12" := 0;
//                         Rec."13" := 0;
//                         Rec."14" := 0;
//                         Rec."15" := 0;
//                         Rec."16" := 0;
//                         Rec."17" := 0;
//                         Rec."18" := 0;
//                         Rec."19" := 0;
//                         Rec."20" := 0;
//                         Rec."21" := 0;
//                         Rec."22" := 0;
//                         Rec."23" := 0;
//                         Rec."24" := 0;
//                         Rec."25" := 0;
//                         Rec."26" := 0;
//                         Rec."27" := 0;
//                         Rec."28" := 0;
//                         Rec."29" := 0;
//                         Rec."30" := 0;
//                         Rec.Présence := 0;
//                         Rec."Dimanche 1" := 0;
//                         Rec."Dimanche 2" := 0;
//                         Rec."Dimanche 3" := 0;
//                         Rec."Dimanche 4" := 0;
//                         Rec."Dimanche 5" := 0;
//                         Rec."Base Jour" := 0;
//                         Rec."Nombre De Jours Travaillé" := 0;
//                         Rec."31" := 0;
//                         RemizeaZeroOnAfterValidate;
//                     end;
//                 }
//             }
//             field("COUNT"; Rec.Count)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Nombre Salariés';
//                 Editable = false;
//                 Style = Unfavorable;
//                 StyleExpr = true;
//             }
//             label(Control1000000073)
//             {
//                 ApplicationArea = Basic;
//                 Caption = '-1 :CONGER ;          -2 : CONGER SPECIALE       ;                -3 : FERIER';
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord()
//     begin
//         OnAfterGetRecordFORMAT();
//         OnFormat;
//     end;

//     trigger OnOpenPage()
//     begin
//         Rec.CalcFields("Nombre Salarier");
//         NombreSalarié := Rec."Nombre Salarier";
//     end;

//     var
//         EtatMensuellePaie: Record "Etat Mensuelle Paie";
//         RecGEmp: Record Employee;
//         i: Integer;
//         d: Dialog;
//         dialogMess1: label 'Défalcation des Heures Supp.';
//         dialogMess2: label 'Mise à jours des lignes défalcation.';
//         //GL3900  MgmtSuppHour: Codeunit "Management of Work Hours";
//         ToTNbrjours: Decimal;
//         ToTNbrHeures: Decimal;
//         Text001: label 'Suppression Impossible, Journée Valider';
//         Text002: label 'Tâche chevée Avec Succée';
//         Text003: label 'Attention Vous Allez Supprimer Toutes Les Informations !!!! Continuer Quand Meme ??????????????????';
//         CodeQualification: Code[20];
//         CodeAffectation: Code[20];
//         "NombreSalarié": Integer;
//         Text004: label 'Vous Avez Depasser Le Nombre De Jours Autorisés';
//         HeureV: Time;
//         NbrJours: Integer;
//         DateDimanche: Date;
//         Cumul: Decimal;
//         d1: Date;
//         d2: Date;
//         d3: Date;
//         d4: Date;
//         d5: Date;
//         j: Integer;
//         Ladate: Date;
//         Ladate2: Date;
//         Ladate3: Date;
//         Ladate4: Date;
//         k: Integer;
//         CumD1: Decimal;
//         CumD2: Decimal;
//         CumD3: Decimal;
//         CumD4: Decimal;
//         CumD5: Decimal;
//         Cumul2: Decimal;
//         espace: Text[30];
//         GDate: Date;
//         NbrTotalHeure: Decimal;
//         [InDataSet]
//         "1Emphasize": Boolean;
//         [InDataSet]
//         "2Emphasize": Boolean;
//         [InDataSet]
//         "3Emphasize": Boolean;
//         [InDataSet]
//         "4Emphasize": Boolean;
//         [InDataSet]
//         "5Emphasize": Boolean;
//         [InDataSet]
//         "6Emphasize": Boolean;
//         [InDataSet]
//         "7Emphasize": Boolean;
//         [InDataSet]
//         "8Emphasize": Boolean;
//         [InDataSet]
//         "9Emphasize": Boolean;
//         [InDataSet]
//         "10Emphasize": Boolean;
//         [InDataSet]
//         "11Emphasize": Boolean;
//         [InDataSet]
//         "12Emphasize": Boolean;
//         [InDataSet]
//         "13Emphasize": Boolean;
//         [InDataSet]
//         "14Emphasize": Boolean;
//         [InDataSet]
//         "15Emphasize": Boolean;
//         [InDataSet]
//         "16Emphasize": Boolean;
//         [InDataSet]
//         "17Emphasize": Boolean;
//         [InDataSet]
//         "18Emphasize": Boolean;
//         [InDataSet]
//         "19Emphasize": Boolean;
//         [InDataSet]
//         "20Emphasize": Boolean;
//         [InDataSet]
//         "21Emphasize": Boolean;
//         [InDataSet]
//         "22Emphasize": Boolean;
//         [InDataSet]
//         "23Emphasize": Boolean;
//         [InDataSet]
//         "24Emphasize": Boolean;
//         [InDataSet]
//         "25Emphasize": Boolean;
//         [InDataSet]
//         "26Emphasize": Boolean;
//         [InDataSet]
//         "27Emphasize": Boolean;
//         [InDataSet]
//         "28Emphasize": Boolean;
//         [InDataSet]
//         "29Emphasize": Boolean;
//         [InDataSet]
//         "30Emphasize": Boolean;
//         [InDataSet]
//         "31Emphasize": Boolean;
//         Text19021340: label '-1 :CONGER ;          -2 : CONGER SPECIALE       ;                -3 : FERIER';


//     procedure CalculPresence()
//     begin
//         if RecGEmp.Get(Rec.Matricule) then;
//         Rec."Total Presence" := Presence;
//         if RecGEmp.Horaire then TotalHeure;
//         if RecGEmp."En Deplacement" then begin
//             if Rec.Présence <= 26 then
//                 Rec.Deplacement := Rec.Présence
//             else
//                 Rec.Deplacement := 26;
//         end;

//         ChercheDimanches;
//         Conge;
//         Ferie;
//         CongSpecial;
//     end;


//     procedure FinMois(ParaJournee: Integer) DateFin: Date
//     var
//         Text001: label 'Depassement Dans La Date Saisie, Mois Max Journée : %1';
//     begin
//         DateFin := CalcDate('FM', WorkDate);
//         if ParaJournee > Date2dmy(DateFin, 1) then;// ERROR(Text001,DATE2DMY(DateFin,1));
//     end;


//     procedure DimancheTravaille() EnMoins: Integer
//     var
//         DateDebut: Date;
//         TextL001: label 'Jour Dimanche Saisie Interdite';
//         DateFin: Date;
//         DimTravaille: Integer;
//         J: Integer;
//         K: Integer;
//         M: Integer;
//     begin
//         DimTravaille := 0;
//         EnMoins := 0;

//         DateDimanche := Dmy2date(1, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."1" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(2, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."2" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(3, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."3" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(4, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."4" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(5, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."5" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(6, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."6" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(7, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."7" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(8, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."8" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(9, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."9" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(10, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."10" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(11, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."11" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(12, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."12" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(13, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."13" = 1 then EnMoins += 1;


//         DateDimanche := Dmy2date(14, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."14" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(15, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."15" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(16, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."16" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(17, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."17" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(18, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."18" = 1 then EnMoins += 1;


//         DateDimanche := Dmy2date(19, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."19" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(20, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."20" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(21, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."21" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(22, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."22" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(23, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."23" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(24, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."24" = 1 then EnMoins += 1;

//         DateDimanche := Dmy2date(25, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(DateDimanche, 1) = 7 then if Rec."25" = 1 then EnMoins += 1;


//         if Rec."Mois Attachement" = 1 then
//             DateDebut := Dmy2date(26, 12, Rec."Annee Attachement" - 1)
//         else
//             DateDebut := Dmy2date(26, Rec."Mois Attachement" - 1, Rec."Annee Attachement");


//         DateFin := CalcDate('FM', DateDebut);
//         M := 25;
//         J := DateFin - DateDebut + 1;
//         for K := 1 to J do begin
//             M += 1;
//             if M = 26 then begin
//                 DateDimanche := Dmy2date(26, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
//                 if Date2dwy(DateDimanche, 1) = 7 then if Rec."26" = 1 then EnMoins += 1;

//             end;
//             if M = 27 then begin
//                 DateDimanche := Dmy2date(27, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
//                 if Date2dwy(DateDimanche, 1) = 7 then if Rec."27" = 1 then EnMoins += 1;

//             end;
//             if M = 28 then begin
//                 DateDimanche := Dmy2date(28, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
//                 if Date2dwy(DateDimanche, 1) = 7 then if Rec."28" = 1 then EnMoins += 1;

//             end;
//             if M = 29 then begin
//                 DateDimanche := Dmy2date(29, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
//                 if Date2dwy(DateDimanche, 1) = 7 then if Rec."29" = 1 then EnMoins += 1;

//             end;

//             if M = 30 then begin
//                 DateDimanche := Dmy2date(30, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
//                 if Date2dwy(DateDimanche, 1) = 7 then if Rec."30" = 1 then EnMoins += 1;

//             end;

//             if M = 31 then begin
//                 DateDimanche := Dmy2date(31, Date2dmy(DateDebut, 2), Date2dmy(DateDebut, 3));
//                 if Date2dwy(DateDimanche, 1) = 7 then if Rec."31" = 1 then EnMoins += 1;

//             end;




//         end;
//     end;


//     procedure ChercheDimanches()
//     begin
//         Ladate := Dmy2date(1, Rec."Mois Attachement", Rec."Annee Attachement");
//         Ladate2 := CalcDate('FM', Ladate);
//         i := 0;
//         j := 0;
//         k := 0;
//         Rec."Dimanche 1" := 0;
//         Rec."Dimanche 2" := 0;
//         Rec."Dimanche 3" := 0;
//         Rec."Dimanche 4" := 0;
//         Rec."Dimanche 5" := 0;
//         Rec."Dimanche 6" := 0;
//         Cumul2 := 0;
//         for j := 1 to Date2dmy(Ladate2, 1) do begin
//             Ladate3 := Dmy2date(j, Date2dmy(Ladate, 2), Date2dmy(Ladate, 3));
//             if Date2dwy(Ladate3, 1) = 7 then begin
//                 k += 1;
//                 if j = 1 then Cumul2 += Rec."1";
//                 if j = 2 then Cumul2 += Rec."2";
//                 if j = 3 then Cumul2 += Rec."3";
//                 if j = 4 then Cumul2 += Rec."4";
//                 if j = 5 then Cumul2 += Rec."5";
//                 if j = 6 then Cumul2 += Rec."6";
//                 if j = 7 then Cumul2 += Rec."7";
//                 if j = 8 then Cumul2 += Rec."8";
//                 if j = 9 then Cumul2 += Rec."9";
//                 if j = 10 then Cumul2 += Rec."10";
//                 if j = 11 then Cumul2 += Rec."11";
//                 if j = 12 then Cumul2 += Rec."12";
//                 if j = 13 then Cumul2 += Rec."13";
//                 if j = 14 then Cumul2 += Rec."14";
//                 if j = 15 then Cumul2 += Rec."15";
//                 if j = 16 then Cumul2 += Rec."16";
//                 if j = 17 then Cumul2 += Rec."17";
//                 if j = 18 then Cumul2 += Rec."18";
//                 if j = 19 then Cumul2 += Rec."19";
//                 if j = 20 then Cumul2 += Rec."20";
//                 if j = 21 then Cumul2 += Rec."21";
//                 if j = 22 then Cumul2 += Rec."22";
//                 if j = 23 then Cumul2 += Rec."23";
//                 if j = 24 then Cumul2 += Rec."24";
//                 if j = 25 then Cumul2 += Rec."25";
//                 if j = 26 then Cumul2 += Rec."26";
//                 if j = 25 then Cumul2 += Rec."25";
//                 if j = 27 then Cumul2 += Rec."27";
//                 if j = 29 then Cumul2 += Rec."29";
//                 if j = 30 then Cumul2 += Rec."30";
//                 if j = 31 then Cumul2 += Rec."31";
//                 if k = 1 then Rec."Dimanche 1" := Cumul2;
//                 if k = 2 then Rec."Dimanche 2" := Cumul2;
//                 if k = 3 then Rec."Dimanche 3" := Cumul2;
//                 if k = 4 then Rec."Dimanche 4" := Cumul2;
//                 if k = 5 then Rec."Dimanche 5" := Cumul2;

//                 Cumul2 := 0;


//             end
//             else begin
//                 if j = 1 then Cumul2 += Rec."1";
//                 if j = 2 then Cumul2 += Rec."2";
//                 if j = 3 then Cumul2 += Rec."3";
//                 if j = 4 then Cumul2 += Rec."4";
//                 if j = 5 then Cumul2 += Rec."5";
//                 if j = 6 then Cumul2 += Rec."6";
//                 if j = 7 then Cumul2 += Rec."7";
//                 if j = 8 then Cumul2 += Rec."8";
//                 if j = 9 then Cumul2 += Rec."9";
//                 if j = 10 then Cumul2 += Rec."10";
//                 if j = 11 then Cumul2 += Rec."11";
//                 if j = 12 then Cumul2 += Rec."12";
//                 if j = 13 then Cumul2 += Rec."13";
//                 if j = 14 then Cumul2 += Rec."14";
//                 if j = 15 then Cumul2 += Rec."15";
//                 if j = 16 then Cumul2 += Rec."16";
//                 if j = 17 then Cumul2 += Rec."17";
//                 if j = 18 then Cumul2 += Rec."18";
//                 if j = 19 then Cumul2 += Rec."19";
//                 if j = 20 then Cumul2 += Rec."20";
//                 if j = 21 then Cumul2 += Rec."21";
//                 if j = 22 then Cumul2 += Rec."22";
//                 if j = 23 then Cumul2 += Rec."23";
//                 if j = 24 then Cumul2 += Rec."24";
//                 if j = 25 then Cumul2 += Rec."25";
//                 if j = 26 then Cumul2 += Rec."26";
//                 if j = 25 then Cumul2 += Rec."25";
//                 if j = 27 then Cumul2 += Rec."27";
//                 if j = 29 then Cumul2 += Rec."29";
//                 if j = 30 then Cumul2 += Rec."30";
//                 if j = 31 then Cumul2 += Rec."31";

//                 if k = 5 then Rec."Dimanche 6" := Cumul2;
//             end;
//         end;

//         if (Rec."Dimanche 5" = 0) and (Rec."Dimanche 6" = 0) then Rec."Dimanche 5" := Cumul2;
//     end;


//     procedure EstDimanches(ParaJour: Integer) EstDim: Boolean
//     var
//         LFinMois: Date;
//     begin
//         if (ParaJour = 0) or (Rec."Mois Attachement" = 0) or (Rec."Annee Attachement" = 0) then exit;
//         EstDim := false;
//         LFinMois := CalcDate('FM', Dmy2date(1, Rec."Mois Attachement", Rec."Annee Attachement"));
//         if ParaJour > Date2dmy(LFinMois, 1) then exit;
//         Ladate := Dmy2date(ParaJour, Rec."Mois Attachement", Rec."Annee Attachement");
//         if Date2dwy(Ladate, 1) = 7 then exit(true);
//     end;


//     procedure Presence() JoursPres: Decimal
//     var
//         LTotJour: Decimal;
//     begin
//         JoursPres := 0;
//         if RecGEmp.Horaire then begin
//             if Rec."1" > 0 then JoursPres += 1;
//             if Rec."2" > 0 then JoursPres += 1;
//             if Rec."3" > 0 then JoursPres += 1;
//             if Rec."4" > 0 then JoursPres += 1;
//             if Rec."5" > 0 then JoursPres += 1;
//             if Rec."6" > 0 then JoursPres += 1;
//             if Rec."7" > 0 then JoursPres += 1;
//             if Rec."8" > 0 then JoursPres += 1;
//             if Rec."9" > 0 then JoursPres += 1;
//             if Rec."10" > 0 then JoursPres += 1;
//             if Rec."11" > 0 then JoursPres += 1;
//             if Rec."12" > 0 then JoursPres += 1;
//             if Rec."13" > 0 then JoursPres += 1;
//             if Rec."14" > 0 then JoursPres += 1;
//             if Rec."15" > 0 then JoursPres += 1;
//             if Rec."16" > 0 then JoursPres += 1;
//             if Rec."17" > 0 then JoursPres += 1;
//             if Rec."18" > 0 then JoursPres += 1;
//             if Rec."19" > 0 then JoursPres += 1;
//             if Rec."20" > 0 then JoursPres += 1;
//             if Rec."21" > 0 then JoursPres += 1;
//             if Rec."22" > 0 then JoursPres += 1;
//             if Rec."23" > 0 then JoursPres += 1;
//             if Rec."24" > 0 then JoursPres += 1;
//             if Rec."25" > 0 then JoursPres += 1;
//             if Rec."26" > 0 then JoursPres += 1;
//             if Rec."27" > 0 then JoursPres += 1;
//             if Rec."28" > 0 then JoursPres += 1;
//             if Rec."29" > 0 then JoursPres += 1;
//             if Rec."30" > 0 then JoursPres += 1;
//             if Rec."31" > 0 then JoursPres += 1;
//         end;
//         if not RecGEmp.Horaire then begin
//             if Rec."1" > 0 then LTotJour += Rec."1";
//             if Rec."2" > 0 then LTotJour += Rec."2";
//             if Rec."3" > 0 then LTotJour += Rec."3";
//             if Rec."4" > 0 then LTotJour += Rec."4";
//             if Rec."5" > 0 then LTotJour += Rec."5";
//             if Rec."6" > 0 then LTotJour += Rec."6";
//             if Rec."7" > 0 then LTotJour += Rec."7";
//             if Rec."8" > 0 then LTotJour += Rec."8";
//             if Rec."9" > 0 then LTotJour += Rec."9";
//             if Rec."10" > 0 then LTotJour += Rec."10";
//             if Rec."11" > 0 then LTotJour += Rec."11";
//             if Rec."12" > 0 then LTotJour += Rec."12";
//             if Rec."13" > 0 then LTotJour += Rec."13";
//             if Rec."14" > 0 then LTotJour += Rec."14";
//             if Rec."15" > 0 then LTotJour += Rec."15";
//             if Rec."16" > 0 then LTotJour += Rec."16";
//             if Rec."17" > 0 then LTotJour += Rec."17";
//             if Rec."18" > 0 then LTotJour += Rec."18";
//             if Rec."19" > 0 then LTotJour += Rec."19";
//             if Rec."20" > 0 then LTotJour += Rec."20";
//             if Rec."21" > 0 then LTotJour += Rec."21";
//             if Rec."22" > 0 then LTotJour += Rec."22";
//             if Rec."23" > 0 then LTotJour += Rec."23";
//             if Rec."24" > 0 then LTotJour += Rec."24";
//             if Rec."25" > 0 then LTotJour += Rec."25";
//             if Rec."26" > 0 then LTotJour += Rec."26";
//             if Rec."27" > 0 then LTotJour += Rec."27";
//             if Rec."28" > 0 then LTotJour += Rec."28";
//             if Rec."29" > 0 then LTotJour += Rec."29";
//             if Rec."30" > 0 then LTotJour += Rec."30";
//             if Rec."31" > 0 then LTotJour += Rec."31";
//             JoursPres := LTotJour;
//         end;

//         exit(JoursPres);
//     end;


//     procedure Conge() JoursPres: Integer
//     begin
//         JoursPres := 0;
//         if Rec."1" = -1 then JoursPres += 1;
//         if Rec."2" = -1 then JoursPres += 1;
//         if Rec."3" = -1 then JoursPres += 1;
//         if Rec."4" = -1 then JoursPres += 1;
//         if Rec."5" = -1 then JoursPres += 1;
//         if Rec."6" = -1 then JoursPres += 1;
//         if Rec."7" = -1 then JoursPres += 1;
//         if Rec."8" = -1 then JoursPres += 1;
//         if Rec."9" = -1 then JoursPres += 1;
//         if Rec."10" = -1 then JoursPres += 1;
//         if Rec."11" = -1 then JoursPres += 1;
//         if Rec."12" = -1 then JoursPres += 1;
//         if Rec."13" = -1 then JoursPres += 1;
//         if Rec."14" = -1 then JoursPres += 1;
//         if Rec."15" = -1 then JoursPres += 1;
//         if Rec."16" = -1 then JoursPres += 1;
//         if Rec."17" = -1 then JoursPres += 1;
//         if Rec."18" = -1 then JoursPres += 1;
//         if Rec."19" = -1 then JoursPres += 1;
//         if Rec."20" = -1 then JoursPres += 1;
//         if Rec."21" = -1 then JoursPres += 1;
//         if Rec."22" = -1 then JoursPres += 1;
//         if Rec."23" = -1 then JoursPres += 1;
//         if Rec."24" = -1 then JoursPres += 1;
//         if Rec."25" = -1 then JoursPres += 1;
//         if Rec."26" = -1 then JoursPres += 1;
//         if Rec."27" = -1 then JoursPres += 1;
//         if Rec."28" = -1 then JoursPres += 1;
//         if Rec."29" = -1 then JoursPres += 1;
//         if Rec."30" = -1 then JoursPres += 1;
//         if Rec."31" = -1 then JoursPres += 1;
//         Rec.Congé := JoursPres;
//     end;


//     procedure Ferie() JoursPres: Integer
//     begin
//         JoursPres := 0;

//         if Rec."1" = -3 then JoursPres += 1;
//         if Rec."2" = -3 then JoursPres += 1;
//         if Rec."3" = -3 then JoursPres += 1;
//         if Rec."4" = -3 then JoursPres += 1;
//         if Rec."5" = -3 then JoursPres += 1;
//         if Rec."6" = -3 then JoursPres += 1;
//         if Rec."7" = -3 then JoursPres += 1;
//         if Rec."8" = -3 then JoursPres += 1;
//         if Rec."9" = -3 then JoursPres += 1;
//         if Rec."10" = -3 then JoursPres += 1;
//         if Rec."11" = -3 then JoursPres += 1;
//         if Rec."12" = -3 then JoursPres += 1;
//         if Rec."13" = -3 then JoursPres += 1;
//         if Rec."14" = -3 then JoursPres += 1;
//         if Rec."15" = -3 then JoursPres += 1;
//         if Rec."16" = -3 then JoursPres += 1;
//         if Rec."17" = -3 then JoursPres += 1;
//         if Rec."18" = -3 then JoursPres += 1;
//         if Rec."19" = -3 then JoursPres += 1;
//         if Rec."20" = -3 then JoursPres += 1;
//         if Rec."21" = -3 then JoursPres += 1;
//         if Rec."22" = -3 then JoursPres += 1;
//         if Rec."23" = -3 then JoursPres += 1;
//         if Rec."24" = -3 then JoursPres += 1;
//         if Rec."25" = -3 then JoursPres += 1;
//         if Rec."26" = -3 then JoursPres += 1;
//         if Rec."27" = -3 then JoursPres += 1;
//         if Rec."28" = -3 then JoursPres += 1;
//         if Rec."29" = -3 then JoursPres += 1;
//         if Rec."30" = -3 then JoursPres += 1;
//         if Rec."31" = -3 then JoursPres += 1;
//         Rec.Férier := JoursPres;
//     end;


//     procedure CongSpecial() JoursPres: Integer
//     begin
//         JoursPres := 0;

//         if Rec."1" = -2 then JoursPres += 1;
//         if Rec."2" = -2 then JoursPres += 1;
//         if Rec."3" = -2 then JoursPres += 1;
//         if Rec."4" = -2 then JoursPres += 1;
//         if Rec."5" = -2 then JoursPres += 1;
//         if Rec."6" = -2 then JoursPres += 1;
//         if Rec."7" = -2 then JoursPres += 1;
//         if Rec."8" = -2 then JoursPres += 1;
//         if Rec."9" = -2 then JoursPres += 1;
//         if Rec."10" = -2 then JoursPres += 1;
//         if Rec."11" = -2 then JoursPres += 1;
//         if Rec."12" = -2 then JoursPres += 1;
//         if Rec."13" = -2 then JoursPres += 1;
//         if Rec."14" = -2 then JoursPres += 1;
//         if Rec."15" = -2 then JoursPres += 1;
//         if Rec."16" = -2 then JoursPres += 1;
//         if Rec."17" = -2 then JoursPres += 1;
//         if Rec."18" = -2 then JoursPres += 1;
//         if Rec."19" = -2 then JoursPres += 1;
//         if Rec."20" = -2 then JoursPres += 1;
//         if Rec."21" = -2 then JoursPres += 1;
//         if Rec."22" = -2 then JoursPres += 1;
//         if Rec."23" = -2 then JoursPres += 1;
//         if Rec."24" = -2 then JoursPres += 1;
//         if Rec."25" = -2 then JoursPres += 1;
//         if Rec."26" = -2 then JoursPres += 1;
//         if Rec."27" = -2 then JoursPres += 1;
//         if Rec."28" = -2 then JoursPres += 1;
//         if Rec."29" = -2 then JoursPres += 1;
//         if Rec."30" = -2 then JoursPres += 1;
//         if Rec."31" = -2 then JoursPres += 1;

//         Rec."Conger Speciale" := JoursPres;
//     end;


//     procedure TotalHeure() TotH: Decimal
//     var
//         LTotHeure: Decimal;
//     begin
//         LTotHeure := 0;
//         if Rec."1" > 0 then LTotHeure += Rec."1";
//         if Rec."2" > 0 then LTotHeure += Rec."2";
//         if Rec."3" > 0 then LTotHeure += Rec."3";
//         if Rec."4" > 0 then LTotHeure += Rec."4";
//         if Rec."5" > 0 then LTotHeure += Rec."5";
//         if Rec."6" > 0 then LTotHeure += Rec."6";
//         if Rec."7" > 0 then LTotHeure += Rec."7";
//         if Rec."8" > 0 then LTotHeure += Rec."8";
//         if Rec."9" > 0 then LTotHeure += Rec."9";
//         if Rec."10" > 0 then LTotHeure += Rec."10";
//         if Rec."11" > 0 then LTotHeure += Rec."11";
//         if Rec."12" > 0 then LTotHeure += Rec."12";
//         if Rec."13" > 0 then LTotHeure += Rec."13";
//         if Rec."14" > 0 then LTotHeure += Rec."14";
//         if Rec."15" > 0 then LTotHeure += Rec."15";
//         if Rec."16" > 0 then LTotHeure += Rec."16";
//         if Rec."17" > 0 then LTotHeure += Rec."17";
//         if Rec."18" > 0 then LTotHeure += Rec."18";
//         if Rec."19" > 0 then LTotHeure += Rec."19";
//         if Rec."20" > 0 then LTotHeure += Rec."20";
//         if Rec."21" > 0 then LTotHeure += Rec."21";
//         if Rec."22" > 0 then LTotHeure += Rec."22";
//         if Rec."23" > 0 then LTotHeure += Rec."23";
//         if Rec."24" > 0 then LTotHeure += Rec."24";
//         if Rec."25" > 0 then LTotHeure += Rec."25";
//         if Rec."26" > 0 then LTotHeure += Rec."26";
//         if Rec."27" > 0 then LTotHeure += Rec."27";
//         if Rec."28" > 0 then LTotHeure += Rec."28";
//         if Rec."29" > 0 then LTotHeure += Rec."29";
//         if Rec."30" > 0 then LTotHeure += Rec."30";
//         if Rec."31" > 0 then LTotHeure += Rec."31";

//         Rec."Total Heures" := LTotHeure;
//     end;

//     local procedure MatriculeOnAfterValidate()
//     begin
//         if RecGEmp.Get(Rec.Matricule) then
//             Rec.Bage := RecGEmp."N° Badge";
//     end;

//     local procedure RemizeaZeroOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;

//     local procedure MatriculeOnAfterInput(var Text: Text[1024])
//     begin
//         if RecGEmp.Get(Rec.Matricule) then
//             Rec.Bage := RecGEmp."N° Badge";
//     end;

//     local procedure MatriculeOnFormat()
//     begin
//         //GL2024
//         /*IF RecGEmp.GET(Matricule) THEN;
//         IF RecGEmp.Horaire THEN BEGIN END
//         ELSE CurrPage.Matricule.UPDATEFORECOLOR(16711680)    */

//     end;

//     local procedure OnFormat()
//     begin
//         if Rec."Mois Attachement" = 0 then exit;
//         if Rec."Mois Attachement" = 1 then
//             GDate := Dmy2date(1, 12, Rec."Annee Attachement" - 1)
//         else
//             GDate := Dmy2date(1, Rec."Mois Attachement" - 1, Rec."Annee Attachement");
//         GDate := CalcDate('FM', GDate);
//         if Date2dmy(GDate, 1) = 31 then begin

//             if EstDimanches(31) then begin
//                 "31Emphasize" := true;
//                 //GL2024
//                 // CurrPage."31".UPDATEFORECOLOR(255)
//             end;
//         end;
//     end;

//     local procedure OnAfterGetRecordFORMAT()
//     begin
//         MatriculeOnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//         OnFormat;
//     end;
// }

