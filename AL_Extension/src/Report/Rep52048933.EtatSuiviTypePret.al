report 52048933 "Etat Suivi Type Pret"
{
    // //Id Nav 39001420
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/EtatSuiviTypePret.rdl';

    // dataset
    // {
    //     dataitem("Loan & Advance Header"; "Loan & Advance Header")
    //     {
    //         DataItemTableView = SORTING("Pret CNSS")
    //                             WHERE(Type = CONST(Loan));
    //         PrintOnlyIfDetail = true;
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(USERID; USERID)
    //         {
    //         }
    //         column(Mois; Mois)
    //         {
    //         }
    //         column(Annee; Annee)
    //         {
    //         }
    //         column(LISTE_____TypePret; 'LISTE ' + TypePret)
    //         {
    //         }
    //         column(Somme; Somme)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Mois_du__Caption; Mois_du__CaptionLbl)
    //         {
    //         }
    //         column("Année__Caption"; Année__CaptionLbl)
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column(Nom_Et_PrenomCaption; Nom_Et_PrenomCaptionLbl)
    //         {
    //         }
    //         column(AffCaption; AffCaptionLbl)
    //         {
    //         }
    //         column(Description_AffCaption; Description_AffCaptionLbl)
    //         {
    //         }
    //         column(MontantCaption; MontantCaptionLbl)
    //         {
    //         }
    //         column(Loan___Advance_Header_No_; "No.")
    //         {
    //         }
    //         column(Loan___Advance_Header_Pret_CNSS; "Pret CNSS")
    //         {
    //         }
    //         dataitem("Loan & Advance Lines"; "Loan & Advance Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING(Year, Month);
    //             column(Loan___Advance_Lines_Employee; Employee)
    //             {
    //             }
    //             column(Loan___Advance_Lines__Line_Amount_; "Line Amount")
    //             {
    //             }
    //             column(Loan___Advance_Lines_section; section)
    //             {
    //             }
    //             column(RecEmployee__First_Name_; RecEmployee."First Name")
    //             {
    //             }
    //             column(RecSection_Decription; RecSection.Decription)
    //             {
    //             }
    //             column(Loan___Advance_Lines_No_; "No.")
    //             {
    //             }
    //             column(Loan___Advance_Lines_Entry_No_; "Entry No.")
    //             {
    //             }
    //             column(Loan___Advance_Lines_Year; Year)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin

    //                 IF RecEmployee.GET(Employee) THEN;
    //                 IF RecSection.GET(section) THEN;
    //                 Somme += "Line Amount";
    //             end;

    //             trigger OnPreDataItem()
    //             begin
    //                 IF Annee <> 0 THEN SETRANGE(Year, Annee);
    //                 SETRANGE(Month, Mois);
    //                 CurrReport.CREATETOTALS("Line Amount");
    //             end;
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             // CurrReport.SHOWOUTPUT :=
    //             //   CurrReport.TOTALSCAUSEDBY = "Loan & Advance Header".FIELDNO("Pret CNSS");
    //             //IF CurrReport.TOTALSCAUSEDBY = "Loan & Advance Header".FIELDNO("Pret CNSS") THEN BEGIN
    //             Somme := 0;
    //             IF "Pret CNSS" = 0 THEN TypePret := 'PRET SOCIETE';
    //             IF "Pret CNSS" = 1 THEN TypePret := 'CNSS LOGEMENT';
    //             IF "Pret CNSS" = 2 THEN TypePret := 'CNSS VOITURE';
    //             IF "Pret CNSS" = 3 THEN TypePret := 'CESSION';
    //             //   END;

    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(content)
    //         {
    //             group(Group)
    //             {
    //                 Caption = 'Paramètres';
    //                 field(Mois; Mois)
    //                 {
    //                     Caption = 'Mois';
    //                 }
    //                 field(Annee; Annee)
    //                 {
    //                     Caption = 'Année';
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

    // var
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     RecEmployee: Record 5200;
    //     RecSection: Record Section;
    //     TypePret: Text[30];
    //     Mois: Option Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Autre;
    //     Annee: Integer;
    //     Somme: Decimal;
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     Mois_du__CaptionLbl: Label 'Mois du :';
    //     "Année__CaptionLbl": Label 'Année :';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     Nom_Et_PrenomCaptionLbl: Label 'Nom Et Prenom';
    //     AffCaptionLbl: Label 'Aff';
    //     Description_AffCaptionLbl: Label 'Description Aff';
    //     MontantCaptionLbl: Label 'Montant';
}

