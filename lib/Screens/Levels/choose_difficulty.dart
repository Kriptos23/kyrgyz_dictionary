import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyrgyz_dictionary/widgets/region_card_widget.dart';
import '../../State Management/Bloc/progress/counter_event.dart';
import '../../State Management/Bloc/progress/progress_bloc.dart';
import '../../classes/region_card.dart';

class ChooseDifficulty extends StatefulWidget {
  const ChooseDifficulty({super.key});

  @override
  State<ChooseDifficulty> createState() => _ChooseDifficultyState();
}

class _ChooseDifficultyState extends State<ChooseDifficulty> {
  @override
  void initState() {
    super.initState();
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: regions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 2.5,
        ),
        itemBuilder: (context, index) {
          final region = regions[index];

          return RegionCardWidget(
            region: region,
            onTap: () {
              print(region.text);
            },
          );
        },
      )
    );
  }
}


final regions = [
  RegionCard(text: "Bishkek", image: "assets/img/regions/bishkek.png"),
  RegionCard(text: "Chuy", image: "assets/img/regions/chuy.png"),
  // RegionCard(text: "Naryn", image: "assets/img/regions/chuy.png"),
  // add all 9
];

