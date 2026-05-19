class ChanceResult {
  const ChanceResult({
    required this.percent,
    required this.label,
    required this.hasData,
  });

  final int? percent;
  final String label;
  final bool hasData;
}

ChanceResult calculateGrantChance({
  required int userScore,
  required int? grantPassingScore,
}) {
  if (grantPassingScore == null) {
    return const ChanceResult(
      percent: null,
      label: 'Дерек әлі енгізілмеген',
      hasData: false,
    );
  }

  final difference = userScore - grantPassingScore;

  if (difference >= 15) {
    return const ChanceResult(percent: 95, label: 'Өте жоғары', hasData: true);
  }
  if (difference >= 8) {
    return const ChanceResult(percent: 85, label: 'Жоғары', hasData: true);
  }
  if (difference >= 1) {
    return const ChanceResult(
      percent: 70,
      label: 'Орташа жоғары',
      hasData: true,
    );
  }
  if (difference == 0) {
    return const ChanceResult(percent: 60, label: 'Шекарада', hasData: true);
  }
  if (difference >= -5) {
    return const ChanceResult(
      percent: 40,
      label: 'Орташа төмен',
      hasData: true,
    );
  }
  if (difference >= -10) {
    return const ChanceResult(percent: 20, label: 'Төмен', hasData: true);
  }
  return const ChanceResult(percent: 5, label: 'Өте төмен', hasData: true);
}
