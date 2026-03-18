// Table 39001529 "Entete Lot Paie"
// {
//     //GL2024  ID dans Nav 2009 : "39001529"
//     DrillDownPageID = "Liste Lot Virement Salaire";
//     LookupPageID = "Liste Lot Virement Salaire";

//     fields
//     {
//         field(1; "Code"; Code[20])
//         {
//         }
//         field(2; "Code Banque"; Code[20])
//         {
//             TableRelation = "Bank Account";

//             trigger OnValidate()
//             begin

//                 RecLigneLotPaie.Reset;
//                 RecLigneLotPaie.SetRange(Code, Code);
//                 RecLigneLotPaie.SetRange("Code Banque", "Code Banque");
//                 if RecLigneLotPaie.FindFirst then
//                     Error(Text002);

//                 if RecBankAccount.Get("Code Banque") then;
//                 "Nom Banque" := RecBankAccount.Name;
//             end;
//         }
//         field(3; "Date Creation"; Date)
//         {
//         }
//         field(4; "Nom Banque"; Text[50])
//         {
//         }
//         field(5; Status; Option)
//         {
//             OptionCaption = 'En Cours,Validée';
//             OptionMembers = "En Cours","Validée";
//         }
//         field(6; "Mantant Net"; Decimal)
//         {
//             CalcFormula = sum("Ligne Lot Paie"."Montant Net" where(Code = field(Code)));
//             FieldClass = FlowField;
//         }
//         field(7; Mois; Option)
//         {
//             OptionCaption = ' ,Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,Congé,Prime,Rappel,Solder jour de congé,STC';
//             OptionMembers = " ",Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,Rappel,"Solder jour de congé",STC;
//         }
//         field(8; Annee; Integer)
//         {
//         }
//         field(9; "Code Affectation"; Code[10])
//         {
//             // TableRelation = Section.Section;

//             trigger OnValidate()
//             begin

//                 RecLigneLotPaie.Reset;
//                 RecLigneLotPaie.SetRange(Code, Code);
//                 //RecLigneLotPaie.SETRANGE("Code Banque","Code Banque");
//                 if RecLigneLotPaie.FindFirst then
//                     Error(Text003);

//                 if RecSection.Get("Code Affectation") then;
//                 "Description Affectation" := RecSection.Decription;
//             end;
//         }
//         field(10; "Description Affectation"; Text[50])
//         {
//         }
//         field(11; "Inserer en Comptabilité"; Boolean)
//         {
//         }
//         field(12; "Code Bordereau"; Code[20])
//         {
//         }
//         field(13; Type; Option)
//         {
//             OptionCaption = ' ,Bordereau,Ordre Virement,Rejet Salaire';
//             OptionMembers = " ",Bordereau,"Ordre Virement","Rejet Salaire";
//         }
//         field(14; "Ordre Virement Salaire"; Code[20])
//         {
//         }
//         field(15; "Inserer en Ordre Virement Sala"; Boolean)
//         {
//         }
//         field(16; User; Code[20])
//         {
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "Code")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     begin
//         RecLigneLotPaie.Reset;
//         RecLigneLotPaie.SetRange(Code, Code);
//         RecLigneLotPaie.SetRange("Code Banque", "Code Banque");
//         if RecLigneLotPaie.FindFirst then
//             Error(Text001);
//     end;

//     trigger OnInsert()
//     begin
//         /*
//         RecHumanResourcesSetup.GET;
//         Code :=NoSeriesMgt.GetNextNo(RecHumanResourcesSetup."Lot Paie",0D,TRUE);
//         "Date Creation" := TODAY;
//         */

//     end;

//     var
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         RecHumanResourcesSetup: Record "Human Resources Setup";
//         RecEmployee: Record Employee;
//         RecBankAccount: Record "Bank Account";
//         RecLigneLotPaie: Record "Ligne Lot Paie";
//         Text001: label 'Vous devez supprimer les Lignes !!!';
//         Text002: label 'Erreur, vous ne pouvez pas modifier le code Bannquaire Aprés L''insertion des lignes de Salaires!!!';
//         RecSection: Record "Tranche STC";
//         Text003: label 'Erreur, vous ne pouvez pas modifier le code de l''affectation Aprés L''insertion des lignes de Salaires!!!';
// }

