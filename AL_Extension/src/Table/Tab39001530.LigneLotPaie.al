// Table 39001530 "Ligne Lot Paie"
// {
//     //GL2024  ID dans Nav 2009 : "39001530"
//     fields
//     {
//         field(1; "Code"; Code[20])
//         {
//         }
//         field(2; "Code Banque"; Code[20])
//         {
//         }
//         field(3; "Matricule Salarié"; Code[20])
//         {
//             TableRelation = Employee."No.";

//             // trigger OnValidate()
//             // begin
//             //     if RecEmployee.Get("Matricule Salarié") then;
//             //     "Nom Salarie" := RecEmployee."First Name";
//             //     RIB := RecEmployee.RIB;
//             //     "Banque Salarié" := RecEmployee."Banque Salarié";
//             // end;
//         }
//         field(4; "Nom Salarie"; Text[60])
//         {
//         }
//         field(5; RIB; Code[20])
//         {
//         }
//         field(6; "Montant Net"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;

//         }
//         field(7; Status; Option)
//         {
//             OptionCaption = 'En Cours,Validée';
//             OptionMembers = "En Cours","Validée";
//         }
//         field(8; "Num Paie"; Code[20])
//         {
//         }
//         field(9; "Banque Salarié"; Code[20])
//         {
//         }
//         field(10; "Code Affectation"; Code[20])
//         {
//         }
//         field(11; Type; Option)
//         {
//             OptionCaption = ' ,Bordereau,Ordre Virement,Rejet Salaire';
//             OptionMembers = " ",Bordereau,"Ordre Virement","Rejet Salaire";
//         }
//         field(12; "Ordre Virement Salaire"; Code[20])
//         {
//         }
//         field(13; Selection; Boolean)
//         {
//         }
//         field(14; "Rejet Salaire"; Code[20])
//         {
//         }
//         field(50000; Mois; Option)
//         {
//             CalcFormula = lookup("Heures occa. enreg. m"."Mois de paiement" where("Paiement No." = field("Num Paie")));
//             Editable = false;
//             FieldClass = FlowField;
//             OptionCaption = 'Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,Congé,Prime,Rappel,Solder jour de congé,Divers,STC';
//             OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,Rappel,"Solder jour de congé",Divers,STC;
//         }
//         field(50001; Annee; Integer)
//         {
//             CalcFormula = lookup("Heures occa. enreg. m"."Année de paiement" where("Paiement No." = field("Num Paie")));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(Key1; "Code", "Matricule Salarié")
//         {
//             Clustered = true;
//             SumIndexFields = "Montant Net";
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     begin
//         // if "Ordre Virement Salaire" <> '' then
//         //     Error(TEXT001);
//         // RecSalaryLines.Reset;
//         // if RecSalaryLines.Get("Num Paie", "Matricule Salarié") then begin
//         //     RecSalaryLines."Lot Virement Salaire" := '';
//         //     //RecSalaryLines."Code Banque Virement" := '';
//         //     RecSalaryLines.Modify;
//         // end
//         // else begin
//         //     RecSalaryLinesEnr.Reset;
//         //     if RecSalaryLinesEnr.Get("Num Paie", "Matricule Salarié") then begin
//         //         RecSalaryLinesEnr."Lot Virement Salaire" := '';
//         //         //RecSalaryLinesEnr."Code Banque Virement" := '';
//         //         RecSalaryLinesEnr.Modify;
//         //     end;

//         // end;
//     end;

//     var
//         RecEmployee: Record Employee;
//         RecSalaryLines: Record "Salary Lines";
//         RecSalaryLinesEnr: Record "Rec. Salary Lines";
//         TEXT001: label 'Erreur !!! Vous ne pouvez pas supprimer une lignie déja inserer dans un Ordre de Virement de Salaire';
// }

