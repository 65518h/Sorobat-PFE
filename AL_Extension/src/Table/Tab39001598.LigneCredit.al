// Table 39001598 "Ligne Credit"
// {
//     //GL2024  ID dans Nav 2009 : "39001598"
//     fields
//     {
//         field(1; "Numero Credit"; Code[20])
//         {
//         }
//         field(2; "Annnée"; Integer)
//         {
//         }
//         field(3; Numero; Integer)
//         {
//         }
//         field(4; Base; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(5; Interet; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(6; Amortissement; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(7; "Annuité"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(8; "Val Fin"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(9; Mois; Code[10])
//         {
//         }
//         field(10; "Mensualité"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;

//             trigger OnValidate()
//             begin
//                 if EnteteCredit."Type Calcul" = EnteteCredit."type calcul"::"Trimestrailité Degressive" then TrimestrialiteDegressive;
//             end;
//         }
//         field(11; Statut; Option)
//         {
//             OptionMembers = "En Cours","Payé","Impayé";
//         }
//         field(12; "Nouveau TMM"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 /*IF NOT CONFIRM(Text001) THEN EXIT;
//                 EnteteCredit.GET("Numero Credit");
//                 IF EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Annuité Constante" THEN AnnuitéConstante;
//                 IF EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Mensualité Constante" THEN MensualitéConstante;
//                 IF EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Semestrialité Constante" THEN SemestrialiteConstante;
//                 IF EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Trimestrailité Constante" THEN TrimestrialiteConstante;
//                 IF EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Annuité Degressive" THEN AnnuitéDegressive;
//                 IF EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Mensualité Degressive" THEN MensualitéDegressive;
//                 IF EnteteCredit."Type Calcul"=EnteteCredit."Type Calcul"::"Semestrialité Degressive" THEN SemestrialiteDegressive;
//                 */

//             end;
//         }
//         field(13; "Trimestrialité"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//         }
//         field(14; "Semestrialité"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "Numero Credit", Numero)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
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


//     procedure "AnnuitéConstante"()
//     begin
//         Clear(LigneCredit);
//         if EnteteCredit.Get("Numero Credit") then TauxCredit := "Nouveau TMM" + EnteteCredit."Taux Interet";
//         LigneCredit2.SetFilter(Numero, '>=%1', Numero);
//         if LigneCredit2.FindFirst then NombreTranche := LigneCredit2.Count;
//         LigneCredit.SetFilter(Numero, '>=%1', Numero);
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
//                 Commit;
//             until LigneCredit.Next = 0;
//     end;


//     procedure "MensualitéConstante"()
//     begin
//     end;


//     procedure SemestrialiteConstante()
//     begin
//     end;


//     procedure TrimestrialiteConstante()
//     begin
//     end;


//     procedure "AnnuitéDegressive"()
//     begin
//     end;


//     procedure "MensualitéDegressive"()
//     begin
//     end;


//     procedure SemestrialiteDegressive()
//     begin
//     end;


//     procedure TrimestrialiteDegressive()
//     begin
//     end;
// }

