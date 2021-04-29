import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/instructor/bloc/get_all_classes/get_all_classes_bloc.dart';
import 'package:school_project/instructor/model/class_model.dart';
import 'package:school_project/instructor/pages/selected_class_page.dart';
import 'package:flutter/services.dart';

class AllClassesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<GetAllClassesBloc, GetAllClassesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadingGetAllClassesState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadedGetAllClassesState) {
            return RefreshIndicator(
              onRefresh: () async => BlocProvider.of<GetAllClassesBloc>(context)
                  .add(FetchAllClassesEvent()),
              child: AllClassesListView(classes: state.classes),
            );
          } else if (state is ErrorGetAllClassesState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

class AllClassesListView extends StatelessWidget {
  final List<ClassModel> classes;

  const AllClassesListView({Key key, this.classes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (classes.isEmpty) {
      return ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 200),
            child: Center(
              child: Text(
                'Opps, No Class Found You This User \n\n Click On the Add New Class Button Below Or refresh the page',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      itemCount: classes.length,
      separatorBuilder: (_, index) => Divider(),
      itemBuilder: (context, index) {
        ClassModel currentClass = classes[index];
        print(currentClass.sId);
        return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SelectedClassPageInstructor(currentClass))),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(radius: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentClass.className,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Text(
                        currentClass.description,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 15),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(currentClass.isOpened == true ? 'Opened ' : 'Closed '),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: currentClass.isOpened == true
                          ? Colors.green
                          : Colors.red,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
