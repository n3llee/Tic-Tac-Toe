//
//  main.m
//  TicTacToe
//
//  Created by Nelly Santoso on 11/29/14.
//  Copyright (c) 2014 Nelly Santoso. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* get_player_name(NSString *icon_name, NSNumber *player_number);
NSString* player1_moves(NSString *player1_name);
//NSNumber* is_accepted_move(NSString *moves);
NSMutableArray* processing_move(NSString *user_moves);
//NSString* asking_again(NSString *player_name, NSString *user_moves);
BOOL is_player_winning(NSArray *player_data);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSDictionary *default_table = @{@1:@"A",@2:@"B",@3:@"C",@4:@"D",@5:@"E",@6:@"F",@7:@"G",@8:@"H",@9:@"I"};
//        NSMutableDictionary *table_score = [NSMutableDictionary dictionaryWithDictionary:default_table];
        

        
        
        //        NSMutableArray *player1_score = [[NSMutableArray alloc]init];
        ////        NSMutableArray *player2_score = [[NSMutableArray alloc]init];
        //        [player1_score addObject:move_player1];
        //
        //        [table_score setObject:@"O" forKey:@1];
        //        [table_score setObject:@"X" forKey:@2];
        
        // finding out the name of player one and player two
        NSString *player1_name = get_player_name(@"O",@1);
//        NSString *player2_name = get_player_name(@"X",@2);

        
        printf("Let's play tic tac toe game!\n");
        printf("Rule: The player who succeeds in placing three respective marks in a horizontal, vertical, or diagonal row wins the game.\n");
        printf("Here is the table\n");
        printf("-------------\n| A | B | C |\n-------------\n| D | E | F |\n-------------\n| G | H | I |\n-------------\n");
        
        NSMutableArray *store_player1_data = [[NSMutableArray alloc] init];
        

        BOOL win_lose_status = NO;
        int ct;
        while(!win_lose_status && ct < 5)
        {
            NSString *my_moves = player1_moves(player1_name);
            NSString * good_data = [my_moves stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            [store_player1_data addObject:good_data];
            NSLog(@"%@",store_player1_data);
            win_lose_status = is_player_winning(store_player1_data);
            
            ct++;
        }
        
        
        
        
    }
    return 0;
}

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

NSString* player1_moves(NSString *player1_name)
{
    printf("it's your turn, %s",[player1_name UTF8String]);
    NSFileHandle *player1_data = [NSFileHandle fileHandleWithStandardInput];
    NSData *player1_moves = [player1_data availableData];
    NSString *move_player1 = [[NSString alloc] initWithData:player1_moves encoding:NSUTF8StringEncoding];
    move_player1 = [move_player1 uppercaseString];
    NSLog(@"%@", move_player1);
    
    return move_player1;
}

BOOL is_player_winning(NSArray *player_data)
{
    NSArray *winning=@[@[@"A",@"B",@"C"],@[@"A", @"D", @"G"],@[@"G",@"H",@"I"],@[@"C", @"F", @"I"],@[@"A",@"E",@"I"],@[@"C", @"E", @"G"]];
    BOOL is_winning = NO;
    
    NSUInteger array_count = [player_data count];
    NSLog(@"my array count %lu",(unsigned long)array_count);
    
    
    if ([player_data count] > 2){
        for ( int i = 0; i < 2; i++ )
        {
            
            if ([[NSSet setWithArray:winning[i]] isSubsetOfSet:[NSSet setWithArray:player_data]])
            {
                is_winning = YES;
                NSLog(@"Congratulation! You Won!");
                NSLog(@"%@", winning[i]);
            }
            
        }
    }
    return is_winning;
}

//NSNumber* is_accepted_move(NSString *moves)
//{
//    NSNumber *accepted;
//    NSUInteger char_length = [moves length];
//    
//    
//    if (char_length > 1 )
//        accepted = @1;
//    else
//        accepted = @0;
//    
//    return accepted;
//}

//NSMutableArray* processing_move(NSString *user_moves)
//{
//    NSMutableArray *store_data = [[NSMutableArray alloc] init];
//    NSString *data = [NSString stringWithString:user_moves];
//    [store_data addObject:data];
//    NSLog(@"my array has: %@", store_data);
//    
//    return store_data;
//    
//}


//NSString* asking_again(NSString *player_name, NSString *user_moves)
//{
//    printf("That's not a correct move. Please enter another moves that are not 'O' or 'X', %s!",[player_name UTF8String]);
//    NSFileHandle *player_data = [NSFileHandle fileHandleWithStandardInput];
//    NSData *player_moves = [player_data availableData];
//    NSString *selected_item = [[NSString alloc] initWithData:player_moves encoding:NSUTF8StringEncoding];
//    
//    return selected_item;
//}