import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/student/bloc/get_all_registered_class_bloc/all_registered_class_bloc.dart';
import 'package:school_project/student/model/regisgeter_class_Model.dart';
import 'package:school_project/student/pages/selected_class_page_student.dart';

class StudentHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<AllRegisteredClassBloc, AllRegisteredClassState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadingAllRegisteredClassState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadedAllRegisteredClassState) {
            return RefreshIndicator(
              onRefresh: () async =>
                  BlocProvider.of<AllRegisteredClassBloc>(context)
                      .add(FetchAllRegisteredClassEvent()),
              child: AllRegisteredClassesListView(classes: state.classes),
            );
          } else if (state is ErrorAllRegisteredClassState) {
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

class AllRegisteredClassesListView extends StatelessWidget {
  final List<RegisteredClassModel> classes;

  const AllRegisteredClassesListView({Key key, this.classes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (classes.isEmpty) {
      return ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 200),
            child: Center(
              child: Text(
                'It seems you have not join any class yet. \n\n Click on the add new class button below or refresh the page',
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
        RegisteredClassModel currentClass = classes[index];
        return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SelectedClassPageStudent(currentClass))),
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
                        currentClass?.classId?.className ?? 'test',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Text(
                        currentClass?.classId?.description ?? 'des',
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
                    Text((currentClass?.classId?.isOpened ?? true) == true
                        ? 'Opened '
                        : 'Closed '),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor:
                          (currentClass?.classId?.isOpened ?? true) == true
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
