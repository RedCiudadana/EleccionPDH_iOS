//
//  Perfil+CoreDataProperties.m
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/16/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "Perfil+CoreDataProperties.h"
#import <Restkit/Restkit.h>
#import "TablaGradacion+CoreDataClass.h"

@implementation Perfil (CoreDataProperties)

+ (NSFetchRequest<Perfil *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Perfil"];
}

@dynamic asistencia;
@dynamic biografia;
@dynamic cargo;
@dynamic cargoNombreCorto;
@dynamic comision;
@dynamic comision2;
@dynamic comision3;
@dynamic desempenio;
@dynamic direccion;
@dynamic distrito;
@dynamic educacion;
@dynamic email;
@dynamic experienciaEnDH;
@dynamic experienciaProfesional;
@dynamic fb;
@dynamic fechaNacimiento;
@dynamic fotoUrl;
@dynamic historialPolitico;
@dynamic idPerfil;
@dynamic institucion;
@dynamic lugarNacimiento;
@dynamic nombre;
@dynamic partidoActual;
@dynamic partidoPostulante;
@dynamic planTrabajo;
@dynamic profesion;
@dynamic sexo;
@dynamic telefono;
@dynamic tw;
@dynamic web;
@dynamic grade;
@dynamic gradacion;

- (void)updateGrade{
    NSManagedObjectContext *managedObjectcontext = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TablaGradacion"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"aspecto" ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    request.predicate = [NSPredicate predicateWithFormat:@"perfil = %@", [self idPerfil]];
    NSError *error = nil;
    NSArray *results = [managedObjectcontext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Session objects: %@/%@", [error localizedDescription], [error userInfo]);
    }else{
        for (TablaGradacion *tabla in results) {
            if ([tabla.aspecto isEqualToString:@"Total"]) {
                [self setGrade:tabla.puntaje];
            }else{
                [self addGradacionObject:tabla];
            }
        }
    }
}

@end
