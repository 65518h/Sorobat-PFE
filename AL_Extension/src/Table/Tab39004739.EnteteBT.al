// Table 39004739 "Entete BT"
// {
//     //GL2024  ID dans Nav 2009 : "39004739"
//     LookupPageID = "Liste BT GMAO";

//     fields
//     {
//         field(1; "Code"; Code[20])
//         {

//             trigger OnValidate()
//             begin
//                 "Date Lancement" := Today;
//             end;
//         }
//         field(2; Type; Option)
//         {
//             OptionMembers = Curative,Preventive;
//         }
//         field(3; "Date Lancement"; Date)
//         {
//         }
//         field(4; Equipement; Code[20])
//         {
//             TableRelation = Véhicule;

//             trigger OnValidate()
//             begin
//                 if RecVehicule.Get(Equipement) then;
//                 "Designiation Equipement" := RecVehicule.Désignation;
//                 Immatriculation := RecVehicule.Immatriculation;
//             end;
//         }
//         field(5; "Designiation Equipement"; Text[60])
//         {
//         }
//         field(6; Gamme; Code[30])
//         {
//             TableRelation = Gamme."Code Gamme";
//         }
//         field(7; "Designiation Gamme"; Text[200])
//         {
//         }
//         field(9; Observation; Text[120])
//         {
//         }
//         field(10; "Date Traitement"; Date)
//         {
//         }
//         field(11; Frequence; Decimal)
//         {
//         }
//         field(12; Status; Option)
//         {
//             OptionMembers = Ouvert,"Lancé","En attente d'autorisation","En attente de devis","En attente info complémentaire","En attente d'articles","Archivé","Executé";

//             /*   trigger OnValidate()
//                begin
//                    if Status > 0 then begin
//                        NotificationReception.SetRange("Document N°", Code);
//                        NotificationReception.ModifyAll(Statut, NotificationReception.Statut::Terminé);
//                    end
//                    else begin
//                        NotificationReception.SetRange("Document N°", Code);
//                        NotificationReception.ModifyAll(Statut, NotificationReception.Statut::Lancé);
//                    end;
//                end;*/
//         }
//         field(13; "Cout Article"; Decimal)
//         {
//             CalcFormula = sum("Ligne BT"."Cout Ligne" where("Code BT" = field(Code)));
//             DecimalPlaces = 3 : 3;
//             FieldClass = FlowField;
//         }
//         field(14; "Cout Main d'oeuvre"; Decimal)
//         {
//             CalcFormula = sum("Intervenants BT"."Cout Ligne Intervention" where("Code BT" = field(Code)));
//             DecimalPlaces = 3 : 3;
//             FieldClass = FlowField;
//         }
//         field(15; "Cout BT"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(16; "Index Actuelle"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(17; Immatriculation; Code[20])
//         {
//             CalcFormula = lookup(Véhicule.Immatriculation where("N° Vehicule" = field(Equipement)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(18; Atelier; Code[20])
//         {
//         }
//         field(19; "Date Objectif"; Date)
//         {
//         }
//         field(50000; Chauffeur; Code[50])
//         {
//             TableRelation = "Chauffeur Location";
//         }
//         field(50001; "Vehicule Mission"; Code[20])
//         {
//             TableRelation = Véhicule;
//         }
//         field(50002; "DA Associé"; Code[20])
//         {
//             /*    TableRelation = "Sales Header"."No." where("Document Type" = filter(Order),
//                                                             "Order Type" = const("Supply Order"),
//                                                             Statut = filter(<> Archiver),
//                                                             Engin = field(Equipement));*/
//         }
//         field(50003; "Nom Chauffeur"; Text[100])
//         {
//             CalcFormula = lookup("Chauffeur Location".Nom where(Code = field(Chauffeur)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(50004; "Designation Vehicule"; Text[100])
//         {
//             CalcFormula = lookup(Véhicule.Désignation where("N° Vehicule" = field("Vehicule Mission")));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(50005; Utilisateur; Code[20])
//         {
//         }
//         field(50006; "Date Acceptation"; Date)
//         {
//         }
//         field(50007; "Heure Acceptation"; Time)
//         {
//         }
//         field(50008; "Nature Panne"; Option)
//         {
//             OptionCaption = ' ,Mécanique,Electrique,Pneumatique,Tollerie';
//             OptionMembers = " ","Mécanique",Electrique,Pneumatique,Tollerie;
//         }
//         field(50009; "Sous Nature Panne"; Code[50])
//         {
//             //GL3900   TableRelation = "Sous Nature Panne"."Sous Nature Panne" where("Nature Panne" = field("Nature Panne"));
//         }
//         field(50010; "Date Prevision Réparation"; Date)
//         {
//         }
//         field(50011; "Heure Prevision Réparation"; Time)
//         {
//         }
//         field(50012; "Date Début Réparation"; Date)
//         {
//         }
//         field(50013; "Heure Debut Réparation"; Time)
//         {
//         }
//         field(50014; "Date Fin réparation"; Date)
//         {
//         }
//         field(50015; "Heure Fin Réparation"; Time)
//         {
//         }
//         field(50016; "Statut Materiel"; Option)
//         {
//             OptionMembers = " ",Fonctionnel,Disponible,Panne,"Mauvais Temps";

//             trigger OnValidate()
//             begin
//                 //TESTFIELD("N° Véhicule");
//                 //IF Veh.GET("N° Véhicule") THEN BEGIN
//                 ///   Veh."Statut Vehicule":="Statut Materiel";
//                 //   Veh.MODIFY;
//                 //END;
//             end;
//         }
//         field(50017; "Motif  Ecart"; Option)
//         {
//             OptionMembers = " ","Piece Non Disponible","Main Ouevre Non Disponible","Travail Supplementaire","DA En Cours","Livraison Partielle Piece",Autre;
//         }
//         field(50018; "Descriptif Panne"; Text[250])
//         {
//         }
//         field(50019; "Opération Realisées"; Text[250])
//         {
//         }
//         field(50020; "Degré d'Urgence"; Option)
//         {
//             OptionCaption = 'Normal,Urgent, Trés Urgent';
//             OptionMembers = Normal,Urgent," Trés Urgent";
//         }
//     }

//     keys
//     {
//         key(Key1; "Code")
//         {
//             Clustered = true;
//         }
//         key(Key2; "Date Lancement")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     begin
//         LigneBT.SetRange("Code BT", Code);
//         LigneBT.DeleteAll;
//     end;

//     trigger OnInsert()
//     begin
//         Utilisateur := UpperCase(UserId);
//     end;

//     var
//         RecVehicule: Record "Véhicule";
//         LigneBT: Record "Ligne BT";
//         "Gamme_Mode Operatoire": Record "Gamme_Mode Operatoire";
//     // NotificationReception: Record "Notification Reception";
// }

