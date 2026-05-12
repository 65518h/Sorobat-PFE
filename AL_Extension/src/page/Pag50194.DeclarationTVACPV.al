// Page 50194 "Declaration TVA CPV"
// {
//     PageType = List;
//     SourceTable = "Declaration TVA";
//     SourceTableView = sorting("N° Séguence")
//                       where(Valider = const(false),
//                             "N° Client" = filter('CPV*'));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Declaration TVA CPV';
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

//                 field("Mois Declaration"; REC."Mois Declaration")
//                 {
//                     ApplicationArea = all;
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
//                 field("Valider1"; REC.Valider)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Valider';
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Valider)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     //DeclarationTVA.SETRANGE(DeclarationTVA."Mois Declaration",0);
//                     DeclarationTVA.SetRange(DeclarationTVA.Valider, false);
//                     if DeclarationTVA.FindFirst then
//                         repeat
//                             if DeclarationTVA."Mois Declaration" <> 0 then begin
//                                 DeclarationTVA.Valider := true;
//                                 DeclarationTVA.Modify;
//                             end;
//                         until DeclarationTVA.Next = 0;
//                     //CurrForm.UPDATE;
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin


//         VATEntry.SetRange(VATEntry."Document Type", 2, 3);
//         VATEntry.SetRange(VATEntry.Type, 2);
//         if VATEntry.FindFirst then
//             repeat
//                 DeclarationTVA."N° Séguence" := Format(VATEntry."Entry No.");
//                 DeclarationTVA."Date Comptabilisation" := VATEntry."Posting Date";
//                 DeclarationTVA."N° Document" := VATEntry."Document No.";
//                 DeclarationTVA."Type Document" := VATEntry."Document Type";
//                 DeclarationTVA."N° Client" := VATEntry."Bill-to/Pay-to No.";
//                 RecCustomer.Reset;
//                 RecCustomer.SetRange(RecCustomer."No.", VATEntry."Bill-to/Pay-to No.");
//                 if RecCustomer.FindFirst then DeclarationTVA."Description Client" := RecCustomer.Name;
//                 DeclarationTVA.Base := VATEntry.Base;
//                 DeclarationTVA.Montant := VATEntry.Amount;
//                 DeclarationTVA."N° Doc Externe" := VATEntry."External Document No.";
//                 DeclarationTVA."Groupe Compta Produit TVA" := VATEntry."VAT Prod. Posting Group";
//                 if not DeclarationTVA.Insert then;
//             until VATEntry.Next = 0;
//         //CurrForm.UPDATE;
//     end;

//     var
//         DeclarationTVA: Record "Declaration TVA";
//         VATEntry: Record "VAT Entry";
//         RecCustomer: Record Customer;
// }

