page 52048917 "Recorded Employee's Absences"
{
    //GL2024  ID dans Nav 2009 : "39001438"
    Caption = 'Recorded Employee''s Absences';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Employee's days off Entry";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Tab)
            {
                field("Transaction No."; REC."Transaction No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Entry No."; REC."Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Line type"; REC."Line type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Unit; REC.Unit)
                {
                    ApplicationArea = all;
                }
                field(Nom; REC.Nom)
                {
                    ApplicationArea = all;
                }
                field(prenom; REC.prenom)
                {
                    ApplicationArea = all;
                }
                field(section; Rec.section)
                {
                    ApplicationArea = all;
                }

                field("Employee No."; REC."Employee No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("From Date"; REC."From Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("To Date"; REC."To Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Montant Ligne"; REC."Montant Ligne")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Cause of Absence Code"; REC."Cause of Absence Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Quantity; REC.Quantity)
                {
                    Editable = false;
                }
                field("Posting month"; REC."Posting month")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting year"; REC."Posting year")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Quantity (Days)"; REC."Quantity (Days)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Quantity (Hours)"; REC."Quantity (Hours)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Payment No."; REC."Payment No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Motif D'absence"; REC."Motif D'absence")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Quinzaine; REC.Quinzaine)
                {
                    ApplicationArea = all;
                }
                field(Comment; REC.Comment)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("Fonction&s1")
            {
                Caption = 'Fonction&s';
                actionref(Unvalidate1; Unvalidate) { }
                actionref("Impimer Titre de congés1"; "Impimer Titre de congés") { }
            }
            group("A&bsence1")
            {
                Caption = 'A&bsence';
                actionref("Co&mments1"; "Co&mments") { }
                actionref("Overview by &Categories1"; "Overview by &Categories") { }

            }
        }
        area(navigation)
        {
            group("Fonction&s")
            {
                Caption = 'Fonction&s';
                action(Unvalidate)
                {
                    ApplicationArea = all;
                    Caption = 'Unvalidate';

                    trigger OnAction()
                    var
                        HumanRessource: Codeunit "Management of absences";
                        Saved: Record "Employee's days off Entry";
                        conf: Label 'Are sur to unvalidate the selected lines.';
                    begin
                        CurrPage.SETSELECTIONFILTER(Saved);
                        //Saved.CALCFIELDS(Enregistrer);
                        //Saved.SETFILTER(Enregistrer,'%1',FALSE);
                        Saved.SETFILTER("Payment No.", '%1', '');
                        Saved.SETFILTER(Comptabiliser, '%1', FALSE);
                        IF Saved.FIND('-') THEN BEGIN
                            IF CONFIRM(conf) THEN
                                REPEAT
                                    HumanRessource.UnValidateEmployeeAbsence(Saved);
                                UNTIL Saved.NEXT = 0;
                        END
                        ELSE
                            MESSAGE('Vous ne pouvez pas dévalider des éléments de paie enregistrée ou comptabilisée!');
                    end;
                }
                separator("  ")
                {
                }
                action("Impimer Titre de congés")
                {
                    ApplicationArea = all;
                    Caption = 'Impimer Titre de congés';

                    trigger OnAction()
                    begin
                        EmplDaysOffEntry.RESET;
                        CurrPage.SETSELECTIONFILTER(EmplDaysOffEntry);
                        REPORT.RUNMODAL(39001422, TRUE, TRUE, EmplDaysOffEntry);
                    end;
                }
            }
            group("A&bsence")
            {
                Caption = 'A&bsence';
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Confidential Information"),
                                  "Table Line No." = FIELD("Entry No."),
                                  "No." = FIELD("Employee No.");
                }
                separator(" ")
                {
                }
                action("Overview by &Categories")
                {
                    ApplicationArea = all;
                    Caption = 'Overview by &Categories';
                    RunObject = Page "Rec. Absence Overview by Cat.";
                    RunPageLink = "Employee No. Filter" = FIELD("Employee No.");
                }
                /*GL2024   action("Overview by &Periods")
                   {
                       ApplicationArea = all;
                       Caption = 'Overview by &Periods';
                       //RunObject = Page " Rec. Abs. Overview by Periods";
                   }*/
            }
        }
    }

    var
        // R39001422: Report 77022;
        EmplDaysOffEntry: Record "Employee's days off Entry";
}

