// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(faultList)
final faultListProvider = FaultListProvider._();

final class FaultListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Fault>>,
          List<Fault>,
          FutureOr<List<Fault>>
        >
    with $FutureModifier<List<Fault>>, $FutureProvider<List<Fault>> {
  FaultListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'faultListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$faultListHash();

  @$internal
  @override
  $FutureProviderElement<List<Fault>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Fault>> create(Ref ref) {
    return faultList(ref);
  }
}

String _$faultListHash() => r'5cb8f001e3c5116d37709a8fbef96f1d9aa46195';

/// Faults filtered by category.

@ProviderFor(faultsByCategory)
final faultsByCategoryProvider = FaultsByCategoryFamily._();

/// Faults filtered by category.

final class FaultsByCategoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Fault>>,
          List<Fault>,
          FutureOr<List<Fault>>
        >
    with $FutureModifier<List<Fault>>, $FutureProvider<List<Fault>> {
  /// Faults filtered by category.
  FaultsByCategoryProvider._({
    required FaultsByCategoryFamily super.from,
    required FaultCategory super.argument,
  }) : super(
         retry: null,
         name: r'faultsByCategoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$faultsByCategoryHash();

  @override
  String toString() {
    return r'faultsByCategoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Fault>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Fault>> create(Ref ref) {
    final argument = this.argument as FaultCategory;
    return faultsByCategory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FaultsByCategoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$faultsByCategoryHash() => r'ae57d7ff4d1da80db6f58d24b0dd5570e8948a6f';

/// Faults filtered by category.

final class FaultsByCategoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Fault>>, FaultCategory> {
  FaultsByCategoryFamily._()
    : super(
        retry: null,
        name: r'faultsByCategoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Faults filtered by category.

  FaultsByCategoryProvider call(FaultCategory category) =>
      FaultsByCategoryProvider._(argument: category, from: this);

  @override
  String toString() => r'faultsByCategoryProvider';
}

@ProviderFor(faultMatcher)
final faultMatcherProvider = FaultMatcherProvider._();

final class FaultMatcherProvider
    extends $FunctionalProvider<FaultMatcher, FaultMatcher, FaultMatcher>
    with $Provider<FaultMatcher> {
  FaultMatcherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'faultMatcherProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$faultMatcherHash();

  @$internal
  @override
  $ProviderElement<FaultMatcher> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FaultMatcher create(Ref ref) {
    return faultMatcher(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FaultMatcher value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FaultMatcher>(value),
    );
  }
}

String _$faultMatcherHash() => r'89924469fb387768c48df8878029fb71f2ee6b24';

@ProviderFor(LocalePreference)
final localePreferenceProvider = LocalePreferenceProvider._();

final class LocalePreferenceProvider
    extends $NotifierProvider<LocalePreference, String> {
  LocalePreferenceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localePreferenceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localePreferenceHash();

  @$internal
  @override
  LocalePreference create() => LocalePreference();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$localePreferenceHash() => r'7bf5079120eaa1f63efb251332516689e629db3d';

abstract class _$LocalePreference extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
