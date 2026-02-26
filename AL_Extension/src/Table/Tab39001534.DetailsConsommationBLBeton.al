// Table 39001534 "Details Consommation BL Beton"
// {
//     //GL2024  ID dans Nav 2009 : "39001534"
//     fields
//     {
//         field(1; Con_ID; Code[20])
//         {
//         }
//         field(2; Mat_Code; Code[20])
//         {
//         }
//         field(3; "Quantité"; Decimal)
//         {
//         }
//         field(4; Num_BL; Code[20])
//         {
//         }
//         field(50000; Correspondance; Code[20])
//         {
//             CalcFormula = lookup("Materiaux BL Beton".Correspondance where(Mat_Code = field(Mat_Code)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(50001; "Quantité Total"; Decimal)
//         {
//             CalcFormula = sum("Details Consommation BL Beton".Quantité where(Num_BL = field(Num_BL),
//                                                                               Mat_Code = field(Mat_Code)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(50002; "Date BL"; Date)
//         {
//             // CalcFormula = lookup("BL Carriere".Date where("N° Societe" = const('BZ4'),
//             //                                                "N° Sequence" = field(Num_BL)));
//             // FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(Key1; Con_ID, Num_BL)
//         {
//             Clustered = true;
//         }
//         key(Key2; Mat_Code)
//         {
//         }
//         key(Key3; Mat_Code, Num_BL)
//         {
//             SumIndexFields = "Quantité";
//         }
//     }

//     fieldgroups
//     {
//     }
// }

