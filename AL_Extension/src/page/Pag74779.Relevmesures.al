// page 74779 "Relevé mesures"
// {//GL2024  ID dans Nav 2009 : "39004779"
//     Caption = 'Measure reading';
//     DeleteAllowed = true;
//     Editable = true;
//     ModifyAllowed = true;
//     PageType = Card;
//     SourceTable = "Relevé mesures";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'Général';
//                 field("N°"; REC."N°")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Date Mesure"; REC."Date Mesure")
//                 {
//                     ApplicationArea = All;
//                     Editable = "Date MesureEditable";
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field("Code Releveur"; REC."Code Releveur")
//                 {
//                     ApplicationArea = All;
//                     Editable = "Code ReleveurEditable";
//                 }
//                 field(Releveur; REC.Releveur)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Observation; REC.Observation)
//                 {
//                     ApplicationArea = All;
//                     Editable = ObservationEditable;
//                 }
//                 field("Filter Affectation"; REC."Filter Affectation")
//                 {
//                     ApplicationArea = All;
//                     Editable = "Filter AffectationEditable";
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Filter Sous Famille"; REC."Filter Sous Famille")
//                 {
//                     ApplicationArea = All;
//                     // DecimalPlaces = 0 : 0;
//                     Editable = "Filter Sous FamilleEditable";
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Status; REC.Status)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//             }
//             part(Ligne; "Subform Ligne Releve Mesure")
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "N° Mesure" = FIELD("N°");
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Reading)
//             {
//                 Caption = 'Relevé';

//                 action(Valider)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Valider';
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         CuGMAOParc.ValiderReleverMesure(Rec);
//                     end;
//                 }

//                 action("Appliquer les Filters")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Appliquer les Filters';

//                     trigger OnAction()
//                     begin
//                         IF (REC."Filter Affectation" = '') AND (REC."Filter Sous Famille" = '') THEN
//                             ERROR(Text001);
//                         RecLignesReleveMesures.SETRANGE("N° Mesure", REC."N°");
//                         IF RecLignesReleveMesures.FINDFIRST THEN BEGIN
//                             IF CONFIRM(Text002) THEN BEGIN
//                                 RecLignesReleveMesures.DELETEALL;
//                                 CuGMAOParc.AppliquerFilterReleverMesure(Rec);
//                             END;
//                         END
//                         ELSE
//                             CuGMAOParc.AppliquerFilterReleverMesure(Rec);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         Edite_Forme;
//     end;

//     trigger OnInit()
//     begin
//         "Filter Sous FamilleEditable" := TRUE;
//         "Filter AffectationEditable" := TRUE;
//         ObservationEditable := TRUE;
//         "Code ReleveurEditable" := TRUE;
//         "Date MesureEditable" := TRUE;
//     end;

//     trigger OnOpenPage()
//     begin
//         Edite_Forme;
//     end;

//     var
//         RecLignesReleveMesures: Record "Lignes Relevé mesures";
//         CuGMAOParc: Codeunit "Soroubat cdu";
//         Text001: Label 'Vous Devez Inserer Un Filter Affectation ou bien Un Filter Sous Famille';
//         Text002: Label 'Attention !!! Vous etes en Train d''Apliquer un nouveau Filter. Vous risquer de supprimer les lignes existants';

//         "Date MesureEditable": Boolean;

//         "Code ReleveurEditable": Boolean;

//         ObservationEditable: Boolean;

//         "Filter AffectationEditable": Boolean;

//         "Filter Sous FamilleEditable": Boolean;


//     procedure Edite_Forme()
//     begin
//         IF REC.Status = REC.Status::Valider THEN BEGIN
//             "Date MesureEditable" := FALSE;
//             "Code ReleveurEditable" := FALSE;
//             ObservationEditable := FALSE;
//             "Filter AffectationEditable" := FALSE;
//             "Filter Sous FamilleEditable" := FALSE;
//         END
//         ELSE BEGIN
//             "Date MesureEditable" := TRUE;
//             "Code ReleveurEditable" := TRUE;
//             ObservationEditable := TRUE;
//             "Filter AffectationEditable" := TRUE;
//             "Filter Sous FamilleEditable" := TRUE;

//         END;
//     end;
// }

