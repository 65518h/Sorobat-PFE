Codeunit 52048880 "Upgrading Employees"
{
    //GL2024  ID dans Nav 2009 : "39001411"
    trigger OnRun()
    begin
        Employee.SetFilter(Catégorie, '<>%1', '');
        Employee.SetFilter(Echelons, '<>%1', '0');
        Employee.SetRange("Upgrading date Cat/Echelon", 0D, WorkDate);
        if Employee.Find('-') then
            REPORT.RUN(REPORT::"Recupérer Sursalaire AV Prime", TRUE, TRUE, Employee)
        else
            Message('Pas de Salariés dans le filtre');
    end;

    var
        Employee: Record Employee;
}

