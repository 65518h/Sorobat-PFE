// Page 74799 "Recuperation Info Fournisseur"
// {//GL2024  ID dans Nav 2009 : "39004799"
//     PageType = Card;
//     SourceTable = Vendor;
//     SourceTableView = where("No." = filter(<> '_DEMANDE & "FRE*"' & <> 'FRL-0000'));
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             field(CodeFournisseur; CodeFournisseur)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Code Fournisseur';
//                 TableRelation = Vendor;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Valider)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if CodeFournisseur <> '' then begin
//                         RecCopieFournisseur.Get(CodeFournisseur);
//                         if Rec.Get(CodeFournisseur) then;
//                         Rec."Payment Terms Code" := RecCopieFournisseur."Payment Terms Code";
//                         Rec."Country/Region Code" := RecCopieFournisseur."Country/Region Code";
//                         Rec."Payment Method Code" := RecCopieFournisseur."Payment Method Code";
//                         Rec."VAT Registration No." := RecCopieFournisseur."VAT Registration No.";
//                         REC."Regime D'imposition" := RecCopieFournisseur."Regime D'imposition";
//                         REC."Type identifiant" := RecCopieFournisseur."Type identifiant";
//                         REC.Activité := RecCopieFournisseur.Activité;
//                         // Aprés la vérififation avec Mr Hosni je lance la validation de Fournisseur
//                         Rec.Validate(Statut, REC.Statut::Validé);
//                         Rec.Modify;
//                         Message(TEXT001);
//                     end
//                     else begin
//                         RecVendor.SetRange(RecVendor.Statut, RecVendor.Statut::"En Attente");
//                         if RecVendor.FindFirst then
//                             repeat
//                                 if RecCopieFournisseur.Get(RecVendor."No.") then begin
//                                     RecVendor."Payment Terms Code" := RecCopieFournisseur."Payment Terms Code";
//                                     RecVendor."Country/Region Code" := RecCopieFournisseur."Country/Region Code";
//                                     RecVendor."Payment Method Code" := RecCopieFournisseur."Payment Method Code";
//                                     RecVendor."VAT Registration No." := RecCopieFournisseur."VAT Registration No.";
//                                     RecVendor."Regime D'imposition" := RecCopieFournisseur."Regime D'imposition";
//                                     RecVendor."Type identifiant" := RecCopieFournisseur."Type identifiant";
//                                     RecVendor.Activité := RecCopieFournisseur.Activité;
//                                     // Aprés la vérififation avec Mr Hosni je lance la validation de Fournisseur
//                                     //RecVendor.VALIDATE(RecVendor.Statut,RecVendor.Statut::Validé);
//                                     RecVendor.Statut := RecVendor.Statut::Validé;
//                                     RecVendor.Modify;
//                                 end;
//                                 Message(TEXT001, RecVendor."No.");
//                             until RecVendor.Next = 0;
//                     end;
//                 end;
//             }
//         }
//     }

//     var
//         CodeFournisseur: Code[20];
//         RecCopieFournisseur: Record "Copie Table Fournisseur";
//         TEXT001: label 'MODIFICATION REUISSITE DE FOURNISSEUR %1';
//         RecVendor: Record Vendor;
// }

