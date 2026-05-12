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
                field(totalPresent; Rec."Total Present") { Caption = 'Total Present'; }
                field(attendanceRate; Rec."Taux Present") { Caption = 'Attendance Rate'; }
                field(totalAbsentJustified; Rec."Total Absent Justifie") { Caption = 'Total Absent Justified'; }
                field(absenceRate; Rec."Taux Absence") { Caption = 'Absence Rate'; }
                field(thresholdDays; Rec."Seuil Jours de Pointage") { Caption = 'Threshold Days'; }
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