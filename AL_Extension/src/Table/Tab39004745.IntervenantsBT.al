// Table 39004745 "Intervenants BT"
// {
//     //GL2024  ID dans Nav 2009 : "39004745"
//     fields
//     {
//         field(1; "Code BT"; Code[20])
//         {

//             trigger OnValidate()
//             begin
//                 if RecEnteteBT.Get("Code BT") then;
//                 Type := RecEnteteBT.Type;
//             end;
//         }
//         field(2; "Code Intervenant"; Code[20])
//         {
//             TableRelation = Salarier;

//             /*   trigger OnValidate()
//                begin
//                    if RecEmployee.Get("Code Intervenant") then;
//                    "Nom Intervenant" := RecEmployee."First Name";

//                    // Calcule de cout horaire de l'intervenat
//                    if RecEmploymentContract.Get("Code Intervenant") then;
//                    if RecRegimesofwork.Get(RecEmploymentContract."Regimes of work") then;
//                    "Cout Horaire Intervenant" := RecEmployee."Salaire Brut" / RecRegimesofwork."Work Hours per month";
//                end;*/
//         }
//         field(3; "Nom Intervenant"; Text[60])
//         {
//         }
//         field(4; Type; Option)
//         {
//             OptionMembers = Curative,Preventive;
//         }
//         field(5; "Date Intervention"; Date)
//         {
//         }
//         field(8; "Durée"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 "Cout Ligne Intervention" := "Cout Horaire Intervenant" * Durée;
//             end;
//         }
//         field(9; "Detaille Intervention"; Text[250])
//         {
//         }
//         field(10; "N° Ligne"; Integer)
//         {
//         }
//         field(11; "Cout Horaire Intervenant"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(12; "Cout Ligne Intervention"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//     }

//     keys
//     {
//         key(Key1; "Code BT", "N° Ligne")
//         {
//             Clustered = true;
//             SumIndexFields = "Cout Ligne Intervention";
//         }
//         key(Key2; "Code Intervenant", "Date Intervention")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnInsert()
//     begin
//         /*
//         RecIntervenantsBT.SETRANGE("Code BT");
//         IF RecIntervenantsBT.FINDLAST THEN
//         BEGIN
//            "N° Ligne" := RecIntervenantsBT."N° Ligne" + 10000;
//         END
//         ELSE
//            "N° Ligne" := 10000;
//         */

//     end;

//     var
//         RecEmployee: Record Employee;
//         RecIntervenantsBT: Record "Intervenants BT";
//         RecEnteteBT: Record "Entete BT";
//         RecEmploymentContract: Record "Employment Contract";
//         RecRegimesofwork: Record "Regimes of work";
// }

