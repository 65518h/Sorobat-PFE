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
                field("Agent Saisie"; Rec."Data Entry agent") { ApplicationArea = all; editable = false; }
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
        }
    }



}