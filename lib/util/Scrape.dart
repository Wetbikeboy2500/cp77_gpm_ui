//This is for web scrapping the cyberpunk website
import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

Future<List<News>> fetchCyberpunkNews() async {
  try {
    var response = await Dio().get("https://www.cyberpunk.net/en/news");
    var document = parse(response.data.toString());
    var format = DateFormat('dd.MM.yyyy');
    List<News> news = [];
    document.querySelectorAll('.c-news').forEach((element) {
      news.add(News(
          url: p.url
              .join('https://www.cyberpunk.net', element.attributes['href']),
          title: element.querySelector('.c-news__title').text,
          time: format.parse(
              element.querySelector('.c-news__date').attributes['data-text'])));
    });
    return news;
  } catch (e, stack) {
    print(e);
    print(stack);
  }

  return <News>[];
}

Future<List<News>> fetchRelease() async {
  final String api =
      'https://api.github.com/repos/wetbikeboy2500/cp77_gpm_ui/releases';

  List<News> news = [];

  try {
    var response = await Dio().get(api,
        options: Options(
          responseType: ResponseType.json,
        ));

    news = List<News>.from(response.data.map((element) {
      return News(
          time: DateTime.parse(element['published_at']),
          title: element['name'],
          url: element['html_url']);
    }));
  } catch (e, stack) {
    print(e);
    print(stack);
  }

  return news;
}

class News {
  final String title;
  final String url;
  final DateTime time;
  News({this.title, this.url, this.time});
}
