// page 50133 "Entete Credit"
// {
//     PageType = Card;
//     SourceTable = "Entete Credit";
//     Caption = 'Entete Credit';
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'General';
//                 field("Numero Credit"; rec."Numero Credit")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Banque; rec.Banque)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Compte Bancaire"; rec."Compte Bancaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Type Calcul"; rec."Type Calcul")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Credit"; rec."Date Credit")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nombre Tranche"; rec."Nombre Tranche")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(TMM; rec.TMM)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Taux Interet"; rec."Taux Interet")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Taux Credit"; rec."Taux Credit")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Montant Credit"; rec."Montant Credit")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Observation; rec.Observation)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             part(Ligne; "Ligne Credit")
//             {
//                 ApplicationArea = all;

//                 SubPageLink = "Numero Credit" = FIELD("Numero Credit");
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Update)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Update';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     IF NOT CONFIRM(Text001) THEN EXIT;
//                     LigneCredit.SETFILTER("Nouveau TMM", '<>%1', 0);
//                     IF LigneCredit.FINDLAST THEN NumeroLigne := LigneCredit.Numero;
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Annuité Constante" THEN
//                         CurrPage.Ligne.Page.AnnuitéConstante(LigneCredit.Numero,
//                                                              LigneCredit."Nouveau TMM");
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Mensualité Constante" THEN
//                         CurrPage.Ligne.Page.MensualitéConstante(LigneCredit.Numero,
//                                                           LigneCredit."Nouveau TMM");
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Semestrialité Constante" THEN
//                         CurrPage.Ligne.Page.SemestrialiteConstante(LigneCredit.Numero,
//                                                            LigneCredit."Nouveau TMM");
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Trimestrailité Constante" THEN
//                         CurrPage.Ligne.Page.TrimestrialiteConstante(LigneCredit.Numero,
//                                                             LigneCredit."Nouveau TMM");
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Annuité Degressive" THEN
//                         CurrPage.Ligne.Page.AnnuitéDegressive(LigneCredit.Numero,
//                                                                 LigneCredit."Nouveau TMM");
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Mensualité Degressive" THEN
//                         CurrPage.Ligne.Page.MensualitéDegressive(LigneCredit.Numero,
//                                                          LigneCredit."Nouveau TMM");
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Semestrialité Degressive" THEN
//                         CurrPage.Ligne.Page.SemestrialiteDegressive(LigneCredit.Numero,
//                                                               LigneCredit."Nouveau TMM");
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Trimestrailité Degressive" THEN
//                         CurrPage.Ligne.Page.TrimestrialiteDegressive(LigneCredit.Numero,
//                                                              LigneCredit."Nouveau TMM");

//                     //Currpage.Ligne.Page.UpdateControl;
//                 end;
//             }
//             action(Calculer)
//             {
//                 Caption = 'Calculer';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ApplicationArea = all;
//                 trigger OnAction()
//                 begin
//                     IF NOT CONFIRM(Text001) THEN EXIT;
//                     Compteur := 0;
//                     LigneCredit.SETRANGE("Numero Credit", rec."Numero Credit");
//                     LigneCredit.DELETEALL;
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Annuité Constante" THEN AnnuitéConstante;
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Mensualité Constante" THEN MensualitéConstante;
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Semestrialité Constante" THEN SemestrialiteConstante;
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Trimestrailité Constante" THEN TrimestrialiteConstante;
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Annuité Degressive" THEN AnnuitéDegressive;
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Mensualité Degressive" THEN MensualitéDegressive;
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Semestrialité Degressive" THEN SemestrialiteDegressive;
//                     IF rec."Type Calcul" = rec."Type Calcul"::"Trimestrailité Degressive" THEN TrimestrialiteDegressive;

//                     //Currpage.Ligne.Page.UpdateControl;
//                 end;
//             }
//         }
//     }

//     var
//         LigneCredit: Record "Ligne Credit";
//         Text001: Label 'Lancer Le Traitement';
//         Compteur: Integer;
//         MontantBase: Decimal;
//         Montant: Decimal;
//         NumeroLigne: Integer;
//         DateCalcule: Date;


//     procedure "AnnuitéConstante"()
//     begin
//         CLEAR(LigneCredit);
//         FOR Compteur := 1 TO rec."Nombre Tranche" DO BEGIN

//             LigneCredit."Numero Credit" := rec."Numero Credit";
//             LigneCredit.Numero := Compteur;
//             LigneCredit.Annnée := DATE2DMY(rec."Date Credit", 3) + Compteur - 1;
//             IF Compteur = 1 THEN
//                 LigneCredit.Base := rec."Montant Credit"
//             ELSE
//                 LigneCredit.Base := MontantBase;
//             Montant := (rec."Montant Credit" * rec."Taux Credit" / 100) / (1 - POWER(1 + rec."Taux Credit" / 100, -rec."Nombre Tranche"));
//             LigneCredit.Interet := LigneCredit.Base * rec."Taux Credit" / 100;
//             LigneCredit.Amortissement := Montant - LigneCredit.Interet;
//             LigneCredit.Annuité := Montant;
//             LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//             MontantBase := LigneCredit."Val Fin";
//             LigneCredit.INSERT;
//         END;
//         CurrPage.Ligne.Page.UpdateControl;
//     end;


//     procedure "MensualitéConstante"()
//     begin
//         CLEAR(LigneCredit);
//         FOR Compteur := 1 TO rec."Nombre Tranche" DO BEGIN

//             LigneCredit."Numero Credit" := rec."Numero Credit";
//             LigneCredit.Numero := Compteur;

//             IF Compteur = 1 THEN BEGIN
//                 LigneCredit.Mois := FORMAT(DATE2DMY(rec."Date Credit", 2));
//                 LigneCredit.Annnée := DATE2DMY(rec."Date Credit", 3);
//             END
//             ELSE BEGIN
//                 DateCalcule := CALCDATE('1M', rec."Date Credit");
//                 rec."Date Credit" := DateCalcule;
//                 LigneCredit.Mois := FORMAT(DATE2DMY(DateCalcule, 2));
//                 LigneCredit.Annnée := DATE2DMY(DateCalcule, 3);
//             END;
//             IF Compteur = 1 THEN
//                 LigneCredit.Base := rec."Montant Credit"
//             ELSE
//                 LigneCredit.Base := MontantBase;

//             Montant := (rec."Montant Credit" * rec."Taux Credit" / 1200) / (1 - POWER(1 + rec."Taux Credit" / 1200, -rec."Nombre Tranche"));
//             LigneCredit.Interet := LigneCredit.Base * rec."Taux Credit" / 1200;
//             LigneCredit.Amortissement := Montant - LigneCredit.Interet;
//             LigneCredit.Mensualité := Montant;
//             LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//             MontantBase := LigneCredit."Val Fin";
//             LigneCredit.INSERT;
//         END;
//     end;


//     procedure SemestrialiteConstante()
//     begin
//         CLEAR(LigneCredit);
//         FOR Compteur := 1 TO rec."Nombre Tranche" DO BEGIN

//             LigneCredit."Numero Credit" := rec."Numero Credit";
//             LigneCredit.Numero := Compteur;
//             LigneCredit.Mois := FORMAT(DATE2DMY(rec."Date Credit", 2) + Compteur - 1);
//             IF Compteur = 1 THEN
//                 LigneCredit.Base := rec."Montant Credit"
//             ELSE
//                 LigneCredit.Base := MontantBase;
//             Montant := (rec."Montant Credit" * rec."Taux Credit" / 200) / (1 - POWER(1 + rec."Taux Credit" / 200, -rec."Nombre Tranche"));
//             LigneCredit.Interet := LigneCredit.Base * rec."Taux Credit" / 200;
//             LigneCredit.Amortissement := Montant - LigneCredit.Interet;
//             LigneCredit.Semestrialité := Montant;
//             LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//             MontantBase := LigneCredit."Val Fin";
//             LigneCredit.INSERT;
//         END;
//     end;

//     procedure TrimestrialiteConstante()
//     begin
//         CLEAR(LigneCredit);
//         FOR Compteur := 1 TO rec."Nombre Tranche" DO BEGIN

//             LigneCredit."Numero Credit" := rec."Numero Credit";
//             LigneCredit.Numero := Compteur;
//             LigneCredit.Mois := FORMAT(DATE2DMY(rec."Date Credit", 2) + Compteur - 1);
//             IF Compteur = 1 THEN
//                 LigneCredit.Base := rec."Montant Credit"
//             ELSE
//                 LigneCredit.Base := MontantBase;
//             Montant := (rec."Montant Credit" * rec."Taux Credit" / 400) / (1 - POWER(1 + rec."Taux Credit" / 400, -rec."Nombre Tranche"));
//             LigneCredit.Interet := LigneCredit.Base * rec."Taux Credit" / 400;
//             LigneCredit.Amortissement := Montant - LigneCredit.Interet;
//             LigneCredit.Trimestrialité := Montant;
//             LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//             MontantBase := LigneCredit."Val Fin";
//             LigneCredit.INSERT;
//         END;
//     end;


//     procedure "AnnuitéDegressive"()
//     begin
//         CLEAR(LigneCredit);
//         FOR Compteur := 1 TO rec."Nombre Tranche" DO BEGIN

//             LigneCredit."Numero Credit" := rec."Numero Credit";
//             LigneCredit.Numero := Compteur;
//             LigneCredit.Annnée := DATE2DMY(rec."Date Credit", 3) + Compteur - 1;
//             IF Compteur = 1 THEN
//                 LigneCredit.Base := rec."Montant Credit"
//             ELSE
//                 LigneCredit.Base := MontantBase;
//             LigneCredit.Interet := LigneCredit.Base * rec."Taux Credit" / 100;
//             LigneCredit.Amortissement := rec."Montant Credit" / rec."Nombre Tranche";
//             LigneCredit.Annuité := LigneCredit.Amortissement + LigneCredit.Interet;
//             LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//             MontantBase := LigneCredit."Val Fin";
//             LigneCredit.INSERT;
//         END;
//         CurrPage.Ligne.Page.UpdateControl;
//     end;


//     procedure "MensualitéDegressive"()
//     begin
//         CLEAR(LigneCredit);
//         FOR Compteur := 1 TO rec."Nombre Tranche" DO BEGIN

//             LigneCredit."Numero Credit" := rec."Numero Credit";
//             LigneCredit.Numero := Compteur;
//             LigneCredit.Annnée := DATE2DMY(rec."Date Credit", 3) + Compteur - 1;
//             IF Compteur = 1 THEN
//                 LigneCredit.Base := rec."Montant Credit"
//             ELSE
//                 LigneCredit.Base := MontantBase;
//             LigneCredit.Interet := LigneCredit.Base * rec."Taux Credit" / 1200;
//             LigneCredit.Amortissement := rec."Montant Credit" / rec."Nombre Tranche";
//             LigneCredit.Annuité := LigneCredit.Amortissement + LigneCredit.Interet;
//             LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//             MontantBase := LigneCredit."Val Fin";
//             LigneCredit.INSERT;
//         END;
//         CurrPage.Ligne.Page.UpdateControl;
//     end;


//     procedure SemestrialiteDegressive()
//     begin
//         CLEAR(LigneCredit);
//         FOR Compteur := 1 TO rec."Nombre Tranche" DO BEGIN

//             LigneCredit."Numero Credit" := rec."Numero Credit";
//             LigneCredit.Numero := Compteur;
//             LigneCredit.Annnée := DATE2DMY(rec."Date Credit", 3) + Compteur - 1;
//             IF Compteur = 1 THEN
//                 LigneCredit.Base := rec."Montant Credit"
//             ELSE
//                 LigneCredit.Base := MontantBase;
//             LigneCredit.Interet := LigneCredit.Base * rec."Taux Credit" / 200;
//             LigneCredit.Amortissement := rec."Montant Credit" / rec."Nombre Tranche";
//             LigneCredit.Annuité := LigneCredit.Amortissement + LigneCredit.Interet;
//             LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//             MontantBase := LigneCredit."Val Fin";
//             LigneCredit.INSERT;
//         END;
//         CurrPage.Ligne.Page.UpdateControl;
//     end;


//     procedure TrimestrialiteDegressive()
//     begin
//         CLEAR(LigneCredit);
//         FOR Compteur := 1 TO rec."Nombre Tranche" DO BEGIN

//             LigneCredit."Numero Credit" := rec."Numero Credit";
//             LigneCredit.Numero := Compteur;
//             LigneCredit.Annnée := DATE2DMY(rec."Date Credit", 3) + Compteur - 1;
//             IF Compteur = 1 THEN
//                 LigneCredit.Base := rec."Montant Credit"
//             ELSE
//                 LigneCredit.Base := MontantBase;
//             LigneCredit.Interet := LigneCredit.Base * rec."Taux Credit" / 400;
//             LigneCredit.Amortissement := rec."Montant Credit" / rec."Nombre Tranche";
//             LigneCredit.Annuité := LigneCredit.Amortissement + LigneCredit.Interet;
//             LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//             MontantBase := LigneCredit."Val Fin";
//             LigneCredit.INSERT;
//         END;
//         CurrPage.Ligne.Page.UpdateControl;
//     end;
// }

