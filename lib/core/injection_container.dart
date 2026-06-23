import 'package:finly/data/datasources/local/app_database.dart';
import 'package:finly/data/repositories/transaction/transaction_repository_impl.dart';
import 'package:finly/domain/repositories/transaction/transaction_repository.dart';
import 'package:finly/domain/usecases/category/delete_category.dart';
import 'package:finly/domain/usecases/category/get_categories.dart';
import 'package:finly/domain/usecases/category/insert_category.dart';
import 'package:finly/domain/usecases/category/update_category.dart';
import 'package:finly/domain/usecases/transaction/delete_transaction.dart';
import 'package:finly/domain/usecases/transaction/get_transactions.dart';
import 'package:finly/domain/usecases/transaction/insert_transaction.dart';
import 'package:finly/domain/usecases/transaction/update_transaction.dart';
import 'package:finly/presentation/cubits/category/category_cubit.dart';
import 'package:finly/presentation/cubits/transaction/transaction_cubit.dart';
import 'package:get_it/get_it.dart';

import '../data/repositories/category/category_repository_impl.dart';
import '../domain/repositories/category/category_repository.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final database = AppDatabase();

  getIt.registerLazySingleton<AppDatabase>(() => database);

  // Repository
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(database: getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(database: getIt<AppDatabase>()),
  );

  // Usecase
  getIt.registerLazySingleton<GetCategoriesUseCases>(
    () => GetCategoriesUseCases(repository: getIt()),
  );
  getIt.registerLazySingleton<UpdateCategoryUseCases>(
    () => UpdateCategoryUseCases(repository: getIt()),
  );
  getIt.registerLazySingleton<InsertCategoryUseCases>(
    () => InsertCategoryUseCases(repository: getIt()),
  );
  getIt.registerLazySingleton<DeleteCategoryUseCases>(
    () => DeleteCategoryUseCases(repository: getIt()),
  );

  getIt.registerLazySingleton<GetTransactionsUseCase>(
    () => GetTransactionsUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<UpdateTransactionUseCase>(
    () => UpdateTransactionUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<InsertTransactionUseCase>(
    () => InsertTransactionUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<DeleteTransactionUseCase>(
    () => DeleteTransactionUseCase(repository: getIt()),
  );

  // Cubit
  getIt.registerFactory<CategoryCubit>(
    () => CategoryCubit(
      getCategoriesUseCases: getIt(),
      insertCategoryUseCases: getIt(),
      deleteCategoryUseCases: getIt(),
      updateCategoryUseCases: getIt(),
    ),
  );

  getIt.registerFactory<TransactionCubit>(
    () => TransactionCubit(
      getTransactionsUseCase: getIt(),
      insertTransactionUseCase: getIt(),
      deleteTransactionUseCase: getIt(),
      updateTransactionUseCase: getIt(),
    ),
  );
}
