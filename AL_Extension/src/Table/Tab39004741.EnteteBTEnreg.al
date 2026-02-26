// Table 39004741 "Entete BT Enreg"
// {
//     //GL2024  ID dans Nav 2009 : "39004741"
//     LookupPageID = "Liste BT GMAO Enre";

//     fields
//     {
//         field(1; "Code"; Code[20])
//         {
//         }
//         field(2; Type; Option)
//         {
//             OptionMembers = Curative,Preventive;
//         }
//         field(3; "Date Lancement"; Date)
//         {
//         }
//         field(4; Equipement; Code[20])
//         {
//             TableRelation = Véhicule;
//         }
//         field(5; "Designiation Equipement"; Text[60])
//         {
//         }
//         field(6; Gamme; Code[30])
//         {
//             TableRelation = Gamme."Code Gamme";
//         }
//         field(7; "Designiation Gamme"; Text[200])
//         {
//         }
//         field(9; Observation; Text[120])
//         {
//         }
//         field(10; "Date Traitement"; Date)
//         {
//         }
//         field(11; Frequence; Decimal)
//         {
//         }
//         field(12; Status; Option)
//         {
//             OptionMembers = "Lancé","En attente d'autorisation","En attente de devis","En attente info complémentaire","En attente d'articles","Archivé","Executé";
//         }
//         field(13; "Cout Article"; Decimal)
//         {
//             CalcFormula = sum("Ligne BT"."Cout Ligne" where("Code BT" = field(Code)));
//             DecimalPlaces = 3 : 3;
//             FieldClass = FlowField;
//         }
//         field(14; "Cout Main d'oeuvre"; Decimal)
//         {
//             CalcFormula = sum("Intervenants BT"."Cout Ligne Intervention" where("Code BT" = field(Code)));
//             DecimalPlaces = 3 : 3;
//             FieldClass = FlowField;
//         }
//         field(15; "Cout BT"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(16; "Index Actuelle"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(17; Immatriculation; Code[20])
//         {
//             CalcFormula = lookup(Véhicule.Immatriculation where("N° Vehicule" = field(Equipement)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(18; Atelier; Code[20])
//         {
//         }
//         field(19; "Date Objectif"; Date)
//         {
//         }
//         field(50000; Chauffeur; Code[50])
//         {
//             TableRelation = "Chauffeur Location";
//         }
//         field(50001; "Vehicule Mission"; Code[20])
//         {
//             TableRelation = Véhicule;
//         }
//         field(50002; Utilisateur; Code[20])
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "Code")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

