class Site {
  const Site(
      {required this.name,
      required this.yearOpened,
      required this.description,
      required this.imageUrl,
      required this.id});

  final String name;
  final String yearOpened;
  final String description;
  final String imageUrl;
  final String id;

  static fromMap(Map<String, dynamic> siteData) {
    return Site(
        name: siteData['name'],
        yearOpened: siteData['yearOpened'],
        description: siteData['siteInfo'],
        imageUrl: siteData['photo'],
        id: siteData['id']);
  }
}
