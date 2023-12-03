import 'package:flutter/material.dart';
import 'dart:ui';
import 'Task.dart';
import 'TaskList.dart';
import 'package:pomodor/auxiliar.dart';

abstract class SortingStrategy {
  int compare(Task a, Task b);
}

class SubjectSortingStrategy implements SortingStrategy {
  @override
  int compare(Task a, Task b) {
    if (a.getIfFinished == b.getIfFinished) {
      return a.getSubject.toLowerCase().compareTo(b.getSubject.toLowerCase());
    }
    return a.getIfFinished ? 1 : -1;
  }
}


class ExpDateSortingStrategy implements SortingStrategy {
  @override
  int compare(Task a, Task b) {
    if (a.getIfFinished == b.getIfFinished) {
      return a.getDate.compareTo(b.getDate);
    }
    return a.getIfFinished ? 1 : -1;
  }
}


class DefaultSortingStrategy implements SortingStrategy {
  @override
  int compare(Task a, Task b) {
    if (a.getIfFinished == b.getIfFinished) {
      return -a.getUrgency.getNumber.compareTo(b.getUrgency.getNumber);
    }
    return a.getIfFinished ? 1 : -1;
  }
}


class SortingStrategyFactory {
  static final Map<String, SortingStrategy> _strategies = {
    'subject': SubjectSortingStrategy(),
    'expDate': ExpDateSortingStrategy(),
    'urgency': DefaultSortingStrategy(),
  };

  static SortingStrategy getSortingStrategy(String orderType) {
    return _strategies[orderType] as SortingStrategy ?? _strategies['urgency']!;
  }
}
