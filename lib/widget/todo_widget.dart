import 'package:care_connect/api/notification_api.dart';
import 'package:care_connect/model/todos_model.dart';
import 'package:care_connect/pages/remainder_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../custom_style.dart';
import '../model/users_data.dart';
import '../pages/edit_todo_page.dart';
import '../providers/todos_provider.dart';
import '../utils.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TodoWidget extends StatefulWidget {
  final Todo todo;
  const TodoWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  @override
  void initState() {
    super.initState();

    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.pushNamed(
        context,
        ReminderPage.pageRout,
      );
  // Navigator.of(context).push(
  //     MaterialPageRoute(builder: (context) => ReminderPage(payload: payload)));

  // DateTime selectedDate = DateTime.now();

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(1900),
  //       lastDate: DateTime(2100));
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //       Var.dateofbirth = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        actionPane: const SlidableDrawerActionPane(),
        key: Key(widget.todo.id.toString()),
        actions: [
          IconSlideAction(
            color: Colors.green,
            onTap: () => editTodo(context, widget.todo),
            caption: 'Edit',
            icon: Icons.edit,
          )
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            caption: 'Delete',
            onTap: () => deleteTodo(context, widget.todo),
            icon: Icons.delete,
          )
        ],
        child: buildTodo(context),
      ),
    );
  }

  //  final hours = time.hour.toString().padLeft(2, '0');
  //  final minutes = time.minute.toString().padLeft(2, '0');
  Widget buildTodo(BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return GestureDetector(
      onTap: () => editTodo(context, widget.todo),
      child: Container(
        color: const Color(0xFFE5E5E5),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 21),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                  value: widget.todo.isDone,
                  onChanged: (_) {
                    final provider =
                        Provider.of<TodosProvider>(context, listen: false);
                    final isDone = provider.toggleTodoStatus(widget.todo);

                    Utils.showSnackBar(
                      context,
                      isDone ? 'Task completed' : 'Task marked incomplete',
                    );
                  },
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.todo.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                        ),
                      ),
                      if (widget.todo.description.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            widget.todo.description,
                            style: TextStyle(fontSize: 20, height: 1.5),
                          ),
                        ),
                      // const Text('Hello'),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 45,
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: CustomColors.primaryLightBlue,
                                  side: const BorderSide(
                                      color: Colors.white, width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10), // <-- Radius
                                  ),
                                ),
                                onPressed: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                  );

                                  //?if 'CANCLE' => null
                                  if (newTime == null) return;
                                  //? if 'OK' => TimeOfDay
                                  setState(() => time = newTime);
                                },
                                child: Text('$hours : $minutes',
                                    textAlign: TextAlign.left,
                                    style: CustomTextStyle.style(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    )),
                              )),
                          const SizedBox(width: 10),
                          //? The "Notify me" button
                          ElevatedButton(
                            onPressed: () => NotificationApi.showNotification(
                              title: widget.todo.title,
                              body: widget.todo.description,
                              payload: '',
                            ),
                            child: const Text("Notify me"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}
