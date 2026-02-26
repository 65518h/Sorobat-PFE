

// Table 58000 "vrif tiers et grp cpta"
// {

//     fields
//     {
//         field(1; tiers; Code[20])
//         {
//         }
//         field(2; "type tiers"; Option)
//         {
//             OptionMembers = " ",frs,clt,bq;
//         }
//         field(3; "grp comptta"; Boolean)
//         {
//         }
//         field(4; "exist frs"; Boolean)
//         {
//             CalcFormula = exist(Vendor where("Ancien Numero" = field(tiers)));
//             FieldClass = FlowField;
//         }
//         field(5; "exist clt"; Boolean)
//         {
//         }
//         field(6; "nom frs"; Text[100])
//         {
//             CalcFormula = lookup(Vendor.Name where("Ancien Numero" = field(tiers)));
//             FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(Key1; tiers)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

