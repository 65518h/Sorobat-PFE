// Table 39001518 Contrat
// {//GL2024  ID dans Nav 2009 : "39001518"
//     DrillDownPageID = "Liste Contrat Leasing";
//     LookupPageID = "Liste Contrat Leasing";

//     fields
//     {
//         field(1; "N°"; Code[20])
//         {
//         }
//         field(2; "Date Contrat"; Date)
//         {
//         }
//         field(3; Fournisseur; Code[20])
//         {
//             TableRelation = Vendor;
//         }
//         field(4; "Nom Fournisseur"; Text[50])
//         {
//             CalcFormula = lookup(Vendor.Name where("No." = field(Fournisseur)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(5; Duree; Integer)
//         {
//         }
//         field(6; Periodicite; Option)
//         {
//             OptionMembers = Mensuelle,Annuelle;
//         }
//         field(7; "Date Depart"; Date)
//         {
//         }
//         field(8; Observation; Text[250])
//         {
//         }
//         field(9; "Total TTC"; Decimal)
//         {
//             CalcFormula = sum("Detail Contrat"."Prix TTC" where("N° Contrat" = field("N°")));
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(10; "Montant Loyer TTC"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(11; "Montant Loyer HT"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(12; Statut; Option)
//         {
//             OptionMembers = "En Cours","Main Levé";
//         }
//         field(13; Banque; Code[20])
//         {
//             TableRelation = "Bank Account";
//         }
//         field(14; "Nom Banque"; Text[50])
//         {
//             CalcFormula = lookup("Bank Account".Name where("No." = field(Banque)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(Key1; "N°")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

