// Table 39004743 "Gamme_Mode Operatoire"
// {
//     //GL2024  ID dans Nav 2009 : "39004743"
//     fields
//     {
//         field(1; "Code Gamme"; Code[30])
//         {
//             TableRelation = Gamme."Code Gamme";
//         }
//         field(2; "N° Ligne"; Integer)
//         {
//         }
//         field(3; Description; Text[250])
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "Code Gamme", "N° Ligne")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnInsert()
//     begin
//         RecGammeModeOperatoire.SetRange("Code Gamme", "Code Gamme");
//         if RecGammeModeOperatoire.FindLast then begin
//             "N° Ligne" := RecGammeModeOperatoire."N° Ligne" + 10000;
//         end
//         else
//             "N° Ligne" := 10000;
//     end;

//     var
//         RecGamme: Record Gamme;
//         RecGammeModeOperatoire: Record "Gamme_Mode Operatoire";
// }

