// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:nyt/features/articles/domain/entities/article.dart';

class ArticleSearchResponse {
  String status;
  String copyright;
  Response response;

  ArticleSearchResponse({
    required this.status,
    required this.copyright,
    required this.response,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'copyright': copyright,
      'response': response.toMap(),
    };
  }

  factory ArticleSearchResponse.fromMap(Map<String, dynamic> map) {
    return ArticleSearchResponse(
      status: map['status'] != null ? map['status'] as String : "",
      copyright: map['copyright'] != null ? map['copyright'] as String : "",
      response: Response.fromMap(map['response']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleSearchResponse.fromJson(String source) => ArticleSearchResponse.fromMap(json.decode(source));
}

class Response {
  List<Doc> docs;

  Response({
    required this.docs,
  });

  Map<String, dynamic> toMap() {
    return {
      'docs': docs.map((x) => x.toMap()).toList(),
    };
  }

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
      docs: List<Doc>.from(map['docs'].map((x) => Doc.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Response.fromJson(String source) => Response.fromMap(json.decode(source));
}

class Doc extends Article {
  String docAbstract;
  String webUrl;
  String snippet;
  String leadParagraph;
  String printSection;
  String printPage;
  List<Multimedia> multimedia;
  Headline headline;
  List<Keyword> keywords;
  String pubDate;
  String newsDesk;
  String sectionName;
  String subsectionName;
  Byline byline;
  String id;
  int wordCount;
  String uri;

  Doc({
    required this.docAbstract,
    required this.webUrl,
    required this.snippet,
    required this.leadParagraph,
    required this.printSection,
    required this.printPage,
    required this.multimedia,
    required this.headline,
    required this.keywords,
    required this.pubDate,
    required this.newsDesk,
    required this.sectionName,
    required this.subsectionName,
    required this.byline,
    required this.id,
    required this.wordCount,
    required this.uri,
  }) : super(
          publishedDate: pubDate,
          title: headline.main,
        );

  Map<String, dynamic> toMap() {
    return {
      'docAbstract': docAbstract,
      'webUrl': webUrl,
      'snippet': snippet,
      'leadParagraph': leadParagraph,
      'printSection': printSection,
      'printPage': printPage,
      'multimedia': multimedia.map((x) => x.toMap()).toList(),
      'headline': headline.toMap(),
      'keywords': keywords.map((x) => x.toMap()).toList(),
      'pubDate': pubDate,
      'newsDesk': newsDesk,
      'sectionName': sectionName,
      'subsectionName': subsectionName,
      'byline': byline.toMap(),
      'id': id,
      'wordCount': wordCount,
      'uri': uri,
    };
  }

  factory Doc.fromMap(Map<String, dynamic> map) {
    return Doc(
      docAbstract: map['docAbstract'] != null ? map['docAbstract'] as String : "",
      webUrl: map['webUrl'] != null ? map['webUrl'] as String : "",
      snippet: map['snippet'] != null ? map['snippet'] as String : "",
      leadParagraph: map['leadParagraph'] != null ? map['leadParagraph'] as String : "",
      printSection: map['printSection'] != null ? map['printSection'] as String : "",
      printPage: map['printPage'] != null ? map['printPage'] as String : "",
      multimedia: List<Multimedia>.from(map['multimedia'].map((x) => Multimedia.fromMap(x))),
      headline: Headline.fromMap(map['headline']),
      keywords: List<Keyword>.from(map['keywords'].map((x) => Keyword.fromMap(x))),
      pubDate: map['pub_date'] != null ? map['pub_date'] as String : "",
      newsDesk: map['newsDesk'] != null ? map['newsDesk'] as String : "",
      sectionName: map['sectionName'] != null ? map['sectionName'] as String : "",
      subsectionName: map['subsectionName'] != null ? map['subsectionName'] as String : "",
      byline: Byline.fromMap(map['byline']),
      id: map['id'] != null ? map['id'] as String : "",
      wordCount: map['wordCount'] != null ? map['wordCount'] as int : 0,
      uri: map['uri'] != null ? map['uri'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Doc.fromJson(String source) => Doc.fromMap(json.decode(source));
}

class Byline {
  String original;
  List<Person> person;
  dynamic organization;

  Byline({
    required this.original,
    required this.person,
    required this.organization,
  });

  Map<String, dynamic> toMap() {
    return {
      'original': original,
      'person': person.map((x) => x.toMap()).toList(),
      'organization': organization,
    };
  }

  factory Byline.fromMap(Map<String, dynamic> map) {
    return Byline(
      original: map['original'],
      person: List<Person>.from(map['person'].map((x) => Person.fromMap(x))),
      organization: map['organization'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Byline.fromJson(String source) => Byline.fromMap(json.decode(source));
}

class Person {
  String firstname;
  String middlename;
  String lastname;
  dynamic qualifier;
  String title;
  String organization;
  int rank;

  Person({
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.qualifier,
    required this.title,
    required this.organization,
    required this.rank,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'middlename': middlename,
      'lastname': lastname,
      'qualifier': qualifier,
      'title': title,
      'organization': organization,
      'rank': rank,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      firstname: map['firstname'] != null ? map['firstname'] as String : "",
      middlename: map['middlename'] != null ? map['middlename'] as String : "",
      lastname: map['lastname'] != null ? map['lastname'] as String : "",
      qualifier: map['qualifier'] != null ? map['qualifier'] as String : "",
      title: map['title'] != null ? map['title'] as String : "",
      organization: map['organization'] != null ? map['organization'] as String : "",
      rank: map['rank'] != null ? map['rank'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));
}

class Headline {
  String main;
  String kicker;
  dynamic contentKicker;
  String printHeadline;
  dynamic name;
  dynamic seo;
  dynamic sub;

  Headline({
    required this.main,
    required this.kicker,
    required this.contentKicker,
    required this.printHeadline,
    required this.name,
    required this.seo,
    required this.sub,
  });

  Map<String, dynamic> toMap() {
    return {
      'main': main,
      'kicker': kicker,
      'contentKicker': contentKicker,
      'printHeadline': printHeadline,
      'name': name,
      'seo': seo,
      'sub': sub,
    };
  }

  factory Headline.fromMap(Map<String, dynamic> map) {
    return Headline(
      main: map['main'] != null ? map['main'] as String : "",
      kicker: map['kicker'] != null ? map['kicker'] as String : "",
      contentKicker: map['contentKicker'] != null ? map['contentKicker'] as String : "",
      printHeadline: map['printHeadline'] != null ? map['printHeadline'] as String : "",
      name: map['name'] != null ? map['name'] as String : "",
      seo: map['seo'] != null ? map['seo'] as String : "",
      sub: map['sub'] != null ? map['sub'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Headline.fromJson(String source) => Headline.fromMap(json.decode(source));
}

class Keyword {
  String value;
  int rank;
  Keyword({
    required this.value,
    required this.rank,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'rank': rank,
    };
  }

  factory Keyword.fromMap(Map<String, dynamic> map) {
    return Keyword(
      value: map['value'] != null ? map['value'] as String : "",
      rank: map['rank'] != null ? map['rank'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Keyword.fromJson(String source) => Keyword.fromMap(json.decode(source));
}

enum Major { N }

enum Name { GLOCATIONS, SUBJECT, PERSONS, ORGANIZATIONS }

class Multimedia {
  int rank;
  String subtype;
  dynamic caption;
  dynamic credit;
  String url;
  int height;
  int width;
  String subType;
  String cropName;

  Multimedia({
    required this.rank,
    required this.subtype,
    required this.caption,
    required this.credit,
    required this.url,
    required this.height,
    required this.width,
    required this.subType,
    required this.cropName,
  });

  Map<String, dynamic> toMap() {
    return {
      'rank': rank,
      'subtype': subtype,
      'caption': caption,
      'credit': credit,
      'url': url,
      'height': height,
      'width': width,
      'subType': subType,
      'cropName': cropName,
    };
  }

  factory Multimedia.fromMap(Map<String, dynamic> map) {
    return Multimedia(
      rank: map['rank'] != null ? map['rank'] as int : 0,
      subtype: map['subtype'] != null ? map['subtype'] as String : "",
      caption: map['caption'] != null ? map['caption'] as String : "",
      credit: map['credit'] != null ? map['credit'] as String : "",
      url: map['url'] != null ? map['url'] as String : "",
      height: map['height'] != null ? map['height'] as int : 0,
      width: map['width'] != null ? map['width'] as int : 0,
      subType: map['subType'] != null ? map['subType'] as String : "",
      cropName: map['cropName'] != null ? map['cropName'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Multimedia.fromJson(String source) => Multimedia.fromMap(json.decode(source));
}

class Legacy {
  String xlarge;
  int xlargewidth;
  int xlargeheight;
  String thumbnail;
  int thumbnailwidth;
  int thumbnailheight;
  int widewidth;
  int wideheight;
  String wide;

  Legacy({
    required this.xlarge,
    required this.xlargewidth,
    required this.xlargeheight,
    required this.thumbnail,
    required this.thumbnailwidth,
    required this.thumbnailheight,
    required this.widewidth,
    required this.wideheight,
    required this.wide,
  });

  Map<String, dynamic> toMap() {
    return {
      'xlarge': xlarge,
      'xlargewidth': xlargewidth,
      'xlargeheight': xlargeheight,
      'thumbnail': thumbnail,
      'thumbnailwidth': thumbnailwidth,
      'thumbnailheight': thumbnailheight,
      'widewidth': widewidth,
      'wideheight': wideheight,
      'wide': wide,
    };
  }

  factory Legacy.fromMap(Map<String, dynamic> map) {
    return Legacy(
      xlarge: map['xlarge'],
      xlargewidth: map['xlargewidth'],
      xlargeheight: map['xlargeheight'],
      thumbnail: map['thumbnail'],
      thumbnailwidth: map['thumbnailwidth'],
      thumbnailheight: map['thumbnailheight'],
      widewidth: map['widewidth'],
      wideheight: map['wideheight'],
      wide: map['wide'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Legacy.fromJson(String source) => Legacy.fromMap(json.decode(source));
}

enum Type { IMAGE }

enum Source { THE_NEW_YORK_TIMES }

enum TypeOfMaterial { NEWS }

class Meta {
  int hits;
  int offset;
  int time;

  Meta({
    required this.hits,
    required this.offset,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'hits': hits,
      'offset': offset,
      'time': time,
    };
  }

  factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
      hits: map['hits'] != null ? map['hits'] as int : 0,
      offset: map['offset'] != null ? map['offset'] as int : 0,
      time: map['time'] != null ? map['time'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Meta.fromJson(String source) => Meta.fromMap(json.decode(source));
}
