class Package {
  final int id;
  final String name;
  final int accountCount;

  Package({
    this.id,
    this.name,
    this.accountCount,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json["id"],
      name: json["name"],
      accountCount: json["account_count"],
    );
  }
}
