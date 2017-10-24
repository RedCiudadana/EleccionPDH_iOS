//
//  Perfil+CoreDataProperties.h
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/16/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "Perfil+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Perfil (CoreDataProperties)

+ (NSFetchRequest<Perfil *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *asistencia;
@property (nullable, nonatomic, copy) NSString *biografia;
@property (nullable, nonatomic, copy) NSString *cargo;
@property (nullable, nonatomic, copy) NSString *cargoNombreCorto;
@property (nullable, nonatomic, copy) NSString *comision;
@property (nullable, nonatomic, copy) NSString *comision2;
@property (nullable, nonatomic, copy) NSString *comision3;
@property (nullable, nonatomic, copy) NSString *desempenio;
@property (nullable, nonatomic, copy) NSString *direccion;
@property (nullable, nonatomic, copy) NSString *distrito;
@property (nullable, nonatomic, copy) NSString *educacion;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *experienciaEnDH;
@property (nullable, nonatomic, copy) NSString *experienciaProfesional;
@property (nullable, nonatomic, copy) NSString *fb;
@property (nullable, nonatomic, copy) NSDate *fechaNacimiento;
@property (nullable, nonatomic, copy) NSString *fotoUrl;
@property (nullable, nonatomic, copy) NSString *historialPolitico;
@property (nullable, nonatomic, copy) NSString *idPerfil;
@property (nullable, nonatomic, copy) NSString *institucion;
@property (nullable, nonatomic, copy) NSString *lugarNacimiento;
@property (nullable, nonatomic, copy) NSString *nombre;
@property (nullable, nonatomic, copy) NSString *partidoActual;
@property (nullable, nonatomic, copy) NSString *partidoPostulante;
@property (nullable, nonatomic, copy) NSString *planTrabajo;
@property (nullable, nonatomic, copy) NSString *profesion;
@property (nullable, nonatomic, copy) NSString *sexo;
@property (nullable, nonatomic, copy) NSString *telefono;
@property (nullable, nonatomic, copy) NSString *tw;
@property (nullable, nonatomic, copy) NSString *web;
@property (nonatomic) int64_t grade;
@property (nullable, nonatomic, retain) NSSet<TablaGradacion *> *gradacion;

- (void)updateGrade;

@end

@interface Perfil (CoreDataGeneratedAccessors)

- (void)addGradacionObject:(TablaGradacion *)value;
- (void)removeGradacionObject:(TablaGradacion *)value;
- (void)addGradacion:(NSSet<TablaGradacion *> *)values;
- (void)removeGradacion:(NSSet<TablaGradacion *> *)values;

@end

NS_ASSUME_NONNULL_END
