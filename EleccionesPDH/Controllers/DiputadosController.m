//
//  DiputadosController.m
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/14/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "DiputadosController.h"
#import <Restkit/Restkit.h>
#import "DiputadoDetailController.h"
#import "DiputadoCell.h"
#import "HeaderCell.h"
#import "DiputadoComision+CoreDataClass.h"

@interface DiputadosController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *diputadoFRC;

@end

@implementation DiputadosController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_logo"]];
    
    _tableView.estimatedRowHeight = 44.0f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedSectionHeaderHeight = 44.0f;
    _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    [_tableView setNeedsLayout];
    [_tableView layoutIfNeeded];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"DiputadoComision"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"idDiputado" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    NSError *error = nil;
    _diputadoFRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                     managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext
                                                       sectionNameKeyPath:nil
                                                                cacheName:nil];
    _diputadoFRC.delegate = self;
    BOOL fetchSuccessful = [_diputadoFRC performFetch:&error];
    if (! fetchSuccessful) {
        
    }
    
    // Request data from servers
    [self loadData];
}

- (void)loadData{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"diputados-comision.json"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  NSLog(@"Load Perfil Succes: %@", operation.description);
                                                  NSLog(@"responseString: %@", operation.HTTPRequestOperation.responseString);
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"Load Perfil Error: %@", [error localizedDescription]);
                                                  NSLog(@"error: %@", [error userInfo]);
                                              }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"diputado_segue"]) {
        ((DiputadoDetailController*)segue.destinationViewController).diputado = [_diputadoFRC objectAtIndexPath:[_tableView indexPathForSelectedRow]];
    }
}

#pragma mark NSFetchedResultsControllerDelegate methods
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[_diputadoFRC sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_diputadoFRC sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reusableIdentifier = @"diputado_cell";
    
    DiputadoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier forIndexPath:indexPath];
    DiputadoComision *diputado = [_diputadoFRC objectAtIndexPath:indexPath];
    
    [cell.pictureIV setImageWithURL:[NSURL URLWithString:diputado.fotoUrl] placeholderImage:[UIImage new]];
    cell.pictureIV.layer.cornerRadius = cell.pictureIV.frame.size.height/2;
    cell.pictureIV.clipsToBounds = YES;
    cell.nameL.text = diputado.nombre;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"diputado_segue" sender:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header_cell"];
    cell.titleL.text = @"Comisión Congreso Derechos Humanos";
    return cell.contentView;
}


@end
