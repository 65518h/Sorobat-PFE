// Page 50199 "Regroupement paie"
// {
//     PageType = Card;
//     SourceTable = "Regroupement Paie";
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Regroupement paie';
//     layout
//     {
//         area(content)
//         {
//             label(Control1000000038)
//             {
//                 ApplicationArea = all;
//                 Caption = '............................INTEGRATION PAIE A LA CAISSE............................';
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field(Affect; NumCaisse)
//             {
//                 ApplicationArea = all;
//                 Caption = 'N° Caisse';
//                 Editable = false;

//                 trigger OnValidate()
//                 begin
//                     //RESET;
//                     //CALCFIELDS("Nombre Salarier");
//                     //NombreSalarié:= "Nombre Salarier";
//                     //IF CodeAffectation <>'' THEN
//                     // BEGIN
//                     //   SETRANGE(Affectation,CodeAffectation);
//                     //  EtatMensuellePaie.SETRANGE(Affectation,CodeAffectation);
//                     //  EtatMensuellePaie.CALCFIELDS("Nombre Salarier");
//                     //  NombreSalarié:= EtatMensuellePaie.COUNT;
//                     // END;
//                     //    PaymentHeader.COPY(Rec);
//                     RegroupementPaie.DeleteAll;
//                     //REPORT.RUN (50224,TRUE,TRUE,SalaryLines);
//                     SalaryLines.SetCurrentkey(Employee);
//                     SalaryLines.SetRange(SalaryLines.Affectation, CodeAffectation);
//                     if SalaryLines.FindFirst then
//                         repeat
//                             CaisseExtra.SetRecord(PaymentHeader);
//                             // PaymentHeader.GET();
//                             RegroupementPaie."N° Caisse" := PaymentHeader."No.";
//                             RegroupementPaie."N° Salarié" := SalaryLines.Employee;
//                             RegroupementPaie."Nom Salarié" := SalaryLines.Name;
//                             RegroupementPaie.Affectation := SalaryLines.Affectation;
//                             RegroupementPaie.Qualification := SalaryLines.Qualification;
//                             RegroupementPaie.Mantant := SalaryLines."Net salary cashed";
//                             RegroupementPaie.Insert;
//                         until SalaryLines.Next = 0;
//                     Commit;
//                     NumCaisseOnAfterValidate;
//                 end;
//             }
//             field(MoisPaie; MoisPaie)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Mois Paie';
//             }
//             field(Affect1; Datecaisse)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Date';
//                 Editable = false;

//                 trigger OnValidate()
//                 begin
//                     //RESET;
//                     //CALCFIELDS("Nombre Salarier");
//                     //NombreSalarié:= "Nombre Salarier";
//                     //IF CodeAffectation <>'' THEN
//                     // BEGIN
//                     //   SETRANGE(Affectation,CodeAffectation);
//                     //  EtatMensuellePaie.SETRANGE(Affectation,CodeAffectation);
//                     //  EtatMensuellePaie.CALCFIELDS("Nombre Salarier");
//                     //  NombreSalarié:= EtatMensuellePaie.COUNT;
//                     // END;
//                     //    PaymentHeader.COPY(Rec);
//                     RegroupementPaie.DeleteAll;
//                     //REPORT.RUN (50224,TRUE,TRUE,SalaryLines);
//                     SalaryLines.SetCurrentkey(Employee);
//                     SalaryLines.SetRange(SalaryLines.Affectation, CodeAffectation);
//                     if SalaryLines.FindFirst then
//                         repeat
//                             CaisseExtra.SetRecord(PaymentHeader);
//                             // PaymentHeader.GET();
//                             RegroupementPaie."N° Caisse" := PaymentHeader."No.";
//                             RegroupementPaie."N° Salarié" := SalaryLines.Employee;
//                             RegroupementPaie."Nom Salarié" := SalaryLines.Name;
//                             RegroupementPaie.Affectation := SalaryLines.Affectation;
//                             RegroupementPaie.Qualification := SalaryLines.Qualification;
//                             RegroupementPaie.Mantant := SalaryLines."Net salary cashed";
//                             RegroupementPaie.Insert;
//                         until SalaryLines.Next = 0;
//                     Commit;
//                     DatecaisseOnAfterValidate;
//                 end;
//             }
//             field(Receptionneur; Receptionneur)
//             {
//                 ApplicationArea = all;
//                 TableRelation = Salarier;

//                 trigger OnValidate()
//                 begin

//                     RecSalarier.Reset;
//                     RecSalarier.SetRange(RecSalarier.Salarie, Receptionneur);
//                     if RecSalarier.FindFirst() then NomReceptionneur := RecSalarier."Nom Et Prenom";
//                 end;
//             }
//             field(AnnePaie; AnnePaie)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Annee Paie';
//             }
//             field(MatriculePaie; MatriculePaie)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Matricule Salarier';
//                 TableRelation = Salarier;

//                 trigger OnValidate()
//                 begin
//                     AnnePaie := 0;
//                     CodeAffectation := '';
//                 end;
//             }
//             field(Affect2; CodeAffectation)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Affectation';
//                 TableRelation = Section;

//                 trigger OnValidate()
//                 begin
//                     MatriculePaie := '';
//                     /*RegroupementPaie.DELETEALL;
//                     SalaryLines.SETCURRENTKEY(Employee);
//                     SalaryLines.SETRANGE(SalaryLines.Affectation,CodeAffectation);
//                     SalaryLines.SETRANGE(SalaryLines."Code Mode Réglement",0);
//                     IF SalaryLines.FINDFIRST THEN
//                       REPEAT
//                        IF RecSection.GET(SalaryLines.Affectation) THEN Affect:=RecSection.Decription;
//                        IF RecQualification.GET(SalaryLines.Qualification) THEN Qualif:=RecQualification.Description;

//                        RegroupementPaie."N° Caisse":=NumCaisse;
//                       RegroupementPaie."N° Paie":=SalaryLines."No.";
//                       RegroupementPaie."Designation Paie":=SalaryLines.Description;
//                       RegroupementPaie."N° Salarié":=SalaryLines.Employee;
//                       RegroupementPaie."Nom Salarié":=SalaryLines.Name;
//                       RegroupementPaie.Affectation:=SalaryLines.Affectation;
//                       RegroupementPaie.Qualification:=SalaryLines.Qualification;
//                       RegroupementPaie."Designation Affectation":=Affect;
//                       RegroupementPaie."Designation Qualification":=Qualif;
//                       RegroupementPaie.Mantant:=SalaryLines."Net salary cashed";
//                       RegroupementPaie.INSERT;
//                       UNTIL SalaryLines.NEXT=0;
//                     COMMIT; */
//                     CodeAffectationOnAfterValidate;

//                 end;
//             }
//             field(NomReceptionneur; NomReceptionneur)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Nom Receptionneur';
//                 Editable = false;
//                 Enabled = true;
//             }
//             repeater(Control1)
//             {
//                 Editable = true;
//                 field("N° Caisse"; REC."N° Caisse")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("N° Paie"; REC."N° Paie")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Designation Paie"; REC."Designation Paie")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("N° Salarié"; REC."N° Salarié")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Matricule';
//                     Editable = false;
//                 }
//                 field("Nom Salarié"; REC."Nom Salarié")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Mantant; REC.Mantant)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Control1000000039; MoisPaie)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(AnneePaie; REC.AnneePaie)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Affectation; REC.Affectation)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Designation Affectation"; REC."Designation Affectation")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Qualification; REC.Qualification)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Designation Qualification"; REC."Designation Qualification")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//             //GL2024 label(Control1000000044)
//             // {
//             //     ApplicationArea = all;
//             //     //CaptionClass = Text19071466;
//             //     Style = Strong;
//             //     StyleExpr = true;
//             // }

//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Recherche)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Recherche';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if MatriculePaie = '' then begin //**********
//                         RegroupementPaie.DeleteAll;
//                         SalaryLines.SetCurrentkey(Employee);
//                         SalaryLines.SetRange(SalaryLines.Affectation, CodeAffectation);
//                         SalaryLines.SetRange(SalaryLines."Code Mode Réglement", 0);
//                         if SalaryLines.FindFirst then
//                             repeat
//                                 if RecSection.Get(SalaryLines.Affectation) then Affect := RecSection.Decription;
//                                 if RecQualification.Get(SalaryLines.Qualification) then Qualif := RecQualification.Description;

//                                 RegroupementPaie."N° Caisse" := NumCaisse;
//                                 RegroupementPaie."N° Paie" := SalaryLines."No.";
//                                 RegroupementPaie."Designation Paie" := SalaryLines.Description;
//                                 RegroupementPaie."N° Salarié" := SalaryLines.Employee;
//                                 RegroupementPaie."Nom Salarié" := SalaryLines.Name;
//                                 RegroupementPaie.Affectation := SalaryLines.Affectation;
//                                 RegroupementPaie.Qualification := SalaryLines.Qualification;
//                                 RegroupementPaie."Designation Affectation" := Affect;
//                                 RegroupementPaie."Designation Qualification" := Qualif;
//                                 RegroupementPaie.Mantant := SalaryLines."Net salary cashed";
//                                 RegroupementPaie.MoisPaie := SalaryLines.Month;
//                                 RegroupementPaie.AnneePaie := SalaryLines.Year;
//                                 RegroupementPaie.Insert;
//                             until SalaryLines.Next = 0;


//                         RecSalaryLines.SetCurrentkey(Employee);
//                         RecSalaryLines.SetRange(RecSalaryLines.Month, MoisPaie);
//                         RecSalaryLines.SetRange(RecSalaryLines.Year, AnnePaie);
//                         RecSalaryLines.SetRange(RecSalaryLines.Affectation, CodeAffectation);
//                         RecSalaryLines.SetRange(RecSalaryLines."Code Mode Réglement", 0);
//                         if RecSalaryLines.FindFirst then
//                             repeat
//                                 if RecSection.Get(RecSalaryLines.Affectation) then Affect := RecSection.Decription;
//                                 if RecQualification.Get(RecSalaryLines.Qualification) then Qualif := RecQualification.Description;

//                                 RegroupementPaie."N° Caisse" := NumCaisse;
//                                 RegroupementPaie."N° Paie" := RecSalaryLines."No.";
//                                 RegroupementPaie."Designation Paie" := RecSalaryLines.Description;
//                                 RegroupementPaie."N° Salarié" := RecSalaryLines.Employee;
//                                 RegroupementPaie."Nom Salarié" := RecSalaryLines.Name;
//                                 RegroupementPaie.Affectation := RecSalaryLines.Affectation;
//                                 RegroupementPaie.Qualification := RecSalaryLines.Qualification;
//                                 RegroupementPaie."Designation Affectation" := Affect;
//                                 RegroupementPaie."Designation Qualification" := Qualif;
//                                 RegroupementPaie.Mantant := RecSalaryLines."Net salary cashed";
//                                 RegroupementPaie.MoisPaie := RecSalaryLines.Month;
//                                 RegroupementPaie.AnneePaie := RecSalaryLines.Year;

//                                 RegroupementPaie.Insert;
//                             until RecSalaryLines.Next = 0;
//                         Commit;

//                     end //*************
//                     else begin
//                         RegroupementPaie.DeleteAll;
//                         //SalaryLines.SETCURRENTKEY(Employee);
//                         SalaryLines.SetRange(SalaryLines.Employee, MatriculePaie);
//                         //SalaryLines.SETRANGE(SalaryLines.Affectation,CodeAffectation);
//                         //SalaryLines.SETRANGE(SalaryLines."Code Mode Réglement",0);
//                         if SalaryLines.FindFirst then
//                             repeat
//                                 if RecSection.Get(SalaryLines.Affectation) then Affect := RecSection.Decription;
//                                 if RecQualification.Get(SalaryLines.Qualification) then Qualif := RecQualification.Description;

//                                 RegroupementPaie."N° Caisse" := NumCaisse;
//                                 RegroupementPaie."N° Paie" := SalaryLines."No.";
//                                 RegroupementPaie."Designation Paie" := SalaryLines.Description;
//                                 RegroupementPaie."N° Salarié" := SalaryLines.Employee;
//                                 RegroupementPaie."Nom Salarié" := SalaryLines.Name;
//                                 RegroupementPaie.Affectation := SalaryLines.Affectation;
//                                 RegroupementPaie.Qualification := SalaryLines.Qualification;
//                                 RegroupementPaie."Designation Affectation" := Affect;
//                                 RegroupementPaie."Designation Qualification" := Qualif;
//                                 RegroupementPaie.Mantant := SalaryLines."Net salary cashed";
//                                 RegroupementPaie.MoisPaie := SalaryLines.Month;
//                                 RegroupementPaie.AnneePaie := SalaryLines.Year;

//                                 RegroupementPaie.Insert;
//                             until SalaryLines.Next = 0;


//                         //RecSalaryLines.SETCURRENTKEY(Employee);
//                         RecSalaryLines.SetRange(RecSalaryLines.Employee, MatriculePaie);
//                         //RecSalaryLines.SETRANGE(RecSalaryLines.Month,MoisPaie);
//                         //RecSalaryLines.SETRANGE(RecSalaryLines.Year,AnnePaie);
//                         //RecSalaryLines.SETRANGE(RecSalaryLines.Affectation,CodeAffectation);
//                         //RecSalaryLines.SETRANGE(RecSalaryLines."Code Mode Réglement",0);
//                         if RecSalaryLines.FindFirst then
//                             repeat
//                                 if RecSection.Get(RecSalaryLines.Affectation) then Affect := RecSection.Decription;
//                                 if RecQualification.Get(RecSalaryLines.Qualification) then Qualif := RecQualification.Description;

//                                 RegroupementPaie."N° Caisse" := NumCaisse;
//                                 RegroupementPaie."N° Paie" := RecSalaryLines."No.";
//                                 RegroupementPaie."Designation Paie" := RecSalaryLines.Description;
//                                 RegroupementPaie."N° Salarié" := RecSalaryLines.Employee;
//                                 RegroupementPaie."Nom Salarié" := RecSalaryLines.Name;
//                                 RegroupementPaie.Affectation := RecSalaryLines.Affectation;
//                                 RegroupementPaie.Qualification := RecSalaryLines.Qualification;
//                                 RegroupementPaie."Designation Affectation" := Affect;
//                                 RegroupementPaie."Designation Qualification" := Qualif;
//                                 RegroupementPaie.Mantant := RecSalaryLines."Net salary cashed";
//                                 RegroupementPaie.MoisPaie := RecSalaryLines.Month;
//                                 RegroupementPaie.AnneePaie := RecSalaryLines.Year;

//                                 RegroupementPaie.Insert;
//                             until RecSalaryLines.Next = 0;
//                         Commit;

//                     end;
//                 end;
//             }
//             action("MAJ Paie")
//             {
//                 ApplicationArea = all;
//                 Caption = 'MAJ Paie';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     MoisEcheance := Date2dmy(Datecaisse, 2);
//                     AnneeEcheance := Date2dmy(Datecaisse, 3);

//                     if not Confirm(Text001) then exit;
//                     if CodeOpérationCaisse.Get('P1') then begin
//                         LibelleOpreration := CodeOpérationCaisse.Description;

//                         if CodeOpérationCaisse.Sens = 'C' then Sens := 3;
//                         if CodeOpérationCaisse.Sens = 'E' then Sens := 2;
//                     end;

//                     if RegroupementPaie.FindFirst then
//                         repeat
//                             RecPaymentLine.Reset();

//                             RecPaymentLine.SetRange(RecPaymentLine."No.", RegroupementPaie."N° Caisse");
//                             if RecPaymentLine.FindFirst() then
//                                 repeat
//                                     NumLigne := RecPaymentLine."Line No.";
//                                 until RecPaymentLine.Next = 0;
//                             RecPaymentLine2.Reset;
//                             RecPaymentLine2.SetRange(RecPaymentLine2."Code Opération", 'P1');
//                             RecPaymentLine2.SetRange(RecPaymentLine2."N° Paie", RegroupementPaie."N° Paie");
//                             RecPaymentLine2.SetRange(RecPaymentLine2.Benificiaire, RegroupementPaie."N° Salarié");
//                             if RecPaymentLine2.FindFirst() then begin
//                                 RecPaymentLine2.SetRange(RecPaymentLine2."Code Opération", 'PR');
//                                 RecPaymentLine2.SetRange(RecPaymentLine2."N° Paie", RegroupementPaie."N° Paie");
//                                 RecPaymentLine2.SetRange(RecPaymentLine2.Benificiaire, RegroupementPaie."N° Salarié");
//                                 if RecPaymentLine2.FindFirst() then begin
//                                     PaymentLine."No." := RegroupementPaie."N° Caisse";
//                                     PaymentLine."Line No." := NumLigne + 10000;
//                                     PaymentLine."Type Origine" := 1;
//                                     PaymentLine.Validate(PaymentLine.Benificiaire, RegroupementPaie."N° Salarié");
//                                     PaymentLine."Nom Benificiaire" := RegroupementPaie."Nom Salarié";
//                                     PaymentLine.Validate(PaymentLine."Credit Amount", RegroupementPaie.Mantant);
//                                     PaymentLine."N° Paie" := RegroupementPaie."N° Paie";
//                                     PaymentLine."Description Paie" := RegroupementPaie."Designation Paie";
//                                     PaymentLine.Affect := RegroupementPaie.Affectation;
//                                     PaymentLine.Qualification := RegroupementPaie.Qualification;
//                                     PaymentLine."Designation Affectation" := RegroupementPaie."Designation Affectation";
//                                     PaymentLine."Designation Qualification" := RegroupementPaie."Designation Qualification";
//                                     PaymentLine."Due Date" := Datecaisse;
//                                     PaymentLine."Code Opération" := 'P1';
//                                     PaymentLine."Type Caisse" := Sens;
//                                     PaymentLine."Mois Echeance" := MoisEcheance;
//                                     PaymentLine."Annee Echeance" := AnneeEcheance;
//                                     PaymentLine.Libellé := CodeOpérationCaisse.Description;
//                                     PaymentLine.MoisPaie := RegroupementPaie.MoisPaie;
//                                     PaymentLine.AnnePaie := RegroupementPaie.AnneePaie;
//                                     PaymentLine."Numero Seq Retour" := RecPaymentLine2."Numero Seq Retour";
//                                     //IF  Sens=3 THEN PaymentLine."Numero Seq":=NoSeriesManagment.GetNextNo('SEQEXT',TODAY,TRUE);
//                                     PaymentLine."Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXTPAIE', Today, true);
//                                     //IF  Sens=2 THEN PaymentLine."Numero Seq":=NoSeriesManagment.GetNextNo('SEQEXTCE',TODAY,TRUE);
//                                     if Receptionneur <> '' then PaymentLine.Validate(PaymentLine.Receptionneur, Receptionneur);
//                                     PaymentLine.Caisse := true;
//                                     PaymentLine.Insert;

//                                 end
//                             end
//                             else begin
//                                 PaymentLine."No." := RegroupementPaie."N° Caisse";
//                                 PaymentLine."Line No." := NumLigne + 10000;
//                                 PaymentLine."Type Origine" := 1;
//                                 PaymentLine.Validate(PaymentLine.Benificiaire, RegroupementPaie."N° Salarié");
//                                 PaymentLine."Nom Benificiaire" := RegroupementPaie."Nom Salarié";
//                                 PaymentLine.Validate(PaymentLine."Credit Amount", RegroupementPaie.Mantant);
//                                 PaymentLine."N° Paie" := RegroupementPaie."N° Paie";
//                                 PaymentLine."Description Paie" := RegroupementPaie."Designation Paie";
//                                 PaymentLine.Affect := RegroupementPaie.Affectation;
//                                 PaymentLine.Qualification := RegroupementPaie.Qualification;
//                                 PaymentLine."Designation Affectation" := RegroupementPaie."Designation Affectation";
//                                 PaymentLine."Designation Qualification" := RegroupementPaie."Designation Qualification";
//                                 PaymentLine."Due Date" := Datecaisse;
//                                 PaymentLine."Code Opération" := 'P1';
//                                 PaymentLine."Type Caisse" := Sens;
//                                 PaymentLine."Mois Echeance" := MoisEcheance;
//                                 PaymentLine."Annee Echeance" := AnneeEcheance;
//                                 PaymentLine.Libellé := CodeOpérationCaisse.Description;
//                                 PaymentLine.MoisPaie := RegroupementPaie.MoisPaie;
//                                 PaymentLine.AnnePaie := RegroupementPaie.AnneePaie;
//                                 PaymentLine."Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXTPAIE', Today, true);
//                                 if Receptionneur <> '' then PaymentLine.Validate(PaymentLine.Receptionneur, Receptionneur);
//                                 // IF  Sens=3 THEN PaymentLine."Numero Seq":=NoSeriesManagment.GetNextNo('SEQEXT',TODAY,TRUE);
//                                 // IF  Sens=2 THEN PaymentLine."Numero Seq":=NoSeriesManagment.GetNextNo('SEQEXTCE',TODAY,TRUE);
//                                 PaymentLine.Caisse := true;
//                                 PaymentLine.Insert;
//                             end;
//                         until RegroupementPaie.Next = 0;
//                     Message(Text002);
//                 end;
//             }
//         }
//     }

//     trigger OnInit()
//     begin
//         //IF RegroupementPaieEntete.GET THEN
//         //BEGIN
//         RegroupementPaieEntete.FindFirst();
//         NumCaisse := RegroupementPaieEntete."N° Caisse";
//         Datecaisse := RegroupementPaieEntete.Date;
//         //END;
//     end;

//     trigger OnOpenPage()
//     begin
//         //IF RegroupementPaieEntete.GET() THEN
//         //BEGIN
//         RegroupementPaieEntete.FindFirst();
//         NumCaisse := RegroupementPaieEntete."N° Caisse";
//         Datecaisse := RegroupementPaieEntete.Date;
//         //END;
//     end;

//     var
//         Text001: label 'Confirmer Cette Action ?';
//         PaymentLine: Record "Payment Line";
//         RegroupementPaie: Record "Regroupement Paie";
//         RecPaymentLine: Record "Payment Line";
//         NumLigne: Integer;
//         CodeAffectation: Code[10];
//         SalaryLines: Record "Salary Lines";
//         RegroupementPaie2: Record "Regroupement Paie";
//         PaymentHeader: Record "Payment Header";
//         CaisseExtra: Page "Caisse Extra";
//         NumCaisse: Code[20];
//         RegroupementPaieEntete: Record "Regroupement Paie Entete";
//         Datecaisse: Date;
//         RecSection: Record Section;
//         RecQualification: Record Qualification;
//         Affect: Text[200];
//         Qualif: Text[200];
//         "CodeOpérationCaisse": Record "Code Opération Caisse";
//         LibelleOpreration: Text[200];
//         Sens: Integer;
//         RecPaymentLine2: Record "Payment Line";
//         Text002: label 'Integration Effectué';
//         NoSeriesManagment: Codeunit NoSeriesManagement;
//         MoisEcheance: Integer;
//         AnneeEcheance: Integer;
//         MoisPaie: Option Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,Rappel,"Solder jour de congé";
//         AnnePaie: Integer;
//         RecSalaryLines: Record "Rec. Salary Lines";
//         MatriculePaie: Code[10];
//         Receptionneur: Code[10];
//         NomReceptionneur: Text[200];
//         RecSalarier: Record Salarier;
//         Text19035414: label 'INTEGRATION PAIE A LA CAISSE';
//         Text19071466: label 'Receptionneur ( Permis à)';

//     local procedure CodeAffectationOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;

//     local procedure NumCaisseOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;

//     local procedure DatecaisseOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;
// }

