/// FaultMatcher interface and keyword-based implementation.
///
/// The interface exists so an LLM-based matcher can be swapped in later.
library;

import '../domain/fault.dart';

/// Abstract interface for matching user-described faults to known entries.
abstract class FaultMatcher {
  /// Returns the top [limit] matching faults for the given [query].
  List<Fault> match(String query, List<Fault> faults, {int limit = 3});
}

/// Keyword-based fault matcher — fully offline.
///
/// Tokenises the query and scores each fault by the number of keyword hits.
class KeywordFaultMatcher implements FaultMatcher {
  @override
  List<Fault> match(String query, List<Fault> faults, {int limit = 3}) {
    final queryTokens = _tokenise(query);
    if (queryTokens.isEmpty) return [];

    final scored = <_Scored>[];

    for (final fault in faults) {
      int score = 0;
      for (final token in queryTokens) {
        for (final keyword in fault.keywords) {
          if (keyword.toLowerCase().contains(token)) {
            score++;
          }
        }
        // Also search title for partial matches.
        if (fault.titleEn.toLowerCase().contains(token)) {
          score += 2;
        }
      }
      if (score > 0) {
        scored.add(_Scored(fault, score));
      }
    }

    scored.sort((a, b) => b.score.compareTo(a.score));
    return scored.take(limit).map((s) => s.fault).toList();
  }

  List<String> _tokenise(String text) {
    return text
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .where((t) => t.length > 1)
        .toList();
  }
}

class _Scored {
  _Scored(this.fault, this.score);
  final Fault fault;
  final int score;
}
