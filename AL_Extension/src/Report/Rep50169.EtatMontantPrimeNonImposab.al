report 50169 "Etat Montant Prime Non Imposab"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/EtatMontantPrimeNonImposab.rdlc';

    // dataset
    // {
    //     dataitem(Notes; 52048938)
    //     {
    //         DataItemTableView = SORTING(Année, Matricule)
    //                             WHERE(Imposable = CONST(false),
    //                                   Note = FILTER(> 0));
    //         RequestFilterFields = Affectation;
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column("Notes_Année"; Année)
    //         {
    //         }
    //         column(Notes_Matricule; Matricule)
    //         {
    //         }
    //         column("Notes__Nom_Salariée_"; "Nom Salariée")
    //         {
    //         }
    //         column(Notes__Description_Affectation_; "Description Affectation")
    //         {
    //         }
    //         column(Notes__Description_Qualification_; "Description Qualification")
    //         {
    //         }
    //         column(Notes_Note; Note)
    //         {
    //         }
    //         column(MantantPrime; MantantPrime)
    //         {
    //         }
    //         column("Notes_Année_Control1000000009"; Année)
    //         {
    //         }
    //         column("IntAnnéeAncienneté"; IntAnnéeAncienneté)
    //         {
    //         }
    //         column("ZoneSalarié"; ZoneSalarié)
    //         {
    //         }
    //         column(Notes_Notes__Base_Calcul_; Notes."Base Calcul")
    //         {
    //         }
    //         column(totalmantant; totalmantant)
    //         {
    //         }
    //         column("NbreSalarié"; NbreSalarié)
    //         {
    //         }
    //         column(Etat_Mantant_Prime_Non_ImposableCaption; Etat_Mantant_Prime_Non_ImposableCaptionLbl)
    //         {
    //         }
    //         column("Année__Caption"; Année__CaptionLbl)
    //         {
    //         }
    //         column("Notes_Année_Control1000000009Caption"; FIELDCAPTION(Année))
    //         {
    //         }
    //         column(Notes_MatriculeCaption; FIELDCAPTION(Matricule))
    //         {
    //         }
    //         column("Notes__Nom_Salariée_Caption"; FIELDCAPTION("Nom Salariée"))
    //         {
    //         }
    //         column(Notes__Description_Affectation_Caption; FIELDCAPTION("Description Affectation"))
    //         {
    //         }
    //         column(Notes__Description_Qualification_Caption; FIELDCAPTION("Description Qualification"))
    //         {
    //         }
    //         column(Notes_NoteCaption; FIELDCAPTION(Note))
    //         {
    //         }
    //         column(Montant_PrimeCaption; Montant_PrimeCaptionLbl)
    //         {
    //         }
    //         column("AncientéCaption"; AncientéCaptionLbl)
    //         {
    //         }
    //         column(ZoneCaption; ZoneCaptionLbl)
    //         {
    //         }
    //         column(Base_CalculCaption; Base_CalculCaptionLbl)
    //         {
    //         }
    //         column(Total_Mantant_Prime__Caption; Total_Mantant_Prime__CaptionLbl)
    //         {
    //         }
    //         column(Nbre__Caption; Nbre__CaptionLbl)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         var
    //         begin

    //             IntAnnéeAncienneté := 0;
    //             MantantPrime := 0;
    //             NbreFiche := 0;

    //             Salarie.RESET();
    //             Salarie.SETRANGE(Salarie."No.", Notes.Matricule);
    //             IF Salarie.FINDFIRST THEN BEGIN
    //                 ZoneSalarié := Salarie.Zone;
    //                 IF FORMAT(Salarie."Employment Date") <> '' THEN BEGIN
    //                     RecSalaryLines.RESET;
    //                     RecSalaryLines.SETRANGE(RecSalaryLines.Month, 11);
    //                     RecSalaryLines.SETRANGE(RecSalaryLines.Employee, Notes.Matricule);
    //                     RecSalaryLines.SETRANGE(RecSalaryLines.Year, Année);
    //                     IF RecSalaryLines.FINDFIRST THEN DateRefAnciennete := DMY2DATE(31, 12, RecSalaryLines.Year);
    //                     IntMoisAncienneté := Managementofsalary.CalculerMoisAncienneté(RecSalaryLines."No.", DateRefAnciennete);
    //                     NewDate := CALCDATE(FORMAT(((IntMoisAncienneté - IntAnnéeAncienneté * 12) - 1)) + 'M', Salarie."Employment Date");
    //                     NbrJour := DateRefAnciennete - Salarie."Employment Date";
    //                     IntAnnéeAncienneté := NbrJour DIV 365;
    //                     IF Salarie.Zone = 'A' THEN BEGIN
    //                         MantantPrime := ((RecSalaryLines."Net salary" * Notes.Note) / 20) + (5 * IntAnnéeAncienneté);
    //                         Notes."Montant Prime" := MantantPrime;
    //                         Notes."Montant Ancienneté" := 5 * IntAnnéeAncienneté;
    //                         Notes."Base Calcul" := RecSalaryLines."Net salary";
    //                         Notes.Ancienté := IntAnnéeAncienneté;
    //                         RecSalaryLines.RESET();
    //                         RecSalaryLines.SETRANGE(RecSalaryLines.Employee, Notes.Matricule);
    //                         RecSalaryLines.SETRANGE(RecSalaryLines.Year, Notes.Année);
    //                         IF RecSalaryLines.FINDFIRST() THEN
    //                             REPEAT
    //                                 NbreFiche := NbreFiche + 1;

    //                             UNTIL RecSalaryLines.NEXT = 0;
    //                         Notes."Nbre Fiche" := NbreFiche;
    //                         Notes.MODIFY;
    //                     END
    //                     ELSE IF Salarie.Zone = 'C' THEN BEGIN
    //                         MantantPrime := ((RecSalaryLines."Basis salary" * Notes.Note) / 20);
    //                         Notes."Montant Prime" := MantantPrime;
    //                         Notes."Base Calcul" := RecSalaryLines."Basis salary";
    //                         Notes.Ancienté := IntAnnéeAncienneté;
    //                         RecSalaryLines.RESET();
    //                         RecSalaryLines.SETRANGE(RecSalaryLines.Employee, Notes.Matricule);
    //                         RecSalaryLines.SETRANGE(RecSalaryLines.Year, Notes.Année);
    //                         IF RecSalaryLines.FINDFIRST() THEN
    //                             REPEAT
    //                                 NbreFiche := NbreFiche + 1;

    //                             UNTIL RecSalaryLines.NEXT = 0;
    //                         Notes."Nbre Fiche" := NbreFiche;

    //                         Notes.MODIFY;
    //                     END;

    //                 END;
    //             END;

    //             totalmantant := totalmantant + MantantPrime;
    //             NbreSalarié := NbreSalarié + 1;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO(Année);
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // var
    //     PageConst: Label 'Page';
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     "IntMoisAncienneté": Integer;
    //     "IntAnnéeAncienneté": Integer;
    //     "Ancienneté": Text[50];
    //     IntAncienneteJour: Integer;
    //     DateRefAnciennete: Date;
    //     Salarie: Record 5200;
    //     RecSalaryLines: Record 52048901;
    //     Managementofsalary: Codeunit 39001402;
    //     NewDate: Date;
    //     NbrJour: Integer;
    //     MantantPrime: Decimal;
    //     "ZoneSalarié": Text[30];
    //     totalmantant: Decimal;
    //     "NbreSalarié": Integer;
    //     NbreFiche: Integer;
    //     Etat_Mantant_Prime_Non_ImposableCaptionLbl: Label 'Etat Mantant Prime Non Imposable';
    //     "Année__CaptionLbl": Label 'Année :';
    //     Montant_PrimeCaptionLbl: Label 'Montant Prime';
    //     "AncientéCaptionLbl": Label 'Ancienté';
    //     ZoneCaptionLbl: Label 'Zone';
    //     Base_CalculCaptionLbl: Label 'Base Calcul';
    //     Total_Mantant_Prime__CaptionLbl: Label 'Total Mantant Prime :';
    //     Nbre__CaptionLbl: Label 'Nbre :';
}

