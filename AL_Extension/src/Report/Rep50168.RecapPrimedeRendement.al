report 50168 "Recap Prime de Rendement"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/RecapPrimedeRendement.rdlc';

    // dataset
    // {
    //     dataitem("Rec. Salary Lines"; 52048901)
    //     {
    //         DataItemTableView = SORTING(Affectation, Month, Year, Employee)
    //                             ORDER(Ascending);
    //         RequestFilterFields = Year;
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Year; Year)
    //         {
    //         }
    //         column(Nbresalarie; Nbresalarie)
    //         {
    //         }
    //         column(DesignAffectation; DesignAffectation)
    //         {
    //         }
    //         column(NbreTotal; NbreTotal)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Service_PersonnelsCaption; Service_PersonnelsCaptionLbl)
    //         {
    //         }
    //         column(RECAP_PRIME_DE_RENDEMENTCaption; RECAP_PRIME_DE_RENDEMENTCaptionLbl)
    //         {
    //         }
    //         column("Année__Caption"; Année__CaptionLbl)
    //         {
    //         }
    //         column(A_l_attention_de_Mr_Caption; A_l_attention_de_Mr_CaptionLbl)
    //         {
    //         }
    //         column(AffectationCaption; AffectationCaptionLbl)
    //         {
    //         }
    //         column("Nbre_SalariésCaption"; Nbre_SalariésCaptionLbl)
    //         {
    //         }
    //         column(Nbre_Total__Caption; Nbre_Total__CaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_No_; "No.")
    //         {
    //         }
    //         column(Rec__Salary_Lines_Employee; Employee)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Affectation; Affectation)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         var
    //         begin

    //             RecAffectation.RESET();
    //             RecAffectation.SETRANGE(RecAffectation.Section, "Rec. Salary Lines".Affectation);
    //             IF RecAffectation.FINDFIRST THEN;
    //             DesignAffectation := RecAffectation.Decription;

    //             Nbresalarie := 0;


    //             NotePrecedent := 0;
    //             Ancienneté := '';
    //             NbreFiche := 0;
    //             RecAffectation.RESET();
    //             RecAffectation.SETRANGE(RecAffectation.Section, "Rec. Salary Lines".Affectation);
    //             IF RecAffectation.FINDFIRST THEN;
    //             DesignAffectation := RecAffectation.Decription;

    //             Salarie.RESET();
    //             Salarie.SETRANGE(Salarie."No.", "Rec. Salary Lines".Employee);
    //             IF Salarie.FINDFIRST THEN BEGIN
    //                 daterecrutelment := Salarie."Employment Date";
    //                 //*******************Nbre Fiche
    //                 RecSalaryLines.RESET();
    //                 RecSalaryLines.SETRANGE(RecSalaryLines.Employee, "Rec. Salary Lines".Employee);
    //                 RecSalaryLines.SETRANGE(RecSalaryLines.Year, "Rec. Salary Lines".Year);
    //                 IF RecSalaryLines.FINDFIRST() THEN
    //                     REPEAT
    //                         NbreFiche := NbreFiche + 1;

    //                     UNTIL RecSalaryLines.NEXT = 0;

    //                 IF NbreFiche < 12 THEN CurrReport.SHOWOUTPUT(FALSE);
    //                 IF Salarie.Blocked = TRUE THEN CurrReport.SHOWOUTPUT(FALSE);
    //                 IF (Salarie.Blocked = FALSE) AND (NbreFiche >= 12) THEN Nbresalarie := Nbresalarie + 1;
    //                 IF (Salarie.Blocked = FALSE) AND (NbreFiche >= 12) THEN NbreTotal := NbreTotal + 1;



    //                 //************Anciente**************

    //                 IF FORMAT(Salarie."Employment Date") <> '' THEN BEGIN
    //                     //DateRefAnciennete:=DMY2DATE(25,"Rec. Salary Lines".Month+1,"Rec. Salary Lines".Year)+1;
    //                     DateRefAnciennete := DMY2DATE(31, 12, "Rec. Salary Lines".Year);
    //                     IntMoisAncienneté := Managementofsalary.CalculerMoisAncienneté("No.", DateRefAnciennete);
    //                     NewDate := CALCDATE(FORMAT(((IntMoisAncienneté - IntAnnéeAncienneté * 12) - 1)) + 'M', Salarie."Employment Date");
    //                     NbrJour := DateRefAnciennete - Salarie."Employment Date";
    //                     IntAnnéeAncienneté := NbrJour DIV 365;
    //                     IntMoisAncienneté := (NbrJour - IntAnnéeAncienneté * 365) DIV 30;
    //                     IntAncienneteJour := NbrJour - IntAnnéeAncienneté * 365 - IntMoisAncienneté * 30;
    //                     IF IntAncienneteJour < 0 THEN IntAncienneteJour := 0;
    //                     IF IntAncienneteJour < 0 THEN IntAncienneteJour := 0;
    //                     Ancienneté := FORMAT(IntAnnéeAncienneté) + ' An(s), ' + FORMAT(IntMoisAncienneté) + ' Mois'
    //                     //+ FORMAT(IntAncienneteJour)+ ' Jours' ;
    //                 END;
    //                 //*********************************
    //                 RecQualificat.RESET();
    //                 RecQualificat.SETRANGE(RecQualificat.Code, Salarie.Qualification);
    //                 IF RecQualificat.FINDFIRST() THEN Designqualification := RecQualificat.Description;
    //             END;

    //             Notes.RESET;
    //             Notes.SETRANGE(Notes.Matricule, "Rec. Salary Lines".Employee);
    //             Notes.SETRANGE(Notes.Année, Notes.Année, "Rec. Salary Lines".Year - 1);
    //             IF Notes.FINDFIRST THEN NotePrecedent := Notes.Note;


    //             IF Nbresalarie = 0 THEN CurrReport.SHOWOUTPUT(FALSE);

    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO(Affectation);
    //             "Rec. Salary Lines".SETRANGE("Rec. Salary Lines".Month, 11);
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         // area(Content)
    //         // {
    //         //     field(Debut )
    //         // }
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // var
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     Anneeprime: Integer;
    //     Affect: Text[30];
    //     RecAffectation: Record 52048917;
    //     DesignAffectation: Text[30];
    //     RecQualificat: Record 5202;
    //     Designqualification: Text[30];
    //     daterecrutelment: Date;
    //     Salarie: Record 5200;
    //     Datedif: Integer;
    //     Notes: Record 52048938;
    //     NotePrecedent: Decimal;
    //     Managementofsalary: Codeunit 39001402;
    //     "IntMoisAncienneté": Integer;
    //     "IntAnnéeAncienneté": Integer;
    //     "Ancienneté": Text[50];
    //     IntAncienneteJour: Integer;
    //     DateRefAnciennete: Date;
    //     NewDate: Date;
    //     NbrJour: Integer;
    //     Nbresalarie: Integer;
    //     NbreTotal: Integer;
    //     RecSalaryLines: Record 52048901;
    //     NbreFiche: Integer;
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     Service_PersonnelsCaptionLbl: Label 'Service Personnels';
    //     RECAP_PRIME_DE_RENDEMENTCaptionLbl: Label 'RECAP PRIME DE RENDEMENT';
    //     "Année__CaptionLbl": Label 'Année :';
    //     A_l_attention_de_Mr_CaptionLbl: Label 'A l''attention de Mr.';
    //     AffectationCaptionLbl: Label 'Affectation';
    //     "Nbre_SalariésCaptionLbl": Label 'Nbre Salariés';
    //     Nbre_Total__CaptionLbl: Label 'Nbre Total :';
}

