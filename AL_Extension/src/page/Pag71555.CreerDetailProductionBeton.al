//GL3900 
// page 71555 "Creer Detail Production Beton"
// {
//     //GL2024  ID dans Nav 2009 : "39001555"
//     PageType = Card;
//     SourceTable = "Entete frais mission";
//     SourceTableView = where("Statut ordre mission" = filter("En cours"));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Creer Detail Production Beton';
//     layout
//     {
//         area(content)
//         {
//             field(NumBLDestination; NumBLDestination)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'N° BL Destination';
//                 Editable = false;
//             }
//             field(GQte; GQte)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Qte, Destination';
//                 Editable = false;
//             }
//             field(NumBLOrigine; NumBLOrigine)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'N° BL Origine';
//                 TableRelation = "BL Carriere"."N° Sequence" where("N° Societe" = filter('BZ4'),
//                                                                    "Production Créer" = const(true));
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
//                     if not Confirm(Text001) then exit;
//                     BLCarriere.SetRange("N° Societe", 'BZ4');
//                     BLCarriere.SetRange("N° Sequence", NumBLOrigine);
//                     if BLCarriere.FindFirst then Qte := BLCarriere.Quantité;
//                     DetailsConsommationBBeton.SetRange(Num_BL, NumBLOrigine);
//                     if DetailsConsommationBBeton.FindFirst then
//                         repeat
//                             DetailsConsommationBBeton2.Copy(DetailsConsommationBBeton);
//                             DetailsConsommationBBeton2.Num_BL := NumBLDestination;
//                             DetailsConsommationBBeton2.Quantité := ROUND((GQte / Qte) * DetailsConsommationBBeton.Quantité, 0.1);
//                             DetailsConsommationBBeton2.Insert;
//                         until DetailsConsommationBBeton.Next = 0;
//                     Message(Text002);
//                     CurrPage.Close;
//                 end;
//             }
//         }
//     }

//     var
//         Text001: label 'Confirmer Cette Action ?';
//         BLCarriere: Record "BL Carriere";
//         DetailsConsommationBBeton: Record "Details Consommation BL Beton";
//         DetailsConsommationBBeton2: Record "Details Consommation BL Beton";
//         NumBLDestination: Code[20];
//         NumBLOrigine: Code[20];
//         GBLOrigine: Integer;
//         GQte: Decimal;
//         Qte: Decimal;
//         Text002: label 'Tache Terminée avec Succée';


//     procedure GeTBLOrigine(ParaBL: Code[20]; ParaQte: Decimal)
//     var
//         DecLTotMontantFrais: Decimal;
//     begin
//         NumBLDestination := ParaBL;
//         GQte := ParaQte;
//     end;
// }

