import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search/search_movie_bloc.dart';
import '../bloc/search/search_tv_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  final bool? isMovie;

  const SearchPage({this.isMovie = true});
  const SearchPage.tv({this.isMovie = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                isMovie == true
                    ? context
                        .read<SearchMovieBloc>()
                        .add(OnSearchMovie(query: query))
                    : context
                        .read<SearchTvBloc>()
                        .add(OnSearchTv(query: query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            ShowListSearch(
              isMovie: isMovie!,
            ),
          ],
        ),
      ),
    );
  }
}

class ShowListSearch extends StatelessWidget {
  final bool isMovie;
  const ShowListSearch({
    Key? key,
    required this.isMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMovie
        ? BlocBuilder<SearchMovieBloc, SearchMovieState>(
            builder: (context, state) {
              if (state is SearchMovieLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchMovieLoaded) {
                final result = state.result;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = result[index];
                      return MovieCard<Movie>(movie);
                    },
                    itemCount: result.length,
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            },
          )
        : BlocBuilder<SearchTvBloc, SearchTvState>(
            builder: (context, state) {
              if (state is SearchTvLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchTvLoaded) {
                final result = state.result;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = result[index];
                      return MovieCard<Tv>(movie);
                    },
                    itemCount: result.length,
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            },
          );
  }
}
