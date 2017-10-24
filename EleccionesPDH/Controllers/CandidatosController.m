//
//  CandidatosController.m
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/14/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "CandidatosController.h"
#import <Restkit/Restkit.h>
#import "CandidatoDetailController.h"
#import "CandidatoCell.h"
#import "HeaderCell.h"
#import "Perfil+CoreDataClass.h"
#import "HeaderView.h"

@interface CandidatosController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *perfilFRC;
@property (nonatomic, strong) HeaderView *headerView;

@end

@implementation CandidatosController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_logo"]];
    
//    _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 100.0)];
//    _tableView.tableHeaderView = _headerView;
    
    
    _tableView.estimatedRowHeight = 44.0f;
    _tableView.estimatedSectionHeaderHeight = 44.0f;
    _tableView.sectionHeaderHeight = 44.0f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [_tableView setNeedsLayout];
    [_tableView layoutIfNeeded];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Perfil"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"idPerfil" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    NSError *error = nil;
    _perfilFRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                     managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext
                                                       sectionNameKeyPath:nil
                                                                cacheName:nil];
    _perfilFRC.delegate = self;
    BOOL fetchSuccessful = [_perfilFRC performFetch:&error];
    if (! fetchSuccessful) {
        
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"candidato_segue"]) {
        ((CandidatoDetailController*)segue.destinationViewController).perfil = [_perfilFRC objectAtIndexPath:[_tableView indexPathForSelectedRow]];
    }
}


#pragma mark NSFetchedResultsControllerDelegate methods
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[_perfilFRC sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_perfilFRC sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reusableIdentifier = @"candidato_cell";
    
    CandidatoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier forIndexPath:indexPath];
    Perfil *perfil = [_perfilFRC objectAtIndexPath:indexPath];
    
    
   
    NSURL *url = [NSURL URLWithString:[perfil.fotoUrl stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]];
    [cell.pictureIV setImageWithURL:url placeholderImage:[UIImage new]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [cell.pictureIV setImageWithURLRequest:request placeholderImage:[UIImage new] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        NSLog(@"success response:%@", response);
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        NSLog(@"error request: %@", [request description]);
//        NSLog(@"error response:%@\nerror:%@", response, [error description]);
//    }];
    cell.pictureIV.layer.cornerRadius = cell.pictureIV.frame.size.height/2;
    cell.pictureIV.clipsToBounds = YES;
    cell.nameL.text = [NSString stringWithFormat:@"%@", perfil.nombre];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header_cell"];
    cell.titleL.text = @"Candidatos";
    return cell.contentView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"candidato_segue" sender:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [_headerView scrollViewDidScroll:scrollView];
}

@end
