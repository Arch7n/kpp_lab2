import 'carrier.dart';
import 'parcel_status.dart';

/// Immutable parcel model
class Parcel {
  const Parcel({
    required this.title,
    required this.trackingNumber,
    required this.carrier,
    required this.status,
    required this.updatedAt,
  });

  final String title;
  final String trackingNumber;
  final Carrier carrier;
  final ParcelStatus status;

  /// Human readable time of the last status change, e.g. "Сьогодні, 09:12"
  final String updatedAt;
}
