import 'task.dart';
import 'dart:core';
import 'orders_interface.dart';

class dateOrder implements order{
  @override
  void orderList(){
    tasks.sort((task1, task2) => task1.expeditionDate.compareTo(task2.expeditionDate));
  }
}