import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

final jobKnowledgeSummaryProvider = FutureProvider<JobKnowledgeSummary>((
  ref,
) async {
  return ref.read(clientProvider).jobKnowledge.getSummary();
});

final jobKnowledgeDraftProvider = FutureProvider<JobKnowledgeDraft>((
  ref,
) async {
  return ref.read(clientProvider).jobKnowledge.getDraft();
});
