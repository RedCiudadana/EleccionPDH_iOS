//
//  AppDelegate.m
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/14/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "AppDelegate.h"
#import <Restkit/CoreData.h>
#import <Restkit/Restkit.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Initialize Crashlytics
//    [Fabric with:@[[Crashlytics class]]];
//    [[Fabric sharedSDK] setDebug: YES];
//    
    
    // Initialize networking settings
    NSURL *baseURL = [NSURL URLWithString:@"https://rawgit.com/RedCiudadana/JusticiaAbiertaBeta/master/public/static-files/"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    [objectManager.HTTPClient setDefaultHeader:@"User-Agent" value:[NSString stringWithFormat:@"%@/%@ (Mac OS X %@)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey], [[NSProcessInfo processInfo] operatingSystemVersionString]]];
    
    [RKObjectMapping alloc]; // This ensures you will actually insert at index 0!
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d-M-yyyy"];
    //    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    [[RKValueTransformer defaultValueTransformer] insertValueTransformer:dateFormatter atIndex:0];
    
    
    // Initialize managed object store
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    // Object Mapping
    RKEntityMapping *perfilMapping = [RKEntityMapping mappingForEntityForName:@"Perfil" inManagedObjectStore:managedObjectStore];
    perfilMapping.identificationAttributes = @[@"idPerfil"];
    [perfilMapping addAttributeMappingsFromDictionary:@{
                                                        @"id":@"idPerfil",
                                                        @"nombre":@"nombre",
                                                        @"fotoUrl":@"fotoUrl",
                                                        @"profesion":@"profesion",
                                                        @"educacion":@"educacion",
                                                        @"fechaNacimiento":@"fechaNacimiento",
                                                        @"institucion":@"institucion",
                                                        @"cargoNombreCorto":@"cargoNombreCorto",
                                                        @"cargo":@"cargo",
                                                        @"lugarNacimiento":@"lugarNacimiento",
                                                        @"distrito":@"distrito",
                                                        @"partidoPostulante":@"partidoPostulante",
                                                        @"partidoActual":@"partidoActual",
                                                        @"biografia":@"biografia",
                                                        @"desempenio":@"desempenio",
                                                        @"historialPolitico":@"historialPolitico",
                                                        @"asistencia":@"asistencia",
                                                        @"comision":@"comision",
                                                        @"comision2":@"comision2",
                                                        @"comision3":@"comision3",
                                                        @"email":@"email",
                                                        @"telefono":@"telefono",
                                                        @"direccion":@"direccion",
                                                        @"web":@"web",
                                                        @"fb":@"fb",
                                                        @"tw":@"tw",
                                                        @"sexo":@"sexo",
                                                        @"experienciaProfesional":@"experienciaProfesional",
                                                        @"experienciaEnDH":@"experienciaEnDH",
                                                        @"planTrabajo":@"planTrabajo"
                                                        }];
    
    RKEntityMapping *partidoMapping = [RKEntityMapping mappingForEntityForName:@"Partido" inManagedObjectStore:managedObjectStore];
    partidoMapping.identificationAttributes = @[@"idPartido"];
    [partidoMapping addAttributeMappingsFromDictionary:@{
                                                         @"id":@"idPartido",
                                                         @"codigo":@"codigo",
                                                         @"nombreCompleto":@"nombreCompleto",
                                                         @"nombreCorto":@"nombreCorto",
                                                         @"logo":@"logo",
                                                         @"presidenteBancadaID":@"presidenteBancadaID",
                                                         @"presidenteBancada":@"presidenteBancada",
                                                         @"web":@"web",
                                                         @"fb":@"fb",
                                                         @"tw":@"tw",
                                                         @"Yt":@"yt",
                                                         @"email":@"email",
                                                         @"telefono":@"telefono",
                                                         @"secretarioGeneral":@"secretarioGeneral",
                                                         @"fundacion":@"fundacion",
                                                         @"ideologiaPolitica":@"ideologiaPolitica",
                                                         @"sede":@"sede",
                                                         @"noDeAfiliados":@"noDeAfiliados",
                                                         @"telefono2":@"telefono2",
                                                         }];
    
    RKEntityMapping *diputadoMapping = [RKEntityMapping mappingForEntityForName:@"DiputadoComision" inManagedObjectStore:managedObjectStore];
    diputadoMapping.identificationAttributes = @[@"idDiputado"];
    [diputadoMapping addAttributeMappingsFromDictionary:@{
                                                          @"id":@"idDiputado",
                                                          @"nombre":@"nombre",
                                                          @"fotoUrl":@"fotoUrl",
                                                          @"profesion":@"profesion",
                                                          @"educacion":@"educacion",
                                                          @"fechaNacimiento":@"fechaNacimiento",
                                                          @"cargoNombreCorto":@"cargoNombreCorto",
                                                          @"cargo":@"cargo",
                                                          @"lugarNacimiento":@"lugarNacimiento",
                                                          @"distrito":@"distrito",
                                                          @"partidoPostulante":@"partidoPostulante",
                                                          @"partidoActual":@"partidoActual",
                                                          @"biografia":@"biografia",
                                                          @"desempenio":@"desempenio",
                                                          @"historialPolitico":@"historialPolitico",
                                                          @"email":@"email",
                                                          @"telefono":@"telefono",
                                                          @"direccion":@"direccion",
                                                          @"web":@"web",
                                                          @"fb":@"fb",
                                                          @"tw":@"tw",
                                                          @"sexo":@"sexo",
                                                          }];
    
    // Descriptors
    RKResponseDescriptor *perfilResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:perfilMapping
                                                                                                  method:RKRequestMethodGET
                                                                                             pathPattern:@"perfil.json"
                                                                                                 keyPath:nil
                                                                                             statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *partidoResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:partidoMapping
                                                                                                   method:RKRequestMethodGET
                                                                                              pathPattern:@"partido.json"
                                                                                                  keyPath:nil
                                                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *diputadoResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:diputadoMapping
                                                                                                    method:RKRequestMethodGET
                                                                                               pathPattern:@"diputados-comision.json"
                                                                                                   keyPath:nil
                                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:perfilResponseDescriptor];
    [objectManager addResponseDescriptor:partidoResponseDescriptor];
    [objectManager addResponseDescriptor:diputadoResponseDescriptor];
    
#ifdef RESTKIT_GENERATE_SEED_DB
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelInfo);
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelTrace);
    
    NSError *error = nil;
    BOOL success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error);
    if (! success) {
        RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error);
    }
    NSString *seedStorePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"RKSeedDatabase.sqlite"];
    //RKManagedObjectImporter *importer = [[RKManagedObjectImporter alloc] initWithManagedObjectModel:managedObjectModel storePath:seedStorePath];
    
    
    // Clear out the root view controller
    [self.window setRootViewController:[UIViewController new]];
#else
    /**
     Complete Core Data stack initialization
     */
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"EleccionPDH.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES,
                              NSInferMappingModelAutomaticallyOption: @YES};
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath
                                                                     fromSeedDatabaseAtPath:seedPath
                                                                          withConfiguration:nil
                                                                                    options:options
                                                                                      error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
#endif
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
