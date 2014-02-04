//
//  CITViewController.m
//  CollabrifyTest
//
//  Created by Brandon Knope on 11/12/13.
//  Copyright (c) 2013 Collabrify.it. All rights reserved.
//

#import "CITViewController.h"
#import <Collabrify/Collabrify.h>
#import "CITListSessionsTableViewController.h"
#import "Operation.h"
#import "EventTranslator.h"
#import "OperationManager.h"

@interface CITViewController () < CollabrifyClientDelegate, CITListSessionsTableViewControllerDelegate, UITextFieldDelegate >
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *createSessionButton;
@property (weak, nonatomic) IBOutlet UIButton *leaveSessionButton;
@property (weak, nonatomic) IBOutlet UITextView *textEditor;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *joinSessionButton;

@property (strong, nonatomic) CollabrifyClient *client;
@property (strong, nonatomic) NSArray *tags; //of NSString
@property (strong, nonatomic) OperationManager *opManager;
@property (weak, nonatomic) IBOutlet UILabel *connectionLabel;
@property (weak, nonatomic) IBOutlet UITextField *broadcastTextField;
@property (weak, nonatomic) IBOutlet UILabel *sessionNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *resumeButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@property (strong, nonatomic) NSTimer *batchCastTimer;
@property (assign, nonatomic) NSInteger counter;

@property (weak, nonatomic) IBOutlet UIButton *redoButton;
@property (weak, nonatomic) IBOutlet UIButton *undoButton;
@property (assign) BOOL hold;
//@property (strong, nonatomic) NSMutableDictionary *map;
@property (assign) int cursor;
@property (assign) int hiscursor;

@end

@implementation CITViewController

static bool hold = false;

- (IBAction)undo:(UIButton *)sender {
    NSLog(@"Undo");
    
    NSMutableArray* undoArray = [[NSMutableArray alloc] init];
    for (int i = (int)[[[OperationManager getOperationManager] undoStack] size] - 1; i >= 0; i--) {
        NSNumber* global_id = [[[OperationManager getOperationManager] undoStack] getObjAtIndex:i];
        [undoArray addObject:global_id];
        Operation* op = [[[OperationManager getOperationManager] confirmedOp] getObjAtIndex:[global_id intValue]];
        if (op.participantID == self.client.participantID) {
            [[[OperationManager getOperationManager] undoStack] removeObjAtIndex:i];
            Operation* undo_op = [self getUndoOperation:undoArray];
            [self undoOperation:undo_op];
            break;
        }
    }
}

- (void) undoOperation: (Operation* ) op {
    NSRange undorange;
    undorange.location = op.range.location;
    undorange.length = op.replacementString.length;
    
    Operation* undo_op = [[Operation alloc] initLocal];;
    [undo_op setRange:undorange];
    [undo_op setOriginalString:op.replacementString];
    [undo_op setReplacementString:op.originalString];
    
    NSLog(@"View text: %@", self.textEditor.text);
    NSLog(@"range location: %d", undorange.location);
    NSLog(@"range length: %d", undorange.length);
    
    // self.textEditor.text = [self.textEditor.text stringByReplacingCharactersInRange:undorange withString:undo_op.replacementString];
    
    if (self.textEditor.text.length >= undorange.location + undorange.length)
        self.textEditor.text = [self.textEditor.text stringByReplacingCharactersInRange:undorange withString:undo_op.replacementString];
    else {
        undorange.length = self.textEditor.text.length - undorange.location;
        self.textEditor.text = [self.textEditor.text stringByReplacingCharactersInRange:undorange withString:undo_op.replacementString];
        self.textEditor.text = [self.textEditor.text stringByAppendingString:[undo_op.replacementString substringFromIndex:undorange.length]];
    }
    
    [undo_op setParticipantID:self.client.participantID];
    [undo_op setIsUndo:true];
    if (self.opManager.confirmedOp.size > 0) {
        [undo_op setConfirmedGID:[self.opManager.confirmedOp.bottom globalID]];
        [op setConfirmedGID:[self.opManager.confirmedOp.bottom globalID]];
    } else {
        [undo_op setConfirmedGID:-1];
        [op setConfirmedGID:-1];
    }
    
    [[[OperationManager getOperationManager] unconfirmedOp] push_back:undo_op];
    [[[OperationManager getOperationManager] redoStack] push_back:op];
    [self broadcastOperation:undo_op];
}

- (IBAction)redo:(UIButton *)sender {
    NSLog(@"Redo");
    if([[[OperationManager getOperationManager] redoStack] isEmpty])
        return;
    Operation* op = [[[OperationManager getOperationManager] redoStack] popbot];
    [self redoOperation:op];
}

- (void) redoOperation: (Operation* ) op {
    self.textEditor.text = [self.textEditor.text stringByReplacingCharactersInRange:op.range withString:op.replacementString];
    if (self.opManager.confirmedOp.size > 0)
        [op setConfirmedGID:[self.opManager.confirmedOp.bottom globalID]];
    else
        [op setConfirmedGID:-1];
    [[[OperationManager getOperationManager] unconfirmedOp] push_back:op];
    [self broadcastOperation:op];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([[self textEditor] isFirstResponder] && [touch view] != [self textEditor]) {
        [[self textEditor] resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (range.length == 0 && text.length == 0) {
        return YES;
    }
    
    /* init */
    Operation *op = [[Operation alloc] initLocal];
    
    /* add information */
    [op setParticipantID: self.client.participantID];
    [op setOriginalString:[textView.text substringWithRange:range]];
    [op setReplacementString: text];
    [op setRange:range];
    [op setIsUndo:false];
    if (self.opManager.confirmedOp.size > 0)
        [op setConfirmedGID:[self.opManager.confirmedOp.bottom globalID]];
    else
        [op setConfirmedGID:-1];
    [[[OperationManager getOperationManager] unconfirmedOp] push_back:op];
    [[[OperationManager getOperationManager] redoStack] clear];
    [self broadcastOperation:op];
    
    /* print out */
    if (text.length == 0){
        NSLog(@"Delete: %@", [textView.text substringWithRange:range]);
    }
    else if (range.length == 0){
        NSLog(@"Insert: %@", text);
    }
    else{
        NSLog(@"replace %@ by %@",[textView.text substringWithRange:range],text);
    }
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *) textView {
    
    /*
    if (self.hold)
        return;
    
    NSRange r = textView.selectedRange;
     */
    /* init */
//    Operation *op = [[Operation alloc] initLocal];
    
    /* add information */
    /*
    [op setParticipantID: self.client.participantID];
    [op setOriginalString: @""];
    [op setReplacementString: @""];
    [op setRange:r];
    [[[OperationManager getOperationManager] unconfirmedOp] push_back:op];
    [self broadcastOperation:op];
    NSLog(@"Start from : %d",r.location); //starting selection in text selection
     */
}

- (void)updatePauseButton
{
    if ([[self pauseButton] backgroundColor])
    {
        //events are paused
        [[self client] resumeEvents];
        [[self pauseButton] setBackgroundColor:nil];
        
        [[self pauseButton] setTitle:@"Pause Events" forState:UIControlStateNormal];
    }
    else
    {
        //events are not paused
        [[self client] pauseEvents];
        [[self pauseButton] setBackgroundColor:[UIColor lightGrayColor]];
        
        [[self pauseButton] setTitle:@"Resume Events" forState:UIControlStateNormal];
    }
}

- (void)trigger:(NSTimer *)timer
{
    if ([self counter] == 10)
    {
        [timer invalidate];
    }
    
    [self broadcastText:@"1"];
    ++_counter;
}

//this method is used for testing
- (IBAction)batchCastTriggered:(id)sender
{
    [[self batchCastTimer] invalidate];
    
    [self setCounter:0];
//    _batchCastTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(trigger:) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:_batchCastTimer forMode:NSDefaultRunLoopMode];
}

- (BOOL)isButtonPaused
{
    if ([[self pauseButton] backgroundColor])
    {
        return YES;
    }
    
    return NO;
}

#pragma mark -
#pragma mark List Participants
- (IBAction)listParticipantsTriggered:(id)sender
{
    NSLog(@"Participants = %@", [[self client] currentSessionParticipants]);
}

#pragma mark -
#pragma mark Resume Events
- (IBAction)resumeButtonTriggered:(id)sender
{
    [[self client] resumeEvents];
    
    [[self resumeButton] setBackgroundColor:[UIColor grayColor]];
    [[self pauseButton] setBackgroundColor:[UIColor clearColor]];
}

#pragma mark -
#pragma mark Pause Events
- (IBAction)pauseButtonTriggered:(id)sender
{
    [self updatePauseButton];

//    [[self pauseButton] setBackgroundColor:[UIColor grayColor]];
//    [[self resumeButton] setBackgroundColor:[UIColor clearColor]];
}

/**
 * Implement this delegate method to receive events in your session
 *
 * This method is not called on the main thread. You must make sure if you touch the UI that you do it on the main thread
 */
- (void)client:(CollabrifyClient *)client receivedEventWithOrderID:(int64_t)orderID submissionRegistrationID:(int32_t)submissionRegistrationID eventType:(NSString *)eventType data:(NSData *)data
{
    /*
     NSString *chatMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     
     dispatch_async(dispatch_get_main_queue(), ^{
     [[self statusLabel] setText:chatMessage];
     });
     */
    Operation *operation = [EventTranslator stringToOperation:data];
    operation.globalID = orderID;
    operation.submissionID = submissionRegistrationID;
    [self handleReceivedOperation:operation];
}

- (Operation*) getUndoOperation:(NSMutableArray*) indexArr{
    if ([indexArr count] == 0) {
        NSLog(@"Passed empty array into method getRedoOperation!!");
        return nil;
    }
    NSLog(@"In getUndoOperation");
    Operation* op = [[Operation alloc] init];
    NSNumber *index = indexArr[[indexArr count] - 1];
    op = [self.opManager.confirmedOp.getDequeObj objectAtIndex:[index intValue]];
    if (self.opManager.confirmedOp.size > 0)
        [op setConfirmedGID:[self.opManager.confirmedOp.bottom globalID]];
    else
        [op setConfirmedGID:-1];
    NSRange newRange = op.range;
    for (int i = (int)indexArr.count - 2; i >= 0; i--) {
        Operation *tempOp = [[Operation alloc] init];
        tempOp = [self.opManager.confirmedOp.getDequeObj objectAtIndex:[indexArr[i] intValue]];
        if (tempOp.participantID != op.participantID && tempOp.range.location < newRange.location) {
            if ((int)newRange.location + (int)tempOp.replacementString.length - (int)tempOp.range.length >= 0) {
                newRange.location += tempOp.replacementString.length - tempOp.range.length;
            } else
                newRange.location = 0;
            NSLog(@"newRange for redo: %d", newRange.location);
        }
    }
    op.range = newRange;
 /*
    for (int i = (int)self.opManager.confirmedOp.size - 2; i >= 0; i--) {
        Operation *tempOp = [[Operation alloc] init];
        tempOp = [self.opManager.confirmedOp.getDequeObj objectAtIndex:i];
        NSLog(@"Previous op: %d, %d, %@", i, tempOp.range.location, tempOp.replacementString);
        NSRange trange = tempOp.range;
        if (op.range.location <= [tempOp range].location) {
            if ((int)[tempOp range].location + (int)op.replacementString.length - (int)op.range.length > 0) {
                trange.location += (NSUInteger)op.replacementString.length - (NSUInteger)op.range.length;
            }
            else
                trange.location = 0;
            tempOp.range = trange;
            [self.opManager.confirmedOp.getDequeObj replaceObjectAtIndex:i withObject:tempOp];
        }
    }
   */
    return op;
}

- (void)handleReceivedOperation:(Operation *)operation
{
    
        dispatch_sync(dispatch_get_main_queue(), ^{
            /*
            if ([self.map objectForKey:(int)(operation.participantID)] == nil && operation.submissionID == -1) {
                self.map[@(operation.participantID)] = 0;
            }
            */
            NSLog(@"replace range:%u,%u with %@. ConfirmID: %d, GlobalID: %d",operation.range.location, operation.range.length,operation.replacementString, operation.confirmedGID, operation.globalID);
            //Boolean delete = false;
            //if (operation.range.length > operation.replacementString.length)
            //    delete = true;
            // remember the cursor location.
            /* ***
            if (operation.submissionID == -1 && operation.replacementString.length == 0 && operation.originalString == 0) {
                self.hiscursor = operation.range.location;
                return;
            }
            self.hold = true;
            */
            NSRange tempRange = self.textEditor.selectedRange;
            
            NSString *temptext = [NSString stringWithFormat:@"%@", self.opManager.confirmedText];
            
            NSRange newRange = operation.range;
            
            NSLog(@"Before: temptext %@ confirmedText %@", temptext, self.opManager.confirmedText);
      
            for (int i = operation.confirmedGID + 1; i < self.opManager.confirmedOp.size; i++) {
                Operation *tempOp = [[Operation alloc] init];
                tempOp = [self.opManager.confirmedOp.getDequeObj objectAtIndex:i];
                if (tempOp.participantID != operation.participantID && tempOp.range.location < newRange.location) {
                    if ((int)newRange.location + (int)tempOp.replacementString.length - (int)tempOp.range.length >= 0) {
                        newRange.location +=tempOp.replacementString.length - tempOp.range.length;
                    } else
                        newRange.location = 0;
                    NSLog(@"newRange: %d", newRange.location);
                }
            }
            operation.range = newRange;
       
            [self.opManager setConfirmedText:[temptext stringByReplacingCharactersInRange:operation.range withString:operation.replacementString]];
            temptext = self.opManager.confirmedText;
            
            
            NSLog(@"After: temptext %@ confirmedText %@", temptext, self.opManager.confirmedText);
            NSLog(@"bottom localID: %d:%d, submissionID: %d", operation.localID, [[[self.opManager unconfirmedOp] top] localID], operation.submissionID);
            if (self.client.participantID == operation.participantID && operation.submissionID == -1)
                NSLog(@"Collabrify has bug!!!!");
            if (operation.localID == [self.opManager.unconfirmedOp.top localID] && operation.submissionID != -1) {
                [self.opManager.unconfirmedOp poptop];
                if (self.opManager.unconfirmedOp.size == 0)
                    self.textEditor.text = self.opManager.confirmedText;
            }
            else {
                for (int i = 0; i < self.opManager.unconfirmedOp.size; i++) {
                    Operation *tempOp = [[Operation alloc] init];
                    tempOp = [self.opManager.unconfirmedOp.getDequeObj objectAtIndex:i];
                    NSLog(@"Previous op: %d, %d, %@", i, tempOp.range.location, tempOp.replacementString);
                    NSRange trange = tempOp.range;
                    if (operation.range.location <= [tempOp range].location) {
                        if ((int)[tempOp range].location + (int)operation.replacementString.length - (int)operation.range.length > 0) {
                            trange.location += (NSUInteger)operation.replacementString.length - (NSUInteger)operation.range.length;
                        }
                        else
                            trange.location = 0;
                        tempOp.range = trange;
                        [self.opManager.unconfirmedOp.getDequeObj replaceObjectAtIndex:i withObject:tempOp];
                    }
                    
                    temptext = [temptext stringByReplacingCharactersInRange:[tempOp range] withString:tempOp.replacementString];
                    NSLog(@"Unconfirm %d %@, %d, %@", i, temptext, tempOp.range.location, tempOp.replacementString);
                
                }
                self.textEditor.text = temptext;
                if (operation.range.location < tempRange.location) {
                    if ((int)tempRange.location + (int)operation.replacementString.length - (int)operation.range.length >= 0) {
                        tempRange.location += operation.replacementString.length - operation.range.length;
                    } else
                        tempRange.location = 0;
                }
            }
            
            //[self.opManager setConfirmedText:[[self textEditor] text]];
            [[self.opManager confirmedOp] push_back:operation];
            if (!operation.isUndo) {
                    [[self.opManager undoStack] push_back:[NSNumber numberWithInt:operation.globalID]];
            } else {
                if (operation.submissionID == -1 ) {
                    NSLog(@"Operation for UNdo start");
                    for (int i = (int)[[self.opManager undoStack] size] - 1; i >=0; i--) {
                        if ([[self.opManager.confirmedOp getObjAtIndex:[[[[self.opManager undoStack] getDequeObj] objectAtIndex:i] intValue] ] participantID] == operation.participantID) {
                            [[self.opManager undoStack] removeObjAtIndex:i];
                            break;
                        }
                    }
                    NSLog(@"Operation for UNdo end");
                }
            }
            
            // set the cursor location back.
            self.textEditor.selectedRange = tempRange;
            /*  ***
            self.cursor = tempRange.location;
            self.hold = false;
             */
        });
  //  }
}


- (void)ownerHasPreventedFurtherJoinsForClient:(CollabrifyClient *)client
{
    NSLog(@"Further joins off");
}

#pragma mark -
#pragma mark Participant Joined
- (void)client:(CollabrifyClient *)client participantJoined:(CollabrifyParticipant *)participant
{
    [[self statusLabel] setText:[NSString stringWithFormat:@"%@ has joined.", [participant displayName]]];
}

#pragma mark -
#pragma mark Particiant Left
- (void)client:(CollabrifyClient *)client participantLeft:(CollabrifyParticipant *)participant
{
    [[self statusLabel] setText:[NSString stringWithFormat:@"%@ has left.", [participant displayName]]];
}

#pragma mark -
#pragma mark Session Ended
- (void)client:(CollabrifyClient *)client sessionEnded:(int64_t)sessionID
{
    //Make sure to update your UI after the session ends
    [self leaveSession];
}

#pragma mark -
#pragma mark Base File Uploaded
- (void)client:(CollabrifyClient *)client uploadedBaseFileWithSize:(NSUInteger)baseFileSize
{
    NSLog(@"Uploaded Base File with size %lu", (unsigned long)baseFileSize);
    [[self statusLabel] setText:@"Uploaded Base File"];
}

#pragma mark -
#pragma mark Base File Downoaded
- (void)client:(CollabrifyClient *)client receivedBaseFile:(NSData *)baseFile
{
    NSString *baseFileString = [[NSString alloc] initWithData:baseFile encoding:NSUTF8StringEncoding];
    
    NSLog(@"Base File String = %@", baseFileString);
    NSLog(@"Data = %@", baseFile);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"List Sessions Segue"])
    {
        CITListSessionsTableViewController *listSessions = [segue destinationViewController];
        [listSessions setTags:[self tags]];
        [listSessions setClient:[self client]];
        [listSessions setDelegate:self];
    }
}

#pragma mark -
#pragma mark Broadcast
- (void)broadcastText:(NSString *)text
{
//    NSLog(@"Broadcast %@", text);
    
    if ([text length])
    {
        NSData *textData = [text dataUsingEncoding:NSUTF8StringEncoding];
        
        int submissionID = [[self client] broadcast:textData eventType:@"ChatMessageType"];
    }
}

// function to broadcast an operation
// return 0 on success, -1 for failure
- (int)broadcastOperation:(Operation *)operation
{
    NSData *textData = [EventTranslator operationToString:operation];
    int submissionRegistrationID = [[self client] broadcast:textData eventType:nil];
    if(submissionRegistrationID == -1)
    {
        NSLog(@"Failed to send operation.\n");
        return -1;
    }
    else
    {
        [operation setSubmissionID:submissionRegistrationID];
        return 0;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self broadcastText:[textField text]];
    return YES;
}

#pragma mark -
#pragma mark Join Session
- (void)listSessionsTVC:(CITListSessionsTableViewController *)listSessionsTVC selectedSession:(CollabrifySession *)session
{
    NSLog(@"Session selected");
    
    [[self navigationController] popViewControllerAnimated:YES];
    
    [[self client] joinSessionWithID:[session sessionID] password:@"password" startPaused:NO completionHandler:^(int64_t maxOrderID, int32_t baseFileSize, CollabrifyError *error) {
        if (!error)
        {
            [self joinedSession];
        }
    }];
}

#pragma mark -
#pragma mark Create Session without a Base File
- (IBAction)createSessionTriggered:(id)sender
{
    NSInteger randomNumber = arc4random_uniform(9999);
    NSString *sessionName = [NSString stringWithFormat:@"%li Test", (long)randomNumber];
    
    NSLog(@"Session Name = %@", sessionName);
    
    [[self client] createSessionWithName:sessionName password:@"password" tags:[self tags] startPaused:NO completionHandler:^(int64_t sessionID, CollabrifyError *error) {
        if (!error)
        {
            NSLog(@"Successful");
            [self joinedSession];
        }
        else
        {
            NSLog(@"Error Creating Session = %@", error);
        }
    }];
}

#pragma mark -
#pragma mark Create Session with Base File
- (IBAction)createSessionWithBaseFileTriggered:(id)sender
{
    NSInteger randomNumber = arc4random_uniform(9999);
    NSString *sessionName = [NSString stringWithFormat:@"%li Test", (long)randomNumber];
    
    NSString *baseFileString = @"Test Base File";
    NSData *baseFileData = [baseFileString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Data = %@", baseFileData);
    
    NSLog(@"Base File Test = %@", [[NSString alloc] initWithData:baseFileData encoding:NSUTF8StringEncoding]);
    
    [[self client] createSessionWithName:sessionName password:@"password" tags:[self tags] baseFile:baseFileData startPaused:NO completionHandler:^(int64_t sessionID, CollabrifyError *error) {
        if (!error)
        {
            [self joinedSession];
        }
    }];
}

#pragma mark -
#pragma mark Leave Session
- (IBAction)leaveSessionTriggered:(id)sender
{
    [[self client] leaveAndEndSession:YES completionHandler:^(BOOL success, CollabrifyError *error) {
        if (!error)
        {
            NSLog(@"Success leaving = %i", success);
            [self leaveSession];
        }
        else
        {
            NSLog(@"Error leaving = %@", error);
        }
    }];
}

//convenience method to update the interface when joining a session
- (void)joinedSession
{
    [[self connectionLabel] setText:@"Connected"];
    [[self createSessionButton] setEnabled:NO];
    [[self joinSessionButton] setEnabled:NO];
    [[self leaveSessionButton] setEnabled:YES];
    
    [[self sessionNameLabel] setText:[[self client] currentSessionName]];
    
    if ([[self client] eventsArePaused] != [self isButtonPaused])
    {
        [self updatePauseButton];
    }
}

//convenience method to update the interface after leaving a session
- (void)leaveSession
{
    [[self connectionLabel] setText:@"Not Connected"];
    [[self createSessionButton] setEnabled:YES];
    [[self leaveSessionButton] setEnabled:NO];
    [[self joinSessionButton] setEnabled:YES];
    
    [[self sessionNameLabel] setText:@""];
}

#pragma mark -
#pragma mark Encountered Error
- (void)client:(CollabrifyClient *)client encounteredError:(CollabrifyError *)error
{
    if ([[error domain] isEqualToString:CollabrifyClientSideErrorDomain])
    {
        if ([error type] == CollabrifyClientSideErrorCannotConnectToCollabrify)
        {
            //There is no internet
            if ([error isKindOfClass:[CollabrifyUnrecoverableError class]])
            {
                //reset your interface
            }
        }
    }
}

#pragma mark -
#pragma mark Network Status Changed
- (void)networkStatusDidChange:(NSNotification *)notificiation
{
    CollabrifyClientNetworkStatus statusFromNotification = [[[notificiation userInfo] objectForKey:CollabrifyClientNetworkStatusKey] longValue];
    CollabrifyClientNetworkStatus statusFromClient = [CollabrifyClient currentNetworkStatus];
    
    NSLog(@"Status from notification: %i, status from client: %i", statusFromNotification, statusFromClient);
}

- (void)viewWillAppear:(BOOL)animated
{
    //only create the client once
    if (![self client])
    {
        CollabrifyError *error = nil;
        
#warning Change to your display name
#warning Change to the appropriate class gmail
#warning Change to the appropriate accessToken
        CollabrifyClient *client = [[CollabrifyClient alloc] initWithGmail:ACCOUNT_GMAIL
                                                               displayName:DISPLAY_NAME
                                                              accountGmail:@"441winter2014@umich.edu"
                                                               accessToken:@"338692774BBE"
                                                                     error:&error];
        
        [self setTags:@[@"Test 3"]];
        [client setDelegate:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusDidChange:) name:CollabrifyClientNetworkStatusChangedNotification object:client];
        
        [self setClient:client];
    }
    
    if ([[self client] isInSession])
    {
        [self joinedSession];
    }
    else
    {
        [self leaveSession];
        [[self statusLabel] setText:@""];
    }
    
    [[self broadcastTextField] setDelegate:self];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self textEditor].layer.borderWidth = 5.0f;
    [self textEditor].layer.borderColor = [[UIColor grayColor] CGColor];
    [[self leaveSessionButton] setEnabled:YES];
    [[self textEditor] setDelegate: (id<UITextViewDelegate>)self];
    self.opManager = [OperationManager getOperationManager];
    self.hold = false;
    self.cursor = 0;
    self.hiscursor = 0;
    //self.map = [[NSMutableDictionary alloc] init];
    //[self.map setObject:[NSNumber numberWithFloat:1.23f]
     //                  forKey:[NSNumber numberWithInt:1]];
    //NSLog(@"Test dictionary: %@", testDictionary);
    //[self.map release];
    
    //self.map[@-1] = 0;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
