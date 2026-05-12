// page 50345 "Liste Ordre Virement Salairer"
// {
//     //GL2024 NEW PAGE
//     PageType = List;
//     SourceTable = "Entete Lot Paie";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     SourceTableView = WHERE(Status = FILTER("En Cours"), Type = FILTER("Ordre Virement"));
//     Caption = 'Liste Ordre Virement Salaire';
//     CardPageId = "Ordre Virement Salaire";
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field("Date Creation"; Rec."Date Creation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(User; Rec.User)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Code Banque"; Rec."Code Banque")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Nom Banque"; Rec."Nom Banque")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Mantant Net"; Rec."Mantant Net")
//                 {
//                     ApplicationArea = Basic;
//                     DecimalPlaces = 3 : 3;
//                     Editable = false;
//                 }
//                 field(Annee; Rec.Annee)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Mois; Rec.Mois)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Code Affectation"; Rec."Code Affectation")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Description Affectation"; Rec."Description Affectation")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Code Bordereau"; Rec."Code Bordereau")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Attention;
//                     StyleExpr = true;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             Group("Disquette Virement")
//             {
//                 action("Disquette Virement STB")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement STB';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement STB';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement STB";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;
//                 }

//                 action("Disquette Virement BTE")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement BTE';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement BTE';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement BTE";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;
//                 }

//                 action("Disquette Virement BNA")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement BNA';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement BNA';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement BNA";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;
//                 }

//                 action("Disquette Virement BNA Enreg")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement BNA Enreg';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement BNA Enreg';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement BNA Enreg";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;
//                 }

//                 action("Disquette Virement BTE Enreg")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement BTE Enreg';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement BTE Enreg';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement BTE 02";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;
//                 }

//                 action("Disquette Virement QNB")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement QNB';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement QNB';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement QNB";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;

//                 }

//                 action("Disquette Virement TSB")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement TSB';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement TSB';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement TSB";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();

//                     end;
//                 }
//             }

//         }
//     }
// }

