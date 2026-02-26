// Table 39004742 "Ligne BT Enreg"
// {
//     //GL2024  ID dans Nav 2009 : "39004742"
//     fields
//     {
//         field(1; "Code BT"; Code[20])
//         {
//             TableRelation = "Entete BT Enreg".Code;
//         }
//         field(2; "Num Ligne"; Integer)
//         {
//         }
//         field(3; "Code Equipement"; Code[20])
//         {
//         }
//         field(4; "Code Gamme"; Code[30])
//         {
//         }
//         field(5; "Code Article"; Code[20])
//         {
//         }
//         field(6; Designiation; Text[200])
//         {
//             CalcFormula = lookup(Item.Description where("No." = field("Code Article")));
//             FieldClass = FlowField;
//         }
//         field(7; "Date Lancement"; Date)
//         {
//         }
//         field(8; "Type BT"; Option)
//         {
//             OptionMembers = Curative,Preventive;
//         }
//         field(9; Quantite; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Editable = false;
//         }
//         field(10; "Cout Article"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(11; "Cout Ligne"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(12; "Quantite Connsomée"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(50002; "DA Associé"; Code[20])
//         {
//             // TableRelation = "Sales Header"."No." where("Document Type" = filter(Order),
//             //                                             "Order Type" = const("Supply Order"),
//             //                                             Statut = filter(<> Archiver));
//         }
//     }

//     keys
//     {
//         key(Key1; "Code BT", "Num Ligne", "Code Article")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

