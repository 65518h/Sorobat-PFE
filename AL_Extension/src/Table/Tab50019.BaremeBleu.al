// Table 50019 "Bareme Bleu"
// {
//     DrillDownPageID = "Bareme Bleu";
//     LookupPageID = "Bareme Bleu";

//     fields
//     {
//         field(1; "Classe Immo"; Code[20])
//         {
//         }
//         field(2; Description; Text[250])
//         {
//         }
//         field(3; "Date Acquisition"; Date)
//         {

//             trigger OnValidate()
//             begin
//                 "Annee Acquistion (0)" := Date2dmy("Date Acquisition", 3);
//                 "Mois Acquistion (0)" := Date2dmy("Date Acquisition", 2);
//                 "Annee Acquistion (T)" := Date2dmy(Today, 3);
//                 "Mois Acquistion (T)" := Date2dmy(Today, 2);
//                 if BBIM.Get("Annee Acquistion (0)", "Mois Acquistion (0)") then Validate("IM(0)", BBIM.IM);
//                 if BBIM.Get("Annee Acquistion (T)", "Mois Acquistion (T)") then Validate("IM(T)", BBIM.IM);
//             end;
//         }
//         field(4; "Cout Acquisition (T0)"; Decimal)
//         {
//             Description = 'IM = Indice Materiel';

//             trigger OnValidate()
//             begin
//                 if "IM(T)" <> 0 then Validate("Cout Acquisition (Ti)", "Cout Acquisition (T0)" * ("IM(T)" / "IM(0)"));
//             end;
//         }
//         field(5; "IM(0)"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 if "IM(T)" <> 0 then Validate("Cout Acquisition (Ti)", "Cout Acquisition (T0)" * ("IM(T)" / "IM(0)"));
//             end;
//         }
//         field(6; "IM(T)"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 if "IM(0)" <> 0 then Validate("Cout Acquisition (Ti)", "Cout Acquisition (T0)" * ("IM(T)" / "IM(0)"));
//             end;
//         }
//         field(7; "Cout Acquisition (Ti)"; Decimal)
//         {
//         }
//         field(8; T; Integer)
//         {
//             Description = 'Longivité Ou Année Amortissement Saisie';

//             trigger OnValidate()
//             begin
//                 if T <> 0 then Validate(N, 100 / T);
//             end;
//         }
//         field(9; N; Decimal)
//         {
//             Description = 'Amortissement = 100/T';

//             trigger OnValidate()
//             begin
//                 if I <> 0 then begin
//                     Validate(CI, (I + N) / 360);
//                     Validate(CS, ROUND((100 * (1 / 8) * (N / 360) + (M / 171)), 0.01));
//                     Validate(IM, ("Cout Acquisition (Ti)" / 100) * ((3 / 2) * CI));
//                     Validate(UM, ("Cout Acquisition (Ti)" / 100) * ((7 / 5) * CU));
//                 end;
//             end;
//         }
//         field(10; I; Decimal)
//         {
//             Description = 'Taux Annuelle d''Entretient 8% Saisie';

//             trigger OnValidate()
//             begin
//                 if N <> 0 then begin
//                     Validate(CI, (I + N) / 360);
//                     Validate(LJ, ("Cout Acquisition (Ti)" / 100) * ((3 / 2) * CI + (5 / 7) * CU));
//                     Validate(IM, ("Cout Acquisition (Ti)" / 100) * ((3 / 2) * CI));
//                     Validate(UM, ("Cout Acquisition (Ti)" / 100) * ((7 / 5) * CU));
//                 end;
//             end;
//         }
//         field(11; M; Decimal)
//         {
//             Description = 'Charge de Gros Entretient Saisie';

//             trigger OnValidate()
//             begin
//                 Validate(CU, ROUND((M / 171) * 100, 0.01));
//                 Validate(CS, ROUND((100 * (1 / 8) * (N / 360) + (M / 171)), 0.01));
//             end;
//         }
//         field(12; CU; Decimal)
//         {
//             Description = 'Charge Utilisation = M/171';
//         }
//         field(13; CI; Decimal)
//         {
//             Description = 'Charge d''Immobilisation = (I+N) / 360';
//         }
//         field(14; CS; Decimal)
//         {
//             Description = 'Charge Supplementaire (Heure Supp)= 1/8 * ( N/360 + M/171)';
//         }
//         field(15; LJ; Decimal)
//         {
//             Description = 'Location Journaliere =(Cout Acquisition (Ti)/100) * (3/2*CI +5/7 * CU)';
//         }
//         field(16; IM; Decimal)
//         {
//             Description = 'Immobilisation Materiel =[(Cout Acquisition (Ti)/100) * (3/2*CI )]/9';
//         }
//         field(17; UM; Decimal)
//         {
//             Description = 'Utilisation Materiel=[(Cout Acquisition (Ti)/100) * (3/2*CU )]/9';
//         }
//         field(18; "Annee Acquistion (0)"; Integer)
//         {
//         }
//         field(19; "Mois Acquistion (0)"; Integer)
//         {
//         }
//         field(20; "Annee Acquistion (T)"; Integer)
//         {

//             trigger OnValidate()
//             begin
//                 if BBIM.Get("Annee Acquistion (T)", "Mois Acquistion (T)") then Validate("IM(T)", BBIM.IM);
//             end;
//         }
//         field(21; "Mois Acquistion (T)"; Integer)
//         {

//             trigger OnValidate()
//             begin
//                 if BBIM.Get("Annee Acquistion (T)", "Mois Acquistion (T)") then Validate("IM(T)", BBIM.IM);
//             end;
//         }
//         field(22; Consommation; Decimal)
//         {
//             Description = 'Consommation Gasoil / Huile /Lubrifiant';
//         }
//         field(23; Lubrifiant; Decimal)
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "Classe Immo")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         BBIM: Record "Bareme Bleu IM";
// }

