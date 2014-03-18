//
//  DSViewController.m
//  Dolt
//
//  Created by Dan Szeezil on 3/17/14.
//  Copyright (c) 2014 Dan Szeezil. All rights reserved.
//

#import "DSViewController.h"

@interface DSViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSMutableArray *items;
    BOOL isEditModeEnabled;
    
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UITextField *myTextField;


@end

@implementation DSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    items = [[NSMutableArray alloc] initWithArray:@[@"One", @"Two", @"Three"]];
    
    self.myTextField.delegate = self;
    
}


- (IBAction)enterText:(id)sender {
    
    
}



- (IBAction)onAddButtonPressed:(id)sender {
    
    [items addObject:self.myTextField.text];
    
    [self.myTextField resignFirstResponder];
    
    [self.myTableView reloadData];
    
    self.myTextField.text = @"";
}



- (IBAction)onEditButtonPressed:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"Edit"]) {
        
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        isEditModeEnabled = YES;
        self.editing = YES;
        
    } else {
        
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        isEditModeEnabled = NO;
        self.editing = NO;
    }
    
}




# pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myReuseIdentifier"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",items[indexPath.row]];
  
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (isEditModeEnabled) {
        [items removeObjectAtIndex:indexPath.row];
        
        [self.myTableView reloadData];
        
    }
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor greenColor];
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = items[sourceIndexPath.row];
    [items removeObjectAtIndex:sourceIndexPath.row];
    [items insertObject:stringToMove atIndex:destinationIndexPath.row];
    
    [tableView reloadData];
}




@end








