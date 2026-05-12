// Page 50087 "Creation Frais Annexes"
// {
//     PageType = Card;
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Creation Frais Annexes';
//     layout
//     {
//         area(content)
//         {
//             label("UTILITAIRE CERATION FRAIS ANNEXES")
//             {
//                 ApplicationArea = all;
//                 //CaptionClass = Text19053278;
//                 Style = Unfavorable;
//                 Caption = 'UTILITY FOR CREATING CHARGE ITEM';
//                 StyleExpr = true;
//             }
//             field(Frais; Frais)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Code Frais';
//             }
//             field("LibelléFrais"; LibelléFrais)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Libellé Frais';
//             }
//             field(TVA; TVA)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Code TVA';
//                 TableRelation = "VAT Product Posting Group";
//             }
//             field(CompteCharge; CompteCharge)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Compte Charge';
//                 TableRelation = "G/L Account";
//             }
//             field(Sens; Sens)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Sens';
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
//                 Caption = 'Validate';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin

//                     if Frais = '' then Error(Text001);
//                     if LibelléFrais = '' then Error(Text001);
//                     if TVA = '' then Error(Text001);
//                     if CompteCharge = '' then Error(Text001);
//                     if not Confirm(Text003) then exit;
//                     if Sens = Sens::Achat then begin
//                         if GenProductPostingGroup1.Get('CC-DIVERS') then begin
//                             GenProductPostingGroup.Copy(GenProductPostingGroup1);
//                             GenProductPostingGroup.Code := Frais;
//                             GenProductPostingGroup.Description := LibelléFrais;
//                             GenProductPostingGroup."Compte Vente" := '';
//                             GenProductPostingGroup."Compte Achat" := CompteCharge;
//                             GenProductPostingGroup."Def. VAT Prod. Posting Group" := TVA;
//                             GenProductPostingGroup.Insert;
//                             UpdateParaNature;
//                         end;
//                     end;
//                     if Sens = Sens::Vente then begin
//                         if GenProductPostingGroup1.Get('CC-DIVERS') then begin
//                             GenProductPostingGroup.Copy(GenProductPostingGroup1);
//                             GenProductPostingGroup.Code := Frais;
//                             GenProductPostingGroup.Description := LibelléFrais;
//                             GenProductPostingGroup."Compte Achat" := '';
//                             GenProductPostingGroup."Compte Vente" := CompteCharge;
//                             GenProductPostingGroup."Def. VAT Prod. Posting Group" := TVA;
//                             GenProductPostingGroup.Insert;
//                             UpdateParaNature;
//                         end;
//                     end;

//                     if ItemCharge1.Get('CC-DIVERS') then begin
//                         ItemCharge.Copy(ItemCharge1);
//                         ItemCharge."No." := Frais;
//                         ItemCharge.Description := LibelléFrais;
//                         ItemCharge."Gen. Prod. Posting Group" := Frais;
//                         ItemCharge."VAT Prod. Posting Group" := TVA;
//                         ItemCharge.Insert;
//                     end;

//                     Message(Text002);
//                 end;
//             }
//         }
//     }

//     var
//         Frais: Code[10];
//         "LibelléFrais": Text[30];
//         TVA: Code[20];
//         CompteCharge: Code[20];
//         ItemCharge: Record "Item Charge";
//         ItemCharge1: Record "Item Charge";
//         GenProductPostingGroup: Record "Gen. Product Posting Group";
//         GenProductPostingGroup1: Record "Gen. Product Posting Group";
//         GenProductPostingGroup2: Record "Gen. Product Posting Group";
//         GeneralPostingSetup: Record "General Posting Setup";
//         GenBusinessPostingGroup: Record "Gen. Business Posting Group";
//         Text001: label 'Missing Field';
//         Text002: label 'Action Completed Successfully';
//         Text003: label 'Start the Creation of the Charge?';
//         Sens: Option Achat,Vente;
//         Text19053278: label 'UTILITY FOR CREATING CHARGE ITEM';


//     procedure UpdateParaNature()
//     begin
//         if GenProductPostingGroup2.FindFirst then
//             repeat
//                 GeneralPostingSetup."Gen. Bus. Posting Group" := '';
//                 GeneralPostingSetup."Gen. Prod. Posting Group" := GenProductPostingGroup2.Code;
//                 GeneralPostingSetup."Sales Account" := GenProductPostingGroup2."Compte Vente";
//                 GeneralPostingSetup."Sales Line Disc. Account" := GenProductPostingGroup2."Compte Vente";
//                 GeneralPostingSetup."Sales Inv. Disc. Account" := GenProductPostingGroup2."Compte Vente";
//                 GeneralPostingSetup."Sales Credit Memo Account" := GenProductPostingGroup2."Compte Vente";
//                 GeneralPostingSetup."Purch. Account" := GenProductPostingGroup2."Compte Achat";
//                 GeneralPostingSetup."Purch. Line Disc. Account" := GenProductPostingGroup2."Compte Achat";
//                 GeneralPostingSetup."Purch. Inv. Disc. Account" := GenProductPostingGroup2."Compte Achat";
//                 GeneralPostingSetup."Purch. Credit Memo Account" := GenProductPostingGroup2."Compte Achat";
//                 GeneralPostingSetup."COGS Account" := '31100013';
//                 GeneralPostingSetup."Inventory Adjmt. Account" := '31100013';
//                 GeneralPostingSetup."Direct Cost Applied Account" := '31100013';
//                 if not GeneralPostingSetup.Insert then GeneralPostingSetup.Modify;
//             until GenProductPostingGroup2.Next = 0;
//         if GenBusinessPostingGroup.FindFirst then
//             repeat
//                 if GenProductPostingGroup2.FindFirst then
//                     repeat
//                         GeneralPostingSetup."Gen. Bus. Posting Group" := GenBusinessPostingGroup.Code;
//                         GeneralPostingSetup."Gen. Prod. Posting Group" := GenProductPostingGroup2.Code;
//                         GeneralPostingSetup."Sales Account" := GenProductPostingGroup2."Compte Vente";
//                         GeneralPostingSetup."Sales Line Disc. Account" := GenProductPostingGroup2."Compte Vente";
//                         GeneralPostingSetup."Sales Inv. Disc. Account" := GenProductPostingGroup2."Compte Vente";
//                         GeneralPostingSetup."Sales Credit Memo Account" := GenProductPostingGroup2."Compte Vente";
//                         GeneralPostingSetup."Purch. Account" := GenProductPostingGroup2."Compte Achat";
//                         GeneralPostingSetup."Purch. Line Disc. Account" := GenProductPostingGroup2."Compte Achat";
//                         GeneralPostingSetup."Purch. Inv. Disc. Account" := GenProductPostingGroup2."Compte Achat";
//                         GeneralPostingSetup."Purch. Credit Memo Account" := GenProductPostingGroup2."Compte Achat";
//                         GeneralPostingSetup."COGS Account" := '31100013';
//                         GeneralPostingSetup."Inventory Adjmt. Account" := '31100013';
//                         GeneralPostingSetup."Direct Cost Applied Account" := '31100013';
//                         if not GeneralPostingSetup.Insert then GeneralPostingSetup.Modify;

//                     until GenProductPostingGroup2.Next = 0;
//             until GenBusinessPostingGroup.Next = 0;
//     end;
// }

