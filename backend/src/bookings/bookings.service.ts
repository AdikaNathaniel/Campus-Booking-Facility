import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Booking } from './entities/booking.entity';
import { CreateBookingDto } from './dto/create-booking.dto';
import { UpdateBookingDto } from './dto/update-booking.dto';

@Injectable()
export class BookingsService {
  constructor(
    @InjectRepository(Booking)
    private readonly bookingRepo: Repository<Booking>,
  ) {}

  create(dto: CreateBookingDto): Promise<Booking> {
    const booking = this.bookingRepo.create(dto);
    return this.bookingRepo.save(booking);
  }

  findAll(): Promise<Booking[]> {
    return this.bookingRepo.find({ relations: ['facility', 'user'] });
  }

  async findOne(id: number): Promise<Booking> {
    const booking = await this.bookingRepo.findOne({
      where: { id },
      relations: ['facility', 'user'],
    });
    if (!booking) throw new NotFoundException(`Booking #${id} not found`);
    return booking;
  }

  async update(id: number, dto: UpdateBookingDto): Promise<Booking> {
    await this.findOne(id);
    await this.bookingRepo.update(id, dto);
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    const booking = await this.findOne(id);
    await this.bookingRepo.remove(booking);
  }
}
