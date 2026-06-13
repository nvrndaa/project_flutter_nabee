part of 'article_bloc.dart';

@freezed
class ArticleState with _$ArticleState {
  const factory ArticleState.initial() = _Initial;
  const factory ArticleState.loading() = _Loading;
  const factory ArticleState.success({
    required List<Article> articles,
    required bool hasMore,
    required int currentPage,
  }) = _Success;
  const factory ArticleState.loadingMore({
    required List<Article> articles,
    required int currentPage,
  }) = _LoadingMore;
  const factory ArticleState.error(String message) = _Error;
}
