// Table 39004740 "Ligne BT"
// {
//     //GL2024  ID dans Nav 2009 : "39004740"
//     fields
//     {
//         field(1; "Code BT"; Code[20])
//         {
//             TableRelation = "Entete BT".Code;
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
//             TableRelation = Item."No.";

//             trigger OnValidate()
//             begin
//                 RecEnteteBT.SetRange(Code, "Code BT");
//                 if RecEnteteBT.FindFirst then begin
//                     "Date Lancement" := RecEnteteBT."Date Lancement";
//                 end;
//             end;
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
//             //                                             Statut = filter(<> Archiver),
//             //                                             Engin = field("Code Equipement"));
//         }
//     }

//     keys
//     {
//         key(Key1; "Code BT", "Num Ligne", "Code Article")
//         {
//             Clustered = true;
//             SumIndexFields = "Cout Ligne";
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         RecEnteteBT: Record "Entete BT";
// }

