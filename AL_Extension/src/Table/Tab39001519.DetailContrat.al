// Table 39001519 "Detail Contrat"
// {
//     //GL2024  ID dans Nav 2009 : "39001519"
//     fields
//     {
//         field(1; "N° Contrat"; Code[20])
//         {
//         }
//         field(2; Fournisseurs; Code[20])
//         {
//             TableRelation = Vendor;
//         }
//         field(3; "Nom Fournisseurs"; Text[50])
//         {
//             CalcFormula = lookup(Vendor.Name where("No." = field(Fournisseurs)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(4; Nombre; Integer)
//         {
//             Editable = true;
//         }
//         field(5; Description; Text[250])
//         {
//         }
//         field(6; "Prix TTC"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = true;
//         }
//         field(7; Ligne; Integer)
//         {
//             AutoIncrement = true;
//         }
//     }

//     keys
//     {
//         key(Key1; "N° Contrat", Fournisseurs, Ligne)
//         {
//             Clustered = true;
//             SumIndexFields = "Prix TTC";
//         }
//     }

//     fieldgroups
//     {
//     }
// }

