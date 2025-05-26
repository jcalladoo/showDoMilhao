import 'package:flutter/material.dart';

class RankingTile extends StatefulWidget {
  final int position;
  final String name;
  final String prize;

  const RankingTile({
    super.key,
    required this.position,
    required this.name,
    required this.prize,
  });

  @override
  State<RankingTile> createState() => _RankingTileState();
}

class _RankingTileState extends State<RankingTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.position} - ${widget.name}',
                style: const TextStyle(fontSize: 18, fontFamily: 'Georgia'),
              ),
              IconButton(
                icon: Icon(
                  expanded ? Icons.remove : Icons.add,
                  color: Colors.orange,
                ),
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
              ),
            ],
          ),
          if (expanded) ...[
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 8),
            const Text(
              'Premiação',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              widget.prize,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Aqui pode abrir tela de detalhes
              },
              child: const Text('Ver questões >'),
            ),
          ]
        ],
      ),
    );
  }
}
