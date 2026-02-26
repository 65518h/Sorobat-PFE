// Table 50021 "Messenger Utilisateur"
// {

//     fields
//     {
//         field(1; "Messenger User ID"; Code[20])
//         {
//         }
//         field(2; Name; Text[50])
//         {
//         }
//         field(10; "Login Time"; Time)
//         {
//         }
//         field(11; "Login Date"; Date)
//         {
//         }
//         field(12; "Idle Time"; Duration)
//         {
//         }
//         field(50001; "Online/Offline"; Option)
//         {
//             OptionMembers = Online,Offline;
//         }
//     }

//     keys
//     {
//         key(Key1; "Messenger User ID")
//         {
//             Clustered = true;
//         }
//         key(Key2; "Online/Offline", "Messenger User ID")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }
// }

