import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedGridView extends StatefulWidget {
  const AnimatedGridView({super.key});

  @override
  State<AnimatedGridView> createState() => _AnimatedGridViewState();
}

class _AnimatedGridViewState extends State<AnimatedGridView>
    with TickerProviderStateMixin {
  List<AnimatedItem> items = [
    AnimatedItem(name: 'Item 1'),
    AnimatedItem(name: 'Item 2'),
    AnimatedItem(name: 'Item 3'),
    AnimatedItem(name: 'Item 4'),
    AnimatedItem(name: 'Item 5'),
    AnimatedItem(name: 'Item 6'),
  ];

  @override
  void dispose() {
    for (var item in items) {
      item.animationController!.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    for (var item in items) {
      item.animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      item.animationController!.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: items.map((item) => buildAnimatedItemWidget(item)).toList(),
    );
  }

  Widget buildAnimatedItemWidget(AnimatedItem item) {
    final Animation<Offset> slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: item.animationController!,
        curve: Curves.easeOut,
      ),
    );

    return SlideTransition(
      position: slideAnimation,
      child: buildItemWidget(item.name),
    );
  }

  Widget buildItemWidget(String itemName) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: Image.network(
              'https://example.com/image.jpg', // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: Text(
                itemName,
                style: GoogleFonts.lato(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedItem {
  final String name;
  late AnimationController? animationController;

  AnimatedItem({required this.name, this.animationController});
}