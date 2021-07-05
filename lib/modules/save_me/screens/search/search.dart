import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:save_me/modules/save_me/models/post.dart';
import 'package:save_me/modules/save_me/repositories/post_repository.dart';
import 'package:save_me/modules/save_me/screens/search/bloc/search_bloc.dart';
import 'package:save_me/widgets/post/post_view.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final PostRepository _postRepository = PostRepository();
  final TextEditingController _searchController = TextEditingController();
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchController.addListener(_onSearchChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final List<String> labels = [
          "Missing",
          "Finding",
          "Female",
          "Male",
          "Toddler, 2-3 years",
          "Child, 3-13 years",
          "Teenager, 13-19 years",
          "Adult, 19-60 years",
          "Elderly, 60+ years old",
        ];

        final List<bool> truth = [
          state.isMissing,
          state.isFinding,
          state.isFemale,
          state.isMale,
          state.isToddler,
          state.isChild,
          state.isTeenager,
          state.isAdult,
          state.isElderly,
        ];

        final List<Function> onChange = [
          _onFilterMissingChange,
          _onFilterFindingChange,
          _onFilterFemaleChange,
          _onFilterMaleChange,
          _onFilterToddlerChange,
          _onFilterChildChange,
          _onFilterTeenagerChange,
          _onFilterAdultChange,
          _onFilterElderlyChange,
        ];

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 120,
            title: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                isDense: true,
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.image),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Theme.of(context).primaryColor,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return FilterChip(
                      checkmarkColor: Theme.of(context).primaryColor,
                      selectedColor: Theme.of(context).canvasColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      selected: truth[index],
                      label: Text(labels[index]),
                      onSelected: onChange[index],
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    width: 1,
                    margin: EdgeInsets.all(9),
                    color: Theme.of(context).canvasColor,
                  ),
                  itemCount: labels.length,
                ),
              ),
              preferredSize: Size.fromHeight(kToolbarHeight),
            ),
          ),
          body: Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                state.search.isNotEmpty || state.isPopulated,
            widgetBuilder: (context) {
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _postRepository.posts,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else {
                        QuerySnapshot documents = snapshot.data;
                        List<DocumentSnapshot> docs = documents.docs;

                        return viewPosts(
                          context: context,
                          posts: docs.where((post) {
                            Map<String, dynamic> map = post.data();
                            return map['name']
                                .toLowerCase()
                                .contains(state.search);
                          }).where((post) {
                            Map<String, dynamic> map = post.data();

                            bool target = true;

                            target = state.isMissing
                                ? map.containsKey('missingFrom')
                                : target;

                            target = state.isFinding
                                ? (!map.containsKey('missingFrom'))
                                : target;

                            target = state.isFemale
                                ? map['sex'] == 'female'
                                : target;

                            target =
                                state.isMale ? map['sex'] == 'male' : target;

                            target = state.isToddler
                                ? 2 <= map['age'] && 3 >= map['age']
                                : target;

                            target = state.isChild
                                ? 13 < map['age'] && 19 >= map['age']
                                : target;

                            target = state.isTeenager
                                ? 13 < map['age'] && 19 >= map['age']
                                : target;

                            target = state.isAdult
                                ? 19 < map['age'] && 60 >= map['age']
                                : target;

                            target = state.isElderly ? map['age'] > 60 : target;

                            return target;
                          }).map((post) {
                            Map<String, dynamic> map = post.data();
                            return map.containsKey('missingFrom')
                                ? Missing.fromMap(map)
                                : Finding.fromMap(map);
                          }).toList(),
                        );
                      }
                  }
                },
              );
            },
            fallbackBuilder: (context) {
              // image recognize
              return SizedBox();
            },
          ),
        );
      },
    );
  }

  void _onSearchChange() {
    _searchBloc.add(SearchChange(search: _searchController.text));
  }

  void _onFilterMissingChange(bool isMissing) {
    _searchBloc.add(
      FilterMissingChange(isMissing: isMissing),
    );
  }

  void _onFilterFindingChange(bool isFinding) {
    _searchBloc.add(
      FilterFindingChange(isFinding: isFinding),
    );
  }

  void _onFilterFemaleChange(bool isFemale) {
    _searchBloc.add(
      FilterFemaleChange(isFemale: isFemale),
    );
  }

  void _onFilterMaleChange(bool isMale) {
    _searchBloc.add(
      FilterMaleChange(isMale: isMale),
    );
  }

  void _onFilterToddlerChange(bool isToddler) {
    _searchBloc.add(
      FilterToddlerChange(isToddler: isToddler),
    );
  }

  void _onFilterChildChange(bool isChild) {
    _searchBloc.add(
      FilterChildChange(isChild: isChild),
    );
  }

  void _onFilterTeenagerChange(bool isTeenager) {
    _searchBloc.add(
      FilterTeenagerChange(isTeenager: isTeenager),
    );
  }

  void _onFilterAdultChange(bool isAdult) {
    _searchBloc.add(
      FilterAdultChange(isAdult: isAdult),
    );
  }

  void _onFilterElderlyChange(bool isElderly) {
    _searchBloc.add(
      FilterElderlyChange(isElderly: isElderly),
    );
  }
}
