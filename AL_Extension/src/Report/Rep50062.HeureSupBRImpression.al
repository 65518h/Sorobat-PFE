report 50062 "Heure Sup BR Impression"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HeureSupBRImpression.rdlc';

    dataset
    {
        dataitem("BR Heure Suplémentaire"; 50035)
        {
            DataItemTableView = SORTING(Affectation, Mois, Annee, Maticule);
            RequestFilterFields = Affectation, Mois, Annee;
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column("BR_Heure_Suplémentaire__Deccription_Affectation_"; "Deccription Affectation")
            {
            }
            column("BR_Heure_Suplémentaire_Mois"; Mois)
            {
            }
            column("BR_Heure_Suplémentaire_Annee"; Annee)
            {
            }
            column("BR_Heure_Suplémentaire_Maticule"; Maticule)
            {
            }
            column("BR_Heure_Suplémentaire__Nombre_Heure_Suplémentaire_"; "Nombre Heure Suplémentaire")
            {
            }
            column("BR_Heure_Suplémentaire__Net_A_Payer_"; "Net A Payer")
            {
            }
            column("BR_Heure_Suplémentaire_Salarié"; Salarié)
            {
            }
            column("BR_Heure_Suplémentaire__Description_Qualification_"; "Description Qualification")
            {
            }
            column(Nbre; Nbre)
            {
            }
            column(TotalFor___FIELDCAPTION_Affectation_; TotalFor + FIELDCAPTION(Affectation))
            {
            }
            column("BR_Heure_Suplémentaire__Nombre_Heure_Suplémentaire__Control1000000030"; "Nombre Heure Suplémentaire")
            {
            }
            column("BR_Heure_Suplémentaire__Net_A_Payer__Control1000000031"; "Net A Payer")
            {
            }
            column(Nbre_Control1000000037; Nbre)
            {
            }
            column("Heures_Supplémentaires_Mois_de_Caption"; Heures_Supplémentaires_Mois_de_CaptionLbl)
            {
            }
            column(AffectationCaption; AffectationCaptionLbl)
            {
            }
            column("BR_Heure_Suplémentaire_MaticuleCaption"; FIELDCAPTION(Maticule))
            {
            }
            column(Nbre_HS_BCaption; Nbre_HS_BCaptionLbl)
            {
            }
            column("BR_Heure_Suplémentaire__Net_A_Payer_Caption"; BR_Heure_Suplémentaire__Net_A_Payer_CaptionLbl)
            {
            }
            column("Nom_et_PrénomCaption"; Nom_et_PrénomCaptionLbl)
            {
            }
            column(QualificationCaption; QualificationCaptionLbl)
            {
            }
            column(EmargementCaption; EmargementCaptionLbl)
            {
            }
            column(SERVICE_GRHCaption; SERVICE_GRHCaptionLbl)
            {
            }
            column(Direction_AdministrativeCaption; Direction_AdministrativeCaptionLbl)
            {
            }
            column("Direction_GénéraleCaption"; Direction_GénéraleCaptionLbl)
            {
            }
            column("BR_Heure_Suplémentaire_Affectation"; Affectation)
            {
            }

            trigger OnAfterGetRecord()
            var
                rfere: Report 10808;
            begin
                // PrintToExcel THEN
                //BEGIN
                //MakeExcelDataHeader;
                //END;

                // IF PrintToExcel THEN BEGIN
                //     MakeExcelDataBody;
                // END;
                Nbre := 0;
                Nbre := Nbre + 1;
            end;

            trigger OnPostDataItem()
            begin
                // IF PrintToExcel THEN BEGIN
                //     CreateExcelbook;
                // END;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Affectation);
                IF PrintToExcel THEN BEGIN
                    MakeExcelDataHeader;
                END;
                // IF PrintToExcel THEN BEGIN
                //     MakeExcelDataBody;
                // END;
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
        PageConst: Label 'Page';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total ';
        Nbre: Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record 370 temporary;
        Text001: Label 'Données';
        Text002: Label 'Detail Mensuelle De Paie Enreg';
        Text003: Label 'Nom de la société';
        Text004: Label 'N° état';
        Text005: Label 'Nom état';
        Text006: Label 'Code utilisateur';
        Text007: Label 'Date';
        "Heures_Supplémentaires_Mois_de_CaptionLbl": Label 'Heures Supplémentaires Mois de ';
        AffectationCaptionLbl: Label 'Affectation';
        Nbre_HS_BCaptionLbl: Label 'Nbre HS/B';
        "BR_Heure_Suplémentaire__Net_A_Payer_CaptionLbl": Label 'Montant';
        "Nom_et_PrénomCaptionLbl": Label 'Nom et Prénom';
        QualificationCaptionLbl: Label 'Qualification';
        EmargementCaptionLbl: Label 'Emargement';
        SERVICE_GRHCaptionLbl: Label 'SERVICE GRH';
        Direction_AdministrativeCaptionLbl: Label 'Direction Administrative';
        "Direction_GénéraleCaptionLbl": Label 'Direction Générale';

    // [Scope('Internal')]
    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text003), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(REPORT::"Solde Pret", FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', 0);
        //ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('N°', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Nom & Prenom', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Qualification', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('NBR/HS', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('MONTANT', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    end;

    // [Scope('Internal')]
    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("BR Heure Suplémentaire".Maticule, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("BR Heure Suplémentaire".Salarié, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("BR Heure Suplémentaire"."Description Qualification", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("BR Heure Suplémentaire"."Nombre Heure Suplémentaire", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("BR Heure Suplémentaire"."Net A Payer", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    end;

    // [Scope('Internal')]
    procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBook('Heure Sup BR Impression');
        // //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        // ExcelBuf.GiveUserControl;
        ERROR('');
    end;
}