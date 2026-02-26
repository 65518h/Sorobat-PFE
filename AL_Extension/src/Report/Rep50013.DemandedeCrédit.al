report 50013 "Demande de Crédit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/DemandedeCrédit.rdlc';

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Sell-to Customer No." = FILTER(<> ''));
            RequestFilterFields = "Bill-to Customer No.", "Posting Date";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Sales_Header__Bill_to_City_; "Bill-to City")
            {
            }
            column(Sales_Header__Bill_to_Address_2_; "Bill-to Address 2")
            {
            }
            column(Sales_Header__Bill_to_Address_; "Bill-to Address")
            {
            }
            column(Sales_Header__Bill_to_Name_; "Bill-to Name")
            {
            }
            column(Textcin; Textcin)
            {
            }
            column(valeurCin; valeurCin)
            {
            }
            column(DEMANDE_DE_CREDITCaption; DEMANDE_DE_CREDITCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Fiche_de_renseignementCaption; Fiche_de_renseignementCaptionLbl)
            {
            }
            column(IDENTITE_DU__OU_DES__CLIENTS_Caption; IDENTITE_DU__OU_DES__CLIENTS_CaptionLbl)
            {
            }
            column(Sales_Header__Bill_to_City_Caption; FIELDCAPTION("Bill-to City"))
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(DomicileCaption; DomicileCaptionLbl)
            {
            }
            column("Nom___prénomCaption"; Nom___prénomCaptionLbl)
            {
            }
            column("Délivrée_àCaption"; Délivrée_àCaptionLbl)
            {
            }
            column(Date___lieu_de_naissanceCaption; Date___lieu_de_naissanceCaptionLbl)
            {
            }
            column(ProfessionCaption; ProfessionCaptionLbl)
            {
            }
            column(SalaireCaption; SalaireCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control31; EmptyStringCaption_Control31Lbl)
            {
            }
            column(EmptyStringCaption_Control32; EmptyStringCaption_Control32Lbl)
            {
            }
            column(EmptyStringCaption_Control34; EmptyStringCaption_Control34Lbl)
            {
            }
            column(EmptyStringCaption_Control36; EmptyStringCaption_Control36Lbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }

            dataitem("Sales Line"; 37)
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                column(Sales_Line_Description; Description)
                {
                }
                column(Sales_Header___Amount_Including_VAT_; "Sales Header"."Amount Including VAT")
                {
                    DecimalPlaces = 3 : 3;
                    Description = '//GL2024 SourceEXPR="Sales Header"."Amount Including VAT"-"Sales Header".Acompte-"Sales Header"."Accompte Différé"';
                }
                column(Sales_Header___Amount_Including_VAT__Control43; "Sales Header"."Amount Including VAT")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(PaymentTerms_Description; PaymentTerms.Description)
                {
                    // DecimalPlaces = 3:3;
                }
                column(MATERIEL_A_ACQUERIR_Caption; MATERIEL_A_ACQUERIR_CaptionLbl)
                {
                }
                column(CREDIT_Caption; CREDIT_CaptionLbl)
                {
                }
                column("Montant_du_crédit_demandé_Caption"; Montant_du_crédit_demandé_CaptionLbl)
                {
                }
                column(Montant_total_de_la_facture_Caption; Montant_total_de_la_facture_CaptionLbl)
                {
                }
                column("Paiement_à_la_commande_Caption"; Paiement_à_la_commande_CaptionLbl)
                {
                }
                column("Durée___modalité_du_crédit_Caption"; Durée___modalité_du_crédit_CaptionLbl)
                {
                }
                column(RESSOURCES_Caption; RESSOURCES_CaptionLbl)
                {
                }
                column(a__Exploitation_Agricole_Caption; a__Exploitation_Agricole_CaptionLbl)
                {
                }
                column(Grandes_cultures___Superficie_et_nature_Caption; Grandes_cultures___Superficie_et_nature_CaptionLbl)
                {
                }
                column(Elevage___Nature_et_nombre_de_sujet_Caption; Elevage___Nature_et_nombre_de_sujet_CaptionLbl)
                {
                }
                column("Point_d_eaus___Precier_puits__Réseau_public_etc_Caption"; Point_d_eaus___Precier_puits__Réseau_public_etc_CaptionLbl)
                {
                }
                column("Culture_maraichéres___Superficie_Caption"; Culture_maraichéres___Superficie_CaptionLbl)
                {
                }
                column(Arboricultures___Nombre_Age_et_nature_Caption; Arboricultures___Nombre_Age_et_nature_CaptionLbl)
                {
                }
                column(b_Autres_Biens__Caption; b_Autres_Biens__CaptionLbl)
                {
                }
                column(EmptyStringCaption_Control56; EmptyStringCaption_Control56Lbl)
                {
                }
                column(EmptyStringCaption_Control57; EmptyStringCaption_Control57Lbl)
                {
                }
                column(EmptyStringCaption_Control58; EmptyStringCaption_Control58Lbl)
                {
                }
                column(c__Revenue_annuel_de_l_exploitation__Caption; c__Revenue_annuel_de_l_exploitation__CaptionLbl)
                {
                }
                column(EmptyStringCaption_Control60; EmptyStringCaption_Control60Lbl)
                {
                }
                column(d__Autres_Revenues__Caption; d__Autres_Revenues__CaptionLbl)
                {
                }
                column(EmptyStringCaption_Control62; EmptyStringCaption_Control62Lbl)
                {
                }
                column(EmptyStringCaption_Control63; EmptyStringCaption_Control63Lbl)
                {
                }
                column(EmptyStringCaption_Control64; EmptyStringCaption_Control64Lbl)
                {
                }
                column(EmptyStringCaption_Control65; EmptyStringCaption_Control65Lbl)
                {
                }
                column(EmptyStringCaption_Control66; EmptyStringCaption_Control66Lbl)
                {
                }
                column(EmptyStringCaption_Control67; EmptyStringCaption_Control67Lbl)
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

            trigger OnAfterGetRecord()
            begin
                "Sales Header".CALCFIELDS(Amount, "Amount Including VAT");
                CLEAR(cin);
                IF cin.GET("Sales Header"."Bill-to Customer No.") THEN
                    mm := 0;
                IF cin."Home Page" <> '' THEN BEGIN
                    Textcin := ' N° C.I.N :';
                    valeurCin := cin."Home Page";
                END;
                IF cin."Telex No." <> '' THEN BEGIN
                    Textcin := 'Matricule Fisale :';
                    valeurCin := cin."Telex No.";
                END;
                IF PaymentTerms.GET("Payment Terms Code") THEN;

                cin.GET("Sell-to Customer No.");
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
        design: Record 37;
        mtotal: Decimal;
        cin: Record 18;
        Textcin: Text[30];
        mm: Integer;
        valeurCin: Text[30];
        PaymentTerms: Record 3;
        DEMANDE_DE_CREDITCaptionLbl: Label 'DEMANDE DE CREDIT';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Fiche_de_renseignementCaptionLbl: Label 'Fiche de renseignement';
        IDENTITE_DU__OU_DES__CLIENTS_CaptionLbl: Label 'IDENTITE DU (OU DES) CLIENTS:';
        DateCaptionLbl: Label 'Date';
        DomicileCaptionLbl: Label 'Domicile';
        "Nom___prénomCaptionLbl": Label 'Nom & prénom';
        "Délivrée_àCaptionLbl": Label 'Délivrée à';
        Date___lieu_de_naissanceCaptionLbl: Label 'Date & lieu de naissance';
        ProfessionCaptionLbl: Label 'Profession';
        SalaireCaptionLbl: Label 'Salaire';
        EmptyStringCaptionLbl: Label '...................................................................................';
        EmptyStringCaption_Control31Lbl: Label '...................................................................................';
        EmptyStringCaption_Control32Lbl: Label '.......................................................................................................................................................................................';
        EmptyStringCaption_Control34Lbl: Label '.......................................................................................................................................................................................';
        EmptyStringCaption_Control36Lbl: Label '.......................................................................................................................................................................................';
        MATERIEL_A_ACQUERIR_CaptionLbl: Label 'MATERIEL A ACQUERIR:';
        CREDIT_CaptionLbl: Label 'CREDIT:';
        "Montant_du_crédit_demandé_CaptionLbl": Label 'Montant du crédit demandé:';
        Montant_total_de_la_facture_CaptionLbl: Label 'Montant total de la facture:';
        "Paiement_à_la_commande_CaptionLbl": Label 'Paiement à la commande:';
        "Durée___modalité_du_crédit_CaptionLbl": Label 'Durée & modalité du crédit:';
        RESSOURCES_CaptionLbl: Label 'RESSOURCES:';
        a__Exploitation_Agricole_CaptionLbl: Label 'a) Exploitation Agricole:';
        Grandes_cultures___Superficie_et_nature_CaptionLbl: Label 'Grandes cultures :(Superficie et nature)';
        Elevage___Nature_et_nombre_de_sujet_CaptionLbl: Label 'Elevage :(Nature et nombre de sujet)';
        "Point_d_eaus___Precier_puits__Réseau_public_etc_CaptionLbl": Label 'Point d''eaus :(Precier puits, Réseau public etc)';
        "Culture_maraichéres___Superficie_CaptionLbl": Label 'Culture maraichéres :(Superficie)';
        Arboricultures___Nombre_Age_et_nature_CaptionLbl: Label 'Arboricultures :(Nombre,Age et nature)';
        b_Autres_Biens__CaptionLbl: Label 'b)Autres Biens :';
        EmptyStringCaption_Control56Lbl: Label '...............................................................................................................................................................................................................';
        EmptyStringCaption_Control57Lbl: Label '...............................................................................................................................................................................................................';
        EmptyStringCaption_Control58Lbl: Label '...............................................................................................................................................................................................................';
        c__Revenue_annuel_de_l_exploitation__CaptionLbl: Label 'c) Revenue annuel de l''exploitation: ';
        EmptyStringCaption_Control60Lbl: Label '...............................................................................................................................................................................................................';
        d__Autres_Revenues__CaptionLbl: Label 'd) Autres Revenues: ';
        EmptyStringCaption_Control62Lbl: Label '...............................................................................................................................................................................................................';
        EmptyStringCaption_Control63Lbl: Label '...............................................................................................................................................................................................................';
        EmptyStringCaption_Control64Lbl: Label '...............................................................................................................................................................................................................';
        EmptyStringCaption_Control65Lbl: Label '...............................................................................................................................................................................................................';
        EmptyStringCaption_Control66Lbl: Label '...............................................................................................................................................................................................................';
        EmptyStringCaption_Control67Lbl: Label '...............................................................................................................................................................................................................';
}

