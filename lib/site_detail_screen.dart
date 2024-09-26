import 'package:flutter/material.dart';
import 'site.dart';

class SiteDetailPage extends StatelessWidget {
  const SiteDetailPage({super.key, required this.site});

  final Site site;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          site.name,
          style: const TextStyle(
            color: Color.fromRGBO(255, 215, 0, 100),
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 51, 102, 5),
      ),
      backgroundColor: const Color.fromRGBO(0, 112, 115, 10),
      body: ListView(
        children: [
          Image.asset(
            site.imageUrl,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Year Opened: ${site.yearOpened}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              site.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
