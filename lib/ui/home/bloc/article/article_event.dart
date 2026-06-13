part of 'article_bloc.dart';

@freezed
class ArticleEvent with _$ArticleEvent {
  const factory ArticleEvent.started() = _Started;
  const factory ArticleEvent.fetchArticles() = _FetchArticles;
  const factory ArticleEvent.fetchMoreArticles() = _FetchMoreArticles;
}
