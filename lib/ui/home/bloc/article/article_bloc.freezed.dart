// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ArticleEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() fetchArticles,
    required TResult Function() fetchMoreArticles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? fetchArticles,
    TResult? Function()? fetchMoreArticles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? fetchArticles,
    TResult Function()? fetchMoreArticles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchArticles value) fetchArticles,
    required TResult Function(_FetchMoreArticles value) fetchMoreArticles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchArticles value)? fetchArticles,
    TResult? Function(_FetchMoreArticles value)? fetchMoreArticles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchArticles value)? fetchArticles,
    TResult Function(_FetchMoreArticles value)? fetchMoreArticles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleEventCopyWith<$Res> {
  factory $ArticleEventCopyWith(
          ArticleEvent value, $Res Function(ArticleEvent) then) =
      _$ArticleEventCopyWithImpl<$Res, ArticleEvent>;
}

/// @nodoc
class _$ArticleEventCopyWithImpl<$Res, $Val extends ArticleEvent>
    implements $ArticleEventCopyWith<$Res> {
  _$ArticleEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArticleEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$ArticleEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArticleEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'ArticleEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() fetchArticles,
    required TResult Function() fetchMoreArticles,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? fetchArticles,
    TResult? Function()? fetchMoreArticles,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? fetchArticles,
    TResult Function()? fetchMoreArticles,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchArticles value) fetchArticles,
    required TResult Function(_FetchMoreArticles value) fetchMoreArticles,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchArticles value)? fetchArticles,
    TResult? Function(_FetchMoreArticles value)? fetchMoreArticles,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchArticles value)? fetchArticles,
    TResult Function(_FetchMoreArticles value)? fetchMoreArticles,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements ArticleEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$FetchArticlesImplCopyWith<$Res> {
  factory _$$FetchArticlesImplCopyWith(
          _$FetchArticlesImpl value, $Res Function(_$FetchArticlesImpl) then) =
      __$$FetchArticlesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchArticlesImplCopyWithImpl<$Res>
    extends _$ArticleEventCopyWithImpl<$Res, _$FetchArticlesImpl>
    implements _$$FetchArticlesImplCopyWith<$Res> {
  __$$FetchArticlesImplCopyWithImpl(
      _$FetchArticlesImpl _value, $Res Function(_$FetchArticlesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArticleEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FetchArticlesImpl implements _FetchArticles {
  const _$FetchArticlesImpl();

  @override
  String toString() {
    return 'ArticleEvent.fetchArticles()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FetchArticlesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() fetchArticles,
    required TResult Function() fetchMoreArticles,
  }) {
    return fetchArticles();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? fetchArticles,
    TResult? Function()? fetchMoreArticles,
  }) {
    return fetchArticles?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? fetchArticles,
    TResult Function()? fetchMoreArticles,
    required TResult orElse(),
  }) {
    if (fetchArticles != null) {
      return fetchArticles();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchArticles value) fetchArticles,
    required TResult Function(_FetchMoreArticles value) fetchMoreArticles,
  }) {
    return fetchArticles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchArticles value)? fetchArticles,
    TResult? Function(_FetchMoreArticles value)? fetchMoreArticles,
  }) {
    return fetchArticles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchArticles value)? fetchArticles,
    TResult Function(_FetchMoreArticles value)? fetchMoreArticles,
    required TResult orElse(),
  }) {
    if (fetchArticles != null) {
      return fetchArticles(this);
    }
    return orElse();
  }
}

abstract class _FetchArticles implements ArticleEvent {
  const factory _FetchArticles() = _$FetchArticlesImpl;
}

/// @nodoc
abstract class _$$FetchMoreArticlesImplCopyWith<$Res> {
  factory _$$FetchMoreArticlesImplCopyWith(_$FetchMoreArticlesImpl value,
          $Res Function(_$FetchMoreArticlesImpl) then) =
      __$$FetchMoreArticlesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchMoreArticlesImplCopyWithImpl<$Res>
    extends _$ArticleEventCopyWithImpl<$Res, _$FetchMoreArticlesImpl>
    implements _$$FetchMoreArticlesImplCopyWith<$Res> {
  __$$FetchMoreArticlesImplCopyWithImpl(_$FetchMoreArticlesImpl _value,
      $Res Function(_$FetchMoreArticlesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArticleEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FetchMoreArticlesImpl implements _FetchMoreArticles {
  const _$FetchMoreArticlesImpl();

  @override
  String toString() {
    return 'ArticleEvent.fetchMoreArticles()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FetchMoreArticlesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() fetchArticles,
    required TResult Function() fetchMoreArticles,
  }) {
    return fetchMoreArticles();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? fetchArticles,
    TResult? Function()? fetchMoreArticles,
  }) {
    return fetchMoreArticles?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? fetchArticles,
    TResult Function()? fetchMoreArticles,
    required TResult orElse(),
  }) {
    if (fetchMoreArticles != null) {
      return fetchMoreArticles();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchArticles value) fetchArticles,
    required TResult Function(_FetchMoreArticles value) fetchMoreArticles,
  }) {
    return fetchMoreArticles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchArticles value)? fetchArticles,
    TResult? Function(_FetchMoreArticles value)? fetchMoreArticles,
  }) {
    return fetchMoreArticles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchArticles value)? fetchArticles,
    TResult Function(_FetchMoreArticles value)? fetchMoreArticles,
    required TResult orElse(),
  }) {
    if (fetchMoreArticles != null) {
      return fetchMoreArticles(this);
    }
    return orElse();
  }
}

abstract class _FetchMoreArticles implements ArticleEvent {
  const factory _FetchMoreArticles() = _$FetchMoreArticlesImpl;
}

/// @nodoc
mixin _$ArticleState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Article> articles, bool hasMore, int currentPage)
        success,
    required TResult Function(List<Article> articles, int currentPage)
        loadingMore,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult? Function(List<Article> articles, int currentPage)? loadingMore,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult Function(List<Article> articles, int currentPage)? loadingMore,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleStateCopyWith<$Res> {
  factory $ArticleStateCopyWith(
          ArticleState value, $Res Function(ArticleState) then) =
      _$ArticleStateCopyWithImpl<$Res, ArticleState>;
}

/// @nodoc
class _$ArticleStateCopyWithImpl<$Res, $Val extends ArticleState>
    implements $ArticleStateCopyWith<$Res> {
  _$ArticleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ArticleStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ArticleState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Article> articles, bool hasMore, int currentPage)
        success,
    required TResult Function(List<Article> articles, int currentPage)
        loadingMore,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult? Function(List<Article> articles, int currentPage)? loadingMore,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult Function(List<Article> articles, int currentPage)? loadingMore,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ArticleState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ArticleStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ArticleState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Article> articles, bool hasMore, int currentPage)
        success,
    required TResult Function(List<Article> articles, int currentPage)
        loadingMore,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult? Function(List<Article> articles, int currentPage)? loadingMore,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult Function(List<Article> articles, int currentPage)? loadingMore,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ArticleState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Article> articles, bool hasMore, int currentPage});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ArticleStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? hasMore = null,
    Object? currentPage = null,
  }) {
    return _then(_$SuccessImpl(
      articles: null == articles
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<Article>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(
      {required final List<Article> articles,
      required this.hasMore,
      required this.currentPage})
      : _articles = articles;

  final List<Article> _articles;
  @override
  List<Article> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  @override
  final bool hasMore;
  @override
  final int currentPage;

  @override
  String toString() {
    return 'ArticleState.success(articles: $articles, hasMore: $hasMore, currentPage: $currentPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_articles), hasMore, currentPage);

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Article> articles, bool hasMore, int currentPage)
        success,
    required TResult Function(List<Article> articles, int currentPage)
        loadingMore,
    required TResult Function(String message) error,
  }) {
    return success(articles, hasMore, currentPage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult? Function(List<Article> articles, int currentPage)? loadingMore,
    TResult? Function(String message)? error,
  }) {
    return success?.call(articles, hasMore, currentPage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult Function(List<Article> articles, int currentPage)? loadingMore,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(articles, hasMore, currentPage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements ArticleState {
  const factory _Success(
      {required final List<Article> articles,
      required final bool hasMore,
      required final int currentPage}) = _$SuccessImpl;

  List<Article> get articles;
  bool get hasMore;
  int get currentPage;

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingMoreImplCopyWith<$Res> {
  factory _$$LoadingMoreImplCopyWith(
          _$LoadingMoreImpl value, $Res Function(_$LoadingMoreImpl) then) =
      __$$LoadingMoreImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Article> articles, int currentPage});
}

/// @nodoc
class __$$LoadingMoreImplCopyWithImpl<$Res>
    extends _$ArticleStateCopyWithImpl<$Res, _$LoadingMoreImpl>
    implements _$$LoadingMoreImplCopyWith<$Res> {
  __$$LoadingMoreImplCopyWithImpl(
      _$LoadingMoreImpl _value, $Res Function(_$LoadingMoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? currentPage = null,
  }) {
    return _then(_$LoadingMoreImpl(
      articles: null == articles
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<Article>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadingMoreImpl implements _LoadingMore {
  const _$LoadingMoreImpl(
      {required final List<Article> articles, required this.currentPage})
      : _articles = articles;

  final List<Article> _articles;
  @override
  List<Article> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  @override
  final int currentPage;

  @override
  String toString() {
    return 'ArticleState.loadingMore(articles: $articles, currentPage: $currentPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingMoreImpl &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_articles), currentPage);

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingMoreImplCopyWith<_$LoadingMoreImpl> get copyWith =>
      __$$LoadingMoreImplCopyWithImpl<_$LoadingMoreImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Article> articles, bool hasMore, int currentPage)
        success,
    required TResult Function(List<Article> articles, int currentPage)
        loadingMore,
    required TResult Function(String message) error,
  }) {
    return loadingMore(articles, currentPage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult? Function(List<Article> articles, int currentPage)? loadingMore,
    TResult? Function(String message)? error,
  }) {
    return loadingMore?.call(articles, currentPage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult Function(List<Article> articles, int currentPage)? loadingMore,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(articles, currentPage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_Error value) error,
  }) {
    return loadingMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_Error value)? error,
  }) {
    return loadingMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(this);
    }
    return orElse();
  }
}

abstract class _LoadingMore implements ArticleState {
  const factory _LoadingMore(
      {required final List<Article> articles,
      required final int currentPage}) = _$LoadingMoreImpl;

  List<Article> get articles;
  int get currentPage;

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingMoreImplCopyWith<_$LoadingMoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ArticleStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ArticleState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Article> articles, bool hasMore, int currentPage)
        success,
    required TResult Function(List<Article> articles, int currentPage)
        loadingMore,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult? Function(List<Article> articles, int currentPage)? loadingMore,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Article> articles, bool hasMore, int currentPage)?
        success,
    TResult Function(List<Article> articles, int currentPage)? loadingMore,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ArticleState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
