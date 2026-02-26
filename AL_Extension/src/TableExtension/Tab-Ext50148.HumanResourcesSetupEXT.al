TableExtension 50148 "Human Resources SetupEXT" extends "Human Resources Setup"
{
    fields
    {
        field(50000; "Nombre Heure Travail Par Mois"; Decimal)
        {
        }
        field(50001; "Prime days"; Code[10])
        {
            Caption = 'NB Jours Prime';
        }
        field(50002; "Notifié dmde Formation"; Code[20])
        {
            Description = 'GRH-TRIUM1.00';
            TableRelation = Employee."No.";
        }
        field(50003; "Notifié dmde Recrutement"; Code[20])
        {
            Description = 'GRH-TRIUM1.00';
            TableRelation = Employee."No.";
        }
        field(50004; "Code rembourcement frais"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(50005; "Plafond Heure Supp"; Integer)
        {
            Description = 'HJ SORO 25-09-2014';
        }
        field(50006; "indemnité Exéptionnelle"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(50007; "indemnité Salisure"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(50008; "Montant retenu caisse FS"; Decimal)
        {
            Description = '//Montant retenu caisse Fond social';
        }
        field(50009; "Type Calcul prêt"; Option)
        {
            OptionCaption = 'Nombre de tranche,Montant tranche';
            OptionMembers = "Nombre de tranche","Montant tranche";
        }
        field(50010; Douche; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(50011; "Calcul Montant absence"; Boolean)
        {
        }
        field(50012; "Code indemnité samedi"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(50013; "Code indemnité ration de force"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(50014; "Code indemnité Habillement"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(50015; "Code Prime semestrielle"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(50016; "Congé annuel"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(50017; "Code contrubition national"; Code[20])
        {
            TableRelation = "Social Contribution";
        }
        field(50018; "Ind. Heures de vol"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(50019; "Indem Ancienneté"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(50020; "Type calcul congé"; Option)
        {
            OptionCaption = 'Salaire de base + indemnité,Somme salaire brut *13.75';
            OptionMembers = "Salaire de base + indemnité","Somme salaire brut *13.75";
        }
        field(50021; "Taux IS"; Decimal)
        {
        }
        field(50022; "Plafand Brut"; Decimal)
        {
        }
        field(50023; CNSS; Code[20])
        {
            Description = 'Mehdi 11-07-2014';
            TableRelation = "Social Contribution";
        }
        field(50024; "Prestations Familiale"; Code[20])
        {
            Description = 'Mehdi 11-07-2014';
            TableRelation = "Social Contribution";
        }
        field(50025; "Risque Professionnel"; Code[20])
        {
            Description = 'Mehdi 11-07-2014';
            TableRelation = "Social Contribution";
        }
        field(50026; "Assurance Vieillesse"; Code[20])
        {
            Description = 'Mehdi 11-07-2014';
            TableRelation = "Social Contribution";
        }
        field(50027; "Appliquer Retenue FSP"; Boolean)
        {
            Description = 'HJ SORO 24-09-2014';
            TableRelation = Indemnity;
        }
        field(50028; "Taux Retenue FSP"; Decimal)
        {

        }
        field(50029; "Montant Indem Deplacement"; Decimal)
        {
            Description = 'HJ SORO 24-09-2014';
        }
        field(50030; "Indemnite Rappel"; Code[20])
        {
            Description = 'HJ SORO 24-09-2014';
            TableRelation = Indemnity;
        }
        field(50031; "Indemnite Retenu"; Code[20])
        {
            Description = 'HJ SORO 24-09-2014';
            TableRelation = Indemnity;
        }
        field(50032; "Indemnite Cession"; Code[20])
        {
            Description = 'HJ SORO 24-09-2014';
            TableRelation = Indemnity;
        }
        field(50033; "Bon Reglement N°"; Code[20])
        {
            Description = 'HJ SORO 24-09-2014';
            TableRelation = "No. Series";
        }
        field(50034; "Appliqué taxe redevance"; Boolean)
        {
        }
        field(50035; "Taux redevance sur salaire"; Decimal)
        {
        }
        field(50036; "Plafond redevance"; Decimal)
        {
        }
        field(50037; "Limite Redevance"; Decimal)
        {
        }
        field(50038; "Plafond Exonération Impot"; Decimal)
        {
        }
        field(50039; "Appliquer Exo Impot"; Boolean)
        {
            Description = 'HJ SORO 21-10-2014';
        }
        field(50040; "Conge Base Salaire De Base"; Boolean)
        {
        }
        field(50041; "Recap Paie"; Code[20])
        {
            Description = 'RB SORO 28/09/2015';
            TableRelation = "No. Series";
        }
        field(50042; "Indemnite Kilometrage"; Code[20])
        {
            Description = 'RB SORO 17/02/2016';
            TableRelation = Indemnity;
        }
        field(50043; "Montant Indem Kilometrage"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'RB SORO 17/02/2016';
        }
        field(50044; "STC Salarie"; Code[20])
        {
            Description = 'RB SORO 29/04/2016';
            TableRelation = "No. Series";
        }
        field(50045; "Lot Paie"; Code[20])
        {
            Description = 'RB SORO 08/05/2016';
            TableRelation = "No. Series";
        }
        field(50046; "Indemnite Panier"; Code[20])
        {
            Description = 'Update Paie Panier';
            TableRelation = Indemnity;
        }
        field(50050; "Taux Part salariale CNSS"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'RB SORO 12/04/2016';
        }
        field(50051; "Taux Part patronale CNSS"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'RB SORO 12/04/2016';
        }
        field(50052; "Taux Accidents du travail CNSS"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'RB SORO 12/04/2016';
        }
        field(50053; "Taux Part salariale CNSS Avant"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'RB SORO 12/04/2016';
        }
        field(50054; "Taux Part patronale CNSS Avant"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'RB SORO 12/04/2016';
        }
        field(50055; "Taux Accid du travail CNSS Ava"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'RB SORO 12/04/2016';
        }
        field(50056; "Total Cotisation CNSS"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'RB SORO 12/04/2016';
        }
        field(50057; "Total Cotisation CNSS Avantage"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'RB SORO 12/04/2016';
        }
        field(50058; "Taux CNSS"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50059; "Bordereau Paie"; Code[20])
        {
            Description = 'RB SORO 31/05/2017';
            TableRelation = "No. Series";
        }
        field(50060; "Rejet Salaire"; Code[20])
        {
            Description = 'RB SORO 15/07/2017';
            TableRelation = "No. Series";
        }
        field(50061; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;

            trigger OnValidate()
            begin
                PictureUpdated := true;
            end;
        }
        field(50200; "Mission Etranger"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50201; "Mission Local"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50202; "Mission Chantier"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50500; "1/2 solde à partir de"; Decimal)
        {
        }
        field(50501; "Type de Note"; Option)
        {
            Caption = 'Type de Note';
            InitValue = Pourcentage;
            OptionCaption = 'Pourcentage,Coefficient';
            OptionMembers = Pourcentage,Coefficient;
        }
        field(50502; "Paie Notée"; Option)
        {
            Caption = 'Paie Notée';
            InitValue = "14ème";
            OptionCaption = '13ème,14ème,Autre';
            OptionMembers = "13ème","14ème",Autre;
        }
        field(50600; "N° Mission"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50601; "N° Absence"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50602; "Pointage Salarié"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(50900; "Type Calcul Note"; Option)
        {
            OptionCaption = 'Independante,Cumulatif';
            OptionMembers = Independante,Cumulatif;
        }
        field(60000; "Number of monthes"; Option)
        {
            Caption = 'Number of monthes';
            OptionMembers = "Paies régulières","Rétributions provisoires","Paies régulières + Rétributions provisoires";
        }
        field(60001; "Directeur général"; Text[100])
        {
        }
        field(60002; "Plafond Cotisation Social"; Integer)
        {
        }
        field(60003; "Taux Plafond Cotisation"; Decimal)
        {
        }
        field(60004; "Taux TPA"; Decimal)
        {
        }
        field(60005; "Base Prime Panier F"; Decimal)
        {
        }
        field(60006; "Filtre Departement"; code[20])
        {
            TableRelation = "Employee Statistics Group".Code WHERE(Type = CONST(Departement));


        }
        field(60007; "Filtre Affectation1"; Code[20])
        {
            TableRelation = Job;
        }
        field(60008; "Filtre Affectation2"; Code[20])
        {
            TableRelation = Job;
        }
        field(60009; "Filtre Affectation3"; Code[20])
        {
            TableRelation = Job;
        }
        field(60010; "Code Solde Congé STC"; Code[20])
        {
            TableRelation = "Cause of Absence";
        }
        field(39001420; "App.Defalcation automat"; Boolean)
        {
        }
        field(39001421; "Code indem rappel chang grille"; Code[20])
        {
            TableRelation = Indemnity.Code;
        }
        field(39001422; "Activer régime quinzaine"; Boolean)
        {
        }
        field(39001423; "Code ind.rend. Mensuel"; Code[20])
        {
            TableRelation = Indemnity.Code;
        }
        field(39001424; "Appl. prime rendement mensuel"; Boolean)
        {
        }
        field(39001425; "Activer prime de productivité"; Boolean)
        {
            Description = '//DSFT-AGA 100710';
        }
        field(39001426; "Code indemnité de productivité"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(39001427; "Nombre de jours Prime de prod"; Decimal)
        {
        }
        field(39001430; "Applquer Le Prêt après"; Integer)
        {
        }
        field(39001431; "Taux Interêt du prêt"; Decimal)
        {
        }
        field(39001450; "Motif Abscence pour Dép."; Code[20])
        {
            TableRelation = "Cause of Absence";
        }
        field(39001451; "Motif Abscence Affaire Pers."; Code[20])
        {
            TableRelation = "Cause of Absence";
        }
        field(39001452; "Nbre Heures Panier"; Decimal)
        {
        }
        field(39001453; "Permission de Retard (en Min)"; Decimal)
        {
        }
        field(39001454; "Date de Calcul de Paie"; Integer)
        {
        }
        field(39001455; "Code Grille par défaut"; Code[20])
        {
            TableRelation = "Salary grid header".Code;
        }
        field(39001456; "App.retribution jour ancien."; Boolean)
        {
        }
        field(39001460; "Type Consomation Congé"; Option)
        {
            OptionCaption = 'Jours Ouvert Seulement,Jours Normaux';
            OptionMembers = "Jours Ouvert Seulement","Jours Normaux";
        }
        field(39001470; "Validité Recuperation"; DateFormula)
        {
        }
        field(39001471; "Code Calendar"; Code[20])
        {
            TableRelation = "Base Calendar".Code;
        }
        field(39001472; "Heures Réel Travaillées / ans"; Decimal)
        {
        }
        field(39001473; "type calcul solde congé"; Option)
        {
            OptionMembers = "Salaire base"," Salaire base+ Indemnité";
        }
        field(39001480; "N° Paie Prev"; Code[20])
        {
            Caption = 'Loan & Advance Nos.';
            TableRelation = "No. Series";
        }
        field(39001481; "Chèque Salarié"; Text[30])
        {
            //GL2024  TableRelation = "Payment Class" where(Suggestions = const("3"));
            TableRelation = "Payment Class" where(Suggestions = const(vendor));

        }
        field(39001482; "Espèce Salarié"; Text[30])
        {
            //GL2024  TableRelation = "Payment Class" where(Suggestions = const("3"));
            TableRelation = "Payment Class" where(Suggestions = const(vendor));
        }
        field(39001483; "ind. Gratif. Fin Serv."; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(39001484; "nbre J par Mois travail"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(39001485; "Max en Mois"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(39001486; "Ind. Licensement"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(39001487; "Nbre Mois (Licensement)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(39001488; "Max en Mois (Lic.)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(39001489; "Ind transport Chantier"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(39001490; "Ind supp Chantier"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(39001492; "Heure Début Nuit"; Time)
        {
        }
        field(39001493; "Heure Fin Nuit"; Time)
        {
        }
        field(39001494; "Indem diff Prime"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(39001495; "Indem Sursalaire"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(39001496; "N° Document Decision"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(39001498; "Virement Salarié"; Text[30])
        {
            //GL2024  TableRelation = "Payment Class" where(Suggestions = const("3"));
            TableRelation = "Payment Class" where(Suggestions = const(vendor));
        }
        field(39001499; "Avance Repas"; Code[20])
        {
            TableRelation = "Loan & Advance Type";
        }
        field(39001500; "Calculer STC auto"; Boolean)
        {
        }
        field(39001501; "Code solde congé"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(39001502; "Inclure jours droit de congé"; Boolean)
        {
        }
        field(39001503; "Inclure heures supplémentaire"; Boolean)
        {
        }
        field(39001504; "Inclure heures de nuits"; Boolean)
        {
        }
        field(39001561; "Ind supp Chantier auto."; Boolean)
        {
        }
        field(39001562; Chantier; Boolean)
        {
        }
        field(39001563; "Activer Type Prime"; Boolean)
        {
        }
        field(39001564; "Deduction for Familly Chief"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Deduction for Familly Chief';
        }
        field(39001565; "From Work day to Work hour"; Decimal)
        {
            Caption = 'From Work day to Work hour';
            DecimalPlaces = 3 : 3;
        }
        field(39001566; "Taxes regulation"; Option)
        {
            Caption = 'Taxes regulation';
            OptionCaption = 'Dynamic,12th and more,Statique 12';
            OptionMembers = Dynamic,"13th and more","Statique 12";
        }
        field(39001567; "Minimum wage guarantee"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Minimum wage guarantee';
        }
        field(39001568; "% professional expenses"; Decimal)
        {
            Caption = '% professional expenses';
        }
        field(39001569; "Paid days"; Decimal)
        {
            Caption = 'Paid days';
        }
        field(39001570; "Worked days"; Decimal)
        {
            Caption = 'Worked days';
        }
        field(39001571; "Expenses to repay Nos."; Code[20])
        {
            Caption = 'Expenses to repay Nos.';
            TableRelation = "No. Series";
        }
        field(39001572; "Paiment Nos."; Code[20])
        {
            Caption = 'Paiment Nos.';
            TableRelation = "No. Series";
        }
        field(39001573; "Employment Contract Nos."; Code[20])
        {
            Caption = 'Employment Contract Nos.';
            TableRelation = "No. Series";
        }
        field(39001574; "Loan & Advance Nos."; Code[20])
        {
            Caption = 'Loan & Advance Nos.';
            TableRelation = "No. Series";
        }
        field(39001575; "Salary grid Nos."; Code[20])
        {
            Caption = 'Salary grid Nos.';
            TableRelation = "No. Series";
        }
        field(39001576; "Supp. hours Nos."; Code[20])
        {
            Caption = 'Supp. hours Nos.';
            TableRelation = "No. Series";
        }
        field(39001577; "General Journal Template"; Code[20])
        {
            Caption = 'General Journal Template';
            TableRelation = "Gen. Journal Template" where(Type = filter(Financial));

            trigger OnLookup()
            begin
                if "General Journal Template" <> '' then begin
                    GenJournalBatch.SetRange("Journal Template Name", "General Journal Template");
                    if GenJournalBatch.Find('-') then begin
                        FormGenJournalBatch.SetTableview(GenJournalBatch);
                        if page.RunModal(0, GenJournalBatch) = Action::LookupOK then begin
                            "General Journal Template" := GenJournalBatch.Name;
                            Modify;
                        end;
                    end;
                end
            end;
        }
        field(39001578; "Gen. Journal Batch (Payroll)"; Code[20])
        {
            Caption = 'Gen. Journal Batch (Payroll)';

            trigger OnLookup()
            begin
                if "General Journal Template" <> '' then begin
                    GenJournalBatch.SetRange("Journal Template Name", "General Journal Template");
                    if GenJournalBatch.Find('-') then begin
                        FormGenJournalBatch.SetTableview(GenJournalBatch);
                        if page.RunModal(0, GenJournalBatch) = Action::LookupOK then begin
                            "Gen. Journal Batch (Payroll)" := GenJournalBatch.Name;
                            Modify;
                        end;
                    end;
                end
            end;
        }
        field(39001579; "Gen. Journal Batch (L&A)"; Code[20])
        {
            Caption = 'Gen. Journal Batch (Loan && Advance)';

            trigger OnLookup()
            begin
                if "General Journal Template" <> '' then begin
                    GenJournalBatch.SetRange("Journal Template Name", "General Journal Template");
                    if GenJournalBatch.Find('-') then begin
                        FormGenJournalBatch.SetTableview(GenJournalBatch);
                        if page.RunModal(0, GenJournalBatch) = Action::LookupOK then begin
                            "Gen. Journal Batch (L&A)" := GenJournalBatch.Name;
                            Modify;
                        end;
                    end;
                end
            end;
        }
        field(39001580; "Loss on rounding amounts"; Code[20])
        {
            Caption = 'Loss on rounding amounts';
            TableRelation = "G/L Account";
        }
        field(39001581; "User ID"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(39001582; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(39001583; "Default Panier"; Code[20])
        {
            TableRelation = Indemnity.Code;
        }
        field(39001584; "NB Jours annuel"; Decimal)
        {
        }
        field(39001585; "NB Heures annuel"; Decimal)
        {
        }
        field(39001586; "Candidat Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(39001587; "N° Borderau"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(39001588; "To-do Nos."; Code[20])
        {
            Caption = 'To-do Nos.';
            TableRelation = "No. Series";
        }
        field(39001589; "N° Modele Action"; Code[20])
        {
            Caption = 'N° modèle action';
            TableRelation = "No. Series";
        }
        field(39001590; "General Journal Template GFM"; Code[20])
        {
            Caption = 'General Journal Template';
            TableRelation = "Gen. Journal Template" where(Type = filter(General));
        }
        field(39001591; "Gen. Journal Batch GFM"; Code[20])
        {
            Caption = 'Gen. Journal Batch (GFM)';

            trigger OnLookup()
            begin
                if "General Journal Template" <> '' then begin
                    GenJournalBatch.SetRange("Journal Template Name", "General Journal Template");
                    if GenJournalBatch.Find('-') then begin
                        FormGenJournalBatch.SetTableview(GenJournalBatch);
                        if page.RunModal(0, GenJournalBatch) = Action::LookupOK then begin
                            "Gen. Journal Batch (Payroll)" := GenJournalBatch.Name;
                            Modify;
                        end;
                    end;
                end
            end;
        }
        field(39001592; "Montant Arrondi"; Decimal)
        {
        }
        field(39001593; "Attestation de travail depuis"; Text[200])
        {
        }
        field(39001594; "Attestation de travail période"; Text[200])
        {
        }
        field(39001595; "Certif de travail"; Text[200])
        {
        }
        field(39001596; "Responsable personnel"; Code[20])
        {
            TableRelation = Employee;
        }
        field(39001597; "Mode limite avance prêt"; Option)
        {
            OptionCaption = 'Pourcentage,Montant';
            OptionMembers = Pourcentage,Montant;

            trigger OnValidate()
            begin
                Valeur := 0;
                Modify
            end;
        }
        field(39001598; Valeur; Decimal)
        {
        }
        field(39001599; "Type Calcul prime"; Option)
        {
            OptionMembers = "Prime=(((Salaire base+Indemnité)*NbjourTravaillé)/NbjourAnuel)*Taux","Prime=(somme SB Brut* 26 *(J TR/360)/(24*M TR))- (SB Brut12*(M TR/12))","Prime=(((somme SB Brut* NB jour payé)/NB jour annuel)*Taux)","Prime=(((Salaire base+Indemnité)*NbjourTravaillé+HN)/NbjourHAnuel)*Taux ","Prime=(((Salaire base+Indemnité)*Note/20","SBase*8*2*N*n/12","Brut*10%","prime=((S base+ind) pourcentage*nb jours*nb mois trav)/12","Prime=(Somme S base+indemités)*pourcentage","Formules GMS","S Base * note";
        }
    }

    trigger OnInsert()

    BEGIN
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    END;

    trigger OnModify()
    BEGIN
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    END;

    trigger OnRename()
    BEGIN
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    END;

    procedure SetPictureFromBlob(TempBlob: Codeunit "Temp Blob")
    var
        RecordRef: RecordRef;
    begin
        RecordRef.GetTable(Rec);
        TempBlob.ToRecordRef(RecordRef, FieldNo(Picture));
        RecordRef.SetTable(Rec);
    end;



    var
        //DYS page addon non migrer
        //   Obj: page 52048950;
        //GL2024 License   Objet: Record "Object";
        GenJournalBatch: Record "Gen. Journal Batch";
        FormGenJournalBatch: page "General Journal Batches";
        EmployeeAbsence: Record "Employee Absence";
        HumanResUnitOfMeasure: Record "Human Resource Unit of Measure";
        Text001: label 'You cannot change %1 because there are %2.';
        PictureUpdated: Boolean;
}

