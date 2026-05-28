page 50153 "EmpAttendanceLineAPI"
{
    PageType = API;
    Caption = 'employeeAttendanceLine';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'employeeAttendanceLine';
    EntitySetName = 'employeeAttendanceLines';
    SourceTable = "Ligne Pointage Salarier Man";
    DelayedInsert = true;
    ODataKeyFields =SystemId;

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
                field(documentNo; Rec."N°") { Caption = 'Document No'; }
                field(employeeNo; Rec.Matricule) { Caption = 'Employee No'; }
                field(employeeName; Rec.Nom) { Caption = 'Employee Name'; }
                field(assignment; Rec.Affectation) { Caption = 'Assignment'; }
                field(assignmentDescription; Rec."Description affectation") { Caption = 'assignmentDescription'; }
                
                field(day1; Rec."1") { Caption = 'Day 1'; }
                field(day2; Rec."2") { Caption = 'Day 2'; }
                field(day3; Rec."3") { Caption = 'Day 3'; }
                field(day4; Rec."4") { Caption = 'Day 4'; }
                field(day5; Rec."5") { Caption = 'Day 5'; }
                field(day6; Rec."6") { Caption = 'Day 6'; }
                field(day7; Rec."7") { Caption = 'Day 7'; }
                field(day8; Rec."8") { Caption = 'Day 8'; }
                field(day9; Rec."9") { Caption = 'Day 9'; }
                field(day10; Rec."10") { Caption = 'Day 10'; }
                field(day11; Rec."11") { Caption = 'Day 11'; }
                field(day12; Rec."12") { Caption = 'Day 12'; }
                field(day13; Rec."13") { Caption = 'Day 13'; }
                field(day14; Rec."14") { Caption = 'Day 14'; }
                field(day15; Rec."15") { Caption = 'Day 15'; }
                field(day16; Rec."16") { Caption = 'Day 16'; }
                field(day17; Rec."17") { Caption = 'Day 17'; }
                field(day18; Rec."18") { Caption = 'Day 18'; }
                field(day19; Rec."19") { Caption = 'Day 19'; }
                field(day20; Rec."20") { Caption = 'Day 20'; }
                field(day21; Rec."21") { Caption = 'Day 21'; }
                field(day22; Rec."22") { Caption = 'Day 22'; }
                field(day23; Rec."23") { Caption = 'Day 23'; }
                field(day24; Rec."24") { Caption = 'Day 24'; }
                field(day25; Rec."25") { Caption = 'Day 25'; }
                field(day26; Rec."26") { Caption = 'Day 26'; }
                field(day27; Rec."27") { Caption = 'Day 27'; }
                field(day28; Rec."28") { Caption = 'Day 28'; }
                field(day29; Rec."29") { Caption = 'Day 29'; }
                field(day30; Rec."30") { Caption = 'Day 30'; }
                field(day31; Rec."31") { Caption = 'Day 31'; }

                field(totalPresentDays; Rec."Nbre Jours Present") { Caption = 'Total Present Days'; }
                field(totalAbsentDays; Rec."Nbre Jours Absent") { Caption = 'Total Absent Days'; }
                field(totalHours; Rec."Nbre Total Heures Presnt") { Caption = 'Total Hours'; }
                field(totalCong; Rec."Nbre Jours Congé") { Caption = 'Total Congé'; }
                field(totalCongExp; Rec."Nbre Jours congé EXP") { Caption = 'Total congé EXP'; }
                field(totalFerier; Rec."Nbre Jours Ferier") { Caption = 'Total Ferier'; }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.CalculateTotals(); 
        exit(true);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.CalculateTotals();
        exit(true);
    end;
}