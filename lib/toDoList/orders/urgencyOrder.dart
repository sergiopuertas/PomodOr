import 'task.dart';
import 'dart:core';
import 'orders_interface.dart';

class urgencyOrder implements order{
  @override
  void orderList(){
    tasks.sort((task1, task2) => task1.urgency.compareTo(task2.expeditionDate));
  }
}