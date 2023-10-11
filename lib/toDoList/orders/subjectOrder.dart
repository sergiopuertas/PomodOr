import 'task.dart';
import 'dart:core';
import 'orders_interface.dart';


class subjectOrder implements order{
  @override
  void orderList(){
    tasks.sort((task1, task2) => task1.subject.compareTo(task2.expeditionDate));
  }
}