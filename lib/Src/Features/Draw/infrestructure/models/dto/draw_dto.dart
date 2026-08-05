class DrawDto{
  final int idDraw;
  final String name;
  final String description;
  final String imageUrl;
  final String date;
  final String category;
  final List<int> sections;

  DrawDto({
    required this.idDraw,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.category,
    required this.sections,
  });

  DrawDto.fromJson(Map<String, dynamic> json)
      : idDraw = (() {
          final v = json['idDraw'];
          if (v is int) return v;
          if (v is String) return int.tryParse(v) ?? 0;
          if (v is num) return v.toInt();
          return 0;
        })(),
        name = (json['name'] ?? '').toString(),
        description = (json['description'] ?? '').toString(),
        imageUrl = (json['image_location'] ?? '').toString(),
        date = (json['date'] ?? '').toString(),
        category = (json['category'] ?? '').toString(),
        sections = (() {
          final s = json['sections'];
          if (s == null) return <int>[];
          try {
            return List<int>.from((s as List).map((e) => (e is int) ? e : int.tryParse(e.toString()) ?? 0));
          } catch (_) {
            return <int>[];
          }
        })();
}