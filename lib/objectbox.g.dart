// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'features/articles/data/datasources/local/tables/articles_table.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 8376996681621182852),
      name: 'ArticlesTable',
      lastPropertyId: const IdUid(4, 7617306674933384073),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 9210478886206035020),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1807260537424911951),
            name: 'publishedDate',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 329109197166402113),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7617306674933384073),
            name: 'articleType',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 8376996681621182852),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    ArticlesTable: EntityDefinition<ArticlesTable>(
        model: _entities[0],
        toOneRelations: (ArticlesTable object) => [],
        toManyRelations: (ArticlesTable object) => {},
        getId: (ArticlesTable object) => object.id,
        setId: (ArticlesTable object, int id) {
          object.id = id;
        },
        objectToFB: (ArticlesTable object, fb.Builder fbb) {
          final publishedDateOffset = fbb.writeString(object.publishedDate);
          final titleOffset = fbb.writeString(object.title);
          final articleTypeOffset = fbb.writeString(object.articleType);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, publishedDateOffset);
          fbb.addOffset(2, titleOffset);
          fbb.addOffset(3, articleTypeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ArticlesTable(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              publishedDate: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              articleType: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [ArticlesTable] entity fields to define ObjectBox queries.
class ArticlesTable_ {
  /// see [ArticlesTable.id]
  static final id =
      QueryIntegerProperty<ArticlesTable>(_entities[0].properties[0]);

  /// see [ArticlesTable.publishedDate]
  static final publishedDate =
      QueryStringProperty<ArticlesTable>(_entities[0].properties[1]);

  /// see [ArticlesTable.title]
  static final title =
      QueryStringProperty<ArticlesTable>(_entities[0].properties[2]);

  /// see [ArticlesTable.articleType]
  static final articleType =
      QueryStringProperty<ArticlesTable>(_entities[0].properties[3]);
}