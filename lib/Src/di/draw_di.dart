import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:http/http.dart' as http;

import '../Features/Draw/infrestructure/resource/draw_remote_data.dart';
import '../Features/Draw/infrestructure/repo/draw_repository_impl.dart';
import '../Features/Draw/domain/repository/draw_repository.dart';
import '../Features/Draw/application/getDraw_usecase.dart';
import '../Features/Draw/application/createDraw_usecase.dart';
import '../Features/Draw/application/updateDraw_usecase.dart';
import '../Features/Draw/application/deleteDraw_usecase.dart';
import '../Features/Draw/presentation/provider/draw_provider.dart';

List<SingleChildWidget> drawDI = [
  Provider<DrawRemoteDataSource>(
    create: (context) => DrawRemoteDataSourceImpl(client: context.read<http.Client>()),
  ),

  Provider<DrawRepository>(
    create: (context) => DrawRepositoryImpl(remote: context.read<DrawRemoteDataSource>()),
  ),

  Provider<GetDrawUseCase>(
    create: (context) => GetDrawUseCase(context.read<DrawRepository>()),
  ),

  Provider<CreateUseCase>(
    create: (context) => CreateUseCase(context.read<DrawRepository>()),
  ),

  Provider<UpdateUseCase>(
    create: (context) => UpdateUseCase(context.read<DrawRepository>()),
  ),

  Provider<DeleteUseCase>(
    create: (context) => DeleteUseCase(context.read<DrawRepository>()),
  ),

  ChangeNotifierProvider<DrawViewModel>(
    create: (context) => DrawViewModel(
      getDraws: context.read<GetDrawUseCase>(),
      createDraw: context.read<CreateUseCase>(),
      updateDraw: context.read<UpdateUseCase>(),
      deleteDrawUseCase: context.read<DeleteUseCase>(),
    ),
  ),
];
