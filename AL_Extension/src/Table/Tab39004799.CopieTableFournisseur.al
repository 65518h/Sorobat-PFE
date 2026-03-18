// Table 39004799 "Copie Table Fournisseur"
// {
//     //GL2024  ID dans Nav 2009 : "39004799"
//     fields
//     {
//         field(1; "No."; Code[20])
//         {
//         }
//         field(2; Name; Text[50])
//         {
//             Caption = 'Name';
//         }
//         field(27; "Payment Terms Code"; Code[10])
//         {
//             Caption = 'Payment Terms Code';
//             TableRelation = "Payment Terms";
//         }
//         field(35; "Country/Region Code"; Code[10])
//         {
//             Caption = 'Country/Region Code';
//             TableRelation = "Country/Region";
//         }
//         field(47; "Payment Method Code"; Code[10])
//         {
//             Caption = 'Payment Method Code';
//             TableRelation = "Payment Method";
//         }
//         field(86; "VAT Registration No."; Text[20])
//         {
//             Caption = 'VAT Registration No.';

//             trigger OnValidate()
//             var
//                 VATRegNoFormat: Record "VAT Registration No. Format";
//             begin
//             end;
//         }
//         field(50006; "Regime D'imposition"; Option)
//         {
//             Description = 'HJ DSFT 05-10-2012';
//             OptionMembers = " ",Moral,Physique;
//         }
//         field(50009; "Type identifiant"; Option)
//         {
//             OptionMembers = " ","Matricule Fiscal",CIN,"N° Passeport","N° Carte Sejour";
//         }
//         field(50010; "Activité"; Text[50])
//         {
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "No.")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

