import 'package:famcards/features/cards/presentation/cubit/card_cubit.dart';
import 'package:famcards/features/cards/presentation/cubit/card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DismissButton extends StatelessWidget {
  final String id;
  const DismissButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCubit, CardState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.read<CardCubit>().dismissCard(id),
          child: Container(
            height: 100,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/dismiss.png'),
                const SizedBox(height: 4),
                const Text(
                  "dismiss now",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
