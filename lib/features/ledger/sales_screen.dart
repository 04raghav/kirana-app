import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/ledger/ledger_service.dart';
import 'purchases_screen.dart';
import '../../database/database.dart';

class SalesScreen extends ConsumerStatefulWidget {
  const SalesScreen({super.key});

  @override
  ConsumerState<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends ConsumerState<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales')),
      body: FutureBuilder<List<Ledger>>(
        future: ref.read(ledgerServiceProvider).getLedgersByTypeAndDate('sale'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final ledgers = snapshot.data ?? [];
          if (ledgers.isEmpty) return const Center(child: Text('No sales yet'));

          final Map<String, List<Ledger>> grouped = {};
          for (final l in ledgers) {
            final key = DateTime(
              l.date.year,
              l.date.month,
              l.date.day,
            ).toIso8601String();
            grouped.putIfAbsent(key, () => []).add(l);
          }

          final dates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

          return ListView.builder(
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final dateKey = dates[index];
              final dateLedgers = grouped[dateKey]!;
              final date = DateTime.parse(dateKey);
              final total = dateLedgers.fold<double>(
                0,
                (s, l) => s + l.totalAmount,
              );
              return ListTile(
                title: Text('${date.day}-${date.month}-${date.year}'),
                subtitle: Text('Total: ₹${total.toStringAsFixed(2)}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SalesDateDetailScreen(date: date),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class SalesDateDetailScreen extends ConsumerWidget {
  final DateTime date;
  const SalesDateDetailScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales ${date.day}-${date.month}-${date.year}'),
      ),
      body: FutureBuilder<List<Ledger>>(
        future: ref.read(ledgerServiceProvider).getLedgersForDate(date, 'sale'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return const Center(child: CircularProgressIndicator());
          final ledgers = snapshot.data ?? [];
          if (ledgers.isEmpty)
            return const Center(child: Text('No sales for this date'));
          return ListView.builder(
            itemCount: ledgers.length,
            itemBuilder: (context, idx) {
              final l = ledgers[idx];
              return ListTile(
                title: Text('Retailer ID: ${l.partyId}'),
                subtitle: Text(
                  'Total: ₹${l.totalAmount.toStringAsFixed(2)} | Remaining: ₹${l.remainingAmount.toStringAsFixed(2)}',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LedgerDetailScreen(ledger: l),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
