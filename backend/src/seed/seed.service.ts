import { Injectable, OnModuleInit, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Facility } from '../facilities/entities/facility.entity';
import { User } from '../users/entities/user.entity';
import { Booking } from '../bookings/entities/booking.entity';

@Injectable()
export class SeedService implements OnModuleInit {
  private readonly logger = new Logger(SeedService.name);

  constructor(
    @InjectRepository(Facility) private facilityRepo: Repository<Facility>,
    @InjectRepository(User) private userRepo: Repository<User>,
    @InjectRepository(Booking) private bookingRepo: Repository<Booking>,
  ) {}

  async onModuleInit() {
    await this.seed();
  }

  private async seed() {
    const facilityCount = await this.facilityRepo.count();
    if (facilityCount > 0) {
      this.logger.log('Database already seeded, skipping...');
      return;
    }

    const facilities = await this.facilityRepo.save([
      { name: 'Balme Library', location: 'Main Campus, Near Great Hall', capacity: 600 },
      { name: 'JQB Auditorium', location: 'Department of Computer Science, JQB Building', capacity: 250 },
      { name: 'UGCS Computer Lab', location: 'Department of Computer Science, Ground Floor', capacity: 80 },
      { name: 'Great Hall', location: 'Main Campus, University Avenue', capacity: 1500 },
      { name: 'New N Block Lecture Hall', location: 'Science Campus, N Block', capacity: 400 },
    ]);

    const users = await this.userRepo.save([
      { name: 'Nathaniel Adika', email: 'nathaniel.adika@ug.edu.gh', role: 'admin' },
      { name: 'Emmanuel Adika', email: 'emmanuel.adika@st.ug.edu.gh', role: 'student' },
      { name: 'Grace Adika', email: 'grace.adika@ug.edu.gh', role: 'faculty' },
      { name: 'Daniel Adika', email: 'daniel.adika@st.ug.edu.gh', role: 'student' },
      { name: 'Priscilla Adika', email: 'priscilla.adika@ug.edu.gh', role: 'faculty' },
    ]);

    await this.bookingRepo.save([
      {
        facilityId: facilities[0].id,
        userId: users[0].id,
        date: '2026-03-15',
        startTime: '09:00',
        endTime: '12:00',
        status: 'confirmed',
      },
      {
        facilityId: facilities[1].id,
        userId: users[1].id,
        date: '2026-03-16',
        startTime: '14:00',
        endTime: '16:00',
        status: 'confirmed',
      },
      {
        facilityId: facilities[2].id,
        userId: users[2].id,
        date: '2026-03-17',
        startTime: '08:00',
        endTime: '10:00',
        status: 'pending',
      },
      {
        facilityId: facilities[3].id,
        userId: users[3].id,
        date: '2026-03-20',
        startTime: '10:00',
        endTime: '13:00',
        status: 'confirmed',
      },
      {
        facilityId: facilities[4].id,
        userId: users[0].id,
        date: '2026-03-22',
        startTime: '15:00',
        endTime: '17:00',
        status: 'pending',
      },
    ]);

    this.logger.log('Database seeded successfully');
  }
}
