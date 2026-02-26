//GL3900 
// page 71493 "Décision Administratif"
// {//GL2024  ID dans Nav 2009 : "39001493"
//     PageType = List;
//     SourceTable = "Saisie Carière";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Décision Administratif';
//     layout
//     {
//         area(content)
//         {
//             group(Control1102752002)
//             {
//                 ShowCaption = false;
//                 label(Control1102752003)
//                 {
//                     ApplicationArea = Basic;
//                     CaptionClass = Text19049800;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//             }
//             repeater(Control1102752000)
//             {
//                 ShowCaption = false;
//                 field("N° Document Extr."; Rec."N° Document Extr.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(employee; Rec.employee)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("First Name"; Rec."First Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date Décesion"; Rec."Date Décesion")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(date; Rec.date)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Date Effet';
//                 }
//                 field(Type; Rec.Type)
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         actualiserfields
//                     end;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = StatusEditable;
//                 }
//                 field("Date Debut Contrat"; Rec."Date Debut Contrat")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "Date Debut ContratEditable";
//                 }
//                 field("Date Fin Contrat"; Rec."Date Fin Contrat")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "Date Fin ContratEditable";
//                 }
//                 field("Salaire Base"; Rec."Salaire Base")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "Salaire BaseEditable";
//                 }
//                 field("Nbre Mois Bonification"; Rec."Nbre Mois Bonification")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "Nbre Mois BonificationEditable";
//                 }
//                 field("Date Entrée"; Rec."Date Entrée")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "Date EntréeEditable";
//                 }
//                 field("Catégorie soc."; Rec."Catégorie soc.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "Catégorie soc.Editable";
//                     Visible = false;
//                 }
//                 field("Collège"; Rec.Collège)
//                 {
//                     Editable = "CollègeEDITABLE";
//                     ApplicationArea = Basic;
//                 }
//                 field(Echelon; Rec.Echelon)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = EchelonEditable;
//                 }
//                 field(Fonction; Rec.Fonction)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = FonctionEditable;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = GlobalDimension1CodeEditable;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = GlobalDimension2CodeEditable;
//                 }
//                 field("Relation de travail"; Rec."Relation de travail")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "Relation de travailEditable";
//                 }
//                 field("Site de travail"; Rec."Site de travail")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "Site de travailEditable";
//                 }
//                 field("Désignation Site de travail"; Rec."Désignation Site de travail")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = DésignationSitedetravailEditab;
//                 }
//                 field(Qualification; Rec.Qualification)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = QualificationEditable;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 action("P&ost")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'P&ost';
//                     Image = Post;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         val.Run(Rec);
//                         CurrPage.Update;
//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Post and &Print';
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Ctrl+F7';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         val.Validerimpr(Rec);
//                         CurrPage.Update;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     trigger OnInit()
//     begin
//         "Date Fin ContratEditable" := true;
//         "Date Debut ContratEditable" := true;
//         QualificationEditable := true;
//         DésignationSitedetravailEditab := true;
//         "Site de travailEditable" := true;
//         "Relation de travailEditable" := true;
//         GlobalDimension2CodeEditable := true;
//         GlobalDimension1CodeEditable := true;
//         StatusEditable := true;
//         FonctionEditable := true;
//         EchelonEditable := true;
//         "Catégorie soc.Editable" := true;
//         "Date EntréeEditable" := true;
//         "Nbre Mois BonificationEditable" := true;
//         "Salaire BaseEditable" := true;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     trigger OnOpenPage()
//     begin
//         actualiserfields;
//     end;

//     var
//         val: Codeunit "Enregistrement Cariere";
//         [InDataSet]
//         "Salaire BaseEditable": Boolean;
//         [InDataSet]
//         "Nbre Mois BonificationEditable": Boolean;
//         [InDataSet]
//         "Date EntréeEditable": Boolean;
//         [InDataSet]
//         "Catégorie soc.Editable": Boolean;
//         [InDataSet]
//         EchelonEditable: Boolean;
//         [InDataSet]
//         FonctionEditable: Boolean;
//         [InDataSet]
//         StatusEditable: Boolean;
//         [InDataSet]
//         GlobalDimension1CodeEditable: Boolean;
//         [InDataSet]
//         GlobalDimension2CodeEditable: Boolean;
//         [InDataSet]
//         "Relation de travailEditable": Boolean;
//         [InDataSet]
//         "Site de travailEditable": Boolean;
//         [InDataSet]
//         "DésignationSitedetravailEditab": Boolean;
//         [InDataSet]
//         QualificationEditable: Boolean;
//         [InDataSet]
//         "Date Debut ContratEditable": Boolean;
//         [InDataSet]
//         "Date Fin ContratEditable": Boolean;
//         CollègeEDITABLE: Boolean;
//         Text19049800: label 'Décision Administrative';


//     procedure actualiserfields()
//     begin
//         "Salaire BaseEditable" := false;
//         "Nbre Mois BonificationEditable" := false;
//         "Date EntréeEditable" := false;

//         "Catégorie soc.Editable" := false;

//         CollègeEDITABLE := FALSE;
//         EchelonEditable := true;
//         FonctionEditable := false;
//         StatusEditable := false;
//         GlobalDimension1CodeEditable := false;
//         GlobalDimension2CodeEditable := false;
//         "Relation de travailEditable" := false;
//         "Site de travailEditable" := false;
//         DésignationSitedetravailEditab := false;
//         QualificationEditable := false;
//         "Salaire BaseEditable" := true;
//         "Date Debut ContratEditable" := false;
//         "Date Fin ContratEditable" := false;

//         case Rec.Type of
//             1:
//                 begin
//                     "Date EntréeEditable" := true;
//                     "Catégorie soc.Editable" := true;

//                     CollègeEDITABLE := TRUE;
//                     EchelonEditable := true;
//                     FonctionEditable := true;
//                     StatusEditable := true;
//                     GlobalDimension1CodeEditable := true;
//                     GlobalDimension2CodeEditable := true;
//                     "Relation de travailEditable" := true;
//                     "Site de travailEditable" := true;
//                     QualificationEditable := true;
//                     "Salaire BaseEditable" := true;
//                     "Date Debut ContratEditable" := true;
//                     "Date Fin ContratEditable" := true;

//                 end;
//             2:
//                 begin
//                     EchelonEditable := true;
//                     if Rec."Catégorie soc." = 0 then
//                         "Salaire BaseEditable" := true;

//                 end;
//             3:
//                 begin
//                     EchelonEditable := true;
//                     if Rec."Catégorie soc." = 0 then
//                         "Salaire BaseEditable" := true;

//                 end;
//             4:
//                 begin
//                     "Relation de travailEditable" := true;
//                     "Catégorie soc.Editable" := true;

//                     CollègeEDITABLE := TRUE;
//                     EchelonEditable := true;
//                     QualificationEditable := true;
//                     if Rec."Catégorie soc." = 0 then
//                         "Salaire BaseEditable" := true;

//                 end;
//             5:
//                 begin
//                     "Site de travailEditable" := true;
//                 end;
//             6:
//                 begin
//                     FonctionEditable := true;
//                 end;
//             7:
//                 begin
//                     GlobalDimension1CodeEditable := true;
//                 end;
//             8:
//                 begin
//                     GlobalDimension2CodeEditable := true;
//                 end;
//             9:
//                 begin
//                     StatusEditable := true;
//                     "Date Debut ContratEditable" := true;
//                     "Date Fin ContratEditable" := true;
//                 end;
//             10:
//                 begin
//                     "Nbre Mois BonificationEditable" := true;
//                 end;
//             11:
//                 begin
//                     QualificationEditable := true;
//                     "Salaire BaseEditable" := true;
//                 end;
//             12:
//                 begin
//                     "Catégorie soc.Editable" := true;

//                     CollègeEDITABLE := TRUE;
//                     EchelonEditable := true;
//                     FonctionEditable := true;
//                     StatusEditable := true;
//                     GlobalDimension1CodeEditable := true;
//                     GlobalDimension2CodeEditable := true;
//                     "Relation de travailEditable" := true;
//                     "Site de travailEditable" := true;
//                     QualificationEditable := true;
//                     "Date Debut ContratEditable" := true;
//                     "Date Fin ContratEditable" := true;
//                     if Rec."Catégorie soc." = 0 then
//                         "Salaire BaseEditable" := true;

//                 end;

//         end;
//     end;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         actualiserfields;
//     end;
// }

