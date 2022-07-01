import 'package:flutter/material.dart';

import '../custom_style.dart';
import '../widget/add_todo_dialog_widget.dart';
import '../widget/completed_list_widget.dart';
import '../widget/todo_list_widget.dart';

class ReminderPage extends StatefulWidget {
  final String? payload;
  const ReminderPage({Key? key, this.payload}) : super(key: key);
  static const String pageRout = 'reminder_page';

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage>
    with SingleTickerProviderStateMixin {
  //?Custom controller for Tabs
  late TabController controller;

  //?Initialising the controller
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  //?To clean the controller
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reminders',
          style: CustomTextStyle.style(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.primaryNormalBlue,
        bottom: TabBar(controller: controller, tabs: [
          Text(
            'To-Take',
            style: CustomTextStyle.style(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          Text(
            'Taken',
            style: CustomTextStyle.style(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ]),
      ),
      body: TabBarView(controller: controller, children: [
        const TodoListWidget(),
        CompletedListWidget(),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: CustomColors.primaryNormalBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AddTodoDialogWidget(),
          barrierDismissible: true,
        ),
      ),
    );
  }
}
