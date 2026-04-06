// Table 39001540 "Ligne Affectation Employé"
// {
//     //GL2024  ID dans Nav 2009 : "39001540"
//     fields
//     {
//         field(1; "N°"; Code[20])
//         {
//         }
//         field(3; "Employé"; Code[20])
//         {
//             TableRelation = Employee;

//             /*  trigger OnValidate()
//               begin
//                   "Salaire Brut" := 0;
//                   "Salaire de Base" := 0;
//                   RecEmployee.Reset();
//                   RecEmployee.SetRange("No.", Employé);
//                   if RecEmployee.FindFirst then begin
//                       "Nom et Prenom" := RecEmployee."First Name";
//                       Affectation := RecEmployee.Affectation;
//                       RecSection.Reset;
//                       Qualification := RecEmployee.Qualification;
//                       Categorie := RecEmployee.Collège;
//                       RecEmployee.CalcFields("Indemnité imposable");
//                       RecEmployee.CalcFields("Total Indemnité Par Defaut");
//                       if RecEmployee."Salaire De Base Horaire" = 0 then
//                           "Salaire Brut" := RecEmployee."Total Indemnité Par Defaut" + RecEmployee."Basis salary"
//                       else
//                           "Salaire Brut" := RecEmployee."Total Indemnité Par Defaut" + RecEmployee."Salaire De Base Horaire";
//                       "Salaire de Base" := RecEmployee."Basis salary";
//                       Zone := RecEmployee.Zone;
//                       RecPointageEmployé.Reset();
//                       RecPointageEmployé.SetRange("N°", "N°");
//                       if RecPointageEmployé.FindFirst then begin
//                           Journée := RecPointageEmployé.Journée;

//                       end;


//                   end;
//               end;*/
//         }
//         field(4; "Journée"; Date)
//         {
//         }
//         field(5; Chantier; Code[20])
//         {
//             TableRelation = Job;
//         }
//         field(6; "Nom et Prenom"; Text[100])
//         {
//         }
//         field(7; Affectation; Code[20])
//         {
//         }
//         field(8; Qualification; Code[20])
//         {
//         }
//         field(9; Categorie; Code[10])
//         {
//         }
//         field(10; "Salaire Brut"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(11; "Salaire de Base"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(12; Present; Option)
//         {
//             OptionMembers = " ",P,C,A,F;
//         }
//         field(13; "Heure Debut Service"; Time)
//         {
//         }
//         field(14; "Heure Fin Service"; Time)
//         {
//         }
//         field(15; Observation; Text[250])
//         {
//         }
//         field(16; "Nbre Heure"; Decimal)
//         {
//         }
//         field(17; "Nouveau Affectation"; Code[20])
//         {
//             TableRelation = "Tranche STC";

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then begin
//             //         "Description Affectation" := RecSection.Decription;
//             //         Chantier := RecSection.Chantier;
//             //     end;
//             // end;
//         }
//         field(18; "Description Affectation"; Text[150])
//         {
//         }
//         field(19; "1"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(20; "2"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(21; "3"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(22; "4"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(23; "5"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(24; "6"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(25; "7"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(26; "8"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(27; "9"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(28; "10"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(29; "11"; Code[20])
//         {
//             //     TableRelation = Section;

//             //     trigger OnValidate()
//             //     begin
//             //         RecSection.SetRange(Section, "Nouveau Affectation");
//             //         if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             //     end;
//         }
//         field(30; "12"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(31; "13"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(32; "14"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(33; "15"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(34; "16"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(35; "17"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(36; "18"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(37; "19"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(38; "20"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(39; "21"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(40; "22"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(41; "23"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(42; "24"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(43; "25"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(44; "26"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(45; "27"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(46; "28"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(47; "29"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(48; "30"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(49; "31"; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     RecSection.SetRange(Section, "Nouveau Affectation");
//             //     if RecSection.FindFirst then Chantier := RecSection.Chantier;
//             // end;
//         }
//         field(50; Zone; Code[10])
//         {
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "N°", "Employé")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         RecEmployee: Record Employee;
//         "RecPointageEmployé": Record "Pointage Employé";
//         RecSection: Record "Tranche STC";
// }

