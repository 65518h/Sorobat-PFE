// Page 74780 "Subform Ligne Releve Mesure"
// {//GL2024  ID dans Nav 2009 : "39004780"
//     PageType = ListPart;
//     SourceTable = "Lignes Relevé mesures";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 field("N° Ligne"; Rec."N° Ligne")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Code Equipement"; Rec."Code Equipement")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "Code EquipementEditable";
//                 }
//                 field("Libellé Equipement"; Rec."Libellé Equipement")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Famille Equipement"; Rec."Famille Equipement")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Sous Famille Equipement"; Rec."Sous Famille Equipement")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Index; Rec.Index)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = IndexEditable;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Date Releve"; Rec."Date Releve")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Gamme Actif"; Rec."Gamme Actif")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Observation; Rec.Observation)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = ObservationEditable;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord()
//     begin
//         Edite_Forme;
//     end;

//     trigger OnInit()
//     begin
//         ObservationEditable := true;
//         IndexEditable := true;
//         "Code EquipementEditable" := true;
//     end;

//     trigger OnOpenPage()
//     begin
//         Edite_Forme;
//     end;

//     var
//         RecReleveMesures: Record "Relevé mesures";
//         [InDataSet]
//         "Code EquipementEditable": Boolean;
//         [InDataSet]
//         IndexEditable: Boolean;
//         [InDataSet]
//         ObservationEditable: Boolean;


//     procedure Edite_Forme()
//     begin
//         if RecReleveMesures.Get(Rec."N° Mesure") then;
//         if RecReleveMesures.Status = RecReleveMesures.Status::Valider then begin
//             "Code EquipementEditable" := false;
//             IndexEditable := false;
//             ObservationEditable := false;
//         end
//         else begin
//             "Code EquipementEditable" := true;
//             IndexEditable := true;
//             ObservationEditable := true;

//         end;
//     end;
// }

