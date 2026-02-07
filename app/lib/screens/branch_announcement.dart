import 'package:flutter/material.dart';

class GenreReal extends StatelessWidget {
  const GenreReal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The soft pink background color from the reference images
      backgroundColor: const Color(0xFFFFF5F5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildWritingCard(),
        ),
      ),
    );
  }

  Widget _buildWritingCard() {
    return Container(
      padding: const EdgeInsets.all(10.0), // The thickness of the orange outer border
      decoration: BoxDecoration(
        color: const Color(0xFFF39200), // Primary Orange
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.black, width: 2.5),
      ),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 340, maxHeight: 200),
        decoration: BoxDecoration(
          color: const Color(0xFFF7E845), // Primary Yellow
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black, width: 2.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Three Outlined Stars
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _CustomStar(),
                SizedBox(width: 6),
                _CustomStar(),
                SizedBox(width: 6),
                _CustomStar(),
              ],
            ),
            const SizedBox(height: 12),
            // Top Text Row
            const Text(
              "you are writing",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            // Bottom Row with Blank Line
                const SizedBox(width: 10),
                const Text(
                  "____ story!",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                  ),
                ),
          ],
            ),
        ),
      );
  }
}

class _CustomStar extends StatelessWidget {
  const _CustomStar();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.star, color: Colors.black, size: 28), // The outline
        const Icon(Icons.star, color: Color(0xFFF39200), size: 18), // The fill
      ],
    );
  }
}