import { IsString, IsInt, IsNotEmpty, Min } from 'class-validator';

export class CreateFacilityDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  location: string;

  @IsInt()
  @Min(1)
  capacity: number;
}
