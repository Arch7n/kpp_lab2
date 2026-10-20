import 'package:flutter/material.dart';

import '../../core/data/mock_data.dart';
import '../../core/models/carrier.dart';
import '../../core/models/parcel.dart';
import '../../core/models/parcel_status.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/widgets.dart';

/// List of active parcels with filter chips over the hardcoded data
class ParcelsScreen extends StatefulWidget {
  const ParcelsScreen({super.key, this.onOpenParcel});

  final ValueChanged<Parcel>? onOpenParcel;

  @override
  State<ParcelsScreen> createState() => _ParcelsScreenState();
}

class _ParcelsScreenState extends State<ParcelsScreen> {
  static const List<String> _filters = [
    'Усі',
    'Нова пошта',
    'Укрпошта',
    'Meest',
    'У дорозі',
    'У відділенні',
    'Проблемні',
  ];

  int _selectedFilter = 0;

  bool _matchesFilter(Parcel parcel) => switch (_selectedFilter) {
        1 => parcel.carrier == Carrier.novaPoshta,
        2 => parcel.carrier == Carrier.ukrposhta,
        3 => parcel.carrier == Carrier.meest,
        4 => parcel.status == ParcelStatus.inTransit,
        5 => parcel.status == ParcelStatus.atBranch,
        6 => parcel.status == ParcelStatus.returned,
        _ => true,
      };

  @override
  Widget build(BuildContext context) {
    final openParcel = widget.onOpenParcel;
    final parcels = MockData.activeParcels.where(_matchesFilter);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Посилки'),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Сортування',
            icon: const Icon(Icons.sort),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.xs,
          AppSpacing.screen,
          AppSpacing.lg,
        ),
        children: [
          const AppSearchField(hintText: 'Пошук за номером або назвою'),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (var i = 0; i < _filters.length; i++)
                FilterChip(
                  label: Text(_filters[i]),
                  selected: i == _selectedFilter,
                  onSelected: (_) => setState(() => _selectedFilter = i),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final parcel in parcels)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: ParcelCard(
                parcel: parcel,
                onTap: openParcel == null ? null : () => openParcel(parcel),
              ),
            ),
          if (parcels.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: AppSpacing.xxl),
              child: Center(child: Text('Посилок не знайдено')),
            ),
        ],
      ),
    );
  }
}
