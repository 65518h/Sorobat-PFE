// Table 39001509 Notes
// {
//     //GL2024  ID dans Nav 2009 : "39001509"
//     fields
//     {
//         field(1; "Année"; Integer)
//         {
//             NotBlank = false;
//         }
//         field(2; Matricule; Code[20])
//         {
//         }
//         field(3; "Montant Ancienneté"; Decimal)
//         {
//         }
//         field(4; Note; Decimal)
//         {
//         }
//         field(5; "Montant Prime"; Decimal)
//         {
//         }
//         field(50001; Affectation; Code[20])
//         {
//             Description = 'MH SORO 22-06-2016';
//             //  TableRelation = Section.Section;
//         }
//         field(50002; Qualification; Code[20])
//         {
//             Description = 'MH SORO 22-06-2016';
//         }
//         field(50003; Imposable; Boolean)
//         {
//             Description = 'MH SORO 22-06-2016';
//         }
//         field(50004; "Description Affectation"; Text[100])
//         {
//             Description = 'MH SORO 22-06-2016';
//         }
//         field(50005; "Description Qualification"; Text[100])
//         {
//             Description = 'MH SORO 22-06-2016';
//         }
//         field(50006; "Nom Salariée"; Text[50])
//         {
//             Description = 'MH SORO 22-06-2016';
//         }
//         field(50007; "Base Calcul"; Decimal)
//         {
//             Description = 'MH SORO 22-06-2016';
//         }
//         field(50008; "Nbre Fiche"; Integer)
//         {
//             Description = 'MH SORO 22-06-2016';
//         }
//         field(50009; "Ancienté"; Integer)
//         {
//             Description = 'MH SORO 22-06-2016';
//         }
//         field(50010; Statut; Option)
//         {
//             OptionMembers = Ouvert,"Validé";
//         }
//         field(50011; Affectation2; Code[20])
//         {
//             // CalcFormula = lookup(Employee.Affectation where("No." = field(Matricule)));
//             // Description = 'HJ Soro 07-06-2017';
//             // Editable = false;
//             // FieldClass = FlowField;
//         }
//         field(50012; Zone; Text[1])
//         {
//             // CalcFormula = lookup(Employee.Zone where("No." = field(Matricule)));
//             // Editable = false;
//             // FieldClass = FlowField;
//         }
//         field(50013; "Nbre Jours Base calcul"; Decimal)
//         {
//             Description = 'MH SORO 16-08-2017';
//         }
//         field(50014; "Nbre Mois Base calcul"; Decimal)
//         {
//             Description = 'MH SORO 16-08-2017';
//         }
//         field(50015; "Montant Prime Base calcul"; Decimal)
//         {
//             Description = 'MH SORO 16-08-2017';
//         }
//         field(50016; "Nbre Jours Réelle"; Decimal)
//         {
//             Description = 'MH SORO 24-07-2018';
//         }
//         field(50017; "Nbre Mois Réelle"; Decimal)
//         {
//             Description = 'MH SORO 24-07-2018';
//         }
//         field(50018; "Avance sur Prime"; Decimal)
//         {
//             DecimalPlaces = 0 : 3;
//             Description = 'MH SORO 17-08-2018';
//         }
//         field(50019; Net; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//             Description = 'MH SORO 07-09-2018';
//         }
//         field(50020; "nbr jours tempo"; Decimal)
//         {
//         }
//         field(50021; JO; Boolean)
//         {
//             Description = 'KA SORO 02-08-2019';
//         }
//         field(50022; "Min"; Boolean)
//         {
//             Description = 'MH SORO 03-08-2019';
//         }
//         field(50023; "Payé"; Boolean)
//         {
//             Description = 'MH SORO 08-08-2019';
//         }
//         field(50024; "Salaire Net Actuel"; Decimal)
//         {
//             Description = 'MH SORO 13-07-2020';
//         }
//         field(50025; "Solde Congé"; Decimal)
//         {
//             Description = 'MH SORO 13-07-2020';
//         }
//         field(50026; "Nbre Jours à retenir"; Decimal)
//         {
//             Description = 'MH SORO 13-07-2020';

//             trigger OnValidate()
//             begin
//                 "Montant Congé 2" := -(("Salaire Net Actuel" / 26) * "Nbre Jours à retenir");
//                 "Montant Prime Final" := "Montant Prime" + "Montant Congé 2";
//             end;
//         }
//         field(50027; "Montant Congé 1"; Decimal)
//         {
//             Description = 'MH SORO 13-07-2020';

//             trigger OnValidate()
//             begin
//                 "Montant Congé 1" := ("Salaire Net Actuel" / 26) * "Solde Congé";
//             end;
//         }
//         field(50028; "Montant Congé 2"; Decimal)
//         {
//             Description = 'MH SORO 13-07-2020';
//         }
//         field(50029; "Montant Prime Final"; Decimal)
//         {
//             Description = 'MH SORO 13-07-2020';
//         }
//         field(50030; "Solde Congé au 31-12"; Decimal)
//         {
//             Description = 'MH SORO 13-07-2020';
//         }
//         field(50031; "montant Congé au 31-12"; Decimal)
//         {
//             Description = 'MH SORO 13-07-2020';
//         }
//         field(50032; Temp; Decimal)
//         {
//             Description = 'MH SORO 13-07-2020';

//             trigger OnValidate()
//             begin

//                 "Solde Congé au 31-12" := Temp + ROUND("Solde Congé", 0.01, '=');
//                 "montant Congé au 31-12" := ("Salaire Net Actuel" / 26) * ROUND("Solde Congé au 31-12", 0.01, '=');
//             end;
//         }
//     }

//     keys
//     {
//         key(Key1; "Année", Matricule)
//         {
//             Clustered = true;
//         }
//         key(Key2; Affectation, "Année", Matricule)
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         RecEmployee: Record Employee;
// }

