report 50283 "Ordre Virement Fournisseur"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/OrdreVirementFournisseur.rdlc';

    dataset
    {
        dataitem("Payment Header"; 10865)
        {
            column(ORDRE_DE_VIREMENT_N______No__; 'ORDRE DE VIREMENT N°  ' + "No.")
            {
            }
            column(RIBsociete; RIBsociete)
            {
            }
            column(RaisonSociale; RaisonSociale)
            {
            }
            column("Mégrine_le______FORMAT__Document_Date__"; 'Mégrine le :  ' + FORMAT("Document Date"))
            {
            }
            column(NomBanque; NomBanque)
            {
            }
            column(Payment_Header_Motif; Motif)
            {
            }
            column(RIB_DONNEUR_D_ORDRE__Caption; RIB_DONNEUR_D_ORDRE__CaptionLbl)
            {
            }
            column(RAISON_SOCIALE__Caption; RAISON_SOCIALE__CaptionLbl)
            {
            }
            column("RIB___RIP_Bénéficiaire__s_Caption"; RIB___RIP_Bénéficiaire__s_CaptionLbl)
            {
            }
            column(BanqueCaption; BanqueCaptionLbl)
            {
            }
            column("Nom___Prénom___Raison_socialeCaption"; Nom___Prénom___Raison_socialeCaptionLbl)
            {
            }
            column(MontantCaption; MontantCaptionLbl)
            {
            }
            column(MOTIF_DE_VIREMENT__Caption; MOTIF_DE_VIREMENT__CaptionLbl)
            {
            }
            column(Payment_Header_No_; "No.")
            {
            }
            dataitem("Payment Line"; 10866)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.");
                column(RIBfournisseur; RIBfournisseur)
                {
                }
                column(BanqueFournisseur; BanqueFournisseur)
                {
                }
                column(NomFournisseur; NomFournisseur)
                {
                }
                column(MontantFournisseur; MontantFournisseur)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Nbre; Nbre)
                {
                }
                column(MontantTotal; MontantTotal)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TextGMnt; TextGMnt)
                {
                }
                column(NombreCaption; NombreCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Total_en_toutes_lettres__Caption; Total_en_toutes_lettres__CaptionLbl)
                {
                }
                column(Important__Caption; Important__CaptionLbl)
                {
                }
                column("V1_Cet_Ordre_ne_sera_exécuté_que_si_la_situation_du_donneur_d_ordre_le_permet_Caption"; V1_Cet_Ordre_ne_sera_exécuté_que_si_la_situation_du_donneur_d_ordre_le_permet_CaptionLbl)
                {
                }
                column(DataItem1000000036; V2__Le_donneur_d_ordre_dégage_d_ores)
                {
                }
                column(Signature_du_ClientCaption; Signature_du_ClientCaptionLbl)
                {
                }
                column(Payment_Line_No_; "No.")
                {
                }
                column(Payment_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    MontantFournisseur := 0;

                    IF RecVendor.GET("Payment Line"."Code compte") THEN BEGIN
                        RIBfournisseur := RecVendor.RIB;
                        BanqueFournisseur := FORMAT(RecVendor.Banque);
                        NomFournisseur := RecVendor.Name;
                    END;
                    MontantFournisseur := "Payment Line"."Debit Amount";
                    Nbre += 1;
                    MontantTotal += MontantFournisseur;
                    TextGMnt := '';
                    CodeU."Montant en texte sans millimes"(TextGMnt, MontantTotal);
                end;
            }
            trigger OnAfterGetRecord()
            begin

                IF BankAccount.GET("Account No.") THEN BEGIN
                    RIBsociete := BankAccount.RIB;
                    NomBanque := BankAccount."Name 2";
                END;
                IF CompanyInformation.GET() THEN RaisonSociale := CompanyInformation.Name;
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
        BankAccount: Record 270;
        RIBsociete: Text[30];
        RecVendor: Record 23;
        RIBfournisseur: Text[30];
        BanqueFournisseur: Text[30];
        CompanyInformation: Record 79;
        RaisonSociale: Text[50];
        MontantFournisseur: Decimal;
        NomFournisseur: Text[150];
        MontantTotal: Decimal;
        Nbre: Integer;
        CodeU: Codeunit 50005;
        TextGMnt: Text[250];
        NomBanque: Text[150];
        RIB_DONNEUR_D_ORDRE__CaptionLbl: Label 'RIB DONNEUR D''ORDRE :';
        RAISON_SOCIALE__CaptionLbl: Label 'RAISON SOCIALE :';
        "RIB___RIP_Bénéficiaire__s_CaptionLbl": Label 'RIB / RIP Bénéficiaire (s)';
        BanqueCaptionLbl: Label 'Banque';
        "Nom___Prénom___Raison_socialeCaptionLbl": Label 'Nom & Prénom / Raison sociale';
        MontantCaptionLbl: Label 'Montant';
        MOTIF_DE_VIREMENT__CaptionLbl: Label 'MOTIF DE VIREMENT :';
        NombreCaptionLbl: Label 'Nombre';
        TotalCaptionLbl: Label 'Total';
        Total_en_toutes_lettres__CaptionLbl: Label 'Total en toutes lettres :';
        Important__CaptionLbl: Label 'Important :';
        "V1_Cet_Ordre_ne_sera_exécuté_que_si_la_situation_du_donneur_d_ordre_le_permet_CaptionLbl": Label '1-Cet Ordre ne sera exécuté que si la situation du donneur d''ordre le permet.';
        "V2__Le_donneur_d_ordre_dégage_d_ores": Label '2- Le donneur d''ordre dégage d''ores et déja la responsabilité de la banque pour la conséquence découlant du libellé d''un RIP / RIB erroné';
        Signature_du_ClientCaptionLbl: Label 'Signature du Client';
}

