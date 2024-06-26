// Mocks generated by Mockito 5.4.4 from annotations
// in newsapp/test/usecase/lates_news_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:newsapp/data/models/article.dart' as _i4;
import 'package:newsapp/data/models/articles_request_params.dart' as _i5;
import 'package:newsapp/data/repository.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [DataRespository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDataRespository extends _i1.Mock implements _i2.DataRespository {
  MockDataRespository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.Article>> articles(_i5.ArticlesParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #articles,
          [params],
        ),
        returnValue: _i3.Future<List<_i4.Article>>.value(<_i4.Article>[]),
      ) as _i3.Future<List<_i4.Article>>);

  @override
  _i3.Future<List<_i4.Article>> latestArticles(
    List<String>? keywords,
    int? page,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #latestArticles,
          [
            keywords,
            page,
          ],
        ),
        returnValue: _i3.Future<List<_i4.Article>>.value(<_i4.Article>[]),
      ) as _i3.Future<List<_i4.Article>>);
}
