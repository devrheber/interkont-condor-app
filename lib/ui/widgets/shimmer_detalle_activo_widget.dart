import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ShimmerDetallerActivoWidget extends StatelessWidget {
  const ShimmerDetallerActivoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 361),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Skelton(width: 100, height: 20),
          const SizedBox(height: 10),
          const Skelton(width: 210, height: 20),
          const SizedBox(height: 20),
          ...List.generate(3, (int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.5),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Skelton(width: 100, height: 20),
                  SizedBox(width: 40),
                  Skelton(width: 150, height: 20),
                ],
              ),
            );
          }),
          const SizedBox(height: 30),
          const Skelton(width: double.infinity, height: 120),
        ],
      ),
    );
  }
}
