import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Atoms/Title.dart';
import '../Molecules/DrawCard.dart';
import '../../Features/Draw/presentation/provider/draw_provider.dart';

class SectionDrawsOrg extends StatefulWidget {
  const SectionDrawsOrg({super.key});

  @override
  State<SectionDrawsOrg> createState() => _SectionDrawsOrgState();
}

class _SectionDrawsOrgState extends State<SectionDrawsOrg> {

  @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<DrawViewModel>().loadDraws();
  });
}


  @override
  Widget build(BuildContext context) {

    final vm = context.watch<DrawViewModel>();

    return Column(
      children: [

        /// HEADER
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

  

            const SizedBox(width: 10),

            AppTitle("SECCIÓN DE DIBUJOS"),
          ],
        ),

        const SizedBox(height: 20),

        /// LOADING
        if (vm.isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),

        /// LISTA
        if (!vm.isLoading)
          Expanded(
            child: ListView.builder(
              itemCount: vm.draws.length,

              itemBuilder: (context, index) {

                final draw = vm.draws[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),

                  child: DrawCard(
                    idDraw: draw.idDraw,
                    title: draw.name,
                    description: draw.descriptionDraw,
                    imagePath: draw.imageUrl,
                    date: draw.date,           
                    category: draw.category,   
                  ),
                );
              },
            ),
          ),

      ],
    );
  }
}