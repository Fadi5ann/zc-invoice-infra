import { Controller, Get, HttpCode, HttpStatus } from '@nestjs/common';
import { Public } from './shared/auth/utils/public-strategy';

@Controller('health')
export class AppController {
  
  @Get()
  @HttpCode(HttpStatus.OK)
  @Public() // Ensures global authentication guards ignore this route
  getHealth(): string {
    return 'OK';
  }
}
