// Table 39001514 "Chiffre Affaire"
// {
//     //GL2024  ID dans Nav 2009 : "39001514"
//     LookupPageID = "Liste Chifre D'affaire";

//     fields
//     {
//         field(1; "N° Compte"; Text[50])
//         {
//             TableRelation = Customer."No.";

//             trigger OnValidate()
//             begin
//                 RecCustomer.Reset;
//                 if RecCustomer.Get("N° Compte") then Projet := RecCustomer.Name;
//             end;
//         }
//         field(2; Projet; Text[250])
//         {
//             Editable = false;
//         }
//         field(3; Date; Date)
//         {

//             trigger OnValidate()
//             begin

//                 Mois := Date2dmy(Date, 2);
//                 Année := Date2dmy(Date, 3);

//                 if Mois = 1 then Periode := 'Janvier / ' + Format(Année);
//                 if Mois = 2 then Periode := 'Février / ' + Format(Année);
//                 if Mois = 3 then Periode := 'Mars / ' + Format(Année);
//                 if Mois = 4 then Periode := 'Avril / ' + Format(Année);
//                 if Mois = 5 then Periode := 'Mai / ' + Format(Année);
//                 if Mois = 6 then Periode := 'Juin / ' + Format(Année);
//                 if Mois = 7 then Periode := 'Juillet / ' + Format(Année);
//                 if Mois = 8 then Periode := 'Aout / ' + Format(Année);
//                 if Mois = 9 then Periode := 'Septembre / ' + Format(Année);
//                 if Mois = 10 then Periode := 'Octobre / ' + Format(Année);
//                 if Mois = 11 then Periode := 'Novembre / ' + Format(Année);
//                 if Mois = 12 then Periode := 'Décembre / ' + Format(Année);

//                 //********************
//                 if "Taux RS TVA" = 1 then
//                     "RS TVA" := TVA / 4
//                 else
//                     if "Taux RS TVA" = 2 then
//                         "RS TVA" := TVA / 2
//                     else
//                         "RS TVA" := 0;
//             end;
//         }
//         field(4; Mois; Integer)
//         {
//             Editable = false;
//         }
//         field(5; "Année"; Integer)
//         {
//             Editable = false;
//         }
//         field(6; "Dec."; Integer)
//         {
//         }
//         field(7; HT; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//         }
//         field(8; TVA; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//         }
//         field(9; TTC; Decimal)
//         {
//             DecimalPlaces = 3 : 3;

//             trigger OnValidate()
//             begin
//                 TVA := (TTC / 1.18) * (0.18);
//                 HT := TTC - (TTC / 1.18) * (0.18);
//                 "Travaux TTC" := "Avance TTC" + TTC;
//                 "RS Marché" := (TTC * 1.5) / 100;
//                 Net := TTC - "RS TVA" - "RS Marché";
//                 "Solde D/F" := Net - FP - HB;
//                 "Tot encaissé" := FP + HB;

//                 if Mois = 1 then Periode := 'Janvier / ' + Format(Année);
//                 if Mois = 2 then Periode := 'Février / ' + Format(Année);
//                 if Mois = 3 then Periode := 'Mars / ' + Format(Année);
//                 if Mois = 4 then Periode := 'Avril / ' + Format(Année);
//                 if Mois = 5 then Periode := 'Mai / ' + Format(Année);
//                 if Mois = 6 then Periode := 'Juin / ' + Format(Année);
//                 if Mois = 7 then Periode := 'Juillet / ' + Format(Année);
//                 if Mois = 8 then Periode := 'Aout / ' + Format(Année);
//                 if Mois = 9 then Periode := 'Septembre / ' + Format(Année);
//                 if Mois = 10 then Periode := 'Octobre / ' + Format(Année);
//                 if Mois = 11 then Periode := 'Novembre / ' + Format(Année);
//                 if Mois = 12 then Periode := 'Décembre / ' + Format(Année);

//                 //********************
//                 if "Taux RS TVA" = 1 then
//                     "RS TVA" := TVA / 4
//                 else
//                     if "Taux RS TVA" = 2 then
//                         "RS TVA" := TVA / 2
//                     else
//                         "RS TVA" := 0;
//             end;
//         }
//         field(10; "Avance TTC"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;

//             trigger OnValidate()
//             begin
//                 "Travaux TTC" := "Avance TTC" + TTC;
//                 TVA := (TTC / 1.18) * (0.18);
//                 HT := TTC - (TTC / 1.18) * (0.18);
//                 "RS TVA" := TVA / 4;
//                 "RS Marché" := (TTC * 1.5) / 100;
//                 Net := TTC - "RS TVA" - "RS Marché";
//                 "Solde D/F" := Net - FP - HB;
//                 "Tot encaissé" := FP + HB;
//                 if Mois = 1 then Periode := 'Janvier / ' + Format(Année);
//                 if Mois = 2 then Periode := 'Février / ' + Format(Année);
//                 if Mois = 3 then Periode := 'Mars / ' + Format(Année);
//                 if Mois = 4 then Periode := 'Avril / ' + Format(Année);
//                 if Mois = 5 then Periode := 'Mai / ' + Format(Année);
//                 if Mois = 6 then Periode := 'Juin / ' + Format(Année);
//                 if Mois = 7 then Periode := 'Juillet / ' + Format(Année);
//                 if Mois = 8 then Periode := 'Aout / ' + Format(Année);
//                 if Mois = 9 then Periode := 'Septembre / ' + Format(Année);
//                 if Mois = 10 then Periode := 'Octobre / ' + Format(Année);
//                 if Mois = 11 then Periode := 'Novembre / ' + Format(Année);
//                 if Mois = 12 then Periode := 'Décembre / ' + Format(Année);
//                 //********************
//                 if "Taux RS TVA" = 1 then
//                     "RS TVA" := TVA / 4
//                 else
//                     if "Taux RS TVA" = 2 then
//                         "RS TVA" := TVA / 2
//                     else
//                         "RS TVA" := 0;
//             end;
//         }
//         field(11; "Travaux TTC"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//         }
//         field(12; "Mois Décl décompte"; Date)
//         {
//         }
//         field(13; "RS TVA"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//         }
//         field(14; "RS Marché"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//         }
//         field(15; "Certif RS"; Date)
//         {
//         }
//         field(16; Net; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//         }
//         field(17; FP; Decimal)
//         {
//             DecimalPlaces = 3 : 3;

//             trigger OnValidate()
//             begin
//                 TVA := (TTC / 1.18) * (0.18);
//                 HT := TTC - (TTC / 1.18) * (0.18);
//                 "Travaux TTC" := "Avance TTC" + TTC;
//                 "RS TVA" := TVA / 4;
//                 "RS Marché" := (TTC * 1.5) / 100;
//                 Net := TTC - "RS TVA" - "RS Marché";
//                 "Solde D/F" := Net - FP - HB;
//                 "Tot encaissé" := FP + HB;
//                 if Mois = 1 then Periode := 'Janvier / ' + Format(Année);
//                 if Mois = 2 then Periode := 'Février / ' + Format(Année);
//                 if Mois = 3 then Periode := 'Mars / ' + Format(Année);
//                 if Mois = 4 then Periode := 'Avril / ' + Format(Année);
//                 if Mois = 5 then Periode := 'Mai / ' + Format(Année);
//                 if Mois = 6 then Periode := 'Juin / ' + Format(Année);
//                 if Mois = 7 then Periode := 'Juillet / ' + Format(Année);
//                 if Mois = 8 then Periode := 'Aout / ' + Format(Année);
//                 if Mois = 9 then Periode := 'Septembre / ' + Format(Année);
//                 if Mois = 10 then Periode := 'Octobre / ' + Format(Année);
//                 if Mois = 11 then Periode := 'Novembre / ' + Format(Année);
//                 if Mois = 12 then Periode := 'Décembre / ' + Format(Année);
//                 //********************
//                 if "Taux RS TVA" = 1 then
//                     "RS TVA" := TVA / 4
//                 else
//                     if "Taux RS TVA" = 2 then
//                         "RS TVA" := TVA / 2
//                     else
//                         "RS TVA" := 0;
//             end;
//         }
//         field(18; "Date encais. FP"; Date)
//         {
//         }
//         field(19; HB; Decimal)
//         {
//             DecimalPlaces = 3 : 3;

//             trigger OnValidate()
//             begin
//                 TVA := (TTC / 1.18) * (0.18);
//                 HT := TTC - (TTC / 1.18) * (0.18);
//                 "Travaux TTC" := "Avance TTC" + TTC;
//                 "RS TVA" := TVA / 4;
//                 "RS Marché" := (TTC * 1.5) / 100;
//                 Net := TTC - "RS TVA" - "RS Marché";
//                 "Solde D/F" := Net - FP - HB;
//                 "Solde D/F" := Net - FP - HB;
//                 "Tot encaissé" := FP + HB;
//                 if Mois = 1 then Periode := 'Janvier / ' + Format(Année);
//                 if Mois = 2 then Periode := 'Février / ' + Format(Année);
//                 if Mois = 3 then Periode := 'Mars / ' + Format(Année);
//                 if Mois = 4 then Periode := 'Avril / ' + Format(Année);
//                 if Mois = 5 then Periode := 'Mai / ' + Format(Année);
//                 if Mois = 6 then Periode := 'Juin / ' + Format(Année);
//                 if Mois = 7 then Periode := 'Juillet / ' + Format(Année);
//                 if Mois = 8 then Periode := 'Aout / ' + Format(Année);
//                 if Mois = 9 then Periode := 'Septembre / ' + Format(Année);
//                 if Mois = 10 then Periode := 'Octobre / ' + Format(Année);
//                 if Mois = 11 then Periode := 'Novembre / ' + Format(Année);
//                 if Mois = 12 then Periode := 'Décembre / ' + Format(Année);
//                 //********************
//                 if "Taux RS TVA" = 1 then
//                     "RS TVA" := TVA / 4
//                 else
//                     if "Taux RS TVA" = 2 then
//                         "RS TVA" := TVA / 2
//                     else
//                         "RS TVA" := 0;
//             end;
//         }
//         field(20; "Date encais. HB"; Date)
//         {
//         }
//         field(21; "Solde D/F"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//         }
//         field(50000; "Tot encaissé"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//         }
//         field(50001; "N° Domiciliation"; Text[250])
//         {
//             TableRelation = "Bank Account"."No.";

//             trigger OnValidate()
//             begin
//                 //  BankAccount.Reset;
//                 // if BankAccount.Get("N° Domiciliation") then "Domiciliation Name" := Format(BankAccount.Banque);
//             end;
//         }
//         field(50002; "Domiciliation Name"; Text[250])
//         {
//             Editable = false;
//         }
//         field(50003; Periode; Text[30])
//         {
//             Editable = false;
//         }
//         field(50004; "R.G"; Boolean)
//         {
//         }
//         field(50005; "Taux RS TVA"; Option)
//         {
//             OptionMembers = " ","25","50";

//             trigger OnValidate()
//             begin
//                 TVA := (TTC / 1.18) * (0.18);
//                 HT := TTC - (TTC / 1.18) * (0.18);
//                 "Travaux TTC" := "Avance TTC" + TTC;
//                 "RS Marché" := (TTC * 1.5) / 100;
//                 Net := TTC - "RS TVA" - "RS Marché";
//                 "Solde D/F" := Net - FP - HB;
//                 "Tot encaissé" := FP + HB;

//                 if Mois = 1 then Periode := 'Janvier / ' + Format(Année);
//                 if Mois = 2 then Periode := 'Février / ' + Format(Année);
//                 if Mois = 3 then Periode := 'Mars / ' + Format(Année);
//                 if Mois = 4 then Periode := 'Avril / ' + Format(Année);
//                 if Mois = 5 then Periode := 'Mai / ' + Format(Année);
//                 if Mois = 6 then Periode := 'Juin / ' + Format(Année);
//                 if Mois = 7 then Periode := 'Juillet / ' + Format(Année);
//                 if Mois = 8 then Periode := 'Aout / ' + Format(Année);
//                 if Mois = 9 then Periode := 'Septembre / ' + Format(Année);
//                 if Mois = 10 then Periode := 'Octobre / ' + Format(Année);
//                 if Mois = 11 then Periode := 'Novembre / ' + Format(Année);
//                 if Mois = 12 then Periode := 'Décembre / ' + Format(Année);
//                 //********************
//                 if "Taux RS TVA" = 1 then
//                     "RS TVA" := TVA / 4
//                 else
//                     if "Taux RS TVA" = 2 then
//                         "RS TVA" := TVA / 2
//                     else
//                         "RS TVA" := 0;
//             end;
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "N° Compte", Date)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         RecCustomer: Record Customer;
//         BankAccount: Record "Bank Account";
//         RecChiffreAffaire: Record "Chiffre Affaire";
// }

