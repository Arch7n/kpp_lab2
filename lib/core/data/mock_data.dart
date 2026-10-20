import '../models/carrier.dart';
import '../models/parcel.dart';
import '../models/parcel_status.dart';

/// One step of a parcel tracking history
typedef TrackingEvent = ({String title, String subtitle, String time});

/// Hardcoded data used instead of a backend
abstract final class MockData {
  // User
  static const String userFullName = 'Дмитро Чебаненко';
  static const String userGreetingName = 'Дмитре';
  static const String userInitial = 'Д';
  static const String userInitials = 'ДЧ';
  static const String userEmail = 'dmytro@gmail.com';
  static const String userPhone = '+380 67 123 45 67';

  // Counters shown on the home and archive screens
  static const int activeParcelsCount = 6;
  static const int archivedParcelsCount = 12;

  static const List<Parcel> activeParcels = [
    Parcel(
      title: 'Навушники Sony',
      trackingNumber: '20450912345678',
      carrier: Carrier.novaPoshta,
      status: ParcelStatus.atBranch,
      updatedAt: 'Сьогодні, 09:12',
    ),
    Parcel(
      title: 'Кросівки Nike Air',
      trackingNumber: '0600123456789',
      carrier: Carrier.ukrposhta,
      status: ParcelStatus.inTransit,
      updatedAt: 'Вчора, 18:40',
    ),
    Parcel(
      title: 'Чохол для телефону',
      trackingNumber: 'MYCUA00098765',
      carrier: Carrier.meest,
      status: ParcelStatus.inTransit,
      updatedAt: '27.09, 14:05',
    ),
    Parcel(
      title: 'Книга «Чистий код»',
      trackingNumber: '20450987654321',
      carrier: Carrier.novaPoshta,
      status: ParcelStatus.inTransit,
      updatedAt: '27.09, 11:30',
    ),
    Parcel(
      title: 'Павербанк Xiaomi',
      trackingNumber: '20450911122233',
      carrier: Carrier.novaPoshta,
      status: ParcelStatus.returned,
      updatedAt: '25.09, 16:20',
    ),
    Parcel(
      title: 'Монітор Samsung',
      trackingNumber: '0600998877665',
      carrier: Carrier.ukrposhta,
      status: ParcelStatus.inTransit,
      updatedAt: '24.09, 10:05',
    ),
  ];

  static const List<Parcel> archivedParcels = [
    Parcel(
      title: 'Клавіатура Logitech',
      trackingNumber: '20450900011122',
      carrier: Carrier.novaPoshta,
      status: ParcelStatus.received,
      updatedAt: '22.09',
    ),
    Parcel(
      title: 'Футболка',
      trackingNumber: '0600111222333',
      carrier: Carrier.ukrposhta,
      status: ParcelStatus.received,
      updatedAt: '18.09',
    ),
    Parcel(
      title: 'Кабель USB-C',
      trackingNumber: 'MYCUA00012345',
      carrier: Carrier.meest,
      status: ParcelStatus.received,
      updatedAt: '15.09',
    ),
    Parcel(
      title: 'Iphone',
      trackingNumber: '20450933344455',
      carrier: Carrier.novaPoshta,
      status: ParcelStatus.received,
      updatedAt: '10.09',
    ),
    Parcel(
      title: 'Навушники JBL',
      trackingNumber: '20450966677788',
      carrier: Carrier.novaPoshta,
      status: ParcelStatus.received,
      updatedAt: '03.09',
    ),
    Parcel(
      title: 'Мишка Logitech',
      trackingNumber: '0600444555666',
      carrier: Carrier.ukrposhta,
      status: ParcelStatus.received,
      updatedAt: '28.08',
    ),
  ];

  // Parcel details screen
  static const String branchTitle = 'Чекає у відділенні №12';
  static const String branchAddress = 'Львів, вул. Городоцька, 120';
  static const String storageNote = 'Безкоштовне зберігання до 03.10';

  static const List<TrackingEvent> trackingHistory = [
    (
      title: 'У відділенні',
      subtitle: 'Львів, відділення №12',
      time: '29.09, 09:12',
    ),
    (
      title: 'Прибула в місто',
      subtitle: 'Львів, сортувальний центр',
      time: '29.09, 06:40',
    ),
    (title: 'У дорозі', subtitle: 'Київ → Львів', time: '28.09, 21:15'),
    (
      title: 'Відправлено',
      subtitle: 'Київ, відділення №1',
      time: '28.09, 17:02',
    ),
    (
      title: 'Створено накладну',
      subtitle: 'Відправник: Rozetka',
      time: '28.09, 12:30',
    ),
  ];

  static const List<String> parcelPhotos = [
    'IMG_0412.jpg',
    'IMG_0413.jpg',
    'Упаковка.jpg',
  ];
}
