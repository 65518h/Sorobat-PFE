report 50280 "SUIVI BT CURATIVE"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/SUIVIBTCURATIVE.rdlc';

    // dataset
    // {
    //     dataitem("Entete BT Enreg"; 52049017)
    //     {
    //         DataItemTableView = SORTING (Code);
    //         RequestFilterFields = "Code";
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(USERID; USERID)
    //         {
    //         }
    //         column(Entete_BT_Enreg_Observation; Observation)
    //         {
    //         }
    //         column(Entete_BT_Enreg_Code; Code)
    //         {
    //         }
    //         column(Entete_BT_Enreg__Date_Lancement_; "Date Lancement")
    //         {
    //         }
    //         column(Entete_BT_Enreg_Equipement; Equipement)
    //         {
    //         }
    //         column(Entete_BT_Enreg__Designiation_Equipement_; "Designiation Equipement")
    //         {
    //         }
    //         column(Entete_BT_Enreg_Status; Status)
    //         {
    //         }
    //         column(Entete_BT_Enreg__Index_Actuelle_; "Index Actuelle")
    //         {
    //         }
    //         column(Entete_BT_Enreg_Immatriculation; Immatriculation)
    //         {
    //         }
    //         column(Entete_BT_EnregCaption; Entete_BT_EnregCaptionLbl)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Entete_BT_Enreg_CodeCaption; FIELDCAPTION(Code))
    //         {
    //         }
    //         column(Entete_BT_Enreg__Date_Lancement_Caption; FIELDCAPTION("Date Lancement"))
    //         {
    //         }
    //         column(Entete_BT_Enreg_EquipementCaption; FIELDCAPTION(Equipement))
    //         {
    //         }
    //         column(Entete_BT_Enreg__Designiation_Equipement_Caption; FIELDCAPTION("Designiation Equipement"))
    //         {
    //         }
    //         column(Entete_BT_Enreg_StatusCaption; FIELDCAPTION(Status))
    //         {
    //         }
    //         column(Entete_BT_Enreg__Index_Actuelle_Caption; FIELDCAPTION("Index Actuelle"))
    //         {
    //         }
    //         column(Entete_BT_Enreg_ImmatriculationCaption; FIELDCAPTION(Immatriculation))
    //         {
    //         }
    //         column(ObservationsCaption; ObservationsCaptionLbl)
    //         {
    //         }

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO(Code);
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
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     Entete_BT_EnregCaptionLbl: Label 'Entete BT Enreg';
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     ObservationsCaptionLbl: Label 'Observations';
}

