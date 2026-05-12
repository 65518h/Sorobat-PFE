// page 52049023 "Preparation Rejet Salaire"
// {
//     //GL2024  ID dans Nav 2009 : "39001551"
//     PageType = List;
//     SourceTable = "Ligne Lot Paie";
//     SourceTableView = where(Type = filter("Ordre Virement"),
//                             Status = filter(Validée),
//                             "Rejet Salaire" = filter(''));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Preparation Rejet Salaire';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Selection; Rec.Selection)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Matricule Salarié"; Rec."Matricule Salarié")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Nom Salarie"; Rec."Nom Salarie")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(RIB; Rec.RIB)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Montant Net"; Rec."Montant Net")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Code Banque"; Rec."Code Banque")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Num Paie"; Rec."Num Paie")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Banque Salarié"; Rec."Banque Salarié")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Code Affectation"; Rec."Code Affectation")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Valider le Rejet")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Valider le Rejet';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if not Confirm(Text001) then exit;
//                     RecLigneRejetSalaire.Reset;
//                     RecLigneRejetSalaire.SetRange(Code, CodeRejetSalaire);
//                     Rec.SetRange(Selection, true);
//                     if Rec.Count <> 1 then Error(Text002);
//                     if Rec.FindFirst then begin
//                         RecLigneRejetSalaire.Code := CodeRejetSalaire;
//                         RecLigneRejetSalaire."Code Banque" := CodeBqRejetSalaire;
//                         RecLigneRejetSalaire.Validate("Matricule Salarié", Rec."Matricule Salarié");
//                         RecLigneRejetSalaire."Montant Net" := Rec."Montant Net";
//                         RecLigneRejetSalaire.Status := RecLigneRejetSalaire.Status::"En Cours";
//                         RecLigneRejetSalaire."Num Paie" := Rec."Num Paie";
//                         RecLigneRejetSalaire."Code Affectation" := Rec."Code Affectation";
//                         RecLigneRejetSalaire.Type := RecLigneRejetSalaire.Type::"Rejet Salaire";
//                         if not RecLigneRejetSalaire.Modify then RecLigneRejetSalaire.Insert;
//                         Rec."Rejet Salaire" := CodeRejetSalaire;
//                         Rec.Selection := false;
//                         Rec.Modify;
//                     end;
//                     CurrPage.Close;
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         GetParametres(CodeRejetSalaire, CodeBqRejetSalaire);
//         Rec.FilterGroup(2);
//         //SETRANGE("Code Banque",CodeBqRejetSalaire);
//         Rec.FilterGroup(0);
//     end;

//     var
//         CodeRejetSalaire: Code[20];
//         CodeBqRejetSalaire: Code[20];
//         Text001: label 'Confirmer le Rejet de Salaire ?';
//         Text002: label 'Erreur !!! Vous devez selectionner une seule lignie !!!';
//         RecLigneRejetSalaire: Record "Ligne Lot Paie";


//     procedure GetParametres(ParmCodeRejet: Code[20]; ParmCodeBq: Code[20])
//     begin
//         CodeRejetSalaire := ParmCodeRejet;
//         CodeBqRejetSalaire := ParmCodeBq;
//     end;
// }

