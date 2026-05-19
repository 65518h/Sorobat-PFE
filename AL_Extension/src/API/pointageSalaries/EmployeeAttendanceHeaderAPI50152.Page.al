page 50152 "EmpAttendanceHeaderAPI"
{
    PageType = API;
    Caption = 'employeeAttendanceHeader';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'employeeAttendanceHeader';
    EntitySetName = 'employeeAttendanceHeaders';
    SourceTable = "Entete Pointage Salarier Man";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId) 
            {
                Caption = 'Id';
                Editable = false;
            }
                field(no; Rec."N°") { Caption = 'No'; }
                field(month; Rec.Mois) { Caption = 'Month'; }
                field(year; Rec."Année") { Caption = 'Year'; }
                field(jobNo; Rec.Chantier) { Caption = 'Job No'; }
                field(totalStaff; Rec."Total Effectif") { Caption = 'Total Staff'; }
            }
            part(employeeAttendanceLines; "EmpAttendanceLineAPI")
            {
                Caption = 'Lines';
                EntityName = 'employeeAttendanceLine';
                EntitySetName = 'employeeAttendanceLines';
                SubPageLink = "N°" = field("N°"); 
            }
        }
    }
}