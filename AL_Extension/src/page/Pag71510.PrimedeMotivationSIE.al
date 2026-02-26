//GL3900 
// page 71510 "Prime de Motivation SIE"
// { //GL2024  ID dans Nav 2009 : "39001510"
//     PageType = List;
//     SourceTable = "Prime de Motivation SIE";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Prime de Motivation SIE';
//     layout
//     {
//         area(content)
//         {
//             label(Control1120040)
//             {
//                 ApplicationArea = Basic;
//                 CaptionClass = Text19001603;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             repeater(Control1120000)
//             {
//                 ShowCaption = false;
//                 field("Code Employée"; Rec."Code Employée")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Nom Employée"; Rec."Nom Employée")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Fonction; Rec.Fonction)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Groupe Compta."; Rec."Groupe Compta.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Groupe Statistique"; Rec."Groupe Statistique")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Qualification; Rec.Qualification)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Mois de Prime"; Rec."Mois de Prime")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Année de Prime"; Rec."Année de Prime")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Classe Prime"; Rec."Classe Prime")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Absence; Rec.Absence)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Abs.';
//                 }
//                 field(Dicipline; Rec.Dicipline)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Rendement; Rec.Rendement)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Rend.';
//                 }
//                 field("Qualité"; Rec.Qualité)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Heures Sup."; Rec."Heures Sup.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Heures Sup.';
//                 }
//                 field(SEP; SEP)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taux Assiduite"; Rec."Taux Assiduite")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Taux Assid.';
//                 }
//                 field("Taux Dicipline"; Rec."Taux Dicipline")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taux Rendement"; Rec."Taux Rendement")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Taux Rend.';
//                 }
//                 field("Taux Qualité"; Rec."Taux Qualité")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taux Disponibilité"; Rec."Taux Disponibilité")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Taux Dispo.';
//                 }
//                 field("Prime Imi"; Rec."Prime Imi")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Prime Img"; Rec."Prime Img")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Prime Imp"; Rec."Prime Imp")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }

//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Fonction")
//             {
//                 Caption = '&Fonction';
//                 action("Proposer Lignes Prime")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Proposer Lignes Prime';

//                     trigger OnAction()
//                     begin
//                         Report.RunModal(Report::"Etat de pointage @", false, false);
//                         CurrPage.SaveRecord;
//                         CurrPage.Update(true);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         SEP := '';
//     end;

//     var
//         SEP: Code[10];
//         Text19001603: label '***  Prime de Motivation  ***';
// }

