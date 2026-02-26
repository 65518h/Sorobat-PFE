report 50174 "Situation Individuelle  Congés"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/SituationIndividuelleCongés.rdlc';
    // Caption = 'Situation Individuelle  Congés';
    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;
    // //date 09 07 2025

    // dataset
    // {
    //     dataitem(Employee; 5200)
    //     {
    //         DataItemTableView = WHERE("Blocked" = CONST(false));
    //         RequestFilterFields = "No.";
    //         column(Employee__No__; "No.")
    //         {
    //         }
    //         column(Employee__First_Name_; "First Name")
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column("Soldereporté"; Soldereporté)
    //         {
    //         }
    //         column("Situation_Individuelle_des_congésCaption"; Situation_Individuelle_des_congésCaptionLbl)
    //         {
    //         }
    //         column("Solde_Reporté__Caption"; Solde_Reporté__CaptionLbl)
    //         {
    //         }
    //         dataitem("Employee's days off Entry"; 52048895)
    //         {
    //             DataItemLink = "Employee No." = FIELD("No.");
    //             DataItemTableView = SORTING("Employee No.", "Posting year", "Posting month")
    //                                 WHERE("Cause of Absence Code" = FILTER(<> 'ABS'));
    //             column(Congep; Congep)
    //             {
    //             }
    //             column(Reliquat; Reliquat)
    //             {
    //             }
    //             column(FORMAT__Posting_month__________FORMAT__Posting_year__; FORMAT("Posting month") + ' /  ' + FORMAT("Posting year"))
    //             {
    //             }
    //             column(solde; solde)
    //             {
    //             }
    //             column(NbreJoursTravail; NbreJoursTravail)
    //             {
    //             }
    //             column(congeconsomme; congeconsomme)
    //             {
    //             }
    //             column(droitcongee; droitcongee)
    //             {
    //             }
    //             column(JourFiche; JourFiche)
    //             {
    //             }
    //             column("JoursFeriée"; JoursFeriée)
    //             {
    //             }
    //             column(MoisCaption; MoisCaptionLbl)
    //             {
    //             }
    //             column(SoldeCaption; SoldeCaptionLbl)
    //             {
    //             }
    //             column("Congè_PayéCaption"; Congè_PayéCaptionLbl)
    //             {
    //             }
    //             column(ReliquatCaption; ReliquatCaptionLbl)
    //             {
    //             }
    //             column(Jours_TravailCaption; Jours_TravailCaptionLbl)
    //             {
    //             }
    //             column("Nbre_J_CongéCaption"; Nbre_J_CongéCaptionLbl)
    //             {
    //             }
    //             column(Droit_CongCaption; Droit_CongCaptionLbl)
    //             {
    //             }
    //             column(Jours_Trav_Base_CalculCaption; Jours_Trav_Base_CalculCaptionLbl)
    //             {
    //             }
    //             column("Nbre_J_FériéCaption"; Nbre_J_FériéCaptionLbl)
    //             {
    //             }
    //             column(Employee_s_days_off_Entry_Entry_No_; "Entry No.")
    //             {
    //             }
    //             column(Employee_s_days_off_Entry_Employee_No_; "Employee No.")
    //             {
    //             }
    //             column(Employee_s_days_off_Entry_Posting_year; "Posting year")
    //             {
    //             }
    //             column(Employee_s_days_off_Entry_Posting_month; "Posting month")
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             var
    //                 MoisPrecedent: Integer;
    //                 PreviousOlde: Decimal;
    //                 YesOrNo: Boolean;
    //                 LastYear: Integer;
    //                 LastMonth: Integer;
    //             begin

    //                 NbreJoursTravail := 0;
    //                 congeconsomme := 0;
    //                 droitcongee := 0;
    //                 Reliquat := 0;
    //                 Congep := 0;
    //                 JoursFeriée := 0;
    //                 JourFiche := 0;


    //                 IF "Employee's days off Entry"."Posting year" = "Employee's days off Entry"."Posting year" THEN Reliquat := "Employee's days off Entry"."Quantity (Days)";

    //                 ///
    //                 if "Employee's days off Entry"."Posting year" <> "Postingyear2" then begin

    //                     Reliquat2 := 0;
    //                     "Postingyear2" := "Employee's days off Entry"."Posting year";
    //                 end;

    //                 if "Employee's days off Entry"."Posting month" <> "Posting month2" then begin
    //                     Reliquat2 := 0;
    //                     "Posting month2" := "Employee's days off Entry"."Posting month";
    //                 end;

    //                 // IF "Employee's days off Entry"."Posting year" = "Employee's days off Entry"."Posting year" THEN Reliquat2 := Reliquat2 + "Employee's days off Entry"."Quantity (Days)";
    //                 //


    //                 RecEmployeesdaysoffEntry3.RESET;
    //                 RecEmployeesdaysoffEntry3.SETRANGE(RecEmployeesdaysoffEntry3."Employee No.", "Employee's days off Entry"."Employee No.");
    //                 RecEmployeesdaysoffEntry3.SETRANGE(RecEmployeesdaysoffEntry3."Posting year", "Posting year");
    //                 RecEmployeesdaysoffEntry3.SETRANGE(RecEmployeesdaysoffEntry3."Posting month", "Employee's days off Entry"."Posting month");
    //                 IF RecEmployeesdaysoffEntry3.FINDFIRST THEN
    //                     if (("Employee's days off Entry"."Posting year" = Annee) and
    //                                     ("Employee's days off Entry"."Posting month" = monthA::January)) then begin
    //                         REPEAT
    //                             Reliquat2 := Reliquat2 + RecEmployeesdaysoffEntry3."Quantity (Days)";
    //                             employeeA := RecEmployeesdaysoffEntry3."Employee No.";
    //                             yearA := RecEmployeesdaysoffEntry3."Posting year";
    //                             monthA := RecEmployeesdaysoffEntry3."Posting month";
    //                         UNTIL RecEmployeesdaysoffEntry3.NEXT = 0;
    //                         solde := solde + Reliquat2;
    //                     end else
    //                         IF ("Employee's days off Entry"."Employee No." <> employeeA) or

    //                              ("Employee's days off Entry"."Posting year" <> yearA) or

    //                                 ("Employee's days off Entry"."Posting month" <> monthA) then begin
    //                             REPEAT
    //                                 Reliquat2 := Reliquat2 + RecEmployeesdaysoffEntry3."Quantity (Days)";
    //                                 employeeA := RecEmployeesdaysoffEntry3."Employee No.";
    //                                 yearA := RecEmployeesdaysoffEntry3."Posting year";
    //                                 monthA := RecEmployeesdaysoffEntry3."Posting month";
    //                             UNTIL RecEmployeesdaysoffEntry3.NEXT = 0;
    //                             solde := solde + Reliquat2;
    //                         end;


    //                 /*    if "Employee's days off Entry"."Posting month" = "Employee's days off Entry"."Posting month" THEN
    //                         solde := solde + Reliquat2;*/

    //                 RecSalaryLines.RESET;
    //                 RecSalaryLines.SETRANGE(RecSalaryLines.Employee, "Employee's days off Entry"."Employee No.");
    //                 RecSalaryLines.SETRANGE(RecSalaryLines.Year, "Posting year");
    //                 RecSalaryLines.SETRANGE(RecSalaryLines.Month, "Employee's days off Entry"."Posting month");
    //                 IF RecSalaryLines.FINDFIRST THEN NbreJoursTravail := RecSalaryLines."Paied days";

    //                 // Congé Consommé
    //                 RecEmployeesdaysoffEntry.RESET;
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Employee No.", "Employee's days off Entry"."Employee No.");
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Posting year", "Posting year");
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Posting month", "Employee's days off Entry"."Posting month");
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Line type", 2);
    //                 RecEmployeesdaysoffEntry.SETFILTER(RecEmployeesdaysoffEntry."Cause of Absence Code", 'CONG|COR -');

    //                 IF RecEmployeesdaysoffEntry.FINDFIRST THEN
    //                     REPEAT
    //                         congeconsomme := congeconsomme + RecEmployeesdaysoffEntry.Quantity;
    //                     UNTIL RecEmployeesdaysoffEntry.NEXT = 0;


    //                 // Jours STC SOLDER
    //                 RecEmployeesdaysoffEntry.RESET;
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Employee No.", "Employee's days off Entry"."Employee No.");
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Posting year", "Posting year");
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Posting month", "Employee's days off Entry"."Posting month");
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Line type", 2);
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Cause of Absence Code", 'STC');

    //                 IF RecEmployeesdaysoffEntry.FINDFIRST THEN
    //                     REPEAT
    //                         StcSoldé += RecEmployeesdaysoffEntry.Quantity;
    //                     UNTIL RecEmployeesdaysoffEntry.NEXT = 0;


    //                 RecEmployeesdaysoffEntry2.RESET;
    //                 RecEmployeesdaysoffEntry2.SETRANGE(RecEmployeesdaysoffEntry2."Employee No.", "Employee's days off Entry"."Employee No.");
    //                 RecEmployeesdaysoffEntry2.SETRANGE(RecEmployeesdaysoffEntry2."Posting year", "Posting year");
    //                 RecEmployeesdaysoffEntry2.SETRANGE(RecEmployeesdaysoffEntry2."Posting month", "Employee's days off Entry"."Posting month");
    //                 RecEmployeesdaysoffEntry2.SETRANGE(RecEmployeesdaysoffEntry2."Line type", 1);
    //                 IF RecEmployeesdaysoffEntry2.FINDFIRST THEN droitcongee := RecEmployeesdaysoffEntry2.Quantity;


    //                 RecEmployeesdaysoffEntry.RESET;
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Employee No.", "Employee's days off Entry"."Employee No.");
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Posting year", "Posting year");
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Posting month", "Employee's days off Entry"."Posting month");
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Line type", 2);
    //                 RecEmployeesdaysoffEntry.SETRANGE(RecEmployeesdaysoffEntry."Cause of Absence Code", 'CONGP');
    //                 IF RecEmployeesdaysoffEntry.FINDFIRST THEN
    //                     REPEAT
    //                         Congep := Congep + RecEmployeesdaysoffEntry.Quantity;
    //                     UNTIL RecEmployeesdaysoffEntry.NEXT = 0;

    //                 Heuressuperegistréesm.RESET;
    //                 Heuressuperegistréesm.SETRANGE(Heuressuperegistréesm."N° Salarié", "Employee's days off Entry"."Employee No.");
    //                 Heuressuperegistréesm.SETRANGE(Heuressuperegistréesm."Année de paiement", "Posting year");
    //                 Heuressuperegistréesm.SETRANGE(Heuressuperegistréesm."Mois de paiement", "Employee's days off Entry"."Posting month");
    //                 Heuressuperegistréesm.SETRANGE(Heuressuperegistréesm."Type Jours", 12);
    //                 IF Heuressuperegistréesm.FINDFIRST THEN JoursFeriée := Heuressuperegistréesm."Nombre Heures Supp";

    //                 IF (NbreJoursTravail + JoursFeriée + congeconsomme) <= 26 THEN
    //                     JourFiche := NbreJoursTravail + JoursFeriée + congeconsomme
    //                 ELSE IF (NbreJoursTravail + JoursFeriée + congeconsomme) > 26 THEN JourFiche := 26;

    //                 IF CurrReport.TOTALSCAUSEDBY = "Employee's days off Entry".FIELDNO("Posting month") THEN JourFicheTotal := JourFicheTotal + JourFiche;
    //             end;

    //             trigger OnPreDataItem()
    //             begin
    //                 "Postingyear2" := 0;
    //                 LastFieldNo := FIELDNO("Posting month");
    //                 "Employee's days off Entry".SETFILTER("Posting year", '>=%1', Annee);
    //             end;
    //         }
    //         trigger OnAfterGetRecord()
    //         var
    //         begin

    //             solde := 0;
    //             JourFicheTotal := 0;
    //             Soldereporté := 0;
    //             "Employee's days off Entry".RESET;
    //             "Employee's days off Entry".SETRANGE("Employee's days off Entry"."Employee No.", Employee."No.");
    //             "Employee's days off Entry".SETRANGE("Employee's days off Entry"."Posting year", Annee - 1);
    //             IF "Employee's days off Entry".FINDFIRST() THEN
    //                 REPEAT
    //                     Soldereporté := Soldereporté + "Employee's days off Entry"."Quantity (Days)";
    //                 UNTIL "Employee's days off Entry".NEXT = 0;
    //             solde := Soldereporté;
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(Options)
    //             {
    //                 Caption = 'Options';

    //                 field(Annee; Annee)
    //                 {
    //                     ApplicationArea = all;
    //                     Caption = 'Année Depart';
    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // trigger OnInitReport()
    // begin
    //     Annee := DATE2DMY(WORKDATE, 3) - 1;
    // end;

    // trigger OnPreReport()
    // begin
    //     IF Annee = 0 THEN ERROR(Text01);
    // end;

    // var
    //     PageConst: Label 'Page';
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     solde: Decimal;
    //     "Soldereporté": Decimal;
    //     Reliquat: Decimal;
    //     Reliquat2: Decimal;
    //     Reliquat3: Decimal;
    //     RecSalaryLines: Record 52048901;
    //     NbreJoursTravail: Decimal;
    //     EmployeesdaysoffEntry: Record 52048895;
    //     Congep: Decimal;
    //     congeconsomme: Decimal;
    //     congeconsommepaye: Decimal;
    //     droitcongee: Decimal;
    //     RecEmployeesdaysoffEntry: Record 52048895;
    //     RecEmployeesdaysoffEntry2: Record 52048895;
    //     RecEmployeesdaysoffEntry3: Record 52048895;
    //     "Heuressuperegistréesm": Record 52048892;
    //     "JoursFeriée": Decimal;
    //     JourFiche: Decimal;
    //     Annee: Integer;
    //     Text01: Label 'Preciser Anneé';
    //     JourFicheTotal: Decimal;
    //     "StcSoldé": Decimal;
    //     "Situation_Individuelle_des_congésCaptionLbl": Label 'Situation Individuelle des congés';
    //     "Solde_Reporté__CaptionLbl": Label 'Solde Reporté :';
    //     MoisCaptionLbl: Label 'Mois';
    //     SoldeCaptionLbl: Label 'Solde';
    //     "Congè_PayéCaptionLbl": Label 'Congè Payé';
    //     ReliquatCaptionLbl: Label 'Reliquat';
    //     Jours_TravailCaptionLbl: Label 'Jours Travail';
    //     "Nbre_J_CongéCaptionLbl": Label 'Nbre J.Congé';
    //     Droit_CongCaptionLbl: Label 'Droit Cong';
    //     Jours_Trav_Base_CalculCaptionLbl: Label 'Jours Trav Base Calcul';
    //     "Nbre_J_FériéCaptionLbl": Label 'Nbre J.Férié';
    //     "Postingyear2": Integer;
    //     "Posting month2": Option January," February"," March"," April"," May"," June"," July"," August"," September"," October"," November"," December";
    //     employeeA: CODE[20];
    //     yearA: Integer;
    //     monthA: Option January," February"," March"," April"," May"," June"," July"," August"," September"," October"," November"," December";
}

