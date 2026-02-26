PageExtension 50310 "Job Card _PagEXT" extends "Job Card"
{
    layout
    {
        addafter("Project Manager")
        {
            field("No. Series Projet"; Rec."No. Series Caisse")
            {
                ApplicationArea = all;
            }
            field("Fond de Roulement Caisse"; Rec."Fond de Roulement Caisse")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fond de Roulement Caisse field.', Comment = '%';
            }
            field("Depenses Caisse"; Rec."Depenses Caisse")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Depenses Caisse field.', Comment = '%';
            }


            field("Pointage Serine N°"; rec."No. Series Pointage Vehicule")
            {
                ApplicationArea = all;
            }
        }
        addlast(General)
        {

            field("Affectation Magasin"; Rec."Affectation Magasin") { ApplicationArea = all; ShowMandatory = true; }
            field("% Marge"; Rec."% Marge") { ApplicationArea = all; visible = false; Enabled = false; }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                Style = Unfavorable;
                Editable = false;
                ShowMandatory = true;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                Style = Unfavorable;
                ShowMandatory = true;
                ToolTip = 'Specifies the value of the Global Dimension 2 Code field.', Comment = '%';
            }
        }

    }
    actions
    {
        addafter("&Job")
        {
            action("Generer Axe PROJET")
            {
                Image = DimensionSets;
                ApplicationArea = all;
                Caption = 'Générer Axe PROJET';
                trigger OnAction()
                var

                begin
                    rec.SetRange(Blocked, rec.Blocked::" ");
                    if rec.findfirst then
                        repeat
                            rec.CreateJobDimension(0);
                        until rec.Next() = 0;
                    Message('Mise à jour des axes terminée.');
                end;

            }
            action("suggérer prix de vente")
            {
                trigger OnAction()
                var

                begin
                    Suggérerprixdevente();
                end;

            }
            action("Lancement des traveaux")
            {
                trigger OnAction()
                var

                begin
                    Lancementdestraveaux();
                end;

            }
            action(JobPlanningLines2)
            {
                ApplicationArea = Jobs;
                Caption = 'Lignes Facturable';
                Image = JobLines;
                ToolTip = 'View all planning lines for the project. You use this window to plan what items, resources, and general ledger expenses that you expect to use on a project (Budget) or you can specify what you actually agreed with your customer that he should pay for the project (Billable).';

                trigger OnAction()
                var
                    JobPlanningLine: Record "Job Planning Line";
                    JobPlanningLines: Page "Lignes planning projet B/F";
                    IsHandled: Boolean;
                begin
                    IsHandled := false;
                    //     OnBeforeJobPlanningLinesAction(Rec, IsHandled);
                    if IsHandled then
                        exit;

                    Rec.TestField("No.");
                    JobPlanningLine.FilterGroup(2);
                    JobPlanningLine.SetRange("Job No.", Rec."No.");
                    JobPlanningLine.FilterGroup(0);
                    JobPlanningLines.SetJobTaskNoVisible(true);
                    JobPlanningLines.SetTableView(JobPlanningLine);
                    JobPlanningLines.Editable := true;
                    JobPlanningLines.Run();
                end;
            }
        }
        addafter("Create Warehouse Pick_Promoted")
        {
            actionref("suggérer prix de venteRef"; "suggérer prix de vente")
            {
            }
            actionref("Lancement des traveauxRef"; "Lancement des traveaux")
            {
            }
        }
        addafter("JobPlanningLines_Promoted")
        {
            actionref("JobPlanningLines2Ref"; "JobPlanningLines2")
            {
            }

        }
    }
    procedure Lancementdestraveaux()
    var
        LineNo: Integer;
        RecJobPlanningLine2: Record "Job Planning Line";
    begin
        RecResourcesSetup.Get();
        LineNo := 10000;

        RecJobTask.Reset();
        RecJobTask.SetRange("Job No.", Rec."No.");
        RecJobTask.SetFilter("Job Task Type", '%1', RecJobTask."Job Task Type"::Posting);
        if RecJobTask.FindSet() then begin
            repeat
                RecJobPlanningLine2.Reset();
                RecJobPlanningLine2.setrange("Job No.", Rec."No.");
                RecJobPlanningLine2.SetRange("Job Task No.", RecJobTask."Job Task No.");
                if RecJobPlanningLine2.FindLast() then
                    LineNo := RecJobPlanningLine2."Line No." + 10000;
                if RecJobTask."Initial Quantity" <> 0 then begin
                    RecJobPlanningLine.Init();
                    RecJobPlanningLine."Job No." := Rec."No.";
                    RecJobPlanningLine."Job Task No." := RecJobTask."Job Task No.";
                    RecJobPlanningLine.validate("Line Type", RecJobPlanningLine."Line Type"::Billable);
                    RecJobPlanningLine."Document Date" := Today();
                    RecJobPlanningLine."Line No." := LineNo;
                    RecJobPlanningLine.Type := RecJobPlanningLine.Type::Resource;
                    RecJobPlanningLine.Validate("No.", RecResourcesSetup."ressources Projet");

                    RecJobPlanningLine.Insert(true);

                    RecJobPlanningLine.Validate("Unit of Measure Code", RecJobTask."Initial Unit Of Measure");

                    RecJobPlanningLine.Validate(Quantity, RecJobTask."Initial Quantity");
                    RecJobPlanningLine.Validate("Unit Price", RecJobTask."Initial Unit Price");
                    RecJobPlanningLine."Qty. to Transfer to Invoice" := 0;
                    RecJobPlanningLine.Description := RecJobTask.Description;

                    RecJobPlanningLine.Modify();

                    LineNo := LineNo + 10000;
                end;
            until RecJobTask.Next() = 0;
        end;
        Rec.Status := Rec.Status::Open;
        Rec.Modify();
        Message('Le projet a été lancé avec succès.');
    end;

    procedure Suggérerprixdevente()
    var
        Cpt: Integer;
        NouveauStatutTxt: Text;
    begin
        RecJobTask.Reset();
        RecJobTask.SetRange("Job No.", Rec."No.");
        RecJobTask.SetFilter("Job Task Type", '%1', RecJobTask."Job Task Type"::Posting);
        if RecJobTask.FindSet() then begin
            repeat
                Cpt += 1;
                RecJobTask.CalcFields("Schedule (Total Cost)");
                if (RecJobTask."Schedule (Total Cost)" <> 0) and (RecJobTask."Initial Quantity" <> 0) then begin
                    RecJobTask."Initial Amount" := RecJobTask."Schedule (Total Cost)" * ((100 + Rec."% Marge") / 100);
                    if RecJobTask."Initial Quantity" <> 0 then
                        RecJobTask."Initial Unit Price" := RecJobTask."Initial Amount" / RecJobTask."Initial Quantity";
                    RecJobTask.Modify();
                end;
            until RecJobTask.Next() = 0;
        end;
        Rec.Status := Rec.Status::Quote;
        Rec.Modify();
        NouveauStatutTxt := Format(Rec.Status);
        Message(
      '%1 lignes mises à jour pour le job %2. Le statut est passé à : %3',
      Cpt,
      Rec."No.",
      NouveauStatutTxt
  );
    end;

    var
        RecJobTask: Record "Job Task";
        RecJobPlanningLine: Record "Job Planning Line";
        RecResourcesSetup: Record "Resources Setup";

}