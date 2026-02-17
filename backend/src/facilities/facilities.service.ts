import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Facility } from './entities/facility.entity';
import { CreateFacilityDto } from './dto/create-facility.dto';
import { UpdateFacilityDto } from './dto/update-facility.dto';

@Injectable()
export class FacilitiesService {
  constructor(
    @InjectRepository(Facility)
    private readonly facilityRepo: Repository<Facility>,
  ) {}

  create(dto: CreateFacilityDto): Promise<Facility> {
    const facility = this.facilityRepo.create(dto);
    return this.facilityRepo.save(facility);
  }

  findAll(): Promise<Facility[]> {
    return this.facilityRepo.find();
  }

  async findOne(id: number): Promise<Facility> {
    const facility = await this.facilityRepo.findOneBy({ id });
    if (!facility) throw new NotFoundException(`Facility #${id} not found`);
    return facility;
  }

  async update(id: number, dto: UpdateFacilityDto): Promise<Facility> {
    await this.findOne(id);
    await this.facilityRepo.update(id, dto);
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    const facility = await this.findOne(id);
    await this.facilityRepo.remove(facility);
  }
}
