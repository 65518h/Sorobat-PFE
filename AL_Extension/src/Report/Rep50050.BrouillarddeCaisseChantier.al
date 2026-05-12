report 50050 "Brouillard de Caisse Chantier"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BrouillarddeCaisseChantier.rdlc';

    dataset
    {
        dataitem("Payment Line"; 10866)
        {
            DataItemTableView = SORTING("No.", "Line No.");
            RequestFilterFields = "No.", "Compte Entete";
            /* column(Payment_Line__No__; "No.")
             {
             }
             column(CurrReport_PAGENO; CurrReport.PAGENO)
             {
             }
             column("Date_Journée______Journecaisse"; 'Page : ')
             {
             }

             column(Payment_Line_Commentaires; Commentaires)
             {
             }
             column(Payment_Line_Amount; Amount)
             {
             }
             column(Cumul; Cumul)
             {
                 DecimalPlaces = 0 : 0;
             }
             column(Payment_Line__Due_Date_; "Due Date")
             {
             }
             column(Payment_Line__Numero_Seq_; "Numero Seq")
             {
             }
             column(Payment_Line_Benificiaire; Benificiaire)
             {
             }
             column(Payment_Line__Motif_Depense_Ex_; "Motif Depense Ex")
             {
             }
             column(Payment_Line__No___Control1000000002; "No.")
             {
             }
             column(Cumul_Control1000000003; Cumul)
             {
             }
             column(Brouillard_de_caisse_n_Caption; Brouillard_de_caisse_n_CaptionLbl)
             {
             }
             column(PAGE__Caption; PAGE__CaptionLbl)
             {
             }
             column(CompteCaption; CompteCaptionLbl)
             {
             }
             column(MontantCaption; MontantCaptionLbl)
             {
             }
             column(ObjetCaption; ObjetCaptionLbl)
             {
             }
             column(N__Caption; N__CaptionLbl)
             {
             }
             column(CumulCaption; CumulCaptionLbl)
             {
             }
             column(DateCaption; DateCaptionLbl)
             {
             }
             column("BénèficiaireCaption"; BénèficiaireCaptionLbl)
             {
             }
             column(Payment_Line__Motif_Depense_Ex_Caption; FIELDCAPTION("Motif Depense Ex"))
             {
             }
             column(TOTAL_BROUILLARD_N__Caption; TOTAL_BROUILLARD_N__CaptionLbl)
             {
             }
             column(Le_CaissierCaption; Le_CaissierCaptionLbl)
             {
             }
             column("Contrôle_de_gestionCaption"; Contrôle_de_gestionCaptionLbl)
             {
             }
             column(Le_directeur_de_projetCaption; Le_directeur_de_projetCaptionLbl)
             {
             }
             column(Payment_Line_Line_No_; "Line No.")
             {
             }*/

            column(Payment_Line__No__; "No.")
            {
            }
            column("Date_Journée______Journecaisse"; 'Page : ')
            {
            }
            column("NumeroSeq"; "Numero Seq")
            {

            }
            column("Payment_Line_Libellé"; Libellé)
            {
            }
            column(Benificiaire; Benificiaire) { }
            column(Payment_Line__Payment_Line___Nom_Benificiaire_; "Payment Line"."Nom Benificiaire")
            {
            }
            column(Payment_Line__Payment_Line___Debit_Amount_; "Payment Line"."Debit Amount")
            {
            }
            column(Payment_Line__Due_Date_; "Due Date")
            {
            }
            column(Payment_Line_Benificiaire; Benificiaire)
            {
            }
            column(Payment_Line__Payment_Line___Credit_Amount_; "Payment Line"."Credit Amount")
            {
            }
            column(Payment_Line__Payment_Line___Credit_Amount__Control1000000047; "Payment Line"."Credit Amount")
            {
            }
            column(Payment_Line__Payment_Line___Debit_Amount__Control1000000048; "Payment Line"."Debit Amount")
            {
            }
            column(Amount; Amount) { }
            column("Journée_de_caisse_n_Caption"; Journée_de_caisse_n_CaptionLbl)
            {
            }
            column(RecetteCaption; RecetteCaptionLbl)
            {
            }
            column("Nature_OpérationCaption"; Nature_OpérationCaptionLbl)
            {
            }
            column("DépenseCaption"; DépenseCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(MatriculeCaption; MatriculeCaptionLbl)
            {
            }
            column(NomCaption; NomCaptionLbl)
            {
            }
            column(TOTAL_JOURNEE__Caption; TOTAL_JOURNEE__CaptionLbl)
            {
            }
            column(Le_CaissierCaption; Le_CaissierCaptionLbl)
            {
            }
            column("Contrôle_de_gestionCaption"; Contrôle_de_gestionCaptionLbl)
            {
            }
            column(Le_directeur_financierCaption; Le_directeur_financierCaptionLbl)
            {
            }
            column("ComptabilitéCaption"; ComptabilitéCaptionLbl)
            {
            }
            column(Commentaires; Commentaires) { }

            column(Payment_Line_Line_No_; "Line No.")
            {
            }
            column(Motif_Depense_Ex; "Motif Depense Ex") { }
            column(Cumul; Cumul) { }
            trigger OnAfterGetRecord()
            begin

                PaymentHeader.RESET;
                PaymentHeader.SETRANGE(PaymentHeader."No.", "Payment Line"."No.");
                IF PaymentHeader.FINDFIRST THEN Journecaisse := FORMAT(PaymentHeader."Document Date");
                Cumul += Amount;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
                CurrReport.CREATETOTALS("Payment Line"."Credit Amount", "Payment Line"."Debit Amount");
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
        Journecaisse: Text[30];
        PaymentHeader: Record 10865;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cumul: Decimal;
        Brouillard_de_caisse_n_CaptionLbl: Label 'Brouillard de caisse n°';
        PAGE__CaptionLbl: Label 'PAGE :';
        CompteCaptionLbl: Label 'Compte';
        MontantCaptionLbl: Label 'Montant';
        ObjetCaptionLbl: Label 'Objet';
        N__CaptionLbl: Label 'N° ';
        CumulCaptionLbl: Label 'Cumul';
        DateCaptionLbl: Label 'Date';
        "BénèficiaireCaptionLbl": Label 'Bénèficiaire';
        TOTAL_BROUILLARD_N__CaptionLbl: Label 'TOTAL BROUILLARD N° ';
        Le_CaissierCaptionLbl: Label 'Le Caissier';
        "Contrôle_de_gestionCaptionLbl": Label 'Contrôle de gestion';
        Le_directeur_de_projetCaptionLbl: Label 'Le directeur de projet';
        "ComptabilitéCaptionLbl": Label 'Comptabilité';
        Le_directeur_financierCaptionLbl: Label 'Le directeur financier';
        NomCaptionLbl: Label 'Nom';
        "Journée_de_caisse_n_CaptionLbl": Label 'Brouillard de caisse n°';
        RecetteCaptionLbl: Label 'Recette';
        "Nature_OpérationCaptionLbl": Label 'Nature Opération';
        "DépenseCaptionLbl": Label 'Dépense';

        MatriculeCaptionLbl: Label 'Matricule';

        TOTAL_JOURNEE__CaptionLbl: Label 'TOTAL JOURNEE :';

        "Directeur_GénèraleCaptionLbl": Label 'Directeur Génèrale';
}

