//
//  main.m
//  TicTacToe
//
//  Created by Nelly Santoso on 11/29/14.
//  Copyright (c) 2014 Nelly Santoso. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* get_player_name(NSString *icon_name, NSNumber *player_number);
NSString* player_moves(NSString *player_name, NSArray *default_table);
NSMutableArray* processing_move(NSString *user_moves);
NSString* asking_again(NSString *player_name);
BOOL is_player_winning(NSArray *player_data, NSString *player_name);
void print_table(NSMutableDictionary *table_score, NSString *icon, NSString *player_moves);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSDictionary *default_dictionary = @{@"A":@"A",@"B":@"B",@"C":@"C",@"D":@"D",@"E":@"E",@"F":@"F",@"G":@"G",@"H":@"H",@"I":@"I"};
        NSMutableDictionary *table_score = [NSMutableDictionary dictionaryWithDictionary:default_dictionary];
        
        NSArray *default_table = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I"];
        
        // finding out the name of player one and player two
        NSString *player1_name = get_player_name(@"O",@1);
        NSString *player2_name = get_player_name(@"X",@2);

        // regulation of the play
        printf("Let's play tic tac toe game!\n");
        printf("Rule: The player who succeeds in placing three respective marks in a horizontal, vertical, or diagonal row wins the game.\n");
        printf("Here is the table\n");
        printf("-------------\n| A | B | C |\n-------------\n| D | E | F |\n-------------\n| G | H | I |\n-------------\n");
        
        // creating array to store player's moves
        NSMutableArray *store_player1_data = [[NSMutableArray alloc] init];
        NSMutableArray *store_player2_data = [[NSMutableArray alloc] init];

        
        BOOL win_lose_status = NO;
        int ct;
        
        // store the moves, print the moves and check one of the player is a winner or not
        while(!win_lose_status && ct < 5)
        {
            // player 1
            NSString *player1_moves = player_moves(player1_name, default_table);
            NSString *player1_data = [player1_moves stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            [store_player1_data addObject:player1_data];
            NSLog(@"%@'s list of data%@",player1_name, store_player1_data);
            
            print_table(table_score, @"O", player1_data);
            
            win_lose_status = is_player_winning(store_player1_data, player1_name);
            
            if(win_lose_status) break;
            
            // player 2
            NSString *player2_moves = player_moves(player2_name,default_table);
            NSString *player2_data = [player2_moves stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            [store_player2_data addObject:player2_data];
            NSLog(@"%@'s list of data%@",player2_name, store_player2_data);
            
            print_table(table_score, @"X", player2_data);
            
            win_lose_status = is_player_winning(store_player2_data, player2_name);
            
            if(win_lose_status) break;
            
            ct++;
            
        }
        
    }
    return 0;
}

// Get player's name from the console and welcoming them
NSString* get_player_name(NSString *icon_name, NSNumber *player_number)
{
    NSLog(@"\nPlayer %@ \nPlease enter your name:", player_number);
    NSFileHandle *player = [NSFileHandle fileHandleWithStandardInput];
    NSData *player_name = [player availableData];
    
    NSString *str_player = [[NSString alloc] initWithData:player_name encoding:NSUTF8StringEncoding];
    printf("Welcome %s", [str_player UTF8String]);
    printf("Your icon is %s\n\n", [icon_name UTF8String]);
    
    return str_player;
}

// Grab the player's moves from console, make it uppercase and check make sure that it has one character and the input belongs to default table
NSString* player_moves(NSString *player_name, NSArray *default_table)
{
    printf("it's your turn, %s",[player_name UTF8String]);
    NSFileHandle *player_data = [NSFileHandle fileHandleWithStandardInput];
    NSData *player_moves = [player_data availableData];
    
    NSString *move_player = [[NSString alloc] initWithData:player_moves encoding:NSUTF8StringEncoding];
    move_player = [move_player uppercaseString];
    move_player = [move_player stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSUInteger char_length = move_player.length;
//    NSLog(@"%lu", (unsigned long)char_length);
    
    NSArray *player_move_array = @[move_player];
    
    while (char_length > 2 || ![[NSSet setWithArray:player_move_array] isSubsetOfSet:[NSSet setWithArray:default_table]])
    {
        move_player = asking_again(player_name);
        char_length = move_player.length;
        player_move_array = @[move_player];
    }
    
//    NSLog(@"%@", move_player);
    
    return move_player;
}

// fall back if the player enters more than 1 character
NSString* asking_again(NSString *player_name)
{
    printf("That's not a correct move. Please enter another moves that are not 'O' or 'X', %s!",[player_name UTF8String]);
    
    NSFileHandle *player_data = [NSFileHandle fileHandleWithStandardInput];
    NSData *player_moves = [player_data availableData];
    
    NSString *selected_item = [[NSString alloc] initWithData:player_moves encoding:NSUTF8StringEncoding];
    selected_item = [selected_item uppercaseString];
    selected_item = [selected_item stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    NSLog(@"selected items is %@", selected_item);
    
    return selected_item;
}

// check if the player is a winner. if yes, send it as true
BOOL is_player_winning(NSArray *player_data, NSString *player_name)
{
    NSArray *winning=@[@[@"A",@"B",@"C"],@[@"A", @"D", @"G"],@[@"G",@"H",@"I"],
                       @[@"C", @"F", @"I"],@[@"A",@"E",@"I"],@[@"C", @"E", @"G"],
                       @[@"D", @"E", @"F"],@[@"B", @"E", @"H"]];
    BOOL is_winning = NO;
    
    NSUInteger array_count = [player_data count];
//    NSLog(@"my array count %lu",(unsigned long)array_count);
    
    
    if (array_count > 2){
        for ( int i = 0; i < 8; i++ )
        {
            
            if ([[NSSet setWithArray:winning[i]] isSubsetOfSet:[NSSet setWithArray:player_data]])
            {
                is_winning = YES;
                NSLog(@"Congratulation %@ !  You Are The Winner!", player_name);
                NSLog(@"You won from this moves: %@", winning[i]);
            }
            
        }
    }
    return is_winning;
}

// print the table based on the icon
void print_table(NSMutableDictionary *table_score, NSString *icon, NSString *player_moves)
{
    [table_score setObject:icon forKey:player_moves];
    NSLog(@"\n-------------\n| %@ | %@ | %@ |\n-------------\n| %@ | %@ | %@ |\n-------------\n| %@ | %@ | %@ |\n-------------\n",
          table_score[@"A"],table_score[@"B"],table_score[@"C"],table_score[@"D"],table_score[@"E"],table_score[@"F"],
          table_score[@"G"],table_score[@"H"],table_score[@"I"]);
    
}




