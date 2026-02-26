// Table 60000 "Employee 2"
// {

//     fields
//     {
//         field(1; matricule; Code[20])
//         {
//         }
//         field(2; nom; Text[50])
//         {
//         }
//         field(3; prenom; Text[50])
//         {
//         }
//         field(4; "total conge"; Decimal)
//         {
//             CalcFormula = sum("Employee's days off Entry".Quantity where("Employee No." = field(matricule),
//                                                                           "From Date" = field("Filtre Date")));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(5; "Nom 2"; Text[50])
//         {
//             //GL2024 CalcFormula = lookup(Employee."First Name" where ("No."=field(matricule)));
//             CalcFormula = lookup(Employee."First Name" where("No." = field(matricule)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(6; "Filtre Date"; Date)
//         {
//             FieldClass = FlowFilter;
//         }
//     }

//     keys
//     {
//         key(Key1; matricule)
//         {
//             Clustered = true;
//         }
//         key(Key2; nom)
//         {
//         }
//     }

//     fieldgroups
//     {
//     }
// }

