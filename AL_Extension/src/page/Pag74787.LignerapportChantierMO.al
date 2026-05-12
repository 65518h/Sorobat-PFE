// Page 74787 "Ligne rapport Chantier MO"
// {//GL2024  ID dans Nav 2009 : "39004787"
//     PageType = ListPart;
//     SourceTable = "Ligne Rapport Chantier";
//     SourceTableView = where(Ressource = const(MO));
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 field(MO; Rec.MO)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("MO Description"; Rec."MO Description")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Description Qualification"; Rec."Description Qualification")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Cout Horaire MO"; Rec."Cout Horaire MO")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Slaire Brut"; Rec."Slaire Brut")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Tot Heure"; Rec."Tot Heure")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Nbre Heure';
//                 }
//                 field("Coût Ligne"; Rec."Coût Ligne")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(TotaalHeureMo; TotaalHeureMo)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Total H Journée';
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Description Tache"; Rec."Description Tache")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Quantité Excutée"; Rec."Quantité Excutée")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code unité"; Rec."Code unité")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Unité';
//                 }
//                 field("Achèvement"; Rec.Achèvement)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Observation; Rec.Observation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord()
//     begin

//         if RecEnteteRapportChantier.Get(Rec."N° Document") then begin
//             TotaalHeureMo := 0;
//             RecLigneRapportChantier.Reset();
//             RecLigneRapportChantier.SetRange(Journee, RecEnteteRapportChantier.Journee);
//             RecLigneRapportChantier.SetRange(MO, Rec.MO);
//             if RecLigneRapportChantier.FindFirst then
//                 repeat
//                     TotaalHeureMo += RecLigneRapportChantier."Tot Heure";
//                 until RecLigneRapportChantier.Next = 0;
//         end;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         Rec.Ressource := Rec.Ressource::MO;
//     end;

//     var
//         RecEnteteRapportChantier: Record "Entete Rapport Chantier";
//         TotaalHeureMo: Decimal;
//         RecLigneRapportChantier: Record "Ligne Rapport Chantier";
// }

