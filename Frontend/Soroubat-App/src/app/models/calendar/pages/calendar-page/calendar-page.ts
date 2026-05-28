import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { MatIconModule } from '@angular/material/icon';

interface CalendarEvent {
  id: string;
  title: string;
  date: Date;
  type: string;
  description?: string;
  time?: string;
  notification?: boolean;
}

interface CalendarDay {
  date: Date | null;
  isToday: boolean;
  events: CalendarEvent[];
}

interface Notification {
  id: string;
  event: CalendarEvent;
  date: Date;
}

@Component({
  selector: 'app-calendar-page',
  standalone: true,
  imports: [CommonModule, FormsModule, MatIconModule],
  templateUrl: './calendar-page.html',
  styleUrls: ['./calendar-page.scss']
})
export class CalendarPageComponent implements OnInit, OnDestroy {
  
  // Vue actuelle
  currentView: 'month' | 'week' = 'month';
  
  // Dates
  currentYear: number = new Date().getFullYear();
  currentMonth: number = new Date().getMonth();
  currentMonthName: string = '';
  currentWeekStart: Date = new Date();
  
  weekDays: string[] = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  hourSlots: number[] = Array.from({ length: 24 }, (_, i) => i);
  
  calendarDays: CalendarDay[] = [];
  weekEvents: { [key: string]: CalendarEvent[] } = {};
  
  selectedDate: Date | null = null;
  selectedDateEvents: CalendarEvent[] = [];
  
  // Recherche
  searchTerm: string = '';
  searchResults: CalendarEvent[] = [];
  
  // Notifications
  showNotifications: boolean = false;
  pendingNotifications: Notification[] = [];
  private notificationInterval: any;
  
  // Statistiques
  totalTasks: number = 0;
  totalAttendance: number = 0;
  totalPurchases: number = 0;
  totalOverdue: number = 0;
  hasPendingNotifications: boolean = false;
  
  // Modal
  showModal: boolean = false;
  editingEvent: CalendarEvent | null = null;
  formData: any = {
    title: '',
    type: 'task',
    description: '',
    date: '',
    time: '',
    notification: false
  };
  
  eventTypes = [
    { value: 'task', label: 'Tâche', icon: 'assignment_turned_in' },
    { value: 'attendance', label: 'Présence', icon: 'people' },
    { value: 'purchase', label: 'Commande', icon: 'shopping_bag' },
    { value: 'event', label: 'Événement', icon: 'celebration' },
    { value: 'overdue', label: 'Urgence', icon: 'priority_high' }
  ];
  
  private events: CalendarEvent[] = [];

  ngOnInit(): void {
    this.loadEvents();
    this.initCalendar();
    this.initWeek();
    this.startNotificationChecker();
  }

  ngOnDestroy(): void {
    if (this.notificationInterval) {
      clearInterval(this.notificationInterval);
    }
  }

  // ==================== Gestion des événements ====================
  
  private loadEvents(): void {
    const saved = localStorage.getItem('calendar_events');
    if (saved) {
      this.events = JSON.parse(saved).map((e: any) => ({
        ...e,
        date: new Date(e.date)
      }));
    }
    this.updateStats();
    this.checkNotifications();
  }

  private saveEvents(): void {
    localStorage.setItem('calendar_events', JSON.stringify(this.events));
    this.updateStats();
    this.checkNotifications();
    this.initCalendar();
    this.initWeek();
    this.updateSelectedDateEvents();
  }

  private updateStats(): void {
    this.totalTasks = this.events.filter(e => e.type === 'task').length;
    this.totalAttendance = this.events.filter(e => e.type === 'attendance').length;
    this.totalPurchases = this.events.filter(e => e.type === 'purchase').length;
    this.totalOverdue = this.events.filter(e => e.type === 'overdue').length;
  }

  // ==================== Calendrier Mois ====================
  
  private initCalendar(): void {
    this.currentMonthName = this.getMonthName(this.currentMonth);
    this.generateCalendarDays();
    this.updateSelectedDateEvents();
  }

  private getMonthName(month: number): string {
    const months = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
                    'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
    return months[month];
  }

  private generateCalendarDays(): void {
    const firstDayOfMonth = new Date(this.currentYear, this.currentMonth, 1);
    let startDay = firstDayOfMonth.getDay();
    startDay = startDay === 0 ? 6 : startDay - 1;
    
    const daysInMonth = new Date(this.currentYear, this.currentMonth + 1, 0).getDate();
    
    this.calendarDays = [];
    const today = new Date();
    
    // Jours précédents
    const prevMonthDays = new Date(this.currentYear, this.currentMonth, 0).getDate();
    for (let i = startDay - 1; i >= 0; i--) {
      const date = new Date(this.currentYear, this.currentMonth - 1, prevMonthDays - i);
      this.calendarDays.push({
        date: date,
        isToday: false,
        events: this.getEventsForDate(date)
      });
    }
    
    // Jours du mois
    for (let day = 1; day <= daysInMonth; day++) {
      const date = new Date(this.currentYear, this.currentMonth, day);
      this.calendarDays.push({
        date: date,
        isToday: this.isSameDate(date, today),
        events: this.getEventsForDate(date)
      });
    }
    
    // Jours suivants
    const remainingDays = 42 - this.calendarDays.length;
    for (let day = 1; day <= remainingDays; day++) {
      const date = new Date(this.currentYear, this.currentMonth + 1, day);
      this.calendarDays.push({
        date: date,
        isToday: false,
        events: []
      });
    }
  }

  private getEventsForDate(date: Date): CalendarEvent[] {
    return this.events.filter(event => 
      event.date.getDate() === date.getDate() &&
      event.date.getMonth() === date.getMonth() &&
      event.date.getFullYear() === date.getFullYear()
    );
  }

  private isSameDate(date1: Date, date2: Date): boolean {
    return date1.getDate() === date2.getDate() &&
           date1.getMonth() === date2.getMonth() &&
           date1.getFullYear() === date2.getFullYear();
  }

  private updateSelectedDateEvents(): void {
    if (this.selectedDate) {
      this.selectedDateEvents = this.getEventsForDate(this.selectedDate);
    }
  }

  selectDate(day: CalendarDay): void {
    if (day.date) {
      this.selectedDate = day.date;
      this.updateSelectedDateEvents();
    }
  }

  previousMonth(): void {
    if (this.currentMonth === 0) {
      this.currentMonth = 11;
      this.currentYear--;
    } else {
      this.currentMonth--;
    }
    this.initCalendar();
  }

  nextMonth(): void {
    if (this.currentMonth === 11) {
      this.currentMonth = 0;
      this.currentYear++;
    } else {
      this.currentMonth++;
    }
    this.initCalendar();
  }

  goToToday(): void {
    const today = new Date();
    this.currentYear = today.getFullYear();
    this.currentMonth = today.getMonth();
    this.initCalendar();
    
    const todayDay = this.calendarDays.find(day => day.isToday);
    if (todayDay) {
      this.selectDate(todayDay);
    }
  }

  // ==================== Vue Semaine ====================
  
  setView(view: 'month' | 'week'): void {
    this.currentView = view;
    if (view === 'week') {
      this.initWeek();
    }
  }

  private initWeek(): void {
    const today = this.selectedDate || new Date();
    const dayOfWeek = today.getDay();
    const startOffset = dayOfWeek === 0 ? 6 : dayOfWeek - 1;
    this.currentWeekStart = new Date(today);
    this.currentWeekStart.setDate(today.getDate() - startOffset);
    this.generateWeekEvents();
  }

  private generateWeekEvents(): void {
    this.weekEvents = {};
    for (let i = 0; i < 7; i++) {
      const date = new Date(this.currentWeekStart);
      date.setDate(this.currentWeekStart.getDate() + i);
      const key = date.toDateString();
      this.weekEvents[key] = this.getEventsForDate(date);
    }
  }

  getWeekRange(): string {
    const start = new Date(this.currentWeekStart);
    const end = new Date(this.currentWeekStart);
    end.setDate(start.getDate() + 6);
    return `${start.getDate()} ${this.getMonthName(start.getMonth())} - ${end.getDate()} ${this.getMonthName(end.getMonth())} ${end.getFullYear()}`;
  }

  getWeekDayDate(dayName: string): string {
    const index = this.weekDays.indexOf(dayName);
    const date = new Date(this.currentWeekStart);
    date.setDate(this.currentWeekStart.getDate() + index);
    return `${date.getDate()}/${date.getMonth() + 1}`;
  }

  getWeekDate(index: number, hour: number): Date {
    const date = new Date(this.currentWeekStart);
    date.setDate(this.currentWeekStart.getDate() + index);
    if (hour !== undefined) {
      date.setHours(hour, 0, 0, 0);
    }
    return date;
  }

  getEventsAtSlot(date: Date): CalendarEvent[] {
    const key = date.toDateString();
    const events = this.weekEvents[key] || [];
    const hour = date.getHours();
    return events.filter(e => {
      if (!e.time) return false;
      const eventHour = parseInt(e.time.split(':')[0]);
      return eventHour === hour;
    });
  }

  getEventTime(event: CalendarEvent): string {
    return event.time || 'Toute la journée';
  }

  previousWeek(): void {
    this.currentWeekStart.setDate(this.currentWeekStart.getDate() - 7);
    this.generateWeekEvents();
  }

  nextWeek(): void {
    this.currentWeekStart.setDate(this.currentWeekStart.getDate() + 7);
    this.generateWeekEvents();
  }

  openAddEventAtSlot(date: Date): void {
  //  Utiliser la même méthode de formatage
  const formattedDate = this.formatDateForInput(date);
  const hour = date.getHours();
  
  this.formData = {
    title: '',
    type: 'task',
    description: '',
    date: formattedDate,
    time: `${hour.toString().padStart(2, '0')}:00`,
    notification: false
  };
  this.editingEvent = null;
  this.showModal = true;
}

  // ==================== CRUD Événements ====================
  
  openAddEventDialog(): void {
  // S'assurer qu'on a une date sélectionnée
  let defaultDate = this.selectedDate;
  
  if (!defaultDate) {
    defaultDate = new Date();
    this.selectedDate = defaultDate;
  }
  
  //  Utiliser la méthode existante pour formater la date
  const formattedDate = this.formatDateForInput(defaultDate);
  
  console.log(' Date sélectionnée:', defaultDate);
  console.log(' Date formatée:', formattedDate);
  
  this.formData = {
    title: '',
    type: 'task',
    description: '',
    date: formattedDate,  //  Utiliser la méthode existante
    time: '',
    notification: false
  };
  this.editingEvent = null;
  this.showModal = true;
}

  editEvent(event: CalendarEvent): void {
    this.editingEvent = event;
    this.formData = {
      title: event.title,
      type: event.type,
      description: event.description || '',
      date: this.formatDateForInput(event.date),
      time: event.time || '',
      notification: event.notification || false
    };
    this.showModal = true;
  }

  saveEvent(): void {
    if (!this.formData.title.trim()) {
      alert('Veuillez saisir un titre');
      return;
    }
    
    if (!this.formData.date) {
      alert('Veuillez sélectionner une date');
      return;
    }
    
    const eventDate = new Date(this.formData.date);
    
    if (this.editingEvent) {
      // Modification
      this.editingEvent.title = this.formData.title;
      this.editingEvent.type = this.formData.type;
      this.editingEvent.description = this.formData.description;
      this.editingEvent.date = eventDate;
      this.editingEvent.time = this.formData.time;
      this.editingEvent.notification = this.formData.notification;
    } else {
      // Ajout
      const newEvent: CalendarEvent = {
        id: Date.now().toString(),
        title: this.formData.title,
        type: this.formData.type,
        description: this.formData.description,
        date: eventDate,
        time: this.formData.time,
        notification: this.formData.notification
      };
      this.events.push(newEvent);
    }
    
    this.saveEvents();
    this.closeModal();
  }

  deleteEvent(event: CalendarEvent): void {
    if (confirm(`Supprimer "${event.title}" ?`)) {
      this.events = this.events.filter(e => e.id !== event.id);
      this.saveEvents();
    }
  }

  goToEvent(event: CalendarEvent): void {
    this.currentYear = event.date.getFullYear();
    this.currentMonth = event.date.getMonth();
    this.selectedDate = event.date;
    this.initCalendar();
    this.setView('month');
    this.showNotifications = false;
  }

  goToEventDate(event: CalendarEvent): void {
    this.goToEvent(event);
    this.clearSearch();
  }

  // ==================== Recherche ====================
  
  onSearch(): void {
    if (this.searchTerm.trim() === '') {
      this.searchResults = [];
      return;
    }
    
    const term = this.searchTerm.toLowerCase();
    this.searchResults = this.events.filter(event =>
      event.title.toLowerCase().includes(term) ||
      (event.description && event.description.toLowerCase().includes(term))
    );
  }

  clearSearch(): void {
    this.searchTerm = '';
    this.searchResults = [];
  }

  // ==================== Filtres ====================
  
  filterByType(type: string): void {
    const today = new Date();
    this.selectedDate = today;
    this.selectedDateEvents = this.getEventsForDate(today).filter(e => e.type === type);
    this.setView('month');
  }

  // ==================== Notifications ====================
  
  private startNotificationChecker(): void {
    this.notificationInterval = setInterval(() => {
      this.checkNotifications();
    }, 60000); // Vérifier chaque minute
  }

  private checkNotifications(): void {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    const newNotifications: Notification[] = [];
    
    this.events.forEach(event => {
      if (event.notification) {
        const eventDate = new Date(event.date);
        eventDate.setHours(0, 0, 0, 0);
        
        const diffDays = Math.ceil((eventDate.getTime() - today.getTime()) / (1000 * 3600 * 24));
        
        // Notification 1 jour avant
        if (diffDays === 1) {
          const existingNotif = this.pendingNotifications.find(n => n.event.id === event.id);
          if (!existingNotif) {
            newNotifications.push({
              id: `notif_${event.id}_${Date.now()}`,
              event: event,
              date: new Date()
            });
          }
        }
      }
    });
    
    if (newNotifications.length > 0) {
      this.pendingNotifications = [...this.pendingNotifications, ...newNotifications];
      this.hasPendingNotifications = true;
      
      // Afficher automatiquement les notifications pendant 5 secondes
      this.showNotifications = true;
      setTimeout(() => {
        if (this.showNotifications) {
          this.showNotifications = false;
        }
      }, 5000);
    }
  }

  toggleNotifications(): void {
    this.showNotifications = !this.showNotifications;
    if (this.showNotifications) {
      this.hasPendingNotifications = false;
    }
  }

  getRelativeDate(date: Date): string {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const eventDate = new Date(date);
    eventDate.setHours(0, 0, 0, 0);
    
    const diffDays = Math.ceil((eventDate.getTime() - today.getTime()) / (1000 * 3600 * 24));
    
    if (diffDays === 0) return "Aujourd'hui";
    if (diffDays === 1) return "Demain";
    if (diffDays === -1) return "Hier";
    if (diffDays > 1) return `Dans ${diffDays} jours`;
    return `Il y a ${Math.abs(diffDays)} jours`;
  }

  // ==================== Utilitaires ====================
  
  formatDate(date: Date): string {
    return date.toLocaleDateString('fr-FR', { day: 'numeric', month: 'long', year: 'numeric' });
  }
  formatDateForInput(date: Date): string {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}

  getDayInfo(date: Date): string {
    const days = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];
    return days[date.getDay()];
  }

  getEventIcon(type: string): string {
    const icons: any = {
      task: 'assignment_turned_in',
      attendance: 'people',
      purchase: 'shopping_bag',
      event: 'celebration',
      overdue: 'priority_high'
    };
    return icons[type] || 'event';
  }

  getEventTypeLabel(type: string): string {
    const labels: any = {
      task: 'Tâche',
      attendance: 'Présence',
      purchase: 'Commande',
      event: 'Événement',
      overdue: 'Urgence'
    };
    return labels[type] || 'Événement';
  }

  closeModal(): void {
    this.showModal = false;
    this.editingEvent = null;
  }
}