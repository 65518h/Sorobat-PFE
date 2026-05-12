// Page 50097 "Ordre Transfert Matèriel"
// {
//     PageType = Card;
//     SourceTable = "Historique Transfert Engin";

//     Caption = 'Ordre Transfert Matèriel';
//     layout
//     {
//         area(content)
//         {
//             field("Code Transfert"; rec."Code Transfert")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field("Date Transfert"; rec."Date Transfert")
//             {
//                 ApplicationArea = all;
//                 Editable = true;
//             }
//             field("User Id"; rec."User Id")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("Code Engin"; rec."Code Engin")
//             {
//                 ApplicationArea = all;
//                 Editable = "Code EnginEditable";
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field("Description Engin"; rec."Description Engin")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field(Immatriculation; rec.Immatriculation)
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Style = Attention;
//                 StyleExpr = true;
//             }
//             field("Index Engin"; rec."Index Engin")
//             {
//                 ApplicationArea = all;
//             }
//             field("Code Tracteur Routier"; rec."Code Tracteur Routier")
//             {
//                 ApplicationArea = all;
//                 Editable = "Code Tracteur RoutierEditable";
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field("Description Tracteur Routier"; rec."Description Tracteur Routier")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("Immat Tracteur Routier"; rec."Immat Tracteur Routier")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("Code Port-Chart"; rec."Code Port-Chart")
//             {
//                 ApplicationArea = all;
//                 Editable = "Code Port-ChartEditable";
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field("Description Port-Chart"; rec."Description Port-Chart")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("Immat Port-Chart"; rec."Immat Port-Chart")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("Code Chauffeur"; rec."Code Chauffeur")
//             {
//                 ApplicationArea = all;
//                 Editable = "Code ChauffeurEditable";
//             }
//             field(Chauffeur; rec.Chauffeur)
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field(Depart; rec.Depart)
//             {
//                 ApplicationArea = all;
//                 Editable = DepartEditable;
//                 Style = Unfavorable;
//                 StyleExpr = true;
//             }
//             field("Description Depart"; rec."Description Depart")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field(Destination; rec.Destination)
//             {
//                 ApplicationArea = all;
//                 Editable = DestinationEditable;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field("Description Destination"; rec."Description Destination")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field(Observation; rec.Observation)
//             {
//                 ApplicationArea = all;
//                 Editable = ObservationEditable;
//             }
//             field(Status; rec.Status)
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group(Fonction1)
//             {
//                 Caption = 'Fonction';
//                 actionref(Valider1; Valider) { }

//                 actionref(Imprimer1; Imprimer) { }
//             }
//         }
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action(Valider)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Valider';

//                     trigger OnAction()
//                     var

//                         txt001: label 'Transfert Engin Validé aves succèes';
//                     begin
//                         rec.TestField("Index Engin");
//                         RecVehicule.Reset;
//                         if RecVehicule.Get(rec."Code Engin") then;
//                         RecHistoriqueAffectVehicule.Init;
//                         if RecVehicule.Marche = '' then
//                             RecHistoriqueAffectVehicule.Type := RecHistoriqueAffectVehicule.Type::Affectation
//                         else
//                             RecHistoriqueAffectVehicule.Type := RecHistoriqueAffectVehicule.Type::Réaffectation;
//                         RecHistoriqueAffectVehicule."Code Ordre Transfert" := rec."Code Transfert";
//                         RecHistoriqueAffectVehicule."Date Affectation" := Today;
//                         RecHistoriqueAffectVehicule."N° Véhicule" := rec."Code Engin";
//                         RecHistoriqueAffectVehicule."Type Affectation" := RecHistoriqueAffectVehicule."type affectation"::"Parc Auto";
//                         RecHistoriqueAffectVehicule.Observation := rec.Observation;
//                         RecHistoriqueAffectVehicule."Ancien Affaire" := rec.Depart;
//                         RecHistoriqueAffectVehicule."Nouveau Affaire" := rec.Destination;
//                         RecHistoriqueAffectVehicule.Utilisateur := UpperCase(UserId);
//                         if not RecHistoriqueAffectVehicule.Modify then RecHistoriqueAffectVehicule.Insert(true);

//                         RecVehicule.Marche := rec.Destination;
//                         RecVehicule.Modify;

//                         rec.Status := rec.Status::Lancer;
//                         rec.Modify;
//                         CurrPage.Update;
//                         Message(txt001);
//                     end;
//                 }
//                 separator(Action1000000035)
//                 {
//                 }
//                 action(Imprimer)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer';

//                     trigger OnAction()
//                     begin
//                         RecHistoriqueTransfertEngin.Reset;
//                         RecHistoriqueTransfertEngin.SetRange("Code Transfert", rec."Code Transfert");
//                         Report.Run(50105, true, true, RecHistoriqueTransfertEngin);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         if rec.Status = rec.Status::Lancer then
//             FonctEditable(false)
//         else
//             FonctEditable(true);
//     end;

//     trigger OnInit()
//     begin
//         ObservationEditable := true;
//         DestinationEditable := true;
//         DepartEditable := true;
//         "Code ChauffeurEditable" := true;
//         "Code Port-ChartEditable" := true;
//         "Code Tracteur RoutierEditable" := true;
//         "Code EnginEditable" := true;
//     end;

//     trigger OnOpenPage()
//     begin
//         if rec.Status = rec.Status::Lancer then
//             FonctEditable(false)
//         else
//             FonctEditable(true);
//     end;

//     var
//         RecVehicule: Record "Véhicule";

//         Text01: label 'Destination Job is Empty  !!!!';
//         Text02: label 'Destination Job must be different from the original job  !!!!';
//         RecHistoriqueAffectVehicule: Record "Historique Véhicule";
//         RecHistoriqueTransfertEngin: Record "Historique Transfert Engin";
//         [InDataSet]
//         "Code EnginEditable": Boolean;
//         [InDataSet]
//         "Code Tracteur RoutierEditable": Boolean;
//         [InDataSet]
//         "Code Port-ChartEditable": Boolean;
//         [InDataSet]
//         "Code ChauffeurEditable": Boolean;
//         [InDataSet]
//         DepartEditable: Boolean;
//         [InDataSet]
//         DestinationEditable: Boolean;
//         [InDataSet]
//         ObservationEditable: Boolean;


//     procedure FonctEditable(ParmOption: Boolean)
//     begin
//         if ParmOption = true then begin
//             "Code EnginEditable" := true;
//             "Code Tracteur RoutierEditable" := true;
//             "Code Port-ChartEditable" := true;
//             "Code ChauffeurEditable" := true;
//             DepartEditable := true;
//             DestinationEditable := true;
//             ObservationEditable := true;
//         end
//         else begin
//             "Code EnginEditable" := false;
//             "Code Tracteur RoutierEditable" := false;
//             "Code Port-ChartEditable" := false;
//             "Code ChauffeurEditable" := false;
//             DepartEditable := false;
//             DestinationEditable := false;
//             ObservationEditable := false;
//         end;
//     end;
// }

