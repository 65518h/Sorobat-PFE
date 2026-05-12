
// Codeunit 39001409 "Enregistrement Cariere"
// {
//     //GL2024  ID dans Nav 2009 : "39001409"
//     TableNo = "Saisie Carière";

//     trigger OnRun()
//     var
//         "Carière": Record "Carière Enreg";
//         RecTmp: Record "Saisie Carière";
//         J: Integer;
//         Wind: Dialog;
//         i: Integer;
//         Sal: Record Employee;
//         trans: Integer;
//     begin
//         RecTmp.Reset;
//         RecTmp.CopyFilters(Rec);
//         J := 0;
//         i := 0;
//         trans := 0;
//         Carière.Reset;
//         Wind.Open('Valider Decision    :                   \' +
//                   'Salarié : #1########################### \' +
//                   ' Avancement :                           \' +
//                   ' @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ');
//         if Carière.Find('+') then begin
//             J := Carière."N° sequence";
//             trans := Carière."N° Transaction";
//         end;
//         trans := trans + 1;
//         if RecTmp.Find('-') then
//             repeat
//                 RecTmp.TestField(employee);
//                 RecTmp.TestField(Type);
//                 RecTmp.TestField(date);
//                 RecTmp.TestField("Date Décesion");
//                 J := J + 1;
//                 i := i + 1;
//                 Clear(Sal);
//                 Sal.Get(RecTmp.employee);
//                 Wind.Update(1, RecTmp.employee + ' ' + Sal."Last Name" + ' ' + Sal."First Name");
//                 if RecTmp.Count <> 0 then
//                     Wind.Update(2, ROUND(i / RecTmp.Count, 0.01) * 10000);
//                 enregCar(RecTmp, J, trans);
//             until RecTmp.Next = 0;
//         Wind.Close;
//     end;

//     var
//         Sal: Record Employee;
//         Qal: Record "Employee Qualification";
//         QalTmp: Record "Employee Qualification";
//         recEchelon: Record "Baréme De Charge";




//     procedure createQal(var Rec: Record "Saisie Carière")
//     begin
//         QalTmp.Reset;
//         QalTmp.SetFilter("Employee No.", Rec.employee);
//         Clear(Qal);
//         Qal.Init;
//         Qal."Employee No." := Rec.employee;
//         if QalTmp.Find('+') then
//             Qal."Line No." := QalTmp."Line No." + 10000
//         else
//             Qal."Line No." := 10000;
//         if Rec.Qualification <> '' then
//             Qal.Validate("Qualification Code", Rec.Qualification);
//         Qal."From Date" := Rec."Date Décesion";
//         Qal.Insert;
//     end;


//     procedure Validerimpr(var Rec: Record "Saisie Carière")
//     var
//         "Carière": Record "Carière Enreg";
//         RecTmp: Record "Saisie Carière";
//         J: Integer;
//         Wind: Dialog;
//         i: Integer;
//         Sal: Record Employee;
//         trans: Integer;
//     begin
//         RecTmp.Reset;
//         RecTmp.CopyFilters(Rec);
//         J := 0;
//         i := 0;
//         trans := 0;
//         Carière.Reset;
//         Wind.Open('Valider Decision    :                   \' +
//                   'Salarié : #1########################### \' +
//                   ' Avancement :                           \' +
//                   ' @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ');
//         if Carière.Find('+') then begin
//             J := Carière."N° sequence";
//             trans := Carière."N° Transaction";
//         end;
//         trans := trans + 1;
//         if RecTmp.Find('-') then
//             RecTmp.TestField(employee);
//         RecTmp.TestField(Type);
//         RecTmp.TestField(date);
//         RecTmp.TestField("Date Décesion");
//         repeat
//             J := J + 1;
//             i := i + 1;
//             Clear(Sal);
//             Sal.Get(RecTmp.employee);
//             Wind.Update(1, RecTmp.employee + ' ' + Sal."Last Name" + ' ' + Sal."First Name");
//             if RecTmp.Count <> 0 then
//                 Wind.Update(2, ROUND(i / RecTmp.Count, 0.01) * 10000);
//             enregCar(RecTmp, J, trans);
//         until RecTmp.Next = 0;
//         Wind.Close;
//         Commit;
//         Carière.Reset;
//         Carière.SetFilter("N° Transaction", '%1', trans);
//         Report.Run(39001456, true, false, Carière);
//     end;


//     procedure enregCar(var Rec: Record "Saisie Carière"; Nseq: Integer; Transact: Integer)
//     var
//         "Carière": Record "Carière Enreg";
//         "CarièreTmp": Record "Carière Enreg";
//     begin
//         with Rec do begin
//             Clear(Sal);
//             Sal.Get(employee);
//             case Type of
//                 1:
//                     begin  //Recrutement
//                         Sal."Employment Date" := "Date Entrée";
//                         Sal."Basis salary" := "Salaire Base";
//                         Sal.Catégorie := Collège;
//                         Sal.Echelle := Echelle;
//                         Sal.Echellons := Echelon;
//                         Sal.Status := Status;
//                         Sal."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                         Sal."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                         Sal."Relation de travail" := "Relation de travail";
//                         Sal.Direction := Direction;
//                         Sal.Service := Service;
//                         Sal.Section := Section;
//                         createQal(Rec);
//                     end;
//                 2:
//                     begin //Passage Horizontal (echelon)
//                         Sal.Validate(Echellons, Echelon);
//                     end;
//                 3:
//                     begin //Passage Vertical (Categorie/Echelle)
//                         Sal.Collège := Collège;
//                         Sal.Echelle := Echelle;
//                         Sal.Validate(Echellons, Echelon);
//                     end;
//                 4:
//                     begin //Relation Travail
//                         Sal."Relation de travail" := "Relation de travail";
//                     end;
//                 5:
//                     begin //Site Travail
//                         Sal.Direction := Direction;
//                         Sal.Service := Service;
//                         Sal.Section := Section;
//                         Sal."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                         Sal."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                     end;
//                 6:
//                     begin //Fonction (Qualification)
//                         Sal.Catégorie := Collège;
//                         Sal.Echelle := Echelle;
//                         Sal.Validate(Echellons, Echelon);
//                         createQal(Rec);
//                     end;
//                 7:
//                     begin //Renouvellement Contrat
//                         Sal."Employment Date" := "Date Entrée";
//                         Sal."Basis salary" := "Salaire Base";
//                         Sal.Catégorie := Collège;
//                         Sal.Echelle := Echelle;
//                         Sal.Echellons := Echelon;
//                         Sal.Status := Status;
//                         Sal."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                         Sal."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                         Sal."Relation de travail" := "Relation de travail";
//                         Sal.Direction := Direction;
//                         Sal.Service := Service;
//                         Sal.Section := Section;
//                         createQal(Rec);
//                     end;
//                 8:
//                     begin //Dossier (affectation analytique)
//                         Sal."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                     end;
//                 9:
//                     begin //Statuts
//                         case Status of
//                             0:
//                                 begin
//                                     Sal.Status := Status;
//                                     Sal."date debut contrat" := "Date Debut Contrat";
//                                     Sal."Termination Date" := "Date Fin Contrat";
//                                     Sal."Grounds for Term. Code" := '';
//                                     Sal."Inactive Date" := 0D;
//                                 end;

//                             1:
//                                 begin
//                                     Sal.Status := Status;
//                                     Sal."Inactive Date" := "Date Fin Contrat";
//                                     Sal."Grounds for Term. Code" := '';
//                                     Sal."Inactive Date" := 0D;
//                                 end;

//                             2:
//                                 begin
//                                     Sal.Status := Status;
//                                     Sal."Grounds for Term. Code" := '';
//                                     Sal."Inactive Date" := 0D;
//                                 end;

//                         end;
//                     end;
//                 10:
//                     begin //Bonification
//                         Sal."Upgrading date Cat/Echelon" := CalcDate(StrSubstNo('-%1M', "Nbre Mois Bonification"), Sal."Upgrading date Cat/Echelon");

//                     end;
//                 11, 12, 13, 14, 15:
//                     begin
//                         createQal(Rec);
//                         Sal.Grade := Grade;
//                         Sal.Echelle := Echelle;
//                         Sal.Echellons := Echelon;
//                         Sal."Basis salary" := "Salaire Base";
//                         recEchelon.Get(Sal.Echellons);
//                         Sal."Upgrading date Cat/Echelon" := CalcDate(StrSubstNo('+%1', recEchelon."Date fomula"), Sal."Upgrading date Cat/Echelon");
//                         Message(Format(Sal."Upgrading date Cat/Echelon"));
//                     end;
//             end;

//             if Sal.Modify then begin
//                 CarièreTmp.Reset;
//                 CarièreTmp.SetCurrentkey(employee, date);
//                 CarièreTmp.SetFilter(employee, Rec.employee);
//                 CarièreTmp.SetFilter(date, '..%1', Rec.date);

//                 Carière.Init;
//                 Carière."N° sequence" := Nseq;
//                 Carière."N° Transaction" := Transact;
//                 if CarièreTmp.Find('+') then
//                     Carière."Ancien Salaire Base" := CarièreTmp."Salaire Base";
//                 Carière.TransferFields(Rec);
//                 if Carière.Insert then
//                     Delete;
//             end;
//         end;
//     end;
// }

