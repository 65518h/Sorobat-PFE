// table 39001544 "Decompte - Masse par Chantier"
// {
//     //GL2024  ID dans Nav 2009 : "39001544"
//     fields
//     {
//         field(1; Chantier; Code[20])
//         {
//             TableRelation = Job."No.";
//         }
//         field(2; Month; Option)
//         {
//             Caption = 'Month';
//             Editable = true;
//             OptionCaption = 'Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,Congé,Prime,Rappel,Solder jour de congé';


//             OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,Rappel,"Solder jour de congé";
//         }
//         field(3; Year; Integer)
//         {
//         }
//         field(4; Masse; Decimal)
//         {
//         }
//         field(5; "Decompte Montant"; Decimal)
//         {
//         }
//     }

//     keys
//     {
//         key(STG_Key1; Chantier, Year, Month)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

