import 'package:domain/domain.module.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/infrastructure.module.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/dependencyInjection/dependency_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  externalPackageModulesAfter: [
    ExternalModule(InfrastructurePackageModule),
    ExternalModule(DomainPackageModule)
  ],
)
void configureInjection() => getIt.init(
      environment:
          const String.fromEnvironment('app.flavor', defaultValue: 'prod'),
    );
