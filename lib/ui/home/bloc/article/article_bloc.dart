import 'package:bloc/bloc.dart';
import 'package:flutter_nabee/data/datasources/article_remote_datasource.dart';
import 'package:flutter_nabee/data/model/response/article_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_event.dart';
part 'article_state.dart';
part 'article_bloc.freezed.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRemoteDatasource articleRemoteDatasource;
  ArticleBloc(this.articleRemoteDatasource) : super(_Initial()) {
    on<_FetchArticles>((event, emit) async {
      emit(_Loading());
      final response = await articleRemoteDatasource.fetchArticles(page: 1);
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(
          articles: data.articles,
          hasMore: data.hasMore,
          currentPage: 1,
        )),
      );
    });

    on<_FetchMoreArticles>((event, emit) async {
      final currentState = state;
      if (currentState is _Success && currentState.hasMore) {
        final nextPage = currentState.currentPage + 1;
        emit(_LoadingMore(
          articles: currentState.articles,
          currentPage: currentState.currentPage,
        ));
        final response =
            await articleRemoteDatasource.fetchArticles(page: nextPage);
        response.fold(
          (error) => emit(_Error(error)),
          (data) => emit(_Success(
            articles: [...currentState.articles, ...data.articles],
            hasMore: data.hasMore,
            currentPage: nextPage,
          )),
        );
      }
    });
  }
}
