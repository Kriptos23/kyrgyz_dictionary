import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../State Management/Bloc/progress/counter_event.dart';
import '../../State Management/Bloc/progress/progress_bloc.dart';
import '../classes/region_card.dart';

class RegionCardWidget extends StatelessWidget {
  final RegionCard region;
  final VoidCallback onTap;

  RegionCardWidget({super.key, required this.region, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsetsGeometry.all(15),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white24,
          highlightColor: Colors.white10,
          hoverColor: Colors.white10,
          onTap: () async {
            context.read<ProgressBloc>().add(LoadDifficulty(region.text.toLowerCase()));//'easy' || regionCard.text.toLowerCase()
          },
          child: Ink(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(region.image), fit: BoxFit.cover, alignment: Alignment(0, -0.3),),
                // color: Colors.green,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueAccent, width: 2)
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Text(
              region.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
