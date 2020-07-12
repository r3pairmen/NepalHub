// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoriesStore on _CategoriesStore, Store {
  final _$errorAtom = Atom(name: '_CategoriesStore.error');

  @override
  String get error {
    _$errorAtom.context.enforceReadPolicy(_$errorAtom);
    _$errorAtom.reportObserved();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.context.conditionallyRunInAction(() {
      super.error = value;
      _$errorAtom.reportChanged();
    }, _$errorAtom, name: '${_$errorAtom.name}_set');
  }

  final _$apiErrorAtom = Atom(name: '_CategoriesStore.apiError');

  @override
  APIException get apiError {
    _$apiErrorAtom.context.enforceReadPolicy(_$apiErrorAtom);
    _$apiErrorAtom.reportObserved();
    return super.apiError;
  }

  @override
  set apiError(APIException value) {
    _$apiErrorAtom.context.conditionallyRunInAction(() {
      super.apiError = value;
      _$apiErrorAtom.reportChanged();
    }, _$apiErrorAtom, name: '${_$apiErrorAtom.name}_set');
  }

  final _$activeCategoryTabAtom =
      Atom(name: '_CategoriesStore.activeCategoryTab');

  @override
  String get activeCategoryTab {
    _$activeCategoryTabAtom.context.enforceReadPolicy(_$activeCategoryTabAtom);
    _$activeCategoryTabAtom.reportObserved();
    return super.activeCategoryTab;
  }

  @override
  set activeCategoryTab(String value) {
    _$activeCategoryTabAtom.context.conditionallyRunInAction(() {
      super.activeCategoryTab = value;
      _$activeCategoryTabAtom.reportChanged();
    }, _$activeCategoryTabAtom, name: '${_$activeCategoryTabAtom.name}_set');
  }

  final _$viewAtom = Atom(name: '_CategoriesStore.view');

  @override
  ContentViewType get view {
    _$viewAtom.context.enforceReadPolicy(_$viewAtom);
    _$viewAtom.reportObserved();
    return super.view;
  }

  @override
  set view(ContentViewType value) {
    _$viewAtom.context.conditionallyRunInAction(() {
      super.view = value;
      _$viewAtom.reportChanged();
    }, _$viewAtom, name: '${_$viewAtom.name}_set');
  }

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_loadCategoriesAsyncAction = AsyncAction('_loadCategories');

  @override
  Future<void> _loadCategories() {
    return _$_loadCategoriesAsyncAction.run(() => super._loadCategories());
  }

  final _$_CategoriesStoreActionController =
      ActionController(name: '_CategoriesStore');

  @override
  void loadData() {
    final _$actionInfo = _$_CategoriesStoreActionController.startAction();
    try {
      return super.loadData();
    } finally {
      _$_CategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_CategoriesStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_CategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setActiveCategoryTab(String categoryCode) {
    final _$actionInfo = _$_CategoriesStoreActionController.startAction();
    try {
      return super.setActiveCategoryTab(categoryCode);
    } finally {
      _$_CategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setView(ContentViewType value) {
    final _$actionInfo = _$_CategoriesStoreActionController.startAction();
    try {
      return super.setView(value);
    } finally {
      _$_CategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'error: ${error.toString()},apiError: ${apiError.toString()},activeCategoryTab: ${activeCategoryTab.toString()},view: ${view.toString()}';
    return '{$string}';
  }
}
