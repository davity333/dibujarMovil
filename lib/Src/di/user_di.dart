import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:paperinthelifedraw/Src/Features/User/application/deleteUser_usecase.dart';
import 'package:paperinthelifedraw/Src/Features/User/application/getUser_usecase.dart';
import 'package:paperinthelifedraw/Src/Features/User/application/loginUser_usecase.dart';
import 'package:paperinthelifedraw/Src/Features/User/application/registerUser_usecase.dart';
import 'package:paperinthelifedraw/Src/Features/User/application/updateUser_usecase.dart';
import 'package:paperinthelifedraw/Src/Features/User/domain/repository/user_repository.dart';
import 'package:paperinthelifedraw/Src/Features/User/infrestructure/local/user_local.dart';
import 'package:paperinthelifedraw/Src/Features/User/infrestructure/repo/user_reppsitory_impl.dart';
import 'package:paperinthelifedraw/Src/Features/User/infrestructure/resource/user_remote_data.dart';
import 'package:paperinthelifedraw/Src/Features/User/presentation/provider/User_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> userDI = [
  
  Provider<FlutterSecureStorage>(
    create: (_) => const FlutterSecureStorage(),
  ),


  Provider<http.Client>(
    create: (_) => http.Client(),
    dispose: (_, client) => client.close(),
  ),


  Provider<UserLocalDataSource>(
    create: (context) => UserLocalDataSource(context.read<FlutterSecureStorage>()),
  ),


  Provider<UserRemoteDataSource>(
    create: (context) => UserRemoteDataSourceImp(client: context.read<http.Client>()),
  ),


  Provider<UserRepository>(
    create: (context) => UserRepositoryImpl(remote: context.read<UserRemoteDataSource>()),
  ),


  Provider<GetUserUsecase>(
    create: (context) => GetUserUsecase(context.read<UserRepository>()),
  ),


  Provider<RegisterUserUseCase>(
    create: (context) => RegisterUserUseCase(context.read<UserRepository>()),
  ),


  Provider<UpdateUserusecase>(
    create: (context) => UpdateUserusecase(context.read<UserRepository>()),
  ),


  Provider<DeleteuserUsecase>(
    create: (context) => DeleteuserUsecase(context.read<UserRepository>()),
  ),


  Provider<LoginUserUseCase>(
    create: (context) => LoginUserUseCase(context.read<UserRepository>()),
  ),

  
  ChangeNotifierProvider<UserViewModel>(
    create: (context) => UserViewModel(
      context.read<GetUserUsecase>(),
      context.read<RegisterUserUseCase>(),
      context.read<UpdateUserusecase>(),
      context.read<DeleteuserUsecase>(),
      context.read<LoginUserUseCase>(),
    ),
  ),
];