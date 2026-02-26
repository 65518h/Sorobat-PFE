Page 50291 "Affectation Salarié"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Employee;
    SourceTableView = where(Blocked = const(false), BR = const(false));
    ApplicationArea = all;
    Caption = 'Affectation Salarié';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("First And Last Name"; REC."First Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                // field(Chantier; REC.Chantier)
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }
                // field(Affectation; REC.Affectation)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field(Horaire; REC.Horaire)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Heure / Jour"; REC."Heure / Jour")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("SeuilHeure Sup"; REC."SeuilHeure Sup")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Departement Salarié"; REC."Departement Salarié")
                // {
                //     ApplicationArea = all;
                // }
                field("Description Departement"; REC."Description Departement")
                {
                    ApplicationArea = all;
                }
                // field(Service; REC.Service)
                // {
                //     ApplicationArea = all;
                // }
                // field(Service; REC.Service)
                // {
                //     ApplicationArea = all;
                // }
                field("Description Service"; REC."Description Service")
                {
                    ApplicationArea = all;
                }
                // field("En Deplacement"; REC."En Deplacement")
                // {
                //     ApplicationArea = all;
                // }
            }
        }
    }

    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        IF HumanResourcesSetup.GET THEN;
        //  IF HumanResourcesSetup."Filtre Departement" <> '' THEN rec.SETRANGE("Departement Salarié", HumanResourcesSetup."Filtre Departement");
    end;

    trigger OnOpenPage()
    begin
        IF HumanResourcesSetup.GET THEN;
        //   IF HumanResourcesSetup."Filtre Departement" <> '' THEN rec.SETRANGE("Departement Salarié", HumanResourcesSetup."Filtre Departement");

        /*   RecEmployee.SetRange(Zone, 'C');
           RecEmployee.SetRange(Blocked, false);
           RecEmployee.SetRange("Heure / Jour", 0);
           if RecEmployee.FindFirst then
               repeat
                   if EmploymentContract.Get(RecEmployee."No.") then
                       if RegimeOfWork.Get(EmploymentContract."Regimes of work") then begin
                           RecEmployee.Horaire := true;
                           RecEmployee."Heure / Jour" := RegimeOfWork."Nombre Heure Par Jour";
                           RecEmployee.Modify;
                       end;
               until RecEmployee.Next = 0;
           if UserSetup.Get(UpperCase(UserId)) then
               if UserSetup."Affaire Par Defaut" <> '' then REC.SetFilter(Chantier, UserSetup."Affaire Par Defaut" + '*');*/
    end;

    var
        HumanResourcesSetup: Record "Human Resources Setup";
        RecEmployee: Record Employee;
        EmploymentContract: Record "Employment Contract";
        RegimeOfWork: record "Regimes of work";
        UserSetup: Record "User Setup";

}

