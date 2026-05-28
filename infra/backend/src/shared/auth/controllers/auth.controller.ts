import {
  BadRequestException,
  InternalServerErrorException,
  Body,
  Controller,
  HttpCode,
  Post,
  Request,
  UseInterceptors,
  UnauthorizedException,
} from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { Public } from '../utils/public-strategy';
import { AuthService } from '../services/auth.service';
import { RefreshTokenDto as AuthRefreshTokenDto } from '../dtos/web/response-refresh-token';
import { ResponseSigninDto as AuthResponseSigninDto } from '../dtos/web/response-signin.dto';
import { RequestSignInDto as AuthRequestSignInDto } from '../dtos/web/request-signin.dto';
import { OAuthRequestDto as AuthOAuthRequestDto } from '../dtos/web/response-oauth.dto';
import { LogEvent } from '../../logger/decorators/log-event.decorator';
import { LogInterceptor } from '../../logger/decorators/logger.interceptor';
import { RequestResetTokenDto as AuthRequestResetTokenDto } from '../dtos/web/request-reset-token.dto';
import { ResponseResetTokenDto as AuthResponseResetTokenDto } from '../dtos/web/response-reset-token.dto';
import { RequestCheckResetTokenDto as AuthRequestCheckResetTokenDto } from '../dtos/web/request-check-reset-token.dto';
import { ResponseCheckResetTokenDto as AuthResponseCheckResetTokenDto } from '../dtos/web/response-check-reset-token.dto';
import { identifyUser } from '../../../modules/user-management/utils/identify-user';
import { UserEntity } from '../../../modules/user-management/entities/user.entity';
import { EVENT_TYPE } from '../../logger/enums/event-type.enum';
import { AdvancedRequest } from '../../../types';
import { RequestRegisterDto as AuthRequestRegisterDto } from '../dtos/web/request-register.dto';
import { ResponseRegisterDto as AuthResponseRegisterDto } from '../dtos/web/response-register.dto';

@ApiTags('auth')
@Controller({ path: '/contacts/auth' })
@UseInterceptors(LogInterceptor)
export class AuthController {
  constructor(private authService: AuthService) {}

  @Public()
  @Post('sign-in')
  @HttpCode(200)
  @ApiOperation({
    summary: 'Sign in a user',
    description: 'Authenticate user with email or username and password.',
  })
  @ApiResponse({
    status: 200,
    description: 'Successful sign in.',
    type: AuthResponseSigninDto,
  })
  @ApiResponse({ status: 401, description: 'Invalid credentials.' })
  @LogEvent(EVENT_TYPE.SIGNIN)
  async signIn(
    @Body() signInDto: AuthRequestSignInDto,
    @Request() req: AdvancedRequest,
  ): Promise<AuthResponseSigninDto> {
    if (!signInDto.usernameOrEmail || !signInDto.password) {
      throw new BadRequestException('Credentials are required');
    }

    const result = await this.authService.signin(
      signInDto.usernameOrEmail,
      signInDto.password,
    );

    if (!result?.user) {
      throw new UnauthorizedException(
        'User does not exist or invalid credentials',
      );
    }

    req.logInfo = {
      userId: result.user.id,
      fullname: identifyUser(result.user as unknown as UserEntity),
    };
    return result;
  }

  @Public()
  @Post('register')
  @HttpCode(201)
  @ApiOperation({
    summary: 'Register a user',
    description: 'Registre a new user',
  })
  @ApiResponse({
    status: 201,
    description: 'Successful registration.',
    type: AuthResponseRegisterDto,
  })
  @ApiResponse({ status: 400, description: 'Registration failed.' })
  @LogEvent(EVENT_TYPE.REGISTER)
  async register(
    @Body() registerDto: AuthRequestRegisterDto,
    @Request() req: AdvancedRequest,
  ): Promise<AuthResponseRegisterDto> {
    const result = await this.authService.register(registerDto);

    if (!result?.id) {
      throw new InternalServerErrorException(
        'An error occurred while registering a new account.',
      );
    }

    req.logInfo = {
      userId: result?.id,
      fullname: identifyUser(result as UserEntity),
    };
    return {
      user: result,
      message: 'You have successfully registered a new account.',
    };
  }

  @Public()
  @Post('oauth')
  @LogEvent(EVENT_TYPE.SIGNIN)
  @ApiOperation({
    summary: 'Handle OAuth sign-in/signup',
    description:
      'Accepts an ID token or access token from a supported OAuth provider and signs in or registers the user.',
  })
  @ApiResponse({
    status: 200,
    description: 'Successful OAuth sign in or registration.',
    type: AuthResponseSigninDto,
  })
  @ApiResponse({ status: 400, description: 'Missing or invalid OAuth data.' })
  async oauth(
    @Body() oauthDto: AuthOAuthRequestDto,
    @Request() req: AdvancedRequest,
  ): Promise<AuthResponseSigninDto> {
    const { provider, idToken } = oauthDto;
    if (!provider || !idToken) {
      throw new BadRequestException('Missing provider or idToken');
    }
    const result = await this.authService.handleOAuth(provider, idToken);

    if (!result?.user) {
      throw new UnauthorizedException('OAuth authentication failed');
    }

    req.logInfo = {
      userId: result.user.id,
      fullname: identifyUser(result.user as unknown as UserEntity),
    };

    return result;
  }

  @Public()
  @Post('refresh-token')
  @ApiOperation({
    summary: 'Refresh access token',
    description: 'Obtain a new access token using a valid refresh token.',
  })
  @ApiResponse({
    status: 200,
    description: 'Token successfully refreshed.',
    type: AuthResponseSigninDto,
  })
  @ApiResponse({
    status: 401,
    description: 'Invalid or expired refresh token.',
  })
  async refreshToken(
    @Body() body: AuthRefreshTokenDto,
  ): Promise<AuthResponseSigninDto> {
    return this.authService.refreshToken(body.refresh_token);
  }

  @Public()
  @Post('forgot-password')
  @ApiOperation({
    summary: 'Request password reset',
    description: 'Send an email with a link to reset the user password.',
  })
  @ApiResponse({ status: 200, description: 'Password reset email sent.' })
  @ApiResponse({ status: 400, description: 'Invalid email address.' })
  @ApiResponse({ status: 404, description: 'User not found.' })
  async requestPasswordReset(
    @Body() body: AuthRequestResetTokenDto,
  ): Promise<AuthResponseResetTokenDto> {
    return this.authService.requestResetToken(body);
  }

  @Public()
  @Post('check-reset-token')
  @ApiOperation({
    summary: 'Check reset token validity',
    description: 'Check if the reset token is valid.',
  })
  @ApiResponse({ status: 200, description: 'Token is valid.' })
  @ApiResponse({ status: 401, description: 'Token is invalid.' })
  async checkResetToken(
    @Body() body: AuthRequestCheckResetTokenDto,
  ): Promise<AuthResponseCheckResetTokenDto> {
    return this.authService.checkRestTokenValidity(body);
  }
}
