enum CategoryType {
  income(0),
  outcome(1);

  final int value;
  const CategoryType(this.value);

  static CategoryType fromInt(int value) {
    return CategoryType.values.firstWhere(
      (element) => element.value == value,
      orElse: () => CategoryType.income,
    );
  }
}
