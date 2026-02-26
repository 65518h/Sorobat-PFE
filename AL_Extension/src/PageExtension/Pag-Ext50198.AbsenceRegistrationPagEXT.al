PageExtension 50198 "Absence Registration_PagEXT" extends "Absence Registration"

{

    layout
    {

        addbefore(Control1)
        {
            field(Afficher; TypeAff)
            {
                Caption = 'Afficher :';
                ApplicationArea = all;

                trigger OnValidate()
                begin

                    if TypeAff = TypeAff::"Par Utilisateur" then
                        rec.SETRANGE("User ID", USERID)
                    else
                        rec.SETFILTER("User ID", '<>''''');
                    CurrPage.UPDATE;
                end;

            }
        }

        addafter("Employee No.")
        {
            field(Nom; Rec.Nom)
            {
                ApplicationArea = all;
            }
            field(prenom; Rec.prenom)
            {
                ApplicationArea = all;
            }
            field("Droit Conge"; Rec."Droit Conge")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

        addafter("Cause of Absence Code")
        {
            field(Quinzainea; Rec.Quinzainea)
            {
                ApplicationArea = all;
            }
            field("Motif D'absence"; Rec."Motif D'absence")
            {
                ApplicationArea = all;
            }
            field(Unit; Rec.Unit)
            {
                ApplicationArea = all;
            }
        }
        addafter(Quantity)
        {
            field("Posting month"; Rec."Posting month")
            {
                ApplicationArea = all;
            }
            field("Posting year"; Rec."Posting year")
            {
                ApplicationArea = all;
            }
            field("Quantity en Hours"; Rec."Quantity en Hours")
            {
                ApplicationArea = all;
            }
            field("Line type"; Rec."Line type")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Recuperation Entry No."; Rec."Recuperation Entry No.")
            {
                ApplicationArea = all;

            }
        }
    }
    actions
    {


        addafter("A&bsence")
        {
            group("&Validation")
            {
                Caption = 'validation';
                action("Impression test")
                {
                    ApplicationArea = all;
                    Caption = 'Impression test';
                    Promoted = true;

                    trigger OnAction()
                    begin
                        REPORT.RUN(Report::"Employee - Absences by Causes", TRUE, TRUE, EmployeeAbsence)
                    end;
                }
                action("&Valider")
                {
                    ApplicationArea = all;
                    Caption = 'Valider';
                    Promoted = true;
                    trigger OnAction()
                    begin

                        EmployeeAbsence.RESET;
                        EmployeeAbsence.COPYFILTERS(Rec);
                        IF EmployeeAbsence.FIND('-') THEN BEGIN
                            //     HumanRessource.ValidAbsence(EmployeeAbsence);
                        END;
                    end;
                }
                action("Valider et i&mprimer")
                {
                    ApplicationArea = all;
                    Caption = 'Valider et &Imprimer';
                    Promoted = true;
                    trigger OnAction()
                    begin

                        EmployeeAbsence.RESET;
                        EmployeeAbsence.COPYFILTERS(Rec);
                        IF EmployeeAbsence.FIND('-') THEN
                            HumanRessource.ValidAbsence(EmployeeAbsence);
                    end;
                }


            }

        }
    }
    trigger OnOpenPage()
    begin
        rec.SETRANGE("User ID", USERID);
    end;

    trigger OnAfterGetRecord()
    begin
        IF TypeAff = 0 THEN
            rec.SETRANGE("User ID", USERID)
        ELSE
            rec.SETFILTER("User ID", '<>''''');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."User ID" := USERID;
    end;

    var
        HumRessSetup: Record "Human Resources Setup";
        HumanRessource: Codeunit "Management of absences";
        Saved: Record "Employee's days off Entry";
        EmployeeAbsence: Record "Employee Absence";
        TypeAff: Option "Par Utilisateur",Tous;
        Empl: Record Employee;
        NonPayed1: ARRAY[3] OF Decimal;
        DroitCong1: ARRAY[3] OF Decimal;
        ConSCong1: ARRAY[3] OF Decimal;
        SoldeCong1: ARRAY[3] OF Decimal;
        RecDetailConge: Record "Detail de congé consommé";
        DecResteCons: Decimal;
        i: Integer;
        conf: Label '#1 lines selected.\Are you sure to want to validate the selected lines ?';
        noReportMs: Label 'No report indicated in Human Ressource Setup.';

}