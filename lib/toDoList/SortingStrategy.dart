import 'package:flutter/material.dart';
import 'dart:ui';
import 'Task.dart';
import 'TaskList.dart';

abstract class SortingStrategy {
  int compare(Task a, Task b);
}

class SubjectSortingStrategy implements SortingStrategy {
  @override
  int compare(Task a, Task b) => a.getSubject().toLowerCase().compareTo(b.getSubject().toLowerCase());
}

class ExpDateSortingStrategy implements SortingStrategy {
  @override
  int compare(Task a, Task b) => a.getDate().compareTo(b.getDate());
}

class DefaultSortingStrategy implements SortingStrategy {
  @override
  int compare(Task a, Task b) => -a.getUrgency().getNumber().compareTo(b.getUrgency().getNumber());
}

class SortingStrategyFactory {
  static final Map<String, SortingStrategy> _strategies = {
    'subject': SubjectSortingStrategy(),
    'expDate': ExpDateSortingStrategy(),
    'urgency': DefaultSortingStrategy(),
  };

  static SortingStrategy getSortingStrategy(String orderType) {
    return _strategies[orderType] as SortingStrategy ?? _strategies['expDate']!;
  }
}
