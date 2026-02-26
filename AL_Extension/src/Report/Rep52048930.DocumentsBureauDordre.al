report 52048930 "Documents Bureau D'ordre"
// dans Nav 1 ans d'avant l'ID est 50000
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Documents Bureau D''ordre';
    RDLCLayout = './Layouts/DocumentsBureauDordre.rdlc';////

    dataset
    {
        dataitem(DataItem3644; 50008)
        {
            DataItemTableView = SORTING("Document N°");
            RequestFilterFields = "Document N°";
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
            column("N_________Document_N________Journée_du________FORMAT_Journée_"; 'N° :   ' + "Document N°" + '    Journée du :    ' + FORMAT(Journée))
            {
            }
            column(Nombres_de_Factures_______FORMAT_NbreFacture_; 'Nombres de Factures  :  ' + FORMAT(NbreFacture))
            {
            }
            column(Bureau_D_ordreCaption; Bureau_D_ordreCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Document_Bureau_D_ordreCaption; Document_Bureau_D_ordreCaptionLbl)
            {
            }
            column(Code_FournisseurCaption; Code_FournisseurCaptionLbl)
            {
            }
            column("Déscription_FournisseurCaption"; Déscription_FournisseurCaptionLbl)
            {
            }
            column(Matricule_FiscaleCaption; Matricule_FiscaleCaptionLbl)
            {
            }
            column(N__FactureCaption; N__FactureCaptionLbl)
            {
            }
            column(Montant_HTCaption; Montant_HTCaptionLbl)
            {
            }
            column(Montant_TVACaption; Montant_TVACaptionLbl)
            {
            }
            column(Montant_TTCCaption; Montant_TTCCaptionLbl)
            {
            }
            column(Date_Facture_Fourn_Caption; Date_Facture_Fourn_CaptionLbl)
            {
            }
            column(Bureau_D_ordreCaption_Control1000000038; Bureau_D_ordreCaption_Control1000000038Lbl)
            {
            }
            column(Service_FacturationCaption; Service_FacturationCaptionLbl)
            {
            }
            column(Bureau_Ordre_Document_N_; "Document N°")
            {
            }
            dataitem(DataItem6064; 50009)
            {
                DataItemLink = "Document N°" = FIELD("Document N°");
                DataItemTableView = SORTING("Document N°", "N° Ligne");
                column(Bureau_Ordre_Diffusion__N__Fournisseur_; "N° Fournisseur")
                {
                }
                column(Bureau_Ordre_Diffusion__Nom_Fournisseur_; "Nom Fournisseur")
                {
                }
                column(Bureau_Ordre_Diffusion__Matricule_Fiscale_; "Matricule Fiscale")
                {
                }
                column(Bureau_Ordre_Diffusion__Montant_HT_; "Montant HT")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Bureau_Ordre_Diffusion__Montant_TTC_; "Montant TTC")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Bureau_Ordre_Diffusion__Montant_TVA_; "Montant TVA")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Bureau_Ordre_Diffusion__Numero_Facture_; "Numero Facture")
                {
                }
                column(Bureau_Ordre_Diffusion__Date_Facture_Fournisseur_; "Date Facture Fournisseur")
                {
                }
                column(Bureau_Ordre_Diffusion_Document_N_; "Document N°")
                {
                }
                column(Bureau_Ordre_Diffusion_N__Ligne; "N° Ligne")
                {
                }
                column("Bureau_Ordre_Diffusion_Référence_Ligne"; "Référence Ligne")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    NbreFacture := NbreFacture + 1;
                end;
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Document N°");
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        NbreFacture: Integer;
        Bureau_D_ordreCaptionLbl: Label 'Bureau D''ordre';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Document_Bureau_D_ordreCaptionLbl: Label 'Document Bureau D''ordre';
        Code_FournisseurCaptionLbl: Label 'Code Fournisseur';
        "Déscription_FournisseurCaptionLbl": Label 'Déscription Fournisseur';
        Matricule_FiscaleCaptionLbl: Label 'Matricule Fiscale';
        N__FactureCaptionLbl: Label 'N° Facture';

        Montant_HTCaptionLbl: Label 'Montant HT';
        Montant_TVACaptionLbl: Label 'Montant TVA';
        Montant_TTCCaptionLbl: Label 'Montant TTC';
        Date_Facture_Fourn_CaptionLbl: Label 'Date Facture Fourn.';
        Bureau_D_ordreCaption_Control1000000038Lbl: Label 'Bureau D''ordre';
        Service_FacturationCaptionLbl: Label 'Service Facturation';
}
