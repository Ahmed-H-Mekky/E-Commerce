abstract class StateFavorite {}

class InitialStat extends StateFavorite {}

class StateAddFavoriteList extends StateFavorite {
  final List<Map<String, dynamic>> items;
  StateAddFavoriteList({required this.items});
}

class StateRemove extends StateFavorite {
  final String title;
  StateRemove({required this.title});
}
