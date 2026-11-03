import 'dart:async';

import 'package:flutter/foundation.dart';

import '../errors/auth_failure.dart';
import '../services/crash_reporter.dart';

/// База для контролерів: стан «завантаження / помилка» в одному місці.
/// Метод [run] одночасно виконує дію, блокує повторний виклик і
/// перетворює будь-який виняток на текст помилки для UI.
abstract class AsyncController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  AuthFailure? _lastFailure;
  bool _disposed = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AuthFailure? get lastFailure => _lastFailure;

  /// Тихе скидання помилки (без notify) — викликати в initState екрана,
  /// щоб помилка з попереднього екрана не «просочилась» на новий.
  void resetError() {
    _errorMessage = null;
    _lastFailure = null;
  }

  /// Повертає true, якщо дія успішна.
  /// Якщо вже виконується інша дія — ігнорує виклик (захист від дублів).
  Future<bool> run(
    Future<void> Function() action, {
    required String reason,
  }) async {
    if (_isLoading) return false;

    _isLoading = true;
    _errorMessage = null;
    _lastFailure = null;
    notifyListeners();

    try {
      await action();
      return true;
    } on AuthFailure catch (e, st) {
      _lastFailure = e;
      if (!e.isCancelled) _errorMessage = e.message;
      if (e.unexpected) {
        unawaited(
          CrashReporter.recordNonFatal(e, st, reason: 'Auth: $reason'),
        );
      }
      return false;
    } catch (e, st) {
      _errorMessage = 'Сталася помилка. Спробуйте ще раз';
      unawaited(
        CrashReporter.recordNonFatal(e, st, reason: 'Unexpected: $reason'),
      );
      return false;
    } finally {
      _isLoading = false;
      if (!_disposed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
