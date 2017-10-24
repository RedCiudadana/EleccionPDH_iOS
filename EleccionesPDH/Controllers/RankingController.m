//
//  RankingController.m
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/14/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "RankingController.h"
#import <Restkit/Restkit.h>
#import "CandidatoCell.h"
#import "GradeCell.h"
#import "HeaderCell.h"
#import "Perfil+CoreDataClass.h"
#import "TablaGradacion+CoreDataClass.h"

@interface RankingController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>{
    NSMutableArray *rankExpandBooleans;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *perfilFRC;

@end

@implementation RankingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_logo"]];
    
    _tableView.estimatedRowHeight = 44.0f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedSectionHeaderHeight = 44.0f;
    _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    [_tableView setNeedsLayout];
    [_tableView layoutIfNeeded];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Perfil"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"grade" ascending:NO];
    fetchRequest.sortDescriptors = @[sortDescriptor];
//    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"grade > 0"];
    NSError *error = nil;
    _perfilFRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                     managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext
                                                       sectionNameKeyPath:nil
                                                                cacheName:nil];
    _perfilFRC.delegate = self;
    BOOL fetchSuccessful = [_perfilFRC performFetch:&error];
    if (! fetchSuccessful) {
        
    }
    
    rankExpandBooleans = [NSMutableArray new];
    for (int i = 0; i <= _perfilFRC.fetchedObjects.count; i++) {
        [rankExpandBooleans addObject:@NO];
    }
    
    // Request data from servers
    [self loadData];
}

- (void)loadData{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"perfil.json"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  NSLog(@"Load Candidato Succes: %@", operation.description);
                                                  NSLog(@"responseString: %@", operation.HTTPRequestOperation.responseString);
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"Load Candidato Error: %@", [error localizedDescription]);
                                                  NSLog(@"error: %@", [error userInfo]);
                                              }];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"tabla-gradacion.json"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  NSLog(@"Load Gradacion Succes: %@", operation.description);
                                                  NSLog(@"responseString: %@", operation.HTTPRequestOperation.responseString);
                                                  for (Perfil *perfil in _perfilFRC.fetchedObjects) {
                                                      [perfil updateGrade];
                                                  }
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"Load Gradacion Error: %@", [error localizedDescription]);
                                                  NSLog(@"error: %@", [error userInfo]);
                                              }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


#pragma mark NSFetchedResultsControllerDelegate methods
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"numberOfSections: %ld", _perfilFRC.fetchedObjects.count);
    return _perfilFRC.fetchedObjects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[rankExpandBooleans objectAtIndex:section] boolValue]) {
        Perfil *perfil = [_perfilFRC.fetchedObjects objectAtIndex:section];
        return perfil.gradacion.count + 1;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reusableIdentifier;
    
    if (indexPath.row == 0) {
        reusableIdentifier = @"candidato_cell";
    }else{
        reusableIdentifier = @"grade_cell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier forIndexPath:indexPath];
    Perfil *perfil = [_perfilFRC.fetchedObjects objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        [((CandidatoCell *)cell).pictureIV setImageWithURL:[NSURL URLWithString:[perfil.fotoUrl stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]] placeholderImage:[UIImage new]];
        ((CandidatoCell *)cell).pictureIV.layer.cornerRadius = ((CandidatoCell *)cell).pictureIV.frame.size.height/2;
        ((CandidatoCell *)cell).pictureIV.clipsToBounds = YES;
        ((CandidatoCell *)cell).nameL.text = [NSString stringWithFormat:@"%@", perfil.nombre];
        ((CandidatoCell *)cell).indexL.text = [NSString stringWithFormat:@"%ld", indexPath.section+1];
        ((CandidatoCell *)cell).gradeL.text = [NSString stringWithFormat:@"%lld", perfil.grade];
    }else{
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"aspecto" ascending:YES];
        TablaGradacion *grade = [[[[perfil gradacion] allObjects] sortedArrayUsingDescriptors:@[sortDescriptor]] objectAtIndex:indexPath.row-1];
        ((GradeCell *)cell).titleL.text = grade.aspecto;
        ((GradeCell *)cell).gradeL.text = [NSString stringWithFormat:@"%lld", grade.puntaje];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header_cell"];
        cell.titleL.text = @"Tabla de Gradación";
        return cell.contentView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if ([[rankExpandBooleans objectAtIndex:indexPath.section] boolValue]) {
            [rankExpandBooleans setObject:@NO atIndexedSubscript:indexPath.section];
        }else{
            [rankExpandBooleans setObject:@YES atIndexedSubscript:indexPath.section];
        }
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


@end
