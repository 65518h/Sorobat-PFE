// src/app/modules/attendance/models/attendance.model.ts

export interface AttendanceHeader {
  id?: string;
  no?: string;
  month: string;
  year: number;
  jobNo: string;
  totalStaff?: number;
  attendanceRate?: number;
  isOffline?: boolean;
  employeeAttendanceLines?: AttendanceLine[];
  lines?: AttendanceLine[];
}

export interface AttendanceLine {
  id?: string;
  jobNo?: string;
  documentNo?: string;
  employeeNo: string;
  employeeName: string;
  assignment?: string;           // ✅ Affectation
  assignmentDescription?: string; // ✅ Description affectation
  // qualification?: string;     // ❌ À supprimer (non présent dans le backend)
  day1?: string;
  day2?: string;
  day3?: string;
  day4?: string;
  day5?: string;
  day6?: string;
  day7?: string;
  day8?: string;
  day9?: string;
  day10?: string;
  day11?: string;
  day12?: string;
  day13?: string;
  day14?: string;
  day15?: string;
  day16?: string;
  day17?: string;
  day18?: string;
  day19?: string;
  day20?: string;
  day21?: string;
  day22?: string;
  day23?: string;
  day24?: string;
  day25?: string;
  day26?: string;
  day27?: string;
  day28?: string;
  day29?: string;
  day30?: string;
  day31?: string;
  totalPresentDays?: number;
  totalAbsentDays?: number;
  totalHours?: number;
  totalCong?: number;      // ✅ Nouveau champ
  totalCongExp?: number;   // ✅ Nouveau champ
  totalFerier?: number;    // ✅ Nouveau champ
}

export interface CreateAttendanceHeader {
  month: string;
  year: number;
  jobNo: string;
}

export interface AttendanceStats {
  totalEmployees: number;
  totalPresent: number;
  totalAbsent: number;
  totalLeave: number;
  totalHoliday: number;
  attendanceRate: number;
}

export const AttendanceStatusCodes: Record<string, { label: string; color: string; icon: string; type: string }> = {
  'P':     { label: 'Présent', color: '#10b981', icon: 'check_circle', type: 'present' },
  'AU':    { label: 'Au travail', color: '#10b981', icon: 'work', type: 'present' },
  'P-R':   { label: 'Présent (récup)', color: '#10b981', icon: 'autorenew', type: 'present' },
  'MISS':  { label: 'Mission', color: '#3b82f6', icon: 'flight_takeoff', type: 'present' },
  'FOR':   { label: 'Formation', color: '#8b5cf6', icon: 'school', type: 'present' },
  'C':     { label: 'Congé', color: '#f59e0b', icon: 'beach_access', type: 'leave' },
  'F':     { label: 'Férié', color: '#ef4444', icon: 'celebration', type: 'holiday' },
  'A':     { label: 'Absent', color: '#ef4444', icon: 'block', type: 'absent' },
  'CEXP':  { label: 'Congé exceptionnel', color: '#f59e0b', icon: 'event_busy', type: 'leave' },
  'C1/2':  { label: 'Demi-journée', color: '#f59e0b', icon: 'hourglass_top', type: 'leave' },
  '':      { label: 'Non renseigné', color: '#9ca3af', icon: 'help_outline', type: 'empty' }
};

export function getAttendanceStatusInfo(code: string) {
  return AttendanceStatusCodes[code] || AttendanceStatusCodes[''];
}