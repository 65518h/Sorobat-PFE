report 50239 "Recap Paies Compta"
{
    // //  if copystr("Rec. Salary Lines"."catégorie",1,2)='SV' THEN
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/RecapPaiesCompta.rdl';


    // dataset
    // {
    //     dataitem("Rec. Salary Lines"; "Rec. Salary Lines")
    //     {
    //         DataItemTableView = SORTING("No.", Employee);
    //         RequestFilterFields = "No.";
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(DecTotMontDirect; DecTotMontDirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecTotMontIndirect; DecTotMontIndirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(AnneeRecap; AnneeRecap)
    //         {
    //             //  DecimalPlaces = 0 : 0;
    //         }
    //         column(MoisRecap; MoisRecap)
    //         {
    //             // DecimalPlaces = 0 : 0;
    //         }
    //         column(DecTotEffecIndirect; DecTotEffecIndirect)
    //         {
    //             DecimalPlaces = 0 : 0;
    //         }
    //         column(DecTotEffecDirect; DecTotEffecDirect)
    //         {
    //             DecimalPlaces = 0 : 0;
    //         }
    //         column(CompanyInformation_Name; CompanyInformation.Name)
    //         {
    //         }
    //         column(DecTotEffec; DecTotEffec)
    //         {
    //             DecimalPlaces = 0 : 0;
    //         }
    //         column(Recap__de_PaieCaption; Recap__de_PaieCaptionLbl)
    //         {
    //         }
    //         column(Indirects__Caption; Indirects__CaptionLbl)
    //         {
    //         }
    //         column(Directs__Caption; Directs__CaptionLbl)
    //         {
    //         }
    //         column(IndirectCaption; IndirectCaptionLbl)
    //         {
    //         }
    //         column(DirectCaption; DirectCaptionLbl)
    //         {
    //         }
    //         column(RUBRIQUESCaption; RUBRIQUESCaptionLbl)
    //         {
    //         }
    //         column(TOTAUXCaption; TOTAUXCaptionLbl)
    //         {
    //         }
    //         column(Service_du_PersonnelsCaption; Service_du_PersonnelsCaptionLbl)
    //         {
    //         }
    //         column(CreditCaption; CreditCaptionLbl)
    //         {
    //         }
    //         column(DebitCaption; DebitCaptionLbl)
    //         {
    //         }
    //         column("DésignationCaption"; DésignationCaptionLbl)
    //         {
    //         }
    //         column(Total_Effectif__Caption; Total_Effectif__CaptionLbl)
    //         {
    //         }
    //         column(CodeCaption; CodeCaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_No_; "No.")
    //         {
    //         }
    //         column(Rec__Salary_Lines_Employee; Employee)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF "Employee's type" = "Employee's type"::"Hour based" THEN BEGIN
    //                 DecAppointement += "Rec. Salary Lines"."Real basis salary";
    //             END
    //             ELSE BEGIN
    //                 DecSalaireBase += "Rec. Salary Lines"."Real basis salary";
    //             END;
    //             //
    //             "Rec. Salary Lines".CALCFIELDS("Type Contrat Employee");

    //             IF COPYSTR("Rec. Salary Lines".Catégorie, 1, 2) = 'SV' THEN BEGIN
    //                 DecSalireBrutIndirect += "Rec. Salary Lines"."Gross Salary";
    //                 DecCNSSIndirect += "Rec. Salary Lines".CNSS;
    //                 DecSalireImposIndirect += "Rec. Salary Lines"."Taxable salary";
    //                 DecImpotIndirect += "Rec. Salary Lines"."Taxe (Month)";
    //                 DecContributionIndirect += "Rec. Salary Lines"."Contribution Social";
    //                 DecRedevIndirect += "Rec. Salary Lines"."Taxe Redevance";
    //                 DecSalireNetIndirect += "Rec. Salary Lines"."Net salary cashed";

    //                 //DecTotEffecIndirect+= 1;
    //                 DecTotMontIndirect += "Rec. Salary Lines"."Gross Salary" + "Rec. Salary Lines".CNSS + "Rec. Salary Lines"."Taxable salary"
    //                                      + "Rec. Salary Lines"."Taxe (Month)" + "Rec. Salary Lines"."Taxe Redevance"
    //                                      + "Rec. Salary Lines"."Net salary";
    //             END
    //             ELSE BEGIN
    //                 //IF "Rec. Salary Lines".CNSS<>0 THEN
    //                 DecSalireBrutDirect += "Rec. Salary Lines"."Gross Salary";
    //                 DecCNSSDirect += "Rec. Salary Lines".CNSS;
    //                 DecSalireImposDirect += "Rec. Salary Lines"."Taxable salary";
    //                 DecImpotDirect += "Rec. Salary Lines"."Taxe (Month)";
    //                 DecContributionDirect += "Rec. Salary Lines"."Contribution Social";
    //                 DecRedevDirect += "Rec. Salary Lines"."Taxe Redevance";
    //                 DecSalireNetDirect += "Rec. Salary Lines"."Net salary cashed";

    //                 //DecTotEffecDirect := DecTotEffecDirect + 1;
    //                 DecTotMontDirect += "Rec. Salary Lines"."Gross Salary" + "Rec. Salary Lines".CNSS + "Rec. Salary Lines"."Taxable salary"
    //                                      + "Rec. Salary Lines"."Taxe (Month)" + "Rec. Salary Lines"."Taxe Redevance"
    //                                      + "Rec. Salary Lines"."Net salary";
    //             END;
    //             DecSommSalireBrut := DecSalireBrutDirect + DecSalireBrutIndirect;
    //             DecSommCNSS := DecCNSSDirect + DecCNSSIndirect;
    //             DecSommSalireImpos := DecSalireImposDirect + DecSalireImposIndirect;
    //             DecSommImpot := DecImpotDirect + DecImpotIndirect;
    //             DecSommeContribution := DecContributionDirect + DecContributionIndirect;
    //             DecSommRedev := DecRedevDirect + DecRedevIndirect;
    //             DecSommSalireNet := DecSalireNetDirect + DecSalireNetIndirect;
    //             //
    //             DecAvance += "Rec. Salary Lines".Advances;
    //             DecArrondissPositif += "Rec. Salary Lines"."Ajout  en +";
    //             DecArrondissNegatif += "Rec. Salary Lines"."Report en -";

    //             // A COMPLITER PAR Mahdi Merci
    //             DecTotCredit := DecSommCNSS + DecSommImpot + DecSommeContribution + DecSommRedev + DecAvance + DecArrondissNegatif + DecSommSalireNet +
    //             DecPretCNSSLog + DecPretCNSSVoit + DecPretSoc + DecCessionSalaire + DecRetenuePres;
    //             //------
    //             DecTotDebit := DecAppointement + DecSalaireBase + DecPrimePres + DecIndTransp + DecPrimeDouche + DecIndDeplac + DecIndPanier + DecIndLogement +
    //             DecPrimeEncourag + DecPrimePoussiere + DecPrimeTech + DecPrimeCaisse + DecPrimeFonct + DecPrimeExcept + DecPrimeSpecial +
    //             DecPrimeAssid + DecPrimeRespons + DecPrimeEntret + DecPrimeAstreinte + DecPrimeLait + DecPrimeEnrobe + DecPrimeDiversDirect +
    //             DecSommSalireBrut + DecSommSalireImpos + DecArrondissPositif + DecRappel + DecMajorationDim + DecJourSupp + DecJoursFerie +
    //             DecCongeAnnuel + DecCongeExcept + DecComplementSalaire + DecForfaitHS + DecHeursSupp75 + DecHeursNormalPlus;
    //             //DecPretCNSSLog+= "Rec. Salary Lines".Loans

    //             /*
    //             IF CurrReport.TOTALSCAUSEDBY = "Rec. Salary Lines".FIELDNO("No.") THEN BEGIN
    //                                 "Rec. Salary Lines".CALCSUMS("Gross Salary", "Taxe Redevance");
    //                             END;
    //             */
    //             IF CompanyInformation.GET THEN;
    //             IF RecSalaryHeader.GET("Rec. Salary Lines"."No.") THEN;
    //             MoisRecap := FORMAT(RecSalaryHeader.Month);
    //             AnneeRecap := RecSalaryHeader.Year;
    //             IF RecSalaryHeader.Month = 0 THEN MoisRecap := 'Janvier';
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             IF "Rec. Salary Lines".GETFILTER("No.") = '' THEN
    //                 ERROR('Vous devez Selectionner un numero de Paie');
    //             UserNoPaie := "Rec. Salary Lines".GETFILTER("No.");
    //             DecTotEffec := "Rec. Salary Lines".COUNT;
    //             //
    //             RecNombSalarie.SETRANGE("No.", UserNoPaie);
    //             IF RecNombSalarie.FINDFIRST THEN
    //                 REPEAT
    //                     RecNombSalarie.CALCFIELDS("Type Contrat Employee");
    //                     IF COPYSTR("Rec. Salary Lines".Catégorie, 1, 2) = 'SV' THEN
    //                         DecTotEffecIndirect += 1
    //                     ELSE
    //                         DecTotEffecDirect := DecTotEffecDirect + 1;
    //                 UNTIL RecNombSalarie.NEXT = 0;
    //             //


    //             RecIndemnities.RESET;
    //             RecIndemnities.SETRANGE("No.", UserNoPaie);
    //             IF RecIndemnities.FINDFIRST THEN
    //                 REPEAT
    //                     IF RecIndemnities.Indemnity = '201' THEN DecPrimePres += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '003' THEN DecIndTransp += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '204' THEN DecPrimeDouche += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '106' THEN DecIndDeplac += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '103' THEN DecIndPanier += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '115' THEN DecIndLogement += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '997' THEN DecPrimeEncourag += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '208' THEN DecPrimePoussiere += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '215' THEN DecPrimeTech += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '440' THEN DecPrimeCaisse += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '203' THEN DecPrimeFonct += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '996' THEN DecPrimeExcept += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '990' THEN DecPrimeSpecial += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '998' THEN DecPrimeAssid += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '995' THEN DecPrimeRespons += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '999' THEN DecPrimeEntret += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '448' THEN DecPrimeAstreinte += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '987' THEN DecPrimeLait += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '994' THEN DecPrimeEnrobe += RecIndemnities."Real Amount";
    //                     IF RecIndemnities.Indemnity = '209' THEN DecPrimeDiversDirect += RecIndemnities."Real Amount";
    //                 // IF RecIndemnities.Indemnity = '106' THEN DecIndDeplac+= RecIndemnities."Real Amount";
    //                 // IF RecIndemnities.Indemnity = '107' THEN DecComplementSalaire+= RecIndemnities."Real Amount";
    //                 UNTIL RecIndemnities.NEXT = 0;

    //             RecDetailComplement.RESET;
    //             RecDetailComplement.SETRANGE("Paiement No.", UserNoPaie);
    //             IF RecDetailComplement.FINDFIRST THEN
    //                 REPEAT
    //                     DecComplementSalaire += RecDetailComplement."Montant Complement";
    //                 UNTIL RecDetailComplement.NEXT = 0;

    //             RecHeuresSupEnrg.RESET;
    //             RecHeuresSupEnrg.SETRANGE("Paiement No.", UserNoPaie);
    //             IF RecHeuresSupEnrg.FINDFIRST THEN
    //                 REPEAT
    //                     IF RecHeuresSupEnrg."Type Jours" = RecHeuresSupEnrg."Type Jours"::"Congé Annuelle" THEN
    //                         DecCongeAnnuel += RecHeuresSupEnrg."Montant Ligne";
    //                     IF RecHeuresSupEnrg."Type Jours" = RecHeuresSupEnrg."Type Jours"::"Jour(s) Ferie(s)" THEN
    //                         DecJoursFerie += RecHeuresSupEnrg."Montant Ligne";
    //                     IF RecHeuresSupEnrg."Type Jours" = RecHeuresSupEnrg."Type Jours"::"Congé Exceptionnel" THEN
    //                         DecCongeExcept += RecHeuresSupEnrg."Montant Ligne";
    //                     IF RecHeuresSupEnrg."Type Jours" = RecHeuresSupEnrg."Type Jours"::"Heures Retenues" THEN
    //                         DecRetenuePres += RecHeuresSupEnrg."Montant Ligne";
    //                     IF RecHeuresSupEnrg."Type Jours" = RecHeuresSupEnrg."Type Jours"::Normal THEN
    //                         DecHeursNormalPlus += RecHeuresSupEnrg."Montant Ligne";
    //                     IF RecHeuresSupEnrg."Type Jours" = RecHeuresSupEnrg."Type Jours"::"Heure Maj 75%" THEN
    //                         DecHeursSupp75 += RecHeuresSupEnrg."Montant Ligne";
    //                     IF RecHeuresSupEnrg."Type Jours" = RecHeuresSupEnrg."Type Jours"::"Jours Supp Maj 75%" THEN
    //                         DecJourSupp += RecHeuresSupEnrg."Montant Ligne";

    //                 /*
    //                 DecForfaitHS+= ????
    //                 DecMajorationDim+= ????;

    //                 */
    //                 UNTIL RecHeuresSupEnrg.NEXT = 0;

    //             RecHeuresOcca.RESET;
    //             RecHeuresOcca.SETRANGE("Paiement No.", UserNoPaie);
    //             IF RecHeuresOcca.FINDFIRST THEN
    //                 REPEAT
    //                     DecRappel += RecHeuresOcca.Rappel;
    //                     DecCessionSalaire += RecHeuresOcca.Cession;
    //                 UNTIL RecHeuresOcca.NEXT = 0;

    //             /*
    //             RecHeuresSup.RESET;
    //             RecHeuresSup.SETRANGE("Paiement No.",UserNoPaie);
    //             // ajouter un filter Type Pret ou avance
    //             IF RecPretAvance.FINDFIRST THEN
    //             REPEAT
    //                DecPretCNSSLog+= ????;
    //                DecPretCNSSVoit+= ????;
    //                DecPretSoc+= ????;
    //             UNTIL RecPretAvance.NEXT = 0;
    //             */
    //             //DecPretCNSSLog+= "Rec. Salary Lines".Loans

    //         end;
    //     }
    //     dataitem(Appontement; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecAppointement; DecAppointement)
    //         {
    //         }
    //         column(DecAppointement_Control1000000512; DecAppointement)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(AppointementCaption; AppointementCaptionLbl)
    //         {
    //         }
    //         column(V000Caption; V000CaptionLbl)
    //         {
    //         }
    //         column(Appontement_Number; Number)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecAppointement = 0 THEN
    //                 CurrReport.Skip();
    //             //  CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(SalairedeBase; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecSalaireBase; DecSalaireBase)
    //         {
    //         }
    //         column(DecSalaireBase_Control1000000521; DecSalaireBase)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Salaire_de_BaseCaption; Salaire_de_BaseCaptionLbl)
    //         {
    //         }
    //         column(V001Caption; V001CaptionLbl)
    //         {
    //         }
    //         column(SalairedeBase_Number; Number)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecSalaireBase = 0 THEN
    //                 CurrReport.Skip();
    //             // CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(SalaireBrut; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecSommSalireBrut; DecSommSalireBrut)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecSalireBrutIndirect; DecSalireBrutIndirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecSalireBrutDirect; DecSalireBrutDirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(SALAIRE_BRUTCaption; SALAIRE_BRUTCaptionLbl)
    //         {
    //         }
    //         column(V650Caption; V650CaptionLbl)
    //         {
    //         }
    //         column(SalaireBrut_Number; Number)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin
    //             //  Message(Format(DecSommSalireBrut));

    //             IF DecSommSalireBrut = 0 THEN
    //                 CurrReport.Skip();
    //             // CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(CNSS; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecSommCNSS; DecSommCNSS)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecCNSSIndirect; DecCNSSIndirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecCNSSDirect; DecCNSSDirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(CNSSCaption; CNSSCaptionLbl)
    //         {
    //         }
    //         column(V463Caption; V463CaptionLbl)
    //         {
    //         }
    //         column(CNSS_Number; Number)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecSommCNSS = 0 THEN
    //                 CurrReport.Skip();
    //             // CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(SalaireImpsable; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecSommSalireImpos; DecSommSalireImpos)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecSalireImposIndirect; DecSalireImposIndirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecSalireImposDirect; DecSalireImposDirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Salaire_ImposableCaption; Salaire_ImposableCaptionLbl)
    //         {
    //         }
    //         column(V660Caption; V660CaptionLbl)
    //         {
    //         }
    //         column(SalaireImpsable_Number; Number)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecSommSalireImpos = 0 THEN
    //                 CurrReport.Skip();
    //             // CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(Impot; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecSommImpot; DecSommImpot)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecImpotIndirect; DecImpotIndirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecImpotDirect; DecImpotDirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(ImpotCaption; ImpotCaptionLbl)
    //         {
    //         }
    //         column(V436Caption; V436CaptionLbl)
    //         {
    //         }
    //         column(Impot_Number; Number)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecSommImpot = 0 THEN
    //                 CurrReport.Skip();
    //             // CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem("Contribution Social"; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecContributionDirect; DecContributionDirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecSommeContribution; DecSommeContribution)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecContributionIndirect; DecContributionIndirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Contribution_SocialCaption; Contribution_SocialCaptionLbl)
    //         {
    //         }
    //         column(Contribution_Social_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem("Redevance de Compensation"; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecSommRedev = 0 THEN
    //                 CurrReport.Skip();
    //             //      CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(Avance; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecAvance = 0 THEN
    //                 CurrReport.Skip();
    //             //      CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(ArrondPositif; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecArrondissPositif; DecArrondissPositif)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecArrondissPositif_Control1000000397; DecArrondissPositif)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Arrondissement____Caption; Arrondissement____CaptionLbl)
    //         {
    //         }
    //         column(V01Caption; V01CaptionLbl)
    //         {
    //         }
    //         column(ArrondPositif_Number; Number)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecArrondissPositif = 0 THEN
    //                 CurrReport.Skip();
    //             //      CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(ArrondNegatif; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecArrondissNegatif; DecArrondissNegatif)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecArrondissNegatif_Control1000000411; DecArrondissNegatif)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Arrondissement____Caption_Control1000000417; Arrondissement____Caption_Control1000000417Lbl)
    //         {
    //         }
    //         column(U01Caption; U01CaptionLbl)
    //         {
    //         }
    //         column(ArrondNegatif_Number; Number)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecArrondissNegatif = 0 THEN
    //                 CurrReport.Skip();
    //             //      CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(SalaireNet; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecSommSalireNet; DecSommSalireNet)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecSalireNetIndirect; DecSalireNetIndirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecSalireNetDirect; DecSalireNetDirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Salaire_NetCaption; Salaire_NetCaptionLbl)
    //         {
    //         }
    //         column(V425Caption; V425CaptionLbl)
    //         {
    //         }
    //         column(SalaireNet_Number; Number)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecSommSalireNet = 0 THEN
    //                 CurrReport.Skip();
    //             //      CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(PrimePresence; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecPrimePres = 0 THEN
    //                 CurrReport.Skip();
    //             //      CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(PrimeTransport; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecIndTransp = 0 THEN
    //                 CurrReport.Skip();
    //             //      CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(PrimeDouche; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecPrimeDouche = 0 THEN
    //                 CurrReport.Skip();
    //             //      CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(IndDeplacement; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecIndDeplac = 0 THEN
    //                 CurrReport.Skip();
    //             //      CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(IndPanier; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecIndPanier = 0 THEN
    //                 CurrReport.Skip();
    //             //      CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(IndLogement; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF DecIndLogement = 0 THEN
    //                 CurrReport.Skip();
    //             //      CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(PrimeEncouragement; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));

    //     }
    //     dataitem(PrimePoussiere; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PrimeTechnicite; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PrimeCaisse; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PrimeFonction; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PrimeExceptionnel; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PrimeSpecial; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PrimeAssiduite; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PrimeResponsabilite; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(Primentretien; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PrimeAstreinte; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PrimeLait; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PrimeEnrobe; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PrimeDiverse; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(ComplementSalaire; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(ForfaitHS; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(HeursSup75; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(HeursNormalPlus; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(MajorationDM; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(MontantJourSupp; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(JoursFerie; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(CongeAnnuel; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(CongeExcept; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(RetenuePresence; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(Rappel; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(CessionSalaire; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         trigger OnAfterGetRecord()
    //         begin

    //             DecPretSoc := 0;
    //             DecCessionSalaire := 0;
    //             DecPretCNSSLog := 0;
    //             DecPretCNSSVoit := 0;
    //             RecPretLine.RESET;
    //             RecPretLine.SETRANGE(RecPretLine."Payment No.", "Rec. Salary Lines"."No.");
    //             RecPretLine.SETRANGE(RecPretLine.Type, 1);
    //             IF RecPretLine.FINDFIRST() THEN
    //                 REPEAT
    //                     RecEntetePret.RESET;
    //                     IF RecEntetePret.GET(RecPretLine."No.") THEN BEGIN
    //                         IF RecEntetePret."Pret CNSS" = 0 THEN DecPretSoc += RecPretLine."Principal Amount";
    //                         IF RecEntetePret."Pret CNSS" = 1 THEN DecPretCNSSLog += RecPretLine."Principal Amount";
    //                         IF RecEntetePret."Pret CNSS" = 2 THEN DecPretCNSSVoit += RecPretLine."Principal Amount";
    //                         IF RecEntetePret."Pret CNSS" = 3 THEN DecCessionSalaire += RecPretLine."Principal Amount";
    //                     END

    //                 UNTIL RecPretLine.NEXT = 0;





    //             IF DecCessionSalaire = 0 THEN
    //                 CurrReport.Skip();
    //             //  CurrReport.SHOWOUTPUT(FALSE);
    //         end;
    //     }
    //     dataitem(PretCNSSLog; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PretCNSSVoit; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(PretSocite; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //     }
    //     dataitem(TOTAUX; Integer)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecTotCredit; DecTotCredit)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecTotDebit; DecTotDebit)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(TOTAUXCaption_Control1000000373; TOTAUXCaption_Control1000000373Lbl)
    //         {
    //         }
    //         column(TOTAUX_Number; Number)
    //         {
    //         }
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

    // trigger OnPreReport()
    // begin
    //     IF CurrReport.PAGENO = 1 THEN
    //         CurrReport.SHOWOUTPUT(FALSE);
    // end;

    // var
    //     UserNoPaie: Code[10];
    //     DecAppointement: Decimal;
    //     DecSalaireBase: Decimal;
    //     DecSalireBrutDirect: Decimal;
    //     DecSalireBrutIndirect: Decimal;
    //     DecSommSalireBrut: Decimal;
    //     DecCNSSDirect: Decimal;
    //     DecCNSSIndirect: Decimal;
    //     DecSommCNSS: Decimal;
    //     DecSalireImposDirect: Decimal;
    //     DecSalireImposIndirect: Decimal;
    //     DecSommSalireImpos: Decimal;
    //     DecImpotDirect: Decimal;
    //     DecImpotIndirect: Decimal;
    //     DecContributionDirect: Decimal;
    //     DecContributionIndirect: Decimal;
    //     DecSommeContribution: Decimal;
    //     DecSommImpot: Decimal;
    //     DecRedevDirect: Decimal;
    //     DecRedevIndirect: Decimal;
    //     DecSommRedev: Decimal;
    //     DecAvance: Decimal;
    //     DecArrondissPositif: Decimal;
    //     DecArrondissNegatif: Decimal;
    //     DecSalireNetDirect: Decimal;
    //     DecSalireNetIndirect: Decimal;
    //     DecSommSalireNet: Decimal;
    //     RecIndemnities: Record "Rec. Indemnities";
    //     DecPrimePres: Decimal;
    //     DecIndTransp: Decimal;
    //     DecPrimeDouche: Decimal;
    //     DecIndDeplac: Decimal;
    //     DecIndPanier: Decimal;
    //     DecIndLogement: Decimal;
    //     DecPrimeEncourag: Decimal;
    //     DecPrimePoussiere: Decimal;
    //     DecPrimeTech: Decimal;
    //     DecPrimeCaisse: Decimal;
    //     DecPrimeFonct: Decimal;
    //     DecPrimeExcept: Decimal;
    //     DecPrimeSpecial: Decimal;
    //     DecPrimeAssid: Decimal;
    //     DecPrimeRespons: Decimal;
    //     DecPrimeEntret: Decimal;
    //     DecPrimeAstreinte: Decimal;
    //     DecPrimeLait: Decimal;
    //     DecPrimeEnrobe: Decimal;
    //     DecPrimeDiversDirect: Decimal;
    //     DecPrimeDiversIndirect: Decimal;
    //     DecSommePrimeDivers: Decimal;
    //     RecDetailComplement: Record "Detail Complement";
    //     DecComplementSalaire: Decimal;
    //     RecHeuresSupEnrg: Record "Heures sup. eregistrées m";
    //     DecForfaitHS: Decimal;
    //     DecHeursSupp75: Decimal;
    //     DecHeursNormalPlus: Decimal;
    //     DecMajorationDim: Decimal;
    //     DecJourSupp: Decimal;
    //     DecJoursFerie: Decimal;
    //     DecCongeAnnuel: Decimal;
    //     DecCongeExcept: Decimal;
    //     DecRetenuePres: Decimal;
    //     RecHeuresOcca: Record "Heures occa. enreg. m";
    //     DecRappel: Decimal;
    //     DecCessionSalaire: Decimal;
    //     RecHeuresSup: Record "Heures sup. m";
    //     RecPretAvance: Record "Loan & Advance Lines";
    //     DecPretCNSSLog: Decimal;
    //     DecPretCNSSVoit: Decimal;
    //     DecPretSoc: Decimal;
    //     DecTotEffec: Decimal;
    //     DecTotEffecDirect: Decimal;
    //     DecTotEffecIndirect: Decimal;
    //     DecTotMontDirect: Decimal;
    //     DecTotMontIndirect: Decimal;
    //     DecTotHeuresPrestees: Decimal;
    //     DecTotDebit: Decimal;
    //     DecTotCredit: Decimal;
    //     CompanyInformation: Record 79;
    //     PageConst: Label 'Page';
    //     RecSalaryHeader: Record "Rec. Salary Headers";
    //     MoisRecap: Text[30];
    //     AnneeRecap: Integer;
    //     RecNombSalarie: Record "Rec. Salary Lines";
    //     RecPretLogement: Record "Loan & Advance Header";
    //     RecEntetePret: Record "Loan & Advance Header";
    //     RecPretLine: Record "Loan & Advance Lines";
    //     Recap__de_PaieCaptionLbl: Label 'Recap. de Paie';
    //     Indirects__CaptionLbl: Label 'Indirects :';
    //     Directs__CaptionLbl: Label 'Directs :';
    //     IndirectCaptionLbl: Label 'Indirect';
    //     DirectCaptionLbl: Label 'Direct';
    //     RUBRIQUESCaptionLbl: Label 'RUBRIQUES';
    //     TOTAUXCaptionLbl: Label 'TOTAUX';
    //     Service_du_PersonnelsCaptionLbl: Label 'Service du Personnels';
    //     CreditCaptionLbl: Label 'Credit';
    //     DebitCaptionLbl: Label 'Debit';
    //     "DésignationCaptionLbl": Label 'Désignation';
    //     Total_Effectif__CaptionLbl: Label 'Total Effectif :';
    //     CodeCaptionLbl: Label 'Code';
    //     AppointementCaptionLbl: Label 'Appointement';
    //     V000CaptionLbl: Label '000';
    //     Salaire_de_BaseCaptionLbl: Label 'Salaire de Base';
    //     V001CaptionLbl: Label '001';
    //     SALAIRE_BRUTCaptionLbl: Label 'SALAIRE BRUT';
    //     V650CaptionLbl: Label '650';
    //     CNSSCaptionLbl: Label 'CNSS';
    //     V463CaptionLbl: Label '463';
    //     Salaire_ImposableCaptionLbl: Label 'Salaire Imposable';
    //     V660CaptionLbl: Label '660';
    //     ImpotCaptionLbl: Label 'Impot';
    //     V436CaptionLbl: Label '436';
    //     Contribution_SocialCaptionLbl: Label 'Contribution Social';
    //     Arrondissement____CaptionLbl: Label 'Arrondissement (+)';
    //     V01CaptionLbl: Label 'V01';
    //     Arrondissement____Caption_Control1000000417Lbl: Label 'Arrondissement (-)';
    //     U01CaptionLbl: Label 'U01';
    //     Salaire_NetCaptionLbl: Label 'Salaire Net';
    //     V425CaptionLbl: Label '425';
    //     TOTAUXCaption_Control1000000373Lbl: Label 'TOTAUX';
}

