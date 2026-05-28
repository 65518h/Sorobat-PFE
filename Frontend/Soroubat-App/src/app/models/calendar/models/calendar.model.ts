export interface CalendarEvent {
  id: string;
  title: string;
  date: Date;
  type: 'task' | 'attendance' | 'purchase' | 'event' | 'overdue';
  typeLabel: string;
  icon: string;
  description?: string;
  status: string;
  statusLabel: string;
  link?: string;
}

export interface CalendarDay {
  date: Date | null;
  isToday: boolean;
  events: CalendarEvent[];
  isEmpty: boolean;
}