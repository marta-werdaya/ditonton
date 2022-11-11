import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';
import '../provider/tv_list_notifier.dart';
import '../widgets/build_subheading.dart';
import '../widgets/poster_list.dart';

class TvPage extends StatefulWidget {
  const TvPage({super.key});
  static const ROUTE_NAME = '/tvpage';

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchPopularTv()
      ..fetchNowPlayingTv()
      ..fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildSubHeading(
                title: 'Popular',
                onTap: () {},
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.popularState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return PosterList<Tv>(data.popularTv);
                } else {
                  return Text('Failed');
                }
              }),
              BuildSubHeading(
                title: 'Now Playing',
                onTap: () {},
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return PosterList<Tv>(data.nowPlayingTv);
                } else {
                  return Text('Failed');
                }
              }),
              BuildSubHeading(
                title: 'Top Rated',
                onTap: () {},
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.topRatedState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return PosterList<Tv>(data.topRatedTv);
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
