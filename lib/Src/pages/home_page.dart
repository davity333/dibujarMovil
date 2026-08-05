import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// theme imports removed (handled globally)

import '../Features/Draw/presentation/provider/draw_provider.dart';
import '../plugins/organism/SectionDrawsOrg.dart';
import '../plugins/molecules/ModalForm.dart';
import '../Features/User/infrestructure/local/user_local.dart';
import '../Features/User/presentation/provider/User_viewmodel.dart';
import 'login_page.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Paper In The Life Draw'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                final local = Provider.of<UserLocalDataSource>(context, listen: false);
                final vm = Provider.of<UserViewModel>(context, listen: false);
                final navigator = Navigator.of(context);

                () async {
                  try {
                    await local.deleteToken();
                  } catch (_) {}

                  if (!mounted) return;

                  vm.logout();
                  navigator.pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                }();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final vm = Provider.of<DrawViewModel>(context, listen: false);
            vm.clearSelection();
            showDialog(
              context: context,
              builder: (context) => const ModalForm(),
            );
          },
          label: const Text('Add'),
          icon: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Expanded(
                child: Consumer<DrawViewModel>(
                  builder: (context, vm, _) {
                    return const SectionDrawsOrg();
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}
