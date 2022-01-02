import 'package:evento/exports.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider.value(value: AppProvider()),
  ChangeNotifierProvider(create: (c) => AuthProvider()),
  ChangeNotifierProvider(create: (c) => ExploreProvider()),
  ChangeNotifierProvider(create: (c) => EventProviders()),
];
