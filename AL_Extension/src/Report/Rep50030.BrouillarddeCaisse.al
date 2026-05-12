report 50030 "Brouillard de Caisse"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BrouillarddeCaisse.rdlc';

    dataset
    {
        dataitem("Payment Line"; 10866)
        {
            DataItemTableView = SORTING("No.", "Line No.");
            // RequestFilterFields = "No.", "Field50013", "Type Caisse";
            // JBS
            RequestFilterFields = "No.", "Compte Entete";

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
            column("Directeur_GénèraleCaption"; Directeur_GénèraleCaptionLbl)
            {
            }
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cumul: Decimal;
        PaymentHeader: Record 10865;
        Journecaisse: Text[30];
        Extracomptable: Text[50];
        "Journée_de_caisse_n_CaptionLbl": Label 'Brouillard de caisse n°';
        RecetteCaptionLbl: Label 'Recette';
        "Nature_OpérationCaptionLbl": Label 'Nature Opération';
        "DépenseCaptionLbl": Label 'Dépense';
        DateCaptionLbl: Label 'Date';
        MatriculeCaptionLbl: Label 'Matricule';
        NomCaptionLbl: Label 'Nom';
        TOTAL_JOURNEE__CaptionLbl: Label 'TOTAL JOURNEE :';
        Le_CaissierCaptionLbl: Label 'Le Caissier';
        "Contrôle_de_gestionCaptionLbl": Label 'Contrôle de gestion';
        Le_directeur_financierCaptionLbl: Label 'Le directeur financier';
        "ComptabilitéCaptionLbl": Label 'Comptabilité';
        "Directeur_GénèraleCaptionLbl": Label 'Directeur Génèrale';
}

