page 52048980 "Etat Mensuel De Paie"
{ //GL2024  ID dans Nav 2009 : "39001507"
    SourceTable = "Etat Mensuelle Paie";
    PageType = List;
    ApplicationArea = all;
    UsageCategory = lists;
    Caption = 'Etat Mensuel De Paie';

    layout
    {
        area(content)
        {
            group("ETAT MENSUEL DE PAIE")
            {
                Caption = 'ETAT MENSUEL DE PAIE';
                // Editable = SetEditable;
                /*  field(Affectation; CodeAffectation)
                  {
                      TableRelation = Section;
                      ApplicationArea = Basic;

                      trigger OnValidate()
                      begin
                          Rec.Reset;
                          Rec.CalcFields("Nombre Salarier");
                          NombreSalarié := Rec."Nombre Salarier";
                          if CodeAffectation <> '' then begin
                              Rec.SetRange(Affectation, CodeAffectation);
                              EtatMensuellePaie.SetRange(Affectation, CodeAffectation);
                              EtatMensuellePaie.CalcFields("Nombre Salarier");
                              NombreSalarié := EtatMensuellePaie.Count;
                          end;

                          CurrPage.Update;
                      end;
                  }*/
                /*  field(Mois; MoisAttach)
                  {
                      ApplicationArea = Basic;
                  }
                  field("Année"; AnneeAttach)
                  {
                      ApplicationArea = Basic;
                  }
                  field("Nombre Salarié"; NombreSalarié)
                  {
                      ApplicationArea = Basic;
                      Editable = false;
                  }*/
            }
            repeater("Group0001")
            {

                ShowCaption = false;
                //  Editable = SetEditable;
                field("Matricule"; Rec.Matricule)
                {
                    ApplicationArea = Basic;
                    Caption = 'Matricule';

                    trigger OnValidate()
                    begin
                        IF RecGEmp.GET(rec.Matricule) THEN
                            Rec.Bage := RecGEmp."N° Badge";
                        //GL2024
                        /* IF (rec."Mois Ancienté"<49) AND (rec."Mois Ancienté">45)  THEN
                         BEGIN
                            CurrPAGE.Matricule.UPDATEFORECOLOR(255);
                            CurrPAGE.Matricule.UPDATEFONTBOLD(TRUE);
                            CurrPAGE.UPDATECONTROLS; 
                         END;  */

                        /* IF CodeAffectation = '' THEN ERROR(Text005);
                         IF RecGEmp.GET(rec.Matricule) THEN BEGIN
                             Rec.Affectation := CodeAffectation;
                             RecGEmp.Affectation := CodeAffectation;
                             RecGEmp.MODIFY;
                         END;
                         IF CodeAffectation = '' THEN ERROR(Text005);
                         IF RecGEmp.GET(rec.Matricule) THEN BEGIN
                             rec.Affectation := CodeAffectation;
                             RecGEmp.Affectation := CodeAffectation;
                             IF Section.GET(CodeAffectation) THEN IF Section.Chantier <> '' THEN RecGEmp.Chantier := Section.Chantier;
                             // MH SORO 13-01-2017 Anciente
                             IF FORMAT(RecGEmp."Employment Date") <> '' THEN BEGIN
                                 IntMoisAncienneté := Managementofsalary.CalculerMoisAncienneté(RecGEmp."No.", TODAY);
                                 NbrJour := TODAY - RecGEmp."Employment Date";
                                 IntAnnéeAncienneté := NbrJour DIV 365;
                                 IntMoisAncienneté := (NbrJour - IntAnnéeAncienneté * 365) DIV 30;
                                 IntAncienneteJour := NbrJour - IntAnnéeAncienneté * 365 - IntMoisAncienneté * 30;
                                 IF IntAncienneteJour < 0 THEN IntAncienneteJour := 0;
                                 IF IntAncienneteJour < 0 THEN IntAncienneteJour := 0;
                                 Ancienneté := FORMAT(IntAnnéeAncienneté) + ' An(s), ' + FORMAT(IntMoisAncienneté) + ' Mois';
                                 NbreMoisAnciente := (IntAnnéeAncienneté * 12) + IntMoisAncienneté;
                                 rec."Mois Ancienté" := NbreMoisAnciente;
                                 IF (NbreMoisAnciente < 49) AND (NbreMoisAnciente > 45) THEN NbreSalarié := NbreSalarié + 1;

                             END;
                             // MH SORO 13-01-2017

                             // MH SORO 13-01-2017 Age
                             IF FORMAT(RecGEmp."Birth Date") <> '' THEN BEGIN
                                 IntMoisAncienneté2 := Managementofsalary.CalculerAge(RecGEmp."No.", TODAY);
                                 NbrJour2 := TODAY - RecGEmp."Birth Date";
                                 IntAnnéeAncienneté2 := NbrJour2 DIV 365;
                                 IntMoisAncienneté2 := (NbrJour2 - IntAnnéeAncienneté2 * 365) DIV 30;
                                 IntAncienneteJour2 := NbrJour2 - IntAnnéeAncienneté2 * 365 - IntMoisAncienneté2 * 30;
                                 IF IntAncienneteJour2 < 0 THEN IntAncienneteJour2 := 0;
                                 IF IntAncienneteJour2 < 0 THEN IntAncienneteJour2 := 0;
                                 AgeSalarier := FORMAT(IntAnnéeAncienneté2) + ' An(s), ' + FORMAT(IntMoisAncienneté2) + ' Mois';
                                 rec.Age := AgeSalarier;
                             END;
                             // MH SORO 13-01-2017

                             RecGEmp.MODIFY;
                         END;
                         IF (NbreMoisAnciente < 49) AND (NbreMoisAnciente > 45) THEN MESSAGE(Text007, rec.Nom, rec.Matricule, NbreMoisAnciente);
                         IF (IntAnnéeAncienneté2 = 59) AND (IntMoisAncienneté2 > 8) THEN MESSAGE(Text008, rec.Nom, rec.Matricule, rec.Age);
 */
                    end;
                }
                field("<Nom>"; Rec.Nom)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nom';

                    trigger OnValidate()
                    begin
                        //GL2024
                        /*IF "Droit Congé" < Congé THEN
                        BEGIN
                           CurrForm.Nom.UPDATEFORECOLOR(255);
                           CurrForm.Nom.UPDATEFONTBOLD(TRUE);
                           CurrForm.UPDATECONTROLS;
                        END;  */

                    end;
                }
                // field("<Ne pas appliquer Taux %>"; Rec."Ne pas appliquer Taux %")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Ne pas appliquer Taux %';
                // }
                // field("<Heure Sup BR>"; Rec."Heure Sup BR")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Heure Sup BR';
                // }
                // field("Heure 25"; Rec."Heure 25")
                // {
                //     Caption = 'Heure 20';
                // }
                // field("<Jours Travaillé>"; Rec."Jours Travaillé")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Jours Travaillé';
                // }

                // field("<Heure Travaillé>"; Rec."Heure Travaillé")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Heure Travaillé';
                // }

                field("Nombre de jour"; Rec."Nombre de jour")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("<Présence>"; Rec."Heures Normal")
                {
                    ApplicationArea = Basic;

                    Caption = 'Présence';

                }
                field("Nombre Jour Prime Panier"; Rec."Nombre Jour Prime Panier")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("<Férier>"; Rec.Férier)
                {
                    ApplicationArea = Basic;
                    Caption = 'Férier';
                    Visible = false;
                }
                field(Absence; Rec.Absence)
                {
                    ApplicationArea = Basic;
                }
                // field("<Droit Congé>"; Rec."Droit Congé")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Droit Congé';
                // }
                // field("<Congé Spéciale>"; Rec."Congé Spéciale")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Congé Spéciale';
                // }
                // field("<Nbr Jours Deplacement>"; Rec."Nbr Jours Deplacement")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Nbr Jours Deplacement';
                // }
                field("<Congé>"; Rec.Congé)
                {
                    ApplicationArea = Basic;
                    Caption = 'Congé';

                    trigger OnValidate()
                    begin
                        //   if Rec.Congé + Rec.Présence + Rec."Congé Spéciale" > 26 then Error(Text004);
                    end;
                }
                // field("<Mois Ancienté>"; Rec."Mois Ancienté")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Mois Ancienté';

                //     trigger OnValidate()
                //     begin
                //         //GL2024
                //         /*IF ("Mois Ancienté"<49) AND ("Mois Ancienté">45)  THEN
                //         BEGIN
                //            CurrForm."Mois Ancienté".UPDATEFORECOLOR(255);
                //            CurrForm."Mois Ancienté".UPDATEFONTBOLD(TRUE);
                //            CurrForm.UPDATECONTROLS;
                //         END; */

                //     end;
                // // }
                // field("<Age>"; Rec.Age)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Age';
                // }
                // field("<Affectation>"; Rec.Affectation)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Affectation';
                // }
                // field("<Kmetrage>"; Rec.Kmetrage)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Kmetrage';
                // }
                field("Heure 15"; Rec."Heure 15")
                {
                    ApplicationArea = Basic;

                }
                field("Heure 35"; Rec."Heure 35")
                {
                    ApplicationArea = Basic;

                }
                field("Heure 50"; Rec."Heure 50")
                {
                    ApplicationArea = Basic;

                }
                field("Heure 60"; Rec."Heure 60")
                {
                    ApplicationArea = Basic;

                }
                field("Heure 120"; Rec."Heure 120")
                {
                    ApplicationArea = Basic;

                }
                field(Disponible; Rec.Disponible)
                {
                    ApplicationArea = Basic;

                }


                // field("<Heure Travaillé réel>"; Rec."Heure Travaillé réel")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Heure Travaillé réel';
                // }
                // field("<Heures Retenues>"; Rec."Heures Retenues")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Heures Retenues';
                // }
                // field("<Jours Sup Normal>"; Rec."Jours Sup Normal")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Jours Sup Normal';
                // }
                // field("<Jours Sup Calculé Majoré à 75%>"; Rec."Jours Sup Calculé Majoré à 75%")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Jours Sup Calculé Majoré à 75%';
                // }
                // field("<Heure Normal>"; Rec."Heure Normal")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Heure Normal';
                // }
                // field("<Heure Sup Majoré à 75 %>"; Rec."Heure Sup Majoré à 75 %")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Heure Sup Majoré à 75 %';
                // }
                // field("<Heure Sup Majoré à 100 %>"; Rec."Heure Sup Majoré à 100 %")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Heure Sup Majoré à 100 %';
                // }
                // 
                field("<Total nb heures>"; Rec."Total nb heures")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total nb heures';
                    Visible = false;
                }
                field("<Nombre de jour>"; Rec."Nombre de jour")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nombre de jour';
                    Visible = false;
                }
                field("Heures/Jours  Normal"; Rec."Heures Normal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Heures/Jours  Normal';
                    Visible = false;
                }
                // field("<Rappel Salarié>"; Rec."Rappel Salarié")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Rappel Salarié';
                // }
                // field("<Rappel>"; Rec.Rappel)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Rappel';
                // }
                // field("<Retenu>"; Rec.Retenu)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Retenu';
                // }
                // field("<Cession>"; Rec.Cession)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Cession';
                // }
                // field("<Description Qualification>"; Rec."Description Qualification")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Description Qualification';
                // }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Récupérer Employée1")
            {
                ApplicationArea = Basic;
                PromotedCategory = Process;
                Image = Employee;

                Caption = 'Récupérer Employée';
                Promoted = true;
                trigger OnAction()
                begin
                    // TempEchelon.Reset;
                    // TempEchelon.DeleteAll;


                    if not Confirm(Text001) then exit;
                    if not Confirm(Text003) then exit;
                    RecGEmp.SetRange(RecGEmp.Blocked, false);
                    if RecGEmp.FindFirst then
                        repeat
                            Saut := false;
                            EtatMensuellePaie.Matricule := RecGEmp."No.";
                            EtatMensuellePaie.Nom := RecGEmp."last Name";
                            EtatMensuellePaie."Nombre de jour" := 30;
                            EtatMensuellePaie."Heures Normal" := 30;
                            EtatMensuellePaie."Type Salarié" := 1;

                            /*  EtatMensuellePaie.Qualification := RecGEmp.Qualification;
                              EtatMensuellePaie.Affectation := RecGEmp.Affectation;
                              FinDeMois := CalcDate('+FM', WorkDate);

                              //*****************MH SORO 13/10/2016    Ancienté *****************

                              if Format(RecGEmp."Employment Date") <> '' then begin
                                  IntMoisAncienneté := Managementofsalary.CalculerMoisAncienneté(RecGEmp."No.", Today);
                                  NbrJour := Today - RecGEmp."Employment Date";
                                  IntAnnéeAncienneté := NbrJour DIV 365;
                                  IntMoisAncienneté := (NbrJour - IntAnnéeAncienneté * 365) DIV 30;
                                  IntAncienneteJour := NbrJour - IntAnnéeAncienneté * 365 - IntMoisAncienneté * 30;
                                  if IntAncienneteJour < 0 then IntAncienneteJour := 0;
                                  if IntAncienneteJour < 0 then IntAncienneteJour := 0;
                                  Ancienneté := Format(IntAnnéeAncienneté) + ' An(s), ' + Format(IntMoisAncienneté) + ' Mois';
                                  NbreMoisAnciente := (IntAnnéeAncienneté * 12) + IntMoisAncienneté;
                                  EtatMensuellePaie."Mois Ancienté" := NbreMoisAnciente;
                                  if (NbreMoisAnciente < 49) and (NbreMoisAnciente > 45) then NbreSalarié := NbreSalarié + 1;

                              end;
                              //*****************MH SORO 13/10/2016*****************

                              // MH SORO 13-01-2017 Age
                              if Format(RecGEmp."Birth Date") <> '' then begin
                                  IntMoisAncienneté2 := Managementofsalary.CalculerAge(RecGEmp."No.", Today);
                                  NbrJour2 := Today - RecGEmp."Birth Date";
                                  IntAnnéeAncienneté2 := NbrJour2 DIV 365;
                                  IntMoisAncienneté2 := (NbrJour2 - IntAnnéeAncienneté2 * 365) DIV 30;
                                  IntAncienneteJour2 := NbrJour2 - IntAnnéeAncienneté2 * 365 - IntMoisAncienneté2 * 30;
                                  if IntAncienneteJour2 < 0 then IntAncienneteJour2 := 0;
                                  if IntAncienneteJour2 < 0 then IntAncienneteJour2 := 0;
                                  AgeSalarier := Format(IntAnnéeAncienneté2) + ' An(s), ' + Format(IntMoisAncienneté2) + ' Mois';
                                  Rec.Age := AgeSalarier;
                              end;
                              // MH SORO 13-01-2017


                              NewStr := CopyStr(RecGEmp.Collège, 4, 1);
                              NewStr2 := CopyStr(RecGEmp.Collège, 5, 2);
                              NewStr3 := CopyStr(RecGEmp.Collège, 1, 4);
                              if NewStr = 'E' then begin
                                  //************** Année Entre 0-2 *************
                                  if IntAnnéeAncienneté < 2 then begin
                                      if NewStr2 <> '01' then begin
                                          TempEchelon.Matricule := RecGEmp."No.";
                                          TempEchelon."Nom et Prénom" := RecGEmp."First Name";
                                          TempEchelon."Ancien Echelon" := RecGEmp.Collège;
                                          TempEchelon."Date Embauche" := RecGEmp."Employment Date";
                                          TempEchelon.Ancienté := IntAnnéeAncienneté;
                                          TempEchelon."Nouveau Echelon" := NewStr3 + '01';
                                          if not TempEchelon.Insert then TempEchelon.Modify;
                                      end;
                                  end;
                                  //************** Année Entre 2-4 *************
                                  if (IntAnnéeAncienneté >= 2) and (IntAnnéeAncienneté < 4) then begin
                                      if NewStr2 <> '02' then begin
                                          TempEchelon.Matricule := RecGEmp."No.";
                                          TempEchelon."Nom et Prénom" := RecGEmp."First Name";
                                          TempEchelon."Ancien Echelon" := RecGEmp.Collège;
                                          TempEchelon."Date Embauche" := RecGEmp."Employment Date";
                                          TempEchelon.Ancienté := IntAnnéeAncienneté;
                                          TempEchelon."Nouveau Echelon" := NewStr3 + '02';
                                          if not TempEchelon.Insert then TempEchelon.Modify;
                                      end;
                                  end;
                                  //************** Année Entre 4-6 *************
                                  if (IntAnnéeAncienneté >= 4) and (IntAnnéeAncienneté < 6) then begin
                                      if NewStr2 <> '03' then begin
                                          TempEchelon.Matricule := RecGEmp."No.";
                                          TempEchelon."Nom et Prénom" := RecGEmp."First Name";
                                          TempEchelon."Ancien Echelon" := RecGEmp.Collège;
                                          TempEchelon."Date Embauche" := RecGEmp."Employment Date";
                                          TempEchelon.Ancienté := IntAnnéeAncienneté;
                                          TempEchelon."Nouveau Echelon" := NewStr3 + '03';
                                          if not TempEchelon.Insert then TempEchelon.Modify;
                                      end;
                                  end;
                                  //************** Année Entre 6-8 *************
                                  if (IntAnnéeAncienneté >= 6) and (IntAnnéeAncienneté < 8) then begin
                                      if NewStr2 <> '04' then begin
                                          TempEchelon.Matricule := RecGEmp."No.";
                                          TempEchelon."Nom et Prénom" := RecGEmp."First Name";
                                          TempEchelon."Ancien Echelon" := RecGEmp.Collège;
                                          TempEchelon."Date Embauche" := RecGEmp."Employment Date";
                                          TempEchelon.Ancienté := IntAnnéeAncienneté;
                                          TempEchelon."Nouveau Echelon" := NewStr3 + '04';
                                          if not TempEchelon.Insert then TempEchelon.Modify;
                                      end;
                                  end;
                                  //************** Année Entre 8-10 *************
                                  if (IntAnnéeAncienneté >= 8) and (IntAnnéeAncienneté < 10) then begin
                                      if NewStr2 <> '05' then begin
                                          TempEchelon.Matricule := RecGEmp."No.";
                                          TempEchelon."Nom et Prénom" := RecGEmp."First Name";
                                          TempEchelon."Ancien Echelon" := RecGEmp.Collège;
                                          TempEchelon."Date Embauche" := RecGEmp."Employment Date";
                                          TempEchelon.Ancienté := IntAnnéeAncienneté;
                                          TempEchelon."Nouveau Echelon" := NewStr3 + '05';
                                          if not TempEchelon.Insert then TempEchelon.Modify;
                                      end;
                                  end;
                                  //************** Année Entre 10-12 *************
                                  if (IntAnnéeAncienneté >= 10) and (IntAnnéeAncienneté < 12) then begin
                                      if NewStr2 <> '06' then begin
                                          TempEchelon.Matricule := RecGEmp."No.";
                                          TempEchelon."Nom et Prénom" := RecGEmp."First Name";
                                          TempEchelon."Ancien Echelon" := RecGEmp.Collège;
                                          TempEchelon."Date Embauche" := RecGEmp."Employment Date";
                                          TempEchelon.Ancienté := IntAnnéeAncienneté;
                                          TempEchelon."Nouveau Echelon" := NewStr3 + '06';
                                          if not TempEchelon.Insert then TempEchelon.Modify;
                                      end;
                                  end;
                                  //************** Année Entre 12-15 *************
                                  if (IntAnnéeAncienneté >= 12) and (IntAnnéeAncienneté < 15) then begin
                                      if NewStr2 <> '07' then begin
                                          TempEchelon.Matricule := RecGEmp."No.";
                                          TempEchelon."Nom et Prénom" := RecGEmp."First Name";
                                          TempEchelon."Ancien Echelon" := RecGEmp.Collège;
                                          TempEchelon."Date Embauche" := RecGEmp."Employment Date";
                                          TempEchelon.Ancienté := IntAnnéeAncienneté;
                                          TempEchelon."Nouveau Echelon" := NewStr3 + '07';
                                          if not TempEchelon.Insert then TempEchelon.Modify;
                                      end;
                                  end;
                                  //************** Année Entre 15-18 *************
                                  if (IntAnnéeAncienneté >= 15) and (IntAnnéeAncienneté < 18) then begin
                                      if NewStr2 <> '08' then begin
                                          TempEchelon.Matricule := RecGEmp."No.";
                                          TempEchelon."Nom et Prénom" := RecGEmp."First Name";
                                          TempEchelon."Ancien Echelon" := RecGEmp.Collège;
                                          TempEchelon."Date Embauche" := RecGEmp."Employment Date";
                                          TempEchelon.Ancienté := IntAnnéeAncienneté;
                                          TempEchelon."Nouveau Echelon" := NewStr3 + '08';
                                          if not TempEchelon.Insert then TempEchelon.Modify;
                                      end;
                                  end;
                                  //************** Année Entre 18-21 *************
                                  if (IntAnnéeAncienneté >= 18) and (IntAnnéeAncienneté < 21) then begin
                                      if NewStr2 <> '09' then begin
                                          TempEchelon.Matricule := RecGEmp."No.";
                                          TempEchelon."Nom et Prénom" := RecGEmp."First Name";
                                          TempEchelon."Ancien Echelon" := RecGEmp.Collège;
                                          TempEchelon."Date Embauche" := RecGEmp."Employment Date";
                                          TempEchelon.Ancienté := IntAnnéeAncienneté;
                                          TempEchelon."Nouveau Echelon" := NewStr3 + '09';
                                          if not TempEchelon.Insert then TempEchelon.Modify;
                                      end;
                                  end;
                                  //************** Année Entre 21-24 *************
                                  if (IntAnnéeAncienneté >= 21) and (IntAnnéeAncienneté < 24) then begin
                                      if NewStr2 <> '10' then begin
                                          TempEchelon.Matricule := RecGEmp."No.";
                                          TempEchelon."Nom et Prénom" := RecGEmp."First Name";
                                          TempEchelon."Ancien Echelon" := RecGEmp.Collège;
                                          TempEchelon."Date Embauche" := RecGEmp."Employment Date";
                                          TempEchelon.Ancienté := IntAnnéeAncienneté;
                                          TempEchelon."Nouveau Echelon" := NewStr3 + '10';
                                          if not TempEchelon.Insert then TempEchelon.Modify;
                                      end;
                                  end;
                                  //************** Année Sup à 24 *************
                                  if IntAnnéeAncienneté >= 24 then begin
                                      if NewStr2 <> '11' then begin
                                          TempEchelon.Matricule := RecGEmp."No.";
                                          TempEchelon."Nom et Prénom" := RecGEmp."First Name";
                                          TempEchelon."Ancien Echelon" := RecGEmp.Collège;
                                          TempEchelon."Date Embauche" := RecGEmp."Employment Date";
                                          TempEchelon.Ancienté := IntAnnéeAncienneté;
                                          TempEchelon."Nouveau Echelon" := NewStr3 + '11';
                                          if not TempEchelon.Insert then TempEchelon.Modify;
                                      end;
                                  end;


                              end;

                              //*****************MH SORO 13/10/2016*****************

                              if (RecGEmp."Birth Date" <> 0D) then
                                  if (((FinDeMois - RecGEmp."Birth Date") / 365) > 60) then
                                      Saut := true;
                              if not Saut then*/
                            if not EtatMensuellePaie.Insert then EtatMensuellePaie.Modify;
                        until RecGEmp.Next = 0;
                    Message(Text002);
                    //*****************MH SORO 13/10/2016*****************
                    //   if NbreSalarié > 0 then Message(Text006);

                    // FormEchelon.Run;
                end;
            }
            action("Récupérer Employée 2")
            {
                Enabled = UpdateEmplyeeVISIBLE;
                ApplicationArea = Basic;
                Caption = 'Récupérer Employée 2';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin


                    if not Confirm(Text001) then exit;
                    if not Confirm(Text003) then exit;
                    RecGEmp.SetRange(RecGEmp.Blocked, false);
                    if RecGEmp.FindFirst then
                        repeat
                            Saut := false;
                            EtatMensuellePaie.Matricule := RecGEmp."No.";
                            EtatMensuellePaie.Nom := RecGEmp."First Name";
                            EtatMensuellePaie."Nombre de jour" := 30;
                            EtatMensuellePaie."Heures Normal" := 30;
                            EtatMensuellePaie."Type Salarié" := 1;
                            // EtatMensuellePaie.Qualification := RecGEmp.Qualification;
                            // EtatMensuellePaie.Affectation := RecGEmp.Affectation;
                            FinDeMois := CalcDate('+FM', WorkDate);

                            //*****************MH SORO 13/10/2016    Ancienté *****************

                            /* if Format(RecGEmp."Employment Date") <> '' then begin
                                 IntMoisAncienneté := Managementofsalary.CalculerMoisAncienneté(RecGEmp."No.", Today);
                                 NbrJour := Today - RecGEmp."Employment Date";
                                 IntAnnéeAncienneté := NbrJour DIV 365;
                                 IntMoisAncienneté := (NbrJour - IntAnnéeAncienneté * 365) DIV 30;
                                 IntAncienneteJour := NbrJour - IntAnnéeAncienneté * 365 - IntMoisAncienneté * 30;
                                 if IntAncienneteJour < 0 then IntAncienneteJour := 0;
                                 if IntAncienneteJour < 0 then IntAncienneteJour := 0;
                                 Ancienneté := Format(IntAnnéeAncienneté) + ' An(s), ' + Format(IntMoisAncienneté) + ' Mois';
                                 NbreMoisAnciente := (IntAnnéeAncienneté * 12) + IntMoisAncienneté;
                                 EtatMensuellePaie."Mois Ancienté" := NbreMoisAnciente;
                                 if (NbreMoisAnciente < 49) and (NbreMoisAnciente > 45) then NbreSalarié := NbreSalarié + 1;

                             end;*/
                            //*****************MH SORO 13/10/2016*****************

                            // MH SORO 13-01-2017 Age
                            /* if Format(RecGEmp."Birth Date") <> '' then begin
                                 IntMoisAncienneté2 := Managementofsalary.CalculerAge(RecGEmp."No.", Today);
                                 NbrJour2 := Today - RecGEmp."Birth Date";
                                 IntAnnéeAncienneté2 := NbrJour2 DIV 365;
                                 IntMoisAncienneté2 := (NbrJour2 - IntAnnéeAncienneté2 * 365) DIV 30;
                                 IntAncienneteJour2 := NbrJour2 - IntAnnéeAncienneté2 * 365 - IntMoisAncienneté2 * 30;
                                 if IntAncienneteJour2 < 0 then IntAncienneteJour2 := 0;
                                 if IntAncienneteJour2 < 0 then IntAncienneteJour2 := 0;
                                 AgeSalarier := Format(IntAnnéeAncienneté2) + ' An(s), ' + Format(IntMoisAncienneté2) + ' Mois';
                                 Rec.Age := AgeSalarier;
                             end;*/
                            // MH SORO 13-01-2017
                            /*

                                NewStr :=COPYSTR(RecGEmp.Collège, 4, 1);
                                NewStr2:=COPYSTR(RecGEmp.Collège, 5, 2);
                                NewStr3:=COPYSTR(RecGEmp.Collège, 1, 4);
                                IF NewStr='E' THEN
                                BEGIN
                                     //************** Année Entre 0-2 *************
                                    IF IntAnnéeAncienneté<2 THEN
                                    BEGIN
                                        IF NewStr2<>'01' THEN
                                        BEGIN
                                        TempEchelon.Matricule:=RecGEmp."No.";
                                        TempEchelon."Nom et Prénom":=RecGEmp."First Name";
                                        TempEchelon."Ancien Echelon":=RecGEmp.Collège;
                                        TempEchelon."Date Embauche":=RecGEmp."Employment Date";
                                        TempEchelon.Ancienté:=IntAnnéeAncienneté;
                                        TempEchelon."Nouveau Echelon":=NewStr3+'01';
                                        IF NOT TempEchelon.INSERT THEN TempEchelon.MODIFY;
                                        END;
                                    END;
                                     //************** Année Entre 2-4 *************
                                    IF (IntAnnéeAncienneté>=2) AND (IntAnnéeAncienneté<4)   THEN
                                    BEGIN
                                        IF NewStr2<>'02' THEN
                                        BEGIN
                                        TempEchelon.Matricule:=RecGEmp."No.";
                                        TempEchelon."Nom et Prénom":=RecGEmp."First Name";
                                        TempEchelon."Ancien Echelon":=RecGEmp.Collège;
                                        TempEchelon."Date Embauche":=RecGEmp."Employment Date";
                                        TempEchelon.Ancienté:=IntAnnéeAncienneté;
                                        TempEchelon."Nouveau Echelon":=NewStr3+'02';
                                        IF NOT TempEchelon.INSERT THEN TempEchelon.MODIFY;
                                        END;
                                    END;
                                     //************** Année Entre 4-6 *************
                                    IF (IntAnnéeAncienneté>=4) AND (IntAnnéeAncienneté<6)   THEN
                                    BEGIN
                                        IF NewStr2<>'03' THEN
                                        BEGIN
                                        TempEchelon.Matricule:=RecGEmp."No.";
                                        TempEchelon."Nom et Prénom":=RecGEmp."First Name";
                                        TempEchelon."Ancien Echelon":=RecGEmp.Collège;
                                        TempEchelon."Date Embauche":=RecGEmp."Employment Date";
                                        TempEchelon.Ancienté:=IntAnnéeAncienneté;
                                        TempEchelon."Nouveau Echelon":=NewStr3+'03';
                                        IF NOT TempEchelon.INSERT THEN TempEchelon.MODIFY;
                                        END;
                                    END;
                                     //************** Année Entre 6-8 *************
                                    IF (IntAnnéeAncienneté>=6) AND (IntAnnéeAncienneté<8)   THEN
                                    BEGIN
                                        IF NewStr2<>'04' THEN
                                        BEGIN
                                        TempEchelon.Matricule:=RecGEmp."No.";
                                        TempEchelon."Nom et Prénom":=RecGEmp."First Name";
                                        TempEchelon."Ancien Echelon":=RecGEmp.Collège;
                                        TempEchelon."Date Embauche":=RecGEmp."Employment Date";
                                        TempEchelon.Ancienté:=IntAnnéeAncienneté;
                                        TempEchelon."Nouveau Echelon":=NewStr3+'04';
                                        IF NOT TempEchelon.INSERT THEN TempEchelon.MODIFY;
                                        END;
                                    END;
                                     //************** Année Entre 8-10 *************
                                    IF (IntAnnéeAncienneté>=8) AND (IntAnnéeAncienneté<10)   THEN
                                    BEGIN
                                        IF NewStr2<>'05' THEN
                                        BEGIN
                                        TempEchelon.Matricule:=RecGEmp."No.";
                                        TempEchelon."Nom et Prénom":=RecGEmp."First Name";
                                        TempEchelon."Ancien Echelon":=RecGEmp.Collège;
                                        TempEchelon."Date Embauche":=RecGEmp."Employment Date";
                                        TempEchelon.Ancienté:=IntAnnéeAncienneté;
                                        TempEchelon."Nouveau Echelon":=NewStr3+'05';
                                        IF NOT TempEchelon.INSERT THEN TempEchelon.MODIFY;
                                        END;
                                    END;
                                     //************** Année Entre 10-12 *************
                                    IF (IntAnnéeAncienneté>=10) AND (IntAnnéeAncienneté<12)   THEN
                                    BEGIN
                                        IF NewStr2<>'06' THEN
                                        BEGIN
                                        TempEchelon.Matricule:=RecGEmp."No.";
                                        TempEchelon."Nom et Prénom":=RecGEmp."First Name";
                                        TempEchelon."Ancien Echelon":=RecGEmp.Collège;
                                        TempEchelon."Date Embauche":=RecGEmp."Employment Date";
                                        TempEchelon.Ancienté:=IntAnnéeAncienneté;
                                        TempEchelon."Nouveau Echelon":=NewStr3+'06';
                                        IF NOT TempEchelon.INSERT THEN TempEchelon.MODIFY;
                                        END;
                                    END;
                                     //************** Année Entre 12-15 *************
                                    IF (IntAnnéeAncienneté>=12) AND (IntAnnéeAncienneté<15)   THEN
                                    BEGIN
                                        IF NewStr2<>'07' THEN
                                        BEGIN
                                        TempEchelon.Matricule:=RecGEmp."No.";
                                        TempEchelon."Nom et Prénom":=RecGEmp."First Name";
                                        TempEchelon."Ancien Echelon":=RecGEmp.Collège;
                                        TempEchelon."Date Embauche":=RecGEmp."Employment Date";
                                        TempEchelon.Ancienté:=IntAnnéeAncienneté;
                                        TempEchelon."Nouveau Echelon":=NewStr3+'07';
                                        IF NOT TempEchelon.INSERT THEN TempEchelon.MODIFY;
                                        END;
                                    END;
                                     //************** Année Entre 15-18 *************
                                    IF (IntAnnéeAncienneté>=15) AND (IntAnnéeAncienneté<18)   THEN
                                    BEGIN
                                        IF NewStr2<>'08' THEN
                                        BEGIN
                                        TempEchelon.Matricule:=RecGEmp."No.";
                                        TempEchelon."Nom et Prénom":=RecGEmp."First Name";
                                        TempEchelon."Ancien Echelon":=RecGEmp.Collège;
                                        TempEchelon."Date Embauche":=RecGEmp."Employment Date";
                                        TempEchelon.Ancienté:=IntAnnéeAncienneté;
                                        TempEchelon."Nouveau Echelon":=NewStr3+'08';
                                        IF NOT TempEchelon.INSERT THEN TempEchelon.MODIFY;
                                        END;
                                    END;
                                     //************** Année Entre 18-21 *************
                                    IF (IntAnnéeAncienneté>=18) AND (IntAnnéeAncienneté<21)   THEN
                                    BEGIN
                                        IF NewStr2<>'09' THEN
                                        BEGIN
                                        TempEchelon.Matricule:=RecGEmp."No.";
                                        TempEchelon."Nom et Prénom":=RecGEmp."First Name";
                                        TempEchelon."Ancien Echelon":=RecGEmp.Collège;
                                        TempEchelon."Date Embauche":=RecGEmp."Employment Date";
                                        TempEchelon.Ancienté:=IntAnnéeAncienneté;
                                        TempEchelon."Nouveau Echelon":=NewStr3+'09';
                                        IF NOT TempEchelon.INSERT THEN TempEchelon.MODIFY;
                                        END;
                                    END;
                                     //************** Année Entre 21-24 *************
                                    IF (IntAnnéeAncienneté>=21) AND (IntAnnéeAncienneté<24)   THEN
                                    BEGIN
                                        IF NewStr2<>'10' THEN
                                        BEGIN
                                        TempEchelon.Matricule:=RecGEmp."No.";
                                        TempEchelon."Nom et Prénom":=RecGEmp."First Name";
                                        TempEchelon."Ancien Echelon":=RecGEmp.Collège;
                                        TempEchelon."Date Embauche":=RecGEmp."Employment Date";
                                        TempEchelon.Ancienté:=IntAnnéeAncienneté;
                                        TempEchelon."Nouveau Echelon":=NewStr3+'10';
                                        IF NOT TempEchelon.INSERT THEN TempEchelon.MODIFY;
                                        END;
                                    END;
                                     //************** Année Sup à 24 *************
                                    IF IntAnnéeAncienneté>=24   THEN
                                    BEGIN
                                        IF NewStr2<>'11' THEN
                                        BEGIN
                                        TempEchelon.Matricule:=RecGEmp."No.";
                                        TempEchelon."Nom et Prénom":=RecGEmp."First Name";
                                        TempEchelon."Ancien Echelon":=RecGEmp.Collège;
                                        TempEchelon."Date Embauche":=RecGEmp."Employment Date";
                                        TempEchelon.Ancienté:=IntAnnéeAncienneté;
                                        TempEchelon."Nouveau Echelon":=NewStr3+'11';
                                        IF NOT TempEchelon.INSERT THEN TempEchelon.MODIFY;
                                        END;
                                    END;


                                END;
                            */
                            //*****************MH SORO 13/10/2016*****************

                            // if (RecGEmp."Birth Date" <> 0D) then
                            //     if (((FinDeMois - RecGEmp."Birth Date") / 365) > 60) then
                            //         Saut := true;
                            // if not Saut then
                            if not EtatMensuellePaie.Insert then EtatMensuellePaie.Modify;
                        until RecGEmp.Next = 0;
                    Message(Text002);
                    //*****************MH SORO 13/10/2016*****************
                    //   if NbreSalarié > 0 then Message(Text006);

                    // FormEchelon.Run;

                end;
            }
            action("Integrer Pointage")
            {
                ApplicationArea = Basic;
                Caption = 'Integrer Pointage';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()
                var
                    SauterLigne: Boolean;
                begin

                    /*if CodeAffectation = '' then Error(Text009);
                    if MoisAttach = 0 then Error(Text009);
                    Clear(LignePointageSalariéChanti);

                    LignePointageSalariéChanti.Reset;
                    LignePointageSalariéChanti.SetRange(LignePointageSalariéChanti."Mois Attachement", MoisAttach);
                    LignePointageSalariéChanti.SetRange(LignePointageSalariéChanti."Annee Attachement", AnneeAttach);
                    LignePointageSalariéChanti.SetRange(LignePointageSalariéChanti.Affectation, CodeAffectation);
                    //LignePointageSalariéChanti.SETRANGE(Matricule,'06730');
                    if LignePointageSalariéChanti.FindFirst then
                        repeat
                            if (LignePointageSalariéChanti."Total Heures" <> 0) or (LignePointageSalariéChanti."Total Presence" <> 0) then begin
                                EtatMensuellePaie2.Reset;
                                if Recemployee.Get(LignePointageSalariéChanti.Matricule) then
                                    if not Recemployee.Blocked then begin
                                        EtatMensuellePaie2.Validate(Matricule, LignePointageSalariéChanti.Matricule);
                                        EtatMensuellePaie2.Validate(EtatMensuellePaie2."Jours Travaillé", LignePointageSalariéChanti."Total Presence");
                                        if LignePointageSalariéChanti."Total Heures" <> 0 then
                                            EtatMensuellePaie2.Validate(EtatMensuellePaie2."Heure Travaillé",
                                                                                          LignePointageSalariéChanti."Total Heures");
                                        EtatMensuellePaie2.Férier := LignePointageSalariéChanti.Férier;
                                        EtatMensuellePaie2."Congé Spéciale" := LignePointageSalariéChanti."Conger Speciale";
                                        EtatMensuellePaie2."Nbr Jours Deplacement" := LignePointageSalariéChanti.Deplacement;
                                        Recemployee.CalcFields("Days off =");
                                        EtatMensuellePaie2.Congé := 0;
                                        if Recemployee."Days off =" > 0 then begin
                                            if (ROUND(Recemployee."Days off =", 1) > LignePointageSalariéChanti.Congé) then
                                                EtatMensuellePaie2.Congé := LignePointageSalariéChanti.Congé
                                            else
                                                EtatMensuellePaie2.Congé := ROUND(Recemployee."Days off =" + 1, 1);
                                        end;
                                        SauterLigne := false;
                                        SauterLigne := ValidationLignePointage(LignePointageSalariéChanti.Matricule);
                                        if not SauterLigne then
                                            if not EtatMensuellePaie2.Insert then EtatMensuellePaie2.Modify;
                                    end;
                            end;
                        until LignePointageSalariéChanti.Next = 0;

                    CurrPage.Update;
                    Message(Text010);*/
                end;
            }

            action("Valider HS")
            {
                PromotedCategory = Process;
                Promoted = true;
                ApplicationArea = Basic;
                Visible = false;
                Caption = 'Valider HS';

                trigger OnAction()
                begin
                    //     Report.Run(Report::"Heure Sup BR", true, true)
                end;
            }
            action("Déverouiller")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic;
                Visible = false;
                Caption = 'Déverouiller';

                trigger OnAction()
                begin
                    SetEditable := true;
                    //GL2024        CurrPage.Editable := true
                end;
            }
            action(Verouiller)
            {
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                Caption = 'Verouiller';
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    SetEditable := false;
                    //GL2024     CurrPage.Editable := false
                end;
            }
            action(Imprimer)
            {
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Imprimer';
                ApplicationArea = Basic;
                Image = print;

                trigger OnAction()
                begin
                    Report.RunModal(Report::"Etat de pointage", true, true, Rec)
                end;
            }
            action("Remise a zéro pointage")
            {
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Remise a zéro pointage';
                ApplicationArea = Basic;


                trigger OnAction()
                begin
                    EtatMensuellePaie.RESET;
                    IF EtatMensuellePaie.FIND('-') THEN
                        REPEAT
                            EtatMensuellePaie.Panier := 0;
                            EtatMensuellePaie."Hr nuit" := 0;
                            EtatMensuellePaie."Heure 15" := 0;
                            EtatMensuellePaie."Heure 35" := 0;
                            EtatMensuellePaie.Congé := 0;
                            EtatMensuellePaie.Férier := 0;
                            EtatMensuellePaie."Jour repos" := 0;
                            EtatMensuellePaie."Heure 50" := 0;
                            EtatMensuellePaie.Heure := 0;
                            EtatMensuellePaie.Absence := 0;
                            EtatMensuellePaie."Heure ferier" := 0;
                            EtatMensuellePaie."Heure 120" := 0;
                            EtatMensuellePaie."Heures Normal" := 30;
                            EtatMensuellePaie."Rembourcement frais" := 0;
                            EtatMensuellePaie."Heures compensation" := 0;
                            EtatMensuellePaie."Nombre de jour indemnité exep" := 0;
                            EtatMensuellePaie.Salisure := 0;
                            EtatMensuellePaie."Nombre de jour" := 30;
                            EtatMensuellePaie.Productivité := 0;
                            EtatMensuellePaie.Douche := 0;
                            EtatMensuellePaie.MODIFY;

                        UNTIL EtatMensuellePaie.NEXT = 0;
                end;
            }
            action(Importation)
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic;
                Caption = 'Importation';
                Image = Import;
                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                begin


                    Xmlport.Run(Xmlport::"Etat Mensuel Paie2");

                    CurrPage.Update();


                end;
            }
            action(Valider)
            {
                PromotedCategory = Process;
                Promoted = true;
                ApplicationArea = Basic;
                Caption = 'Valider';
                Image = post;

                trigger OnAction()
                begin
                    //IF CodeAffectation<>'' THEN EtatMensuellePaie.SETRANGE(Affectation,CodeAffectation);
                    //  EtatMensuellePaie.SetFilter(Présence, '<>%1', 0);
                    //  Report.Run(Report::"Defalcatiuon Paie", true, true, EtatMensuellePaie)
                    REPORT.RUN(Report::"Defalcatiuon Paie")
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        /* Rec.CalcFields("Nombre Salarier");
           NombreSalarié := Rec."Nombre Salarier";
           Rec.Reset;
           AnneeAttach := Date2dmy(WorkDate, 3); 

           IF UserSetup.GET(UPPERCASE(USERID)) THEN;
           IF UserSetup."Mise a Jour Etat Mensuel paie" THEN
               UpdateEmplyeeVISIBLE := TRUE
           ELSE
               UpdateEmplyeeVISIBLE := FALSE;*/

        // SetEditable := true;

    end;

    var
        UpdateEmplyeeVISIBLE: Boolean;
        EtatMensuellePaie: Record "Etat Mensuelle Paie";
        RecGEmp: Record Employee;
        i: Integer;
        d: Dialog;
        //GL3900   MgmtSuppHour: Codeunit "Management of Work Hours";
        ToTNbrjours: Decimal;
        ToTNbrHeures: Decimal;
        CodeQualification: Code[20];
        CodeAffectation: Code[20];
        "NombreSalarié": Integer;
        FinDeMois: Date;
        Saut: Boolean;
        NewStr: Text[30];
        // TempEchelon: Record "Echelon Temporaire";
        Managementofsalary: Codeunit "Management of salary";
        "IntMoisAncienneté": Integer;
        "IntAnnéeAncienneté": Integer;
        "Ancienneté": Text[50];
        IntAncienneteJour: Integer;
        DateRefAnciennete: Date;
        NbreMoisAnciente: Decimal;
        NbrJour: Integer;
        "NbreSalarié": Integer;
        NewStr2: Text[30];
        NewStr3: Text[30];

        // FormEchelon: Page "Echelon Modif 2";
        AgeSalarier: Text[30];
        "IntMoisAncienneté2": Integer;
        "IntAnnéeAncienneté2": Integer;
        "Ancienneté2": Text[50];
        IntAncienneteJour2: Integer;
        NbrJour2: Integer;
        // Section: Record Section;
        "//MH soro 01-02-2018": Integer;
        MoisAttach: Option " ",Janvier,Fevrier,Mars,Avril,Mai,Jiun,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
        AnneeAttach: Integer;
        "LignePointageSalariéChanti": Record "Ligne Pointage Salarié Chanti";
        EtatMensuellePaie2: Record "Etat Mensuelle Paie";
        Recemployee: Record Employee;
        UserSetup: Record "User Setup";
        dialogMess1: label 'Défalcation des Heures Supp.';
        dialogMess2: label 'Mise à jours des lignes défalcation.';
        Text001: label 'Integrer Les Employées ?';
        Text002: label 'Tâche chevée Avec Succée';
        Text003: label 'Attention Vous Allez Supprimer Toutes Les Informations !!!! Continuer Quand Meme ??????????????????';
        Text004: label 'Vous Avez Depasser Le Nombre De Jours Autorisés';
        Text005: label 'Vous Devez Chosir Une Affectation';
        Text006: label 'Vous Avez Des Salariés Qui ont Dépasser 46 Mois de Travail';
        Text007: label 'Le Salarié %1 qui possede le Matricule %2  est presque d''atteindre 4 Ans d''ancienté avec un Nbre de Mois Ancienté = %3 Mois';
        Text008: label 'Le Salarié %1 qui possede le Matricule %2  est presque d''atteindre L''Age de Retraile avec un age de %3';
        Text009: label 'Remplir Tous Les Champs';
        Text010: label 'Integration Terminé';
        Text011: label 'Le salarié %1 à Depassé 60 ans';
        Text012: label 'Le contrat du  salarié %1 à pris fin';
        SetEditable: Boolean;


    procedure ValidationLignePointage(ParaMatricule: Code[20]) Sauter: Boolean
    var
        LEmployee: Record Employee;
        Mois: Integer;
        Annee: Integer;
        DateLimite: Date;
    begin
    end;
}

