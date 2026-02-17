import { IsInt, IsString, IsNotEmpty, IsOptional } from 'class-validator';

export class CreateBookingDto {
  @IsInt()
  facilityId: number;

  @IsInt()
  userId: number;

  @IsString()
  @IsNotEmpty()
  date: string;

  @IsString()
  @IsNotEmpty()
  startTime: string;

  @IsString()
  @IsNotEmpty()
  endTime: string;

  @IsString()
  @IsOptional()
  status?: string;
}
