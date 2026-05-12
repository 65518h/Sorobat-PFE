page 52049053 "WIP Report Header Archive"
{
    PageType = Card;
    //ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = "WIP Report Header";
    SourceTableView = where(Status = const(Released));
    RefreshOnActivate = true;
    caption = 'WIP Report Header Archive';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {

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
                field("Agent Saisie"; Rec."Data Entry agent") { ApplicationArea = all; }
                field("Date Saisie"; Rec."Data Entry Date") { ApplicationArea = all; }

            }
            part(WIPReportLine; "WIP Report Line Archive")
            {
                SubPageLink = "WIP Report No." = field("No.");
                caption = 'Personnes';
                ApplicationArea = all;
                UpdatePropagation = Both;
            }
            part("Ligne rapport Engins archive"; "Ligne rapport Engins archive")
            {
                Caption = 'Engins';
                ApplicationArea = all;
                SubPageLink = "WIP Report No." = field("No.");
                UpdatePropagation = SubPart;
            }
            part("Ligne rapport APPRO archive"; "Ligne rapport APPRO archive")
            {
                Caption = 'Consommations';
                ApplicationArea = all;
                SubPageLink = "WIP Report No." = field("No.");
            }
        }
        area(Factboxes)
        {

        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(Posting)
    //         {
    //             Caption = 'Posting';
    //             ApplicationArea = All;
    //             Image = Post;

    //             trigger OnAction()
    //             var
    //                 JobSetup: Record "Jobs Setup";
    //                 JobJournalLine: Record "Job Journal Line";
    //                 WipReportLine: Record "WIP Report Line";
    //             begin
    //                 rec.TestField(Status, rec.Status::Open);
    //                 if JobSetup.Get() then begin
    //                     WipReportLine.Reset();
    //                     WipReportLine.SetRange("WIP Report No.", Rec."No.");
    //                     if WipReportLine.FindSet() then begin
    //                         repeat
    //                             JobJournalLine.TransferFields(WipReportLine);
    //                             JobJournalLine."Journal Template Name" := JobSetup."Journal Template Name";
    //                             JobJournalLine."Journal Batch Name" := JobSetup."Job Journal Batch";
    //                             JobJournalLine."Document No." := Rec."No.";
    //                             JobJournalLine."Posting Date" := Today();
    //                             JobJournalLine."Document Date" := Today();
    //                             JobJournalLine.Insert(true);
    //                         until WipReportLine.Next() = 0;
    //                     end;
    //                     CODEUNIT.Run(CODEUNIT::"Job Jnl.-Post", JobJournalLine);
    //                     Rec.Status := Rec.Status::Released;
    //                     Rec.Modify();
    //                 end;
    //             end;
    //         }
    //     }
    // }



}