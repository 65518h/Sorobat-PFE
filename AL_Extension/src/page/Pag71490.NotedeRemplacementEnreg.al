//GL3900 
// page 71490 "Note de Remplacement Enreg."
// {
//     //GL2024  ID dans Nav 2009 : "39001490"
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = Card;
//     SourceTable = "Note Remplacement Enreg";
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Note de Remplacement Enreg.';
//     layout
//     {
//         area(content)
//         {
//             group(Control1)
//             {
//                 label(Control1000000002)
//                 {
//                     ApplicationArea = Basic;
//                     CaptionClass = Text19053486;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Date Remplacement"; Rec."Date Remplacement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("N° Salariée"; Rec."N° Salariée")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("NomSal(""N° Salariée"")"; NomSal(Rec."N° Salariée"))
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("N° Remplacant"; Rec."N° Remplacant")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("NomSal(""N° Remplacant"")"; NomSal(Rec."N° Remplacant"))
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Heure Début"; Rec."Heure Début")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Heure Fin"; Rec."Heure Fin")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Cause; Rec.Cause)
//                 {
//                     ApplicationArea = Basic;
//                     MultiLine = true;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         Text19053486: label 'Note De Remplacement';


//     procedure NomSal(NumSal: Code[20]) Name: Text[80]
//     var
//         Sal: Record Employee;
//     begin
//         Name := '';
//         Sal.Reset;
//         if Sal.Get(NumSal) then
//             Name := Sal."Last Name" + ' ' + Sal."First Name";
//     end;
// }

