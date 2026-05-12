// Page 50134 "Ligne Credit"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = ListPart;
//     SourceTable = "Ligne Credit";
//     ApplicationArea = All;
//     Caption = 'Ligne Credit';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Numero Credit"; REC."Numero Credit")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field(Numero; REC.Numero)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Annnée"; REC.Annnée)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Mois; REC.Mois)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Base; REC.Base)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Interet; REC.Interet)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Amortissement; REC.Amortissement)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Annuité"; REC.Annuité)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Mensualité"; REC.Mensualité)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Trimestrialité"; REC.Trimestrialité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Semestrialité"; REC.Semestrialité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Val Fin"; REC."Val Fin")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Statut; REC.Statut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nouveau TMM"; REC."Nouveau TMM")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         EnteteCredit: Record "Entete Credit";
//         LigneCredit: Record "Ligne Credit";
//         LigneCredit2: Record "Ligne Credit";
//         Compteur: Integer;
//         TauxCredit: Decimal;
//         MontantCredit: Decimal;
//         MontantBase: Decimal;
//         Montant: Decimal;
//         NombreTranche: Integer;
//         Text001: label 'Lancer La Mise à Jour ?';


//     procedure UpdateControl()
//     begin
//         //GL2024
//         /*EXIT;
//         EnteteCredit.GET("Numero Credit");
//         IF (EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Annuité Constante") OR
//            (EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Annuité Degressive") THEN
//           BEGIN
//             CurrPage.Annuité.VISIBLE:=TRUE;
//             CurrPage.Mensualité.VISIBLE:=FALSE;
//             CurrPage.Trimestrialité.VISIBLE:=FALSE;
//             CurrPage.Semestrialité.VISIBLE :=FALSE;
//           END;
//         IF (EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Mensualité Constante") OR
//             (EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Mensualité Degressive")THEN
//           BEGIN
//             CurrPage.Annuité.VISIBLE:=FALSE;
//             CurrPage.Mensualité.VISIBLE:=TRUE;
//             CurrPage.Trimestrialité.VISIBLE:=FALSE;
//             CurrPage.Semestrialité.VISIBLE :=FALSE;
//           END;
//         IF (EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Trimestrailité Constante") OR
//            (EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Trimestrailité Constante")THEN
//           BEGIN
//             CurrPage.Annuité.VISIBLE:=FALSE;
//             CurrPage.Mensualité.VISIBLE:=FALSE;
//             CurrPage.Trimestrialité.VISIBLE:=TRUE;
//             CurrPage.Semestrialité.VISIBLE :=FALSE;
//           END;
//         IF (EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Semestrialité Constante") OR
//            (EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Semestrialité Degressive")THEN
//           BEGIN
//             CurrPage.Annuité.VISIBLE:=FALSE;
//             CurrPage.Mensualité.VISIBLE:=FALSE;
//             CurrPage.Trimestrialité.VISIBLE:=FALSE;
//             CurrPage.Semestrialité.VISIBLE :=TRUE;
//           END;
//          */

//     end;


//     procedure "AnnuitéConstante"(NumeroLigne: Integer; TauxTmm: Decimal)
//     begin
//         Clear(LigneCredit);
//         Montant := 0;
//         TauxCredit := 0;
//         Compteur := 0;
//         MontantBase := 0;
//         if EnteteCredit.Get(REC."Numero Credit") then TauxCredit := TauxTmm + EnteteCredit."Taux Interet";
//         if TauxCredit = 0 then exit;
//         LigneCredit2.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit2.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit2.FindFirst then NombreTranche := LigneCredit2.Count;
//         LigneCredit.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit.FindFirst then
//             repeat
//                 Compteur += 1;
//                 if Compteur = 1 then begin
//                     LigneCredit.Base := LigneCredit.Base;
//                     MontantCredit := LigneCredit.Base;
//                 end
//                 else
//                     LigneCredit.Base := MontantBase;
//                 Montant := (MontantCredit * TauxCredit / 100) / (1 - Power(1 + TauxCredit / 100, -NombreTranche));
//                 LigneCredit.Interet := LigneCredit.Base * TauxCredit / 100;
//                 LigneCredit.Amortissement := Montant - LigneCredit.Interet;
//                 LigneCredit.Annuité := Montant;
//                 LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//                 MontantBase := LigneCredit."Val Fin";
//                 LigneCredit.Modify;
//             until LigneCredit.Next = 0;
//     end;


//     procedure "MensualitéConstante"(NumeroLigne: Integer; TauxTmm: Decimal)
//     begin
//         Clear(LigneCredit);
//         Montant := 0;
//         TauxCredit := 0;
//         Compteur := 0;
//         MontantBase := 0;
//         if EnteteCredit.Get(REC."Numero Credit") then TauxCredit := TauxTmm + EnteteCredit."Taux Interet";
//         if TauxCredit = 0 then exit;
//         LigneCredit2.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit2.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit2.FindFirst then NombreTranche := LigneCredit2.Count;
//         LigneCredit.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit.FindFirst then
//             repeat
//                 Compteur += 1;
//                 if Compteur = 1 then begin
//                     LigneCredit.Base := LigneCredit.Base;
//                     MontantCredit := LigneCredit.Base;
//                 end
//                 else
//                     LigneCredit.Base := MontantBase;
//                 Montant := (MontantCredit * TauxCredit / 1200) / (1 - Power(1 + TauxCredit / 1200, -NombreTranche));
//                 LigneCredit.Interet := LigneCredit.Base * TauxCredit / 1200;
//                 LigneCredit.Amortissement := Montant - LigneCredit.Interet;
//                 LigneCredit.Mensualité := Montant;
//                 LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//                 MontantBase := LigneCredit."Val Fin";
//                 LigneCredit.Modify;
//             until LigneCredit.Next = 0;
//     end;


//     procedure SemestrialiteConstante(NumeroLigne: Integer; TauxTmm: Decimal)
//     begin
//         Clear(LigneCredit);
//         Montant := 0;
//         TauxCredit := 0;
//         Compteur := 0;
//         MontantBase := 0;
//         if EnteteCredit.Get(REC."Numero Credit") then TauxCredit := TauxTmm + EnteteCredit."Taux Interet";
//         if TauxCredit = 0 then exit;
//         LigneCredit2.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit2.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit2.FindFirst then NombreTranche := LigneCredit2.Count;
//         LigneCredit.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit.FindFirst then
//             repeat
//                 Compteur += 1;
//                 if Compteur = 1 then begin
//                     LigneCredit.Base := LigneCredit.Base;
//                     MontantCredit := LigneCredit.Base;
//                 end
//                 else
//                     LigneCredit.Base := MontantBase;
//                 Montant := (MontantCredit * TauxCredit / 200) / (1 - Power(1 + TauxCredit / 200, -NombreTranche));
//                 LigneCredit.Interet := LigneCredit.Base * TauxCredit / 200;
//                 LigneCredit.Amortissement := Montant - LigneCredit.Interet;
//                 LigneCredit.Semestrialité := Montant;
//                 LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//                 MontantBase := LigneCredit."Val Fin";
//                 LigneCredit.Modify;
//             until LigneCredit.Next = 0;
//     end;


//     procedure TrimestrialiteConstante(NumeroLigne: Integer; TauxTmm: Decimal)
//     begin
//         Clear(LigneCredit);
//         Montant := 0;
//         TauxCredit := 0;
//         Compteur := 0;
//         MontantBase := 0;
//         if EnteteCredit.Get(REC."Numero Credit") then TauxCredit := TauxTmm + EnteteCredit."Taux Interet";
//         if TauxCredit = 0 then exit;
//         LigneCredit2.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit2.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit2.FindFirst then NombreTranche := LigneCredit2.Count;
//         LigneCredit.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit.FindFirst then
//             repeat
//                 Compteur += 1;
//                 if Compteur = 1 then begin
//                     LigneCredit.Base := LigneCredit.Base;
//                     MontantCredit := LigneCredit.Base;
//                 end
//                 else
//                     LigneCredit.Base := MontantBase;
//                 Montant := (MontantCredit * TauxCredit / 400) / (1 - Power(1 + TauxCredit / 400, -NombreTranche));
//                 LigneCredit.Interet := LigneCredit.Base * TauxCredit / 400;
//                 LigneCredit.Amortissement := Montant - LigneCredit.Interet;
//                 LigneCredit.Trimestrialité := Montant;
//                 LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//                 MontantBase := LigneCredit."Val Fin";
//                 LigneCredit.Modify;
//             until LigneCredit.Next = 0;
//     end;


//     procedure "AnnuitéDegressive"(NumeroLigne: Integer; TauxTmm: Decimal)
//     begin
//         Clear(LigneCredit);
//         Montant := 0;
//         TauxCredit := 0;
//         Compteur := 0;
//         MontantBase := 0;
//         if EnteteCredit.Get(REC."Numero Credit") then TauxCredit := TauxTmm + EnteteCredit."Taux Interet";
//         if TauxCredit = 0 then exit;
//         LigneCredit2.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit2.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit2.FindFirst then NombreTranche := LigneCredit2.Count;
//         LigneCredit.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit.FindFirst then
//             repeat
//                 Compteur += 1;
//                 if Compteur = 1 then begin
//                     LigneCredit.Base := LigneCredit.Base;
//                     MontantCredit := LigneCredit.Base;
//                 end
//                 else
//                     LigneCredit.Base := MontantBase;

//                 LigneCredit.Interet := LigneCredit.Base * TauxCredit / 100;
//                 LigneCredit.Amortissement := MontantCredit / NombreTranche;
//                 LigneCredit.Annuité := LigneCredit.Amortissement + LigneCredit.Interet;
//                 LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//                 MontantBase := LigneCredit."Val Fin";
//                 LigneCredit.Modify;
//             until LigneCredit.Next = 0;
//     end;


//     procedure "MensualitéDegressive"(NumeroLigne: Integer; TauxTmm: Decimal)
//     begin
//         Clear(LigneCredit);
//         Montant := 0;
//         TauxCredit := 0;
//         Compteur := 0;
//         MontantBase := 0;
//         if EnteteCredit.Get(REC."Numero Credit") then TauxCredit := TauxTmm + EnteteCredit."Taux Interet";
//         if TauxCredit = 0 then exit;
//         LigneCredit2.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit2.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit2.FindFirst then NombreTranche := LigneCredit2.Count;
//         LigneCredit.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit.FindFirst then
//             repeat
//                 Compteur += 1;
//                 if Compteur = 1 then begin
//                     LigneCredit.Base := LigneCredit.Base;
//                     MontantCredit := LigneCredit.Base;
//                 end
//                 else
//                     LigneCredit.Base := MontantBase;

//                 LigneCredit.Interet := LigneCredit.Base * TauxCredit / 1200;
//                 LigneCredit.Amortissement := MontantCredit / NombreTranche;
//                 LigneCredit.Mensualité := LigneCredit.Amortissement + LigneCredit.Interet;
//                 LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//                 MontantBase := LigneCredit."Val Fin";
//                 LigneCredit.Modify;
//             until LigneCredit.Next = 0;
//     end;


//     procedure SemestrialiteDegressive(NumeroLigne: Integer; TauxTmm: Decimal)
//     begin
//         Clear(LigneCredit);
//         Montant := 0;
//         TauxCredit := 0;
//         Compteur := 0;
//         MontantBase := 0;
//         if EnteteCredit.Get(REC."Numero Credit") then TauxCredit := TauxTmm + EnteteCredit."Taux Interet";
//         if TauxCredit = 0 then exit;
//         LigneCredit2.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit2.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit2.FindFirst then NombreTranche := LigneCredit2.Count;
//         LigneCredit.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit.FindFirst then
//             repeat
//                 Compteur += 1;
//                 if Compteur = 1 then begin
//                     LigneCredit.Base := LigneCredit.Base;
//                     MontantCredit := LigneCredit.Base;
//                 end
//                 else
//                     LigneCredit.Base := MontantBase;

//                 LigneCredit.Interet := LigneCredit.Base * TauxCredit / 200;
//                 LigneCredit.Amortissement := MontantCredit / NombreTranche;
//                 LigneCredit.Semestrialité := LigneCredit.Amortissement + LigneCredit.Interet;
//                 LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//                 MontantBase := LigneCredit."Val Fin";
//                 LigneCredit.Modify;
//             until LigneCredit.Next = 0;
//     end;


//     procedure TrimestrialiteDegressive(NumeroLigne: Integer; TauxTmm: Decimal)
//     begin
//         Clear(LigneCredit);
//         Montant := 0;
//         TauxCredit := 0;
//         Compteur := 0;
//         MontantBase := 0;
//         if EnteteCredit.Get(REC."Numero Credit") then TauxCredit := TauxTmm + EnteteCredit."Taux Interet";
//         if TauxCredit = 0 then exit;
//         LigneCredit2.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit2.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit2.FindFirst then NombreTranche := LigneCredit2.Count;
//         LigneCredit.SetRange("Numero Credit", REC."Numero Credit");
//         LigneCredit.SetFilter(Numero, '>=%1', NumeroLigne);
//         if LigneCredit.FindFirst then
//             repeat
//                 Compteur += 1;
//                 if Compteur = 1 then begin
//                     LigneCredit.Base := LigneCredit.Base;
//                     MontantCredit := LigneCredit.Base;
//                 end
//                 else
//                     LigneCredit.Base := MontantBase;

//                 LigneCredit.Interet := LigneCredit.Base * TauxCredit / 400;
//                 LigneCredit.Amortissement := MontantCredit / NombreTranche;
//                 LigneCredit.Trimestrialité := LigneCredit.Amortissement + LigneCredit.Interet;
//                 LigneCredit."Val Fin" := LigneCredit.Base - LigneCredit.Amortissement;
//                 MontantBase := LigneCredit."Val Fin";
//                 LigneCredit.Modify;
//             until LigneCredit.Next = 0;
//     end;
// }

