page 52049045 "WIP Report Header"
{
    PageType = Card;
    //ApplicationArea = All; 
    //UsageCategory = Lists;
    SourceTable = "WIP Report Header";
    SourceTableView = where(Status = const(Open));
    RefreshOnActivate = true;
    CAPTION = 'WIP Report';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;

                }

                field("project description"; Rec."project description") { ApplicationArea = all; }
                field("Job Task No."; Rec."Job Task No.") { ApplicationArea = all; }
                field("Project Task No. description"; Rec."Project Task No. description") { ApplicationArea = all; }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;

                }
                field("Sum all Lines"; Rec."Sum all Lines") { ApplicationArea = all; Visible = false; }
                field(Status; Rec.Status) { ApplicationArea = all; }
                field("Starting date"; Rec."Starting date") { ApplicationArea = all; }
                field("Ending date"; Rec."Ending date") { ApplicationArea = all; }
                field("Agent Saisie"; Rec."Data Entry agent") { ApplicationArea = all; editable = true; }
                field("Date Saisie"; Rec."Data Entry Date") { ApplicationArea = all; }
            }
            part(WIPReportLine; "WIP Report Line")
            {
                SubPageLink = "WIP Report No." = field("No.");
                caption = 'Persons';
                ApplicationArea = all;
                UpdatePropagation = Both;
            }
            part("Ligne rapport Chantier Engins"; "Ligne rapport Chantier Engins2")
            {
                Caption = 'Machines';
                ApplicationArea = all;
                SubPageLink = "WIP Report No." = field("No.");
                UpdatePropagation = both;
                Visible = false;
            }
            part("Ligne rapport Chantier Engins3"; "Ligne rapport Chantier Engins3")
            {
                Caption = 'Machines / Gasoil';
                ApplicationArea = all;
                SubPageLink = "WIP Report No." = field("No.");
                UpdatePropagation = both;
            }
            part("Ligne rapport Chantier APPRO"; "Ligne rapport Chantier APPRO")
            {
                Caption = 'Consumptions';
                ApplicationArea = all;
                SubPageLink = "WIP Report No." = field("No.");
                UpdatePropagation = Both;
            }

        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(Posting)
            {
                Caption = 'Posting';
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    JobSetup: Record "Jobs Setup";
                    JobJournalLine: Record "Job Journal Line";
                    WipReportLine: Record "WIP Report Line";
                    JobRepLine: Record "Job Report Line";
                    IntLineNo: Integer;
                    CDUPostingWip: Codeunit "Posting Wip";
                begin
                    // CDUPostingWip.PostWipReport(Rec);
                    CDUPostingWip.Run(Rec);

                    /*   rec.TestField(Status, rec.Status::Open);
                       if JobSetup.Get() then begin
                           WipReportLine.Reset();
                           WipReportLine.SetRange("WIP Report No.", Rec."No.");
                           if WipReportLine.FindSet() then begin
                               repeat
                                   JobJournalLine.Init();
                                   JobJournalLine.TransferFields(WipReportLine);
                                   JobJournalLine."Journal Template Name" := JobSetup."Journal Template Name";
                                   JobJournalLine."Journal Batch Name" := JobSetup."Job Journal Batch";
                                   JobJournalLine."Document No." := Rec."No.";
                                   JobJournalLine."Posting Date" := Rec."Ending date";
                                   JobJournalLine."Document Date" := Today();
                                   JobJournalLine.Insert(true);
                               until WipReportLine.Next() = 0;
                           end;
                           WipReportLine.Reset();
                           WipReportLine.SetRange("WIP Report No.", Rec."No.");
                           if WipReportLine.FindLast() then
                               IntLineNo := WipReportLine."Line No." + 10000
                           else
                               IntLineNo := 10000;

                           JobRepLine.Reset();
                           JobRepLine.SetAutoCalcFields("Resource No.");
                           JobRepLine.SetRange("WIP Report No.", Rec."No.");
                           if JobRepLine.FindSet() then begin
                               repeat
                                   JobJournalLine.Init();
                                   JobJournalLine."Journal Template Name" := JobSetup."Journal Template Name";
                                   JobJournalLine."Journal Batch Name" := JobSetup."Job Journal Batch";
                                   JobJournalLine."Document No." := Rec."No.";
                                   JobJournalLine."Posting Date" := Rec."Ending date";
                                   JobJournalLine."Document Date" := Today();
                                   JobJournalLine."Line No." := IntLineNo;
                                   JobJournalLine.Validate("Job No.", Rec."Job No.");
                                   JobJournalLine.Validate("Job Task No.", Rec."Job Task No.");
                                   JobJournalLine.Type := JobJournalLine.Type::Resource;
                                   JobJournalLine.Validate("No.", JobRepLine."Resource No.");
                                   JobJournalLine.Validate(Quantity, 1);
                                   JobJournalLine.Insert(true);
                                   IntLineNo := IntLineNo + 10000;
                               until JobRepLine.Next() = 0;
                           end;
                       end;
                       CODEUNIT.Run(CODEUNIT::"Job Jnl.-Post", JobJournalLine);
                       Rec.Status := Rec.Status::Released;
                       Rec.Modify();*/
                end;

                // end;
            }
            action("Générer ligne pointage")
            {
                Caption = 'Générer ligne pointage';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    JobSetup: Record "Jobs Setup";
                    JobJournalLine: Record "Job Journal Line";
                    WipReportLine: Record "WIP Report Line";
                    JobRepLine: Record "Job Report Line";
                    IntLineNo: Integer;
                    CDUPostingWip: Codeunit "Posting Wip";
                    ParametreParc: Record "Paramétre Parc";
                    Item: Record Item;
                    WIPReportHeader: Record "WIP Report Header";
                    Text001: label 'Information Deja saisie';
                    Text002: label 'Information Deja saisie Pour La Journée %1 Pointage N° %2 Non Encore Validé';
                    LastDocument: Code[20];
                    LastJournee: Date;
                    RecVehicule: Record "Véhicule";
                    "ParamétreParc": Record "Paramétre Parc";
                    LineNo: Integer;

                begin
                    Rec.TESTFIELD("Job No.");
                    //  IF xRec.Journee <> 0D THEN IF xRec.Journee <> Journee THEN ERROR(Text004);
                    IF ParametreParc.GET THEN;
                    IF Item.GET(ParametreParc."Article Gasoil") THEN;
                    JobRepLine.SETRANGE("WIP Report No.", Rec."No.");
                    JobRepLine.SETRANGE(Resource, JobRepLine.Resource::Equipment);
                    JobRepLine.DELETEALL;
                    JobRepLine.Reset();
                    JobRepLine.SETRANGE("WIP Report No.", Rec."No.");
                    if JobRepLine.FindLast() THEN
                        LineNo := JobRepLine."Line" + 10000
                    else
                        LineNo := 10000;

                    WIPReportHeader.RESET;
                    WIPReportHeader.SETRANGE("Starting date", Rec."Data Entry Date");
                    WIPReportHeader.SETRANGE("Job No.", Rec."Job No.");
                    WIPReportHeader.SETRANGE(Status, WIPReportHeader.Status::Released);
                    IF WIPReportHeader.FINDFIRST THEN;
                    //   ERROR(Text002, Rec."Data Entry Date");

                    WIPReportHeader.RESET;
                    WIPReportHeader.SETRANGE(Status, WIPReportHeader.Status::Released);
                    IF WIPReportHeader.FINDLAST THEN BEGIN
                        LastDocument := WIPReportHeader."No.";
                        LastJournee := WIPReportHeader."Data Entry Date";
                    END;
                    RecVehicule.SETRANGE(Bloquer, FALSE);
                    RecVehicule.SETFILTER(Statut, '>%1', 0);
                    // IF ParamétreParc.GET THEN
                    //     IF ParametreParc."Filtre Chantier" <> '' THEN
                    RecVehicule.SETRANGE(marche, Rec."Job No.");
                    IF RecVehicule.FINDFIRST THEN
                        REPEAT
                            JobRepLine.Init();
                            JobRepLine."WIP Report No." := Rec."No.";
                            JobRepLine.Resource := JobRepLine.Resource::Equipment;
                            // JobRepLine.Equipment := RecVehicule."N° Vehicule";
                            JobRepLine.Validate(Equipment, RecVehicule."N° Vehicule");
                            JobRepLine."Equipment Description" := RecVehicule.Désignation;
                            JobRepLine."Job No." := Rec."Job No.";
                            JobRepLine."Job Task No." := Rec."Job Task No.";
                            JobRepLine."Task Description" := Rec."Project Task No. description";
                            JobRepLine.Statut := RecVehicule.Statut;
                            JobRepLine.Line := LineNo;

                            // LignePointageVehicule.Chauffeur := RecVehicule.Conducteur;
                            // LignePointageVehicule.Statut := RecVehicule.Statut;
                            // IF "Dimanche / Ferié" THEN
                            //     IF RecVehicule.Statut = RecVehicule.Statut::Fonctionnel
                            //     //  THEN LignePointageVehicule.Statut := LignePointageVehicule.Statut::"Wrong Expr";
                            //     THEN
                            //         LignePointageVehicule.Statut := LignePointageVehicule.Statut::"Disponible";
                            // LignePointageVehicule.Journee := Journee;
                            // LignePointageVehicule.Mois := DATE2DMY(Journee, 2);
                            // LignePointageVehicule.Annee := DATE2DMY(Journee, 3);
                            // LignePointageVehicule."Heure Travail Theorique" := ParametreParc."Heure Travail";
                            // LignePointageVehicule."Cout Horaire" := RecVehicule."Cout Location Horaire";
                            // LignePointageVehicule."Cout Journalier" := RecVehicule."Cout Journalier";
                            // LignePointageVehicule."Unite Travail" := "Unité Travail";
                            // LignePointageVehicule."N° Serie" := RecVehicule.Immatriculation;
                            // IF CatégorieVéhicule.GET(RecVehicule.Famille) THEN
                            //     LignePointageVehicule."Type Vehicule" := CatégorieVéhicule.Désignation;
                            // LigneGasoil.RESET;
                            // KilometrageJour := 0;
                            // LigneGasoil.RESET;
                            // LigneGasoil.SETCURRENTKEY(Journee);
                            // LigneGasoil.SETRANGE(Materiel, RecVehicule."N° Vehicule");
                            // IF LigneGasoil.FINDLAST THEN BEGIN
                            //     LignePointageVehicule."Index Final" := LigneGasoil."Valeur Compteur";
                            // END;

                            // IF LignePointageVehicule3.GET(LastDocument, RecVehicule."N° Vehicule", LastJournee) THEN BEGIN
                            //     LignePointageVehicule."Motif Indispensalité" := LignePointageVehicule3."Motif Indispensalité";
                            //     LignePointageVehicule."Motif Panne" := LignePointageVehicule3."Motif Panne";
                            //     LignePointageVehicule."N° Reparation" := LignePointageVehicule3."N° Reparation";
                            //     LignePointageVehicule.Observation := LignePointageVehicule3.Observation;
                            //     LignePointageVehicule.Chauffeur := LignePointageVehicule3.Chauffeur;
                            //     LignePointageVehicule."Chauffeur 2" := LignePointageVehicule3."Chauffeur 2";
                            //     LignePointageVehicule."Chauffeur 3" := LignePointageVehicule3."Chauffeur 3";
                            //     LignePointageVehicule."DA Lancé" := LignePointageVehicule3."DA Lancé";
                            //     LignePointageVehicule."N° DA" := LignePointageVehicule3."N° DA";
                            //     LignePointageVehicule."Affectation Marche" := LignePointageVehicule3."Affectation Marche";
                            //     LignePointageVehicule."Sous Affectation Marche" := LignePointageVehicule3."Sous Affectation Marche";
                            //     LignePointageVehicule.Marche := LignePointageVehicule3.Marche;
                            //     LignePointageVehicule."N° Reparation" := LignePointageVehicule3."N° Reparation";
                            //     LignePointageVehicule."Index Depart" := LignePointageVehicule3."Index Final";
                            // END;
                            //  JobRepLine.INSERT;
                            IF NOT JobRepLine.INSERT THEN JobRepLine.MODIFY;
                            LineNo := LineNo + 10000;

                        UNTIL RecVehicule.NEXT = 0;

                end;

                // end;
            }
        }
    }



}