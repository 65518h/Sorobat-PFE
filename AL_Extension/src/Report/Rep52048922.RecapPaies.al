report 52048922 "Recap Paies"
{

    // //39001442
    // //     if copystr("Rec. Salary Lines"."catégorie",1,2)='SV' THEN
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/RecapPaies.rdlc';


    // dataset
    // {
    //     dataitem("Rec. Salary Lines"; 52048901)
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
    //             // DecimalPlaces = 0 : 0;
    //         }
    //         column(MoisRecap; MoisRecap)
    //         {
    //             // DecimalPlaces = 0 : 0;
    //         }
    //         column(DecTotEffecIndirect; DecTotEffecIndirect)
    //         {
    //             // DecimalPlaces = 0 : 0;
    //         }
    //         column(DecTotEffecDirect; DecTotEffecDirect)
    //         {
    //             // DecimalPlaces = 0 : 0;
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
    //             DecContributionSociale += "Contribution Social";
    //             "Rec. Salary Lines".CALCFIELDS("Type Contrat Employee");
    //             //IF ("Type Contrat Employee" = "Type Contrat Employee"::"SIVP I 1iere Année")
    //             //   OR ("Type Contrat Employee" = "Type Contrat Employee"::"SIVP I 2ieme Année")
    //             //   OR ("Type Contrat Employee" = "Type Contrat Employee"::"SIVP II")
    //             //   OR ("Type Contrat Employee" = "Type Contrat Employee"::Stagiaire)
    //             //   OR ("Type Contrat Employee" = "Type Contrat Employee"::Particulier) THEN
    //             //BEGIN
    //             IF (COPYSTR("Rec. Salary Lines".Catégorie, 1, 2) = 'SV') OR (COPYSTR("Rec. Salary Lines".Catégorie, 1, 2) = 'KR') THEN BEGIN
    //                 DecSalireBrutIndirect += "Rec. Salary Lines"."Gross Salary";
    //                 DecCNSSIndirect += "Rec. Salary Lines".CNSS;
    //                 DecSalireImposIndirect += "Rec. Salary Lines"."Taxable salary";
    //                 DecImpotIndirect += "Rec. Salary Lines"."Taxe (Month)";
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
    //             DecSommRedev := DecRedevDirect + DecRedevIndirect;
    //             DecSommSalireNet := DecSalireNetDirect + DecSalireNetIndirect;
    //             //
    //             DecAvance += "Rec. Salary Lines".Advances;
    //             DecArrondissPositif += "Rec. Salary Lines"."Ajout  en +";
    //             DecArrondissNegatif += "Rec. Salary Lines"."Report en -";

    //             // A COMPLITER PAR Mahdi Merci
    //             DecTotCredit := DecSommCNSS + DecSommImpot + DecSommRedev + DecAvance + DecArrondissNegatif + DecSommSalireNet + DecPretCNSSLog +
    //             DecPretCNSSVoit + DecPretSoc + DecCessionSalaire + DecRetenuePres + DecContributionSociale;
    //             //------
    //             DecTotDebit := DecAppointement + DecSalaireBase + DecPrimePres + DecIndTransp + DecPrimeDouche + DecIndDeplac + DecIndPanier + DecIndLogement +
    //             DecPrimeEncourag + DecPrimePoussiere + DecPrimeTech + DecPrimeCaisse + DecPrimeFonct + DecPrimeExcept + DecPrimeSpecial +
    //             DecPrimeAssid + DecPrimeRespons + DecPrimeEntret + DecPrimeAstreinte + DecPrimeLait + DecPrimeEnrobe + DecPrimeDiversDirect +
    //             DecSommSalireBrut + DecSommSalireImpos + DecArrondissPositif + DecRappel + DecMajorationDim + DecJourSupp + DecJoursFerie +
    //             DecCongeAnnuel + DecCongeExcept + DecComplementSalaire + DecForfaitHS + DecHeursSupp75 + DecHeursNormalPlus;
    //             //DecPretCNSSLog+= "Rec. Salary Lines".Loans


    //             IF CurrReport.TOTALSCAUSEDBY = "Rec. Salary Lines".FIELDNO("No.") THEN BEGIN
    //                 "Rec. Salary Lines".CALCSUMS("Gross Salary", "Taxe Redevance");
    //             END;

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
    //             RecNombSalarie.SETFILTER("No.", UserNoPaie);
    //             IF RecNombSalarie.FINDFIRST THEN
    //                 REPEAT
    //                     RecNombSalarie.CALCFIELDS("Type Contrat Employee");
    //                     IF (COPYSTR(RecNombSalarie.Catégorie, 1, 2) = 'SV') OR (COPYSTR(RecNombSalarie.Catégorie, 1, 2) = 'KR') THEN
    //                         DecTotEffecIndirect += 1
    //                     ELSE
    //                         DecTotEffecDirect := DecTotEffecDirect + 1;
    //                 UNTIL RecNombSalarie.NEXT = 0;
    //             //


    //             RecIndemnities.RESET;
    //             RecIndemnities.SETFILTER("No.", UserNoPaie);
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
    //                 //  IF RecIndemnities.Indemnity = '444' THEN DecRetenu+= RecIndemnities."Real Amount";
    //                 // IF RecIndemnities.Indemnity = '107' THEN DecComplementSalaire+= RecIndemnities."Real Amount";
    //                 UNTIL RecIndemnities.NEXT = 0;

    //             RecDetailComplement.RESET;
    //             RecDetailComplement.SETFILTER("Paiement No.", UserNoPaie);
    //             IF RecDetailComplement.FINDFIRST THEN
    //                 REPEAT
    //                     DecComplementSalaire += RecDetailComplement."Montant Complement";
    //                 UNTIL RecDetailComplement.NEXT = 0;

    //             RecHeuresSupEnrg.RESET;
    //             RecHeuresSupEnrg.SETFILTER("Paiement No.", UserNoPaie);
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
    //             RecHeuresOcca.SETFILTER("Paiement No.", UserNoPaie);
    //             IF RecHeuresOcca.FINDFIRST THEN
    //                 REPEAT
    //                     DecRappel += RecHeuresOcca.Rappel;
    //                     DecCessionSalaire += RecHeuresOcca.Cession;
    //                 UNTIL RecHeuresOcca.NEXT = 0;

    //             /*
    //             RecHeuresSup.RESET;
    //             RecHeuresSup.SETFILTER("Paiement No.",UserNoPaie);
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
    //     dataitem(Appontement; 2000000026)
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
    //     }
    //     dataitem(SalairedeBase; 2000000026)
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
    //     }
    //     dataitem(SalaireBrut; 2000000026)
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
    //     }
    //     dataitem(CNSS; 2000000026)
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
    //     }
    //     dataitem(SalaireImpsable; 2000000026)
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
    //     }
    //     dataitem(Impot; 2000000026)
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
    //     }
    //     dataitem("Redevance de Compensation"; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecSommRedev; DecSommRedev)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecRedevIndirect; DecRedevIndirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecRedevDirect; DecRedevDirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Redevance_de_compensationCaption; Redevance_de_compensationCaptionLbl)
    //         {
    //         }
    //         column(V996Caption; V996CaptionLbl)
    //         {
    //         }
    //         column(Redevance_de_Compensation_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(Avance; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecAvance; DecAvance)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecAvance_Control1000000380; DecAvance)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(AvanceCaption; AvanceCaptionLbl)
    //         {
    //         }
    //         column(V420Caption; V420CaptionLbl)
    //         {
    //         }
    //         column(Avance_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(ArrondPositif; 2000000026)
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
    //     }
    //     dataitem(ArrondNegatif; 2000000026)
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
    //     }
    //     dataitem(SalaireNet; 2000000026)
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
    //     }
    //     dataitem(PrimePresence; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimePres; DecPrimePres)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimePres_Control1000000446; DecPrimePres)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_de_PresenceCaption; Prime_de_PresenceCaptionLbl)
    //         {
    //         }
    //         column(V201Caption; V201CaptionLbl)
    //         {
    //         }
    //         column(PrimePresence_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeTransport; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecIndTransp; DecIndTransp)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecIndTransp_Control1000000463; DecIndTransp)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_de_TransportCaption; Prime_de_TransportCaptionLbl)
    //         {
    //         }
    //         column(V003Caption; V003CaptionLbl)
    //         {
    //         }
    //         column(PrimeTransport_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeDouche; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeDouche; DecPrimeDouche)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeDouche_Control1000000478; DecPrimeDouche)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_de_DoucheCaption; Prime_de_DoucheCaptionLbl)
    //         {
    //         }
    //         column(V204Caption; V204CaptionLbl)
    //         {
    //         }
    //         column(PrimeDouche_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(IndDeplacement; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecIndDeplac; DecIndDeplac)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecIndDeplac_Control1000000495; DecIndDeplac)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Indemnite_de_DeplacementCaption; Indemnite_de_DeplacementCaptionLbl)
    //         {
    //         }
    //         column(V106Caption; V106CaptionLbl)
    //         {
    //         }
    //         column(IndDeplacement_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(IndPanier; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecIndPanier; DecIndPanier)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecIndPanier_Control1000000515; DecIndPanier)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Indemnite_de_PanierCaption; Indemnite_de_PanierCaptionLbl)
    //         {
    //         }
    //         column(V103Caption; V103CaptionLbl)
    //         {
    //         }
    //         column(IndPanier_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(IndLogement; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecIndLogement; DecIndLogement)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecIndLogement_Control1000000536; DecIndLogement)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Indemnite_de_LogementCaption; Indemnite_de_LogementCaptionLbl)
    //         {
    //         }
    //         column(V115Caption; V115CaptionLbl)
    //         {
    //         }
    //         column(IndLogement_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeEncouragement; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeEncourag; DecPrimeEncourag)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeEncourag_Control1000000592; DecPrimeEncourag)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_d_encouragementCaption; Prime_d_encouragementCaptionLbl)
    //         {
    //         }
    //         column(V997Caption; V997CaptionLbl)
    //         {
    //         }
    //         column(PrimeEncouragement_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimePoussiere; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimePoussiere; DecPrimePoussiere)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimePoussiere_Control1000000005; DecPrimePoussiere)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_de_PoussiereCaption; Prime_de_PoussiereCaptionLbl)
    //         {
    //         }
    //         column(V208Caption; V208CaptionLbl)
    //         {
    //         }
    //         column(PrimePoussiere_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeTechnicite; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeTech; DecPrimeTech)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeTech_Control1000000051; DecPrimeTech)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_de_TechniciteCaption; Prime_de_TechniciteCaptionLbl)
    //         {
    //         }
    //         column(V215Caption; V215CaptionLbl)
    //         {
    //         }
    //         column(PrimeTechnicite_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeCaisse; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeCaisse; DecPrimeCaisse)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeCaisse_Control1000000088; DecPrimeCaisse)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_de_CaisseCaption; Prime_de_CaisseCaptionLbl)
    //         {
    //         }
    //         column(V440Caption; V440CaptionLbl)
    //         {
    //         }
    //         column(PrimeCaisse_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeFonction; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeFonct; DecPrimeFonct)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeFonct_Control1000000101; DecPrimeFonct)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_de_FonctionCaption; Prime_de_FonctionCaptionLbl)
    //         {
    //         }
    //         column(V520Caption; V520CaptionLbl)
    //         {
    //         }
    //         column(PrimeFonction_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeExceptionnel; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeExcept; DecPrimeExcept)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeExcept_Control1000000111; DecPrimeExcept)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_ExceptionnelCaption; Prime_ExceptionnelCaptionLbl)
    //         {
    //         }
    //         column(V996Caption_Control1000000116; V996Caption_Control1000000116Lbl)
    //         {
    //         }
    //         column(PrimeExceptionnel_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeSpecial; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeSpecial; DecPrimeSpecial)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeSpecial_Control1000000122; DecPrimeSpecial)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_SpecialCaption; Prime_SpecialCaptionLbl)
    //         {
    //         }
    //         column(V990Caption; V990CaptionLbl)
    //         {
    //         }
    //         column(PrimeSpecial_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeAssiduite; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeAssid; DecPrimeAssid)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeAssid_Control1000000132; DecPrimeAssid)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_de_AssiduiteCaption; Prime_de_AssiduiteCaptionLbl)
    //         {
    //         }
    //         column(V998Caption; V998CaptionLbl)
    //         {
    //         }
    //         column(PrimeAssiduite_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeResponsabilite; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeRespons; DecPrimeRespons)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeRespons_Control1000000142; DecPrimeRespons)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_de_ResponsabiliteCaption; Prime_de_ResponsabiliteCaptionLbl)
    //         {
    //         }
    //         column(V995Caption; V995CaptionLbl)
    //         {
    //         }
    //         column(PrimeResponsabilite_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(Primentretien; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeEntret; DecPrimeEntret)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeEntret_Control1000000152; DecPrimeEntret)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_D_EntretienCaption; Prime_D_EntretienCaptionLbl)
    //         {
    //         }
    //         column(V999Caption; V999CaptionLbl)
    //         {
    //         }
    //         column(Primentretien_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeAstreinte; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeAstreinte; DecPrimeAstreinte)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeAstreinte_Control1000000162; DecPrimeAstreinte)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_D_AstreinteCaption; Prime_D_AstreinteCaptionLbl)
    //         {
    //         }
    //         column(V448Caption; V448CaptionLbl)
    //         {
    //         }
    //         column(PrimeAstreinte_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeLait; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeLait; DecPrimeLait)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeLait_Control1000000172; DecPrimeLait)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_de_LaitCaption; Prime_de_LaitCaptionLbl)
    //         {
    //         }
    //         column(V987Caption; V987CaptionLbl)
    //         {
    //         }
    //         column(PrimeLait_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeEnrobe; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeEnrobe; DecPrimeEnrobe)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeEnrobe_Control1000000182; DecPrimeEnrobe)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_d_EnrobeCaption; Prime_d_EnrobeCaptionLbl)
    //         {
    //         }
    //         column(V994Caption; V994CaptionLbl)
    //         {
    //         }
    //         column(PrimeEnrobe_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PrimeDiverse; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPrimeDiversDirect; DecPrimeDiversDirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPrimeDiversDirect_Control1000000391; DecPrimeDiversDirect)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Prime_DiverseCaption; Prime_DiverseCaptionLbl)
    //         {
    //         }
    //         column(V209Caption; V209CaptionLbl)
    //         {
    //         }
    //         column(PrimeDiverse_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(ComplementSalaire; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecComplementSalaire; DecComplementSalaire)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecComplementSalaire_Control1000000192; DecComplementSalaire)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Complement_de_SalaireCaption; Complement_de_SalaireCaptionLbl)
    //         {
    //         }
    //         column(V988Caption; V988CaptionLbl)
    //         {
    //         }
    //         column(ComplementSalaire_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(ForfaitHS; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecForfaitHS; DecForfaitHS)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecForfaitHS_Control1000000206; DecForfaitHS)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Forfait_HSCaption; Forfait_HSCaptionLbl)
    //         {
    //         }
    //         column(ForfaitHS_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(HeursSup75; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecHeursSupp75; DecHeursSupp75)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecHeursSupp75_Control1000000219; DecHeursSupp75)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Heures_Sup_75_Caption; Heures_Sup_75_CaptionLbl)
    //         {
    //         }
    //         column(V007Caption; V007CaptionLbl)
    //         {
    //         }
    //         column(HeursSup75_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(HeursNormalPlus; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecHeursNormalPlus; DecHeursNormalPlus)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecHeursNormalPlus_Control1000000237; DecHeursNormalPlus)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Heurs_Normal__Caption; Heurs_Normal__CaptionLbl)
    //         {
    //         }
    //         column(V204Caption_Control1000000242; V204Caption_Control1000000242Lbl)
    //         {
    //         }
    //         column(HeursNormalPlus_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(MajorationDM; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecMajorationDim; DecMajorationDim)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecMajorationDim_Control1000000250; DecMajorationDim)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Majoration_DimCaption; Majoration_DimCaptionLbl)
    //         {
    //         }
    //         column(V207Caption; V207CaptionLbl)
    //         {
    //         }
    //         column(MajorationDM_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(MontantJourSupp; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecJourSupp; DecJourSupp)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecJourSupp_Control1000000263; DecJourSupp)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Montant_Jour_SuppCaption; Montant_Jour_SuppCaptionLbl)
    //         {
    //         }
    //         column(V236Caption; V236CaptionLbl)
    //         {
    //         }
    //         column(MontantJourSupp_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(JoursFerie; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecJoursFerie; DecJoursFerie)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecJoursFerie_Control1000000279; DecJoursFerie)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Jours_FerieCaption; Jours_FerieCaptionLbl)
    //         {
    //         }
    //         column(V203Caption; V203CaptionLbl)
    //         {
    //         }
    //         column(JoursFerie_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(CongeAnnuel; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecCongeAnnuel; DecCongeAnnuel)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecCongeAnnuel_Control1000000293; DecCongeAnnuel)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Conge_AnnuelCaption; Conge_AnnuelCaptionLbl)
    //         {
    //         }
    //         column(V990Caption_Control1000000297; V990Caption_Control1000000297Lbl)
    //         {
    //         }
    //         column(CongeAnnuel_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(CongeExcept; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecCongeExcept; DecCongeExcept)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecCongeExcept_Control1000000303; DecCongeExcept)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Conge_ExceptionnelCaption; Conge_ExceptionnelCaptionLbl)
    //         {
    //         }
    //         column(V991Caption; V991CaptionLbl)
    //         {
    //         }
    //         column(CongeExcept_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(RetenuePresence; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(ABS_DecRetenuePres_; ABS(DecRetenuePres))
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(ABS_DecRetenuePres__Control1000000313; ABS(DecRetenuePres))
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Retenue_de_Presence__Heures_Caption; Retenue_de_Presence__Heures_CaptionLbl)
    //         {
    //         }
    //         column(V002Caption; V002CaptionLbl)
    //         {
    //         }
    //         column(RetenuePresence_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(Rappel; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecRappel; DecRappel)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecRappel_Control1000000323; DecRappel)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(RappelCaption; RappelCaptionLbl)
    //         {
    //         }
    //         column(V996Caption_Control1000000327; V996Caption_Control1000000327Lbl)
    //         {
    //         }
    //         column(Rappel_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(CessionSalaire; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecCessionSalaire; DecCessionSalaire)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecCessionSalaire_Control1000000333; DecCessionSalaire)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Cession_sur_SalaireCaption; Cession_sur_SalaireCaptionLbl)
    //         {
    //         }
    //         column(V430Caption; V430CaptionLbl)
    //         {
    //         }
    //         column(CessionSalaire_Number; Number)
    //         {
    //         }
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

    //             DecCessionSalaire += ABS(DecRetenu);
    //         end;
    //     }
    //     dataitem(ContributionSociale; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecContributionSociale; DecContributionSociale)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecContributionSociale_Control1000000413; DecContributionSociale)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Contribution_SocialeCaption; Contribution_SocialeCaptionLbl)
    //         {
    //         }
    //         column(V990Caption_Control1000000423; V990Caption_Control1000000423Lbl)
    //         {
    //         }
    //         column(ContributionSociale_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PretCNSSLog; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPretCNSSLog; DecPretCNSSLog)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPretCNSSLog_Control1000000343; DecPretCNSSLog)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Pret_LogementCaption; Pret_LogementCaptionLbl)
    //         {
    //         }
    //         column(V430Caption_Control1000000347; V430Caption_Control1000000347Lbl)
    //         {
    //         }
    //         column(PretCNSSLog_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PretCNSSVoit; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPretCNSSVoit; DecPretCNSSVoit)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPretCNSSVoit_Control1000000353; DecPretCNSSVoit)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Pret_CNSS_VoitureCaption; Pret_CNSS_VoitureCaptionLbl)
    //         {
    //         }
    //         column(V430Caption_Control1000000357; V430Caption_Control1000000357Lbl)
    //         {
    //         }
    //         column(PretCNSSVoit_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(PretSocite; 2000000026)
    //     {
    //         DataItemTableView = SORTING(Number)
    //                             WHERE(Number = CONST(1));
    //         column(DecPretSoc; DecPretSoc)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DecPretSoc_Control1000000363; DecPretSoc)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Pret_SocieteCaption; Pret_SocieteCaptionLbl)
    //         {
    //         }
    //         column(V430Caption_Control1000000367; V430Caption_Control1000000367Lbl)
    //         {
    //         }
    //         column(PretSocite_Number; Number)
    //         {
    //         }
    //     }
    //     dataitem(TOTAUX; 2000000026)
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
    //     UserNoPaie: Text[250];
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
    //     RecIndemnities: Record 52048902;
    //     DecPrimePres: Decimal;
    //     DecIndTransp: Decimal;
    //     DecRetenu: Decimal;
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
    //     RecDetailComplement: Record 52048913;
    //     DecComplementSalaire: Decimal;
    //     RecHeuresSupEnrg: Record 52048892;
    //     DecForfaitHS: Decimal;
    //     DecHeursSupp75: Decimal;
    //     DecHeursNormalPlus: Decimal;
    //     DecMajorationDim: Decimal;
    //     DecJourSupp: Decimal;
    //     DecJoursFerie: Decimal;
    //     DecCongeAnnuel: Decimal;
    //     DecCongeExcept: Decimal;
    //     DecRetenuePres: Decimal;
    //     RecHeuresOcca: Record 52048918;
    //     DecRappel: Decimal;
    //     DecCessionSalaire: Decimal;
    //     RecHeuresSup: Record 52049034;
    //     RecPretAvance: Record 52048890;
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
    //     RecSalaryHeader: Record 52048900;
    //     MoisRecap: Text[30];
    //     AnneeRecap: Integer;
    //     RecNombSalarie: Record 52048901;
    //     RecPretLogement: Record 52048889;
    //     RecEntetePret: Record 52048889;
    //     RecPretLine: Record 52048890;
    //     DecContributionSociale: Decimal;
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
    //     Redevance_de_compensationCaptionLbl: Label 'Redevance de compensation';
    //     V996CaptionLbl: Label '996';
    //     AvanceCaptionLbl: Label 'Avance';
    //     V420CaptionLbl: Label '420';
    //     Arrondissement____CaptionLbl: Label 'Arrondissement (+)';
    //     V01CaptionLbl: Label 'V01';
    //     Arrondissement____Caption_Control1000000417Lbl: Label 'Arrondissement (-)';
    //     U01CaptionLbl: Label 'U01';
    //     Salaire_NetCaptionLbl: Label 'Salaire Net';
    //     V425CaptionLbl: Label '425';
    //     Prime_de_PresenceCaptionLbl: Label 'Prime de Presence';
    //     V201CaptionLbl: Label '201';
    //     Prime_de_TransportCaptionLbl: Label 'Prime de Transport';
    //     V003CaptionLbl: Label '003';
    //     Prime_de_DoucheCaptionLbl: Label 'Prime de Douche';
    //     V204CaptionLbl: Label '204';
    //     Indemnite_de_DeplacementCaptionLbl: Label 'Indemnite de Deplacement';
    //     V106CaptionLbl: Label '106';
    //     Indemnite_de_PanierCaptionLbl: Label 'Indemnite de Panier';
    //     V103CaptionLbl: Label '103';
    //     Indemnite_de_LogementCaptionLbl: Label 'Indemnite de Logement';
    //     V115CaptionLbl: Label '115';
    //     Prime_d_encouragementCaptionLbl: Label 'Prime d''encouragement';
    //     V997CaptionLbl: Label '997';
    //     Prime_de_PoussiereCaptionLbl: Label 'Prime de Poussiere';
    //     V208CaptionLbl: Label '208';
    //     Prime_de_TechniciteCaptionLbl: Label 'Prime de Technicite';
    //     V215CaptionLbl: Label '215';
    //     Prime_de_CaisseCaptionLbl: Label 'Prime de Caisse';
    //     V440CaptionLbl: Label '440';
    //     Prime_de_FonctionCaptionLbl: Label 'Prime de Fonction';
    //     V520CaptionLbl: Label '520';
    //     Prime_ExceptionnelCaptionLbl: Label 'Prime Exceptionnel';
    //     V996Caption_Control1000000116Lbl: Label '996';
    //     Prime_SpecialCaptionLbl: Label 'Prime Special';
    //     V990CaptionLbl: Label '990';
    //     Prime_de_AssiduiteCaptionLbl: Label 'Prime de Assiduite';
    //     V998CaptionLbl: Label '998';
    //     Prime_de_ResponsabiliteCaptionLbl: Label 'Prime de Responsabilite';
    //     V995CaptionLbl: Label '995';
    //     Prime_D_EntretienCaptionLbl: Label 'Prime D''Entretien';
    //     V999CaptionLbl: Label '999';
    //     Prime_D_AstreinteCaptionLbl: Label 'Prime D''Astreinte';
    //     V448CaptionLbl: Label '448';
    //     Prime_de_LaitCaptionLbl: Label 'Prime de Lait';
    //     V987CaptionLbl: Label '987';
    //     Prime_d_EnrobeCaptionLbl: Label 'Prime d''Enrobe';
    //     V994CaptionLbl: Label '994';
    //     Prime_DiverseCaptionLbl: Label 'Prime Diverse';
    //     V209CaptionLbl: Label '209';
    //     Complement_de_SalaireCaptionLbl: Label 'Complement de Salaire';
    //     V988CaptionLbl: Label '988';
    //     Forfait_HSCaptionLbl: Label 'Forfait HS';
    //     Heures_Sup_75_CaptionLbl: Label 'Heures Sup 75%';
    //     V007CaptionLbl: Label '007';
    //     Heurs_Normal__CaptionLbl: Label 'Heurs Normal +';
    //     V204Caption_Control1000000242Lbl: Label '204';
    //     Majoration_DimCaptionLbl: Label 'Majoration Dim';
    //     V207CaptionLbl: Label '207';
    //     Montant_Jour_SuppCaptionLbl: Label 'Montant Jour Supp';
    //     V236CaptionLbl: Label '236';
    //     Jours_FerieCaptionLbl: Label 'Jours Ferie';
    //     V203CaptionLbl: Label '203';
    //     Conge_AnnuelCaptionLbl: Label 'Conge Annuel';
    //     V990Caption_Control1000000297Lbl: Label '990';
    //     Conge_ExceptionnelCaptionLbl: Label 'Conge Exceptionnel';
    //     V991CaptionLbl: Label '991';
    //     Retenue_de_Presence__Heures_CaptionLbl: Label 'Retenue de Presence (Heures)';
    //     V002CaptionLbl: Label '002';
    //     RappelCaptionLbl: Label 'Rappel';
    //     V996Caption_Control1000000327Lbl: Label '996';
    //     Cession_sur_SalaireCaptionLbl: Label 'Cession sur Salaire';
    //     V430CaptionLbl: Label '430';
    //     Contribution_SocialeCaptionLbl: Label 'Contribution Sociale';
    //     V990Caption_Control1000000423Lbl: Label '990';
    //     Pret_LogementCaptionLbl: Label 'Pret Logement';
    //     V430Caption_Control1000000347Lbl: Label '430';
    //     Pret_CNSS_VoitureCaptionLbl: Label 'Pret CNSS Voiture';
    //     V430Caption_Control1000000357Lbl: Label '430';
    //     Pret_SocieteCaptionLbl: Label 'Pret Societe';
    //     V430Caption_Control1000000367Lbl: Label '430';
    //     TOTAUXCaption_Control1000000373Lbl: Label 'TOTAUX';
}

