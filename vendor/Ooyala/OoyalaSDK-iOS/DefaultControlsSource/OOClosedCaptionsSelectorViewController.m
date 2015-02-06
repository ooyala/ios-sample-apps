//
//  OOClosedCaptionsSelectorViewController.m
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//
//  This class represents the view that lets users select a closed captions, or enabling subtitles.
//
//


#import "OOClosedCaptionsSelectorViewController.h"
#import "OOClosedCaptionsStyle.h"
#import "OOOoyalaPlayer.h"
#import "OOOoyalaPlayerViewController.h"

@interface OOClosedCaptionsSelectorViewController ()

@property (nonatomic, weak) UIPopoverController *popover;  // The popover controller that was used to display this view
@property (nonatomic) OOOoyalaPlayer *player;        // The OoyalaPlayer

@end

// This Pair class is a simple object that holds a string and array.
@interface Pair : NSObject
  @property (nonatomic, assign) NSString *name;
  @property (nonatomic, assign) NSArray *value;
@end

@implementation Pair
  @synthesize name, value;
@end

// Constants used for special language names
NSString *const OOClosedCaptionsLanguageNone = @"Off";
NSString *const OOClosedCaptionsLanguageClosedCaptions = @"Use Closed Captions";
NSString *const OOClosedCaptionsRollUpPresentation = @"Roll Up";
NSString *const OOClosedCaptionsPaintOnPresentation = @"Paint On";
NSString *const OOClosedCaptionsPopOnPresentation = @"Pop On";

@implementation OOClosedCaptionsSelectorViewController : UITableViewController

@synthesize popover, player;

NSMutableArray *tableList;  // List of sections (CCs and/or subtitles)
NSIndexPath *selectedLanguageIndex;   // Memory of the language index that was selected, if any
NSIndexPath *selectedPresentationIndex;  // Memory of the presentation style index that was selected, if any


// Arrays that store the available languages
NSMutableArray *subtitleArray;
NSMutableArray *presentationArray;
NSArray *closedCaptionsArray;


- (id)initWithPlayer:(OOOoyalaPlayer *)p  {
  self = [super initWithStyle:UITableViewStylePlain];
  tableList = nil;
  selectedLanguageIndex = nil;
  selectedPresentationIndex = nil;
  popover = nil;
  player = p;

  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  NSArray *providedList = player.availableClosedCaptionsLanguages;
  tableList = [[NSMutableArray alloc] init];
  
  subtitleArray = [[NSMutableArray alloc] init];

	// Currently we only support the Pop-up closed caption presentation but we might come back for roll-up and paint-on later
  //  presentationArray = [[NSMutableArray alloc] initWithObjects:OOClosedCaptionsRollUpPresentation, OOClosedCaptionsPaintOnPresentation, OOClosedCaptionsPopOnPresentation, nil];

  closedCaptionsArray = nil;
  
  // For each language in the list, add it to the necessary array
  for (NSString *language in providedList) {
    
    // If this was the closed captions language, put 'None' and 'CC' langauges in the array
    if ([language compare: @"cc"] == NSOrderedSame) {
      closedCaptionsArray = [NSArray arrayWithObjects:OOClosedCaptionsLanguageNone, OOClosedCaptionsLanguageClosedCaptions, nil];
    }
    else
    {
      if (subtitleArray.count == 0) {
        [subtitleArray addObject:OOClosedCaptionsLanguageNone];
      }
      [subtitleArray addObject:language];
    }
  }
  
  // Make the pairs <section name, language/presentation list> to save in the langauge array
  if (closedCaptionsArray != nil)
  {
    Pair *closedCaptionsPair = [Pair alloc];
    closedCaptionsPair.name = @"Closed Captions";
    closedCaptionsPair.value = closedCaptionsArray;
    [tableList addObject:closedCaptionsPair];
  }
  if (subtitleArray.count > 0)
  {
    Pair *subtitlePair = [Pair alloc];
    subtitlePair.name = [[OOOoyalaPlayerViewController currentLanguageSettings] objectForKey:@"Languages"];
    subtitlePair.value = subtitleArray;

// 		There is only on option for closed caption presentation style so we disable the entire option list for presentation
//    Pair *presentationPair = [Pair alloc];
//    presentationPair.name = @"Presentation Style";
//    presentationPair.value = presentationArray;

    [tableList addObject:subtitlePair];
//    [tableList addObject:presentationPair];
  }
  
  [self.tableView reloadData];
  [super viewWillAppear:animated];
}

-(void)dismiss {
   [self dismissModalViewControllerAnimated:YES];
}


// When a cell has been selected, set the language or presentation style on the player as necessary
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Select the language has been selected previously
  if (selectedLanguageIndex != nil && indexPath.section == 0 && indexPath.row == selectedLanguageIndex.row) {
    return;
  }
  // Select the presentation has been selected previously
  if (selectedPresentationIndex != nil && indexPath.section == 1 && indexPath.row == selectedPresentationIndex.row) {
    return;
  }

  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.accessoryType =  UITableViewCellAccessoryCheckmark;
  if (indexPath.section == 0) {
    if ([cell.textLabel.text compare:OOClosedCaptionsLanguageNone] == NSOrderedSame) {
      [player setClosedCaptionsLanguage:nil];
    }
    else if ([cell.textLabel.text compare:OOClosedCaptionsLanguageClosedCaptions] == NSOrderedSame) {
      [player setClosedCaptionsLanguage:@"cc"];
    }
    else {
      [player setClosedCaptionsLanguage:cell.textLabel.text];
    }

    // Uncheck the previous checked cell if the selected item changed
    if (selectedLanguageIndex != nil &&
        [tableView cellForRowAtIndexPath:selectedLanguageIndex].accessoryType == UITableViewCellAccessoryCheckmark) {
      [tableView cellForRowAtIndexPath:selectedLanguageIndex].accessoryType = UITableViewCellAccessoryNone;
    }
    selectedLanguageIndex = indexPath;
  } else {
    if ([cell.textLabel.text compare:OOClosedCaptionsRollUpPresentation] == NSOrderedSame) {
      [player setClosedCaptionsPresentationStyle:OOClosedCaptionRollUp];
    } else if ([cell.textLabel.text compare:OOClosedCaptionsPaintOnPresentation] == NSOrderedSame) {
       [player setClosedCaptionsPresentationStyle:OOClosedCaptionPaintOn];
    } else {
       [player setClosedCaptionsPresentationStyle:OOClosedCaptionPopOn];
    }
    // Uncheck the previous checked cell if the selected item changed
    if (selectedPresentationIndex != nil &&
        [tableView cellForRowAtIndexPath:selectedPresentationIndex].accessoryType == UITableViewCellAccessoryCheckmark) {
      [tableView cellForRowAtIndexPath:selectedPresentationIndex].accessoryType = UITableViewCellAccessoryNone;
    }
    selectedPresentationIndex = indexPath;
  }
}

// Returns the number of sections, which could have either/or closed captions and subtitles
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return tableList.count;
}

// Return the number of rows a given section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  Pair *sectionPair = [tableList objectAtIndex:section];
  return sectionPair.value.count;
}

// Returns the header text for a given section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  Pair *sectionPair = [tableList objectAtIndex:section];
  return [sectionPair name];
}

// Return a particular cell to draw
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  // Use a set of reusable cells for viewing
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  // Set the data for this cell:
  Pair *sectionPair = [tableList objectAtIndex:indexPath.section];
  
  cell.textLabel.text = [sectionPair.value objectAtIndex:indexPath.row];

  // If we selected this cell last time, give it a checkmark.
  if([indexPath compare:selectedLanguageIndex] == NSOrderedSame || ([indexPath compare:selectedPresentationIndex] == NSOrderedSame)) {
    cell.accessoryType =  UITableViewCellAccessoryCheckmark;
  } else {
    cell.accessoryType =  UITableViewCellAccessoryNone;
  }
  return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, tableView.bounds.size.width, 60)];
  UILabel* label = [[UILabel alloc] initWithFrame:headerView.frame];
  Pair* sectionPair = [tableList objectAtIndex:section];
  label.text = sectionPair.name;
  [label setFont:[UIFont fontWithName:@"Helvetica Neue" size:18]];
  label.backgroundColor = [UIColor clearColor];
  [headerView addSubview:label];
  headerView.backgroundColor = [UIColor lightGrayColor];
  return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 60;
}

- (void)setPopover:(UIPopoverController *)pop {
  popover = pop;
}
@end
