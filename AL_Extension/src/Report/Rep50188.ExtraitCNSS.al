report 50188 "Extrait CNSS"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/ExtraitCNSS.rdlc';

    // dataset
    // {
    //     dataitem("Declaration Trimes salaires"; 52048919)
    //     {
    //         DataItemTableView = SORTING(Matricule, Année, Trimestre);
    //         RequestFilterFields = Matricule;
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column("CnssSociété"; CnssSociété)
    //         {
    //         }
    //         column("Declaration_Trimes_salaires__Nom_et_Prénom_"; "Nom et Prénom")
    //         {
    //         }
    //         column(CNSSEmploye; CNSSEmploye)
    //         {
    //         }
    //         column("FORMAT_Trimestre____tr_____FORMAT_Année_"; FORMAT(Trimestre) + ' tr / ' + FORMAT(Année))
    //         {
    //         }
    //         column(Declaration_Trimes_salaires__N__Page_; "N° Page")
    //         {
    //         }
    //         column(Declaration_Trimes_salaires__N__Ligne_; "N° Ligne")
    //         {
    //         }
    //         column(Declaration_Trimes_salaires__Total_Mantant_; "Total Mantant")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column("Declaration_Trimes_salaires__Nom_et_Prénom__Control1000000006"; "Nom et Prénom")
    //         {
    //         }
    //         column(ATTESTATION_DE_SALAIRES_DECLARESCaption; ATTESTATION_DE_SALAIRES_DECLARESCaptionLbl)
    //         {
    //         }
    //         column("Trimestre_et_annéeCaption"; Trimestre_et_annéeCaptionLbl)
    //         {
    //         }
    //         column("Salaires_déclarésCaption"; Salaires_déclarésCaptionLbl)
    //         {
    //         }
    //         column(PageCaption; PageCaptionLbl)
    //         {
    //         }
    //         column(LigneCaption; LigneCaptionLbl)
    //         {
    //         }
    //         column("IdentiéCaption"; IdentiéCaptionLbl)
    //         {
    //         }
    //         column("Je_soussigné_Caption"; Je_soussigné_CaptionLbl)
    //         {
    //         }
    //         column("employeur_affilié_à_la_Caisse_Nationale_sous_le_numéro_Caption"; employeur_affilié_à_la_Caisse_Nationale_sous_le_numéro_CaptionLbl)
    //         {
    //         }
    //         column(atteste_que_M_me_Caption; atteste_que_M_me_CaptionLbl)
    //         {
    //         }
    //         column("immatriculé_e__à_la_Caisse_Nationale_sous_le_numéro_Caption"; immatriculé_e__à_la_Caisse_Nationale_sous_le_numéro_CaptionLbl)
    //         {
    //         }
    //         column("a_été_occupé_e__à_mon_service_du___________________________au__________________________Caption"; a_été_occupé_e__à_mon_service_du___________________________au__________________________CaptionLbl)
    //         {
    //         }
    //         column("et_que_les_salaires_qu_il__elle__a_perçus_ont_été_portés_sur_les_déclarations_de_salaires_comme_suit__Caption"; et_que_les_salaires_qu_il__elle__a_perçus_ont_été_portés_sur_les_déclarations_de_salaires_comme_suit__CaptionLbl)
    //         {
    //         }
    //         column("telle_que_portée_sur_la_déclaration_de_salaires__Caption"; telle_que_portée_sur_la_déclaration_de_salaires__CaptionLbl)
    //         {
    //         }
    //         column(le______________________________________Caption; le______________________________________CaptionLbl)
    //         {
    //         }
    //         column(Signature_et_cachet_de_l_employeurCaption; Signature_et_cachet_de_l_employeurCaptionLbl)
    //         {
    //         }
    //         column(Declaration_Trimes_salaires_Matricule; Matricule)
    //         {
    //         }
    //         column("Declaration_Trimes_salaires_Année"; Année)
    //         {
    //         }
    //         column(Declaration_Trimes_salaires_Trimestre; Trimestre)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF RecEmployee.GET(Matricule) THEN;
    //             DateRecrutement := RecEmployee."Employment Date";
    //             CNSSEmploye := RecEmployee."Social Security No.";
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             RecCompanyInformation.GET;

    //             CnssSociété := RecCompanyInformation."N° CNSS";
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
    //     RecCompanyInformation: Record 79;
    //     "CnssSociété": Text[30];
    //     "CnssEmployé": Text[30];
    //     DateRecrutement: Date;
    //     RecEmployee: Record 5200;
    //     CNSSEmploye: Text[30];
    //     ATTESTATION_DE_SALAIRES_DECLARESCaptionLbl: Label 'ATTESTATION DE SALAIRES DECLARES';
    //     "Trimestre_et_annéeCaptionLbl": Label 'Trimestre et année';
    //     "Salaires_déclarésCaptionLbl": Label 'Salaires déclarés';
    //     PageCaptionLbl: Label 'Page';
    //     LigneCaptionLbl: Label 'Ligne';
    //     "IdentiéCaptionLbl": Label 'Identié';
    //     "Je_soussigné_CaptionLbl": Label 'Je soussigné ';
    //     "employeur_affilié_à_la_Caisse_Nationale_sous_le_numéro_CaptionLbl": Label 'employeur affilié à la Caisse Nationale sous le numéro ';
    //     atteste_que_M_me_CaptionLbl: Label 'atteste que M(me)';
    //     "immatriculé_e__à_la_Caisse_Nationale_sous_le_numéro_CaptionLbl": Label 'immatriculé(e) à la Caisse Nationale sous le numéro ';
    //     "a_été_occupé_e__à_mon_service_du___________________________au__________________________CaptionLbl": Label 'a été occupé(e) à mon service du ..........................au..........................';
    //     "et_que_les_salaires_qu_il__elle__a_perçus_ont_été_portés_sur_les_déclarations_de_salaires_comme_suit__CaptionLbl": Label 'et que les salaires qu''il (elle) a perçus ont été portés sur les déclarations de salaires comme suit :';
    //     "telle_que_portée_sur_la_déclaration_de_salaires__CaptionLbl": Label 'Identié  ( telle que portée sur la déclaration de salaires )';
    //     le______________________________________CaptionLbl: Label '.......................................le......................................';
    //     Signature_et_cachet_de_l_employeurCaptionLbl: Label 'Signature et cachet de l''employeur';
}

