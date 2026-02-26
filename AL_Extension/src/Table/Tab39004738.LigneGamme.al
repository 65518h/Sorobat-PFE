// Table 39004738 "Ligne Gamme"
// {
//     //GL2024  ID dans Nav 2009 : "39004738"
//     fields
//     {
//         field(1; "Code Gamme"; Code[30])
//         {
//             TableRelation = Gamme."Code Gamme";
//         }
//         field(2; "Code sous Famille"; Code[20])
//         {
//         }
//         field(3; "Code Article"; Code[20])
//         {
//             TableRelation = Item;

//             trigger OnValidate()
//             begin
//                 if RecGamme.Get("Code Gamme") then
//                     "Code sous Famille" := RecGamme."Code sous Famille Equipement";
//             end;
//         }
//         field(4; "Designiation Article"; Text[200])
//         {
//             CalcFormula = lookup(Item.Description where("No." = field("Code Article")));
//             FieldClass = FlowField;
//         }
//         field(5; Quantite; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(6; Status; Option)
//         {
//             Description = 'a supprimer';
//             OptionMembers = "En Instance","Validé";
//         }
//     }

//     keys
//     {
//         key(Key1; "Code Gamme", "Code sous Famille", "Code Article")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         RecGamme: Record Gamme;
// }

