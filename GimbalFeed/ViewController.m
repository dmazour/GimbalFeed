#import "ViewController.h"
#import <Gimbal/Gimbal.h>

@interface ViewController () <GMBLPlaceManagerDelegate>
@property (nonatomic) GMBLPlaceManager *placeManager;
@property (nonatomic) NSMutableArray *placeEvents;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.placeEvents = [NSMutableArray new];
    [Gimbal setAPIKey:@"3ab23ceb-2524-4d82-b83c-bf2ca8ffcb5f" options:nil];
    
    self.placeManager = [GMBLPlaceManager new];
    self.placeManager.delegate = self;
    [GMBLPlaceManager startMonitoring];
    
    [GMBLCommunicationManager startReceivingCommunications];
}

# pragma mark - Gimbal Place Manager Delegate methods
- (void)placeManager:(GMBLPlaceManager *)manager didBeginVisit:(GMBLVisit *)visit
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:self.placeEvents[0] message:@"Please confirm" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    [alertView show];
    NSLog(@"Enter %@", [visit.place description]);
    [self.placeEvents insertObject:visit atIndex:0];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)placeManager:(GMBLPlaceManager *)manager didEndVisit:(GMBLVisit *)visit
{
    NSLog(@"Depart %@", [visit.place description]);
    [self.placeEvents removeObjectAtIndex:0];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.placeEvents insertObject:visit atIndex:0];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

# pragma mark - Table View methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.placeEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    GMBLVisit *visit = (GMBLVisit*)self.placeEvents[indexPath.row];
    
    if (visit.departureDate == nil)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", visit.place.name];
        cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:visit.arrivalDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", visit.place.name];
        NSString *arrivalDate = [NSDateFormatter localizedStringFromDate:visit.arrivalDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
        NSString *departureDate = [NSDateFormatter localizedStringFromDate:visit.departureDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
        NSString *arrivalDateWithSpace = [arrivalDate stringByAppendingString: @"                   -                   "];
        NSString *fullDate = [arrivalDateWithSpace stringByAppendingString:departureDate];
        cell.detailTextLabel.text = fullDate;
    }
    
    return cell;
}

- (IBAction)updateButton:(UIButton *)sender {
    [self.nameLabel resignFirstResponder];
    [self.nurseLabel resignFirstResponder];
    [self.phoneLabel resignFirstResponder];
    [self.NPOLabel resignFirstResponder];
    [self.allergiesLabel resignFirstResponder];
}

- (IBAction)clearButton:(UIButton *)sender {
    [self.placeEvents removeAllObjects];
    [Gimbal resetApplicationInstanceIdentifier];
}
@end