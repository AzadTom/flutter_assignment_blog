import 'package:flutter_03/data/blogmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Blog>> fetchData() async {
  const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  const String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    if (response.statusCode == 200) {
       final List<dynamic> data = json.decode(response.body)['blogs'];

    List<Blog> blogList = data.map((item) => Blog.fromJson(item)).toList();
    return blogList;

    } else {
       throw Exception('Invalid data format');
    }
  } catch (e) {
    throw Exception('Failed to load data');
  }
}
