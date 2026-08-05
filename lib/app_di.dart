import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import './Src/di/user_di.dart';
import './Src/di/draw_di.dart';

List<SingleChildWidget> appDI = [
  ...userDI,
  ...drawDI,
];