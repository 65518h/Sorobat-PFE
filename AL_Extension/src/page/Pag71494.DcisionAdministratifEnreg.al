//GL3900 
// page 71494 "Décision Administratif Enreg."
// {//GL2024  ID dans Nav 2009 : "39001494"
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = Card;
//     SourceTable = "Carière Enreg";
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Décision Administratif Enreg.';
//     layout
//     {
//         area(content)
//         {
//             group(Control1102752002)
//             {
//                 ShowCaption = false;
//                 label(Control1102752003)
//                 {
//                     ApplicationArea = Basic;
//                     CaptionClass = Text19049800;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//             }
//             group(Control1)
//             {
//                 ShowCaption = false;
//                 field("N° Document Extr."; Rec."N° Document Extr.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date Décesion"; Rec."Date Décesion")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(employee; Rec.employee)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("First Name"; Rec."First Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(date; Rec.date)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'date D''effet';
//                 }
//                 field(Type; Rec.Type)
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         TypeOnAfterValidate;
//                     end;
//                 }
//                 field("Salaire Base"; Rec."Salaire Base")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Nbre Mois Bonification"; Rec."Nbre Mois Bonification")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date Entrée"; Rec."Date Entrée")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Catégorie soc."; Rec."Catégorie soc.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Qualification; Rec.Qualification)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Fonction; Rec.Fonction)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Relation de travail"; Rec."Relation de travail")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Direction; Rec.Direction)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Service; Rec.Service)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Section; Rec.Section)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Collège"; Rec.Collège)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Echelle; Rec.Echelle)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Echelon; Rec.Echelon)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }

//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Imprimer)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Imprimer';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     //T1.RESET;
//                     //T1.SETFILTER("N° sequence",'%1',"N° sequence");
//                     //REPORT.RUNMODAL(39001456,TRUE,FALSE,T1);
//                     Report.RunModal(Report::"* Traite Fournisseur");
//                 end;
//             }
//         }
//     }

//     var
//         T1: Record Demandeur;
//         Text19049800: label 'Décision Administrative';


//     procedure actualiserfields()
//     begin
//     end;

//     local procedure TypeOnAfterValidate()
//     begin
//         actualiserfields;
//     end;
// }

