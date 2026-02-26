page 52048918 "Employee's days off Entry"
{
    //GL2024  ID dans Nav 2009 : "39001439"
    Caption = 'Absences salariés enregistrées';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Employee's days off Entry";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Tab)
            {
                ShowCaption = false;
                field("Transaction No."; rec."Transaction No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Line type"; rec."Line type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Unit; rec.Unit)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Nom; rec.Nom)
                {
                    ApplicationArea = all;
                }
                field("Motif D'absence"; rec."Motif D'absence")
                {
                    ApplicationArea = all;
                }
                field(prenom; rec.prenom)
                {
                    ApplicationArea = all;
                }
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                }





                field("Employee No.1"; rec."Employee No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("From Date"; rec."From Date")
                {
                    ApplicationArea = all;

                    Editable = false;
                }
                field("To Date"; rec."To Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(section; rec.section)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Montant Ligne"; rec."Montant Ligne")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Cause of Absence Code"; rec."Cause of Absence Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Unit1; rec.Unit)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting month"; rec."Posting month")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting year"; rec."Posting year")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Line type1"; rec."Line type")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Quantity (Days)"; rec."Quantity (Days)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Quantity (Hours)"; rec."Quantity (Hours)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Payment No."; rec."Payment No.")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Montant Ligne1"; rec."Montant Ligne")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Motif D'absence1"; rec."Motif D'absence")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Quinzaine; rec.Quinzaine)
                {
                    ApplicationArea = all;
                }
                field(Comment; rec.Comment)
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
                actionref("Impimer Titre de conngés1"; "Impimer Titre de conngés") { }
            }
            group("A&bsence1")
            {
                Caption = 'A&bsence';
                actionref("Co&mments1"; "Co&mments") { }
                actionref("Overview by &Categories1"; "Overview by &Categories") { }
                actionref("Overview by &Periods1"; "Overview by &Periods") { }
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
                    Caption = 'Dévalider';

                    trigger OnAction()
                    var
                        HumanRessource: Codeunit "Management of absences";
                        Saved: Record "Employee's days off Entry";
                        conf: Label 'Are sur to unvalidate the selected lines.';
                    begin
                        CurrPage.SETSELECTIONFILTER(Saved);
                        Saved.SETFILTER(Comptabiliser, '%1', FALSE);
                        IF Saved.FIND('-') THEN
                            IF CONFIRM(conf) THEN
                                REPEAT
                                    HumanRessource.UnValidateEmployeeAbsence(Saved);
                                UNTIL Saved.NEXT = 0;
                    end;
                }
                separator(separator100)
                {
                }
                action("Impimer Titre de conngés")
                {
                    ApplicationArea = all;
                    Caption = 'Impimer Titre de conngés';
                    Image = print;
                    Visible = false;

                    trigger OnAction()
                    var

                        EmplDaysOffEntry: Record "Employee's days off Entry";
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
                    RunPageLink = "Table Name" = CONST(7), "Table Line No." = FIELD("Entry No."), "No." = FIELD("Employee No.");
                }
                separator(separator200)
                {
                }
                action("Overview by &Categories")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Caption = 'Overview by &Categories';
                    RunObject = page "Rec. Absence Overview by Cat.";
                    RunPageLink = "Employee No. Filter" = FIELD("Employee No.");
                }
                action("Overview by &Periods")
                {
                    ApplicationArea = all;
                    Caption = 'Overview by &Periods';
                    Visible = false;
                    RunObject = page "Rec. Abs. Overview by Periods";
                }
            }
        }
    }



}

