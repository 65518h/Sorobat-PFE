// Table 39001535 "Materiaux BL Beton"
// {
//     //GL2024  ID dans Nav 2009 : "39001535"
//     fields
//     {
//         field(1; Mat_ID; Code[20])
//         {
//         }
//         field(2; Mat_Code; Code[20])
//         {
//         }
//         field(3; Mat_Nom; Text[100])
//         {
//         }
//         field(4; "Mat_Unité"; Code[20])
//         {
//         }
//         field(50000; Correspondance; Code[20])
//         {
//             TableRelation = Item;
//         }
//         field(50001; "Divison Par"; Integer)
//         {
//         }
//         field(50002; "Description Correspondance"; Text[100])
//         {
//             CalcFormula = lookup(Item.Description where("No." = field(Correspondance)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(Key1; Mat_ID)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

