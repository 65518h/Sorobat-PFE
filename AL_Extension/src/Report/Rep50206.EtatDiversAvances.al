report 50206 "Etat Divers Avances"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/EtatDiversAvances.rdlc';
    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;
    // Caption = 'Etat Divers Avances';

    // dataset
    // {
    //     dataitem("Payment Line"; 10866)
    //     {
    //         DataItemTableView = SORTING("No.", "Line No.")
    //                             WHERE(Caisse = CONST(true),
    //                                   Amount = FILTER(<> 0),
    //                                   "Caisse Chantier" = CONST(false));
    //         RequestFilterFields = "Type Origine", Benificiaire, "Code Opération", "Date Debut", Receptionneur;
    //         column("Période_du______FORMAT_Date1_____AU____FORMAT_Date2_"; 'Période du :  ' + FORMAT(Date1) + '  AU  ' + FORMAT(Date2))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Payment_Line__Due_Date_; "Due Date")
    //         {
    //         }
    //         column("Payment_Line_Libellé"; Libellé)
    //         {
    //         }
    //         column(ABS__Debit_Amount__; ABS("Debit Amount"))
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Payment_Line_Benificiaire; Benificiaire)
    //         {
    //         }
    //         column(ABS__Credit_Amount__; ABS("Credit Amount"))
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Payment_Line__Numero_Seq_; "Numero Seq")
    //         {
    //         }
    //         column(Payment_Line__Nom_Benificiaire_; "Nom Benificiaire")
    //         {
    //         }
    //         column(Payment_Line__Payment_Line___Date_Debut_; "Payment Line"."Date Debut")
    //         {

    //         }
    //         column(Payment_Line__Payment_Line__Tranche; "Payment Line".Tranche)
    //         {
    //             DecimalPlaces = 0 : 0;
    //         }
    //         column("Payment_Line__Code_Opération_"; "Code Opération")
    //         {
    //         }
    //         column(TotalDebit; TotalDebit)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(TotalCrebit; TotalCrebit)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(SITUATION_INDIVIDUELLE_A_LA_CAISSECaption; SITUATION_INDIVIDUELLE_A_LA_CAISSECaptionLbl)
    //         {
    //         }
    //         column(Caisse_CentraleCaption; Caisse_CentraleCaptionLbl)
    //         {
    //         }
    //         column(SOROUBATCaption; SOROUBATCaptionLbl)
    //         {
    //         }
    //         column(RecettesCaption; RecettesCaptionLbl)
    //         {
    //         }
    //         column("LibelléCaption"; LibelléCaptionLbl)
    //         {
    //         }
    //         column("JournéeCaption"; JournéeCaptionLbl)
    //         {
    //         }
    //         column(Prise_en_ChargeCaption; Prise_en_ChargeCaptionLbl)
    //         {
    //         }
    //         column("DépensesCaption"; DépensesCaptionLbl)
    //         {
    //         }
    //         column("RéférenceCaption"; RéférenceCaptionLbl)
    //         {
    //         }
    //         column(Date_AffectationCaption; Date_AffectationCaptionLbl)
    //         {
    //         }
    //         column(TrancheCaption; TrancheCaptionLbl)
    //         {
    //         }
    //         column(Code_OpCaption; Code_OpCaptionLbl)
    //         {
    //         }
    //         column(TOTAL__Caption; TOTAL__CaptionLbl)
    //         {
    //         }
    //         column(Payment_Line_No_; "No.")
    //         {
    //         }
    //         column(Payment_Line_Line_No_; "Line No.")
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin

    //             TotalDebit := TotalDebit + ABS("Debit Amount");
    //             TotalCrebit := TotalCrebit + ABS("Credit Amount");
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             "Payment Line".SETRANGE("Payment Line"."Due Date", Date1, Date2);
    //             //"Payment Line".SETRANGE("N° Affaire",FORMAT(ChantierAffaire));

    //             TotalDebit := 0;
    //             TotalCrebit := 0;

    //         end;
    //     }
    // }

    // requestpage
    // {
    //     layout
    //     {
    //         area(content)
    //         {
    //             group(Options)
    //             {
    //                 Caption = 'Options';
    //                 field("Période du :"; "Date1")
    //                 {
    //                     Caption = 'Période du :';
    //                 }
    //                 field("Au"; "Date2")
    //                 {
    //                     Caption = 'Au';
    //                 }
    //                 field("Chantier :"; ChantierAffaire)
    //                 {
    //                     Caption = 'Chantier :';
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
    //     Date1: Date;
    //     Date2: Date;
    //     TotalDebit: Decimal;
    //     TotalCrebit: Decimal;
    //     ChantierAffaire: Option ADMINISTRATION,"AEROP-JERBA-MATMATA",PENETRANTE_LOT2,PENETRANTE_LOT3,BIZERTE_BASE_AERIEN,PONT_BIZERTE_LOT1,"PORT FINA RAOUED RP2","AUTOROUTE SBIKHA LO5",CHANTIER_KEF_RR173,OUED_JOUMINE_MATEUR;
    //     SITUATION_INDIVIDUELLE_A_LA_CAISSECaptionLbl: Label 'SITUATION INDIVIDUELLE A LA CAISSE';
    //     Caisse_CentraleCaptionLbl: Label 'Caisse Centrale';
    //     SOROUBATCaptionLbl: Label 'SOROUBAT';
    //     RecettesCaptionLbl: Label 'Recettes';
    //     "LibelléCaptionLbl": Label 'Libellé';
    //     "JournéeCaptionLbl": Label 'Journée';
    //     Prise_en_ChargeCaptionLbl: Label 'Prise en Charge';
    //     "DépensesCaptionLbl": Label 'Dépenses';
    //     "RéférenceCaptionLbl": Label 'Référence';
    //     Date_AffectationCaptionLbl: Label 'Date Affectation';
    //     TrancheCaptionLbl: Label 'Tranche';
    //     Code_OpCaptionLbl: Label 'Code Op';
    //     TOTAL__CaptionLbl: Label 'TOTAL :';
}

