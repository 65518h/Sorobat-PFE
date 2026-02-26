// Page 50162 "Alerte  Vidange"
// {
//     DeleteAllowed = false;
//     Editable = true;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "Véhicule";
//     /* SourceTableView = where("Dernier Vidange" = filter(<> 0),
//                              "Compteur Actuel" = filter(<> 0));*/
//     SourceTableView = WHERE("Prochain Vidange" = FILTER(<> 0),
//                           "Reste Pour Alerte" = FILTER(<> 0),
//                           "Compteur Actuel" = FILTER(<> 0),
//                           Statut = FILTER(> ' '),
//                           "Dernier Vidange" = FILTER(<> 0));
//     ApplicationArea = all;
//     Caption = 'Alerte  Vidange';
//     layout
//     {
//         area(content)
//         {
//             label(Control1000000017)
//             {
//                 ApplicationArea = all;
//                 Caption = '********************** ALERTE VIDANGE VEHICULE ECHU *****************************';
//                 Style = Unfavorable;
//                 StyleExpr = true;
//             }

//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("N° Vehicule"; REC."N° Vehicule")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Désignation"; REC.Désignation)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("marche"; REC.marche)
//                 {
//                     ApplicationArea = all;

//                 }

//                 field("Compteur Actuel"; REC."Compteur Actuel")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         if Vehicule.Get(REC."N° Vehicule") then begin
//                             Vehicule."Compteur Actuel" := REC."Compteur Actuel";
//                             Vehicule.Modify;
//                         end;
//                     end;
//                 }
//                 field("Compteur Actuel Vidange"; REC."Compteur Actuel Vidange")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prochain Vidange"; REC."Prochain Vidange")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Reste Pour Alerte"; REC."Reste Pour Alerte")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     trigger OnValidate()
//                     begin
//                         IF Vehicule.GET(Rec."N° Vehicule") THEN BEGIN
//                             Vehicule."Reste Pour Alerte" := Rec."Reste Pour Alerte";
//                             Vehicule.MODIFY;
//                         END;
//                     end;
//                 }
//                 field("Vidange Effectué"; REC."Vidange Effectué")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         VidangeEffectu233OnPush;
//                     end;
//                 }
//             }

//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         IF ParamétreParc.GET THEN
//             IF ParamétreParc."Filtre Chantier" <> '' THEN Rec.SETRANGE(marche, ParamétreParc."Filtre Chantier");
//         REC.SetFilter("Reste Pour Alerte", '<=%1', 0);
//         REC.SetFilter("Prochain Vidange", '<>%1', 0);
//         REC.SETFILTER("Compteur Actuel", '<>%1', 0);
//         if REC.Count = 0 then CurrPage.Close;
//     end;

//     var
//         Vehicule: Record "Véhicule";
//         ParamétreParc: Record "Paramétre Parc";
//         Text001: label 'Vidange Effectué ?';
//         Text19066259: label '********************** ALERTE VIDANGE VEHICULE ECHU *****************************';

//     local procedure VidangeEffectu233OnPush()
//     begin
//         if not Confirm(Text001) then exit;
//         if Vehicule.Get(REC."N° Vehicule") then begin
//             Vehicule."Dernier Vidange" := REC."Compteur Actuel Vidange";
//             Vehicule."Prochain Vidange" := REC."Compteur Actuel Vidange" + Vehicule."Vidange A";
//             Vehicule."Reste Pour Alerte" := Vehicule."Prochain Vidange" - Vehicule."Compteur Actuel" - Vehicule."Alerte Avant";
//             Vehicule."Vidange Effectué" := false;
//             Vehicule.Modify;
//         end;
//     end;
// }

