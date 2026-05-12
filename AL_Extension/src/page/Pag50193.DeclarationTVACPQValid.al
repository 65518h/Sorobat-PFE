// Page 50193 "Declaration TVA CPQ Validé"
// {
//     PageType = List;
//     SourceTable = "Declaration TVA";
//     SourceTableView = sorting("N° Séguence")
//                       where(Valider = const(true),
//                             "N° Client" = filter('CPQ*'));
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     Caption = 'Declaration TVA CPQ Validé';

//     layout
//     {
//         area(content)
//         {
//             label("Déclaration TVA")
//             {
//                 Caption = '.........................................................................................Déclaration TVA................................................................................................';
//                 ApplicationArea = all;
//                 Style = StrongAccent;
//                 StyleExpr = true;

//             }

//             repeater(Control1)
//             {
//                 ShowCaption = false;

//                 field(Valider; REC.Valider)
//                 {
//                     ApplicationArea = all;

//                     Editable = true;

//                     trigger OnValidate()
//                     begin
//                         ValiderOnPush;
//                     end;
//                 }
//                 field("Mois Declaration"; REC."Mois Declaration")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date Comptabilisation"; REC."Date Comptabilisation")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("N° Document"; REC."N° Document")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Type Document"; REC."Type Document")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("N° Client"; REC."N° Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Base; REC.Base)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Montant; REC.Montant)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("N° Doc Externe"; REC."N° Doc Externe")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Groupe Compta Produit TVA"; REC."Groupe Compta Produit TVA")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Description Client"; REC."Description Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         DeclarationTVA: Record "Declaration TVA";
//         VATEntry: Record "VAT Entry";
//         RecCustomer: Record Customer;
//         Text001: label 'Voulez vous Dévalider la Ligne en cours ?';

//     local procedure ValiderOnPush()
//     begin
//         if not Confirm(Text001) then begin
//             REC.Valider := true;
//             Rec.Modify;
//             exit;
//         end;

//         Rec."Mois Declaration" := 0;
//         Rec.Modify;
//     end;
// }

