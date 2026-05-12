report 50002 "Demande d'Appro"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/DemandedAppro.rdlc';

    dataset
    {
        dataitem(DataItem6640; 36)
        {
            column(RecCompInf_Picture; RecCompInf.Picture)
            {
            }
            column(FORMAT__Sales_Header___Document_Date__0_4_; FORMAT("Sales Header"."Document Date", 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(N________Sales_Header___No__; 'N   ' + "Sales Header"."No.")
            {
            }
            column(Choix_2_; Choix[2])
            {
            }
            column(Choix_1_; Choix[1])
            {
            }
            column(Choix_3_; Choix[3])
            {
            }
            column(Choix_4_; Choix[4])
            {
            }
            column(Sales_Header__Sales_Header___User_ID_; "Sales Header"."User ID")
            {
            }
            column(Sales_Header__Sales_Header__Service; "Sales Header".Service)
            {
            }
            column(RecUser__User_Name_; RecUser."User Name")
            {
            }
            column(RecUserSetup_Fonction; RecUserSetup.Fonction)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(User_Caption; User_CaptionLbl)
            {
            }
            column(DEMANDE_D_APPROVISIONNEMENTCaption; DEMANDE_D_APPROVISIONNEMENTCaptionLbl)
            {
            }
            column(PIECE_DE_RACHANGE_Caption; PIECE_DE_RACHANGE_CaptionLbl)
            {
            }
            column(MATERIAUXCaption; MATERIAUXCaptionLbl)
            {
            }
            column(FOURNITURES_ET_DIVERS_Caption; FOURNITURES_ET_DIVERS_CaptionLbl)
            {
            }
            column(PRESTATION_DE_SERVICE_Caption; PRESTATION_DE_SERVICE_CaptionLbl)
            {
            }
            column(FONCTIONCaption; FONCTIONCaptionLbl)
            {
            }
            column(NOMCaption; NOMCaptionLbl)
            {
            }
            column(SERVICECaption; SERVICECaptionLbl)
            {
            }
            column(DEMANDEUR_Caption; DEMANDEUR_CaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(DataItem2844; 37)
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(Sales_Line__Unit_Cost__LCY__; "Unit Cost (LCY)")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Sales_Line__No__; "No.")
                {
                }
                column(FORMAT__Quantity_____________Unit_of_Measure_; FORMAT(Quantity) + '  ' + "Unit of Measure")
                {
                }
                column(Sales_Line_Description; Description)
                {
                }
                column(QtCaption; QtCaptionLbl)
                {
                }
                column(Observation_Caption; Observation_CaptionLbl)
                {
                }
                column(Prix_UnitaireCaption; Prix_UnitaireCaptionLbl)
                {
                }
                column(R_f_renceCaption; R_f_renceCaptionLbl)
                {
                }
                column(D_signation_Caption; D_signation_CaptionLbl)
                {
                }
                column(Code_Caption; Code_CaptionLbl)
                {
                }
                column(Sales_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Line_Line_No_; "Line No.")
                {
                }
            }
            dataitem(SAUT; 2000000026)
            {
                column(Sales_Line___Total_Cost__LCY__; "Sales Line"."Total Cost (LCY)")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Sales_Header__Engin; "Sales Header".Engin)
                {
                }
                column(No_Serie; "Sales Header"."No. Series")
                {
                }
                column(Sales_Header__Type; "Sales Header".Type)
                {
                }
                column(LE_DEMANDEUR_Caption; LE_DEMANDEUR_CaptionLbl)
                {
                }
                column(LE_SERVICE_APPROCaption; LE_SERVICE_APPROCaptionLbl)
                {
                }
                column(LE_DIRECTEURCaption; LE_DIRECTEURCaptionLbl)
                {
                }
                column(TOTAL_DACaption; TOTAL_DACaptionLbl)
                {
                }
                column(SI_DA_De_PDR_Caption; SI_DA_De_PDR_CaptionLbl)
                {
                }
                column(Engin__Caption; Engin__CaptionLbl)
                {
                }
                column(Type__Caption; Type__CaptionLbl)
                {
                }
                column(N__de_s_rie__Caption; N__de_s_rie__CaptionLbl)
                {
                }
                column(SAUT_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF RecUser.GET("User ID") THEN;
                IF RecUserSetup.GET("User ID") THEN;
                CLEAR(Choix);
                CASE "Type Demande" OF
                    0:
                        Choix[1] := 'X';
                    1:
                        Choix[2] := 'X';
                    2:
                        Choix[3] := 'X';
                    3:
                        Choix[4] := 'X';
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        RecCompInf: Record 79;
        "Sales Header": Record 36;
        RecUser: Record 2000000120;
        "Sales Line": Record 37;
        RecUserSetup: Record 91;
        Choix: array[4] of Code[2];
        IntCompteur: Integer;
        DateCaptionLbl: Label 'Date';
        User_CaptionLbl: Label 'User ';
        DEMANDE_D_APPROVISIONNEMENTCaptionLbl: Label 'DEMANDE D''APPROVISIONNEMENT';
        PIECE_DE_RACHANGE_CaptionLbl: Label 'PIECE DE RACHANGE ';
        MATERIAUXCaptionLbl: Label 'MATERIAUX';
        FOURNITURES_ET_DIVERS_CaptionLbl: Label 'FOURNITURES ET DIVERS ';
        PRESTATION_DE_SERVICE_CaptionLbl: Label 'PRESTATION DE SERVICE ';
        FONCTIONCaptionLbl: Label 'FONCTION';
        NOMCaptionLbl: Label 'NOM';
        SERVICECaptionLbl: Label 'SERVICE';
        DEMANDEUR_CaptionLbl: Label 'DEMANDEUR ';
        QtCaptionLbl: Label 'Qté';
        Observation_CaptionLbl: Label 'Observation ';
        Prix_UnitaireCaptionLbl: Label 'Prix Unitaire';
        R_f_renceCaptionLbl: Label 'Référence';
        D_signation_CaptionLbl: Label 'Désignation ';
        Code_CaptionLbl: Label 'Code ';
        LE_DEMANDEUR_CaptionLbl: Label 'LE DEMANDEUR ';
        LE_SERVICE_APPROCaptionLbl: Label 'LE SERVICE APPRO';
        LE_DIRECTEURCaptionLbl: Label 'LE DIRECTEUR';
        TOTAL_DACaptionLbl: Label 'TOTAL DA';
        SI_DA_De_PDR_CaptionLbl: Label 'SI DA De PDR ';
        Engin__CaptionLbl: Label 'Engin :';
        Type__CaptionLbl: Label 'Type :';
        N__de_s_rie__CaptionLbl: Label 'N° de série :';
}

