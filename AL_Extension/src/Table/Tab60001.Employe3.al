// Table 60001 "Employe 3"
// {

//     fields
//     {
//         field(1; "Code"; Code[20])
//         {
//         }
//         field(2; "Nom Et Prenom"; Text[50])
//         {
//         }
//         field(3; Sex; Option)
//         {
//             OptionMembers = " ",M,F;
//         }
//         field(4; Age; Integer)
//         {
//         }
//         field(5; "Salaire de base"; Decimal)
//         {
//         }
//         field(6; "Arti le Preference"; Code[20])
//         {
//             TableRelation = Item."No.";
//         }
//         field(7; "Article Description"; Text[100])
//         {
//             CalcFormula = lookup(Item.Description where("No." = field("Arti le Preference")));
//             Enabled = true;
//             FieldClass = FlowField;
//         }
//         field(8; client; Code[20])
//         {
//             TableRelation = Customer;
//         }
//         field(9; "Somme Facture"; Decimal)
//         {
//         }
//         field(10; "Nom Hosni"; Integer)
//         {
//             CalcFormula = count(Employee where(Gender = const(Female)));
//             FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "Code")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

