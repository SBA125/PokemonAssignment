class Pokemon {
  final int id;
  final String num;
  final String name;
  final String img;
  final List<String> type;
  final String height;
  final String weight;
  final String? candy;
  final int? candyCount;
  final String? egg;
  final double? spawnChance;
  final double? avgSpawns;
  final String? spawnTime;
  final List<double>? multipliers;
  final List<Evolution>? prevEvolution;
  final List<Evolution>? nextEvolution;
  final List<String> weaknesses;

  Pokemon({
    required this.id,
    required this.num,
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    this.candy,
    this.candyCount,
    this.egg,
    this.spawnChance,
    this.avgSpawns,
    this.spawnTime,
    this.multipliers,
    this.prevEvolution,
    this.nextEvolution,
    required this.weaknesses,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      num: json['num'],
      name: json['name'],
      img: json['img'],
      type: List<String>.from(json['type']),
      height: json['height'],
      weight: json['weight'],
      candy: json['candy'],
      candyCount: json['candy_count'],
      egg: json['egg'],
      spawnChance: json['spawn_chance']?.toDouble(),
      avgSpawns: json['avg_spawns']?.toDouble(),
      spawnTime: json['spawn_time'],
      multipliers: json['multipliers'] != null
          ? List<double>.from(json['multipliers'])
          : null,
      prevEvolution: json['prev_evolution'] != null
          ? List<Evolution>.from(json['prev_evolution']
              .map((evolution) => Evolution.fromJson(evolution)))
          : null,
      nextEvolution: json['next_evolution'] != null
          ? List<Evolution>.from(json['next_evolution']
              .map((evolution) => Evolution.fromJson(evolution)))
          : null,
      weaknesses: List<String>.from(json['weaknesses']),
    );
  }
}

class Evolution {
  final String num;
  final String name;

  Evolution({
    required this.num,
    required this.name,
  });

  factory Evolution.fromJson(Map<String, dynamic> json) {
    return Evolution(
      num: json['num'],
      name: json['name'],
    );
  }
}
