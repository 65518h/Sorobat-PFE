//GL3900 
// page 72044 "relevé mesure"
// { //GL2024  ID dans Nav 2009 : "39002044"
//     Caption = 'Measure reading';
//     DeleteAllowed = true;
//     Editable = true;
//     ModifyAllowed = true;
//     PageType = Card;
//     SourceTable = "Relevé mesure";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field(cd_mesure_point; rec.cd_mesure_point)
//                 {
//                     ApplicationArea = all;
//                     Editable = cd_mesure_pointEditable;
//                 }
//                 field(comment; rec.comment)
//                 {
//                     ApplicationArea = all;
//                     Enabled = true;
//                     Visible = false;
//                 }
//                 field(dttm_releve; rec.dttm_releve)
//                 {
//                     ApplicationArea = all;
//                     Editable = dttm_releveEditable;
//                 }
//                 field(val_mesure; rec.val_mesure)
//                 {
//                     ApplicationArea = all;
//                     Editable = val_mesureEditable;
//                 }
//                 field(unit; rec.unit)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(val_variation; rec.val_variation)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Reading)
//             {
//                 Caption = 'Reading';

//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(relevé),
//                                   "No." = FIELD(cd_releve);
//                 }
//                 action("Measure point")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Measure point';
//                     RunObject = Page "Fiche point de mesure";
//                     RunPageLink = cd_measure_point = FIELD(cd_mesure_point);
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         IF rec.Last = FALSE THEN BEGIN
//             cd_mesure_pointEditable := FALSE;
//             dttm_releveEditable := FALSE;
//             val_mesureEditable := FALSE;

//             // Currpage.valider.VISIBLE := FALSE;
//         END
//         ELSE BEGIN
//             cd_mesure_pointEditable := TRUE;
//             dttm_releveEditable := TRUE;
//             val_mesureEditable := TRUE;

//             // Currpage.valider.VISIBLE := TRUE;
//         END;
//     end;

//     trigger OnInit()
//     begin
//         val_mesureEditable := TRUE;
//         dttm_releveEditable := TRUE;
//         cd_mesure_pointEditable := TRUE;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         rec.dttm_releve := TODAY;
//     end;

//     var
//         pt: Record "Point mesure";
//         typ: Record "Type mesure";
//         "max": Decimal;
//         "min": Decimal;
//         [InDataSet]
//         cd_mesure_pointEditable: Boolean;
//         [InDataSet]
//         dttm_releveEditable: Boolean;
//         [InDataSet]
//         val_mesureEditable: Boolean;

//     local procedure cdmesurepointOnActivate()
//     begin
//         rec.RESET;
//     end;
// }

