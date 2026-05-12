//GL3900 
// page 71558 "MIS-Ligne Fr. Mis."
// {
//     //GL2024  ID dans Nav 2009 : "39001558"
//     AutoSplitKey = true;
//     PageType = ListPart;
//     SourceTable = "Ligne frais de mission";
//     Caption = 'MIS-Ligne Fr. Mis.';
//     ApplicationArea = All;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1120000)
//             {
//                 ShowCaption = false;
//                 field("N° Ligne"; Rec."N° Ligne")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("N° Salarier"; Rec."N° Salarier")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code Frais mission"; Rec."Code Frais mission")
//                 {
//                     ApplicationArea = Basic;
//                     Lookup = true;
//                 }
//                 field(Designation; Rec.Designation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Quantite; Rec.Quantite)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Prix Unitaire"; Rec."Prix Unitaire")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Montant DS"; Rec."Montant DS")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Montant a comptabiliser"; Rec."Montant a comptabiliser")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("G/L Account"; Rec."G/L Account")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Bal. G/L Account"; Rec."Bal. G/L Account")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Enveloppe Bank"; Rec."Enveloppe Bank")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Code Bank"; Rec."Code Bank")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

